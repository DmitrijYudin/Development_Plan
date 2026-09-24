namespace Development_Plan.Development_Plan;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;

codeunit 50130 "DMY Credit Limit Mgt."
{
    procedure GetCustomerExposure(CustomerNo: Code[20]): Decimal
    begin
        if CustomerNo = '' then
            exit(0);

        exit(GetPostedReceivablesLCY(CustomerNo) + GetOpenSalesOrdersLCY(CustomerNo, ''));
    end;

    procedure ValidateCustomerCreditLimit(CustomerNo: Code[20]; SalesOrderNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo);

        if SalesHeader."Bill-to Customer No." <> CustomerNo then
            Error(SalesOrderCustomerMismatchErr, SalesOrderNo, CustomerNo);

        ValidateSalesOrderCreditLimit(SalesHeader);
    end;

    procedure ValidateSalesOrderCreditLimit(var SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
        CustomerNo: Code[20];
        PostedReceivablesLCY: Decimal;
        OtherOpenSalesOrdersLCY: Decimal;
        CurrentSalesOrderLCY: Decimal;
        CurrentExposureLCY: Decimal;
        TotalExposureLCY: Decimal;
        ExceededByLCY: Decimal;
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        CustomerNo := GetCreditCustomerNo(SalesHeader);
        if CustomerNo = '' then
            exit;

        Customer.Get(CustomerNo);
        if Customer."Credit Limit (LCY)" = 0 then
            exit;

        GetSalesOrderExposure(SalesHeader, PostedReceivablesLCY, OtherOpenSalesOrdersLCY, CurrentSalesOrderLCY);

        CurrentExposureLCY := PostedReceivablesLCY + OtherOpenSalesOrdersLCY;
        TotalExposureLCY := CurrentExposureLCY + CurrentSalesOrderLCY;
        if TotalExposureLCY <= Customer."Credit Limit (LCY)" then
            exit;

        ExceededByLCY := TotalExposureLCY - Customer."Credit Limit (LCY)";
        Error(
            CreditLimitExceededErr,
            Customer."No.",
            Customer.Name,
            Customer."Credit Limit (LCY)",
            CurrentExposureLCY,
            CurrentSalesOrderLCY,
            TotalExposureLCY,
            ExceededByLCY,
            SalesHeader."No.");
    end;

    procedure GetSalesOrderExposure(var SalesHeader: Record "Sales Header"; var PostedReceivablesLCY: Decimal; var OtherOpenSalesOrdersLCY: Decimal; var CurrentSalesOrderLCY: Decimal)
    var
        CustomerNo: Code[20];
    begin
        CustomerNo := GetCreditCustomerNo(SalesHeader);

        PostedReceivablesLCY := GetPostedReceivablesLCY(CustomerNo);
        OtherOpenSalesOrdersLCY := GetOpenSalesOrdersLCY(CustomerNo, SalesHeader."No.");
        CurrentSalesOrderLCY := GetSalesOrderAmountLCY(SalesHeader);
    end;

    local procedure GetCreditCustomerNo(SalesHeader: Record "Sales Header"): Code[20]
    begin
        exit(SalesHeader."Bill-to Customer No.");
    end;

    local procedure GetPostedReceivablesLCY(CustomerNo: Code[20]): Decimal
    var
        Customer: Record Customer;
        PostedReceivablesLCY: Decimal;
        IsHandled: Boolean;
    begin
        OnBeforeGetPostedReceivablesLCY(CustomerNo, PostedReceivablesLCY, IsHandled);
        if IsHandled then
            exit(PostedReceivablesLCY);

        if CustomerNo = '' then
            exit(0);

        Customer.Get(CustomerNo);
        Customer.CalcFields("Balance (LCY)");
        exit(Customer."Balance (LCY)");
    end;

    local procedure GetOpenSalesOrdersLCY(CustomerNo: Code[20]; ExcludeSalesOrderNo: Code[20]): Decimal
    var
        SalesLine: Record "Sales Line";
        OpenSalesOrdersLCY: Decimal;
        IsHandled: Boolean;
    begin
        OnBeforeGetOpenSalesOrdersLCY(CustomerNo, ExcludeSalesOrderNo, OpenSalesOrdersLCY, IsHandled);
        if IsHandled then
            exit(OpenSalesOrdersLCY);

        if CustomerNo = '' then
            exit(0);

        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Bill-to Customer No.", CustomerNo);
        if ExcludeSalesOrderNo <> '' then
            SalesLine.SetFilter("Document No.", '<>%1', ExcludeSalesOrderNo);
        SalesLine.CalcSums("Outstanding Amount (LCY)");

        exit(SalesLine."Outstanding Amount (LCY)");
    end;

    local procedure GetSalesOrderAmountLCY(SalesHeader: Record "Sales Header"): Decimal
    var
        SalesLine: Record "Sales Line";
        SalesOrderAmountLCY: Decimal;
        IsHandled: Boolean;
    begin
        OnBeforeGetSalesOrderAmountLCY(SalesHeader, SalesOrderAmountLCY, IsHandled);
        if IsHandled then
            exit(SalesOrderAmountLCY);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.CalcSums("Outstanding Amount (LCY)");

        exit(SalesLine."Outstanding Amount (LCY)");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetPostedReceivablesLCY(CustomerNo: Code[20]; var PostedReceivablesLCY: Decimal; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetOpenSalesOrdersLCY(CustomerNo: Code[20]; ExcludeSalesOrderNo: Code[20]; var OpenSalesOrdersLCY: Decimal; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetSalesOrderAmountLCY(SalesHeader: Record "Sales Header"; var SalesOrderAmountLCY: Decimal; var IsHandled: Boolean)
    begin
    end;

    var
        CreditLimitExceededErr: Label 'Customer %1, %2, exceeds the credit limit.\Credit Limit: %3 LCY\Current Exposure: %4 LCY\Sales Order Amount: %5 LCY\Total Exposure: %6 LCY\Exceeded By: %7 LCY\Sales Order: %8', Comment = '%1 = customer number, %2 = customer name, %3 = credit limit, %4 = current exposure before current order, %5 = current sales order amount, %6 = total exposure, %7 = amount over credit limit, %8 = sales order number';
        SalesOrderCustomerMismatchErr: Label 'Sales Order %1 does not belong to customer %2.', Comment = '%1 = sales order number, %2 = customer number';
}

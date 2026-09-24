namespace Development_Plan.Development_Plan;
using Microsoft.Sales.Document;

codeunit 50131 "DMY Credit Limit Release Sub"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; var SkipCheckReleaseRestrictions: Boolean; SkipWhseRequestOperations: Boolean)
    var
        CreditLimitMgt: Codeunit "DMY Credit Limit Mgt.";
    begin
        CreditLimitMgt.ValidateSalesOrderCreditLimit(SalesHeader);
    end;
}

pageextension 50104 "Customer List Ext" extends "Customer List"
{
    actions
    {
        addfirst(processing)
        {
            action(ShowCustomerInvoices)
            {
                Caption = 'Show Customer Invoices';
                ApplicationArea = All;

                trigger OnAction()
                var
                    Q: Query CustomerInvoiceSummary;
                    CustNo: Code[20];
                    CustName: Text[100];
                    TotalAmount: Decimal;
                    Msg: Text;
                begin
                    Msg := '';

                    if Q.Open() then begin
                        while Q.Read() do begin
                            CustNo := Q.CustomerNo;               // DataItem_ColumnName
                            CustName := Q.CustomerName;           // DataItem_ColumnName
                            TotalAmount := Q.TotalInvoiceAmount; // DataItem_ColumnName

                            Msg += StrSubstNo('%1 (%2): %3\',
                                CustName,
                                CustNo,
                                Format(TotalAmount));
                        end;
                        Q.Close();
                    end;

                    if Msg = '' then
                        Message('No customers with posted invoices.')
                    else
                        Message(Msg);
                end;
            }
        }
    }
}
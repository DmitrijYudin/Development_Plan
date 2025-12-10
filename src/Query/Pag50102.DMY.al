page 50106 DMYPurchaseOrderQueryPage
{
    Caption = 'DMY Purchase Order Query';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = DMYPurchaseOrderQuery;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field(RowNo; Rec.RowNo)
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        ZYPurchaseOrderQuery: Query "DMY Purchase Order Query";
    begin
        if ZYPurchaseOrderQuery.Open() then begin
            while ZYPurchaseOrderQuery.Read() do begin
                Rec.Init();
                Rec.RowNo := Rec.RowNo + 1;
                Rec."Buy-from Vendor No." := ZYPurchaseOrderQuery.Buy_from_Vendor_No_;
                Rec."Buy-from Vendor Name" := ZYPurchaseOrderQuery.Buy_from_Vendor_Name;
                Rec."Currency Code" := ZYPurchaseOrderQuery.Currency_Code;
                Rec."Amount Including VAT" := ZYPurchaseOrderQuery.Amount_Including_VAT;
                Rec."Order Date" := ZYPurchaseOrderQuery.Order_Date;
                Rec."No." := ZYPurchaseOrderQuery.No_;
                Rec.Description := ZYPurchaseOrderQuery.Description;
                Rec.Quantity := ZYPurchaseOrderQuery.Quantity;
                Rec.Amount := ZYPurchaseOrderQuery.Amount;
                Rec.Inventory := ZYPurchaseOrderQuery.Inventory;
                Rec.Insert();
            end;
            ZYPurchaseOrderQuery.Close();
        end;
    end;
}
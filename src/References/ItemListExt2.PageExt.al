namespace Development_Plan.Development_Plan;

using Microsoft.Inventory.Item;

pageextension 50103 "Item List Ext 2" extends "Item List"
{
    actions
    {
        addlast(processing)
        {
            group("Development Plan")
            {
                action(References)
                {
                    ToolTip = 'References';
                    Image = Export;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Helper: Codeunit "SetRecFilter Helper";
                        RecRef: RecordRef;
                        VariantRec: Variant;
                    begin
                        // Current record from the page
                        VariantRec := Rec;

                        // Run codeunit logic
                        Helper.SetRecFilterFromVariant(VariantRec, RecRef);
                    end;
                }
            }
        }
    }
}

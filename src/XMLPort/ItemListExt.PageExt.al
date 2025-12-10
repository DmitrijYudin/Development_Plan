namespace AL.AL;

using Microsoft.Inventory.Item;

pageextension 50102 "Item List Ext" extends "Item List"
{
    actions
    {
        addlast(processing)
        {
            group(DMY)
            {
                action(ExportItems)
                {
                    ToolTip = 'DMYExportItems';
                    Image = Export;
                    ApplicationArea = All;
                    RunObject = xmlport DMYExportItems;
                }
            }
        }
    }
}


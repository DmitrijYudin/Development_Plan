namespace FindSet.FindSet;

page 50100 "DMY Page"
{
    ApplicationArea = All;
    Caption = 'DMY Page';
    PageType = List;
    SourceTable = "DMY Table";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("text"; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the text field.', Comment = '%';
                }
                field("integer"; Rec."integer")
                {
                    ToolTip = 'Specifies the value of the integer field.', Comment = '%';
                }
                field(Description2; Rec.Description2)
                {
                    ToolTip = 'Specifies the value of the Description2 field.', Comment = '%';
                }
            }
        }
    }
}

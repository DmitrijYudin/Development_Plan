table 50100 "DMY Table"
{
    Caption = 'DMY Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(2; Description; Text[128])
        {
            Caption = 'Description';
        }
        field(3; "integer"; Integer)
        {
            Caption = 'integer';
        }
        field(4; Description2; Text[2048])
        {
            Caption = 'Description2';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}

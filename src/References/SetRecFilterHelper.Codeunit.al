namespace Development_Plan.Development_Plan;

codeunit 50101 "SetRecFilter Helper"
{
    procedure SetRecFilterFromVariant(VariantRec: Variant; var RecRef: RecordRef)
    var
        KeyRef: KeyRef;
        FieldRef: FieldRef;
        FieldValueTxt: Text;
        i: Integer;
    begin
        if not VariantRec.IsRecord() then
            Error('Variant does not contain a record.');

        RecRef.GetTable(VariantRec);

        KeyRef := RecRef.KeyIndex(1);

        for i := 1 to KeyRef.FieldCount do begin
            FieldRef := KeyRef.FieldIndex(i);
            FieldValueTxt := Format(FieldRef.Value());
            if FieldValueTxt <> '' then
                FieldRef.SetFilter(FieldValueTxt);
        end;

        Message(
            'Table: %1\Filters:\%2',
            RecRef.Name,
            RecRef.GetFilters()
        );
    end;
}

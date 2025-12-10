namespace FindSet.FindSet;

using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;

pageextension 50101 "DMY Customer List Ext" extends "Customer List"
{
    actions
    {
        addfirst(General)
        {
            group(DMY)
            {
                action("Generate Table 1")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                        i: Integer;
                    begin
                        DMYTable.DeleteAll();
                        for i := 1 to 10000 do begin
                            DMYTable.Init();
                            DMYTable."No." := i;
                            DMYTable.Description := Format(i);
                            DMYTable.Insert();
                        end;
                    end;
                }
                action("Generate Table 2")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                        i: Integer;
                        myText: Text[2048];
                    begin
                        for i := 1 to 2048 do
                            myText += '1';

                        DMYTable.DeleteAll();
                        for i := 1 to 10000 do begin
                            DMYTable.Init();
                            DMYTable."No." := i;
                            DMYTable.Description := Format(i);
                            DMYTable.Description2 := myText;
                            DMYTable.Insert();
                        end;
                    end;
                }
                action("DMY Count")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        Message(Format(DMYTable.Count));
                    end;
                }
                action("FindSet(false)")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        Database.SelectLatestVersion();
                        if DMYTable.FindSet(false) then
                            repeat
                                if DMYTable.Description = 'dmy' then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;
                                if DMYTable.Description = 'dmy2' then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 1 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 30 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 50 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 51 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 100 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 1000 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 50000 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;
                            until DMYTable.Next() = 0;
                    end;
                }
                action("FindSet(true)")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        Database.SelectLatestVersion();
                        if DMYTable.FindSet(true) then
                            repeat
                                if DMYTable.Description = 'dmy' then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;
                                if DMYTable.Description = 'dmy2' then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 1 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 30 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 50 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 51 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 100 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 1000 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;

                                if DMYTable."No." = 50000 then
                                    if not Confirm(Format(DMYTable)) then
                                        exit;
                            until DMYTable.Next() = 0;
                    end;
                }
                action("Modify DMY")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        DMYTable.ModifyAll(Description, 'dmy');
                        Commit();
                    end;
                }
                action("Modify DMY2")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        DMYTable.ModifyAll(Description, 'dmy2');
                        Commit();
                    end;
                }
                action("Performance 1")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                        Text1: Text;
                        Text2: Text;
                        Text3: Text;
                        StartTime: DateTime;
                    begin
                        Database.SelectLatestVersion();
                        StartTime := CurrentDateTime;
                        if DMYTable.FindSet() then
                            repeat
                                if DMYTable.Description <> '' then begin
                                    Text1 := DMYTable.Description;
                                    Text2 := DMYTable.Description;
                                    Text3 := DMYTable.Description;
                                end;
                            until DMYTable.Next() = 0;
                        Message(Format(CurrentDateTime - StartTime));
                    end;
                }
                action("Performance 2")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                        Text1: Text;
                        Text2: Text;
                        Text3: Text;
                        TempText: Text;
                        StartTime: DateTime;
                    begin
                        Database.SelectLatestVersion();
                        StartTime := CurrentDateTime;
                        if DMYTable.FindSet() then
                            repeat
                                TempText := DMYTable.Description;
                                if TempText <> '' then begin
                                    Text1 := TempText;
                                    Text2 := TempText;
                                    Text3 := TempText;
                                end;
                            until DMYTable.Next() = 0;
                        Message(Format(CurrentDateTime - StartTime));
                    end;
                }
                action("Performance 3")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                        Text1: Text;
                        Text2: Text;
                        Text3: Text;
                        TempText: Text;
                        StartTime: DateTime;
                    begin
                        Database.SelectLatestVersion();
                        StartTime := CurrentDateTime;
                        if DMYTable.FindSet() then
                            repeat
                                Text1 := 'ddd';
                                Text2 := 'ttt';
                                Text3 := 'fff';
                            until DMYTable.Next() = 0;
                        Message(Format(CurrentDateTime - StartTime));
                    end;
                }
                action("Performance 4")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                        Text1: Text;
                        Text2: Text;
                        Text3: Text;
                        TempText: Text;
                        StartTime: DateTime;
                    begin
                        Database.SelectLatestVersion();
                        StartTime := CurrentDateTime;
                        if DMYTable.FindSet() then
                            repeat
                            //CheckAndModifyItem()
                            until DMYTable.Next() = 0;
                        Message(Format(CurrentDateTime - StartTime));
                    end;
                }
                action("Performance 5")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        StartTime: DateTime;
                        i: Integer;
                        Text1: Text;
                        Text2: Text;
                    begin
                        Database.SelectLatestVersion();
                        StartTime := CurrentDateTime;
                        for i := 1 to 10000 do begin
                            Text1 := 'ddd';
                            Text2 := 'ddd';
                        end;
                        Sleep(1);
                        Message(Format(CurrentDateTime - StartTime));
                    end;
                }
                action("Performance 6")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                        StartTime: DateTime;
                        i: Integer;
                        Text1: Text;
                        Text2: Text;
                    begin
                        Database.SelectLatestVersion();
                        StartTime := CurrentDateTime;

                        DMYTable.LockTable();
                        DMYTable.FindFirst();
                        DMYTable.Next(9999);

                        if not Confirm(Format(DMYTable)) then
                            exit;

                        Message(Format(CurrentDateTime - StartTime));
                    end;
                }
                action("Performance 7")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                        StartTime: DateTime;
                        i: Integer;
                        Text1: Text;
                        Text2: Text;
                    begin
                        Database.SelectLatestVersion();
                        StartTime := CurrentDateTime;

                        for i := 1 to 10000 do
                            DMYTable.Get(i);
                        Message(Format(CurrentDateTime - StartTime));
                    end;
                }
                action("Lock 1")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        if DMYTable.FindSet(true) then
                            repeat
                            until DMYTable.Next() = 0;

                        if not Confirm(Format(DMYTable)) then
                            exit;
                    end;
                }
                action("Lock 2")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        if DMYTable.FindSet(true) then
                            DMYTable.Next(DMYTable.Count - 1);

                        if not Confirm(Format(DMYTable)) then
                            exit;
                    end;
                }
                action("Lock 3")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        DMYTable.LockTable();
                        if DMYTable.FindFirst() then
                            DMYTable.Next(DMYTable.Count - 1);

                        if not Confirm(Format(DMYTable)) then
                            exit;
                    end;
                }
                action("Lock 4")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        DMYTable.LockTable();
                        DMYTable.Next(DMYTable.Count);

                        if not Confirm(Format(DMYTable)) then
                            exit;
                    end;
                }
                action("Lock 5")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYTable: Record "DMY Table";
                    begin
                        DMYTable.LockTable();
                        DMYTable.Next(500);

                        if not Confirm(Format(DMYTable)) then
                            exit;
                    end;
                }



            }
        }
    }
}



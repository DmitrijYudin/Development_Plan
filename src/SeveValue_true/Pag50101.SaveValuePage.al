namespace FindSet.FindSet;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;

page 50101 "SaveValue Page"
{
    ApplicationArea = All;
    Caption = 'SaveValue Page';
    PageType = Card;
    SaveValues = true;
    UsageCategory = Lists;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(GlobalText1Field; GlobalText1)
                {
                }
                field(GlobalText2Field; GlobalText2)
                {
                }
                field(GlobalText4Field; GlobalText4)
                {
                    Visible = HideField;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Read GlobalText1")
            {
                trigger OnAction()
                begin
                    Message(GlobalText1);
                end;
            }
            action("Read GlobalText3")
            {
                trigger OnAction()
                begin
                    Message(GlobalText3);
                end;
            }
            action("Read GlobalText4")
            {
                trigger OnAction()
                begin
                    Message(GlobalText4);
                end;
            }
            action("Set GlobalText1 = GlobalText 1")
            {
                trigger OnAction()
                begin
                    GlobalText1 := 'GlobalText 1';
                end;
            }
            action("Set GlobalText3 = GlobalText 3")
            {
                trigger OnAction()
                begin
                    GlobalText3 := 'GlobalText 3';
                end;
            }
            action("Set GlobalText1 = GlobalText 4")
            {
                trigger OnAction()
                begin
                    GlobalText4 := 'GlobalText 4';
                end;
            }
            action("Hide/show field")
            {
                trigger OnAction()
                begin
                    HideField := not HideField;
                end;
            }
            action("Refresh Page")
            {
                trigger OnAction()
                begin
                    CurrPage.Update();
                    CurrPage.Activate(true);
                end;
            }

            group("Global Vars")
            {
                action("Run DMYProcedure1 + DMYProcedure2")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYcodeunit: Codeunit "DMY codeunit";
                    begin
                        DMYcodeunit.DMYProcedure1();
                        DMYcodeunit.DMYProcedure2();
                    end;
                }
                action("Run DMYProcedure3")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYcodeunit: Codeunit "DMY codeunit";
                    begin
                        DMYcodeunit.DMYProcedure3();
                    end;
                }
                action("Run DMYProcedure1")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYcodeunit: Codeunit "DMY codeunit";
                    begin
                        DMYcodeunit.DMYProcedure1();
                    end;
                }
                action("Run DMYProcedure2")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DMYcodeunit: Codeunit "DMY codeunit";
                    begin
                        DMYcodeunit.DMYProcedure2();
                    end;
                }
            }
            group("Test 2")
            {
                action("Skip Insert")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        TempSalesHeader: Record "Sales Header" temporary;
                    begin
                        SalesHeader.FindFirst();
                        SalesHeader := TempSalesHeader;
                        SalesHeader.Insert();
                    end;
                }
            }
            action("Get partial 1")
            {
                Caption = 'Get Partial 1';
                ToolTip = 'Get Partial 1';
                ApplicationArea = all;

                trigger OnAction()
                var
                    CustomerPartial: Record Customer;
                    CustomerFirst: Record Customer;
                begin
                    CustomerFirst.FindFirst();
                    CustomerPartial.SetLoadFields("No.");
                    CustomerPartial.Get(CustomerFirst."No.");
                    Message('CustomerPartial = %1', Format(CustomerPartial));
                    Message('CustomerFirst = %1', Format(CustomerFirst));
                end;
            }

            group(Errors)
            {
                action("Error 1")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        CustomerFirst: Record Customer;
                        Text000Err: Label 'Ini text';
                    begin
                        CustomerFirst.FindFirst();

                        Error(Text000Err, 'sasd', 'sasasss2');
                    end;
                }
            }
            group(Dialog)
            {
                action("Dialog 1")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        Customer: Record Customer;
                        Dialog: Dialog;
                        i, j : Integer;
                        DialogLbl: Label 'Action "%1":  %2 .. #3\Description: #4\Status: #5',
                                    Locked = true, Comment = 'Action "%1":  %2 .. %3\Description: %4\Status: %5';
                        DialogTest: Text;
                        SleepTime: Integer;
                    begin
                        SleepTime := 2000;

                        for j := 1 to 2 do begin
                            // DialogTest := StrSubstNo(DialogLbl, 'j', j);
                            DialogTest := StrSubstNo(DialogLbl, 'j', Format(j), '#3', '#4', '#5');
                            Dialog.Open(DialogTest);
                            Sleep(SleepTime);
                            i := 0;
                            if Customer.FindSet() then
                                repeat
                                    i += 1;
                                    Dialog.Update(3, Format(i));
                                    Dialog.Update(4, Format(Customer."No."));
                                    Dialog.Update(5, Format(Customer.Name));
                                    Sleep(SleepTime);
                                until (Customer.Next() = 0) or (i = 2);

                            Dialog.Close();
                        end;
                    end;
                }
                action("Dialog 2")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        Customer: Record Customer;
                        Dialog: Dialog;
                        i, j : Integer;
                        DialogLbl: Label 'Action "#1":  #2 .. #3\Description: #4\Status: #5',
                                    Locked = true, Comment = 'Action "%1":  %2 .. %3\Description: %4\Status: %5';
                        DialogTest: Text;
                        SleepTime: Integer;
                    begin
                        SleepTime := 2000;

                        for j := 1 to 2 do begin
                            // DialogTest := StrSubstNo(DialogLbl, 'j', j);
                            DialogTest := DialogLbl;
                            Dialog.Open(DialogTest);
                            Sleep(SleepTime);
                            Dialog.Update(1, 'first ');
                            Dialog.Update(2, Format(j) + ' value');
                            Sleep(SleepTime);
                            i := 0;
                            if Customer.FindSet() then
                                repeat
                                    i += 1;
                                    Dialog.Update(3, Format(i));
                                    Dialog.Update(4, Format(Customer."No."));
                                    Dialog.Update(5, Format(Customer.Name));
                                    Sleep(SleepTime);
                                until (Customer.Next() = 0) or (i = 2);

                            Dialog.Close();
                        end;
                    end;
                }
            }
        }
    }
    var
        GlobalText1: Text;
        GlobalText2: Text;
        GlobalText3: Text;
        GlobalText4: Text;
        HideField: Boolean;

    trigger OnOpenPage()
    begin
        GlobalText2 := GlobalText3;
    end;
}

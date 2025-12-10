namespace FindSet.FindSet;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Customer;

codeunit 50100 "DMY codeunit"
{


    procedure DMYProcedure1()
    begin
        GlobalText50100 := '';
        OnBeforeDMYProcedure1(GlobalItem);
        GlobalText50100 := 'DMYProcedure1';
        Sleep(10);
    end;

    procedure DMYProcedure2()
    begin
        Message(GlobalText50100);
        OnBeforeDMYProcedure2(GlobalItem);
        Sleep(10);
    end;

    procedure DMYProcedure3()
    begin
        OnBeforeDMYProcedure1(GlobalItem);
        OnBeforeDMYProcedure2(GlobalItem);
        Sleep(10);
    end;

    var
        GlobalItem: Record Item;
        // GlobalCustomer: Record Customer;
        GlobalText50100: Text;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDMYProcedure1(var Item: Record Item)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDMYProcedure2(var Item: Record Item)
    begin
    end;

}

page 50120 "ShowHTML Demo"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            usercontrol(HtmlBox; ShowHTML)
            {
                ApplicationArea = All;

                trigger ControlAddInReady()
                begin
                    AddInIsReady := true;
                    CurrPage.HtmlBox.SetHtml('<b>Add-in loaded</b>');
                end;

                trigger AddInClicked(MessageText: Text)
                begin
                    Message(MessageText);
                end;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Test)
            {
                ApplicationArea = All;
                Caption = 'Show Colored HTML';

                trigger OnAction()
                begin
                    EnsureAddInReady();
                    CurrPage.HtmlBox.SetHtml(
                        '<span style="color:red;">Red</span> ' +
                        '<span style="color:green;">Green</span> ' +
                        '<span style="color:blue;">Blue</span>'
                    );
                end;
            }

            action(ShowCustomerName)
            {
                ApplicationArea = All;
                Caption = 'Show Two Texts';

                trigger OnAction()
                begin
                    EnsureAddInReady();
                    CurrPage.HtmlBox.ShowTwoTexts('John', 'Doe');
                end;
            }
        }
    }

    local procedure EnsureAddInReady()
    begin
        if not AddInIsReady then
            Error('The control add-in is not ready yet. Wait a moment and try again.');
    end;

    var
        AddInIsReady: Boolean;
}
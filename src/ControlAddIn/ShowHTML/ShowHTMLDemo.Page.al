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

                trigger OnAction()
                begin
                    // CurrPage.HtmlBox.ShowTwoTexts('John', 'Doe');
                    CurrPage.HtmlBox.SetHtml(
                    '<span style="color:red;">Red</span> ' +
                    '<span style="color:green;">Green</span> ' +
                    '<span style="color:blue;">Blue</span>'
                    );
                end;
            }
        }
    }

}
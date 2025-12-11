query 50120 CustomerInvoiceSummary
{
    QueryType = Normal;

    elements
    {
        dataitem(Customer; Customer)
        {
            // explicit column names (these will be exposed as fields on the Query object)
            column(CustomerNo; "No.")
            {
            }

            column(CustomerName; Name)
            {
            }

            dataitem(PostedInvoice; "Sales Invoice Header")
            {
                DataItemLink = "Sell-to Customer No." = Customer."No.";
                SqlJoinType = InnerJoin; // only customers with invoices

                column(TotalInvoiceAmount; Amount)
                {
                    Method = Sum;
                }
            }
        }
    }
}
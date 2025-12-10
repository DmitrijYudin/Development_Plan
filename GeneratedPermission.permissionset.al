permissionset 50100 GeneratedPermission
{
    Assignable = true;
    Permissions = tabledata "DMY Table" = RIMD,
        table "DMY Table" = X,
        tabledata DMYPurchaseOrderQuery = RIMD,
        table DMYPurchaseOrderQuery = X,
        codeunit "DMY codeunit" = X,
        codeunit "SetRecFilter Helper" = X,
        xmlport DMYExportItems = X,
        page "DMY Page" = X,
        page DMYPurchaseOrderQueryPage = X,
        page Pageusercontrol = X,
        page "SaveValue Page" = X,
        query "DMY Purchase Order Query" = X;
}
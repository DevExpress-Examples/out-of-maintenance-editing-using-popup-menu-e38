<%-- BeginRegion Page setup --%>
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Grid_Editing_CustomUpdate_CustomUpdate" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v7.3" Namespace="DevExpress.Web.ASPxEditors"  TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v7.3" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.v7.3" Namespace="DevExpress.Web.ASPxPager" TagPrefix="dxwp" %>
<%@ Register Assembly="DevExpress.Web.v7.3" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxwm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- EndRegion --%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Editing using popup menu</title>
<script language="javascript" type="text/javascript">
var editingVisibleIndex;
function ShowContextMenu(el, visibleIndex) {    
    editingVisibleIndex = visibleIndex;
    gridMenu.ShowAtElement(el);
}
function GridMenuItemClick(e) {
    if(e.item == null) return;
    var name = e.item.name;
    if(name == "New") grid.AddNewRow(); 
    if(name == "Edit") grid.StartEditRow(editingVisibleIndex); 
    if(name == "Delete") grid.DeleteRow(editingVisibleIndex);  
}
</script>    
</head>
<body>
    <form id="form1" runat="server">
    
        <dxwgv:ASPxGridView ID="grid" ClientInstanceName="grid" runat="server" DataSourceID="ObjectDataSource1" KeyFieldName="Id" Width="300px" >
            <%-- BeginRegion Grid Columns --%>
            <Columns>
                <dxwgv:GridViewDataColumn VisibleIndex="0">
                    <EditFormSettings Visible="false" />
                    <DataItemTemplate>
                        <a onclick="ShowContextMenu(this, <%# Container.VisibleIndex %>)" href="#">Edit</a>
                    </DataItemTemplate>
                </dxwgv:GridViewDataColumn>
                <dxwgv:GridViewDataColumn FieldName="Id" VisibleIndex="1">
                    <EditFormSettings Visible="false" />
                </dxwgv:GridViewDataColumn>
                <dxwgv:GridViewDataColumn FieldName="Name" VisibleIndex="2">
                    <EditFormSettings ColumnSpan="2" />
                </dxwgv:GridViewDataColumn>
                <dxwgv:GridViewDataColumn FieldName="Quantity" VisibleIndex="3">
                </dxwgv:GridViewDataColumn>
                <dxwgv:GridViewDataTextColumn FieldName="Price" VisibleIndex="4">
                    <PropertiesTextEdit DisplayFormatString="c"></PropertiesTextEdit>
                </dxwgv:GridViewDataTextColumn>
                <dxwgv:GridViewDataTextColumn FieldName="Total" VisibleIndex="5">
                    <EditFormSettings Visible="false" />
                    <PropertiesTextEdit DisplayFormatString="c"></PropertiesTextEdit>
                </dxwgv:GridViewDataTextColumn>
            </Columns>
            <%-- EndRegion --%>
            <SettingsEditing EditFormColumnCount="2" />
        </dxwgv:ASPxGridView>
        <dxwm:ASPxPopupMenu runat="server" ID="gridMenu" EnableClientSideAPI="True" PopupVerticalAlign="Below">
            <Items>
                <dxwm:MenuItem Text="New" Name="New"></dxwm:MenuItem>
                <dxwm:MenuItem Text="Edit" Name="Edit"></dxwm:MenuItem>
                <dxwm:MenuItem Text="Delete" Name="Delete"></dxwm:MenuItem>
            </Items>
            <ClientSideEvents ItemClick="function(s, e) { GridMenuItemClick(e);}" />
        </dxwm:ASPxPopupMenu>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"
            SelectMethod="GetItems" UpdateMethod="Update" DeleteMethod="Delete" InsertMethod="Insert" 
            TypeName="InvoiceItemsProvider">
        </asp:ObjectDataSource>
    </form>
</body>
</html>

﻿<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WfTpltSelection.aspx.cs"
    Inherits="LPWeb.Layouts.LPWeb.Pipeline.WfTpltSelection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../css/style.web.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.custom.css" rel="stylesheet" type="text/css" />
    <script src="../js/common.js" type="text/javascript"></script>
    <script src="../js/jquery.js" type="text/javascript"></script>
    <link href="../css/style.grid.css" rel="stylesheet" type="text/css" />
    <title>Workflow Templates Selection</title>
    <script type="text/javascript">
        function ckbClicked(me)
        {
            var bCheck = $(me).attr('checked');
            if (bCheck)
            {
                $('input:checkbox', $('#' + '<%=gvList.ClientID %>')).each(function() { 
                    if (this != me)
                        $(this).attr('checked', false);
                });
            }
        }

        function returnFn() {
            <%=this.ClientScript.GetPostBackEventReference(this.lbtnSelect, null) %>
        }

        // call back
        function callBack(sReturn)
        {
            if(window.parent && window.parent.getWfTpltSelectionReturn)
                window.parent.getWfTpltSelectionReturn(sReturn);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="div1" class="ColorGrid" style="margin-top: 5px;">
        <asp:GridView ID="gvList" runat="server" DataKeyNames="WflTemplId" EmptyDataText="There is no workflow template found in database."
            AutoGenerateColumns="False" CellPadding="3" CssClass="GrayGrid" GridLines="None">
            <EmptyDataRowStyle CssClass="EmptyDataRow" HorizontalAlign="Center" />
            <AlternatingRowStyle CssClass="EvenRow" />
            <Columns>
                <asp:TemplateField HeaderStyle-CssClass="CheckBoxHeader" ItemStyle-CssClass="CheckBoxColumn">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="ckbSelected" runat="server" EnableViewState="true" onclick="ckbClicked(this)" />
                    </ItemTemplate>
                    <HeaderStyle CssClass="CheckBoxHeader"></HeaderStyle>
                    <ItemStyle CssClass="CheckBoxColumn"></ItemStyle>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Name" />
            </Columns>
            <SelectedRowStyle BackColor="#E4E7EF" />
        </asp:GridView>
        <div class="GridPaddingBottom">
            &nbsp;</div>
    </div>
    <asp:LinkButton ID="lbtnSelect" runat="server" OnClick="lbtnSelect_Click"></asp:LinkButton>
    </form>
</body>
</html>

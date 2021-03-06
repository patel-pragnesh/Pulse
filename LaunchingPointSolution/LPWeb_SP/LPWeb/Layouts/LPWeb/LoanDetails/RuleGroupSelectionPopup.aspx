﻿<%@ Assembly Name="LPWeb, Version=1.0.0.0, Culture=neutral, PublicKeyToken=a2c3274f2ef313f2" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RuleGroupSelectionPopup.aspx.cs" Inherits="LoanDetails_RuleGroupSelectionPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rule Group Selection Popup</title>
    <link href="../css/style.web.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.custom.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.grid.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
// <![CDATA[

        // check/decheck all
        function CheckAll(CheckBox) {

            if (CheckBox.checked) {

                $("#gridRuleGroupList tr td :checkbox").attr("checked", "true");
            }
            else {

                $("#gridRuleGroupList tr td :checkbox").attr("checked", "");
            }
        }

        function BeforeAdd() {

            var sltRuleNum = $("#gridRuleGroupList tr:not(:first) td :checkbox:checked").length;
            if ($("#gridRuleGroupList tr:not(:first) td :checkbox:checked").length == 0) {

                alert("Please select rule(s).");
                return false;
            }

            var hdAddRuleNumClientID = "#<%= hdnAddRuleNum.ClientID %>";
            if (sltRuleNum > $(hdAddRuleNumClientID).val()) {

                alert("Each loan can have up to 20 rules or rule groups.");
                return false;
            }
            var RuleGroupIDs = "";
            $("#gridRuleGroupList tr:not(:first) td :checkbox:checked").each(function () {

                var RuleGroupID = $(this).attr("myRuleGroupId");
                if (RuleGroupIDs == "") {

                    RuleGroupIDs = RuleGroupID;
                }
                else {

                    RuleGroupIDs += "," + RuleGroupID;
                }
            });

            $("#hdnSelectedRuleGroupIDs").val(RuleGroupIDs);

            return true;
        }
// ]]>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="divContainer" style="width: 407px; border: solid 0px red;">
        <div id="divGridPanel" style="width: 407px; height: 350px; overflow: auto; border-bottom: solid 1px #e4e7ef;">
            <div id="divRuleGroupList" class="ColorGrid" style="margin-top: 5px;">
                <asp:GridView ID="gridRuleGroupList" runat="server" DataSourceID="RuleGroupSqlDataSource" EmptyDataText="There is no rule group." AutoGenerateColumns="False" CellPadding="3" CssClass="GrayGrid" GridLines="None">
                    <EmptyDataRowStyle CssClass="EmptyDataRow" HorizontalAlign="Center" />
                    <AlternatingRowStyle CssClass="EvenRow" />
                    <Columns>
                        <asp:TemplateField HeaderStyle-CssClass="CheckBoxHeader" ItemStyle-CssClass="CheckBoxColumn">
                            <HeaderTemplate>
                                <input id="chkCheckAll" type="checkbox" onclick="CheckAll(this)" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <input id="chkSelected" type="checkbox" myRuleGroupId="<%# Eval("RuleGroupId")%>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="Rule Group" />
                    </Columns>
                </asp:GridView>
                <div class="GridPaddingBottom">&nbsp;</div>
            </div>
            <asp:SqlDataSource ID="RuleGroupSqlDataSource" runat="server" DataSourceMode="DataReader">
            </asp:SqlDataSource>
        </div>
        <div id="divButtons" style="margin-top: 10px;">
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="Btn-66" OnClientClick="return BeforeAdd();" onclick="btnAdd_Click" />
                    </td>
                    <td style="padding-left: 8px;">
                        <input id="btnCancel2" type="button" value="Cancel" class="Btn-66" onclick="window.parent.CloseDialog_AddRule();" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <asp:HiddenField ID="hdnSelectedRuleGroupIDs" runat="server" />
    <asp:HiddenField ID="hdnProspectLoan" runat="server" />
    <asp:HiddenField ID="hdnAddRuleNum" runat="server" />
    </form>
</body>
</html>

<%@ Page Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="emp-asset-dashboard.aspx.cs" Inherits="AMS_V1.emp_asset_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <div class="row">
        <div class="col-lg-2">
            <div class="small-box bg-yellow-gradient"  onclick="SetAssetFilter('Available')">
                <div class="inner">
                    <p class="mb-0">Available Assets </p>
                    <h3 id="AvailableAssets"></h3>
                </div>
            </div>
        </div>
 </div>

<script>
    function SetAssetFilter(searchText) {
        sessionStorage.setItem("SearchText", searchText);
        window.location.href = "view-available-assets.aspx";
    }
    $(document).ready(function () {
        sessionStorage.setItem("UserId", 3);
        $('#liHomeBreadCrum').hide();
        $.ajax({
            url: "http://localhost:57080/api/Asset/getAvailableAssetCount?userid="+sessionStorage.getItem("UserId"),
            type: "GET",
            success: function (result) {
                debugger;
                if (result.length > 0) {
                    $('#AvailableAssets').text(result[0].AvailableAssetCount);
                }
            },
            error: function (errormessage) {
                $('#divLoader').hide();
                alert(errormessage.responseText);
            }
        });
    });
</script>
</asp:Content>

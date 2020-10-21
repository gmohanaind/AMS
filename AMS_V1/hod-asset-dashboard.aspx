<%@ Page Title="" Language="C#" MasterPageFile="~/Hod.Master" AutoEventWireup="true" CodeBehind="hod-asset-dashboard.aspx.cs" Inherits="AMS_V1.hod_asset_dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
          <div class="row">
        <div class="col-lg-2">
            <div class="small-box bg-yellow-gradient"  onclick="SetAssetFilter('Requested')">
                <div class="inner">
                    <p class="mb-0">Requested Assets </p>
                    <h3 id="RequestedAssets"></h3>
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
        sessionStorage.setItem("UserId", 2);
        $('#liHomeBreadCrum').hide();
        $.ajax({
            url: "http://localhost:57080/api/Asset/GetAssetDashboardDetailsForHOD?userid="+sessionStorage.getItem("UserId"),
            type: "GET",
            success: function (result) {
                console.log(result);
                if (result.length > 0) {                    
                    $('#RequestedAssets').text(result[0].TotalRequestedCount);
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

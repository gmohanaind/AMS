<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="change-asset-status.aspx.cs" Inherits="AMS_V1.Views.change_asset_status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/custom.js"></script>
    <style>
         .disabled{
            cursor: not-allowed; /* aesthetics */
            pointer-events: none;
            background-color:#ccc !important;
             border-color:#ccc !important;
            }
         .nav-tabs {
             border-bottom: 0 !important;
        }
    </style>
    <div class="content">
         <div class="card bg-white" style="padding: 0% 2%;">
            <div class="row">
                <div class="col-md-6 text-center text-sm-left mt-4 mb-2">
                            <h5 class="text-primary"><b>List of Available Assets </b></h5>                 
                </div>
                <div class="col-md-6 text-sm-left mt-4 mb-2">
                     <span class="text-primary"  style="margin-left:22%;padding: 10px;font-weight:bold;">Select Assets to move to </span>
                     <button class="btn btn-success btn-sm" id="btnChangeStatus" onclick="openAssetChangeStatusModal()"></button>
                </div>
            </div>
        </div>
        <div class="card card-body bg-white" id="assetCard">
            <div class="nav nav-tabs nav-tabs-2">
                <a class="nav-item nav-link active" href="#tab1primary" data-toggle="tab" onclick="getAssets(1,'Check Out',2)">Check Out </a>
                <a class="nav-item nav-link" href="#tab2primary" data-toggle="tab" onclick="getAssetsForCheckin(0)">Check In</a>
                <a class="nav-item nav-link" href="#tab1primary" data-toggle="tab" onclick="getAssets(1,'Maintenance',4)">Maintenance</a>
                <a class="nav-item nav-link" href="#tab1primary" data-toggle="tab" onclick="getAssets(1,'Damage',8)">Damage</a>
                <a class="nav-item nav-link" href="#tab1primary" data-toggle="tab" onclick="getAssets(1,'Dispose',6)">Dispose</a>
                <a class="nav-item nav-link" href="#tab1primary" data-toggle="tab" onclick="getAssets(1,'Lost',5)">Lost</a>
               
            </div>
            <div class="tab-content mt-3">
                <div class="tab-pane fade in active show" id="tab1primary"  style="width: 100%; height: auto; overflow: auto;">
                    <table id="tblAssets" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" name="chk_All" id="chk_All" /></th>
                                <th># </th>
                                <th>Image </th>
                                <th>Tag</th>
                                <th>Name </th>
                                <th>Cost </th>
                                <th>Category </th>
                                <th>Sub Category </th>
                            </tr>
                        </thead>
                        <tbody class="assetBody">
                        </tbody>
                    </table>
                </div>
                <div class="tab-pane fade in" id="tab2primary"  style="width: 100%; height: auto; overflow: scroll;">
                    <table id="tblCheckinAssets" class="table table-bordered table-hover"
                        style="display: none; overflow-x: auto;">
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" name="chk_All_Checkin" id="chk_All_Checkin" /></th>
                                <th># </th>
                                <th>Tag Id</th>
                                <th>Asset Name</th>
                                <th>Person/Site</th>
                                <th>Person Name</th>
                                <th>Site</th>
                                <th>Location</th>
                                <th>Department</th>
                                <th>Checkout Date </th>
                                <th>Due Date </th>
                            </tr>
                        </thead>
                        <tbody class="checkinAssetBody">
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
        <div id="noAssets">
            <span class="text-dangr">No Assets Found..</span>
        </div>
    </div>


    <!--Departments Modal -->
    <div id="mdlCheckinAssetDetails" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width: 60%;">
            <!-- Modal content-->
            <div class="modal-content" style="margin-top: 10%;">
                <div class="modal-header">
                    <h5 class="modal-title" style="color: #000; font-weight: 600;" id="hAssetName"></h5>
                    <button type="button" class="close" data-dismiss="modal" style="color: #000; font-weight: 600; opacity: unset;">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-4" id="divPerson" style="display: none; padding-left: 5%;">
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Check out Person  </label>
                                <p id="checkoutPerson" class="asset"></p>
                            </div>
                            <div class="form-group" id="divAssetImage" style="margin-top: 15%;">
                                <img src="" width="160" class="img-fluid mx-auto d-flex" id="AssetImage"
                                    onerror="this.onerror=null;this.src='/../dist/img/assets/laptop.png'" />

                            </div>
                        </div>
                        <div class="col-sm-4" id="divSite" style="display: none; padding-left: 5%;">
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Check out Site  </label>
                                <p id="CheckoutSite" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Check out Location  </label>
                                <p id="CheckoutLocation" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Check out Department </label>
                                <p id="CheckoutDepartment" class="asset"></p>
                            </div>
                            <div class="form-group" id="divAssetImageSite" style="margin-top: 15%;">
                                <img src="" width="160" class="img-fluid mx-auto d-flex" id="AssetImageSite"
                                    onerror="this.onerror=null;this.src='/../dist/img/assets/laptop.png'" />

                            </div>
                        </div>
                        <div class="col-sm-4">

                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Asset Tag ID  </label>
                                <p id="AssetTagId" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Asset Name  </label>
                                <p id="AssetName" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Status</label>
                                <p id="StatusName" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Asset Type  </label>
                                <p id="AssetType" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Asset Cost  </label>
                                <p id="AssetCost" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Category </label>
                                <p id="CategoryName" class="asset"></p>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Site </label>
                                <p id="SiteName" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Location  </label>
                                <p id="LocationName" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Department </label>
                                <p id="DepartmentName" class="asset"></p>
                            </div>

                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Purchased On </label>
                                <p id="PurchasedOn" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Purchase Type </label>
                                <p id="PurchasedType" class="asset"></p>
                            </div>
                            <div class="form-group">
                                <label class="f-w-400 text-muted mb-1">Sub Category </label>
                                <p id="SubCategoryName" class="asset"></p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- Departments Modal -->
    <div>
        <% Response.WriteFile("change-asset-status.html"); %>
    </div>
    <script type="text/javascript">
        function formatDateTime(input) {
            var date = input;
            date = date.replace('T', ' ').split('.')[0].split(' ')[0].split('-');
            return date[2] + "/" + date[1] + "/" + date[0];
        };
        var assetlist = null;
        var apiUrl = "http://localhost:57080/api/";
        var assetIds = [];
        var uniqueIds = [];
        var assetChangeStatus;
        var checkinAssets = [];
        $("#tblCheckinAssets tbody").on("click", "tr", function (event) {
            debugger;
            var table = $('#tblCheckinAssets').DataTable();
            var asset_Id = table.row(this).data().DT_RowId.split('_')[1];
            window.location.href = "view-ind-asset.aspx?assetId=" + asset_Id;           
        });


        $("#tblAssets tbody").on("click", "tr", function (event) {
            debugger;
            var table = $('#tblAssets').DataTable();
            var asset_Id = table.row(this).data().DT_RowId.split('_')[1];
            window.location.href = "view-ind-asset.aspx?assetId=" + asset_Id;
        });

        function openAssetChangeStatusModal() {
            if (assetChangeStatus == "Maintenance") {
                $("#assetMaintenanceModel").modal("show");
            }
            else if (assetChangeStatus == "Dispose" || assetChangeStatus == "Damage" || assetChangeStatus == "Lost") {
                if (assetChangeStatus == "Dispose")
                    sessionStorage.setItem("ChangeStatusId", 6);
                else if (assetChangeStatus == "Damage")
                    sessionStorage.setItem("ChangeStatusId", 8);
                else if (assetChangeStatus == "Lost")
                    sessionStorage.setItem("ChangeStatusId", 5);
                $('#hdAssetStatus').text(assetChangeStatus);
                $("#mdlAssetOtherStatus").modal("show");
            }
            else {
                if (assetChangeStatus == "Check In" && assetIds.length == 1) {
                    debugger;
                    var checkinAssets = JSON.parse(sessionStorage.getItem("checkinAssets"));
                    var objret = $.grep(checkinAssets, function (n, i) {
                        return n.AssetId == parseInt(assetIds[0]);
                    });
                    var assetDetails = objret[0];
                    console.log(assetDetails);
                    if (assetDetails.PersonOrSite == 1) {
                        $("#rdPerson").prop("checked", true);
                        $('#rdPerson').click();
                        $("#rdPerson").addClass("disabled");
                        $("#rdSite").addClass("disabled");
                        $('#txtCheckoutPerson').val(assetDetails.Personname);
                        $('#txtCheckoutPerson').addClass("disabled");
                    }
                    else {
                        $("#rdSite").prop("checked", true);
                        $('#rdSite').click();
                        $("#rdPerson").addClass("disabled");
                        $("#rdSite").addClass("disabled");
                        getAllSites();
                        setTimeout(function () {
                            $('#MainContent_ddlAssetSites').val(assetDetails.SiteId);
                            $('.ddlAssetSites').change();
                            $('.ddlAssetSites').addClass("disabled");
                            setTimeout(function () {
                                $('#MainContent_ddlAssetLocations').val(assetDetails.LocationId);
                                $('.ddlAssetLocations').change();
                                $('.ddlAssetLocations').addClass("disabled");
                                setTimeout(function () {
                                    $('#MainContent_ddlAssetDepartments').val(assetDetails.DepartmentId);
                                    $('#MainContent_ddlAssetDepartments').addClass("disabled");
                                }, 100);
                            }, 100);
                        }, 100);

                    }
                }
                if (assetChangeStatus == "Check In" && assetIds.length > 1) {
                    $("#rdPerson").prop("checked", true);
                    $("#rdPerson").click();
                    $("#rdSite").prop("checked", false);
                    $("#rdSite").removeClass("disabled");
                    $("#rdPerson").removeClass("disabled");
                    $("#MainContent_ddlAssetSites").val("").removeClass("disabled");
                    $("#MainContent_ddlAssetLocations").val("").removeClass("disabled");
                    $("#MainContent_ddlAssetDepartments").val("").removeClass("disabled");
                    $("#txtCheckoutPerson").val("").removeClass("disabled").css({ "background-color": "#fff" });
                }
                $('#txtModalHeader').text(assetChangeStatus);
                if (assetChangeStatus == "Check Out") {
                    $('#divDueDate').show();
                }
                else if (assetChangeStatus == "Check In") {
                    $('#divDueDate').hide();
                }
                $("#mdlChangeAssetStatus").modal("show");
            }
            sessionStorage.setItem("changestatus_assetids", assetIds);
            sessionStorage.setItem("changestatus_uniqueids", uniqueIds);
            sessionStorage.setItem("assetChangeStatus", assetChangeStatus);
        }
        function getAssetIds(assetId, uniqueid) {
            if ($('#chk_' + assetId).prop("checked") == true) {
                // alert("Checkbox is checked.");
                assetIds.push(assetId);
                uniqueIds.push(0);
            }
            else if ($('#chk_' + assetId).prop("checked") == false) {
                //alert("Checkbox is unchecked.");
                assetIds.splice($.inArray(assetId, assetIds), 1);
                uniqueIds.pop();
            }
            if (assetIds.toString().length == 0)
                $('#btnChangeStatus').addClass("disabled");
            else
                $('#btnChangeStatus').removeClass("disabled");
        }
        function getCheckinAssetIds(assetId, uniqueid) {
            debugger;
            if ($('#chk_Checkin_' + assetId).prop("checked") == true) {
                // alert("Checkbox is checked.");
                assetIds.push(assetId);
                uniqueIds.push(uniqueid);
            }
            else if ($('#chk_Checkin_' + assetId).prop("checked") == false) {
                //alert("Checkbox is unchecked.");
                assetIds.splice($.inArray(assetId, assetIds), 1);
                uniqueIds.splice($.inArray(uniqueid, uniqueIds), 1);
            }
            if (assetIds.toString().length == 0)
                $('#btnChangeStatus').addClass("disabled");
            else
                $('#btnChangeStatus').removeClass("disabled");
        }
        function getAssets(getAssetStatusid, status, statusid) {
            assetIds = [];
            uniqueIds = [];

            $('#btnChangeStatus').html(status);
            $('#btnChangeStatus').addClass("disabled");
            assetChangeStatus = status;
            if (assetlist.length > 0) {
                //Clear the Data Table for new fetch
                if ($.fn.dataTable.isDataTable("#tblAssets")) {
                    $('#tblAssets').DataTable().clear().destroy();
                }
                var html = '';
                var i = 0;

                $.each(assetlist, function (key, asset) {
                    if (asset.AssetStatusId == getAssetStatusid) {

                        i = i + 1;
                        var imgUrl = "./../AssetImages/" + asset.AssetId + ".png";
                        var errorImgUrl = "./../dist/img/assets/laptop.png";
                        var statusClass = "text-success";
                        if (asset.StatusName.toUpperCase() != "IN STORAGE")
                            statusClass = "text-danger";
                        html += '<tr style="cursor:pointer;hover:green"  id=tr_' + asset.AssetId + ' onclick="assetView(' + asset.AssetId + ')">';
                        html += '<td onclick=event.stopPropagation()><input type="checkbox" name="chk_' + asset.AssetId + '" id="chk_' + asset.AssetId + '" onclick="getAssetIds(' + asset.AssetId + ')" /></td>';
                        html += '<td>' + i + '</td>';
                        html += '<td><img src="' + imgUrl + '" width="30" class="img-fluid mx-auto d-flex" onerror="this.onerror=null;this.src=\'' + errorImgUrl + '\'" /></td>';
                        html += '<td>' + asset.AssetTagId + '</td>';
                        html += '<td>' + asset.AssetName + '</td>';
                        html += '<td style="text-align:right;">' + asset.AssetCost + '</td>';
                        html += '<td>' + asset.CategoryName + '</td>';
                        html += '<td>' + asset.SubCategoryName + '</td>';
                        html += '</tr>';
                    }
                });
                $('.assetBody').html(html);
                //Make it as a Data Table
                $('#tblAssets').DataTable({                   
                    retrieve: true
                });
                $('#tblAssets').show();
            }
            else {
                $('#noAssets').show();
            }
        }
        $(document).ready(function () {
            debugger;
            $('#noAssets').hide();
            $('#btnChangeStatus').addClass('disabled');
            
            $('.li-dashboard').removeClass('active');
            $('.li-change-asset-status').addClass('active');
            var url = apiUrl;
            $.ajax({
                url: apiUrl + "Asset/GetAssetsForStatusChange",
                type: "GET",
                success: function (result) {
                    assetlist = result;
                    getAssets(1, 'Check Out',2);
                },
                error: function (errormessage) {
                    $('#divLoader').hide();
                    alert(errormessage.responseText);
                }
            });
        });

    </script>
</asp:Content>

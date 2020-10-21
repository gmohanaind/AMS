<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="view-assets.aspx.cs" Inherits="AMS_V1.Views.view_assets" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 
     <script src="../Scripts/filter.js"></script>
    <style>
        sup{
              top: -1.2em !important;
        }
}
        .afont {
            font-size: 14px !important;
            font-weight: 600 !important;
            padding: 20px !important;
        }
        .table-responsive.res-drop {height:500px!important;}
        .dropdown-item {
            padding: 0 !important;
            padding: 2px 0px !important;
        }

        .select2-search__field {
            padding: 0 !important;
        }

        .select2-container--default .select2-results__option[aria-selected=true] {
            display: none !important;
        }

        .select2-container--default .select2-results__option[aria-disabled=true] {
            display: none !important;
        }

        .modal-header {
            background-color: #007bff !important;
        }

        .asset {
            font-weight: 600;
            font-size: 14px;
        }

        .custom-tabs.nav-tabs .nav-link.active {
            border-bottom: 3px solid #007bff !important;
        }

        .card-header {
            background-color: #007bff !important;
            padding: 0 !important;
            color: white;
            border-radius: 0 !important;
        }

        h5 {
            font-weight: bolder;
        }

        .mtprow {
            margin-top: -10px;
            margin-bottom: -10px;
        }
    </style>

    <div class="content">
        <div class="card">
            <div class="spinner" id="divLoader" style="display: none">
                <div class="text-info" style="margin: 15%;">
                    <i class="fa fa-spinner fa-spin" style="font-size: 28px !important;"></i>
                    <p style="font-size: 18px !important;">Please wait a while! Fetching Assets</p>
                </div>
            </div>
            <div class="card-body" style="display: none;" id="assetCard">
                <div class="row pb-2 border-bottom mb-3">
                    <div class="col-md-6 text-center text-sm-left">
                        <h5><b>List of Assets </b></h5>
                    </div>
                    <div class="col-md-6 text-center text-sm-right p-0">
                        <div class="clearfix">
                            <a class="btn btn-primary btn-sm" runat="server" href="~/add-asset.aspx">
                                <i class="fas fa-plus"></i>Add Asset
                            </a>
                            <div class="dropdown btn-group" id="column-dropdown">
                                <button id="btnGroupDrop1" type="button" class="btn btn-success btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-cogs"></i>Columns
                                </button>
                                <div class="dropdown-menu dropdown-menu-right afont" aria-labelledby="btnGroupDrop1">
                                    <a class="dropdown-item" href="#" id="acol2" style="color: green;"><span><i class="fas fa-check mr-1" id="col2"></i></span>Tag Id </a>
                                    <a class="dropdown-item" href="#" id="acol3" style="color: green;"><span><i class="fas fa-check mr-1" id="col3"></i></span>Name </a>
                                    <a class="dropdown-item" href="#" id="acol4" onclick="showHideColumn(4)"><span><i class="fas fa-check mr-1" id="col4"></i></span>Cost </a>
                                    <a class="dropdown-item" href="#" id="acol5" onclick="showHideColumn(5)"><span><i class="fas fa-check mr-1" id="col5"></i></span>Category </a>
                                    <a class="dropdown-item" href="#" id="acol6" onclick="showHideColumn(6)"><span><i class="fas fa-check mr-1" id="col6"></i></span>Sub Category </a>
                                    <a class="dropdown-item" href="#" id="acol7" onclick="showHideColumn(7)"><span><i class="fas fa-check mr-1" id="col7"></i></span>Purchased From</a>
                                    <a class="dropdown-item" href="#" id="acol8" onclick="showHideColumn(8)"><span><i class="fas fa-check mr-1" id="col8"></i></span>Purchased On</a>
                                    <a class="dropdown-item" href="#" id="acol9" onclick="showHideColumn(9)"><span><i class="fas fa-check mr-1" id="col9"></i></span>Purchase Type</a>
                                    <a class="dropdown-item" href="#" id="acol10" onclick="showHideColumn(10)"><span><i class="fas fa-check mr-1" id="col10"></i></span>Site</a>
                                    <a class="dropdown-item" href="#" id="acol11" onclick="showHideColumn(11)"><span><i class="fas fa-check mr-1" id="col11"></i></span>Location</a>
                                    <a class="dropdown-item" href="#" id="acol12" onclick="showHideColumn(12)"><span><i class="fas fa-check mr-1" id="col12"></i></span>Department</a>
                                    <a class="dropdown-item" href="#" id="acol13" onclick="showHideColumn(13)"><span><i class="fas fa-check mr-1" id="col13"></i></span>Insurance </a>
                                    <a class="dropdown-item" href="#" id="acol14" onclick="showHideColumn(14)"><span><i class="fas fa-check mr-1" id="col14"></i></span>Warranty Expiration Date </a>
                                    <a class="dropdown-item" href="#" id="acol15" onclick="showHideColumn(15)"><span><i class="fas fa-check mr-1" id="col15"></i></span>Description</a>
                                    <a class="dropdown-item" href="#" id="acol16" onclick="showHideColumn(16)"><span><i class="fas fa-check mr-1" id="col16"></i></span>Warranty Details</a>
                                    <a class="dropdown-item" href="#" id="acol17" onclick="showHideColumn(17)"><span><i class="fas fa-check mr-1" id="col17"></i></span>Status </a>
                                    <a class="dropdown-item" href="#" id="acol18" onclick="showHideColumn(18)"><span><i class="fas fa-check mr-1" id="col18"></i></span>Actions </a>
                                </div>
                            </div>                           
                        </div>
                    </div>
                </div>

                <div class="card w-100 mt-2" style="margin-top: 20px !important;">
                    <form id="frmFilter" class="form-horizontal" style="margin-top: -10px;">
                        <div class="card-header" id="asset-sec-heading-2">
                            <h5 class="mb-0">
                                <a class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#asset-sec-collapse-2">Filter
                                    <i class="fas fa-filter float-right pt-2" aria-hidden="true"></i>
                                </a>
                            </h5>
                        </div>
                        <div id="asset-sec-collapse-2" class="collapse" aria-labelledby="asset-sec-heading-2" style="border: 1px solid rgb(0, 123, 255);">
                            <div class="card-body">
                                <div class="row mtprow">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="MainContent_ddlAssetTagIdType" class="col-form-label">Tag ID Type </label>
                                            <select class="js-example-basic-multiple" name="tagidtype[]" multiple="multiple" id="MainContent_ddlAssetTagIdType">
                                                <option value="1">Auto Increment</option>
                                                <option value="2">Custom</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="MainContent_ddlAssetCategories" class="col-form-label">Category</label>
                                            <select class="js-example-basic-multiple" name="category[]" multiple="multiple" id="MainContent_ddlAssetCategories">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="MainContent_ddlSubCategories" class="col-form-label">Sub Category</label>
                                            <select class="js-example-basic-multiple" name="subcategory[]" multiple="multiple" id="MainContent_ddlSubCategories">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mtprow">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="MainContent_ddlAssetSites" class="col-form-label">Site &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  </label>
                                            <select class="js-example-basic-multiple" name="sites[]" multiple="multiple" id="MainContent_ddlAssetSites">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="MainContent_ddlLocations" class="col-form-label">Location</label>
                                            <select class="js-example-basic-multiple" name="locations[]" multiple="multiple" id="MainContent_ddlLocations">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="MainContent_ddlDepartments" class="col-form-label">Department </label>
                                            <select class="js-example-basic-multiple" name="departments[]" multiple="multiple" id="MainContent_ddlDepartments">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mtprow">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="MainContent_ddlVendor" class="col-form-label">Vendor &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </label>
                                            <select class="js-example-basic-multiple" name="vendor[]" multiple="multiple" id="MainContent_ddlVendor">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="MainContent_ddlPurchasedType" class="col-form-label">Purchase Type</label>
                                            <select class="js-example-basic-multiple" name="purchasedType[]" multiple="multiple" id="MainContent_ddlPurchasedType">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="MainContent_ddlAssetInsurance" class="col-form-label">Insurance </label>
                                            <select class="js-example-basic-multiple" name="insurance[]" multiple="multiple" id="MainContent_ddlAssetInsurance">
                                            </select>
                                        </div>
                                    </div>
                                  
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12 text-right">
                                        <button class="btn btn-primary btn-sm" id="asset-filter" style="margin-right: 18px;">Apply Filter</button>
                                        <button class="btn btn-danger btn-sm" id="clear-filter" style="margin-right: 18px;">Clear Filter</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                 <div class="nav nav-tabs nav-tabs-2">
                    <a class="nav-item nav-link active" id="aInStorage" href="#tab1primary" data-toggle="tab" onclick="getAssets(1)">In Storage <sup class="badge badge-success" id="cntInStorage"></sup> </a>
                    <a class="nav-item nav-link"  id="aRequests" href="#tab1primary" data-toggle="tab" onclick="getAssets(9)">Requested <sup class="badge badge-primary" id="cntRequested"></sup></a>
                    <a class="nav-item nav-link"  id="aCheckOut" href="#tab1primary" data-toggle="tab" onclick="getAssets(2)">Check Out <sup class="badge badge-info" id="cntCheckOut"></sup> </a>
                    <%--<a class="nav-item nav-link"  id="aCheckIn" href="#tab1primary" data-toggle="tab" onclick="getAssets(3)">Check In Pending</a>--%>
                    <a class="nav-item nav-link"  id="aMaintenance" href="#tab1primary" data-toggle="tab" onclick="getAssets(4)">Maintenance <sup class="badge badge-dark" id="cntMaintenance"></sup></a>
                    <a class="nav-item nav-link"  id="aDamage" href="#tab1primary" data-toggle="tab" onclick="getAssets(8)">Damaged <sup class="badge badge-danger" id="cntDamage"></sup></a>
                    <a class="nav-item nav-link"  id="aDispose" href="#tab1primary" data-toggle="tab" onclick="getAssets(6)">Disposed <sup class="badge badge-light" id="cntDisposed"></sup></a>
                    <a class="nav-item nav-link"  id="aLost" href="#tab1primary" data-toggle="tab" onclick="getAssets(5)">Lost <sup class="badge badge-warning" id="cntLost"></sup></a>
                      <a class="nav-item nav-link"  id="aAll" href="#tab1primary" data-toggle="tab" onclick="getAssets(0)">All <sup class="badge badge-warning" id="cntAll"></sup></a>
               
                 </div>
                <div class="assetTable mt-4 table-responsive"></div>
            </div>
        </div>

        <div id="mdlAssetApproveOrReject" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="hAssetApproveOrReject"></h5>
                        <button type="button" class="close" data-dismiss="modal">
                            &times;
                        </button>
                    </div>
                    <form class="form-horizontal" id="frmAddCategory" name="frmAddCategory" action="#">
                        <div class="modal-body">
                            <div class="form-group row">
                                <div class="col-md-12">
                                    <label for="txtApproveOrRejectRemarks" class="col-form-label">Remarks</label>
                                    <textarea id="txtApproveOrRejectRemarks" name="txtApproveOrRejectRemarks"
                                        class="form-control"> </textarea>
                                </div>
                                <div>
                                    <span class="text-danger" id="errAssetRequestRemarks" style="display: none;">Remarks is required!</span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary" id="btnApproveOrReject" name="btnApproveOrReject" onclick="AssetApproveOrReject()"><i class="far fa-save"></i>save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="card w-100 mt-2" style="margin-top: 250px !important; border-left: 2px solid #007bff; display: none" id="no-assets">
            <h6 class="text-center p-2" style="margin-top: .5rem;">There are no assets yet, <a href="add-asset.aspx">Click here </a>to add new asset.</h6>
        </div>
        <div class="card w-100 mt-2" style="margin-top: 50px !important; border-left: 2px solid #007bff; display: none" id="no-assets-filter">
            <h6 class="text-center p-2" style="margin-top: .5rem;">No records found.</h6>
        </div>
    </div>
   
    <div>
        <% Response.WriteFile("change-asset-status.html"); %>
    </div>
    <script type="text/javascript">
        var apiUrl = "http://localhost:57080/api/";
        var selectedColumn = [1, 2, 3, 4, 5,8,9,18];
        var hiddenCoulmn = [0, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17];
        $('#column-dropdown .dropdown-menu').on({
            "click": function (e) {
                e.stopPropagation();
            }
        });

        function getDate(input, format) {
            var rtDate = "";
            if (input == "")
                return rtDate;

            var dt = new Date(input);
            var day = ("0" + dt.getDate()).slice(-2);
            var month = ("0" + (dt.getMonth() + 1)).slice(-2);
            if (format == "YYYYMMDD")
                rtDate = dt.getFullYear() + "-" + (month) + "-" + (day);
            else if (format == "DDMMYYYY")
                rtDate = (day) + "-" + (month) + "-" + dt.getFullYear();

            return rtDate;
        }

        function showColumnSelected(id, val) {
            if (val)
                $('#col' + id).show();
            else
                $('#col' + id).hide();

        }

        function showHideColumn(columnid) {
            var isChecked = false;
            var table = $('#' + tableId).DataTable();
            var idx = selectedColumn.indexOf(columnid);
            var hidx = hiddenCoulmn.indexOf(columnid);
            if (idx == -1) {
                table.columns([columnid]).visible(true);
                showColumnSelected(columnid, true);
                selectedColumn.push(columnid);
                hiddenCoulmn.splice(hidx, 1);
                $('#acol' + columnid).css("color", "green");
            }
            else {
                table.columns([columnid]).visible(false);
                showColumnSelected(columnid, false);
                selectedColumn.splice(idx, 1);
                hiddenCoulmn.push(columnid);
                $('#acol' + columnid).css("color", "#007bff");
            }
            $("#" + tableId).width("100%");
        }
        function openAssetChangeStatusModal(assetid, status) {
            sessionStorage.setItem("changestatus_assetid", assetid);
            sessionStorage.setItem("assetStaus", status);
            if (status.toUpperCase() == "Check Out".toUpperCase()) {
                $('.clsCheckOut').removeClass("active");
                $('.clsCheckIn').addClass("active");
                $('.clsCheckOut').addClass("disabled");
            }

            $("#mdlChangeAssetStatus").modal("show");
        }
        function editAssetById(assetid) {
            sessionStorage.setItem("assetIdForEdit", assetid);
            window.location.href = "edit-asset.aspx";
        }
        var AssetRequestStatus = "";
        var AssetRequestAssetId = 0;
        var AssetRequestedBy = "";
        function assetRequestApprove(assetId, RequestedBy) {
            $('#hAssetApproveOrReject').text("Request - Approve");
            $('#btnApproveOrReject').text("Approve");
            $('#mdlAssetApproveOrReject').modal("show");
            AssetRequestAssetId = assetId;
            AssetRequestedBy = RequestedBy;
            AssetRequestStatus = "Approved";
        }
        function assetRequestReject(assetId, RequestedBy) {
            $('#hAssetApproveOrReject').text("Request - Reject");
            $('#btnApproveOrReject').text("Reject");
            $('#mdlAssetApproveOrReject').modal("show");
            AssetRequestAssetId = assetId;
            AssetRequestedBy = RequestedBy;
            AssetRequestStatus = "Rejected";
        }
        function AssetApproveOrReject() {
            if ($('#txtApproveOrRejectRemarks').val() == "") {
                $('#errAssetRequestRemarks').show();
                return false;
            }

            var clsAssetRequest = {
                assetIds: AssetRequestAssetId,
                RequestedBy: AssetRequestedBy,
                requestId: 0,
                assetId: AssetRequestAssetId,
                ApprovedOrRejectedBy: sessionStorage.getItem("UserId"),
                CreatedDateTime: "01/01/1900",
                UpdatedDate: "01/01/1900",
                IsApproved: 1,
                Remarks: $('#txtApproveOrRejectRemarks').val(),
                RequestStatus: AssetRequestStatus
            };
            $.ajax({
                type: "POST",
                url: apiUrl + "Asset/SendAssetRequest",
                dataType: 'json',
                data: clsAssetRequest,
                success: function (response) {
                    Swal.fire({
                        text: 'Request Sent Succesfully!',
                        icon: 'success',
                        showCancelButton: false,
                        showConfirmButton: false,
                        width: "20%",
                        height: "20%",
                        timer: 1500,
                    });
                    window.setTimeout(function () {
                        location.reload();
                    }, 1600);

                },
                failure: function (response) {
                    Swal.fire({
                        text: response.responseText,
                        icon: 'error',
                        showCancelButton: false,
                        showConfirmButton: true
                    });
                }
            });
        }

        var tableId = "";

        function generateTable() {
            var table = '';
            tableId = 'tbl_' + new Date().getTime();
            table = table + '<table id="' + tableId + '" class="table table-drop table-bordered table-hover d-sm-table w-100">';
            table = table + '<thead>';
            table = table + '<tr>';
            table = table + '<th>';
            table = table + '<input type="checkbox" name="chk_All" id="chk_All" onclick="selectAllAssets(this)"/></th>';
            table = table + '<th># </th>';
            table = table + '<th>Tag ID</th>';
            table = table + '<th>Name </th>';
            table = table + '<th>Cost </th>';
            table = table + '<th>Category </th>';
            table = table + '<th>Sub Category </th>';
            table = table + '<th>Purchased From</th>';
            table = table + '<th>Purchased On</th>';
            table = table + '<th>Purchase Type</th>';
            table = table + '<th>Site</th>';
            table = table + '<th>Location</th>';
            table = table + '<th>Department</th>';
            table = table + '<th>Insurance </th>';
            table = table + '<th>Warranty Expiration Date </th>';
            table = table + '<th>Description</th>';
            table = table + '<th>Warranty Details</th>';
            table = table + '<th>Status </th>';
            table = table + '<th>Actions </th>';
            table = table + '</tr>';
            table = table + '</thead>';
            table = table + '<tbody class="assetBody">';

            return table;
        }
        function prepareStatus(){

}
        function loadTable(html) {
            var table = generateTable();
            table = table + html;
            table = table + '</tbody>';
            table = table + '</table>';
            $('.assetTable').html(table);
            var id = '#' + tableId;
            $(id).DataTable({
                "scrollX": true
            });
            $('#divLoader').hide();
            $('#assetCard').show();
            $(id).show();
            var oTable = $(id).DataTable();
            oTable.columns(hiddenCoulmn).visible(false);
            for (var i = 0; i < hiddenCoulmn.length; i++) {
                showColumnSelected(hiddenCoulmn[i], false);
                $('#acol' + hiddenCoulmn[i]).css("color", "#007bff");
            }
            for (var i = 0; i < selectedColumn.length; i++) {
                $('#acol' + selectedColumn[i]).css("color", "green");
            }
        }

        function generateTableBody(result) {
            var html = '';
            $.each(result, function (key, asset) {
                var statusClass = "text-primary";
                if (asset.StatusName.toUpperCase() == "CHECK IN")
                    asset.StatusName = "IN STORAGE";

                var actionHtml = "<td><a href=\"view-ind-asset.aspx?assetId=" + asset.AssetId + "\" class=\"btn-sm\"> <i class=\"far fa-eye text-blue\"></i> </a>";

                if (asset.StatusName.toUpperCase() == "IN STORAGE")
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\" title=\"Edit\" onclick=\"editAssetById(" + asset.AssetId + ")\"> <i class=\"fa fa-edit text-secondary\"></i> </a>";
                else if (asset.StatusName.toUpperCase() == "REQUESTED") {
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\" title=\"Approve\" onclick=\"assetRequestApprove(" + asset.AssetId + "," + asset.RequestedBy + ")\">";
                    actionHtml = actionHtml + "<i class=\"fa fa-thumbs-up text-success  \"  aria-hidden=true></i> </a>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\" title=\"Reject\" onclick=\"assetRequestReject(" + asset.AssetId + "," + asset.RequestedBy + ")\">";
                    actionHtml = actionHtml + "<i class=\"fa fa-thumbs-down text-danger\"  aria-hidden=true></i> </a>";
                }
                if (asset.StatusName.toUpperCase() == "IN STORAGE") {
                    statusClass = "text-primary";
                }
                else if (asset.StatusName.toUpperCase() == "CHECK OUT") {
                    console.log(asset.StatusName.toUpperCase());
                    statusClass = "text-info";
                }
                else if (asset.StatusName.toUpperCase() == "REQUESTED") {
                    statusClass = "text-warning";
                }
                else if (asset.StatusName.toUpperCase() == "APPROVED") {
                    statusClass = "text-success";
                }
                else if (asset.StatusName.toUpperCase() == "REJECTED") {
                    statusClass = "text-muted";
                }
                else
                    statusClass = "text-danger";
                var errorImgUrl = "./../dist/img/assets/laptop.png";
                html += '<tr style="cursor:pointer;hover:green">';
                html += '<td><input type="checkbox" name="chk_' + asset.AssetTagId + '" id="chk_' + asset.AssetTagId + '" /></td>';
                html += '<td>' + (parseInt(key) + 1) + '</td>';
                html += '<td>' + asset.AssetTagId + '</td>';
                html += '<td>' + asset.AssetName + '</td>';
                html += '<td style="text-align:right;">' + asset.AssetCost + '</td>';
                html += '<td>' + asset.CategoryName + '</td>';
                html += '<td>' + asset.SubCategoryName + '</td>';
                html += '<td>' + asset.VendorName + '</td>';
                html += '<td>' + getDate(asset.PurchasedOn, "DDMMYYYY") + '</td>';
                html += '<td>' + asset.PurchasedType + '</td>';
                html += '<td>' + asset.SiteName + '</td>';
                html += '<td>' + asset.LocationName + '</td>';
                html += '<td>' + asset.DepartmentName + '</td>';
                html += '<td>' + asset.InsuranceName + '</td>';
                html += '<td>' + getDate(asset.WarrantyExpirationDate, "DDMMYYYY") + '</td>';
                html += '<td>' + asset.Description + '</td>';
                html += '<td>' + asset.WarrantyDetails + '</td>';
                html += '<td class="' + statusClass + '">' + asset.StatusName + '</td>';
                html += actionHtml;
                html += '</tr>';
            });
            return html;
        }
        var selectedStatusId = 0;       
        function getAssets(statusid) {
            selectedStatusId = statusid;
            $.ajax({
                url: apiUrl + "Asset/getAllAssets",
                type: "GET",
                success: function (result) {
                    debugger;
                    var html = '';
                    if (result.length > 0) {
                        var filterJson = result;
                        if (statusid == 0) {
                            filterJson = result;
                        }
                        else if (statusid == 1) {
                           filterJson = result.filter(function (obj) {
                               return obj.AssetStatusId == statusid || obj.AssetStatusId == 4;
                           });
                        }
                        else {
                            filterJson = result.filter(function (obj) {
                                return obj.AssetStatusId == statusid;
                            });
                        }
                        var body = generateTableBody(filterJson);
                        loadTable(body);                      
                        $('#assetCard').show();
                        $('#no-assets').hide();
                    }
                    else {
                        $('#divLoader').hide();
                        $('#assetCard').show();
                        $('#no-assets').show();
                        $('#frmFilter').hide();
                        $('#column-dropdown').hide();

                    }
                },
                error: function (errormessage) {
                    $('#divLoader').hide();
                    alert(errormessage.responseText);
                }
            });
        }


        $(document).ready(function () {
          
            $("#MainContent_ddlAssetCategories").find("option").eq(0).remove();
            $('#liHomeBreadCrum').show();
            $('#liPageBreadCrum').text("View Assets");
            liPageBreadCrum
            $('#divLoader').show();
            $('#noAssets').hide();
            $('.li-dashboard').removeClass('active');
            $('.li-asset').addClass('active');
            var url = apiUrl;
            $('#divLoader').show();
            //AJAX call to fetch the Data
            debugger;
            if (sessionStorage.getItem("SearchStatusId") != "")
            {
                $('#a' + sessionStorage.getItem("SearchText")).click();
            }
            else
            {
                getAssets(1);
            }
            var dashboardDetails = JSON.parse(sessionStorage.getItem("DashboardDetails"))[0];
            $('#cntInStorage').html(dashboardDetails.InStorageAssetsCount);
            $('#cntRequested').html(dashboardDetails.TotalRequestedCount);
            $('#cntCheckOut').html(dashboardDetails.ChecoutAssetsCount);
            $('#cntMaintenance').html(dashboardDetails.MaintenanceAssetsCount);
            $('#cntDisposed').html(dashboardDetails.DisposeAssetsCount);
            $('#cntDamage').html(dashboardDetails.BrokenAssetsCount);
            $('#cntLost').html(dashboardDetails.LossAssetsCount);
            $('#cntAll').html(dashboardDetails.TotalAssetsCount);
            getCategories();
            getSubCategories();
            getSites();
            getLocations();
            getDepartments();
            getAllVendors();
            getPurchasedTypes();
            getInsurancePolicies();
            getAssetStatus();
            $('.js-example-basic-multiple').select2({
                allowClear: true,
                width: 300,
                closeOnSelect: false
            });

            $("#asset-filter").on('click', function (e) {
                e.preventDefault();
                var tagId = $("#MainContent_ddlAssetTagIdType").val().join();
                var categoryId = $("#MainContent_ddlAssetCategories").val().join();
                var subCategoryId = $("#MainContent_ddlSubCategories").val().join();
                var siteId = $("#MainContent_ddlAssetSites").val().join();
                var locationId = $("#MainContent_ddlLocations").val().join();
                var departmentId = $("#MainContent_ddlDepartments").val().join();
                var vendorId = $("#MainContent_ddlVendor").val().join();
                var purchasedTypeId = $("#MainContent_ddlPurchasedType").val().join();
                var insuranceId = $("#MainContent_ddlAssetInsurance").val().join();

                var obj = new Object();
                obj.tagId = tagId == "" ? "0" : tagId;
                obj.categoryId = categoryId == "" ? "0" : categoryId;
                obj.subCategoryId = subCategoryId == "" ? "0" : subCategoryId;
                obj.siteId = siteId == "" ? "0" : siteId;
                obj.locationId = locationId == "" ? "0" : locationId;
                obj.departmentId = departmentId == "" ? "0" : departmentId;
                obj.vendorId = vendorId == "" ? "0" : vendorId;
                obj.purchasedTypeId = purchasedTypeId == "" ? "0" : purchasedTypeId;
                obj.insuranceId = insuranceId == "" ? "0" : insuranceId;
                obj.statusId = selectedStatusId;
                var flag = false;
                if (tagId != "")
                    flag = true;
                else if (categoryId != "")
                    flag = true;
                else if (subCategoryId != "")
                    flag = true;
                else if (siteId != "")
                    flag = true;
                else if (locationId != "")
                    flag = true;
                else if (departmentId != "")
                    flag = true;
                else if (vendorId != "")
                    flag = true;
                else if (purchasedTypeId != "")
                    flag = true;
                else if (insuranceId != "")
                    flag = true;

                if (flag) {
                    $('.assetTable').empty();
                    $.ajax({
                        url: apiUrl + "Asset/getAllAssetsByFilter",
                        type: "POST",
                        dataType: 'json',
                        data: obj,
                        success: function (result) {
                            var html = '';
                            if (result.length > 0) {
                                var body = generateTableBody(result);
                                loadTable(body);
                                $('#no-assets-filter').hide();
                            }
                            else {
                                $('#divLoader').hide();
                                $('#no-assets-filter').show();
                            }
                            $('#assetCard').show();
                        },
                        error: function (errormessage) {
                            $('#divLoader').hide();
                            alert(errormessage.responseText);
                        }
                    });
                }
                else
                    alert("Choose values for filtering asset");
            })

            $("#clear-filter").on('click', function (e) {
                e.preventDefault();
                $("#MainContent_ddlAssetTagIdType").select2("val", "");
                $("#MainContent_ddlAssetCategories").select2("val", "");
                $("#MainContent_ddlSubCategories").select2("val", "");
                $("#MainContent_ddlAssetSites").select2("val", "");
                $("#MainContent_ddlLocations").select2("val", "");
                $("#MainContent_ddlDepartments").select2("val", "");
                $("#MainContent_ddlVendor").select2("val", "");
                $("#MainContent_ddlPurchasedType").select2("val", "");
                $("#MainContent_ddlAssetInsurance").select2("val", "");
                $('#no-assets-filter').hide();
                getAssets(1);
            });
          
        });
        function statuschange() {
            //$(this).parents(".table-responsive").toggleClass("res-drop");
        }

      
    </script>
</asp:Content>

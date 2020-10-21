<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="assets-list.aspx.cs" Inherits="AMS_V1.assets_list" %>
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
                        <h5><b id="hdTitle"></b></h5>
                    </div>
                    <div class="col-md-6 text-center text-sm-right p-0">
                        <div class="clearfix">                          
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
                <div class="assetTable mt-4 table-responsive"></div>
            </div>
        </div>
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
        function editAssetById(assetid) {
            sessionStorage.setItem("assetIdForEdit", assetid);
            window.location.href = "edit-asset.aspx";
        }
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
                        var url = location.search;
                        var query = url.substr(1);
                        var paramresult = {};
                        query.split("&").forEach(function (part) {
                            var item = part.split("=");
                            paramresult[item[0]] = decodeURIComponent(item[1]);
                        });
                        var filtervalue = paramresult.filtervalue;
                    

                        if (filtervalue == "expiringwarranty") {
                            $('#hdTitle').text("Warranty Going to Expire");
                            filterJson = result.filter(function (obj) {
                                return obj.IsWarrantyExpired == 1;
                            });
                        }
                        else if (filtervalue == "expiringinsurance") {
                            $('#hdTitle').text("Insurance Going to Expire");
                            filterJson = result.filter(function (obj) {
                                return obj.IsInsuranceExpired == 1;
                            });
                        }
                        else if (filtervalue == "checkin") {
                            $('#hdTitle').text("Check In Overdue");
                            filterJson = result.filter(function (obj) {
                                return obj.IsCheckInExpired == 1;
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
            var url = apiUrl;
            $('#divLoader').show();
            //AJAX call to fetch the Data
            debugger;
           
            getAssets(1);                  
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
    </script>
</asp:Content>

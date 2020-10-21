
<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="view-ind-asset.aspx.cs" Inherits="AMS_V1.ViewAsset" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <script src="../Scripts/custom.js"></script>
    <style>
        .asset{
            font-weight:600;
            font-size:14px;
        }
       .dropdown-menu>li{
           cursor:pointer !important;

       }
        .dropdown-menu>li:hover{
            background-color:#437cae;
            color:#fff;
        }
        .table td, .table th {
            border:none !important;
        }
    </style>
    <div class="card">
        <div class="card-body col-form-label-right">
            <div class="pb-2 border-bottom mb-3 row">
                <div class="col-md-10">
                      <h4><b>View Asset </b></h4>
                </div>
               <div class="title-action-btn btn-group open">
                <button type="button" class="btn btn-circle blue-madison dropdown-toggle " data-toggle="dropdown">Change Status <span class="caret"></span></button>
                <ul class="dropdown-menu" role="menu" style="border-radius:0px !important;top: -3px;min-width: 140px;border: 1px solid #437cae;">
                            <li style="padding: 5px 6px;display:none" id="liCheckOut" onclick="openAssetChangeStatusModal('Check Out')"><i class="fas fa-arrow-alt-circle-right"></i>&nbsp; Check out</li>
                            <li style="padding: 5px 6px;display:none" id="liCheckIn" onclick="openAssetChangeStatusModal('Check In')"><i class="fas fa-arrow-alt-circle-left"></i>&nbsp; Check In</li>                    
                            <li style="padding: 5px 6px;display:none" id="liMaintenance" onclick="openAssetChangeStatusModal('Maintenance')"><i class="fa fa-wrench"></i>&nbsp; Maintenance</li>   
                            
                            <li style="padding: 5px 6px;display:none" id="liLost" onclick="openAssetChangeStatusModal('Lost')"><i class="fa fa-thumbs-down"></i>&nbsp; Lost</li>
                            <li style="padding: 5px 6px;display:none" id="liFound" onclick="openAssetChangeStatusModal('Found')"><i class="fa fa-thumbs-up"></i>&nbsp; Found</li>                      
                            <li style="padding: 5px 6px;display:none" id="liDamage" onclick="openAssetChangeStatusModal('Damage')"><i class="fa fa-unlink"></i>&nbsp;  Damage</li>                                            
                            <li style="padding: 5px 6px;display:none" id="liRepaired" onclick="openAssetChangeStatusModal('Repaired')"><i class="fa fa-link"></i>&nbsp;  Repaired</li>
                            <li style="padding: 5px 6px;display:none" id="liDispose" onclick="openAssetChangeStatusModal('Dispose')"><i class="fa fa-recycle"></i>&nbsp;  Dispose</li>  
                </ul>
            </div>

              <%--<div class="col-md-2 pull-right">
                   <a href="change-asset-status.aspx" id="changeAssetStatus" class="btn btn-info btn-sm" style="display:none;">Change Asset Status</a>
             </div>--%>

            </div>
            <div class="row">
                <div class="col-sm-3">
                    <div class="form-group" id="divAssetImage" style="margin-top: 15%;display:none;">
                    <img src="" width="160" class="img-fluid mx-auto d-flex"  id="AssetImage"
                            onerror="this.onerror=null;this.src='/../dist/img/assets/laptop.png'"/>

                    </div>

                </div>
                   <div class="col-sm-3">

                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Asset Tag ID  </label>
                        <p id="AssetTagId" class="asset"></p>
                    </div>
                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Asset Name  </label>
                        <p id="AssetName" class="asset"></p>
                    </div>
                     <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Status</label>
                        <p id="StatusName" class="asset"></p>
                    </div>
                      <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Asset Type  </label>
                        <p  id="AssetType" class="asset"></p>
                    </div>
                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Asset Cost  </label>
                       <p  id="AssetCost" class="asset"></p>
                    </div>
                </div>
                <div class="col-sm-3">

                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Category </label>
                        <p  id="CategoryName" class="asset"></p>
                    </div>
                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Sub Category </label>
                        <p  id="SubCategoryName" class="asset"></p>
                    </div>
                     <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Site </label>
                         <p  id="SiteName" class="asset"></p>
                    </div>
                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Department </label>
                         <p  id="LocationName" class="asset"></p>
                    </div>
                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Location  </label>
                        <p  id="DepartmentName" class="asset"></p>
                    </div>

                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Purchased On </label>
                        <p  id="PurchasedOn" class="asset"></p>
                    </div>
                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Purchase Type </label>
                         <p  id="PurchasedType" class="asset"></p>
                    </div>
                    <div class="form-group">
                        <label class="f-w-400 text-muted mb-0">Description   </label>
                        <p  id="Description" class="asset"></p>
                    </div>
                </div>
            </div>
            <div class="">
                <div class="nav nav-tabs nav-tabs-2">
                    <a class="nav-item nav-link active" id="tab-0-tab" href="#tab-0" data-toggle="tab" >Global Fields</a>
                    <a class="nav-item nav-link"  href="#tab-1" id="tab-1-tab" data-toggle="tab" onclick="getAssets(9)"> Custom Fields <sup class="badge badge-primary" id="cntRequested"></sup></a>
                    <a class="nav-item nav-link"   href="#tab-2" id="tab-2-tab" data-toggle="tab">Insurance</a>
                    
                    <a class="nav-item nav-link"   href="#tab-3" id="tab-3-tab" data-toggle="tab" onclick="getAssets(4)">Warranty <sup class="badge badge-dark" id="cntMaintenance"></sup></a>
                   
               
                 </div>




              <%--  <div class="nav-tabs-wrapper w-100">
                    <ul class="nav custom-tabs nav-tabs" id="tabs-title-nav-tabs" role="tablist">
                        <li class="nav-item" id="liGlobalFields">
                            <a class="nav-link active" data-toggle="tab" role="tab" href="#tab-0" aria-selected="false" aria-controls="tab-0" id="tab-0-tab"> Global Fields </a>
                        </li>
                        <li class="nav-item" id="liCustomFields">
                            <a class="nav-link" data-toggle="tab" role="tab" href="#tab-1" aria-selected="false" aria-controls="tab-1" id="tab-1-tab" >Custom Fields </a>
                        </li>
                        <li class="nav-item" id="liInsurance">
                            <a class="nav-link" data-toggle="tab" role="tab" href="#tab-2" aria-selected="false" aria-controls="tab-2" id="tab-2-tab">Insurance </a>
                        </li>
                        <li class="nav-item" id="liWarranty">
                            <a class="nav-link" data-toggle="tab" role="tab" href="#tab-3" aria-selected="false" aria-controls="tab-3" id="tab-3-tab">Warranty </a>
                        </li>
                    </ul>
                </div>--%>
                <div class="card w-100">
                    <div style="padding:2%;">
                        <div class="tab-content w-100">
                            <div id="tab-0" class="tab-pane active" role="tabpanel" aria-labelledby="tab-0-tab">
                                 <table class="table" id="tblAssetGlobalFieldsForView">
                                             <tbody class="globalFieldsBodyView">
                                             </tbody>
                                 </table>
                                <div id="no-records-global-field" style="display:none">No global fields found</div>
                            </div>
                            <div id="tab-1" class="tab-pane" role="tabpanel" aria-labelledby="tab-1-tab">
                                  <table class="table" id="tblAssetCustomFieldsForView">
                                             <tbody class="customFieldsBodyView">
                                             </tbody>
                                 </table>
                            </div>
                            <div id="tab-2" class="tab-pane" role="tabpanel" aria-labelledby="tab-2-tab">
                                <div class="row">
                                   <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Company  </label>
                                        <p  id="insuranceCompany" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Policy Name </label>
                                        <p  id="policyName" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Policy Number </label>
                                         <p  id="policyNumber" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Coverage Amount  </label>
                                        <p  id="coverageAmount" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Start Date  </label>
                                        <p  id="startDate" class="asset"></p>
                                    </div>
                                     <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">End Date </label>
                                        <p  id="endDate" class="asset"></p>
                                    </div>
                                     <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Premium  </label>
                                        <p  id="premium" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Contact Person  </label>
                                        <p  id="contactPerson" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Contact Number  </label>
                                        <p  id="contactNumber" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Contact Email  </label>
                                        <p  id="contactEmail" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Description  </label>
                                        <p  id="description" class="asset"></p>
                                    </div>
                                    </div>
                            </div>
                            <div id="tab-3" class="tab-pane" role="tabpanel" aria-labelledby="tab-3-tab">
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Years </label>
                                        <p  id="WarrantyYears" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Months </label>
                                         <p  id="WarrantyMonths" class="asset"></p>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Days  </label>
                                        <p  id="WarrantyDays" class="asset"></p>
                                    </div>
                                     <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Expiration Date  </label>
                                        <p  id="WarrantyExpirationDate" class="asset"></p>
                                    </div>
                                     <div class="form-group col-md-2">
                                        <label class="f-w-400 text-muted mb-0">Details  </label>
                                        <p  id="WarrantyDetails" class="asset"></p>
                                    </div>
                                      <div class="col-md-1"></div>
                                </div>
                            </div>
                            <div id="tab-4" class="tab-pane" role="tabpanel" aria-labelledby="tab-4-tab">
                                <p> <b> Asset Depreciation tab  </b> Lorem Ipsum is simply dummy text of the printing and typesetting industry. </p>
                            </div>
                        </div>
                    </div>
                </div>
        </div>

            <a class="btn btn-primary float-left" type="button" href="view-assets.aspx"> <i class="fas fa-arrow-left"></i>  Back </a>
    </div>
 </div>
      <div>
        <% Response.WriteFile("change-asset-status.html"); %>
    </div>
    <script type="text/javascript">
        var apiUrl = "http://localhost:57080/api/";
        var assetIdForIndView = 0;
        var customFields = [];
        var globalFields = [];
        function getAssetIdFromParam() {
            debugger;
            url = location.search;
            var query = url.substr(1);
            var result = {};
            query.split("&").forEach(function (part) {
                var item = part.split("=");
                result[item[0]] = decodeURIComponent(item[1]);
            });
            assetIdForIndView = result.assetId;
            var assetIds = [];
            var uniqueIds = [];
            assetIds.push(assetIdForIndView);
            uniqueIds.push(0);
            getCustomFields();
            getGlobalFields();
            getAssetDetailsById(assetIdForIndView);
        }
        function getGlobalFields() {
            $.ajax({
                url: apiUrl + "Asset/getAssetGlobalFieldsMapping?assetId=" + assetIdForIndView,
                type: "GET",
                success: function (result) {
                    debugger;
                    if (result.length > 0) {
                        globalfields = result;
                        var html = '';
                        var counter = (result.length > 3) ? Math.round(result.length / 3) : result.length;

                        for (var idx = 0; idx < result.length;) {
                            html += '<tr class="ui-require" id="tr_' + (idx + 1).toString() + '">';
                            html += '<td class="p-0"><div class="row">';
                            if ((idx + counter) > result.length)
                                counter = result.length - counter;
                            else
                                counter = idx + counter;
                            for (var j = 0; j < counter; j++) {
                                var fieldId = "txtGlobalFiled_" + (idx + 1);
                                html += '<div class="form-group col-md-3">';
                                html += '<label class="f-w-400 text-muted mb-0">' + result[idx].FieldName + '</label>';
                                html += '<p class="asset">' + result[idx].Value + '</p>';
                                html += '</div>';
                                idx++;
                            }
                            html += '</div></td></tr>';
                        }
                        $('.globalFieldsBodyView').html(html);
                        $("#tblAssetGlobalFieldsForView").show();
                        $("#no-records-global-field").hide();
                    }
                    else {
                       // $("#tblAssetGlobalFieldsForView").hide();
                       // $("#no-records-global-field").show();
                      //  $('#liGlobalFields').hide();
                       // $('#tab-0-tab').removeClass('active');

                       // $('#tab-1-tab').addClass('active');
                       // $('#tabs-title-nav-tabs a[href="#tab-1-tab"]').trigger('click');
                        //$('#tab-1-tab').click();
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
        }

        function getCustomFields() {
            $.ajax({
                url: apiUrl + "Asset/getAssetCustomDetails?assetId=" + assetIdForIndView,
                type: "GET",
                success: function (result) {
                    debugger;
                    if (result.length > 0) {
                        customFields = result;
                        var html = '';
                        var counter = (result.length > 3) ? Math.round(result.length / 3) : result.length;

                        for (var idx = 0; idx < result.length;) {
                            html += '<tr class="ui-require" id="tr_' + (idx + 1).toString() + '">';
                            html += '<td class="p-0"><div class="row">';
                            if ((idx + counter) > result.length)
                                counter = result.length - counter;
                            else
                                counter = idx + counter;
                            for (var j = 0; j < counter; j++) {
                                var fieldId = "txtGlobalFiled_" + (idx + 1);
                                html += '<div class="form-group col-md-3">';
                                html += '<label class="f-w-400 text-muted mb-0">' + result[idx].CustomFieldName + '</label>';
                                html += '<p class="asset">' + result[idx].CustomFieldValue + '</p>';
                                html += '</div>';
                                idx++;
                            }
                            html += '</div></td></tr>';
                        }
                        $('.customFieldsBodyView').html(html);
                    }
                    else {
                       /// $('#liCustomFields').hide();
                       // $('#liInsurance').addClass('active');
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
        }

        function getInsuranceDetails(insuranceId) {

            $.ajax({
                url: apiUrl + "Asset/getAssetInsurancePolicies?insuranceId=" + insuranceId,
                type: "GET",
                success: function (result) {
                    if (result.length > 0) {
                        policyDetails = result[0];
                        console.log(result);
                        $('#policyName').text(policyDetails.policyName);
                        $('#policyNumber').text(policyDetails.policyNumber);
                        $('#insuranceCompany').text(policyDetails.insuranceCompany);
                        $('#startDate').text(formatDateTime(policyDetails.startDate));
                        $('#endDate').text(formatDateTime(policyDetails.endDate));
                        $('#premium').text(policyDetails.premium);
                        $('#coverageAmount').text(policyDetails.coverageAmount);
                        $('#contactPerson').text(policyDetails.contactPerson == "" ? "--" : policyDetails.contactPerson);
                        $('#contactNumber').text(policyDetails.contactNumber == "" ? "--" : policyDetails.contactNumber);//.text(policyDetails.contactNumber);
                        $('#contactEmail').text(policyDetails.contactEmail == "" ? "--" : policyDetails.contactEmail);//.text(policyDetails.contactNumber);
                        $('#description').text(policyDetails.description == "" ? "--" : policyDetails.description);//.text(policyDetails.contactNumber);
                    }
                    else {
                       // $('#liInsurance').hide();
                       // $('#liWarranty').addClass('active');
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
        }
        $(document).ready(function () {
            if (sessionStorage.getItem("LoggedInRole") == "Asset Admin") {
                $('#changeAssetStatus').show();
            }
            else {
                $('#changeAssetStatus').hide();
            }
            $('.li-dashboard').removeClass('active');
            $('.li-asset').addClass('active');
            getAssetIdFromParam();

        });
        function formatDateTime(input) {
            var date = input;
            date = date.replace('T', ' ').split('.')[0].split(' ')[0].split('-');
            return date[2] + "/" + date[1] + "/" + date[0];
        };
        function prepareStatus(statusName) {
            $('#liCheckOut').hide();
            $('#liMaintenance').hide();
            $('#liLost').hide();
            $('#liDamage').hide();
            $('#liDispose').hide();
            $('#liFound').hide();
            $('#liRepaired').hide();
            if (statusName == "In Storage" || statusName == "Check In")
            {
                $('#liCheckOut').show();
                $('#liMaintenance').show();
                $('#liLost').show();
                $('#liDamage').show();
                $('#liDispose').show();
            }
            else if (statusName == "Check Out") {
                $('#liCheckIn').show();
                $('#liMaintenance').show();
                $('#liLost').show();
                $('#liDamage').show();
                $('#liDispose').show();
            }
            else if (statusName == "Maintenance") {               
                $('#liRepaired').show();
                $('#liLost').show();
                $('#liDamage').show();
                $('#liDispose').show();
            }
            else if (statusName == "Damage") {
                $('#liMaintenance').show();
                $('#liDispose').show();
            }
            else if (statusName == "Lost") {               
                $('#liFound').show();
            }          
        }
        function getAssetDetailsById(assetId) {
            //AJAX call to fetch the Data
            $.ajax({
                url: apiUrl + "Asset/getAssetDetail?assetId=" + assetId,
                type: "GET",
                success: function (result) {
                    debugger;
                    if (result.length > 0) {
                    
                        console.log(result[0]);
                        var assetDetail = result[0];
                        $('#AssetImage').attr('src', "../AssetImages/" + assetDetail.AssetId + ".png");
                        $('#AssetTagId').text(assetDetail.AssetTagId);
                        $('#AssetName').text(assetDetail.AssetName);
                        $('#StatusName').text(assetDetail.StatusName);
                        $('#AssetType').text(assetDetail.AssetType);
                        $('#AssetCost').text(assetDetail.AssetCost);
                        $('#CategoryName').text(assetDetail.CategoryName == "" ? "--" : assetDetail.CategoryName);
                        $('#SubCategoryName').text(assetDetail.SubCategoryName == "" ? "--" : assetDetail.SubCategoryName);
                        $('#SiteName').text(assetDetail.SiteName == "" ? "--" : assetDetail.SiteName);
                        $('#LocationName').text(assetDetail.LocationName == "" ? "--" : assetDetail.LocationName);
                        $('#DepartmentName').text(assetDetail.DepartmentName == "" ? "--" : assetDetail.DepartmentName);
                        $('#PurchasedOn').text(assetDetail.PurchasedOn == "" ? "--" : formatDateTime(assetDetail.PurchasedOn));
                        $('#PurchasedType').text(assetDetail.PurchasedType == "" ? "--" : assetDetail.PurchasedType);
                        $('#Description').text(assetDetail.Description == "" ? "--" : assetDetail.Description);
                        $('#WarrantyYears').text(assetDetail.WarrantyYears == "" ? "--" : assetDetail.WarrantyYears);
                        $('#WarrantyMonths').text(assetDetail.WarrantyMonths == "" ? "--" : assetDetail.WarrantyMonths);
                        $('#WarrantyDays').text(assetDetail.WarrantyDays == "" ? "--" : assetDetail.WarrantyDays);
                        $('#WarrantyExpirationDate').text(formatDateTime(assetDetail.WarrantyExpirationDate) == "01/01/1900" ? "--" : formatDateTime(assetDetail.WarrantyExpirationDate));
                        $('#WarrantyDetails').text(assetDetail.WarrantyDetails == "" ? "--" : assetDetail.WarrantyDetails);
                        $('#divAssetImage').show();
                        prepareStatus(assetDetail.StatusName);
                        if (assetDetail.InsuranceId > 0)
                            getInsuranceDetails(1);
                    }
                    else {
                        $('#divLoader').hide();
                        $('#assetCard').show();
                        $('#noAssets').show();
                    }
                },
                error: function (errormessage) {
                    $('#divLoader').hide();
                    alert(errormessage.responseText);
                }
            });
        }
      
        function openAssetChangeStatusModal(assetChangeStatus) {            
            if (assetChangeStatus == "Maintenance") {
                $("#assetMaintenanceModel").modal("show");
            }
            else if (assetChangeStatus == "Dispose" || assetChangeStatus == "Damage" || assetChangeStatus == "Lost") {
                if (assetChangeStatus == "Dispose")
                    sessionStorage.setItem("ChangeStatusId", 6);
                else if (assetChangeStatus == "Damage")
                    sessionStorage.setItem("ChangeStatusId", 8);
                else if (assetChangeStatus == "Loss")
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
    </script>
</asp:Content>

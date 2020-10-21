<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="asset-inventory-check.aspx.cs" Inherits="AMS_V1.Views.asset_inventory_check" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      <script src="../Scripts/filter.js"></script>
     <link href="//cdnjs.cloudflare.com/ajax/libs/select2/4.0.0/css/select2.css" rel="stylesheet" />
    <script src="//cdnjs.cloudflare.com/ajax/libs/select2/4.0.0/js/select2.js"></script>
     <style>
        .asset{
            font-weight:600;
            font-size:14px;
        }        
        .custom-tabs.nav-tabs .nav-link.active {
            border-bottom: 3px solid #007bff !important;
        }
        .card-header{
            background-color:#007bff !important;
            padding:0 !important;
            color:white;
        }
         .afont {
            font-size: 14px !important;
            font-weight: 600 !important;
            padding: 20px !important;
        }

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

        h5 {
            font-weight: bolder;
        }
        .mtprow {
            margin-top: -10px;
            margin-bottom: -10px;
        }
    </style>
    <div class="content">
        <div class="card-body bg-white">
            <div class="nav-tabs-wrapper w-100">
                <div class="nav nav-tabs nav-tabs-2" id="tabs-title-region-nav-tabs" role="tablist">
                    <a class="nav-item nav-link active" data-toggle="tab" role="tab" href="#tab-0" aria-selected="false" aria-controls="tab-0" id="tab-0-tab" onclick="getAllAssetsForCheckin(1)">Assets in Person </a>
                    <a class="nav-item nav-link" data-toggle="tab" role="tab" href="#tab-1" aria-selected="false" aria-controls="tab-1" id="tab-1-tab" onclick="getAllAssetsForCheckin(2)">Assets in Site </a>
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
                                        <button class="btn btn-primary btn-sm" id="asset-inventory-check-filter" style="margin-right: 18px;" onclick="saveAssetForInventoryCheck()">Apply Filter</button>
                                        <button class="btn btn-danger btn-sm" id="clear-filter" style="margin-right: 18px;">Clear Filter</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
             <div class="card w-100 mt-5" >
                   <div class="tab-content w-100 p-3" style="border: 1px solid #ccc;">
                        <div id="tab-0" class="tab-pane active" role="tabpanel" aria-labelledby="tab-0-tab">
                            <table class="table table-bordered table-hover table-responsive d-sm-table" id="tblCheckinAssetsPerson" style="display: none;">
                                <thead>
                                    <tr>
                                        <th># </th>
                                        <th>Tag Id</th>
                                        <th>Asset Name</th>
                                        <th>Person Name</th>
                                        <th>Checkout Date </th>
                                        <th>Due Date </th>
                                    </tr>
                                </thead>
                                <tbody class="bodyCheckinAssetsPerson">
                                </tbody>
                            </table>
                        </div>
                        <div id="tab-1" class="tab-pane" role="tabpanel" aria-labelledby="tab-1-tab">
                            <table class="table table-bordered table-hover  table-responsive d-sm-table" id="tblCheckinAssetsSite" style="display: none;">
                                <thead>
                                    <tr>
                                        <th># </th>
                                        <th>Tag Id</th>
                                        <th>Asset Name</th>
                                        <th>Site</th>
                                        <th>Location</th>
                                        <th>Department</th>
                                        <th>Checkout Date </th>
                                        <th>Due Date </th>
                                    </tr>
                                </thead>
                                <tbody class="bodyCheckinAssetsSite">
                                </tbody>
                            </table>
                        </div>
                    </div>
             </div>
        </div>
    </div>
    <script>

        $(document).ready(function () {
            $("#MainContent_ddlAssetCategories").find("option").eq(0).remove();
            $('#liHomeBreadCrum').show();
            $('#liPageBreadCrum').text("View Assets");
            liPageBreadCrum
            $('#divLoader').show();
            $('#noAssets').hide();
            $('.li-dashboard').removeClass('active');
            $('.li-asset-inventory-check').addClass('active');
            var url = apiUrl;
            $('#divLoader').show();
            
            //AJAX call to fetch the Data
            //getAssets();
            getCategories();
            getSubCategories();
            getSites();
            getLocations();
            getDepartments();
            getAllVendors();
            getPurchasedTypes();
            getInsurancePolicies();
            getAllAssetsForCheckin(1);
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
                        url: apiUrl + "Asset/getAllAssetsByFilterForInventoryCheck",
                        type: "POST",
                        dataType: 'json',
                        data: obj,
                        success: function (result) {
                            resCCNOList = result;
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
                getAssets();
            });
        });
    </script>
</asp:Content>

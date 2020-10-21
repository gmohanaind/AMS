<%@ Page Async="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="edit-asset.aspx.cs" Inherits="AMS_V1.Views.edit_asset"  EnableEventValidation="false"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <script src="../Scripts/custom.js"></script>
    <style>
        .disabled{
            pointer-events: none;
            cursor:not-allowed;
        }
        .circle {
            border-radius: 50%;
            width: 38px;
            height: 36px;
            background-color: rgb(44, 108, 128);
            position: relative;
        }
        .btn_red:hover, .btn_red:focus, .btn_red:active, .btn_red.active, .open > .dropdown-toggle.btn_red,
        .modal .modal-footer .btn_red:hover, .modal .modal-footer .btn_red:focus, .modal .modal-footer .btn_red:active {
            color: #fff;
            background-color: #c03c38;
            border-color: #ac2925;
            border-radius: 0;
            font-family: 'Open Sans', sans-serif;
        }
        .card-header{
            padding:4px !important;
        }

        .btn.btn-circle, .btn.btn-circle:active, .btn.btn-circle:hover, .btn.btn-circle:focus {
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
        }

        .btn_green {
            color: #fff !important;
            background-color: #5cb85c;
            font-family: 'Open Sans', sans-serif !important;
        }

        .btn_red {
            color: #34495e;
            background-color: transparent;
            border-color: #d73925;
            border: 1px solid #d73925;
            font-family: 'Open Sans', sans-serif;
        }

    </style>
    <div class="card">
       
        <form class="form-horizontal" runat="server" id="frmEditAsset">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>          
            <div class="card-body col-form-label-right">
                <div class="pb-2 border-bottom mb-3">
                    <div class="col-md-6">
                        <h5> Edit Asset </h5>
                    </div>
                    <div class="col-md-6 text-right">
                    </div>
                </div>
                <div id="asset-sec">
                    <div class="card">
                        <div class="card-header" id="asset-sec-heading-1">
                            <h5 class="mb-0">
                                <a class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#asset-sec-collapse-1" aria-expanded="false" aria-controls="asset-sec-collapse-1">Asset Details
                                   <i class="fa float-right" aria-hidden="true"></i>
                                </a>
                            </h5>
                        </div>
                        <div id="asset-sec-collapse-1" class="collapse show" aria-labelledby="asset-sec-heading-1" data-parent="#asset-sec">
                            <div class="card-body">
                                <div class="row">
                                      <div class="col-md-2">
                                        <label for="assetType" class="col-form-label">Tag ID Type<sup class="text-red">* </sup> </label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlTagIdType"  name="ddlTagIdType" runat="server" CssClass="form-control" Enabled="false">
                                                     <asp:ListItem Value="">-- Select --</asp:ListItem>
                                                    <asp:ListItem Value="1">Auto Increment</asp:ListItem>
                                                    <asp:ListItem Value="2">Custom</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                             <input type="hidden" id="hdnAssetIdForEdit" name="hdnAssetIdForEdit" class="hdnAssetIdForEdit"  runat="server" value="1"/>
                                    </div>

                                    <div class="col-md-2">
                                        <label for="assetTagId" class="col-form-label">Tag ID <sup class="text-red">* </sup></label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                               <input type="text" class="form-control" id="assetTagId" name="assetTagId" placeholder="Enter asset tag ID" runat="server" readonly>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="assetName" class="col-form-label">Name </label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <input type="text" class="form-control" id="assetName" name="assetName" placeholder="Asset name" required runat="server" autocomplete="off">
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-4">
                                        <label for="assetCost" class="col-form-label">Cost </label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <input type="text" class="form-control" id="assetCost" name="assetCost" runat="server" placeholder="Asset cost" required />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="assetType" class="col-form-label">Asset Type </label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetTypes" name="ddlAssetTypes"  runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                      <div class="col-md-4">
                                        <label for="categories" class="col-form-label">Category</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetCategories" name="ddlAssetCategories" runat="server" CssClass="form-control ddlAssetCategories">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-sm-2">
                                                <span class="addnew" onclick="openCategoryAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="assetType" class="col-form-label">Sub Category</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlSubCategories" name="ddlSubCategories" runat="server" CssClass="form-control ddlSubCategories">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-sm-2">
                                                <span class="addnew" onclick="openSubCategoryAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>                                  
                                    <div class="col-md-4">
                                        <label for="purchasedFrom" class="col-form-label">Purchased From</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlVendor" name="ddlVendor" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-sm-2">
                                                <span class="addnew"  onclick="openVendorAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="purchasedOn" class="col-form-label">Purchased On </label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <input type="date" id="purchasedOn" name="purchasedOn" runat="server" class="form-control" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="purchaseType" class="col-form-label">Purchase Type</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlPurchasedType" name="ddlPurchasedType" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-sm-2">
                                                <span class="addnew"  onclick="openPurchaseTypeAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                         <div class="col-md-4">
                                        <label for="site" class="col-form-label">Site</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetSites" name="ddlAssetSites" runat="server" CssClass="form-control ddlAssetSites" >
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-sm-2">
                                                <span class="addnew" onclick="openSiteAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="location" class="col-form-label">Location</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetLocations" name="ddlAssetLocations" runat="server" CssClass="form-control ddlAssetLocations">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-sm-2">
                                                <span class="addnew" onclick="openLocationAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="department" class="col-form-label">Department</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetDepartments" name="ddlAssetDepartments" runat="server" CssClass="form-control ddlAssetDepartments">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-sm-2">
                                                <span class="addnew" onclick="openDepartmentAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <label for="insurance" class="col-form-label">Insurance</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetInsurance" name="ddlAssetInsurance" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-sm-2">
                                                <span class="addnew" onclick="openInsurationAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="warrantdays" class="col-form-label">Warranty</label>
                                        <div class="form-group row">
                                            <div class="col-sm-4">
                                                <input type="number" name="txtWarrantyYears" id="txtWarrantyYears"
                                                    class="form-control" placeholder="Years" runat="server" min="0"/>
                                            </div>
                                            <div class="col-sm-3">
                                                <input type="number" name="txtWarrantyMonths" id="txtWarrantyMonths"
                                                    class="form-control" placeholder="Months"  runat="server"  min="0"/>
                                            </div>
                                            <div class="col-sm-3">
                                                <input type="number" name="txtWarrantyDays" id="txtWarrantyDays"
                                                     class="form-control" placeholder="Days"  runat="server"  min="0"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="desc" class="col-form-label">Warranty Expiration Date </label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <input type="date" id="txtWarrantyExpiry" name="txtWarrantyExpiry" class="form-control"  runat="server"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="description" class="col-form-label">Asset Description</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <textarea class="form-control" id="description" name="description" rows="2" placeholder="Description" runat="server"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="warrantyDetails" class="col-form-label">Warranty Details</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <textarea class="form-control" id="warrantyDetails" name="warrantyDetails" rows="2" placeholder="About Warranty" runat="server"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="assetImg" class="col-form-label">Asset Image</label>
                                        <div class="form-group row">
                                              <div class="col-sm-12">
                                                 <img src="" width="160" class="img-fluid mx-auto d-flex"  id="AssetImage"
                                                onerror="this.onerror=null;this.src='/../dist/img/assets/laptop.png'"/>                                              
                                              </div>
                                              <div class="col-sm-12">                                                
                                                  <div class="custom-file">
                                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    
                                   <div class="col-md-12 text-right mt-3">
                                        <asp:Button ID="btnUpdateAssetDetails" CssClass="btn btn-primary" runat="server" Text="Update" OnClick="udpateAssetDetails"></asp:Button>
                                        
                                   </div>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                 <div class="card" id="divGlobalFields" style="display:none;">
                    <div class="card-header" id="asset-sec-heading-3">
                        <h5 class="mb-0">
                            <a class="btn btn-link collapsed text-left w-100" data-toggle="collapse" 
                                data-target="#asset-sec-collapse-3" aria-expanded="false"
                                 aria-controls="asset-sec-collapse-3">Global Fields <i class="fa float-right" aria-hidden="true"></i>
                            </a>
                        </h5>
                    </div>
                    <div id="asset-sec-collapse-3" class="collapse" aria-labelledby="asset-sec-heading-3" data-parent="#asset-sec">
                        <div class="card-body">
                            <input type="hidden" id="hdnIsGlobalFiedlContainValues" value="0" runat="server" name="hdnIsGlobalFiedlContainValues" class="hdnIsGlobalFiedlContainValues"/>
                            <table class="table" id="tblAssetGlobalFields">                                                   
                                             <tbody class="globalFieldsBody">
                                             </tbody>
                                         </table>
                                          <input type="hidden" id="hdnGlobalFiedCount" name="hdnGlobalFiedCount" class="hdnGlobalFiedCount"  runat="server" value="1"/>
                             <div class="col-md-12 text-right">
                                <asp:Button ID="btnUpdateGlobalFields" CssClass="btn btn-primary" runat="server" Text="Update" OnClick="updateGlobalFields"></asp:Button>
                                        
                            </div>
                        </div>
                    </div>
                   
                </div>





                <div class="card">
                    <div class="card-header" id="asset-sec-heading-2">
                        <h5 class="mb-0">
                            <a class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#asset-sec-collapse-2" aria-expanded="false" aria-controls="asset-sec-collapse-2">Custom Fields
                                   <i class="fa float-right" aria-hidden="true"></i>
                            </a>
                        </h5>
                    </div>
                    <div id="asset-sec-collapse-2" class="collapse" aria-labelledby="asset-sec-heading-2" data-parent="#asset-sec">
                        <div class="card-body">
                             <table class="table" id="tblCustomFields">
                                                    <thead>
                                                        <tr>
                                                            <th style="text-align:center;">Field Name</th>
                                                            <th style="text-align:center;">Value</th>
                                                            <th style="text-align:center;"></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr class="ui-require" id="tablerow_1">
                                                            <td style="width:10%" class="col-sm-12">
                                                                <input class="form-control txtCustomFieldName" id="txtCustomFieldName_1" name="txtCustomFieldName_1" type="text"/>
                                                            </td>
                                                            <td style="width:10%"  class="col-sm-12">
                                                                <input class="form-control txtCustomFieldValue" id="txtCustomFieldValue_1" name="txtCustomFieldValue_1" type="text"/>
                                                            </td>
                                                            <td style="width:5%">                                                              
                                                                <button type="button" id="removebtn_1" style="display:none"
                                                                    class="btn btn_red btn-remove removebtnid btn-circle">
                                                                    <i class="fa fa-minus" aria-hidden="true"></i>
                                                                </button>
                                                                 <button type="button" id="addremovebtn_1"
                                                                    class="btn btn_green btn-add addnewrow addremovebtnid btn-circle">
                                                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                                                </button>
                                                                <input type="hidden" id="hdnRow" class="hdnRow" runat="server" value="1"/>
                                                                <input type="hidden" id="hdnCustomField_1" name="hdnCustomField_1" class="hdnCustomField" runat="server" value="1"/>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                             <div class="col-md-12 text-right">
                                <asp:Button ID="btnUpdateCustomFields" CssClass="btn btn-primary" runat="server" Text="Update" OnClick="updateCustomFields"></asp:Button>
                                        
                            </div>
                        </div>
                    </div>
                </div>


                <%--<div class="text-right">
                    <asp:Button ID="btnSave" CssClass="btn btn-primary" runat="server" Text="Save" OnClick="saveAsset"></asp:Button>
                    <input type="hidden" value="0" id="hdnAssetId" runat="server" />
                </div>--%>
            </div>
    </form>
    </div>
   <div id="divAddNewCategory">
        <% Response.WriteFile("add-master-items.html"); %>
    </div>


    <script type="text/javascript">
        $(document).ready(function () {
            $('#mdlFileFormat').hide();
            $('.li-dashboard').removeClass('active');
            $('.li-asset').addClass('active');
            $('#MainContent_btnUpdateCustomFields').addClass("disabled");
        });

        var apiUrl = "http://localhost:57080/api/"
        function openCategoryAddModal() {
            $("#mdlAddCategory").modal("show");
        }
        function openSubCategoryAddModal() {
            $("#mdlAddSubCategory").modal("show");
        }

        
        $(document).on('click', '.btn-add', function () {
            debugger;
            $(this).animate(false).stop();
            var count = '';
            var cloneCount = '';
            count = $('#tblCustomFields tr:last').attr('id').replace(/tablerow_/, '');
            cloneCount = parseInt(count) + 1;
            console.log("CloneCount :" + cloneCount);
            var row = $('#tblCustomFields tr:last').clone().prop('id', 'tablerow_' + cloneCount);
            $('#tblCustomFields').append(row);
            row.find('.txtCustomFieldName').val("").attr('id', 'txtCustomFieldName_' + cloneCount).attr('name', 'txtCustomFieldName_' + cloneCount);
            row.find('.txtCustomFieldValue').val("").attr('id', 'txtCustomFieldValue_' + cloneCount).attr('name', 'txtCustomFieldValue_' + cloneCount);
            row.find('.hdnCustomField').val("").attr('id', ' hdnCustomField_' + cloneCount).attr('name', ' hdnCustomField_' + cloneCount);
          
            row.find('.addremovebtnid').attr('id', 'addremovebtn_' + cloneCount);
            row.find('.removebtnid').attr('id', 'removebtn_' + cloneCount);
            $('#addremovebtn_' + (cloneCount - 1)).remove();
            $('#MainContent_hdnRow').val(cloneCount);
        });
        $(document).on('click', '.btn-remove', function () {
            var cloneCount = $(this).attr('id').split('_')[1];
          
            $.ajax({
                url: apiUrl + "Asset/deleteCustomField?customFieldId=" + parseInt(cloneCount),
                type: "GET",
                success: function (result) {
                    $('#tablerow_' + cloneCount).remove();
                },
                error: function (errormessage) {
                    console.log(errormessage.responseText);
                }
            });
        });
        $('.txtCustomFieldName').on('change', function () {
            $('#MainContent_btnUpdateCustomFields').removeClass("disabled");
        })
        $('.txtCustomFieldValue').on('change', function () {
            $('#MainContent_btnUpdateCustomFields').removeClass("disabled");
        })
    </script>
</asp:Content>


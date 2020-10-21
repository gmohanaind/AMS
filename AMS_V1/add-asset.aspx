<%@ Page Async="true" Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="add-asset.aspx.cs" Inherits="AMS_V1.Views.add_asset" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <script src="../Scripts/custom.js"></script>
    <style>
         .card-header{
            background-color:#007bff !important;
            padding:0 !important;
            color:white;
            border-radius:0 !important;
        }
    </style>
  <div class="card">
        <form class="form-horizontal" runat="server" id="frmAddAsset">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
            <div class="card-body col-form-label-right">
                <div class="pb-2 border-bottom mb-3">
                    <div class="col-md-6">
                        <h5>Add Asset</h5>
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
                                      <div class="col-md-4">
                                        <label for="assetType" class="col-form-label">Tag ID Type<sup class="text-red">* </sup> </label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                               <select id="ddlTagIdType" name="ddlTagIdType" class="ddlTagIdType form-control">
                                                    <option value="" selected>--Select--</option>
                                                    <option value="1">Auto Increment</option>
                                                    <option value="2">Custom</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <label for="assetTagId" class="col-form-label">Tag ID <sup class="text-red">* </sup></label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                               <input type="text" class="form-control" id="assetTagId" name="assetTagId" placeholder="Enter asset tag ID" required>
                                                <input type="hidden" id="hdnNextAssetTagId" name="hdnNextAssetTagId" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-4">
                                        <label for="assetTagType" class="col-form-label">Tag Type </label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlTagType" runat="server" CssClass="form-control ddlTagType">
                                                    <asp:ListItem Value="">--Select--</asp:ListItem>
                                                    <asp:ListItem Value="1">Barcode</asp:ListItem>
                                                     <asp:ListItem Value="2">QR code</asp:ListItem>
                                                     <asp:ListItem Value="3">RFID Tag</asp:ListItem>
                                                     <asp:ListItem Value="4">UHF Tag</asp:ListItem>
                                                </asp:DropDownList>
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
                                                <input type="text"  class="form-control" id="assetCost" name="assetCost" runat="server" placeholder="Asset cost" required />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="assetType" class="col-form-label">Asset Type </label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetTypes" runat="server" CssClass="form-control">
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
                                            <div class="col-2">
                                                <span class="addnew" onclick="openCategoryModal(0)"><i class="fa fa-plus"></i></span>
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
                                            <div class="col-2">
                                                <span class="addnew" onclick="openSubCategoryAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="col-md-4">

                                    </div>
                                    <div  class="col-md-12" id="divGlobalFields" style="display:none;">
                                         <label  class="col-form-label text-primary">Global Fields</label>
                                         <table class="table" id="tblAssetGlobalFields">
                                             <tbody class="globalFieldsBody">
                                             </tbody>
                                         </table>
                                          <input type="hidden" id="hdnGlobalFiedCount" name="hdnGlobalFiedCount" class="hdnGlobalFiedCount"  runat="server" value="1"/>
                                    </div>

                                    <div class="col-md-4">
                                        <label for="purchasedFrom" class="col-form-label">Purchased From</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlVendor" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-2">
                                                <span class="addnew" onclick="openVendorModal(0)"><i class="fa fa-plus"></i></span>
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
                                                <asp:DropDownList ID="ddlPurchasedType" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-2">
                                                <span class="addnew" onclick="openPurchasedTypeModal(0)"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                         <div class="col-md-4">
                                        <label for="site" class="col-form-label">Site</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetSites" runat="server" CssClass="form-control ddlAssetSites" >
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-2">
                                                <span class="addnew" onclick="openSitesModal(0)"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="location" class="col-form-label">Location</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetLocations" runat="server" CssClass="form-control ddlAssetLocations">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-2">
                                                <span class="addnew" onclick="openLocationsModal(0)"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="department" class="col-form-label">Department</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetDepartments" runat="server" CssClass="form-control ddlAssetDepartments">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-2">
                                                <span class="addnew" onclick="openDeptModal(0)"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <label for="insurance" class="col-form-label">Insurance</label>
                                        <div class="form-group row">
                                            <div class="col-10">
                                                <asp:DropDownList ID="ddlAssetInsurance" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-2">
                                                <span class="addnew" onclick="openInsuranceModal(0)"><i class="fa fa-plus"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="warrantdays" class="col-form-label">Warranty</label>
                                        <div class="form-group row">
                                            <div class="col-sm-4">
                                                <input type="number" name="txtWarrantyYears" id="txtWarrantyYears"
                                                    class="form-control" placeholder="Years" runat="server" min="0" value=0/>
                                            </div>
                                            <div class="col-sm-3">
                                                <input type="number" name="txtWarrantyMonths" id="txtWarrantyMonths"
                                                    class="form-control" placeholder="Months"  runat="server"  min="0"  value=0/>
                                            </div>
                                            <div class="col-sm-3">
                                                <input type="number" name="txtWarrantyDays" id="txtWarrantyDays"
                                                     class="form-control" placeholder="Days"  runat="server"  min="0" value=0/>
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
                                            <div class="col-10">
                                                <div class="custom-file">
                                                    <asp:FileUpload ID="FileUpload1" runat="server" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
                        <div class="card-body p-1 p-sm-3">
                             <table class="table" id="tblCustomFields">
                            <tbody>
                                                        <tr class="ui-require" id="tablerow_1">
                                                            <td>
                                                                <div class="row">
                                                                    <div class="col-5">
                                                                        <label class="col-form-label">Field Name </label>
                                                                            <div class="form-group row">
                                                                                <div class="col-12">
                                                                                    <input class="form-control txtCustomFieldName"
                                                                                        id="txtCustomFieldName_1" name="txtCustomFieldName_1" type="text"/>
                                                                                </div>
                                                                            </div>
                                                                    </div>
                                                                    <div class="col-5">
                                                                        <label class="col-form-label">Value </label>
                                                                            <div class="form-group row">
                                                                                <div class="col-12">
                                                                                    <input class="form-control txtCustomFieldValue"
                                                                                        id="txtCustomFieldValue_1" name="txtCustomFieldValue_1" type="text"/>
                                                                                </div>
                                                                            </div>
                                                                    </div>
                                                                     <div class="col-2">
                                                                        <label class="col-form-label"> <br /> </label>
                                                                            <div class="form-group row">
                                                                                <div class="col-10 text-center">
                                                                                     <button type="button" id="addremovebtn_1"
                                                                                        class="btn btn_green btn-add addnewrow addremovebtnid btn-circle">
                                                                                        <i class="fa fa-plus" aria-hidden="true"></i>
                                                                                    </button>
                                                                                    <input type="hidden" id="hdnRow" class="hdnRow" runat="server" value="1"/>
                                                                                </div>
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                        </div>
                    </div>
                </div>

          <%--      <div class="card">
                    <div class="card-header" id="asset-sec-heading-3">
                        <h5 class="mb-0">
                            <a class="btn btn-link collapsed text-left w-100" data-toggle="collapse" data-target="#asset-sec-collapse-3" aria-expanded="false" aria-controls="asset-sec-collapse-3">Asset Depreciation
                                  <i class="fa float-right" aria-hidden="true"></i>
                            </a>
                        </h5>
                    </div>
                    <div id="asset-sec-collapse-3" class="collapse" aria-labelledby="asset-sec-heading-3" data-parent="#asset-sec">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <label for="assetlife" class="col-form-label">Asset Life</label>
                                    <div class="form-group row">
                                        <div class="col-sm-12">
                                            <input type="text" id="txtAssetLifetime" name="txtAssetLifetime" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="salvage" class="col-form-label">Salvage Value</label>
                                    <div class="form-group row">
                                        <div class="col-sm-12">
                                            <input type="text" id="txtAssetSalvage" name="txtAssetSalvage" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="depreciationtype" class="col-form-label">Depreciation</label>
                                    <div class="form-group row">
                                        <div class="col-sm-12">
                                            <asp:DropDownList ID="ddlAssetDepreciation" runat="server" CssClass="form-control">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>--%>

                <div class="text-right">
                    <a class="btn btn-primary float-left" type="button" href="view-assets.aspx"> <i class="fas fa-arrow-left"></i>  Back </a>
                    <%--<asp:Button ID="btnSave" CssClass="btn btn-primary float-right" runat="server" Text="Save" OnClick="saveAsset">Submit <i class="fa fa-forward" aria-hidden="true" runat="server"></i>  </asp:Button>--%>
                    <asp:LinkButton runat="server" ID="btnSubmit" CssClass="btn btn-primary float-right" OnClick="saveAsset">
                        <i class="far fa-save" aria-hidden="true"></i> Save Asset
                    </asp:LinkButton>
                    <input type="hidden" value="0" id="hdnAssetId" runat="server" />
                </div>
            </div>
    </form>
    </div>
    <div id="divAddNewCategory">
        <% Response.WriteFile("add-master-items.html"); %>
    </div>

    <script type="text/javascript">
        var apiUrl = "http://localhost:57080/api/";
        $(document).ready(function () {
            $('#mdlFileFormat').hide();
            $('.li-dashboard').removeClass('active');
            $('.li-asset').addClass('active');
            //document.getElementById("myNumber").defaultValue = "16";
            $('.ddlSubCategories').on('change', function () {
                var categoryId = $('#MainContent_ddlAssetCategories').val();
                var subCategoryId = $('#MainContent_ddlSubCategories').val();
                $.ajax({
                    url: apiUrl + "Asset/getAssetGlobalFields?CategoryId=" + categoryId + "&SubCategoryId=" + subCategoryId,
                    type: "GET",
                    success: function (result) {
                        debugger;
                        console.log(result);
                        if (result.length > 0) {
                            $('#MainContent_hdnGlobalFiedCount').val(result.length);
                            //hdnGlobalFiedCount
                            var html = '';
                            var counter = (result.length > 3) ? Math.round(result.length / 3) : result.length;

                            for (var idx = 0; idx < result.length;) {
                                html += '<tr class="ui-require" id="tr_' + (idx + 1).toString() + '">';
                                html += '<td class="p-0"><div class="row">';
                                if ((idx + counter) > result.length)
                                    counter = result.length - counter ;
                                else
                                    counter = idx + counter;
                                for (var j = 0; j < counter; j++) {
                                    var fieldId = "txtGlobalFiled_" + (idx + 1);
                                    html += '<div class="col-md-4"><label class="col-form-label" id="txtGlobal_' + (idx + 1) + '" name="txtGlobal_' + (idx + 1) + '">' + result[idx].FieldName + '<span class="text-danger">*</span></label>';

                                    html += "<div class=\"form-group row\"><div class=\"col-10\"><input type=\"text\" id=\"" + fieldId + "\" name=\"" + fieldId + "\" class=\"form-control\" required \/>";
                                    html += '<input type="hidden" id="hdn_' + (idx + 1) + '" value = ' + result[idx].UniqueId + ' name="hdn_' + (idx + 1) + '" value = ' + result[idx].UniqueId + ' minlength="2"  maxlength="25" \/>';
                                    html += '<input type="hidden" id="hdnFieldName_' + (idx + 1) + '" value = ' + result[idx].FieldName + ' name="hdnFieldName_' + (idx + 1) + '"  minlength="2"  maxlength="25" \/>';
                                    html+= "";
                                    html += '</div></div></div>'
                                    idx++;
                                }
                                html += '</div></td></tr>';
                            }
                            $('.globalFieldsBody').html(html);
                            $('#divGlobalFields').show();
                        }
                    },
                    error: function (errormessage) {
                        $('#divLoader').hide();
                        alert(errormessage.responseText);
                    }
                });
            });
        });

        function openCategoryAddModal() {
            $("#mdlAddCategory").modal("show");
        }
        function openSubCategoryAddModal() {
            var v = $("#MainContent_ddlAssetCategories").val();
            if (v > 0) {
                openSubCategoryModal(v, 0);
            }
            else {
                alert("Select category")
            }
            //$("#mdlAddSubCategory").modal("show");
        }

        $("#ddlTagIdType").change(function () {
            debugger;
            if ($("#ddlTagIdType").val() == "1") {
                $('#assetTagId').val($('#MainContent_hdnNextAssetTagId').val());
                $('#assetTagId').attr("disabled", "disabled");
            }
            else {
                $('#assetTagId').val("");
                $('#assetTagId').removeAttr("disabled");
            }

        });
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

           // row.find('.hdnRow').val(cloneCount).attr('id', 'hdnRow_' + cloneCount);

            row.find('.addremovebtnid').attr('id', 'addremovebtn_' + cloneCount);
            $('#addremovebtn_' + (cloneCount - 1)).removeClass('btn-default, btn_green').addClass('btn_red').removeClass('btn-add').removeClass('addnewrow').addClass('btn-remove').html('<i class="fa fa-minus" aria-hidden="true"></i>');
            $('#MainContent_hdnRow').val(cloneCount);
        });
        $(document).on('click', '.btn-remove', function () {
            var cloneCount = $(this).attr('id').split('_')[1];
            $('#tablerow_' + cloneCount).remove();
        });

        $("#assetTagId").focusout(function () {
            debugger;
            var assetId = $('#assetTagId').val();
            if (assetId == "")
                return false;

            $.ajax({
                url: apiUrl + "Asset/GetAssetTagIdValidate?assetId=" + assetId,
                type: "GET",
                success: function (result) {
                    if (result > 0)
                        alert("Tag Id already used. Select new one");
                    else if(result == -2)
                        alert("Something went wrog. Please contact support");
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });

        });

    </script>
</asp:Content>

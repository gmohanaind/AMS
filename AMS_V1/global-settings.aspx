<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" MasterPageFile="~/Site.Master" CodeBehind="global-settings.aspx.cs" Inherits="AMS_V1.Views.global_settings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 <script src="../Scripts/custom.js"></script>
    <div class="content">       
        <div class="card">  
             <%-- <div class="spinner" id="divLoader" style="display:none">
                        <div class="text-info" style="margin:15%;">
                            <i class="fa fa-spinner fa-spin" style="font-size:28px !important;"></i>
                            <p style="font-size:18px !important;">Please wait a while! Fetching Assets .........</p>
                        </div>
                    </div>    --%>    
             <div class="card-body bg-white" id="assetCard">  
                    <div class="nav nav-tabs nav-tabs-2">
                        <a class="nav-item nav-link active" href="#tab1primary" data-toggle="tab"> Global Fields </a> 
                        <a class="nav-item nav-link" href="#tab2primary" data-toggle="tab" onclick="getCurrencies()"> Currency </a> 
                    </div>
                  <div class="tab-content">
                        <div class="tab-pane fade in active show" id="tab1primary"> 
                            <div class="row pb-2 border-bottom mb-3">
                                <div class="col-md-12 text-right">
                                    <button class="btn btn-primary btn-sm mt-2"  data-toggle="modal" data-target="#mdlGlobalFields">   New </button>
                                </div>
                            </div>                           
                           
                                 <table id="tblAssetGlobalFieldsForView" class="table  table-bordered table-hover table-responsive d-sm-table" style="width:100% !important;">
                                    <thead>
                                        <tr>                                           
                                            <th># </th>
                                            <th>Category</th>
                                            <th>Sub Category </th>  
                                            <th>Field Name </th>                                           
                                        </tr>
                                    </thead>
                                    <tbody  class="assetGlobalBody">
                                    </tbody>
                                </table>
                          
                        </div>  
                          <div class="tab-pane fade in" id="tab2primary" >
                                <div class="row">
                                       <div class="col-md-4">
                                          <label for="categories" class="col-form-label">Currency</label>
                                          <div class="form-group row">
                                              <div class="col-sm-10">
                                                  <select id="ddlCurrency" name="ddlCurrency"  class="form-control ddlCurrency selectpicker" data-dropup-auto="false">
                                                  </select>
                                              </div>
                                          </div>
                                       </div>
                                    </div>
                        </div>         
                    </div>
                </div>
                 
            </div>
         </div>
      
     <div id="mdlGlobalFields" class="modal fade" role="dialog">
        <div class="modal-dialog" style="width: 100% !important;">
            <!-- Modal content-->
            <div class="modal-content" style="margin-top:10%;width:120% !important;">
                <div class="modal-header">
                    <h5 class="modal-title" style="color:#fff;font-weight:600;">
                        Add Global Fields
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" style="color:#fff;font-weight:600;opacity: unset;">
                        &times;
                    </button>
                </div>
                <form class="form-horizontal" id="frmAddAssetGlobalFields" name="frmAddAssetGlobalFields" runat="server">

                    <div class="modal-body">
                        <div class="col-md-6">
                                          <label for="categories" class="col-form-label">Category</label>
                                          <div class="form-group row">
                                              <div class="col-sm-10">
                                                  <asp:DropDownList ID="ddlAssetCategories" name="ddlAssetCategories" runat="server" CssClass="form-control ddlAssetCategories">
                                                  </asp:DropDownList>
                                              </div>
                                                <div class="col-2">
                                                <span class="addnew" onclick="openCategoryModal(0)"><i class="fa fa-plus"></i></span>
                                            </div>
                                          </div>
                                       </div>
                           <div class="col-md-6">
                                          <label for="categories" class="col-form-label">Sub Category</label>
                                          <div class="form-group row">
                                              <div class="col-sm-10">
                                                  <asp:DropDownList ID="ddlSubCategories" name="ddlSubCategories" runat="server" CssClass="form-control">
                                                  </asp:DropDownList>
                                              </div>
                                              <div class="col-2">
                                                <span class="addnew" onclick="openSubCategoryAddModal()"><i class="fa fa-plus"></i></span>
                                            </div>
                                          </div>
                                   </div> 
                             
                                  <div class="col-md-6">
                                  <label for="filedName" class="col-form-label">Field Name</label>
                                  <div class="form-group row">
                                      <div class="col-sm-12">
                                           <table id="tblAssetGlobalFields">
                                                   
                                                                <tbody>
                                                                    <tr class="ui-require" id="tablerow_1">
                                                                        <td class="col-sm-12">
                                                                            <input class="form-control txtFieldName" id="txtFieldName_1" name="txtFieldName_1" type="text"/>
                                                                        </td>                                                            
                                                                        <td style="width:5%">
                                                                            <button type="button" id="addremovebtn_1" style="font-size: 12px !important;padding: 1px 5px !important;"
                                                                                class="btn btn_green btn-add addnewrow addremovebtnid btn-circle" title="Clone the Field Name">
                                                                                <i class="fa fa-plus" aria-hidden="true"></i>
                                                                            </button>
                                                                            <input type="hidden" id="hdnRow" class="hdnRow" runat="server" value="1"/>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                           </table>
                                      </div>                         
                                  </div>                       
                                </div> 
                                    
                      
                    </div>
                    <div class="modal-footer">
                        <button id="btnSave" class="btn btn-primary" onclick="saveAssetGlobalFiedls()">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div id="divAddNewCategory">
        <% Response.WriteFile("add-master-items.html"); %>
    </div>
   <script>     
        var apiUrl = "http://localhost:57080/api/";
        $(document).ready(function () {
           
            getAssetGlobalFields(0,0);
        });
        function getClientGlobalSettings() {
            $.ajax({
                url: apiUrl + "Asset/getClientGlobalSettings?ClientId=1",
                type: "GET",
                success: function (result) {
                    $('#ddlCurrency').val(result[0].CurrencyId);
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
        }
      
       
        function openCategoryAddModal() {
            $("#mdlAddCategory").modal("show");
        }
        function openSubCategoryAddModal() {
            $("#mdlAddSubCategory").modal("show");
        }
        function getAssetGlobalFields(categoryId, subCategoryId) {
            debugger;
            $.ajax({
                url: apiUrl + "Asset/getAssetGlobalFields?CategoryId=" + categoryId + "&SubCategoryId=" + subCategoryId,
                type: "GET",
                success: function (result) {
                    debugger;
                    var html = '';
                    if (result.length > 0) {
                        $.each(result, function (key, obj) {
                            html += '<tr style="cursor:pointer;hover:green">';                           
                            html += '<td>' + (parseInt(key) + 1) + '</td>';                           
                            html += '<td>' + obj.CategoryName + '</td>';
                            html += '<td>' + obj.SubCategoryName + '</td>';
                            html += '<td>' + obj.FieldName + '</td>';
                            html += '</tr>';
                        });
                        $('.assetGlobalBody').html(html);
                        //Make it as a Data Table
                        $('#tblAssetGlobalFieldsForView').DataTable({
                        });
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            
        }
        function getCurrencies() {
            debugger;
            $.ajax({
                url: apiUrl + "Asset/getAllCurrency",
                type: "GET",
                success: function (result) {
                    debugger;
                    $("#ddlCurrency").empty();
                    if (result.length > 0)                             
                        var $dropdown = $("#ddlCurrency");
                    $dropdown.append($("<option />").val("").text("--Select--"));
                    $.each(result, function () {
                        $dropdown.append($("<option />").val(this.currencyid).text(this.name +"-" + this.code +"-"+ this.symbol ));
                    });
                    getClientGlobalSettings();
                },           
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
        });
  }
       

        $(document).on('click', '.btn-add', function () {
            debugger;
            $(this).animate(false).stop();
            var count = '';
            var cloneCount = '';
            count = $('#tblAssetGlobalFields tr:last').attr('id').replace(/tablerow_/, '');
            cloneCount = parseInt(count) + 1;
            console.log("CloneCount :" + cloneCount);
            var row = $('#tblAssetGlobalFields tr:last').clone().prop('id', 'tablerow_' + cloneCount);
            $('#tblAssetGlobalFields').append(row);
            row.find('.txtFieldName').val("").attr('id', 'txtFieldName_' + cloneCount).attr('name', 'txtFieldName_' + cloneCount);


            row.find('.addremovebtnid').attr('id', 'addremovebtn_' + cloneCount);
            $('#addremovebtn_' + (cloneCount - 1)).removeClass('btn-default, btn_green').addClass('btn_red').removeClass('btn-add').removeClass('addnewrow').addClass('btn-remove').html('<i class="fa fa-minus" aria-hidden="true"></i>');
            $('#MainContent_hdnRow').val(cloneCount);
        });
        $(document).on('click', '.btn-remove', function () {
            var cloneCount = $(this).attr('id').split('_')[1];
            $('#tablerow_' + cloneCount).remove();
        });
    </script>
</asp:Content>

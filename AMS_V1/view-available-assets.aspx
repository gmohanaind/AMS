<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Employee.Master" CodeBehind="view-available-assets.aspx.cs" Inherits="AMS_V1.Views.view_available_assets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="../Scripts/custom.js"></script>
   <style>
        .disabled{
    cursor: not-allowed; /* aesthetics */
    pointer-events: none;
    background-color:#ccc;
    border-color:#ccc;

    }
        table {
            border-collapse: collapse;
            width: 100%;
            color:black;
        }

        th, td {
            text-align: left;
            padding: 8px;
        }

       .table td {
           padding: 0.5rem;
       }
       .spinner {
        width: 100%;
        height: 100%;
        min-width: 80px;
        position: absolute;
        background: rgba(255, 255, 255, 0.71);
        z-index: 1800;
        text-align:center;
    }

    </style>
    <div class="content">
        <div class="card">
              <div class="spinner" id="divLoader" style="display:none">
                        <div class="text-info" style="margin:15%;">
                            <i class="fa fa-spinner fa-spin" style="font-size:28px !important;"></i>
                            <p style="font-size:18px !important;">Please wait a while! Fetching Assets .........</p>
                        </div>
                    </div>
            <div class="card-body" id="assetCard"  style="display:none;">
                <div class="row pb-2 border-bottom mb-3">
                    <div class="col-md-10">
                        <h4> <b> List of available assets </b></h4>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-primary pull-right" id="send-asset-request">
                            <i class="fa fa-paper-plane"></i> Send Request</button>
                    </div>
                </div>
                <table id="tblAssets" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th></th>
                            <th># </th>
                            <th>Tag ID</th>
                            <th>Name </th>
                            <th>Cost </th>
                            <th>Category </th>
                             <th>Sub Category </th>
                            <th>Status </th>
                          <%--  <th>Actions </th>--%>
                        </tr>
                    </thead>
                    <tbody  class="assetBody">
                    </tbody>
                </table>
                <div id="noAssets">
                    <span class="text-dangr">No Assets Found..</span>
                </div>
            </div>
        </div>
    </div>

      <!--Vendors Modal -->
    <div id="mdlSentRequest" class="modal fade" role="dialog" style="width: 60%;margin-left:25%">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content" style="margin-top:10%;">
                <div class="modal-header">
                    <h5 class="modal-title" style="color:#000;font-weight:600;">
                       Sent Request                       
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" >
                        &times;
                    </button>
                </div>
                <form class="form-horizontal" id="frmSentRequest" name="frmSentRequest" action="#">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-2"></div>
                            <div class="col-md-8">
                                 <label for="ddlRequestPurpose" class="col-md-10 col-form-label">Prupose <span class="text-danger">*</span></label>
                                <select id="ddlRequestPurpose" name="ddlRequestPurpose" class="form-control"
                                    onchange="$('#errPurpose').hide();">
                                </select>
                                <span id="errPurpose" class="text-danger" style="display:none;">Purpose is required!</span>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                         <div class="row">
                           <div class="col-md-2"></div>
                                <div class="col-md-8">
                                    <label for="txtDurationToHold" class="col-form-label col-md-10">Is Permanent Requirement<span class="text-danger">*</span></label>                                                                       
                                    <p style="margin: 0;margin-left: 15px;">
                                        <input type="radio" id="rdIsPermanentYes" name="IsPermanent" value="Yes"   checked="checked"/> &nbsp;&nbsp;Yes
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rdIsPermanentNo" name="IsPermanent" value="No"/>  &nbsp;&nbsp;No
                                    </p>
                                      
                                           
                                </div> 
                       </div>
                        <div class="row">
                            <div class="col-md-2"></div>
                            <div class="col-md-8">
                                 <label for="txtDurationToHold" class="col-form-label col-md-10">Duration To Hold</label>                                        
                                 <input type="date" id="txtDurationToHold" name="txtDurationToHold" class="form-control" />                                        
                            </div>
                            <div class="col-md-1"></div>
                       </div>
                        <div class="row">
                            <div class="col-md-2"></div>
                            <div class="col-md-8">
                                 <label for="txtExpectedCheckoutDate" class="col-form-label col-md-10">Expected Date</label>                                        
                                 <input type="date" id="txtExpectedCheckoutDate" name="txtExpectedCheckoutDate" class="form-control" />                                        
                            </div>
                            <div class="col-md-1"></div>
                       </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" id="btnSentRequest" name="btnSentRequest" type="button"> Sent </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Vendors Modal -->

 <div>
     <% Response.WriteFile("change-asset-status.html"); %>
 </div>
    <script type="text/javascript">
        var IsPermanentToHold = 0;
        $('#rdIsPermanentYes').on('click', function () {
            $('#txtDurationToHold').addClass("disabled");
            IsPermanentToHold = 1;
        });
        $('#rdIsPermanentNo').on('click', function () {
            $('#txtDurationToHold').removeClass("disabled");
            IsPermanentToHold = 0;
        });
        function getRequestPurpose() {
            $("#ddlRequestPurpose").empty();
            $.ajax({
                url: apiUrl + "Asset/GetRequestPurposeMaster",
                type: "GET",
                success: function (result) {
                    if (result.length > 0) {
                        var $dropdown = $("#ddlRequestPurpose");
                        $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                        $.each(result, function () {
                            $dropdown.append($("<option />").val(this.PurposeId).text(this.Purpose));
                        });
                    }
                },
                error: function (errormessage) {
                    console.log(errormessage.responseText);
                }
            });
        }
        $('#btnSentRequest').click(function () {
            debugger;
            if ($('#ddlRequestPurpose').val() == null || $('#ddlRequestPurpose').val() == "")
            {
                $('#errPurpose').show();
                return false;
            }
            var selectedAssetIds = $('.Checkbox:checked').map(function () {
                return this.value;
            }).get().join(',');
            if (selectedAssetIds != "") {
                var clsAssetRequest = {
                    assetIds: selectedAssetIds,
                    RequestedBy: sessionStorage.getItem("UserId"),
                    requestId:0,
                    assetId: 0,
                    ApprovedOrRejectedBy: 0,
                    CreatedDateTime: "01/01/1900",
                    UpdatedDate: "01/01/1900",
                    IsApproved: 0,
                    Remarks: "",
                    RequestStatus: "Requested",
                    PurposeId: $('#ddlRequestPurpose').val(),
                    IsPermanentToHold: IsPermanentToHold,
                    DurationToHold: ($('#txtDurationToHold').val() == "") ? "01/01/1900" : $('#txtDurationToHold').val(),
                    ExpectedCheckoutDate: ($('#txtExpectedCheckoutDate').val() == "") ? "01/01/1900" : $('#txtExpectedCheckoutDate').val()
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
                            $('#mdlSentRequest').modal("hide");
                            getAvailableAssets();
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
            else
            {
                Swal.fire({
                    text: "Please select assets for request",
                    icon: 'warning',
                    showCancelButton: false,
                    showConfirmButton: true
                });
            }
        });
        $('#send-asset-request').click(function () {           
            getRequestPurpose();
            $('#mdlSentRequest').modal("show");
            
        });
        function viewAssets(assetId) {
            window.location.href = "view-ind-asset.aspx?assetId=" + assetId;
        }
        function getAvailableAssets() {
            $('#divLoader').show();
            if ($.fn.DataTable.isDataTable("#tblAssets")) {
                $('#tblAssets').DataTable().clear().destroy();
            }
            //AJAX call to fetch the Data
            $.ajax({
                url: apiUrl + "Asset/getAllAssets",
                type: "GET",
                success: function (result) {
                    debugger;
                    var html = '';
                    if (result.length > 0) {
                        var index = 0;
                        $.each(result, function (key, asset) {
                            if (asset.StatusName.toUpperCase() == "IN STORAGE") {
                                var statusClass = "text-success";
                                index++;
                                var errorImgUrl = "./../dist/img/assets/laptop.png";
                                html += '<tr onclick="viewAssets(' + asset.AssetId + ')" style="cursor:pointer;hover:green">';
                                html += '<td onclick=event.stopPropagation()><input type="checkbox" class="Checkbox" name="assets_available" id="chk_' + asset.AssetId + '"  onclick="getAssetIds(' + asset.AssetId + ')"  value="' + asset.AssetId + '"/></td>';
                                html += '<td>' + (index) + '</td>';
                                html += '<td>' + asset.AssetTagId + '</td>';
                                html += '<td>' + asset.AssetName + '</td>';
                                html += '<td style="text-align:right;">' + asset.AssetCost + '</td>';
                                html += '<td>' + asset.CategoryName + '</td>';
                                html += '<td>' + asset.SubCategoryName + '</td>';
                                html += '<td class="' + statusClass + '">' + asset.StatusName + '</td>';
                                html += '</tr>';
                            }

                        });
                        $('.assetBody').html(html);
                        //Make it as a Data Table
                        $('#tblAssets').DataTable({
                        });
                        $('#divLoader').hide();
                        $('#assetCard').show();
                        $('#tblAssets').show();
                        var oTable = $('#tblAssets').dataTable();
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
        $(document).ready(function () {
            $('#send-asset-request').addClass("disabled");
            $('#txtDurationToHold').addClass("disabled");
            $('#liHomeBreadCrum').show();
            $('#liPageBreadCrum').text("View Assets");
            liPageBreadCrum
            $('#divLoader').show();
            $('#noAssets').hide();
            $('.li-dashboard').removeClass('active');
            $('.li-asset').addClass('active');
            getAvailableAssets();
          
        });
        var assetIds = [];
        function getAssetIds(assetId) {
            if ($('#chk_' + assetId).prop("checked") == true) {
                assetIds.push(assetId);
            }
            else if ($('#chk_' + assetId).prop("checked") == false) {
                assetIds.splice($.inArray(assetId, assetIds), 1);
            }
            if (assetIds.toString().length == 0)
                $('#send-asset-request').addClass("disabled");
            else
                $('#send-asset-request').removeClass("disabled");
        }
    </script>
</asp:Content>

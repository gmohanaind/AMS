<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="asset-dashboard.aspx.cs" Inherits="AMS_V1.asset_dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>

        .liClassPills{
            font-weight:bold;
        }
        .fw{
            font-weight:600;
        }
        .swal2-html-container{
            color:green !important;
            font-weight:600 !important;
        }
     .form-control,.add-btn{
         border-radius:0 !important;
         height: 30px !important;
         font-size: 14px;
     }
     .add-btn{
        border-radius:0 !important;
         height: 30px !important;
         padding: 2px 20px !important;
         margin-bottom: 10px !important;
         font-size: 14px;
     }
     .card-title{
         font-size: 16px !important;
     }
     .card{

         background-color: #fdfdba !important;
     }
    .todo-list>li {
        border-radius: 2px;
        background: #fff !important;
        border-left: 2px solid #e9ecef;
        color: #495057;
        margin-bottom: 5px;
        padding: 4px;
        font-size: 14px;
    }
    .nav>li>a {
    position: relative;
    display: block;
    padding: 10px 15px;
     color: #454545;
    border-bottom: 0 solid #cacaca !important;
}
   .nav-pills.Navtabs_li li .badge, .nav-pills.Navtabs_li li.active>a>.badge {
    padding: 3px 4px !important;
    border-radius:50% !important;
    color: #fff !important;
    font-size: .82em !important;
}
   .nav-pills > li.active > a::after {
    background: #0060ae;
}
  .card-body {
    background-color: #ffffce !important;
}
.active{
    margin-bottom: 3% !important;
}

   .nav-pills>li.active>a::after {
    left: 11%;
    z-index: 999;
    width: 3em;
    height: 3px;
    content: " ";
    bottom: 0;
    margin-left: 0;
    text-align: left;
    position: absolute;
}
sub, sup {
    top: -1em !important;
    position: relative !important;
    font-size: 75% !important;
    line-height: 0 !important;
    vertical-align: baseline !important;
}
.cost{
    color:#fff !important;
}
    </style>
      <div class="row" style="padding-top: 2%;">
        <div class="col-lg-2">
            <!-- small box -->
            <div class="small-box bg-blue-gradient" onclick="SetAssetFilter(0,'All')">
                <div class="inner">
                    <p class="mb-0 f-w-400">Total Assets </p>
                    <h3 id="TotalAssets"></h3>               
                </div>
            </div>
        </div>
          <div class="col-lg-2">
            <!-- small box -->
            <div class="small-box bg-purple-gradient"  onclick="SetAssetFilter(1,'InStorage')">
                <div class="inner">
                    <p class="mb-0">In Storage Assets </p>
                    <h3 id="InStorageCount"></h3>
                </div>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-2">
            <!-- small box -->
            <div class="small-box bg-yellow-gradient"  onclick="SetAssetFilter(2,'CheckOut')">
                <div class="inner">
                    <p class="mb-0">Check-out Assets </p>
                    <h3 id="CheckoutCount"></h3>
                </div>
            </div>
        </div>
           <div class="col-lg-2">
            <!-- small box -->
            <div class="small-box bg-green-gradient" onclick="SetAssetFilter(4,'Maintenance')">
                <div class="inner" style="padding: 14px 10px !important;">
                    <p class="mb-0">Maintenance Assests </p>
                    <h3 id="MaintenanceCount"></h3>
                </div>

            </div>
        </div>
        <!-- ./col -->
           <!-- ./col -->
        <div class="col-lg-2">
            <!-- small box -->
            <div class="small-box bg-red-gradient"  onclick="SetAssetFilter(6,'Dispose')">
                <div class="inner">
                    <p class="mb-0">Disposed Assets </p>
                    <h3 id="DisposeCount"></h3>
                </div>
            </div>
        </div>
     <div class="col-lg-2">
            <!-- small box -->
            <div class="small-box bg-yellow-gradient" onclick="SetAssetFilter(8,'Damage')">
                <div class="inner">
                    <p class="mb-0">Damaged Assets </p>
                    <h3 id="DamagedCount"></h3>
                </div>
            </div>
        </div>
      <div class="col-lg-2">
            <!-- small box -->
            <div class="small-box bg-red-gradient" onclick="SetAssetFilter(5,'Lost')">
                <div class="inner">
                    <p class="mb-0">Lost Assets </p>
                    <h3 id="LossCount"></h3>
                </div>

            </div>
        </div>
        <div class="col-lg-2">
            <div class="small-box bg-green-gradient" onclick="showOtherAssets('checkin')">
                <div class="inner">
                    <p class="mb-0">Check-in Past Due </p>
                    <h3 id="CheckInPendingCount"></h3>
                </div>
            </div>
        </div>
       <div class="col-lg-2">
            <div class="small-box bg-blue-gradient" onclick="showOtherAssets('expiringwarranty')">
                <div class="inner">
                    <p class="mb-0">Warranty Expiring</p>
                    <h3 id="WarrantyExpiry"></h3>
                </div>
            </div>
        </div>
        <div class="col-lg-2">
            <div class="small-box bg-purple-gradient" onclick="showOtherAssets('expiringinsurance')">
                <div class="inner">
                    <p class="mb-0">Insurance Expiring</p>
                    <h3 id="InsuranceExpiry"></h3>
                </div>
            </div>
        </div>
 </div>

     <div class="row">
        <div class="col-md-6">
             <div class="card">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="ion ion-clipboard mr-1"></i>
                <strong>   To Do List </strong>
                </h3>
                     <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                       <%-- <button type="button" class="btn btn-tool" data-card-widget="remove">
                            <i class="fas fa-times"></i>
                        </button>--%>
                    </div>
              <%--  <div class="card-tools">
                  <ul class="pagination pagination-sm">
                    <li class="page-item"><a href="#" class="page-link">&laquo;</a></li>
                    <li class="page-item"><a href="#" class="page-link">1</a></li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">&raquo;</a></li>
                  </ul>
                </div>--%>
              </div>
              <!-- /.card-header -->
              <div class="card-body panel-body">

                  <div class="input-group">
                    <input type="text" class="form-control add-input" placeholder="Add To Do ..." minlength="5"
                         maxlength="500" name="TodoName" id="TodoName" onfocus="$('#errToDoName').hide()" >
                    <span class="input-group-btn">
                        <button type="button" class="btn btn-primary btn-small p-t-5 f-w-600 add-btn" onclick="insertToDo(0,'Completed',0)">
                            Add
                        </button>
                    </span>
                </div>
                  <div style="margin-top: -12px;font-size: 13px;color:red;">
                        <span id="errToDoName" style="display:none;">To Do Name is required!</span>
                  </div>
                <div class="p-b-10 mt-2">
                    <ul class="nav nav-pills Navtabs_li ToDoUl">
                        <li  class="todolist active" onclick="populateLi(1,this)">
                            <a href="#" class="liClassPills">All <sup>
                                <span class="badge badge-info" id="spnAllCount"> </span> </sup> </a>
                        </li>
                        <li class="todolist"  onclick="populateLi(2,this)"> <%-- ng-click="clickableEvents('Active')"--%>
                            <a href="#" class="liClassPills"> Active <sup>
                                <span class="badge badge-success" id="spnActiveCount"></span> </sup></a>
                        </li>
                        <li  class="todolist"  onclick="populateLi(3,this)">
                            <a href="#" class="liClassPills">Completed <sup>
                                <span class="badge badge-warning " id="spnCompletedCount"></span> </sup></a>
                        </li>

                    </ul>
                </div>
                  <div class="clstoDoList">
                        <ul class="todo-list" data-widget="todo-list" id="toDoList">
                        </ul>
                  </div>

              </div>
            </div>

        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header border-transparent">
                    <h3 class="card-title"><strong>Request Status </strong></h3>

                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                     <%-- <button type="button" class="btn btn-tool" data-card-widget="remove">
                            <i class="fas fa-times"></i>
                      </button>--%>
                    </div>
                </div>
                <div class="card-body">
                     <div class="progress-group">
                        <span class="progress-text fw">Total Requests  </span>
                        <span class="float-right fw" id="TotalRequestedCount"></span>
                        <div class="progress progress-sm">
                            <div class="progress-bar bg-info"></div>
                        </div>
                    </div>
                    <div class="progress-group">
                        <span class="progress-text text-success fw">Approved  </span>
                        <span class="float-right  text-success fw" id="TotalApprovedCount"></span>
                        <div class="progress progress-sm">
                            <div class="progress-bar bg-success"  id="divReqApprovedWidth"></div>
                        </div>
                    </div>
                    <!-- /.progress-group -->

                    <div class="progress-group">
                        <span class="progress-text text-primary fw">On Hold </span>
                        <span class="float-right text-primary fw" id="TotalPendingCount"></span>
                        <div class="progress progress-sm">
                            <div class="progress-bar bg-primary" id="divReqPendingWidth"></div>
                        </div>
                    </div>
                    <div class="progress-group">
                        <span class="progress-text text-danger fw">Rejected </span>
                        <span class="float-right text-danger fw" id="TotalRejectedCount">  </span>
                        <div class="progress progress-sm">
                            <div class="progress-bar bg-danger"  id="divReqRejectedWidth"></div>
                        </div>
                    </div>
                </div>
            </div>



             <%--   <div class="card">
                <div class="card-header border-transparent">
                    <h3 class="card-title"><strong>Up Coming Activities </strong></h3>

                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    
                    </div>
                </div>
                <div class="card-body">
                    <ul class="todo-list" data-widget="todo-list" id="upcomingActivities">
                        <li>
                            <i class="fas fa-ellipsis-v"></i>
                            <span class="text">Warranty Going to expiry</span>
                        </li>
                         <li>
                            <i class="fas fa-ellipsis-v"></i>
                            <span class="text">Insurance Going to expiry</span>
                        </li>
                         <li>
                            <i class="fas fa-ellipsis-v"></i>
                            <span class="text">Maintanence Due</span>
                        </li>
                    </ul>
                </div>
               
                </div>--%>
        </div>
    </div>

<script>
    var apiUrl = "http://localhost:57080/api/";
    function showOtherAssets(otherstatus) {
        window.location.href = "assets-list.aspx?filtervalue="+otherstatus;
    }
    function SetAssetFilter(statusId, searchText) {
        sessionStorage.setItem("SearchStatusId", statusId);
        sessionStorage.setItem("SearchText", searchText);
        window.location.href = "view-assets.aspx";
    }
    function updateToDo(obj) {
        debugger;
        if (obj.checked) {
            insertToDo(obj.value, "Completed",1);
        }
        else {
            insertToDo(obj.value, "Active",1);
        }
        //alert(todoid);
    }
    var ActiveToDoList;
    var CompletedToDoList;
    var AllDoList;
    function getToDoList() {
        $.ajax({
            url: apiUrl + "Asset/GetToDoListByUserId?userid=" + sessionStorage.getItem("UserId"),
            success: function (result) {
                debugger;
                console.log(result);
                //persons = [];
                var html = '';
                if (result.length > 0) {
                    ActiveToDoList = result.filter(function (obj) {
                        return obj.Todoliststatus == "Active";
                    });
                    CompletedToDoList = result.filter(function (obj) {
                        return obj.Todoliststatus == "Completed";
                    });
                    AllDoList = result;
                    populateLi(1);
                    $('#spnAllCount').text(AllDoList.length);
                    $('#spnActiveCount').text(ActiveToDoList.length);
                    $('#spnCompletedCount').text(CompletedToDoList.length);
                } else {
                    $('#spnAllCount').text("0");
                    $('#spnActiveCount').text("0");
                    $('#spnCompletedCount').text("0");
                }

            },
            error: function (errormessage) {
                $('#divLoader').hide();
                alert(errormessage.responseText);
            }
        });
    }
    function populateLi(tab,obj) {
        var result = AllDoList;
        if (tab == 1)
            result = AllDoList;
        else if (tab == 2)
            result = ActiveToDoList;
        else
            result = CompletedToDoList;
        var html = '';
        $("#toDoList").empty();
        $.each(result, function (key, response) {
            if (response.Todoliststatus == "Active")
                html += '<li>';
            else
                html += '<li class="done">';
            html += '<span class="handle"><i class="fas fa-ellipsis-v"></i></span>';
            html += '<div class="icheck-primary d-inline ml-2">';
            if (response.Todoliststatus == "Active")
                html += '<input type="checkbox" onclick="updateToDo(this)" value="' + response.ToDoId + '" name="todo' + (parseInt(key) + 1) + '" id="todoCheck"' + (parseInt(key) + 1) + '">';
            else
                html += '<input type="checkbox" checked onclick="updateToDo(this)" value="' + response.ToDoId + '" name="todo' + (parseInt(key) + 1) + '" id="todoCheck"' + (parseInt(key) + 1) + '">';
            html += '<label for="todoCheck' + (parseInt(key) + 1) + '"></label></div>';
            html += '<span class="text">' + response.TodoName + '</span></li>';
        });
        $("#toDoList").append(html);
    }
    function insertToDo(todoid,status,isUpdate) {
        if (isUpdate == 0 && $('#TodoName').val() == "") {
            $('#errToDoName').show();
            return false;
        }

            var obj = {
                "ToDoId": todoid,
                "UserId": sessionStorage.getItem("UserId"),
                "TodoName": (isUpdate == 1) ? "dummy":$('#TodoName').val(),
                "Todoliststatus": status,
                "CreatedDateTime": "",
                "UpdatedDateTime": ""
            }
            $.ajax({
                type: "POST",
                url: apiUrl + "Asset/InsertUpdateToDoList",
                dataType: 'json',
                data: obj,
                success: function (response) {
                    Swal.fire({
                        text: 'Success!',
                        icon: 'success',
                        showCancelButton: false,
                        showConfirmButton: false,
                        width: "20%",
                        height: "20%",
                        timer: 1500,
                    });
                    window.setTimeout(function () {
                     $('#TodoName').val("");
                     getToDoList();
                    }, 1600);
                },
                failure: function (response) {
                    alert(response.responseText);
                }
            });
    }
    $(document).ready(function () {

        sessionStorage.setItem("UserId",1);
        $('#liHomeBreadCrum').hide();
        $.ajax({
            url: apiUrl + "Asset/getAssetDashboardDetails?userid="+sessionStorage.getItem("UserId"),
            type: "GET",
            success: function (result) {
                debugger;
                sessionStorage.setItem("DashboardDetails",JSON.stringify(result));
                if (result.length > 0) {
                    console.log(result);
                    $('#TotalAssets').text(result[0].TotalAssetsCount);
                    $('#InStorageCount').text(result[0].InStorageAssetsCount);
                    $('#CheckoutCount').text(result[0].ChecoutAssetsCount);                  
                    $('#CheckinCount').text(result[0].CheckinAssetsCount);
                    $('#MaintenanceCount').text(result[0].MaintenanceAssetsCount);
                    $('#DisposeCount').text(result[0].DisposeAssetsCount);
                    $('#DamagedCount').text(result[0].BrokenAssetsCount);
                    $('#LossCount').text(result[0].LossAssetsCount);
                    $('#CheckInPendingCount').text(result[0].CheckinAssetsCount);                    
                    $('#TotalRequestedCount').text(result[0].TotalRequestedCount);
                    $('#WarrantyExpiry').text(result[0].WarrantyGoingToExpired);
                    $('#InsuranceExpiry').text(result[0].InsuranceGoingToExpired);
                    
                    $('#TotalPendingCount').text(result[0].TotalRequestOnHoldCount + "/" + result[0].TotalRequestedCount);
                    $('#TotalApprovedCount').text(result[0].TotalRequestApprovedCount + "/" + result[0].TotalRequestedCount);
                    $('#TotalRejectedCount').text(result[0].TotalRequestRejectedCount + "/" + result[0].TotalRequestedCount);
                    $('#TotalRequestedCount').css('width', (result[0].TotalRequestedCount > 0 ? 100 : ''));
                    $('#divReqApprovedWidth').css('width', (result[0].TotalRequestApprovedCount / result[0].TotalRequestedCount) * 100);
                    $('#divReqPendingWidth').css('width', (result[0].TotalRequestOnHoldCount / result[0].TotalRequestedCount) * 100);
                    $('#divReqRejectedWidth').css('width', (result[0].TotalRequestRejectedCount / result[0].TotalRequestedCount) * 100);
                }
                getToDoList();
            },
            error: function (errormessage) {
                $('#divLoader').hide();
                alert(errormessage.responseText);
            }
        });
    });
</script>
</asp:Content>

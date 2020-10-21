<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="view-asset-reports.aspx.cs" Inherits="AMS_V1.Views.view_asset_reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            color: black;
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
            text-align: center;
        }
    </style>
    <div id="view-asset-report" style="display:none;">
        <form class="form-horizontal" name="frmViewAssetReports" id="frmViewAssetReports" action="#">
            <div class="content">
                <div class="card">
                    <div class="form-group row" style="margin: 3%;">
                        <div class="col-md-6">
                            <div class="col-md-7">
                                <div class="small-box bg-blue-gradient">
                                    <div class="inner">
                                        <p class="mb-0 text-warning font-weight-bold">Total Assests </p>
                                        <p id="totalAssetCount" style="font-size: 32px; font-weight: 600;"></p>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="small-box bg-blue-gradient">
                                    <div class="inner">
                                        <p class="mb-0 text-warning font-weight-bold">Total Assests Cost </p>
                                        <p id="totalAssetCost" style="font-size: 28px; font-weight: 600;"></p>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-6">
                            <div id="pieChart"></div>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="row" style="margin: 3%; margin-top: 22%;">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10">
                                            <label for="txtAssetStatus" class="col-form-label">Asset Status</label>
                                            <select id='txtAssetStatus' class="form-control" required>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-5">
                                            <label for="txtFromYear" class="col-form-label">From Year</label>
                                            <input type="text" class="form-control" id="txtFromYear" name="txtFromYear" autocomplete="off" />
                                        </div>
                                        <div class="col-md-5">
                                            <label for="txtToYear" class="col-form-label">To Year</label>
                                            <input type="text" class="form-control" id="txtToYear" name="txtToYear" autocomplete="off" />
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-6"></div>
                                        <div class="col-md-5">
                                            <button type="submit" id="btnviewreport" name="btnviewreport"
                                                class="btn btn-info btn-sm">
                                                Generate Report</button>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="card h-100">
                            <div class="row" style="margin: 3%;">
                                <div class="col-md-12">
                                    <div id="barChart"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </div>
    <div class="card" style="margin-top: 250px !important; border-left: 2px solid #007bff; display:none" id="view-asset-report-no-records">
        <h6 class="text-center p-2" style="margin-top: .5rem;">There are no assets yet, <a href="add-asset.aspx"> Click here </a>to add new asset.</h6>
    </div>


    <script type="text/javascript">
        var apiUrl = "http://localhost:57080/api/";
        $("#txtFromYear").datepicker({
            format: "yyyy",
            viewMode: "years",
            minViewMode: "years",
            minDate: -1
        });
        $("#txtToYear").datepicker({
            format: "yyyy",
            viewMode: "years",
            minViewMode: "years"
        });

        $("#frmViewAssetReports").submit(function (e) {
            e.preventDefault();
            var id = $("#txtAssetStatus").val();
            var fromDate = $("#txtFromYear").val();
            var toDate = $("#txtToYear").val();
            if (toDate == "" || toDate == null || toDate == undefined) {
                var d = new Date();
                toDate = d.getFullYear();
                fromDate = (d.getFullYear() - 5);
            }

            $.ajax({
                url: apiUrl + "Asset/GetAssetStatusReport?statusId=" + id + "&fromDate=" + fromDate + "&toDate=" + toDate,
                type: "GET",
                success: function (result) {
                    debugger;
                    $("#barChart").empty();
                    if (result.length > 0) {
                        var report = result;
                        var data = [];
                        var name = [];
                        name.push('x');
                        data.push('cost')
                        report.forEach(function (e) {
                            name.push(e.year);
                            data.push(e.totalAssetCost);
                        })

                        var barChart = c3.generate({
                            data: {
                                x: 'x',
                                columns: [name, data],
                                groups: [
                                    ['cost']
                                ],
                                type: 'bar',
                                selection: {
                                    enabled: true
                                },
                                labels: true
                            },
                            bar: {
                                width: {
                                    ratio: 0.5
                                },
                            },
                            legend: {
                                show: false
                            },
                            axis: {
                                y: {
                                    show: true,
                                    label: {
                                        text: 'Cost Per Year',
                                        position: 'outer-middle'
                                    }
                                },
                                x: {
                                    show: true,
                                    label: {
                                        text: 'Year',
                                        position: 'outer-center'
                                    },
                                    type: 'category'
                                }
                            }
                        });
                        $("#barChart").append(barChart.element);
                    }
                    else {
                        alert("No data found");
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
        });
        function formatCurrency(total) {
            var neg = false;
            if (total < 0) {
                neg = true;
                total = Math.abs(total);
            }
            return parseFloat(total, 20).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString();
        }
        $('.currency-inr').each(function () {
            var monetary_value = $(this).text();
            var i = new Intl.NumberFormat('en-IN', {
                style: 'currency',
                currency: 'INR'
            }).format(monetary_value);
            $(this).text(i);
        });
        $(document).ready(function () {
            debugger;
            $('.li-dashboard').removeClass('active');
            $('.li-asset-report').addClass('active');

            function setOptions(id, results, val) {
                var options = $('#' + id);
                options.empty();
                options.append(
                        $('<option disabled></option>').val(-1).html("Select")
                    );
                $.each(results, function (key, object) {
                    options.append(
                        $('<option></option>').val(object[val + "Id"]).html(object[val + "Name"])
                    );
                });

            }

            $.ajax({
                url: apiUrl + "Asset/GetAssetTotalCountAndCost",
                type: "GET",
                success: function (result) {
                    debugger;
                    if (result.length > 0) {
                        var report = result[0];
                        if (report.totalAssetCount > 0) {
                            $('#totalAssetCount').text(report.totalAssetCount);
                            $('#totalAssetCost').text("RM " + formatCurrency(report.totalAssetCost));
                            $('#view-asset-report-no-records').hide();
                            $('#view-asset-report').show();
                        }
                        else {
                            alert("No records found");
                            $('#view-asset-report-no-records').show();
                            $('#view-asset-report').hide();
                        }
                    }
                    else {
                        alert("No records found");
                        $('#view-asset-report-no-records').show();
                        $('#view-asset-report').hide();
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            $.ajax({
                url: apiUrl + "Asset/GetAssetCountByStatus",
                type: "GET",
                success: function (result) {
                    debugger;
                    if (result.length > 0) {
                        var report = result;

                        var data = {};
                        var name = [];
                        report.forEach(function (e) {
                            name.push(e.statusName);
                            data[e.statusName] = e.statusCount;
                        })

                        var pieChart = c3.generate({
                            data: {
                                json: [data],
                                keys: {
                                    value: name,
                                },
                                type: 'bar'
                            },
                        });
                        $("#pieChart").append(pieChart.element);
                    }
                    else {
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
            $.ajax({
                url: apiUrl + "Asset/GetAssetStatus",
                type: "GET",
                success: function (result) {
                    debugger;
                    if (result.length > 0) {
                        var report = result;
                        setOptions("txtAssetStatus", result, "status");
                        $('#txtAssetStatus').val(1);
                        $("#frmViewAssetReports").submit();

                    }
                    else {
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });

        });

    </script>

</asp:Content>

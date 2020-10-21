<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="AMS_V1.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="content">
        <div class="card">
            <div class="card-body">
                <div class="row pb-2 border-bottom mb-3">
                    <div class="col-md-6">
                        <h4> <b> List of Assets </b></h4>
                    </div>
                    <div class="col-md-6 text-right">
                        <a class="btn btn-primary text-uppercase" runat="server" href="~/AddAsset"><i class="fas fa-plus"></i>Add Asset</a>
                    </div>
                </div>
                <table id="example1" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Sl.No </th>
                            <th>Image </th>
                            <th>Asset Tag</th>
                            <th>Asset Name </th>
                            <th>Category </th>
                            <th>Status </th>
                            <th>Actions </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox">
                                    1. 
                                </div>
                            </td>
                            <td class="py-2">
                                <img src="dist/img/assets/laptop.png" width="40" class="img-fluid mx-auto d-flex" />
                            </td>
                            <td>LAP108 </td>
                            <td>Lenovo Thinkpad T470  </td>
                            <td>Laptop </td>
                            <td><span class="text-green">Assigned </span></td>
                            <td>
                                <a href="~/ViewAsset" runat="server" class="btn btn-default btn-sm"><i class="far fa-eye text-blue"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-edit text-green"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-trash-alt text-red"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox">
                                    2. 
                                </div>
                            </td>
                            <td class="py-2">
                                <img src="dist/img/assets/desktop.png" width="40" class="img-fluid mx-auto d-flex" />
                            </td>
                            <td>PC1008 </td>
                            <td>Desktop computer  </td>
                            <td>Desktop </td>
                            <td><span class="text-orange">Under Repair </span></td>
                            <td>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-eye text-blue"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-edit text-green"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-trash-alt text-red"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox">
                                    3. 
                                </div>
                            </td>
                            <td class="py-2">
                                <img src="dist/img/assets/mouse.png" width="40" class="img-fluid mx-auto d-flex" />
                            </td>
                            <td>WM258 </td>
                            <td>Wired Mouse  </td>
                            <td>Mouse </td>
                            <td><span class="text-red">Missing </span></td>
                            <td>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-eye text-blue"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-edit text-green"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-trash-alt text-red"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox">
                                    4. 
                                </div>
                            </td>
                            <td class="py-2">
                                <img src="dist/img/assets/cpu.png" width="40" class="img-fluid mx-auto d-flex" />
                            </td>
                            <td>CPU320 </td>
                            <td>Hp CPU  </td>
                            <td>CPU </td>
                            <td><span class="text-purple">Under Repair </span></td>
                            <td>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-eye text-blue"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-edit text-green"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-trash-alt text-red"></i></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox">
                                    5. 
                                </div>
                            </td>
                            <td class="py-2">
                                <img src="dist/img/assets/chair.png" width="40" class="img-fluid mx-auto d-flex" />
                            </td>
                            <td>CH120 </td>
                            <td>Rolling Chair  </td>
                            <td>Chair </td>
                            <td><span class="text-danger">Broken  </span></td>
                            <td>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-eye text-blue"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-edit text-green"></i></a>
                                <a href="#" class="btn btn-default btn-sm"><i class="far fa-trash-alt text-red"></i></a>
                            </td>
                        </tr>

                    </tbody>
                    <%-- <tfoot>
                        <tr>
                            <th>Rendering engine</th>
                            <th>Browser</th>
                            <th>Platform(s)</th>
                            <th>Engine version</th>
                            <th>CSS grade</th>
                        </tr>
                    </tfoot>--%>
                </table>
            </div>
        </div>
    </div>
    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#example1").DataTable({
                "responsive": true,
                "autoWidth": false,
            });
        });
        $(document).ready(function () {
            $('.li-dashboard').removeClass('active');
            $('.li-asset').addClass('active');
        });
    </script>
</asp:Content>

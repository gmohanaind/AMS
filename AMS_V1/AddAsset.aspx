<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddAsset.aspx.cs" Inherits="AMS_V1.AddAsset" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <form class="form-horizontal">
            <div class="card-body col-form-label-right">
                <div class="pb-2 border-bottom mb-3">
                    <div class="col-md-6">
                        <h4> <b> Add Asset </b></h4>
                    </div>
                    <div class="col-md-6 text-right">
                        
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group row">
                            <label for="assetTagId" class="col-sm-4 col-form-label">Asset Tag ID <sup class="text-red">* </sup></label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="assetTagId" placeholder="Enter asset tag ID" required>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="assetName" class="col-sm-4 col-form-label">Asset Name <sup class="text-red">* </sup> </label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="assetName" placeholder="Enter asset name" required>
                            </div>
                        </div>                      
                        <div class="form-group row">
                            <label for="assetCost" class="col-sm-4 col-form-label">Asset Cost <sup class="text-red">* </sup> </label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="assetCost" placeholder="Enter Asset cost " required/>
                            </div>
                        </div>
                          <div class="form-group row">
                            <label for="assetType" class="col-sm-4 col-form-label">Asset Type </label>
                            <div class="col-sm-8">
                                <select class="form-control" id="assetType">
                                    <option> Fixed asset </option>
                                    <option> Non-Fixed asset </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="assetCategory" class="col-sm-4 col-form-label">Category  </label>
                            <div class="col-sm-8">
                                <select class="form-control" id="assetCategory">
                                    <option> Computer Equipments </option>
                                    <option> Softwares </option>
                                    <option> Furnitures </option>
                                </select>
                            </div>
                        </div>
                         <div class="form-group row">
                            <label for="department" class="col-sm-4 col-form-label">Department </label>
                            <div class="col-sm-8">
                                <select class="form-control" id="department">
                                    <option> Finance </option>
                                    <option> IT </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="location" class="col-sm-4 col-form-label">Location</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="location">
                                    <option>Kuala Lumpur </option>
                                    <option>Federal Territory </option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group row">
                            <label for="purchasedFrom" class="col-sm-4 col-form-label">Purchased From</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="purchasedFrom">
                                    <option> Venus Computers </option>
                                    <option>Super Furnitures </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="purchasedOn" class="col-sm-4 col-form-label">Purchased On </label>
                            <div class="col-sm-8">
                                <input type="date" class="form-control" id="purchasedOn" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="purchaseType" class="col-sm-4 col-form-label"> Purchase Type</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="purchaseType">
                                    <option> Owned </option>
                                    <option> Rent </option>
                                    <option> Lease  </option>
                                    <option> Loan </option>
                                    <option> Subscription  </option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="desc" class="col-sm-4 col-form-label">Description </label>
                            <div class="col-sm-8">
                                <textarea class="form-control" id="desc" rows="4" placeholder="Enter description"></textarea>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="assetImg" class="col-sm-4 col-form-label">Asset Image</label>
                            <div class="col-sm-8">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="assetImg">
                                    <label class="custom-file-label" for="customFile">Choose Image </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer float-right">
                    <button type="submit" class="btn btn-primary"> <i class="far fa-save"></i> Save </button>
                    <button type="submit" class="btn btn-default"> <i class="fas fa-times"></i> Cancel </button>
                </div>
            </div>
        </form>
    </div>
    <script src="plugins/jquery/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.li-dashboard').removeClass('active');
            $('.li-asset').addClass('active');
        });
    </script>
</asp:Content>

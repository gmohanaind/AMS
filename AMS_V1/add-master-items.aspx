<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="add-master-items.aspx.cs" Inherits="AMS_V1.Views.add_master_items" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script src="../Scripts/custom.js"></script>
   
    <style>
        .nav-link{
            padding : 0.5rem !important;
        }
    </style>
    <div class="content">
        <div class="card-body bg-white">
            <div class="spinner" align="center" id="divLoader" style="display: none">
                <div class="text-info" style="margin: 15%;">
                    <i class="fa fa-spinner fa-spin" style="font-size: 28px !important;"></i>
                    <p style="font-size: 18px !important;">Please wait a while! Fetching Assets .........</p>
                </div>
            </div>
            <div class="clearfix">
                <div class="nav nav-tabs nav-tabs-2" id="myTab" role="tablist">
                    <a class="nav-item nav-link clsCategory" id="category" href="#" role="tab" aria-controls="profile" aria-selected="false">Categories</a>
                    <a class="nav-item nav-link clsSubCategory" id="subcategory" href="#" role="tab" aria-controls="profile" aria-selected="false">Sub Categories</a>
                    <a class="nav-item nav-link clsSites" id="sites" href="#" role="tab" aria-controls="profile" aria-selected="false">Sites</a>
                    <a class="nav-item nav-link clsLocations" id="locations" href="#" role="tab" aria-controls="profile" aria-selected="false">Locations</a>
                    <a class="nav-item nav-link clsDepartments" id="departments" href="#" role="tab" aria-controls="profile" aria-selected="false">Departments</a>
                    <a class="nav-item nav-link clsDeptLocMapping" id="locDeptLocMapping" href="#" role="tab" aria-controls="profile" aria-selected="false">Location & Department Mapping</a>
                    <a class="nav-item nav-link clsPurchasedTypes" id="purchasedtypes" href="#" role="tab" aria-controls="profile" aria-selected="false">Purchase Types</a>
                    <a class="nav-link clsVendors" id="vendors" href="#" role="tab" aria-controls="profile" aria-selected="false">Vendors</a>
                    <a class="nav-link clsInsurance" id="insurance" href="#" role="tab" aria-controls="profile" aria-selected="false">Insurance</a>
                </div>
                <% Response.WriteFile("view-category.html"); %>
                <% Response.WriteFile("add-master-items.html"); %>
            </div>

        </div>
    </div>
</asp:Content>


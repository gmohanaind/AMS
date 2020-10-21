using AMS_V1.Models;
using Newtonsoft.Json;
using System;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Web.Services;
using AMS_V1.Helper;
using System.IO;
using System.Collections.Generic;

namespace AMS_V1.Views
{
    public partial class edit_asset : System.Web.UI.Page
    {
        CallAPIGetAndPostMethod _objHelper = new CallAPIGetAndPostMethod();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }
        protected void udpateAssetDetails(object sender, EventArgs e)
        {
            asyncUpdateAsset();
        }
        
        public async void asyncUpdateAsset()
        {
            try
            {
                var asset = new clsAssetMaster();
                asset.AssetId = Convert.ToInt32(hdnAssetIdForEdit.Value);
                var assetTagTypeId = Request.Form["ctl00$MainContent$ddlTagIdType".ToString()];
                asset.AssetTagTypeId = (assetTagTypeId == "") ? 0 : Convert.ToInt16(assetTagTypeId);
                asset.AssetTagId = Request.Form["ctl00$MainContent$assetTagId"];
                asset.AssetName = assetName.Value;
               // asset.AssetTagTypeId = Convert.ToInt32(ddlTagIdType.SelectedItem.Value);
                asset.AssetCost = (assetCost.Value == "") ? 0 : Convert.ToDecimal(assetCost.Value);
                asset.AssetTypeId = (ddlAssetTypes.SelectedValue == "") ? 0 : Convert.ToInt16(ddlAssetTypes.SelectedValue);
                asset.AssetStatusId = 1;
                var categoryId = Request.Form["ctl00$MainContent$ddlAssetCategories".ToString()];
                asset.CategoryId = (categoryId == "") ? 0 : Convert.ToInt16(categoryId);
                var subCategoryId = Request.Form["ctl00$MainContent$ddlSubCategories".ToString()];
                asset.SubCategoryId = (subCategoryId == "") ? 0 : Convert.ToInt16(subCategoryId);
                var sId = Request.Form["ctl00$MainContent$ddlAssetSites".ToString()];
                var siteId = Request.Form["ctl00$MainContent$ddlAssetSites".ToString()];
                asset.SiteId = (siteId == "") ? 0 : Convert.ToInt16(siteId);
                var locationId = Request.Form["ctl00$MainContent$ddlAssetLocations".ToString()];
                asset.LocationId = (locationId == "") ? 0 : Convert.ToInt16(locationId);
                var departmentId = Request.Form["ctl00$MainContent$ddlAssetDepartments".ToString()];
                asset.DepartmentId = (departmentId == "") ? 0 : Convert.ToInt16(departmentId);
                var vendorId = Request.Form["ctl00$MainContent$ddlVendor".ToString()];
                asset.VendorId = (vendorId == "") ? 0 : Convert.ToInt16(vendorId);
                asset.PurchasedOn = (purchasedOn.Value == "") ? DateTime.Now : Convert.ToDateTime(purchasedOn.Value);
                var purchasedtypeId = Request.Form["ctl00$MainContent$ddlPurchasedType".ToString()];
                asset.PurchasedTypeId = (purchasedtypeId == "") ? 0 : Convert.ToInt16(purchasedtypeId);
                var insuranceId = Request.Form["ctl00$MainContent$ddlAssetInsurance".ToString()];
                asset.InsuranceId = (insuranceId == "") ? 0 : Convert.ToInt16(insuranceId);
                asset.WarrantyYears = (txtWarrantyYears.Value == "") ? 0 : Convert.ToInt16(txtWarrantyYears.Value);
                asset.WarrantyMonths = (txtWarrantyMonths.Value == "") ? 0 : Convert.ToInt16(txtWarrantyMonths.Value);
                asset.WarrantyDays = (txtWarrantyDays.Value == "") ? 0 : Convert.ToInt16(txtWarrantyDays.Value);
                asset.WarrantyExpirationDate = (txtWarrantyExpiry.Value == "") ? DateTime.Now : Convert.ToDateTime(txtWarrantyExpiry.Value);
                asset.WarrantyDetails = warrantyDetails.Value;
                asset.Description = description.Value;
                asset.ImageUrl = "";
                asset.CreatedBy = 1;
                asset.IsDeleted = false;
                var json = JsonConvert.SerializeObject(asset);
                var data = new StringContent(json, Encoding.UTF8, "application/json");
                int result = await _objHelper.insertData("Asset/insertAssetMaster", data);
                //hdnAssetId.Value = result.ToString();
                if (result > 0)
                {
                    if (FileUpload1.HasFile)
                    {
                        //string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                        string fileExtension = Path.GetExtension(FileUpload1.PostedFile.FileName);
                        string fileName = result + ".png";
                        if (!Directory.Exists(Server.MapPath("~/AssetImages/")))
                            Directory.CreateDirectory(Server.MapPath("~/AssetImages/"));
                        FileUpload1.PostedFile.SaveAs(Server.MapPath("~/AssetImages/") + fileName);
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
        protected void updateGlobalFields(object sender, EventArgs e)
        {
            asynUpdateGlobalFields();
        }

        [WebMethod]
        public async void asynUpdateGlobalFields()
        {
            try
            {              
                int globalFieldsCount = (hdnGlobalFiedCount.Value == "") ? 0 : Convert.ToInt16(hdnGlobalFiedCount.Value);
                if (globalFieldsCount > 0)
                {
                    int assetId = Convert.ToInt32(hdnAssetIdForEdit.Value);
                    List<clsAssetGlobalFieldValue> lstGlobalFields = new List<clsAssetGlobalFieldValue>();

                    string isValueContain = hdnIsGlobalFiedlContainValues.Value;
                    if (isValueContain == "0")
                    {
                        for (int rowIdx = 1; rowIdx <= Convert.ToInt16(globalFieldsCount); rowIdx++)
                        {
                            clsAssetGlobalFieldValue objGlobalFields = new clsAssetGlobalFieldValue();
                            string fieldname = Request.Form["hdnFieldName_" + rowIdx.ToString()];
                            string fieldvalue = Request.Form["txtGlobalFiled_" + rowIdx.ToString()];
                            int fieldid = Convert.ToInt16(Request.Form["hdn_" + rowIdx.ToString()]);
                            if (fieldname != "" && fieldvalue != "")
                            {
                                objGlobalFields.MappingId = 0;
                                objGlobalFields.AssetId = assetId;
                                objGlobalFields.FieldId = fieldid;
                                objGlobalFields.FieldName = fieldname;
                                objGlobalFields.Value = fieldvalue;
                                lstGlobalFields.Add(objGlobalFields);
                            }
                        }
                    }
                    else
                    {
                        for (int rowIdx = 1; rowIdx <= Convert.ToInt16(globalFieldsCount); rowIdx++)
                        {
                            clsAssetGlobalFieldValue objGlobalFields = new clsAssetGlobalFieldValue();
                            string fieldvalue = Request.Form["txtGlobalFiled_" + rowIdx.ToString()];
                            int mappingId = Convert.ToInt32(Request.Form["hdn_" + rowIdx.ToString()]);
                            if (fieldvalue != "")
                            {
                                objGlobalFields.MappingId = mappingId;
                                objGlobalFields.AssetId = assetId;
                                objGlobalFields.FieldId = 0;
                                objGlobalFields.FieldName = "";
                                objGlobalFields.Value = fieldvalue;
                                lstGlobalFields.Add(objGlobalFields);
                            }
                        }
                    }




                   
                    var json1 = JsonConvert.SerializeObject(lstGlobalFields);
                    var data1 = new StringContent(json1, Encoding.UTF8, "application/json");
                    int result1 = await _objHelper.insertData("Asset/InsertAssetGlobalFieldValues", data1);
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void updateCustomFields(object sender, EventArgs e)
        {
            asynUpdateCustomFieldss();
        }

        [WebMethod]
        public async void asynUpdateCustomFieldss()
        {
            try
            {
                int custRowCount = (hdnRow.Value == "") ? 0 : Convert.ToInt16(hdnRow.Value);
                if (custRowCount > 0)
                {
                    int assetId = Convert.ToInt32(hdnAssetIdForEdit.Value);
                    List<clsAssetCustomFields> lstCustFields = new List<clsAssetCustomFields>();
                    for (int rowIdx = 1; rowIdx <= custRowCount; rowIdx++)
                    {
                        clsAssetCustomFields objCustFields = new clsAssetCustomFields();
                        int CustomFieldId = Convert.ToInt32(Request.Form["hdnCustomField_" + rowIdx.ToString()]);
                        string labelName = Request.Form["txtCustomFieldName_" + rowIdx.ToString()];
                        string cusValue = Request.Form["txtCustomFieldValue_" + rowIdx.ToString()];
                        if (labelName != "" && cusValue != "")
                        {
                            objCustFields.assetId = assetId;
                            objCustFields.CustomFieldId = CustomFieldId;
                            objCustFields.CustomFieldLabelName = labelName;
                            objCustFields.CustomFieldValue = cusValue;
                            lstCustFields.Add(objCustFields);
                        }
                    }
                    var json1 = JsonConvert.SerializeObject(lstCustFields);
                    var data1 = new StringContent(json1, Encoding.UTF8, "application/json");
                    int result1 = await _objHelper.insertData("Asset/addCustomFieldsForAsset", data1);
                }
            }
            catch (Exception ex)
            {

            }
        }



    }
}
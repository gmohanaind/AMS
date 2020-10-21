using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Net;
using System.Net.Http;
using System.IO;
using Newtonsoft.Json.Linq;
using AMS_V1.Models;
using System.Text;
using AMS_V1.Helper;
using System.Data;
using System.Threading.Tasks;
using System.Web.Services;

namespace AMS_V1.Views
{
    public partial class add_asset : System.Web.UI.Page
    {
        CallAPIGetAndPostMethod _objHelper = new CallAPIGetAndPostMethod();
        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string retVal = await (Task<string>)_objHelper.executeScalar("Asset/autoIncrementAssetTagId");
                if(retVal.Length > 0)
                {
                    string strRetVal = retVal.Replace("\"", "");
                    if(strRetVal.Length > 0)
                    {
                        string strAssetTagId = (Convert.ToInt16(strRetVal.Substring(5, strRetVal.Length - 5)) + 1).ToString();
                        if (strAssetTagId.Length > 0)
                            hdnNextAssetTagId.Value = strRetVal.Substring(0, 5) + strAssetTagId;
                        else
                            hdnNextAssetTagId.Value = 0.ToString();
                    }                   
                }
            }
        }
        protected void saveAsset(object sender, EventArgs e)
        {
                asyncSaveAsset();
        }

        [WebMethod]
        public async void asyncSaveAsset()
        {
            try
            {
                var asset = new clsAssetMaster();
                asset.AssetId = 0;

                asset.AssetTagTypeId = Convert.ToInt16(Request.Form["ddlTagIdType"]);
                if(asset.AssetTagTypeId == 1)
                    asset.AssetTagId = hdnNextAssetTagId.Value;
                else
                    asset.AssetTagId = Request.Form["assetTagId"];


                asset.AssetName = assetName.Value;
                asset.AssetCost = Convert.ToDecimal(assetCost.Value);
                asset.AssetTypeId = (ddlAssetTypes.SelectedValue == "") ? 0 :Convert.ToInt16(ddlAssetTypes.SelectedValue);
                asset.AssetStatusId = 1;
                var categoryId = Request.Form["ctl00$MainContent$ddlAssetCategories".ToString()];
                asset.CategoryId = Convert.ToInt16(categoryId);
                var subCategoryId = Request.Form["ctl00$MainContent$ddlSubCategories".ToString()];
                asset.SubCategoryId = Convert.ToInt16(subCategoryId);
                var siteId = Request.Form["ctl00$MainContent$ddlAssetSites".ToString()];
                asset.SiteId = Convert.ToInt16(siteId);
                var locationId = Request.Form["ctl00$MainContent$ddlAssetLocations".ToString()];
                asset.LocationId = Convert.ToInt16(locationId);
                var departmentId = Request.Form["ctl00$MainContent$ddlAssetDepartments".ToString()];
                asset.DepartmentId = Convert.ToInt16(departmentId);
                var vendorId = Request.Form["ctl00$MainContent$ddlVendor".ToString()];
                asset.VendorId = Convert.ToInt16(vendorId);
                asset.PurchasedOn = (purchasedOn.Value == "")?DateTime.Now:Convert.ToDateTime(purchasedOn.Value);
                var purchasedtypeId = Request.Form["ctl00$MainContent$ddlPurchasedType".ToString()];
                asset.PurchasedTypeId = Convert.ToInt16(purchasedtypeId);
                var insuranceId = Request.Form["ctl00$MainContent$ddlAssetInsurance".ToString()];
                asset.InsuranceId =  Convert.ToInt16(insuranceId);
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
                int result = await _objHelper.insertData("Asset/insertAssetMaster",data);
                //var url = "http://localhost:57080/api/Asset/insertAssetMaster";
                //var client = new HttpClient();

                //var response = await client.PostAsync(url, data);

                //string result = response.Content.ReadAsStringAsync().Result;
                hdnAssetId.Value = result.ToString();
                if(result > 0)
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
                    string custRow = hdnRow.Value;
                    if (Convert.ToInt16(custRow) > 0)
                    {
                        List<clsAssetCustomFields> lstCustFields = new List<clsAssetCustomFields>();
                        for (int rowIdx = 1; rowIdx <= Convert.ToInt16(custRow); rowIdx++)
                        {
                            clsAssetCustomFields objCustFields = new clsAssetCustomFields();
                            string labelName = Request.Form["txtCustomFieldName_" + rowIdx.ToString()];
                            string cusValue = Request.Form["txtCustomFieldValue_" + rowIdx.ToString()];
                            if (labelName != "" && cusValue != "")
                            {
                                objCustFields.assetId = result;
                                objCustFields.CustomFieldLabelName = labelName;
                                objCustFields.CustomFieldValue = cusValue;
                                lstCustFields.Add(objCustFields);
                            }
                        }
                        var json1 = JsonConvert.SerializeObject(lstCustFields);
                        var data1 = new StringContent(json1, Encoding.UTF8, "application/json");
                        int result1 = await _objHelper.insertData("Asset/addCustomFieldsForAsset", data1);
                    }

                    //Global Fields
                    int globalFieldsCount = (hdnGlobalFiedCount.Value == "") ? 0 : Convert.ToInt16(hdnGlobalFiedCount.Value);
                    if (globalFieldsCount > 0)
                    {
                        List<clsAssetGlobalFieldValue> lstGlobalFields = new List<clsAssetGlobalFieldValue>();
                        for (int rowIdx = 1; rowIdx <= Convert.ToInt16(globalFieldsCount); rowIdx++)
                        {
                            clsAssetGlobalFieldValue objGlobalFields = new clsAssetGlobalFieldValue();
                            string fieldname = Request.Form["hdnFieldName_" + rowIdx.ToString()];
                            string fieldvalue = Request.Form["txtGlobalFiled_" + rowIdx.ToString()];
                            int fieldid = Convert.ToInt16(Request.Form["hdn_" + rowIdx.ToString()]);
                            if (fieldname != "" && fieldvalue != "")
                            {
                                objGlobalFields.MappingId = 0;
                                objGlobalFields.AssetId = result;
                                objGlobalFields.FieldId = fieldid;
                                objGlobalFields.FieldName = fieldname;
                                objGlobalFields.Value = fieldvalue;
                                lstGlobalFields.Add(objGlobalFields);
                            }
                        }
                        var json1 = JsonConvert.SerializeObject(lstGlobalFields);
                        var data1 = new StringContent(json1, Encoding.UTF8, "application/json");
                        int result1 = await _objHelper.insertData("Asset/InsertAssetGlobalFieldValues", data1);
                    }
                }
                Response.Redirect("~/view-assets.aspx");
            }
            catch(Exception ex)
            {

            }
        }
    }
}
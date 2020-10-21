using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AMS_V1.Models
{
    public class AssetMaster
    {
    }

    public class clsAssetMaster
    {
        public int AssetId = 0;
        public int AssetTagTypeId = 1;
        public string AssetTagId { get; set; }
        public string AssetName { get; set; }
        public decimal AssetCost = Convert.ToDecimal("0.0");
        public int AssetTypeId { get; set; }
        public int AssetStatusId = 1;
        public int CategoryId = 0;
        public int SubCategoryId = 0;
        public int SiteId = 0;
        public int LocationId = 0;
        public int DepartmentId = 0;
        public int VendorId = 0;
        public DateTime PurchasedOn { get; set; }
        public int PurchasedTypeId = 0;
        public string Description = string.Empty;
        public string ImageUrl = string.Empty;
        public int CreatedBy { get; set; }
        public int InsuranceId { get; set; }
        public int WarrantyYears { get; set; }
        public int WarrantyMonths { get; set; }
        public int WarrantyDays { get; set; }
        public DateTime WarrantyExpirationDate { get; set; }
        public string WarrantyDetails = string.Empty;
        public bool IsDeleted = false;
        public List<clsAssetCustomFields> objCustomFields { get; set; }
    }
    public class clsAssetCustomFields
    {
        public int CustomFieldId = 0;
        public int assetId { get; set; }
        public string CustomFieldLabelName { get; set; }
        public string CustomFieldValue { get; set; }
    }
    public class clsAssetGlobalFieldValue
    {
        public int MappingId { get; set; }
        public int AssetId { get; set; }
        public int FieldId { get; set; }
        public string FieldName { get; set; }
        public string Value { get; set; }
        public bool IsDeleted { get; set; }
    }
}
USE [AMSV1]
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_AutoIncrementAssetTagId]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_AutoIncrementAssetTagId]
AS
BEGIN
	IF EXISTS (SELECT AssetTagId FROM ams_tblAssetMaster WHERE AssetTagTypeId =  1)
	BEGIN
		SELECT Top 1 AssetTagId AS AssetTagId FROM ams_tblAssetMaster WHERE AssetTagTypeId =  1
		Order By AssetId DESC
	END
	ELSE 
	BEGIN
		SELECT 'ASS2020099' AS AssetTagId
	END
END


GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAllAssetCategories]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetAllAssetCategories]
AS
BEGIN
	SELECT categoryId,categoryName,description,isDeleted,createdBy,createdDate FROM 
	ams_tblCategoryMaster
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAllAssetDepreciations]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetAllAssetDepreciations]
AS
BEGIN
	SELECT depMethodId,depName,description,isDeleted,createdBy,createdDate
	FROM [dbo].[ams_tblDepreciationMethodMaster]
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAllAssetStatus]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetAllAssetStatus]
@categoryId int
AS
BEGIN
	SELECT statusId,statusName,description,isDeleted FROM [dbo].[ams_tblAssetStatusMaster]
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAllInsurancePolicies]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetAllInsurancePolicies]
AS
BEGIN
	SELECT insuranceId,policyNumber,policyName,coverageAmount,startDate,endDate,
	premium,ISNULL(description,'') AS description,ISNULL(insuranceCompany,'') AS insuranceCompany,
	ISNULL(contactPerson,'') AS contactPerson,ISNULL(contactNumber,'') AS contactNumber
	 ,ISNULL(contactEmail,'') AS contactEmail, isDeleted,createdBy,createdDate  FROM [dbo].[ams_tblInsurancePolicyMaster]
END

GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAllPurchasedTypes]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AMS_USP_GetAllPurchasedTypes]
AS
BEGIN
	SELECT * FROM ams_tblAssetPurchasedTypeMaster
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAllUsers]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetAllUsers]
AS
BEGIN
	SELECT * FROM ams_tblUsers
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAssetCustomDetails]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetAssetCustomDetails]
@assestId INT
AS
BEGIN
SELECT	CustomFieldName,CustomFieldValue
FROM	[dbo].asm_tblAssetCustomFieldMapping
WHERE	AssetId = @assestId
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAssetDepartments]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AMS_USP_GetAssetDepartments]
@locationId INT
AS
BEGIN
	IF(@locationId =0)
	BEGIN
		SELECT DM.deptID, deptName, description, DM.isDeleted, DM.CreatedBy, DM.CreatedDate 
		FROM [dbo].[ams_tblDepartmentMaster] DM
	END
	ELSE
	BEGIN
		SELECT DM.deptID, deptName, description, DM.isDeleted, DM.CreatedBy, DM.CreatedDate 
		FROM [dbo].[ams_tblDepartmentMaster] DM
		JOIN [dbo].[ams_tblLocationDepartmentMapping] LDM ON LDM.deptId = DM.deptId
		WHERE LDM.locationId = @locationId
	END
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAssetDetail]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetAssetDetail]
@assestId INT
AS
BEGIN
	SELECT AssetId,AssetTagTypeId,AssetTagId,AssetName,AssetCost,
	AM.AssetStatusId,StatusName,
	AM.AssetTypeId,ISNULL(AssetType,'') AS AssetType,
	AM.CategoryId,ISNULL(CategoryName,'') AS CategoryName,
	AM.SubCategoryId,ISNULL(SubCategoryName,'') AS SubCategoryName,
	AM.SiteId,'' AS SiteName,
	AM.LocationId,'' AS LocationName,
	AM.DepartmentId,'' AS DepartmentName,
	AM.VendorId,'' AS VendorName,
	PurchasedOn,
	PurchasedTypeId,'' AS PurchasedType,
	AM.Description,AM.CreatedDate, ImageUrl,AM.IsDeleted
	FROM [ams_tblAssetMaster] AM
	LEFT JOIN [dbo].[ams_tblAssetStatusMaster] ASM ON ASM.statusId = AM.AssetStatusId
	LEFT JOIN [dbo].[ams_tblAssetTypeMaster] ATM ON ATM.assetTypeId = AM.AssetTypeId
	LEFT JOIN [dbo].[ams_tblCategoryMaster] CM ON CM.CategoryId = AM.CategoryId
	LEFT JOIN [dbo].[ams_tblSubCategoryMaster] SCM ON SCM.subCategoryId = AM.SubCategoryId
	WHERE AssetId = @assestId
END

GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAssetsForCheckin]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetAssetsForCheckin]
AS
	
BEGIN
	--SELECT * from [dbo].[ams_tblAssetCheckoutAndCheckInStatus]
	SELECT UniqueId,AssetId, StatusId,PersonOrSite, PersonId, Personname,
	CONVERT(VARCHAR(10),CheckoutDate,103) AS CheckoutDate,CONVERT(VARCHAR(10),DueDate,103) AS DueDate,CheckoutRemarks,
	'' AS CheckinDate,
	--CAST(CheckoutDate AS NVARCHR,DueDate,
	isnull(CCS.SiteId,0) AS SiteId, ISNULL(SiteName,'') AS SiteName,
	isnull(CCS.LocationId,0) AS LocationId,ISNULL(LocationName,'') AS LocationName,
	isnull(CCS.DeptId,0) AS DepartmentId, ISNULL(deptName,'') AS DepartmentName,
	'' AS CheckinRemarks
	FROM ams_tblAssetCheckoutAndCheckInStatus CCS
	LEFT JOIN [dbo].[ams_tblSiteMaster] SM ON SM.siteId = CCS.SiteId
	LEFT JOIN [dbo].[ams_tblLocationMaster] LM ON LM.LocationId = CCS.LocationId
	LEFT JOIN [dbo].[ams_tblDepartmentMaster] DM ON DM.deptId = CCS.DeptId
	WHERE CCS.StatusId = 2 AND isReturned = 0
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetAssetTypes]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AMS_USP_GetAssetTypes]
AS
BEGIN
	SELECT * FROM ams_tblAssetTypeMaster
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetPurchasedTypes]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetPurchasedTypes]
AS
BEGIN
	SELECT * FROM ams_tblAssetPurchasedTypeMaster
END

GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetSubCategories]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetSubCategories]
@categoryId int
AS
BEGIN
	IF(@categoryId = 0)
	BEGIN
		SELECT subCategoryId,SCM.categoryId,categoryName,subCategoryName,SCM.description,SCM.isDeleted,SCM.createdBy,SCM.createdDate
		FROM ams_tblSubCategoryMaster SCM
		JOIN ams_tblCategoryMaster CM ON CM.categoryId = SCM.categoryId
	END
	ELSE
	BEGIN
		SELECT subCategoryId,SCM.categoryId,categoryName, subCategoryName,SCM.description,SCM.isDeleted,SCM.createdBy,SCM.createdDate
		FROM ams_tblSubCategoryMaster SCM
		JOIN ams_tblCategoryMaster CM ON CM.categoryId = SCM.categoryId
		WHERE SCM.categoryId = @categoryId
	END
END

GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_GetVendors]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_GetVendors]
@vendorId INT
AS
BEGIN
	IF(@vendorId =0)
	BEGIN
		SELECT vendorId,vendorName,address,city,VM.stateId,stateName,VM.countryId,countryName,contactPerson,email,
		contactNumber,fax,websiteURL 
		FROM ams_tblVendorMaster VM
			JOIN ams_tblStateMaster SM ON VM.stateId = SM.stateId
			JOIN AMS_tblCountryMaster CM ON CM.countryId = VM.countryId
		WHERE VM.isDeleted = 0
	END
	ELSE
	BEGIN
		SELECT vendorId,vendorName,address,city,VM.stateId,stateName,VM.countryId,countryName,contactPerson,email,
		contactNumber,fax,websiteURL 
		FROM ams_tblVendorMaster VM
			JOIN ams_tblStateMaster SM ON VM.stateId = SM.stateId
			JOIN AMS_tblCountryMaster CM ON CM.countryId = VM.countryId
		WHERE VM.isDeleted = 0 AND vendorId = @vendorId
	END
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_Insert_AssetCustomFieldMapping]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AMS_USP_Insert_AssetCustomFieldMapping]
@CustomFieldId int,
@AssetId int,
@CustomFieldName nvarchar(50),
@CustomFieldValue nvarchar(50),
@IsDeleted bit,
@CreateBy int
AS
BEGIN
	INSERT INTO [dbo].[asm_tblAssetCustomFieldMapping]
           (
			   [AssetId]
			   ,[CustomFieldName]
			   ,[CustomFieldValue]
			   ,[IsDeleted]
			   ,[CreateBy]
			   ,[CreatedDate]
		   )
     VALUES
           (
				@AssetId ,
				@CustomFieldName,
				@CustomFieldValue ,
				@IsDeleted ,
				@CreateBy ,
				GETDATE()
		   )
END

GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_InsertAssetCheckoutAndCheckInStatus]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_InsertAssetCheckoutAndCheckInStatus]
@UniqueId int,
@AssetId int,
@StatusId int,
@PersonOrSite int,
@PersonId int,
@SiteId int,
@DepartmentId int,
@LocationId int,
@Personname nvarchar(100),
@CheckoutDate DateTime,
@CheckinDate DateTime,
@DueDate DateTime,
@CheckoutRemarks nvarchar(1000),
@CheckinRemarks	 nvarchar(1000),
@insertedValue int output
AS
BEGIN
	IF(@UniqueId = 0 or @StatusId = 3)
	BEGIN
		INSERT INTO [dbo].[ams_tblAssetCheckoutAndCheckInStatus]
           ([AssetId]
           ,[StatusId]
           ,[PersonOrSite]
           ,[PersonId]
		   ,[SiteId]
		   ,[LocationId]
		   ,[DeptId]
           ,[Personname]
           ,[CheckoutDate]
           ,[CheckinDate]
           ,[DueDate]
           ,[CheckoutRemarks]
           ,[CheckinRemarks])
		VALUES
           (
				@AssetId,
				@StatusId,
				@PersonOrSite,
				@PersonId,
				@SiteId,
				@LocationId,
				@DepartmentId,
				@Personname,
				@CheckoutDate,
				@CheckinDate,
				@DueDate,
				@CheckoutRemarks,
				@CheckinRemarks
		   )

		   SET @insertedValue = scope_identity()

			IF(@StatusId = 3)
				UPDATE [ams_tblAssetCheckoutAndCheckInStatus] SET IsReturned  = 1 WHERE UniqueId = @UniqueId
	END

	
	
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_InsertAssetCustomFields]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_InsertAssetCustomFields]
@AssetID int,
@CustomFieldName nvarchar(50),
@CustomFieldValue nvarchar(50)
AS
BEGIN
	INSERT INTO [asm_tblAssetCustomFieldMapping](AssetId,CustomFieldName,CustomFieldValue)
	VALUES(@AssetID,@CustomFieldName,@CustomFieldValue)
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_InsertAssetMaster]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_InsertAssetMaster]
@AssetId int,
@AssetTagTypeId int,
@AssetTagId nvarchar(10),
@AssetName nvarchar(100),
@AssetCost decimal(10,2),
@AssetStatusId int,
@AssetTypeId int,
@CategoryId int,
@SubCategoryId int,
@SiteId int,
@LocationId int,
@DepartmentId int,
@VendorId int,
@PurchasedOn Date,
@PurchasedTypeId int,
@Description nvarchar(1000),
@ImageUrl nvarchar(500),
@CreatedBy int,
@IsDeleted Bit,
@insertedValue int output
AS
BEGIN
IF @AssetId = 0
BEGIN
INSERT INTO [dbo].[ams_tblAssetMaster]
           ([AssetTagTypeId]
           ,[AssetTagId]
           ,[AssetName]
           ,[AssetCost]
           ,[AssetStatusId]
		   ,[AssetTypeId]
           ,[CategoryId]
           ,[SubCategoryId]
           ,[SiteId]
           ,[LocationId]
           ,[DepartmentId]
           ,[VendorId]
           ,[PurchasedOn]
           ,[PurchasedTypeId]
           ,[Description]          
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsDeleted])
     VALUES
           (			
				@AssetTagTypeId,
				@AssetTagId,
				@AssetName,
				@AssetCost,
				@AssetStatusId,
				@AssetTypeId,
				@CategoryId,
				@SubCategoryId,
				@SiteId,
				@LocationId,
				@DepartmentId,
				@VendorId,
				@PurchasedOn,
				@PurchasedTypeId,
				@Description,				
				@CreatedBy,
				GETDATE(),
				@IsDeleted 
		   )
		   SET @insertedValue = SCOPE_IDENTITY();
		   UPDATE [ams_tblAssetMaster] SET ImageUrl = '/AssetImages/' + CAST(@insertedValue AS nvarchar) +'.png' WHERE AssetId = @insertedValue
	END
	ELSE
	BEGIN
		UPDATE ams_tblAssetMaster SET 
			AssetTypeId = @AssetTypeId,
			CategoryId = @CategoryId,
			SubCategoryId = @SubCategoryId,
			SiteId = @SiteId,
			LocationId=@LocationId,
			DepartmentId = @DepartmentId,
			VendorId = @VendorId,
			[PurchasedOn] = @PurchasedOn
           ,[PurchasedTypeId] = @PurchasedTypeId
           ,[Description] = @Description
           ,[ImageUrl] = @ImageUrl
		WHERE AssetId = @AssetId
		SET @insertedValue = @AssetId;

	END
END

GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_SelectAllAssets]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AMS_USP_SelectAllAssets]
AS
BEGIN
	SELECT AM.AssetId,AssetTagTypeId,AssetTagId,AssetName,AssetCost,
	ISNULL(ACICO.statusid, 1) AS AssetStatusId,ISNULL(StatusName, 'Available') AS StatusName,
	AM.AssetTypeId,ISNULL(AssetType,'') AS AssetType,
	AM.CategoryId,ISNULL(CategoryName,'') AS CategoryName,
	AM.SubCategoryId,ISNULL(SubCategoryName,'') AS SubCategoryName,
	AM.SiteId,'' AS SiteName,
	AM.LocationId,'' AS LocationName,
	AM.DepartmentId,'' AS DepartmentName,
	AM.VendorId,'' AS VendorName,
	PurchasedOn,
	PurchasedTypeId,'' AS PurchasedType,
	AM.Description,AM.CreatedDate, '' AS ImageUrl,AM.IsDeleted
	FROM [ams_tblAssetMaster] AM
	LEFT JOIN [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ACICO ON  ACICO.AssetId = AM.AssetId
	LEFT JOIN [dbo].[ams_tblAssetStatusMaster] ASM ON ASM.statusId = ACICO.statusId
	LEFT JOIN [dbo].[ams_tblAssetTypeMaster] ATM ON ATM.assetTypeId = AM.AssetTypeId
	LEFT JOIN [dbo].[ams_tblCategoryMaster] CM ON CM.CategoryId = AM.CategoryId
	LEFT JOIN [dbo].[ams_tblSubCategoryMaster] SCM ON SCM.subCategoryId = AM.SubCategoryId
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_SelectLocationMaster]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_SelectLocationMaster]
AS
BEGIN
	SELECT LocationId,LocationName,LM.SiteId,SiteName,LM.Address,LM.City,LM.StateId,StateName,
	LM.CountryId,CountryName,LM.IsDeleted
	FROM ams_tblLocationMaster LM
	JOIN [ams_tblSiteMaster] SM ON SM.SiteId = LM.SiteId
	JOIN ams_tblCountryMaster CM ON CM.CountryId = SM.CountryId
	JOIN ams_tblStateMaster STM ON STM.stateId = SM.stateId
	WHERE LM.IsDeleted = 0
END
GO
/****** Object:  StoredProcedure [dbo].[AMS_USP_SelectSiteMaster]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AMS_USP_SelectSiteMaster]
AS
BEGIN
	SELECT SiteId,SiteName,Address,City,SM.StateId,StateName,
	SM.CountryId,CountryName,SM.IsDeleted,SM.CreatedBy,CreatedOn
	FROM [ams_tblSiteMaster] SM
	JOIN ams_tblCountryMaster CM ON CM.CountryId = SM.CountryId
	JOIN ams_tblStateMaster STM ON STM.stateId = SM.stateId
	WHERE SM.IsDeleted = 0
END
GO
/****** Object:  Table [dbo].[ams_tblAssetCheckoutAndCheckInStatus]    Script Date: 9/21/2020 1:47:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblAssetCheckoutAndCheckInStatus](
	[UniqueId] [int] IDENTITY(1,1) NOT NULL,
	[AssetId] [int] NULL,
	[StatusId] [int] NULL,
	[PersonOrSite] [int] NOT NULL,
	[PersonId] [int] NULL,
	[Personname] [nvarchar](100) NOT NULL,
	[CheckoutDate] [datetime] NOT NULL,
	[CheckinDate] [datetime] NOT NULL,
	[DueDate] [datetime] NULL,
	[CheckoutRemarks] [nvarchar](1000) NULL,
	[CheckinRemarks] [nvarchar](1000) NULL,
	[SiteId] [int] NULL,
	[LocationId] [int] NULL,
	[DeptId] [int] NULL,
	[IsReturned] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UniqueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblAssetMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblAssetMaster](
	[AssetId] [int] IDENTITY(1,1) NOT NULL,
	[AssetTagTypeId] [int] NULL,
	[AssetTagId] [nvarchar](10) NOT NULL,
	[AssetName] [nvarchar](100) NOT NULL,
	[AssetCost] [decimal](10, 2) NOT NULL,
	[AssetStatusId] [int] NOT NULL,
	[CategoryId] [int] NULL,
	[SubCategoryId] [int] NULL,
	[SiteId] [int] NULL,
	[LocationId] [int] NULL,
	[DepartmentId] [int] NULL,
	[VendorId] [int] NULL,
	[PurchasedOn] [date] NULL,
	[PurchasedTypeId] [int] NULL,
	[Description] [nvarchar](1000) NULL,
	[ImageUrl] [nvarchar](500) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NULL,
	[IsDeleted] [bit] NULL,
	[AssetTypeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AssetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblAssetPurchasedTypeMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblAssetPurchasedTypeMaster](
	[PurchasedId] [int] IDENTITY(1,1) NOT NULL,
	[PurchasedType] [nvarchar](25) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchasedId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblAssetStatusMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblAssetStatusMaster](
	[statusId] [int] IDENTITY(1,1) NOT NULL,
	[statusName] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[statusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblAssetTypeMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblAssetTypeMaster](
	[assetTypeId] [int] IDENTITY(1,1) NOT NULL,
	[assetType] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NULL,
	[isDeleted] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [date] NOT NULL,
 CONSTRAINT [PK__ams_tblA__365ED5DD276F8CC3] PRIMARY KEY CLUSTERED 
(
	[assetTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblCategoryMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblCategoryMaster](
	[categoryId] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](100) NULL,
	[description] [nvarchar](500) NULL,
	[isDeleted] [bit] NULL,
	[createdBy] [int] NULL,
	[createdDate] [date] NOT NULL,
 CONSTRAINT [PK__ams_tblC__23CAF1D8BEF754F9] PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AMS_tblCountryMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMS_tblCountryMaster](
	[countryId] [int] IDENTITY(1,1) NOT NULL,
	[countryName] [nvarchar](50) NOT NULL,
	[countryCodeiso2] [nvarchar](2) NOT NULL,
	[countryCodeiso3] [nvarchar](3) NOT NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[countryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblDepartmentMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblDepartmentMaster](
	[deptId] [int] IDENTITY(1,1) NOT NULL,
	[deptName] [nvarchar](100) NOT NULL,
	[description] [nvarchar](500) NULL,
	[isDeleted] [bit] NULL,
	[createdBy] [int] NULL,
	[createdDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[deptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblDepreciationMethodMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblDepreciationMethodMaster](
	[depMethodId] [int] IDENTITY(1,1) NOT NULL,
	[depName] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NULL,
	[isdeleted] [bit] NULL,
	[createdBy] [int] NULL,
	[createdDate] [date] NOT NULL,
 CONSTRAINT [PK__ams_tblD__99438E5E6D7D8D8E] PRIMARY KEY CLUSTERED 
(
	[depMethodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblInsurancePolicyMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblInsurancePolicyMaster](
	[insuranceId] [int] IDENTITY(1,1) NOT NULL,
	[policyNumber] [nvarchar](50) NOT NULL,
	[policyName] [nvarchar](100) NOT NULL,
	[coverageAmount] [decimal](10, 2) NOT NULL,
	[startDate] [date] NOT NULL,
	[endDate] [date] NOT NULL,
	[premium] [decimal](10, 2) NOT NULL,
	[description] [nvarchar](500) NULL,
	[insuranceCompany] [nvarchar](500) NULL,
	[contactPerson] [nvarchar](100) NULL,
	[contactNumber] [nvarchar](15) NULL,
	[contactEmail] [nvarchar](50) NULL,
	[isDeleted] [bit] NULL,
	[createdBy] [int] NULL,
	[createdDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[insuranceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblLocationDepartmentMapping]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblLocationDepartmentMapping](
	[MappingId] [int] IDENTITY(1,1) NOT NULL,
	[locationId] [int] NULL,
	[deptId] [int] NULL,
	[IsDeleted] [bit] NULL,
	[createdBy] [int] NULL,
	[createdDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblLocationMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblLocationMaster](
	[locationId] [int] IDENTITY(1,1) NOT NULL,
	[siteId] [int] NULL,
	[locationName] [nvarchar](200) NULL,
	[description] [nvarchar](500) NULL,
	[Address] [nvarchar](1000) NULL,
	[City] [nvarchar](500) NULL,
	[stateId] [int] NULL,
	[countryId] [int] NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[locationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblSiteMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblSiteMaster](
	[siteId] [int] IDENTITY(1,1) NOT NULL,
	[siteName] [nvarchar](100) NULL,
	[description] [nvarchar](500) NULL,
	[address] [nvarchar](500) NULL,
	[city] [nvarchar](100) NULL,
	[stateId] [int] NULL,
	[countryId] [int] NULL,
	[isDeleted] [bit] NULL,
	[createdBy] [int] NULL,
	[createdOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[siteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AMS_tblStateMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMS_tblStateMaster](
	[stateId] [int] IDENTITY(1,1) NOT NULL,
	[stateName] [nvarchar](50) NULL,
	[countryId] [int] NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[stateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblSubCategoryMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblSubCategoryMaster](
	[subCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[categoryId] [int] NULL,
	[subCategoryName] [nvarchar](100) NOT NULL,
	[description] [nvarchar](500) NULL,
	[isDeleted] [bit] NULL,
	[createdBy] [int] NULL,
	[createdDate] [date] NOT NULL,
 CONSTRAINT [PK__ams_tblS__F82064692DCC2F20] PRIMARY KEY CLUSTERED 
(
	[subCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblUsers]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblUsers](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NULL,
	[EmailId] [nvarchar](100) NOT NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ams_tblVendorMaster]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ams_tblVendorMaster](
	[vendorId] [int] IDENTITY(1,1) NOT NULL,
	[vendorName] [nvarchar](500) NOT NULL,
	[address] [nvarchar](500) NOT NULL,
	[city] [nvarchar](100) NOT NULL,
	[stateId] [int] NOT NULL,
	[countryId] [int] NOT NULL,
	[contactPerson] [nvarchar](100) NULL,
	[email] [nvarchar](100) NULL,
	[contactNumber] [nvarchar](20) NULL,
	[fax] [nvarchar](20) NULL,
	[websiteURL] [nvarchar](100) NULL,
	[isDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[vendorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[asm_tblAssetCustomFieldMapping]    Script Date: 9/21/2020 1:47:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[asm_tblAssetCustomFieldMapping](
	[CustomFieldId] [int] IDENTITY(1,1) NOT NULL,
	[AssetId] [int] NULL,
	[CustomFieldName] [nvarchar](50) NOT NULL,
	[CustomFieldValue] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NULL,
	[CreateBy] [int] NULL,
	[CreatedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomFieldId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ON 

INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (11, 1, 2, 1, 1, N'Mohana Gunasekaran', CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC4600000000 AS DateTime), N'Check out in good condition', N'', 0, 0, 0, 0)
INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (12, 5, 2, 1, 1, N'Mohana Gunasekaran', CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC4600000000 AS DateTime), N'Check out in good condition', N'', 0, 0, 0, 0)
INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (13, 1003, 2, 1, 1, N'Mohana Gunasekaran', CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC4600000000 AS DateTime), N'Check out in good condition', N'', 0, 0, 0, 1)
INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (14, 3010, 2, 1, 1, N'Mohana Gunasekaran', CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC4600000000 AS DateTime), N'Check out in good condition', N'', 0, 0, 0, 0)
INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (15, 3019, 2, 1, 1, N'Mohana Gunasekaran', CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC4600000000 AS DateTime), N'Check out in good condition', N'', 0, 0, 0, 0)
INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (16, 3015, 2, 1, 1, N'Mohana Gunasekaran', CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC4600000000 AS DateTime), N'Check out in good condition', N'', 0, 0, 0, 0)
INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (17, 2004, 2, 2, 0, N'', CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC4300000000 AS DateTime), N'checkout to site', N'', 1, 1, 3, 0)
INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (18, 4, 2, 2, 0, N'', CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC4300000000 AS DateTime), N'Site/Location', N'', 1, 2, 2, 1)
INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (21, 1003, 3, 1, 1, N'Mohana Gunasekaran', CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), N'', N'sfsdfssdfs', 0, 0, 0, 0)
INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ([UniqueId], [AssetId], [StatusId], [PersonOrSite], [PersonId], [Personname], [CheckoutDate], [CheckinDate], [DueDate], [CheckoutRemarks], [CheckinRemarks], [SiteId], [LocationId], [DeptId], [IsReturned]) VALUES (22, 4, 3, 1, 1, N'Mohana Gunasekaran', CAST(0x0000000000000000 AS DateTime), CAST(0x0000AC3D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), N'', N'sfsdfssdfs', 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[ams_tblAssetCheckoutAndCheckInStatus] OFF
SET IDENTITY_INSERT [dbo].[ams_tblAssetMaster] ON 

INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (1, 1, N'ASS2020100', N'Test Asset', CAST(250.50 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x72410B00 AS Date), 0, N'', N'', 1, CAST(0x72410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (2, 2, N'CUS2020100', N'Test Asset 2', CAST(56890.23 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x72410B00 AS Date), 0, N'', N'', 1, CAST(0x72410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3, 1, N'ASS2020100', N'Test Asset3', CAST(563.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x72410B00 AS Date), 0, N'', N'', 1, CAST(0x72410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (4, 1, N'ASS2020100', N'Test Asset4', CAST(5896.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x72410B00 AS Date), 0, N'', N'', 1, CAST(0x72410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (5, 1, N'ASS2020100', N'Asset1', CAST(250.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x72410B00 AS Date), 0, N'', N'', 1, CAST(0x72410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (1003, 1, N'ASS2020100', N'Asset 2', CAST(800.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x72410B00 AS Date), 0, N'', N'', 1, CAST(0x72410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (1004, 1, N'', N'', CAST(0.00 AS Decimal(10, 2)), 1, 1, 1, 0, 0, 1, 0, CAST(0x72410B00 AS Date), 0, N'test', N'', 1, CAST(0x72410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (2003, 2, N'CUS2020100', N'Example Asset', CAST(500.00 AS Decimal(10, 2)), 1, 1, 2, 0, 0, 1, 0, CAST(0x73410B00 AS Date), 0, N'Test Asset', N'', 1, CAST(0x73410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (2004, 2, N'CUS2020100', N'sample asset', CAST(800.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x73410B00 AS Date), 0, N'', N'', 1, CAST(0x73410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (2005, 1, N'ASS2020100', N'test asset10', CAST(500.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x73410B00 AS Date), 0, N'', N'', 1, CAST(0x73410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (2006, 2, N'ASS2020100', N'Test Asset 20', CAST(900.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x73410B00 AS Date), 0, N'', N'', 1, CAST(0x73410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (2007, 2, N'ASS2020100', N'Test Asset 201', CAST(500.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x73410B00 AS Date), 0, N'', N'', 1, CAST(0x73410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (2008, 2, N'CUS2020100', N'Asset 2020', CAST(523.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x73410B00 AS Date), 0, N'', N'', 1, CAST(0x73410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (2009, 1, N'ASS2020100', N'Demo Asset', CAST(56423.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x73410B00 AS Date), 0, N'', NULL, 1, CAST(0x73410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (2010, 1, N'ASS202101', N'test Asset', CAST(8596.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x74410B00 AS Date), 0, N'', NULL, 1, CAST(0x74410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3010, 1, N'ASS202102', N'test11', CAST(800.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x74410B00 AS Date), 0, N'', NULL, 1, CAST(0x74410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3011, 1, N'ASS202103', N'dgdggdf', CAST(850.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x74410B00 AS Date), 0, N'', NULL, 1, CAST(0x74410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3012, 2, N'ASS2020100', N'sdfsdfffds', CAST(800.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x74410B00 AS Date), 0, N'', NULL, 1, CAST(0x74410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3013, 2, N'fsfdsdff', N'sdfsfsdf', CAST(500.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x74410B00 AS Date), 0, N'', NULL, 1, CAST(0x74410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3014, 2, N'sdfsfsfs', N'sdsdsd', CAST(700.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x74410B00 AS Date), 0, N'', NULL, 1, CAST(0x74410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3015, 1, N'ASS202104', N'Custom Asset 1', CAST(500.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x75410B00 AS Date), 0, N'', NULL, 1, CAST(0x75410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3016, 1, N'ASS202104', N'Custom Asset 1', CAST(500.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x75410B00 AS Date), 0, N'', NULL, 1, CAST(0x75410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3017, 1, N'ASS202104', N'Custom Asset 1', CAST(500.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x75410B00 AS Date), 0, N'', NULL, 1, CAST(0x75410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3018, 1, N'ASS202104', N'Custom Asset 1', CAST(500.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x75410B00 AS Date), 0, N'', N'/AssetImages/3018.png', 1, CAST(0x75410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3019, 2, N'cus66666', N'dfddf', CAST(200.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x75410B00 AS Date), 0, N'', N'/AssetImages/3019.png', 1, CAST(0x75410B00 AS Date), 0, 1)
INSERT [dbo].[ams_tblAssetMaster] ([AssetId], [AssetTagTypeId], [AssetTagId], [AssetName], [AssetCost], [AssetStatusId], [CategoryId], [SubCategoryId], [SiteId], [LocationId], [DepartmentId], [VendorId], [PurchasedOn], [PurchasedTypeId], [Description], [ImageUrl], [CreatedBy], [CreatedDate], [IsDeleted], [AssetTypeId]) VALUES (3021, 1, N'ASS202105', N'dfddf', CAST(700.00 AS Decimal(10, 2)), 1, 0, 0, 0, 0, 0, 0, CAST(0x75410B00 AS Date), 0, N'', N'/AssetImages/3021.png', 1, CAST(0x75410B00 AS Date), 0, 1)
SET IDENTITY_INSERT [dbo].[ams_tblAssetMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblAssetPurchasedTypeMaster] ON 

INSERT [dbo].[ams_tblAssetPurchasedTypeMaster] ([PurchasedId], [PurchasedType], [Description], [IsDeleted]) VALUES (1, N'Owned', N'Owned', 0)
INSERT [dbo].[ams_tblAssetPurchasedTypeMaster] ([PurchasedId], [PurchasedType], [Description], [IsDeleted]) VALUES (2, N'Rented', N'Rented', 0)
INSERT [dbo].[ams_tblAssetPurchasedTypeMaster] ([PurchasedId], [PurchasedType], [Description], [IsDeleted]) VALUES (3, N'Leased', N'Leased', 0)
INSERT [dbo].[ams_tblAssetPurchasedTypeMaster] ([PurchasedId], [PurchasedType], [Description], [IsDeleted]) VALUES (4, N'Subscription', N'Subscription', 0)
SET IDENTITY_INSERT [dbo].[ams_tblAssetPurchasedTypeMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblAssetStatusMaster] ON 

INSERT [dbo].[ams_tblAssetStatusMaster] ([statusId], [statusName], [description], [isDeleted]) VALUES (1, N'Available', N'Available', 0)
INSERT [dbo].[ams_tblAssetStatusMaster] ([statusId], [statusName], [description], [isDeleted]) VALUES (2, N'Check Out', N'Assigned', 0)
INSERT [dbo].[ams_tblAssetStatusMaster] ([statusId], [statusName], [description], [isDeleted]) VALUES (3, N'Check In', N'Check In', 0)
INSERT [dbo].[ams_tblAssetStatusMaster] ([statusId], [statusName], [description], [isDeleted]) VALUES (4, N'Maintenance', N'Maintenance', 0)
INSERT [dbo].[ams_tblAssetStatusMaster] ([statusId], [statusName], [description], [isDeleted]) VALUES (5, N'Loss', N'Loss', 0)
INSERT [dbo].[ams_tblAssetStatusMaster] ([statusId], [statusName], [description], [isDeleted]) VALUES (6, N'Dispose', N'Dispose', 0)
INSERT [dbo].[ams_tblAssetStatusMaster] ([statusId], [statusName], [description], [isDeleted]) VALUES (7, N'Move', N'Move', 0)
INSERT [dbo].[ams_tblAssetStatusMaster] ([statusId], [statusName], [description], [isDeleted]) VALUES (8, N'Broken', N'Broken', 0)
SET IDENTITY_INSERT [dbo].[ams_tblAssetStatusMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblAssetTypeMaster] ON 

INSERT [dbo].[ams_tblAssetTypeMaster] ([assetTypeId], [assetType], [description], [isDeleted], [CreatedBy], [CreatedDate]) VALUES (1, N'Fixed', N'Fixed', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblAssetTypeMaster] ([assetTypeId], [assetType], [description], [isDeleted], [CreatedBy], [CreatedDate]) VALUES (2, N'Non-Fixed', N'Non-Fixed', 0, 1, CAST(0x6D410B00 AS Date))
SET IDENTITY_INSERT [dbo].[ams_tblAssetTypeMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblCategoryMaster] ON 

INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (1, N'Hardware', N'Hardware', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (2, N'Software', N'Software', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (3, N'Furnitures', N'Furnitures', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (4, N'Vechicles', N'Vechicles', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (5, N'Mobiles', N'Mobiles', 0, 1, CAST(0x78410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (6, N'Accessories', N'Accessories', 0, 1, CAST(0x78410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (7, N'Buildings', N'Buildings', 0, 1, CAST(0x78410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (8, N'Groceries', N'Groceries', 0, 1, CAST(0x78410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (9, N'Fertilizers', N'Fertilizers', 0, 1, CAST(0x81410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (10, N'test', N'test', 0, 1, CAST(0x81410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (11, N'Test', N'test', 0, 1, CAST(0x81410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (12, N'Spares', N'Spares', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (13, N'Spares', N'Spares', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (14, N'test2', N'test2', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (15, N'test2', N'test2', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (16, N'test3', N'test3', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (17, N'sddfsdsd', N'sdfsdfsfsfd', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (18, N'fsfdffsfds', N'fsdfsfsfdfsd', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (19, N'yyyyy', N'yyyyyyy', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (20, N'uuuuuuuuuuuuuuuu', N'qqqqqqqqqqqq', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblCategoryMaster] ([categoryId], [categoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (21, N'kjkjkjkjkj', N'wewewerwewt', 0, 1, CAST(0x82410B00 AS Date))
SET IDENTITY_INSERT [dbo].[ams_tblCategoryMaster] OFF
SET IDENTITY_INSERT [dbo].[AMS_tblCountryMaster] ON 

INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (1, N'Afghanistan', N'AF', N'AFG', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (2, N'Albania', N'AL', N'ALB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (3, N'Algeria', N'DZ', N'DZA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (4, N'American Samoa', N'AS', N'ASM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (5, N'Andorra', N'AD', N'AND', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (6, N'Angola', N'AO', N'AGO', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (7, N'Antigua And Barbuda', N'AG', N'ATG', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (8, N'Argentina', N'AR', N'ARG', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (9, N'Armenia', N'AM', N'ARM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (10, N'Aruba', N'AW', N'ABW', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (11, N'Australia', N'AU', N'AUS', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (12, N'Austria', N'AT', N'AUT', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (13, N'Azerbaijan', N'AZ', N'AZE', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (14, N'Bahamas, The', N'BS', N'BHS', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (15, N'Bahrain', N'BH', N'BHR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (16, N'Bangladesh', N'BD', N'BGD', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (17, N'Barbados', N'BB', N'BRB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (18, N'Belarus', N'BY', N'BLR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (19, N'Belgium', N'BE', N'BEL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (20, N'Belize', N'BZ', N'BLZ', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (21, N'Benin', N'BJ', N'BEN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (22, N'Bermuda', N'BM', N'BMU', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (23, N'Bhutan', N'BT', N'BTN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (24, N'Bolivia', N'BO', N'BOL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (25, N'Bosnia And Herzegovina', N'BA', N'BIH', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (26, N'Botswana', N'BW', N'BWA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (27, N'Brazil', N'BR', N'BRA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (28, N'Brunei', N'BN', N'BRN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (29, N'Bulgaria', N'BG', N'BGR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (30, N'Burkina Faso', N'BF', N'BFA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (31, N'Burma', N'MM', N'MMR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (32, N'Burundi', N'BI', N'BDI', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (33, N'Cabo Verde', N'CV', N'CPV', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (34, N'Cambodia', N'KH', N'KHM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (35, N'Cameroon', N'CM', N'CMR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (36, N'Canada', N'CA', N'CAN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (37, N'Cayman Islands', N'KY', N'CYM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (38, N'Central African Republic', N'CF', N'CAF', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (39, N'Chad', N'TD', N'TCD', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (40, N'Chile', N'CL', N'CHL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (41, N'China', N'CN', N'CHN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (42, N'Colombia', N'CO', N'COL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (43, N'Comoros', N'KM', N'COM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (44, N'Congo (Brazzaville)', N'CG', N'COG', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (45, N'Congo (Kinshasa)', N'CD', N'COD', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (46, N'Cook Islands', N'CK', N'COK', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (47, N'Costa Rica', N'CR', N'CRI', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (48, N'Côte D’Ivoire', N'CI', N'CIV', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (49, N'Croatia', N'HR', N'HRV', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (50, N'Cuba', N'CU', N'CUB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (51, N'Curaçao', N'CW', N'CUW', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (52, N'Cyprus', N'CY', N'CYP', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (53, N'Czechia', N'CZ', N'CZE', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (54, N'Denmark', N'DK', N'DNK', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (55, N'Djibouti', N'DJ', N'DJI', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (56, N'Dominica', N'DM', N'DMA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (57, N'Dominican Republic', N'DO', N'DOM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (58, N'Ecuador', N'EC', N'ECU', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (59, N'Egypt', N'EG', N'EGY', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (60, N'El Salvador', N'SV', N'SLV', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (61, N'Equatorial Guinea', N'GQ', N'GNQ', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (62, N'Eritrea', N'ER', N'ERI', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (63, N'Estonia', N'EE', N'EST', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (64, N'Ethiopia', N'ET', N'ETH', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (65, N'Falkland Islands (Islas Malvinas)', N'FK', N'FLK', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (66, N'Faroe Islands', N'FO', N'FRO', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (67, N'Fiji', N'FJ', N'FJI', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (68, N'Finland', N'FI', N'FIN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (69, N'France', N'FR', N'FRA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (70, N'French Guiana', N'GF', N'GUF', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (71, N'French Polynesia', N'PF', N'PYF', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (72, N'Gabon', N'GA', N'GAB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (73, N'Gambia, The', N'GM', N'GMB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (74, N'Georgia', N'GE', N'GEO', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (75, N'Germany', N'DE', N'DEU', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (76, N'Ghana', N'GH', N'GHA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (77, N'Gibraltar', N'GI', N'GIB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (78, N'Greece', N'GR', N'GRC', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (79, N'Greenland', N'GL', N'GRL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (80, N'Grenada', N'GD', N'GRD', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (81, N'Guadeloupe', N'GP', N'GLP', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (82, N'Guam', N'GU', N'GUM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (83, N'Guatemala', N'GT', N'GTM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (84, N'Guinea', N'GN', N'GIN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (85, N'Guinea-Bissau', N'GW', N'GNB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (86, N'Guyana', N'GY', N'GUY', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (87, N'Haiti', N'HT', N'HTI', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (88, N'Honduras', N'HN', N'HND', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (89, N'Hong Kong', N'HK', N'HKG', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (90, N'Hungary', N'HU', N'HUN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (91, N'Iceland', N'IS', N'ISL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (92, N'India', N'IN', N'IND', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (93, N'Indonesia', N'ID', N'IDN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (94, N'Iran', N'IR', N'IRN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (95, N'Iraq', N'IQ', N'IRQ', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (96, N'Ireland', N'IE', N'IRL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (97, N'Isle Of Man', N'IM', N'IMN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (98, N'Israel', N'IL', N'ISR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (99, N'Italy', N'IT', N'ITA', 0)
GO
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (100, N'Jamaica', N'JM', N'JAM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (101, N'Japan', N'JP', N'JPN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (102, N'Jordan', N'JO', N'JOR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (103, N'Kazakhstan', N'KZ', N'KAZ', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (104, N'Kenya', N'KE', N'KEN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (105, N'Kiribati', N'KI', N'KIR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (106, N'Korea, North', N'KP', N'PRK', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (107, N'Korea, South', N'KR', N'KOR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (108, N'Kosovo', N'XK', N'XKS', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (109, N'Kuwait', N'KW', N'KWT', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (110, N'Kyrgyzstan', N'KG', N'KGZ', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (111, N'Laos', N'LA', N'LAO', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (112, N'Latvia', N'LV', N'LVA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (113, N'Lebanon', N'LB', N'LBN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (114, N'Lesotho', N'LS', N'LSO', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (115, N'Liberia', N'LR', N'LBR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (116, N'Libya', N'LY', N'LBY', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (117, N'Liechtenstein', N'LI', N'LIE', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (118, N'Lithuania', N'LT', N'LTU', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (119, N'Luxembourg', N'LU', N'LUX', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (120, N'Macau', N'MO', N'MAC', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (121, N'Macedonia', N'MK', N'MKD', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (122, N'Madagascar', N'MG', N'MDG', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (123, N'Malawi', N'MW', N'MWI', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (124, N'Malaysia', N'MY', N'MYS', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (125, N'Maldives', N'MV', N'MDV', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (126, N'Mali', N'ML', N'MLI', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (127, N'Malta', N'MT', N'MLT', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (128, N'Marshall Islands', N'MH', N'MHL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (129, N'Martinique', N'MQ', N'MTQ', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (130, N'Mauritania', N'MR', N'MRT', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (131, N'Mauritius', N'MU', N'MUS', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (132, N'Mayotte', N'YT', N'MYT', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (133, N'Mexico', N'MX', N'MEX', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (134, N'Micronesia, Federated States Of', N'FM', N'FSM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (135, N'Moldova', N'MD', N'MDA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (136, N'Monaco', N'MC', N'MCO', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (137, N'Mongolia', N'MN', N'MNG', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (138, N'Montenegro', N'ME', N'MNE', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (139, N'Morocco', N'MA', N'MAR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (140, N'Mozambique', N'MZ', N'MOZ', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (141, N'Namibia', N'NA', N'NAM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (142, N'Nepal', N'NP', N'NPL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (143, N'Netherlands', N'NL', N'NLD', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (144, N'New Caledonia', N'NC', N'NCL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (145, N'New Zealand', N'NZ', N'NZL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (146, N'Nicaragua', N'NI', N'NIC', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (147, N'Niger', N'NE', N'NER', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (148, N'Nigeria', N'NG', N'NGA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (149, N'Northern Mariana Islands', N'MP', N'MNP', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (150, N'Norway', N'NO', N'NOR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (151, N'Oman', N'OM', N'OMN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (152, N'Pakistan', N'PK', N'PAK', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (153, N'Palau', N'PW', N'PLW', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (154, N'Panama', N'PA', N'PAN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (155, N'Papua New Guinea', N'PG', N'PNG', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (156, N'Paraguay', N'PY', N'PRY', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (157, N'Peru', N'PE', N'PER', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (158, N'Philippines', N'PH', N'PHL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (159, N'Poland', N'PL', N'POL', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (160, N'Portugal', N'PT', N'PRT', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (161, N'Puerto Rico', N'PR', N'PRI', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (162, N'Qatar', N'QA', N'QAT', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (163, N'Reunion', N'RE', N'REU', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (164, N'Romania', N'RO', N'ROU', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (165, N'Russia', N'RU', N'RUS', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (166, N'Rwanda', N'RW', N'RWA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (167, N'Saint Helena, Ascension, And Tristan Da Cunha', N'SH', N'SHN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (168, N'Saint Kitts And Nevis', N'KN', N'KNA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (169, N'Saint Lucia', N'LC', N'LCA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (170, N'Saint Vincent And The Grenadines', N'VC', N'VCT', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (171, N'Samoa', N'WS', N'WSM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (172, N'San Marino', N'SM', N'SMR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (173, N'Sao Tome And Principe', N'ST', N'STP', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (174, N'Saudi Arabia', N'SA', N'SAU', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (175, N'Senegal', N'SN', N'SEN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (176, N'Serbia', N'RS', N'SRB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (177, N'Seychelles', N'SC', N'SYC', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (178, N'Sierra Leone', N'SL', N'SLE', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (179, N'Singapore', N'SG', N'SGP', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (180, N'Sint Maarten', N'SX', N'SXM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (181, N'Slovakia', N'SK', N'SVK', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (182, N'Slovenia', N'SI', N'SVN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (183, N'Solomon Islands', N'SB', N'SLB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (184, N'Somalia', N'SO', N'SOM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (185, N'South Africa', N'ZA', N'ZAF', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (186, N'South Georgia And South Sandwich Islands', N'GS', N'SGS', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (187, N'South Sudan', N'SS', N'SSD', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (188, N'Spain', N'ES', N'ESP', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (189, N'Sri Lanka', N'LK', N'LKA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (190, N'Sudan', N'SD', N'SDN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (191, N'Suriname', N'SR', N'SUR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (192, N'Swaziland', N'SZ', N'SWZ', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (193, N'Sweden', N'SE', N'SWE', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (194, N'Switzerland', N'CH', N'CHE', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (195, N'Syria', N'SY', N'SYR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (196, N'Taiwan', N'TW', N'TWN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (197, N'Tajikistan', N'TJ', N'TJK', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (198, N'Tanzania', N'TZ', N'TZA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (199, N'Thailand', N'TH', N'THA', 0)
GO
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (200, N'Timor-Leste', N'TL', N'TLS', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (201, N'Togo', N'TG', N'TGO', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (202, N'Tonga', N'TO', N'TON', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (203, N'Trinidad And Tobago', N'TT', N'TTO', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (204, N'Tunisia', N'TN', N'TUN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (205, N'Turkey', N'TR', N'TUR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (206, N'Turkmenistan', N'TM', N'TKM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (207, N'Turks And Caicos Islands', N'TC', N'TCA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (208, N'Tuvalu', N'TV', N'TUV', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (209, N'Uganda', N'UG', N'UGA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (210, N'Ukraine', N'UA', N'UKR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (211, N'United Arab Emirates', N'AE', N'ARE', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (212, N'United Kingdom', N'GB', N'GBR', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (213, N'United States', N'US', N'USA', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (214, N'Uruguay', N'UY', N'URY', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (215, N'Uzbekistan', N'UZ', N'UZB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (216, N'Vanuatu', N'VU', N'VUT', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (217, N'Venezuela', N'VE', N'VEN', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (218, N'Vietnam', N'VN', N'VNM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (219, N'Wallis And Futuna', N'WF', N'WLF', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (220, N'West Bank', N'XW', N'XWB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (221, N'Yemen', N'YE', N'YEM', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (222, N'Zambia', N'ZM', N'ZMB', 0)
INSERT [dbo].[AMS_tblCountryMaster] ([countryId], [countryName], [countryCodeiso2], [countryCodeiso3], [isDeleted]) VALUES (223, N'Zimbabwe', N'ZW', N'ZWE', 0)
SET IDENTITY_INSERT [dbo].[AMS_tblCountryMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblDepartmentMaster] ON 

INSERT [dbo].[ams_tblDepartmentMaster] ([deptId], [deptName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (1, N'IT', N'Development', 0, 1, CAST(0x6E410B00 AS Date))
INSERT [dbo].[ams_tblDepartmentMaster] ([deptId], [deptName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (2, N'Finance', N'Finance', 0, 1, CAST(0x6E410B00 AS Date))
INSERT [dbo].[ams_tblDepartmentMaster] ([deptId], [deptName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (3, N'HR', N'Human Resource', 0, 1, CAST(0x6E410B00 AS Date))
INSERT [dbo].[ams_tblDepartmentMaster] ([deptId], [deptName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (4, N'Admin', N'Admin', 0, 1, CAST(0x98410B00 AS Date))
SET IDENTITY_INSERT [dbo].[ams_tblDepartmentMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblDepreciationMethodMaster] ON 

INSERT [dbo].[ams_tblDepreciationMethodMaster] ([depMethodId], [depName], [description], [isdeleted], [createdBy], [createdDate]) VALUES (1, N'Straight-Line', N'Formula : Depreciation Expense = (Cost – Salvage value) / Useful life', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblDepreciationMethodMaster] ([depMethodId], [depName], [description], [isdeleted], [createdBy], [createdDate]) VALUES (2, N'Double Declining Balance', N'Depreciation Expense = (Number of units produced / Life in number of units) x (Cost – Salvage value), The rate of depreciation (Rate) is calculated as follows:
Expense = (100% / Useful life of asset) x 2', 0, 1, CAST(0x6D410B00 AS Date))
SET IDENTITY_INSERT [dbo].[ams_tblDepreciationMethodMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblInsurancePolicyMaster] ON 

INSERT [dbo].[ams_tblInsurancePolicyMaster] ([insuranceId], [policyNumber], [policyName], [coverageAmount], [startDate], [endDate], [premium], [description], [insuranceCompany], [contactPerson], [contactNumber], [contactEmail], [isDeleted], [createdBy], [createdDate]) VALUES (1, N'INSHard001', N'Hardware Policy', CAST(25000.00 AS Decimal(10, 2)), CAST(0x90400B00 AS Date), CAST(0xFC410B00 AS Date), CAST(2500.00 AS Decimal(10, 2)), NULL, N'LIC of India', NULL, NULL, NULL, 0, 1, CAST(0x6E410B00 AS Date))
INSERT [dbo].[ams_tblInsurancePolicyMaster] ([insuranceId], [policyNumber], [policyName], [coverageAmount], [startDate], [endDate], [premium], [description], [insuranceCompany], [contactPerson], [contactNumber], [contactEmail], [isDeleted], [createdBy], [createdDate]) VALUES (3, N'INSSoft001', N'Software Policy', CAST(50000.00 AS Decimal(10, 2)), CAST(0x90400B00 AS Date), CAST(0xFC410B00 AS Date), CAST(4500.00 AS Decimal(10, 2)), NULL, N'Bajaj Insurance', NULL, NULL, NULL, 0, 1, CAST(0x6E410B00 AS Date))
SET IDENTITY_INSERT [dbo].[ams_tblInsurancePolicyMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblLocationDepartmentMapping] ON 

INSERT [dbo].[ams_tblLocationDepartmentMapping] ([MappingId], [locationId], [deptId], [IsDeleted], [createdBy], [createdDate]) VALUES (1, 1, 1, 0, NULL, CAST(0x0000AC2200D73AF3 AS DateTime))
INSERT [dbo].[ams_tblLocationDepartmentMapping] ([MappingId], [locationId], [deptId], [IsDeleted], [createdBy], [createdDate]) VALUES (2, 1, 2, 0, NULL, CAST(0x0000AC2200D73B08 AS DateTime))
INSERT [dbo].[ams_tblLocationDepartmentMapping] ([MappingId], [locationId], [deptId], [IsDeleted], [createdBy], [createdDate]) VALUES (3, 1, 3, 0, NULL, CAST(0x0000AC2200D73B08 AS DateTime))
INSERT [dbo].[ams_tblLocationDepartmentMapping] ([MappingId], [locationId], [deptId], [IsDeleted], [createdBy], [createdDate]) VALUES (4, 2, 2, 0, NULL, CAST(0x0000AC2200D73B09 AS DateTime))
INSERT [dbo].[ams_tblLocationDepartmentMapping] ([MappingId], [locationId], [deptId], [IsDeleted], [createdBy], [createdDate]) VALUES (5, 2, 3, 0, NULL, CAST(0x0000AC2200D73B09 AS DateTime))
SET IDENTITY_INSERT [dbo].[ams_tblLocationDepartmentMapping] OFF
SET IDENTITY_INSERT [dbo].[ams_tblLocationMaster] ON 

INSERT [dbo].[ams_tblLocationMaster] ([locationId], [siteId], [locationName], [description], [Address], [City], [stateId], [countryId], [isDeleted]) VALUES (1, 1, N'Location1', N'Test Location', N'Location Address', N'City', 1, 124, 0)
INSERT [dbo].[ams_tblLocationMaster] ([locationId], [siteId], [locationName], [description], [Address], [City], [stateId], [countryId], [isDeleted]) VALUES (2, 1, N'Location2', N'Test Location', N'Location Address', N'City', 1, 124, 0)
INSERT [dbo].[ams_tblLocationMaster] ([locationId], [siteId], [locationName], [description], [Address], [City], [stateId], [countryId], [isDeleted]) VALUES (3, 2, N'Location1', N'Test Location', N'Location Address', N'City', 2, 124, 0)
SET IDENTITY_INSERT [dbo].[ams_tblLocationMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblSiteMaster] ON 

INSERT [dbo].[ams_tblSiteMaster] ([siteId], [siteName], [description], [address], [city], [stateId], [countryId], [isDeleted], [createdBy], [createdOn]) VALUES (1, N'Site1', N'Test Site', N'Address 1', N'City', 1, 124, 0, 1, CAST(0x0000AC1B00DD4880 AS DateTime))
INSERT [dbo].[ams_tblSiteMaster] ([siteId], [siteName], [description], [address], [city], [stateId], [countryId], [isDeleted], [createdBy], [createdOn]) VALUES (2, N'Site2', N'Test Site', N'Address 2', N'City', 2, 124, 0, 1, CAST(0x0000AC1B00DD72BC AS DateTime))
INSERT [dbo].[ams_tblSiteMaster] ([siteId], [siteName], [description], [address], [city], [stateId], [countryId], [isDeleted], [createdBy], [createdOn]) VALUES (3, N'Site3', N'Test Site', N'Address 2', N'City', 3, 124, 0, 1, CAST(0x0000AC1B00DD845D AS DateTime))
SET IDENTITY_INSERT [dbo].[ams_tblSiteMaster] OFF
SET IDENTITY_INSERT [dbo].[AMS_tblStateMaster] ON 

INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (1, N'Johor', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (2, N'Kedah', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (3, N'Kelantan', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (4, N'Kuala Lumpur ', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (5, N'Labuan', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (6, N'Melaka', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (7, N'Negeri Sembilan', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (8, N'Pahang', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (9, N'Perak', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (10, N'Perlis', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (11, N'Pulau Pinang', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (12, N'Putrajaya', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (13, N'Sabah', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (14, N'Sarawak', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (15, N'Selangor', 124, 0)
INSERT [dbo].[AMS_tblStateMaster] ([stateId], [stateName], [countryId], [isDeleted]) VALUES (16, N'Terengganu', 124, 0)
SET IDENTITY_INSERT [dbo].[AMS_tblStateMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblSubCategoryMaster] ON 

INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (1, 1, N'Desktop', N'Desktop', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (2, 1, N'Laptop', N'Laptop', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (3, 1, N'Printer', N'Printer', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (4, 1, N'Scanner', N'Scanner', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (5, 1, N'Projector', N'Projector', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (6, 2, N'Operating System', N'Operating System', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (7, 2, N'Oracle 11g', N'DataBase', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (8, 2, N'Visual Studio 2019 Enterprise', N'Framework', 0, 1, CAST(0x6D410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (9, 3, N'Table', N'Table', 0, 1, CAST(0x78410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (10, 1, N'RAM', N'RAM', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (12, 2, N'dfdfsdf', N'sddfsdfs', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (14, 2, N'test', N'test', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (15, 2, N'dsdfsfsf', N'sdfsfsf', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (16, 2, N'test1', N'test', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (17, 2, N'test2', N'test2', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (18, 2, N'ssdfsdfsdf', N'sdfsdfsdsdf', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (19, 2, N'fsdfffsfsf', N'sfsdfsdfsdfsd', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (20, 2, N'rwerrwerwrwe', N'werwerwrrwerrwer', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (21, 2, N'tyyyyyyyyyyyyyyyyyyyy', N'werwerwrrwerrwer', 0, 1, CAST(0x82410B00 AS Date))
INSERT [dbo].[ams_tblSubCategoryMaster] ([subCategoryId], [categoryId], [subCategoryName], [description], [isDeleted], [createdBy], [createdDate]) VALUES (22, 2, N'uuuuuuuuuuuu', N'uuuuuuuuuuuuu', 0, 1, CAST(0x82410B00 AS Date))
SET IDENTITY_INSERT [dbo].[ams_tblSubCategoryMaster] OFF
SET IDENTITY_INSERT [dbo].[ams_tblUsers] ON 

INSERT [dbo].[ams_tblUsers] ([UserId], [FirstName], [LastName], [EmailId], [IsDeleted]) VALUES (1, N'Mohana', N'Gunasekaran', N'gmohan.ind@gmail.com', 0)
INSERT [dbo].[ams_tblUsers] ([UserId], [FirstName], [LastName], [EmailId], [IsDeleted]) VALUES (2, N'Thiyagesh', N'Sathyamoorthy', N'thiyageshece@gmail.com', 0)
INSERT [dbo].[ams_tblUsers] ([UserId], [FirstName], [LastName], [EmailId], [IsDeleted]) VALUES (3, N'Kannan', N'', N'kannankansh@gmail.com', 0)
INSERT [dbo].[ams_tblUsers] ([UserId], [FirstName], [LastName], [EmailId], [IsDeleted]) VALUES (1002, N'Guna', N'', N'guna@gmail.com', 0)
SET IDENTITY_INSERT [dbo].[ams_tblUsers] OFF
SET IDENTITY_INSERT [dbo].[asm_tblAssetCustomFieldMapping] ON 

INSERT [dbo].[asm_tblAssetCustomFieldMapping] ([CustomFieldId], [AssetId], [CustomFieldName], [CustomFieldValue], [IsDeleted], [CreateBy], [CreatedDate]) VALUES (1, 3018, N'xxxx', N'yyyyy', 0, NULL, CAST(0x75410B00 AS Date))
INSERT [dbo].[asm_tblAssetCustomFieldMapping] ([CustomFieldId], [AssetId], [CustomFieldName], [CustomFieldValue], [IsDeleted], [CreateBy], [CreatedDate]) VALUES (2, 3018, N'444444', N'value3', 0, NULL, CAST(0x75410B00 AS Date))
INSERT [dbo].[asm_tblAssetCustomFieldMapping] ([CustomFieldId], [AssetId], [CustomFieldName], [CustomFieldValue], [IsDeleted], [CreateBy], [CreatedDate]) VALUES (3, 3018, N'hhhhhh', N'vaue3', 0, NULL, CAST(0x75410B00 AS Date))
INSERT [dbo].[asm_tblAssetCustomFieldMapping] ([CustomFieldId], [AssetId], [CustomFieldName], [CustomFieldValue], [IsDeleted], [CreateBy], [CreatedDate]) VALUES (4, 3019, N'dfdfsdf', N'dsfsdfs', 0, NULL, CAST(0x75410B00 AS Date))
INSERT [dbo].[asm_tblAssetCustomFieldMapping] ([CustomFieldId], [AssetId], [CustomFieldName], [CustomFieldValue], [IsDeleted], [CreateBy], [CreatedDate]) VALUES (5, 3021, N'xxxx', N'dsfsdfs', 0, NULL, CAST(0x75410B00 AS Date))
SET IDENTITY_INSERT [dbo].[asm_tblAssetCustomFieldMapping] OFF
ALTER TABLE [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ADD  DEFAULT ((1)) FOR [PersonOrSite]
GO
ALTER TABLE [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ADD  DEFAULT (getdate()) FOR [CheckoutDate]
GO
ALTER TABLE [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ADD  DEFAULT (getdate()) FOR [CheckinDate]
GO
ALTER TABLE [dbo].[ams_tblAssetCheckoutAndCheckInStatus] ADD  DEFAULT ((0)) FOR [IsReturned]
GO
ALTER TABLE [dbo].[ams_tblAssetMaster] ADD  DEFAULT ((1)) FOR [AssetTagTypeId]
GO
ALTER TABLE [dbo].[ams_tblAssetMaster] ADD  DEFAULT ((1)) FOR [AssetStatusId]
GO
ALTER TABLE [dbo].[ams_tblAssetMaster] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ams_tblAssetMaster] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ams_tblAssetMaster] ADD  DEFAULT ((0)) FOR [AssetTypeId]
GO
ALTER TABLE [dbo].[ams_tblAssetPurchasedTypeMaster] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ams_tblAssetStatusMaster] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblAssetTypeMaster] ADD  CONSTRAINT [DF_ams_tblAssetTypeMaster_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[ams_tblAssetTypeMaster] ADD  CONSTRAINT [DF__ams_tblAs__isDel__108B795B]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblAssetTypeMaster] ADD  CONSTRAINT [DF_ams_tblAssetTypeMaster_CreatedBy]  DEFAULT ((1)) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[ams_tblAssetTypeMaster] ADD  CONSTRAINT [DF_ams_tblAssetTypeMaster_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ams_tblCategoryMaster] ADD  CONSTRAINT [DF_ams_tblCategoryMaster_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[ams_tblCategoryMaster] ADD  CONSTRAINT [DF__ams_tblCa__isDel__1920BF5C]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblCategoryMaster] ADD  CONSTRAINT [DF_ams_tblCategoryMaster_createdDate]  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[AMS_tblCountryMaster] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblDepartmentMaster] ADD  CONSTRAINT [DF_ams_tblDepartmentMaster_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[ams_tblDepartmentMaster] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblDepreciationMethodMaster] ADD  CONSTRAINT [DF_ams_tblDepreciationMethodMaster_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[ams_tblDepreciationMethodMaster] ADD  CONSTRAINT [DF__ams_tblDe__isdel__164452B1]  DEFAULT ((0)) FOR [isdeleted]
GO
ALTER TABLE [dbo].[ams_tblDepreciationMethodMaster] ADD  CONSTRAINT [DF_ams_tblDepreciationMethodMaster_createdDate]  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[ams_tblInsurancePolicyMaster] ADD  CONSTRAINT [DF_ams_tblInsurancePolicyMaster_description]  DEFAULT ('') FOR [description]
GO
ALTER TABLE [dbo].[ams_tblInsurancePolicyMaster] ADD  CONSTRAINT [DF_ams_tblInsurancePolicyMaster_insuranceCompany]  DEFAULT ('') FOR [insuranceCompany]
GO
ALTER TABLE [dbo].[ams_tblInsurancePolicyMaster] ADD  CONSTRAINT [DF_ams_tblInsurancePolicyMaster_contactPerson]  DEFAULT ('') FOR [contactPerson]
GO
ALTER TABLE [dbo].[ams_tblInsurancePolicyMaster] ADD  CONSTRAINT [DF_ams_tblInsurancePolicyMaster_contactNumber]  DEFAULT ('') FOR [contactNumber]
GO
ALTER TABLE [dbo].[ams_tblInsurancePolicyMaster] ADD  CONSTRAINT [DF_ams_tblInsurancePolicyMaster_contactEmail]  DEFAULT ('') FOR [contactEmail]
GO
ALTER TABLE [dbo].[ams_tblInsurancePolicyMaster] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblInsurancePolicyMaster] ADD  CONSTRAINT [DF_ams_tblInsurancePolicyMaster_createdBy]  DEFAULT ((1)) FOR [createdBy]
GO
ALTER TABLE [dbo].[ams_tblInsurancePolicyMaster] ADD  CONSTRAINT [DF_ams_tblInsurancePolicyMaster_createdDate]  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[ams_tblLocationDepartmentMapping] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ams_tblLocationDepartmentMapping] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[ams_tblLocationMaster] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblSiteMaster] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblSiteMaster] ADD  DEFAULT (getdate()) FOR [createdOn]
GO
ALTER TABLE [dbo].[AMS_tblStateMaster] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblSubCategoryMaster] ADD  CONSTRAINT [DF__ams_tblSu__isDel__24927208]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ams_tblSubCategoryMaster] ADD  CONSTRAINT [DF_ams_tblSubCategoryMaster_createdDate]  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[ams_tblUsers] ADD  CONSTRAINT [DF_ams_tblUsers_LastName]  DEFAULT ('') FOR [LastName]
GO
ALTER TABLE [dbo].[ams_tblUsers] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ams_tblVendorMaster] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[asm_tblAssetCustomFieldMapping] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[asm_tblAssetCustomFieldMapping] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ams_tblAssetCheckoutAndCheckInStatus]  WITH CHECK ADD FOREIGN KEY([AssetId])
REFERENCES [dbo].[ams_tblAssetMaster] ([AssetId])
GO
ALTER TABLE [dbo].[ams_tblAssetCheckoutAndCheckInStatus]  WITH CHECK ADD FOREIGN KEY([StatusId])
REFERENCES [dbo].[ams_tblAssetStatusMaster] ([statusId])
GO
ALTER TABLE [dbo].[ams_tblSubCategoryMaster]  WITH CHECK ADD  CONSTRAINT [FK__ams_tblSu__categ__239E4DCF] FOREIGN KEY([categoryId])
REFERENCES [dbo].[ams_tblCategoryMaster] ([categoryId])
GO
ALTER TABLE [dbo].[ams_tblSubCategoryMaster] CHECK CONSTRAINT [FK__ams_tblSu__categ__239E4DCF]
GO
ALTER TABLE [dbo].[ams_tblVendorMaster]  WITH CHECK ADD FOREIGN KEY([countryId])
REFERENCES [dbo].[AMS_tblCountryMaster] ([countryId])
GO
ALTER TABLE [dbo].[ams_tblVendorMaster]  WITH CHECK ADD FOREIGN KEY([stateId])
REFERENCES [dbo].[AMS_tblStateMaster] ([stateId])
GO
ALTER TABLE [dbo].[asm_tblAssetCustomFieldMapping]  WITH CHECK ADD FOREIGN KEY([AssetId])
REFERENCES [dbo].[ams_tblAssetMaster] ([AssetId])
GO

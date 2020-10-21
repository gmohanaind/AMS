var apiUrl = "http://localhost:57080/api/",
    categoryId = 0,
    view = "",
    liCount = 0;
var persons = [];
var userids = [];
var personOrSite = 1;
var checkoutsiteid = 0;
var checkoutlocationid = 0;
var checkoutdepartmentid = 0;
var checkoutuserid = 0;
var ischeckout = 1;
var isAssetEdit = false;
var assDet = {};
var assetIdForEdit = 0;
var errotTxt = "Something went wrong";

var subCategories = [], sites = [], states = [], countries = [], categoryList = [], locations = [], purchasedTypes = [], locDeptMappingList = [],
    deparmentsList = [], departments = [], vendorsList = [], insuranceList = [];

$(document).ready(function () {
    view = getQueryVariable("view");
    if (view == undefined) { //For Add Asset
        getAllCategories();
        getAllAssetTypes();
        getAllAssetInsurancePolicies(-1);
        getAllAssetPurchasedTypes();
        getAllAssetDepreciation();
        getAllSites();
        getAllUsers();
        getAllVendors();
        $('.clsCheckOut').click();
        if (window.location.href.endsWith("edit-asset.aspx")) {
            assetIdForEdit = sessionStorage.getItem("assetIdForEdit");
            $('#MainContent_hdnAssetIdForEdit').val(assetIdForEdit);
            isAssetEdit = true;
            $.ajax({
                url: apiUrl + "Asset/getAssetDetail?assetId=" + assetIdForEdit,
                type: "GET",
                success: function (result) {

                    if (result.length > 0) {
                        assDet = result[0];
                        $('#MainContent_ddlTagIdType').val(assDet.AssetTagTypeId);
                        $('#MainContent_assetTagId').val(assDet.AssetTagId);
                        $('#MainContent_assetName').val(assDet.AssetName);
                        $('#MainContent_assetCost').val(assDet.AssetCost);
                        $('#MainContent_ddlAssetTypes').val((assDet.AssetTypeId == 0) ? "" : assDet.AssetTypeId);
                        $('#MainContent_ddlAssetCategories').val((assDet.CategoryId == 0) ? "" : assDet.CategoryId);
                        $('#MainContent_ddlAssetCategories').change();
                        $('#MainContent_ddlVendor').val((assDet.VendorId == 0) ? "" : assDet.VendorId);
                        $('#MainContent_purchasedOn').val(assDet.PurchasedOn.split("T")[0]);
                        $('#MainContent_ddlPurchasedType').val((assDet.PurchasedTypeId == 0) ? "" : assDet.PurchasedTypeId);
                        $('#MainContent_ddlAssetSites').val((assDet.SiteId == 0) ? "" : assDet.SiteId);
                        $('#MainContent_ddlAssetSites').change();
                        $('#MainContent_ddlAssetInsurance').val((assDet.InsuranceId == 0) ? "" : assDet.InsuranceId);
                        $('#MainContent_txtWarrantyYears').val(assDet.WarrantyYears);
                        $('#MainContent_txtWarrantyMonths').val(assDet.WarrantyMonths);
                        $('#MainContent_txtWarrantyDays').val(assDet.WarrantyDays);
                        $('#MainContent_txtWarrantyExpiry').val(assDet.WarrantyExpirationDate.split("T")[0]);
                        $('#MainContent_description').val(assDet.Description);
                        $('#MainContent_warrantyDetails').val(assDet.WarrantyDetails);
                        $('#AssetImage').attr('src', "../AssetImages/" + assDet.AssetId + ".png");
                        getCustomFields(assetIdForEdit);

                    }
                },
                error: function (errormessage) {
                    console.log(errormessage.responseText);
                }
            });
        }
    }
    else if (view == "category") {
        $('#category').addClass("active");
        callCategory();
    }
    else if (view == "subcategory") {
        $('#' + view).addClass("active");
        callSubCategory();
    }
    else if (view == "purchasedtypes") {
        $('#' + view).addClass("active");
        callPurchasedTypes();
    }
    else if (view == "departments") {
        $('#' + view).addClass("active");
        callDepartments();
    }
    else if (view == "vendors") {
        $('#' + view).addClass("active");
        callVendors();
    }
    else if (view == "sites") {
        $('#' + view).addClass("active");
        callSites();
    }
    else if (view == "locations") {
        $('#' + view).addClass("active");
        callLocations();
    }
    else if (view == "locDeptLocMapping") {
        $('#' + view).addClass("active");
        callDeptLocMapping();
    }
    else if (view == "insurance") {
        $('#' + view).addClass("active");
        callInsurance();
    }

    $(".clsCategory").on('click', function () {
        window.location.href = "add-master-items.aspx?view=category";
        callCategory();
    })
    $(".clsSubCategory").on('click', function () {
        openTab("subcategory");
    })
    $(".clsPurchasedTypes").on('click', function () {
        openTab("purchasedtypes");
    });
    $(".clsDepartments").on('click', function () {
        openTab("departments");
    });
    $(".clsVendors").on('click', function () {
        openTab("vendors");
    });
    $(".clsSites").on('click', function () {
        openTab("sites");
    });
    $(".clsLocations").on('click', function () {
        openTab("locations");
    });
    $(".clsDeptLocMapping").on('click', function () {
        openTab("locDeptLocMapping");
    });
    $(".clsInsurance").on('click', function () {
        openTab("insurance");
    });
    //Status Change
    $('#rdPerson').click(function () {
        clearcontrols();
        personOrSite = 1;
        $('#divCheckoutPersion').show();
        $('#divCheckoutSite').hide();
        $('#divCheckoutLocations').hide();
        $('#divCheckoutDepartments').hide();
        $('#lblCheckout').show();
        $('#divCheckoutDate').show();
        if (sessionStorage.getItem("assetChangeStatus") == "Check Out") {
            $('#divDueDate').show();
        }
        else {
            $('#divDueDate').hide();
        }

    });
    $('#rdSite').click(function () {
        clearcontrols();
        personOrSite = 2;
        $('#divCheckoutPersion').hide();
        $('#divCheckoutSite').show();
        $('#divCheckoutLocations').show();
        $('#divCheckoutDepartments').show();
        $('#lblCheckout').show();
        if (sessionStorage.getItem("assetChangeStatus") == "Check Out") {
            $('#divDueDate').show();
        }
        else {
            $('#divDueDate').hide();
        }
    });


    $('.ddlAssetSites').on('change', function () {
        checkoutsiteid = $('#MainContent_ddlAssetSites').val();
        $.ajax({
            url: apiUrl + "Asset/getAllLocations?SiteId=" + checkoutsiteid,
            type: "GET",
            success: function (result) {

                if (result.length > 0) {
                    $("#MainContent_ddlAssetLocations").empty();
                    var $dropdown = $("#MainContent_ddlAssetLocations");
                    $dropdown.append($("<option />").val("").text("--Select--"));
                    $.each(result, function () {
                        $dropdown.append($("<option />").val(this.LocationId).text(this.LocationName));
                    });

                    if (isAssetEdit) {
                        $("#MainContent_ddlAssetLocations").val(assDet.LocationId);
                        $("#MainContent_ddlAssetLocations").change();
                    }
                }
            },
            error: function (errormessage) {
                console.log(errormessage.responseText);
            }
        });
    });

    $('.ddlAssetLocations').on('change', function () {
        checkoutlocationid = $('#MainContent_ddlAssetLocations').val();
        $.ajax({
            url: apiUrl + "Asset/getAssetDepartments?locationId=" + checkoutlocationid,
            type: "GET",
            success: function (result) {

                if (result.length > 0) {
                    $("#MainContent_ddlAssetDepartments").empty();
                    var $dropdown = $("#MainContent_ddlAssetDepartments");
                    $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                    $.each(result, function () {
                        $dropdown.append($("<option />").val(this.deptId).text(this.deptName));
                    });
                    if (isAssetEdit) {
                        $("#MainContent_ddlAssetDepartments").val(assDet.DepartmentId);
                    }
                }
            },
            error: function (errormessage) {
                console.log(errormessage.responseText);
            }
        });
    });

    $('.ddlAssetCategories').on('change', function () {

        $("#MainContent_ddlSubCategories").empty();
        $.ajax({
            url: apiUrl + "Asset/getAssetSubCategories?categoryId=" + $('#MainContent_ddlAssetCategories').val(),
            type: "GET",
            success: function (result) {
                if (result.length > 0) {
                    var $dropdown = $("#MainContent_ddlSubCategories");
                    $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                    $.each(result, function () {
                        $dropdown.append($("<option />").val(this.subCategoryId).text(this.subCategoryName));
                    });
                    if (isAssetEdit) {
                        $("#MainContent_ddlSubCategories").val(assDet.SubCategoryId);
                        //$("#MainContent_ddlSubCategories").change();
                        getGlobalFields(assetIdForEdit, assDet.SubCategoryId);
                    }
                }
            },
            error: function (errormessage) {
                console.log(errormessage.responseText);
            }
        });
    });
    $('.ddlSubCategories').on('change', function () {

        var categoryId = $('#MainContent_ddlAssetCategories').val();
        var subCategoryId = $('#MainContent_ddlSubCategories').val();

        if (subCategoryId > 0) {
            if (window.location.href.endsWith("edit-asset.aspx")) {
                getGlobalFieldsForCategory(subCategoryId);
            }
            else {
                $("#MainContent_ddlGlobalFields").empty();
                $.ajax({
                    url: apiUrl + "Asset/getAssetGlobalFields?CategoryId=" + categoryId + "&SubCategoryId=" + subCategoryId,
                    type: "GET",
                    success: function (result) {

                        console.log(result);
                        if (result.length > 0) {
                            var $dropdown = $("#MainContent_ddlGlobalFields");
                            $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                            $.each(result, function () {
                                $dropdown.append($("<option />").val(this.UniqueId).text(this.FieldName));
                            });

                        }
                    },
                    error: function (errormessage) {
                        $('#divLoader').hide();
                        alert(errormessage.responseText);
                    }
                });
            }
        }
    });

    $('.ddlCurrency ').on('change', function () {

        var obj = new Object;
        obj.UniqueId = 1;
        obj.ClientId = 1;
        obj.CurrencyId = $('#ddlCurrency').val();
        $.ajax({
            type: "POST",
            url: apiUrl + "Asset/UpdateClientGlobalSettings",
            dataType: 'json',
            data: obj,
            success: function (response) {
                showSwal("Currency updated successfully", 'S');
            },
            failure: function (response) {
                showSwal("Currency update Failed", 'E');
            }
        });
    });

});
function getGlobalFieldsForCategory(subCatId) {
    var categoryId = $('#MainContent_ddlAssetCategories').val();
    var subCategoryId = ($('#MainContent_ddlSubCategories').val() == null) ? subCatId : $('#MainContent_ddlSubCategories').val();

    $.ajax({
        url: apiUrl + "Asset/getAssetGlobalFields?CategoryId=" + categoryId + "&SubCategoryId=" + subCategoryId,
        type: "GET",
        success: function (result) {

            console.log(result);
            if (result.length > 0) {
                $('#MainContent_hdnGlobalFiedCount').val(result.length);
                //hdnGlobalFiedCount
                var html = '';
                var counter = (result.length > 3) ? Math.round(result.length / 3) : result.length;

                for (var idx = 0; idx < result.length;) {
                    html += '<tr class="ui-require" id="tr_' + (idx + 1).toString() + '">';
                    html += '<td class="p-0"><div class="row">';
                    if ((idx + counter) > result.length)
                        counter = result.length - counter;
                    else
                        counter = idx + counter;
                    for (var j = 0; j < counter; j++) {
                        var fieldId = "txtGlobalFiled_" + (idx + 1);
                        html += '<div class="col-md-4"><label class="col-form-label" id="txtGlobal_' + (idx + 1) + '" name="txtGlobal_' + (idx + 1) + '">' + result[idx].FieldName + '<span class="text-danger">*</span></label>';

                        html += "<div class=\"form-group row\"><div class=\"col-sm-10\"><input type=\"text\" id=\"" + fieldId + "\" name=\"" + fieldId + "\" class=\"form-control\" required \/>";
                        html += '<input type="hidden" id="hdn_' + (idx + 1) + '" value = ' + result[idx].UniqueId + ' name="hdn_' + (idx + 1) + '" value = ' + result[idx].UniqueId + ' minlength="2"  maxlength="25" \/>';
                        html += '<input type="hidden" id="hdnFieldName_' + (idx + 1) + '" value = ' + result[idx].FieldName + ' name="hdnFieldName_' + (idx + 1) + '"  minlength="2"  maxlength="25" \/>';
                        html += "";
                        html += '</div></div></div>'
                        idx++;
                    }
                    html += '</div></td></tr>';
                }
                $('.globalFieldsBody').html(html);
                $('#divGlobalFields').show();
            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });
}
function getGlobalFields(assetId, subCategoryId) {

    $.ajax({
        url: apiUrl + "Asset/getAssetGlobalFieldsMapping?assetId=" + assetId,
        type: "GET",
        success: function (result) {
            if (result.length > 0) {

                $('#MainContent_hdnIsGlobalFiedlContainValues').val("1");
                $('#MainContent_hdnGlobalFiedCount').val(result.length);
                //hdnGlobalFiedCount
                var html = '';
                var counter = (result.length > 3) ? Math.round(result.length / 3) : result.length;

                for (var idx = 0; idx < result.length;) {
                    html += '<tr class="ui-require" id="tr_' + (idx + 1).toString() + '">';
                    html += '<td><div class="row">';
                    if ((idx + counter) > result.length)
                        counter = result.length - counter;
                    else
                        counter = idx + counter;
                    for (var j = 0; j < counter; j++) {
                        var fieldId = "txtGlobalFiled_" + (idx + 1);
                        html += '<div class="col-md-4"><label class="col-form-label" id="txtGlobal_' + (idx + 1) + '" name="txtGlobal_' + (idx + 1) + '">' + result[idx].FieldName + '<span class="text-danger">*</span></label>';

                        html += "<div class=\"form-group row\"><div class=\"col-sm-10\"><input type=\"text\" id=\"" + fieldId + "\" name=\"" + fieldId + "\" class=\"form-control\" value=\"" + result[idx].Value + "\" minlength=\"2\"  maxlength=\"25\" required \/>";
                        html += '<input type="hidden" id="hdn_' + (idx + 1) + '" value = ' + result[idx].MappingId + ' name="hdn_' + (idx + 1) + '" minlength="2"  maxlength="25" \/>';
                        //html += '<input type="hidden" id="hdnFieldName_' + (idx + 1) + '" value = ' + result[idx].FieldName + ' name="hdnFieldName_' + (idx + 1) + '"  minlength="2"  maxlength="25" \/>';
                        html += "";
                        html += '</div></div></div>'
                        idx++;
                    }
                    html += '</div></td></tr>';
                }
                $('.globalFieldsBody').html(html);
                $('#divGlobalFields').show();
            }
            else {
                getGlobalFieldsForCategory(subCategoryId);
            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            console.log(errormessage.responseText);
        }
    });
}
function getCustomFields(assetId) {
    $.ajax({
        url: apiUrl + "Asset/getAssetCustomDetails?assetId=" + assetId,
        type: "GET",
        success: function (result) {

            console.log(result);
            if (result.length > 0) {
                $('#removebtn_1').show();
                $('#txtCustomFieldName_1').val(result[0].CustomFieldName);
                $('#txtCustomFieldValue_1').val(result[0].CustomFieldValue);
                $('#hdnCustomField_1').val(result[0].CustomFieldId)
                for (var idx = 2; idx <= result.length; idx++) {
                    $('.btn-add').click();
                    $('#hdnCustomField_' + idx).val(result[idx - 1].CustomFieldId)
                    $('#txtCustomFieldName_' + idx).val(result[idx - 1].CustomFieldName);
                    $('#txtCustomFieldValue_' + idx).val(result[idx - 1].CustomFieldValue);
                }

            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}
function getClientGlobalSettings() {
    $.ajax({
        url: apiUrl + "Asset/getClientGlobalSettings?ClientId=1",
        type: "GET",
        success: function (result) {

        },
        error: function (errormessage) {
            $('#divLoader').hide();
            console.log(errormessage.responseText);
        }
    });
}
function clearcontrols() {
    $('#txtDate').val("");
    $('#txtReturnDate').val("");
    $('#txtRemarks').val("");
    $('#MainContent_ddlAssetSites').val("");
    $('#MainContent_ddlAssetLocations').val("");
    $('#MainContent_ddlAssetDepartments').val("");
    $('#txtDueDate').val("");

}
function getQueryVariable(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split('&');
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split('=');
        if (decodeURIComponent(pair[0]) == variable) {
            return decodeURIComponent(pair[1]);
        }
    }
}

function showSwal(txt, icon) {
    Swal.fire({
        text: txt,
        icon: icon === 'S' ? 'success' : 'error',
        showCancelButton: false,
        showConfirmButton: false,
        width: "30%",
        height: "50%",
        timer: 2000,
    });
};



function openTab(param) {
    window.location.href = "add-master-items.aspx?view=" + param
}

function setBtnText(id, btnText) {
    $("#" + id).html('<i class="far fa-save"></i> ' + btnText);
}

function callCategory() {

    //Clear the Data Table for new fetch
    if ($.fn.DataTable.isDataTable("#tblCategories")) {
        $('#tblCategories').DataTable().clear().destroy();
    }
    $.ajax({
        url: apiUrl + "Asset/getAssetCategories",
        type: "GET",
        success: function (result) {
            categoryList = result;
            var html = '';
            if (result.length > 0) {
                $.each(result, function (key, response) {
                    var actionHtml = "<td><a href=\"#\" class=\"btn-sm\" title=\"Add Sub Category\"  onclick = openSubCategoryModal(" + response.categoryId + ",0)> <i class=\"fa fa-plus text-primary\"></i> </a>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\" title=\"Edit\" onclick=\"openCategoryModal(" + response.categoryId + ")\"> <i class=\"fa fa-edit text-secondary\"></i> </a>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\"><i class=\"far fa-trash-alt text-red\"></i> </a></td>";


                    html += '<tr style="cursor:pointer;hover:green">';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + response.categoryName + '</td>';
                    html += '<td>' + response.description + '</td>';
                    html += actionHtml;
                    html += '</tr>';
                });
                $('.categoryBody').html(html);
                $('#divLoader').hide();
            } else {
                $('#divLoader').hide();
                $('#noRecordsFound').show();
                loadDataTable("tblCategories", "No categories found.");
            }
           
            $('#divCategory').show();
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });
}

function openCategoryModal(categoryId) {
    var idx = categoryList.findIndex(s => s.categoryId == categoryId);
    if (idx != -1) {
        $('#txtCategoryId').val(categoryId);
        $('#txtCategoryName').val(categoryList[idx].categoryName);
        $('#txtCategoryDescription').val(categoryList[idx].description);
    }
    else {
        $('#txtCategoryId').val(categoryId);
        $('#txtCategoryName').val("");
        $('#txtCategoryDescription').val("");
    }
    setBtnText("btnCategorySave", categoryId == 0 ? "Save" : "Update");
    $("#mdlAddCategory").modal("show");

    $("#frmAddCategory").submit(function (e) {
    e.preventDefault();
    var id = $('#txtCategoryId').val();
    var name = $('#txtCategoryName').val();
    var description = $('#txtCategoryDescription').val();
    $.ajax({
        type: "POST",
        url: apiUrl + "Asset/saveCategory?categoryId=" + id + "&categoryName=" + name + "&categoryDescription=" + description,
        success: function (response) {
            $("#mdlAddCategory").modal("hide");
            var txt = "Catergory has been added successfully";
            if (id != "0")
                txt = "Catergory has updated successfully";
            showSwal(txt,'S')
            window.setTimeout(function () {
                location.reload();
            }, 1600);
        },
        failure: function (response) {
            showSwal(errotTxt, 'E')
        }
    });
    return false;
});
}

function openSubCategoryModal(categoryId, subCategoryId) {

    var idx = subCategories.findIndex(s => s.subCategoryId == subCategoryId);
    if (idx != -1) {
        $('#txtSubCategoryId').val(subCategories[idx].subCategoryId);
        $('#txtSubCategoryName').val(subCategories[idx].subCategoryName);
        $('#txtSubCategoryDescription').val(subCategories[idx].description);
    }
    else {
        $('#txtSubCategoryId').val(0);
        $('#txtSubCategoryName').val("");
        $('#txtSubCategoryDescription').val("");
    }
    $('#txtCategoryMappingId').val(categoryId);
    $("#mdlAddSubCategory").modal("show");
    setBtnText("btnSubCategorySave", subCategoryId == 0 ? "Save" : "Update");
    $("#frmAddSubCategory").submit(function (e) {
        e.preventDefault();
        var id = $('#txtSubCategoryId').val();
        var name = $('#txtSubCategoryName').val();
        var description = $('#txtSubCategoryDescription').val();
        var categoryId = $('#txtCategoryMappingId').val();

        $.ajax({
            type: "POST",
            url: apiUrl + "Asset/saveSubCategory?CategoryId=" + categoryId + '&subCategoryId=' + id + '&subCategoryName=' + name + '&subCategoryDescription=' + description,
            success: function (response) {
                $("#mdlAddSubCategory").modal("hide");
                var txt = "Subcatergory has been added Successfully!";
                if (id != "0")
                    txt = "Subcatergory has updated Successfully!";
                showSwal(txt, 'S');
                window.setTimeout(function () {
                    location.reload();
                }, 1600);

            }
        })
    });
}

function callSubCategory() {
    //Clear the Data Table for new fetch
    if ($.fn.DataTable.isDataTable("#tblSubCategories")) {
        $('#tblSubCategories').DataTable().clear().destroy();
    }
    $.ajax({
        url: apiUrl + "Asset/getAssetSubCategories?categoryId=0",
        type: "GET",
        success: function (result) {

            categoryList = result;
            var html = '';
            if (result.length > 0) {
                subCategories = result;
                $.each(result, function (key, response) {
                    var actionHtml = "<td><a href=\"#\" class=\"btn-sm\" title=\"Edit\" onclick = openSubCategoryModal(" + response.categoryId + "," + response.subCategoryId +")> <i class=\"fa fa-edit text-secondary\"></i> </a>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\"><i class=\"far fa-trash-alt text-red\"></i> </a></td>";
                    html += '<tr style="cursor:pointer;hover:green">';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + response.categoryName + '</td>';
                    html += '<td>' + response.subCategoryName + '</td>';
                    html += '<td>' + response.description + '</td>';
                    html += actionHtml;
                    html += '</tr>';
                });
                $('.subCategoryBody').html(html);
                $('#divLoader').hide();
                $('#divSubCategory').show();
            } else {
                $('#divLoader').hide();
                loadDataTable("tblSubCategories", "No sub categories found.");
                $('#noRecordsFound').show();
                $('#divSubCategory').show();
            }
           

        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });



}

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

function getCountries() {
    return $.ajax({
        url: apiUrl + "Asset/getCountries",
        type: "GET",
        success: function (results) {
            countries = results;
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}

function getStates(countryid) {
    return $.ajax({
        url: apiUrl + "Asset/getStates?countryId=" + countryid,
        type: "GET",
        success: function (results) {
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}

function openSitesModal(SiteId) {
    var idx = sites.findIndex(s => s.SiteId == SiteId);
    var cid = 0, s;
    if (idx != -1) {
        s = sites[idx];
        cid = s.CountryId;
    }
    $("#txtCountries").change(function () {
        var countryId = $('option:selected', this).val();
        getStates(countryId).then(function (result) {
            setOptions("txtStates", result, "State");
        });
    });
    function setSiteValues(SiteId, SiteName, Address, City, StateId, CountryId) {
        $("#mdlSites").modal("show");

        $('#txtSiteId').val(SiteId);
        $('#txtSiteName').val(SiteName);
        $('#txtSiteAddress').val(Address);
        $('#txtSiteCity').val(City);
        $('#txtCountries').val(CountryId);
        $('#txtStates').val(StateId);
        setBtnText("btnSiteSave", SiteId == 0 ? "Save" : "Update");

    }

    getCountries().then(function (results) {
        setOptions("txtCountries", results, "Country");
        if (cid > 0) {
            getStates(cid).then(function (result) {
                setOptions("txtStates", result, "State");
                if (idx != -1) {
                    setSiteValues(s.SiteId, s.SiteName, s.Address, s.City, s.StateId, s.CountryId);
                } else {
                    setSiteValues(0, "", "", "", -1, -1);
                }
            });
        } else {
            setSiteValues(0, "", "", "", -1, -1);
        }


    });

    $("#frmAddSites").submit(function (e) {
        e.preventDefault();
        var id = $('#txtSiteId').val();
        var name = $('#txtSiteName').val();
        var address = $('#txtSiteAddress').val();
        var city = $('#txtSiteCity').val();
        var stateid = $('#txtStates').val();
        var countryid = $('#txtCountries').val();
        var clsAllSites = {
            SiteId: id,
            SiteName: name,
            Address: address,
            City: city,
            StateId: stateid,
            StateName: "",
            CountryId: countryid,
            CountryName: "",
            CreatedBy: "1",
            IsDeleted: 0,
            CreatedOn: new Date()
        }

        $.ajax({
            type: "POST",
            url: apiUrl + "Asset/saveSites",
            dataType: "json",
            data: clsAllSites,
            success: function (response) {
                var txt = "Site has been added successfully";
                if (id != "0")
                    txt = "Site has updated successfully";
                showSwal(txt, 'S');
                window.setTimeout(function () {
                    location.reload();
                }, 1600);
            },
            failure: function (response) {
                showSwal(errorTxt, 'E');
            }
        });
        return false;
    });


}

function callSites(SiteId) {
    $.ajax({
        url: apiUrl + "Asset/getAllSites",
        type: "GET",
        success: function (results) {

            var html = '';
            if (results.length > 0) {
                sites = results;
                $.each(results, function (key, response) {
                    var actionHtml = "<td>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\" title=\"Edit\" onclick=\"openSitesModal(" + response.SiteId + ")\"> <i class=\"fa fa-edit text-secondary\"></i> </a>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\"><i class=\"far fa-trash-alt text-red\"></i> </a></td>";

                    html += '<tr style="cursor:pointer;hover:green">';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + response.SiteName + '</td>';
                    html += '<td>' + response.Address + '</td>';
                    html += '<td>' + response.City + '</td>';
                    html += '<td>' + response.StateName + '</td>';
                    html += '<td>' + response.CountryName + '</td>';
                    html += actionHtml;
                    html += '</tr>';
                });
                $('.sitesBody').html(html);
            }
            else {
                loadDataTable("tblSites", "No sites found.");
            }
            
            $('#divLoader').hide();
            $('#divSites').show();
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });
};

function openLocationsModal(LocationId) {
    function getSites() {
        $.ajax({
            url: apiUrl + "Asset/getAllSites",
            type: "GET",
            success: function (results) {

                if (results.length > 0) {
                    setOptions("txtSiteLocation", results, "Site");
                    var idx = locations.findIndex(d => d.LocationId == LocationId);

                    if (idx != -1) {
                        var dt = locations[idx];
                        $('#txtLocationId').val(locations[idx].LocationId);
                        $('#txtSiteLocation').val(locations[idx].SiteId);
                        $('#txtLocationName').val(locations[idx].LocationName);
                    }
                    else {
                        $('#txtLocationId').val(0);
                        $('#txtSiteLocation').val(-1);
                        $('#txtLocationName').val("");
                    }
                    $("#mdlLocations").modal("show");
                    setBtnText("btnLocationSave", LocationId == 0 ? "Save" : "Update");
                }
            },
            error: function (errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
    getSites();
    $("#frmAddLocations").submit(function (e) {
        e.preventDefault();
        var id = $('#txtLocationId').val();
        var siteId = $('#txtSiteLocation').val();
        var locationName = $('#txtLocationName').val();

        $.ajax({
            type: "POST",
            url: apiUrl + "Asset/saveLocations?locationId=" + id + "&siteId=" + siteId + "&locationName=" + locationName,
            success: function (response) {
                $("#mdlAddCategory").modal("hide");
                var txt = "Location has been added successfully";
                if (id != "0")
                    txt = "Location has updated successfully";
                showSwal(txt,'S');
                window.setTimeout(function () {
                    location.reload();
                }, 1600);
            },
            failure: function (response) {
                showSwal(errorTxt,'E');
            }
        });
        return false;
    });
}

function callLocations() {
    $.ajax({
        url: apiUrl + "Asset/getAllLocations?SiteId=0",
        type: "GET",
        success: function (results) {

            var html = '';
            if (results.length > 0) {
                locations = results;
                $.each(results, function (key, response) {
                    var actionHtml = "<td>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\" title=\"Edit\" onclick=\"openLocationsModal(" + response.LocationId + ")\"> <i class=\"fa fa-edit text-secondary\"></i> </a>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\"><i class=\"far fa-trash-alt text-red\"></i> </a></td>";

                    html += '<tr style="cursor:pointer;hover:green">';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + response.LocationName + '</td>';
                    //html += '<td>' + response.Address + '</td>';
                    //html += '<td>' + response.City + '</td>';
                    //html += '<td>' + response.StateName + '</td>';
                    //html += '<td>' + response.CountryName + '</td>';
                    html += '<td>' + response.SiteName + '</td>';
                    html += actionHtml;
                    html += '</tr>';
                });
                $('.locationsBody').html(html);
            }
            else {
                loadDataTable("tblLocations", "No sites found.");
            } 
        
            $('#divLoader').hide();
            $('#divLocations').show();
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });


}

function filterCategory(json) {

    var lookup = {};
    var items = json;
    var result = [];

    for (var item, i = 0; item = items[i++];) {
        var categoryId = item.categoryId;

        if (!(categoryId in lookup)) {
            lookup[categoryId] = 1;
            result.push(item);
        }
    }
    return result;
}

function filterSubCategory(json, categoryId) {


    var result = json.filter(function (hero) {
        return hero.categoryId == categoryId;
    });
    return result;
}

function filterLocation(json) {

    var lookup = {};
    var items = json;
    var result = [];

    for (var item, i = 0; item = items[i++];) {
        var locationId = item.locationId;

        if (!(categoryId in lookup)) {
            lookup[locationId] = 1;
            result.push(item);
        }
    }
    return result;
}

function filterDepartments(json, locationId) {
    var result = json.filter(function (item) {
        return item.locationId == locationId;
    });
    return result;
}


function callPurchasedTypes() {
    $.ajax({
        url: apiUrl + "Asset/getAllPurchasedTypes",
        type: "GET",
        success: function (result) {

            var html = '';
            if (result.length > 0) {
                purchasedTypes = result;
                $.each(result, function (key, response) {
                    var actionHtml = '<td><a href=\"#\" id=\"' + response.PurchasedId + '\" class=\"btn-sm editpurchasedType\" title=\"Edit\" onclick=\"openPurchasedTypeModal(' + response.PurchasedId + ')\"> <i class=\"fa fa-edit text-secondary\"></i> </a>';
                    actionHtml = actionHtml + '<a href=\"#\" class=\"btn-sm\"><i class=\"far fa-trash-alt text-red\"></i> </a></td>';
                    html += '<tr style="cursor:pointer;hover:green">';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + response.PurchasedType + '</td>';
                    html += '<td>' + response.Description + '</td>';
                    html += actionHtml;
                    html += '</tr>';
                });
                $('.purchasedTypeBody').html(html);
            }
            else {
                loadDataTable("tblPurchasedTypes", "No sites found.");
            }
            $('#divLoader').hide();
            $('#divPurschasedTypes').show();
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });
}

function openPurchasedTypeModal(PurchasedId) {

    var idx = purchasedTypes.findIndex(p => p.PurchasedId == PurchasedId);
    if (idx != -1) {
        $('#txtPurchasedTypeName').val(purchasedTypes[idx].PurchasedType);
        $('#txtPurchasedTypeDescription').val(purchasedTypes[idx].Description);
    }
    else {
        $('#txtPurchasedTypeName').val("");
        $('#txtPurchasedTypeDescription').val("");
    }
    $('#txtPurchasedTypeId').val(PurchasedId);
    $("#mdlPurchasedType").modal("show");
    setBtnText("btnPurchasedTypeSave", PurchasedId == 0 ? "Save" : "Update");
    $("#frmAddPurchasedType").submit(function () {
        var id = $('#txtPurchasedTypeId').val();
        var name = $('#txtPurchasedTypeName').val();
        var description = $('#txtPurchasedTypeDescription').val();
        $.ajax({
            type: "POST",
            url: apiUrl + "Asset/savePurchasedType?id=" + id + "&name=" + name + '&description=' + description,
            success: function (response) {
                var txt = "Purchased type has been added successfully";
                if (id != "0")
                    txt = "Purchased type has updated successfully";
                showSwal(txt,'S');
                window.setTimeout(function () {
                    location.reload();
                }, 1600);
            },
            failure: function (response) {
                showSwal(txt, 'E');
            }
        });
        return false;
    });
}


function openDeptModal(deptId) {
    var idx = departments.findIndex(d => d.deptId == deptId);
    $('#txtDepartmentId').val(0);
    $('#txtDepartmentName').val("");
    $('#txtDepartmentDescription').val("");
    if (idx != -1) {
        var dt = departments[idx];
        $('#txtDepartmentId').val(dt.deptId);
        $('#txtDepartmentName').val(dt.deptName);
        $('#txtDepartmentDescription').val(dt.description);
    }
    $("#mdlDepartments").modal("show");
    setBtnText("btnDepartmentSave", deptId == 0 ? "Save" : "Update");
    $("#frmAddDepartments").submit(function (e) {
        e.preventDefault();
        var id = $('#txtDepartmentId').val();
        var name = $('#txtDepartmentName').val();
        var description = $('#txtDepartmentDescription').val();
        $.ajax({
            type: "POST",
            url: apiUrl + "Asset/saveDepartments?id=" + id + "&name=" + name + '&description=' + description,
            success: function (response) {
                var txt = "Department has been added successfully";
                if (id != "0")
                    txt = "Department has updated successfully";
                showSwal(txt,'S');
                window.setTimeout(function () {
                    location.reload();
                }, 1600);
            },
            failure: function (response) {
                showSwal(errorTxt, 'S');
            }
        });
        return false;
    });

}

function callDepartments() {
    $.ajax({
        url: apiUrl + "Asset/getAssetDepartments?locationId=0",
        type: "GET",
        success: function (results) {

            var html = '';
            if (results.length > 0) {
                departments = results;
                $.each(results, function (key, response) {
                    var actionHtml = "<td>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\" title=\"Edit\" onclick=\"openDeptModal(" + response.deptId + ")\"> <i class=\"fa fa-edit text-secondary\"></i> </a>";
                    actionHtml = actionHtml + "<a href=\"#\" class=\"btn-sm\"><i class=\"far fa-trash-alt text-red\"></i> </a></td>";

                    html += '<tr style="cursor:pointer;hover:green">';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + response.deptName + '</td>';
                    html += '<td>' + response.description + '</td>';
                    html += actionHtml;
                    html += '</tr>';
                });
                $('.departmentsBody').html(html);
            }
            else {
                loadDataTable("tblDepartments", "No sites found.");
            }
            $('#divLoader').hide();
            $('#divDepartments').show();
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });
}

function openDeptLocMapping(MappingId) {
    var locations = [], departments = [];

    $("#txtLocations").change(function () {
        var locationId = $('option:selected', this).val();
        var index;
        var tempArray = departments.slice();
        var filteredList = locDeptMappingList.filter(function (obj) {
            return obj.locationId == locationId;
        });
        for (var i = 0; i < filteredList.length; i++) {
            index = tempArray.findIndex(d => d.deptId == filteredList[i].deptId);
            if (index > -1) {
                tempArray.splice(index, 1);
            }
        }

        setOptions("txtDepartments", tempArray, "dept");
    })


    function getLocations() {
        $.ajax({
            url: apiUrl + "Asset/getAllLocations?SiteId=0",
            type: "GET",
            success: function (results) {

                var html = '';
                if (results.length > 0) {
                    locations = results;
                    setOptions("txtLocations", results, "Location");
                    getDepartments();
                }
            },
            error: function (errormessage) {
                alert(errormessage.responseText);
            }
        });
    }

    function getDepartments() {
        $.ajax({
            url: apiUrl + "Asset/getAssetDepartments?locationId=0",
            type: "GET",
            success: function (result) {
                var idx = locDeptMappingList.findIndex(s => s.MappingId == MappingId);
                if (result.length > 0) {
                    departments = result.slice();
                    setOptions("txtDepartments", result, "dept");
                }

                if (idx != -1) {
                    $('#txtDeptLocMappingId').val(locDeptMappingList[idx].MappingId);
                    $('#txtLocations').val(locDeptMappingList[idx].locationId);
                    $('#txtDepartments').val(locDeptMappingList[idx].deptId);
                }
                else {
                    $('#txtDeptLocMappingId').val(0);
                    $('#txtLocations').val(-1);
                    $('#txtDepartments').val(-1);
                }
                $("#mdlDeptLocMapping").modal("show");
                setBtnText("btnDeptLocMappingSave", MappingId == 0 ? "Save" : "Update");
            },
            error: function (errormessage) {
                alert(errormessage.responseText);
            }
        });
    }
    getLocations();

    $("#frmAddDeptLocMapping").submit(function () {
        var id = $('#txtDeptLocMappingId').val();
        var locationId = $('#txtLocations').val();
        var deptId = $('#txtDepartments').val();
        $.ajax({
            type: "POST",
            url: apiUrl + "Asset/saveDepartmentLocationMapping?mappingId=" + id + "&locationId=" + locationId + "&deptId=" + deptId,
            success: function (response) {
                $("#mdlAddCategory").modal("hide");
                var txt = "Location and Department mapping has been added successfully";
                if (id != "0")
                    txt = "Location and Department mapping has updated successfully";
                showSwal(txt, 'S');
                window.setTimeout(function () {
                    location.reload();
                }, 1600);
            },
            failure: function (response) {
                showSwal(errorTxt, 'E');
            }
        });
        return false;
    });
}

function callDeptLocMapping() {
    $.ajax({
        url: apiUrl + "Asset/getLocationAndDepartments",
        type: "GET",
        success: function (result) {
            var html = '';
            if (result.length > 0) {
                locDeptMappingList = result;
                $.each(result, function (key, response) {
                    var actionHtml = '<td><a href=\"#\" id=\"' + response.MappingId + '\" class=\"btn-sm editpurchasedType\" title=\"Edit\" onclick=\"openDeptLocMapping(' + response.MappingId + ')\"> <i class=\"fa fa-edit text-secondary\"></i> </a>';
                    actionHtml = actionHtml + '<a href=\"#\" class=\"btn-sm\"><i class=\"far fa-trash-alt text-red\"></i> </a></td>';
                    html += '<tr style="cursor:pointer;hover:green">';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + response.locationName + '</td>';
                    html += '<td>' + response.deptName + '</td>';
                    html += actionHtml;
                    html += '</tr>';
                });

                $('.deptLocMappingBody').html(html);
            }
            else {
                loadDataTable("tblDeptLocMapping", "No location and department mapping found.");
            }
            $('#divDeptLocMapping').show();
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}

function openViewVendorModal(vendorId) {
    var idx = vendorsList.findIndex(v => v.vendorId == vendorId);
    var v = vendorsList[idx];
    $("#mdlViewVendors").modal("show");

    $('#txtVendorName_view').text(v.vendorName);
    $('#txtVendorAddress_view').text(v.address);
    $('#txtVendorCity_view').text(v.city);
    $('#txtVendorCountry_view').text(v.countryName);
    $('#txtVendorState_view').text(v.stateName);
    $('#txtVendorContactPerson_view').text(v.contactPerson);
    $('#txtVendorContactNumber_view').text(v.contactNumber);
    $('#txtVendorEmail_view').text(v.email);
    $('#txtVendorFax_view').text(v.fax);
    $('#txtVendorWebsite_view').text(v.websiteURL);
}

function openVendorModal(vendorId) {
    var idx = vendorsList.findIndex(v => v.vendorId == vendorId);
    var cid = 0, v;
    if (idx != -1) {
        v = vendorsList[idx];
        cid = v.countryId;
    }
    $("#txtVendorCountry").change(function () {
        var countryId = $('option:selected', this).val();
        getStates(countryId).then(function (result) {
            setOptions("txtVendorState", result, "State");
        });
    });
    function setVendorValues(vendorId, vendorName, address, city, stateId, countryId, contactPerson, email, contactNumber, fax, websiteURL) {
        $("#mdlVendors").modal("show");

        $('#txtVendorId').val(vendorId);
        $('#txtVendorName').val(vendorName);
        $('#txtVendorAddress').val(address);
        $('#txtVendorCity').val(city);
        $('#txtVendorCountry').val(countryId);
        $('#txtVendorState').val(stateId);
        $('#txtVendorContactPerson').val(contactPerson);
        $('#txtVendorContactNumber').val(contactNumber);
        $('#txtVendorEmail').val(email);
        $('#txtVendorFax').val(fax);
        $('#txtVendorWebsite').val(websiteURL);
        setBtnText("btnVendorSave", vendorId == 0 ? "Save" : "Update");

    }

    getCountries().then(function (results) {
        setOptions("txtVendorCountry", results, "Country");
        if (cid > 0) {
            getStates(cid).then(function (result) {
                setOptions("txtVendorState", result, "State");
                if (idx != -1) {
                    setVendorValues(v.vendorId, v.vendorName, v.address, v.city, v.stateId, v.countryId, v.contactPerson, v.email, v.contactNumber, v.fax, v.websiteURL);
                } else {
                    setVendorValues(0, "", "", "", -1, -1, "", "", "", "", "");
                }
            });
        } else {
            setVendorValues(0, "", "", "", -1, -1, "", "", "", "", "");
        }


    });

    $("#frmAddVendors").submit(function (e) {
        e.preventDefault();
        var id = $('#txtVendorId').val();
        var vendorName = $('#txtVendorName').val();
        var address = $('#txtVendorAddress').val();
        var city = $('#txtVendorCity').val();
        var countryId = $('#txtVendorCountry').val();
        var stateId = $('#txtVendorState').val();
        var contactPerson = $('#txtVendorContactPerson').val();
        var contactNumber = $('#txtVendorContactNumber').val();
        var email = $('#txtVendorEmail').val();
        var fax = $('#txtVendorFax').val();
        var websiteURL = $('#txtVendorWebsite').val();
        var clsAllVendor = {
            vendorId: id,
            vendorName: vendorName,
            address: address,
            city: city,
            stateId: stateId,
            stateName: "",
            countryId: countryId,
            countryName: "",
            contactPerson: contactPerson,
            contactNumber: contactNumber,
            email: email,
            fax: fax,
            websiteURL: websiteURL
        }

        $.ajax({
            type: "POST",
            url: apiUrl + "Asset/saveVendors",
            dataType: "json",
            data: clsAllVendor,
            success: function (response) {
                var txt = "Vendor has been added successfully";
                if (id != "0")
                    txt = "Vendor has updated successfully";
                showSwal(txt,'S');
                window.setTimeout(function () {
                    location.reload();
                }, 1600);
            },
            failure: function (response) {
                showSwal(errorTxt, 'E');
            }
        });
        return false;
    });

}

function getAllVendors() {
    $("#MainContent_ddlVendor").empty();
    $.ajax({
        url: apiUrl + "Asset/getVendors?vendorId=0",
        type: "GET",
        success: function (result) {

            if (result.length > 0) {

                var $dropdown = $("#MainContent_ddlVendor");
                $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                $.each(result, function () {
                    $dropdown.append($("<option />").val(this.vendorId).text(this.vendorName));
                });
            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });
}

function getDate(input, format) {
    var rtDate = "";
    if (input == "")
        return rtDate;

    var dt = new Date(input);
    var day = ("0" + dt.getDate()).slice(-2);
    var month = ("0" + (dt.getMonth() + 1)).slice(-2);
    if (format == "YYYYMMDD")
        rtDate = dt.getFullYear() + "-" + (month) + "-" + (day);
    else if (format == "DDMMYYYY")
        rtDate = (day) + "-" + (month) + "-" + dt.getFullYear();

    return rtDate;
}


function callVendors() {
    $.ajax({
        url: apiUrl + "Asset/getVendors?vendorId=0",
        type: "GET",
        success: function (result) {

            var html = '';
            if (result.length > 0) {
                vendorsList = result;
                $.each(result, function (key, response) {
                    var actionHtml = '<td><a href=\"#\" class=\"btn-sm\" title=\"View\" onclick=\"openViewVendorModal(\'' + response.vendorId + '\')\"> <i class=\"fa fa-eye text-secondary\"></i> </a>';
                    actionHtml = actionHtml + '<a href=\"#\" class=\"btn-sm\" title=\"Edit\" onclick=\"openVendorModal(\'' + response.vendorId + '\')\"> <i class=\"fa fa-edit text-secondary\"></i> </a>';
                    actionHtml = actionHtml + '<a href=\"#\" class=\"btn-sm\"><i class=\"far fa-trash-alt text-red\"></i> </a></td>';
                    html += '<tr style="cursor:pointer;hover:green">';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + response.vendorName + '</td>';
                    html += '<td>' + response.address + '</td>';
                    html += '<td>' + response.city + '</td>';
                    //html += '<td>' + response.stateName + ' / ' + response.countryName + '</td>';
                    html += '<td>' + response.contactPerson + '</td>';
                    html += '<td>' + response.contactNumber + '</td>';
                    //html += '<td>' + response.email + '</td>';
                    //html += '<td>' + response.fax + '</td>';
                    //html += '<td>' + response.websiteURL + '</td>';
                    html += actionHtml;
                    html += '</tr>';
                });
                $('.vendorsBody').html(html);
            }
            else {
                loadDataTable("tblVendors", "No location and department mapping found.");
            }
            $('#divVendors').show();
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });
}
function setInsuranceValues(insuranceId, policyNumber, policyName, coverageAmount, startDate, endDate, premium, description, insuranceCompany, contactPerson, contactNumber, contactEmail) {

    $("#mdlInsurance").modal("show");

    $('#txtInsuranceId').val(insuranceId);
    $('#txtPolicyNumber').val(policyNumber);
    $('#txtPolicyName').val(policyName);
    $('#txtPolicyCoverageAmount').val(coverageAmount);
    $('#txtPolicyPremiumAmount').val(premium);
    $('#txtInsuranceCompany').val(insuranceCompany);
    $('#txtPolicyStartDate').val(getDate(startDate, "YYYYMMDD"));
    $('#txtPolicyEndDate').val(getDate(endDate, "YYYYMMDD"));

    $('#txtPolicyDescription').val(description);
    $('#txtPolicyContactPerson').val(contactPerson);
    $('#txtPolicyContactNumber').val(contactNumber);
    $('#txtPolicyContactEmail').val(contactEmail);
    setBtnText("btnInsuranceSave", insuranceId == 0 ? "Save" : "Update");
    $("#frmAddInsurance").submit(function (e) {
        e.preventDefault();
        var id = $('#txtInsuranceId').val();
        var policyNumber = $('#txtPolicyNumber').val();
        var policyName = $('#txtPolicyName').val();
        var coverageAmount = $('#txtPolicyCoverageAmount').val();
        var premium = $('#txtPolicyPremiumAmount').val();
        var insuranceCompany = $('#txtInsuranceCompany').val();
        var startDate = $('#txtPolicyStartDate').val();
        var endDate = $('#txtPolicyEndDate').val();
        var description = $('#txtPolicyDescription').val();
        var contactPerson = $('#txtPolicyContactPerson').val();
        var contactNumber = $('#txtPolicyContactNumber').val();
        var contactEmail = $('#txtPolicyContactEmail').val();
        var clsAssetInsurancePolicies = {
            insuranceId: id,
            policyNumber: policyNumber,
            policyName: policyName,
            coverageAmount: coverageAmount,
            premium: premium,
            insuranceCompany: insuranceCompany,
            startDate: startDate,
            endDate: endDate,
            description: description,
            contactPerson: contactPerson,
            contactNumber: contactNumber,
            contactEmail: contactEmail,
            isDeleted: 0,
            createdBy: 1,
            createdDate: new Date()
        }

        $.ajax({
            type: "POST",
            url: apiUrl + "Asset/saveInsurance",
            dataType: "json",
            data: clsAssetInsurancePolicies,
            success: function (response) {
                var txt = "Insurance has been added successfully";
                if (id != "0")
                    txt = "Insurance has updated successfully";
                showSwal(txt, 'S');
                window.setTimeout(function () {
                    location.reload();
                }, 1600);
            },
            failure: function (response) {
                showSwal(errorTxt, 'E');
            }
        });
        return false;
    });

}
function setViewInsuranceValues(insuranceId, policyNumber, policyName, coverageAmount, startDate, endDate, premium, description, insuranceCompany, contactPerson, contactNumber, contactEmail) {

    $("#mdlViewInsurance").modal("show");

    $('#txtPolicyNumber_view').text(policyNumber);
    $('#txtPolicyName_view').text(policyName);
    $('#txtPolicyCoverageAmount_view').text(coverageAmount);
    $('#txtPolicyPremiumAmount_view').text(premium);
    $('#txtInsuranceCompany_view').text(insuranceCompany);
    $('#txtPolicyStartDate_view').text(getDate(startDate, "YYYYMMDD"));
    $('#txtPolicyEndDate_view').text(getDate(endDate, "YYYYMMDD"));

    $('#txtPolicyDescription_view').text(description);
    $('#txtPolicyContactPerson_view').text(contactPerson);
    $('#txtPolicyContactNumber_view').text(contactNumber);
    $('#txtPolicyContactEmail_view').text(contactEmail);

}
function openViewInsuranceModal(insuranceId) {
    var idx = insuranceList.findIndex(i => i.insuranceId == insuranceId);
    var v = insuranceList[idx];
    setViewInsuranceValues(v.insuranceId, v.policyNumber, v.policyName, v.coverageAmount, v.startDate, v.endDate, v.premium, v.description, v.insuranceCompany, v.contactPerson, v.contactNumber, v.contactEmail);
}
function openInsuranceModal(insuranceId) {
    var idx = insuranceList.findIndex(i => i.insuranceId == insuranceId);


    if (idx != -1) {
        var v = insuranceList[idx];
        setInsuranceValues(v.insuranceId, v.policyNumber, v.policyName, v.coverageAmount, v.startDate, v.endDate, v.premium, v.description, v.insuranceCompany, v.contactPerson, v.contactNumber, v.contactEmail);
    } else {
        setInsuranceValues(0, "", "", "", "", "", "", "", "", "", "", "");
    }



}


function callInsurance() {
    $.ajax({
        url: apiUrl + "Asset/getAssetInsurancePolicies?insuranceId=0",
        type: "GET",
        success: function (result) {

            var html = '';
            if (result.length > 0) {
                insuranceList = result;
                $.each(result, function (key, response) {
                    var actionHtml = '<td><a href=\"#\" class=\"btn-sm\" title=\"View\" onclick=\"openViewInsuranceModal(\'' + response.insuranceId + '\')\"> <i class=\"fa fa-eye text-secondary\"></i> </a>';
                    actionHtml = actionHtml + '<a href=\"#\" class=\"btn-sm\" title=\"Edit\" onclick=\"openInsuranceModal(\'' + response.insuranceId + '\')\"> <i class=\"fa fa-edit text-secondary\"></i> </a>';
                    actionHtml = actionHtml + '<a href=\"#\" class=\"btn-sm\"><i class=\"far fa-trash-alt text-red\"></i> </a></td>';
                    html += '<tr style="cursor:pointer;hover:green">';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + response.policyNumber + '</td>';
                    html += '<td>' + response.policyName + '</td>';
                    html += '<td>' + response.coverageAmount + '</td>';
                    html += '<td>' + response.premium + '</td>';
                    html += '<td>' + getDate(response.startDate, "DDMMYYYY") + '</td>';
                    html += '<td>' + getDate(response.endDate, "DDMMYYYY") + '</td>';
                    html += '<td>' + response.insuranceCompany + '</td>';
                    html += actionHtml;
                    html += '</tr>';
                });
                $('.insuranceBody').html(html);
            }
            else {
                loadDataTable("tblInsurance", "No insurance found.");
            }
            $('#divInsurance').show();
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });


}



function loadDataTable(id, message) {
    if ($.fn.DataTable.isDataTable("#" + id)) {       
        $('#' + id).DataTable().clear().destroy();
    }
    $('#' + id).dataTable({
        "language": {
            "emptyTable": message
        }
    });
}



function addClasstoUL() {
    $.fn.extend({
        treed: function (o) {

            var openedClass = 'fa-minus';
            var closedClass = 'fa-plus';

            if (typeof o != 'undefined') {
                if (typeof o.openedClass != 'undefined') {
                    openedClass = o.openedClass;
                }
                if (typeof o.closedClass != 'undefined') {
                    closedClass = o.closedClass;
                }
            };

            //initialize each of the top levels
            var tree = $(this);
            tree.addClass("tree");
            tree.find('li').has("ul").each(function () {
                var branch = $(this); //li with children ul
                branch.prepend("<i class='indicator fa " + closedClass + "'></i>");
                branch.addClass('branch');
                branch.on('click', function (e) {
                    if (this == e.target) {
                        var icon = $(this).children('i:first');
                        icon.toggleClass(openedClass + " " + closedClass);
                        $(this).children().children().toggle();
                    }
                })
                branch.children().children().toggle();
            });
            //fire event from the dynamically added icon
            tree.find('.branch .indicator').each(function () {
                $(this).on('click', function () {
                    $(this).closest('li').click();
                });
            });

            //fire event to open branch if the li contains a button instead of text
            tree.find('.branch>button').each(function () {
                //$(this).on('click', function (e) {
                //
                //    $("#mdlAddSubCategory").modal("show");
                //    categoryId = e.currentTarget.id.split("_")[1];
                //    liCount = e.currentTarget.className.split("_")[1];

                //    e.preventDefault();
                //});
            });
        }
    });

    //Initialization of treeviews

    $('#tree1').treed();

    $('#tree2').treed({
        openedClass: 'glyphicon-folder-open',
        closedClass: 'glyphicon-folder-close'
    });

    $('#tree3').treed({
        openedClass: 'glyphicon-chevron-right',
        closedClass: 'glyphicon-chevron-down'
    });
    if (liCount == 0)
        $("#tree1 > li:nth-child(1) > i").click();
    else
        $("#tree1 > li:nth-child(" + liCount + ") > i").click();
}

/////ADD ASSET///////////////////////
function GetAssetMaintenaceStatus() {
    $.ajax({
        url: apiUrl + "Asset/GetAssetMaintenaceStatus",
        type: "GET",
        success: function (result) {

            persons = [];
            if (result.length > 0) {
                //$("#MainContent_ddlAssetCategories").empty();
                //var $dropdown = $("#MainContent_ddlAssetCategories");
                //$dropdown.append($("<option />").val("").text("--Select--"));
                //$.each(result, function () {
                //    $dropdown.append($("<option />").val(this.categoryId).text(this.categoryName));
                //});
            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            console.log(errormessage.responseText);
        }
    });
}
function getAllUsers() {

    $.ajax({
        url: apiUrl + "Asset/getAllUsers",
        type: "GET",
        success: function (result) {

            persons = [];
            if (result.length > 0) {
                $.each(result, function () {
                    persons.push(this.FirstName + ' ' + this.LastName);
                    userids.push(this.UserId);
                });
                autocomplete(document.getElementById("txtCheckoutPerson"), persons, userids, "txtCheckoutPerson");
                autocomplete(document.getElementById("txtStatusBy"), persons, userids, "txtStatusBy");

            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            console.log(errormessage.responseText);
        }
    });
}
function getAllCategories() {


    $.ajax({
        url: apiUrl + "Asset/getAssetCategories",
        type: "GET",
        success: function (result) {

            if (result.length > 0) {
                $("#MainContent_ddlAssetCategories").empty();
                var $dropdown = $("#MainContent_ddlAssetCategories");
                $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                $.each(result, function () {
                    $dropdown.append($("<option />").val(this.categoryId).text(this.categoryName));
                });
            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            console.log(errormessage.responseText);
        }
    });
}
function getAllAssetTypes() {

    $.ajax({
        url: apiUrl + "Asset/GetAssetTypes",
        type: "GET",
        success: function (result) {

            if (result.length > 0) {
                $("#MainContent_ddlAssetTypes").empty();
                var $dropdown = $("#MainContent_ddlAssetTypes");
                $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                $.each(result, function () {
                    $dropdown.append($("<option />").val(this.assetTypeId).text(this.assetType));
                });
            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            console.log(errormessage.responseText);
        }
    });
}
function getAllAssetInsurancePolicies(insuranceId) {

    $.ajax({
        url: apiUrl + "Asset/getAssetInsurancePolicies?insuranceId=" + insuranceId,
        type: "GET",
        success: function (result) {

            if (result.length > 0) {
                $("#MainContent_ddlAssetInsurance").empty();
                var $dropdown = $("#MainContent_ddlAssetInsurance");
                $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                $.each(result, function () {
                    $dropdown.append($("<option />").val(this.insuranceId).text(this.policyName));
                });
            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}
function getAllAssetPurchasedTypes() {

    $.ajax({
        url: apiUrl + "Asset/getAllPurchasedTypes",
        type: "GET",
        success: function (result) {

            if (result.length > 0) {
                $("#MainContent_ddlPurchasedType").empty();
                var $dropdown = $("#MainContent_ddlPurchasedType");
                $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                $.each(result, function () {
                    $dropdown.append($("<option />").val(this.PurchasedId).text(this.PurchasedType));
                });
            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}
function getAllAssetDepreciation() {

    $.ajax({
        url: apiUrl + "Asset/getAssetDepreciations",
        type: "GET",
        success: function (result) {

            if (result.length > 0) {
                $("#MainContent_ddlAssetDepreciation").empty();
                var $dropdown = $("#MainContent_ddlAssetDepreciation");
                $dropdown.append($("<option />").val("").text("--Select--"));
                $.each(result, function () {
                    $dropdown.append($("<option />").val(this.depMethodId).text(this.depName));
                });
            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}

function getAllSites() {

    $.ajax({
        url: apiUrl + "Asset/getAllSites",
        type: "GET",
        success: function (result) {

            if (result.length > 0) {
                $("#MainContent_ddlAssetSites").empty();
                var $dropdown = $("#MainContent_ddlAssetSites");
                $dropdown.append($("<option disabled selected/>").val("").text("--Select--"));
                $.each(result, function () {
                    $dropdown.append($("<option />").val(this.SiteId).text(this.SiteName));
                });
                $('#MainContent_ddlAssetSites').val("Malasiya");

            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}

function autocomplete(inp, arr, arrids, elementName) {
    // inp = document.getElementById(elementName);
    /*the autocomplete function takes two arguments,
    the text field element and an array of possible autocompleted values:*/
    var currentFocus;
    /*execute a function when someone writes in the text field:*/
    inp.addEventListener("input", function (e) {
        var a, b, i, val = this.value;
        /*close any already open lists of autocompleted values*/
        closeAllLists();
        if (!val) { return false; }
        currentFocus = -1;
        /*create a DIV element that will contain the items (values):*/
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        a.setAttribute("style", "width: 90%;margin-left: 5%;");
        /*append the DIV element as a child of the autocomplete container:*/
        this.parentNode.appendChild(a);
        /*for each item in the array...*/
        for (i = 0; i < arr.length; i++) {
            /*check if the item starts with the same letters as the text field value:*/
            if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
                /*create a DIV element for each matching element:*/
                b = document.createElement("DIV");
                /*make the matching letters bold:*/
                b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
                b.innerHTML += arr[i].substr(val.length);
                /*insert a input field that will hold the current array item's value:*/
                b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                b.innerHTML += "<input type='hidden' value='" + arrids[i] + "'>";
                /*execute a function when someone clicks on the item value (DIV element):*/
                b.addEventListener("click", function (e) {

                    /*insert the value for the autocomplete text field:*/
                    inp.value = this.getElementsByTagName("input")[0].value;
                    checkoutuserid = this.getElementsByTagName("input")[1].value;
                    //alert(checkoutuserid);
                    /*close the list of autocompleted values,
                    (or any other open lists of autocompleted values:*/
                    closeAllLists();
                });
                a.appendChild(b);
            }
        }
    });
    /*execute a function presses a key on the keyboard:*/
    inp.addEventListener("keydown", function (e) {
        var x = document.getElementById(this.id + "autocomplete-list");
        if (x) x = x.getElementsByTagName("div");
        if (e.keyCode == 40) {
            /*If the arrow DOWN key is pressed,
            increase the currentFocus variable:*/
            currentFocus++;
            /*and and make the current item more visible:*/
            addActive(x);
        } else if (e.keyCode == 38) { //up
            /*If the arrow UP key is pressed,
            decrease the currentFocus variable:*/
            currentFocus--;
            /*and and make the current item more visible:*/
            addActive(x);
        } else if (e.keyCode == 13) {
            /*If the ENTER key is pressed, prevent the form from being submitted,*/
            e.preventDefault();
            if (currentFocus > -1) {
                /*and simulate a click on the "active" item:*/
                if (x) x[currentFocus].click();
            }
        }
    });
    function addActive(x) {
        /*a function to classify an item as "active":*/
        if (!x) return false;
        /*start by removing the "active" class on all items:*/
        removeActive(x);
        if (currentFocus >= x.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = (x.length - 1);
        /*add class "autocomplete-active":*/
        x[currentFocus].classList.add("autocomplete-active");
    }
    function removeActive(x) {
        /*a function to remove the "active" class from all autocomplete items:*/
        for (var i = 0; i < x.length; i++) {
            x[i].classList.remove("autocomplete-active");
        }
    }
    function closeAllLists(elmnt) {
        /*close all autocomplete lists in the document,
        except the one passed as an argument:*/
        var x = document.getElementsByClassName("autocomplete-items");
        for (var i = 0; i < x.length; i++) {
            if (elmnt != x[i] && elmnt != inp) {
                x[i].parentNode.removeChild(x[i]);
            }
        }
    }
    /*execute a function when someone clicks in the document:*/
    document.addEventListener("click", function (e) {
        closeAllLists(e.target);
    });
}

function changeAssetStatus() {

    if (sessionStorage.getItem("assetChangeStatus") == "Check Out") {
        assetCheckout();
    }
    else if (sessionStorage.getItem("assetChangeStatus") == "Check In") {
        assetCheckin();
    }

}

function assetCheckout() {

    var obj = new Object();
    obj.UniqueIds = sessionStorage.getItem("changestatus_uniqueids");
    obj.AssetIds = sessionStorage.getItem("changestatus_assetids");
    obj.StatusId = 2;
    obj.PersonOrSite = personOrSite;
    obj.PersonId = checkoutuserid;
    obj.Personname = ($('#txtCheckoutPerson').val() == null) ? " " : $('#txtCheckoutPerson').val();
    obj.CheckoutDate = $('#txtDate').val();
    obj.CheckinDate = "01/01/1900";
    obj.DueDate = $('#txtDueDate').val();
    obj.CheckoutRemarks = $('#txtRemarks').val();
    obj.CheckinRemarks = " ";
    obj.SiteId = ($('#MainContent_ddlAssetSites').val() == null || $('#MainContent_ddlAssetSites').val() == "") ? 0 : $('#MainContent_ddlAssetSites').val();
    obj.LocationId = ($('#MainContent_ddlAssetLocations').val() == null || $('#MainContent_ddlAssetLocations').val() == "") ? 0 : $('#MainContent_ddlAssetLocations').val();
    obj.DepartmentId = ($('#MainContent_ddlAssetDepartments').val() == null || $('#MainContent_ddlAssetDepartments').val() == "") ? 0 : $('#MainContent_ddlAssetDepartments').val();
    $.ajax({
        url: apiUrl + "Asset/insertCheckoutAndCheckinStatus",
        type: 'POST',
        dataType: 'json',
        data: obj,
        success: function (response) {

            location.reload();
        },
        failure: function (response) {
            console.lo(response.responseText);
        }
    });

}

function assetCheckin() {

    var obj = new Object();
    obj.UniqueIds = sessionStorage.getItem("changestatus_uniqueids");
    obj.AssetIds = sessionStorage.getItem("changestatus_assetids");
    obj.StatusId = 3;
    obj.PersonOrSite = personOrSite;
    obj.PersonId = checkoutuserid;
    obj.Personname = ($('#txtCheckoutPerson').val() == null) ? "" : $('#txtCheckoutPerson').val();
    obj.CheckoutDate = "01/01/1900";
    obj.CheckinDate = $('#txtDate').val();
    obj.DueDate = "01/01/1900";
    obj.CheckoutRemarks = "";
    obj.CheckinRemarks = $('#txtRemarks').val();
    obj.SiteId = $('#txtRemarks').val();
    obj.LocationId = $('#txtRemarks').val();
    obj.DepartmentId = $('#txtRemarks').val();
    $.ajax({
        url: apiUrl + "Asset/insertCheckoutAndCheckinStatus",
        type: 'POST',
        dataType: 'json',
        data: obj,
        success: function (response) {

            var x = response;
            location.reload();
        },
        failure: function (response) {
            console.lo(response.responseText);
        }
    });

}
var isInHouseMaintenance = 1;
function showMaintenanceBy(val) {
    isInHouseMaintenance = val;
    $('#divDDLMaintenanceBy').hide();
    $('#divMaintenanceBy').hide();
    if (val == 1)
        $('#divMaintenanceBy').show();
    else
        $('#divDDLMaintenanceBy').show();
}
var isRepeated = 1;
function setRepeated(repVal) {
    isRepeated = repVal;
    if (repVal == 1) {
        $('#maintenanceFrequencySelectBox').slideDown(300);
    }
    else {
        SetFrequency(1);
        $('#maintenanceFrequencySelectBox').slideUp(300);
    }
}

var Frequency = "Daily";
var NumberOfWeeksReocurOn = 0;
var DayOfWeeksReocurOn = 0;
var NumberOfMonthsReocurOn = 0;
var DateOfMonthReocurOn = 0;
var MonthOfYearReocurOn = 0;
var DateOfMonthOfYearReocurOn = 0;
function SetFrequency(freq) {
    NumberOfWeeksReocurOn = 0;
    DayOfWeeksReocurOn = 0;
    NumberOfMonthsReocurOn = 0;
    DateOfMonthReocurOn = 0;
    MonthOfYearReocurOn = 0;
    DateOfMonthOfYearReocurOn = 0;

    $('#FormWeekly').hide();
    $('#FormMonthly').hide();
    $('#FormYearly').hide();   
    if (freq == 2)
    {      
        Frequency = "Weekly";
        $('#FormWeekly').show();
    }   
    else if (freq == 3)
    {       
        Frequency = "Monthly";
        $('#FormMonthly').show();
    }    
    else if (freq == 4)
    {      
        Frequency = "Yearly";
        $('#FormYearly').show();
    }
}
function setFrequencyValue() {
    NumberOfWeeksReocurOn = $('#WeeklyRecurOn1').val();
    DayOfWeeksReocurOn = $('#WeeklyRecurOn2').val();
    NumberOfMonthsReocurOn = $('#MonthlyRecurOn1').val();
    DateOfMonthReocurOn = $('#MonthlyRecurOn2').val();
    MonthOfYearReocurOn = $('#YearlyRecurOn1').val();
    DateOfMonthOfYearReocurOn = $('#YearlyRecurOn2').val();
}

function saveAssetMaintenance() {
    if ($('#txtTitle').val() != "")
    {
    setFrequencyValue();
    var obj = new Object();
    //obj.MaintenanceIds = sessionStorage.getItem("changestatus_uniqueids");
    obj.AssetIds = sessionStorage.getItem("changestatus_assetids");
    obj.StatusId = 4;
    obj.MaintenanceDate = "01/01/1900";
    obj.Title = $('#txtTitle').val();
    obj.Details = $('#txtDetails').val();
    obj.Cost = ($('#txtCost').val() == "") ? 0 : $('#txtCost').val();
    obj.DueDate = ($('#txtMaintenanceDueDate').val() == "") ? "01/01/1900" : $('#txtMaintenanceDueDate').val();
    obj.CompletedDate = ($('#txtDateCompleted').val() == "") ? "01/01/1900" : $('#txtDateCompleted').val();
    obj.MaintenanceById = (isInHouseMaintenance == 0) ? $('#MainContent_ddlVendor').val() : 0;
    obj.MaintenanceBy = (isInHouseMaintenance == 0) ? $("#MainContent_ddlVendor option:selected").text() : $('#txtMaintenanceBy').val();
    obj.isInHouseMaintenance = isInHouseMaintenance;
    obj.isRepeated = isRepeated;
    obj.CreatedBy = 1;    
    obj.MaintenanceFrequency = Frequency;
    obj.NumberOfWeeksReocurOn = NumberOfWeeksReocurOn;
    obj.DayOfWeeksReocurOn = DayOfWeeksReocurOn;
    obj.NumberOfMonthsReocurOn = NumberOfMonthsReocurOn;
    obj.DateOfMonthReocurOn = DateOfMonthReocurOn;
    obj.MonthOfYearReocurOn = MonthOfYearReocurOn;
    obj.DateOfMonthOfYearReocurOn = DateOfMonthOfYearReocurOn;
    obj.MaintenanceStatus = $('#ddlStatus').val();
    console.log(obj);
    $.ajax({
        url: apiUrl + "Asset/insertAssetMaintenanceMaster",
        type: 'POST',
        dataType: 'json',
        data: obj,
        success: function (response) {

            var x = response;
            location.reload();
        },
        failure: function (response) {
            console.lo(response.responseText);
        }
    });
}
else{
        $('#errTitle').show();
        return false;
}
}
function saveAssetOtherStatus() {
    var obj = new Object();
    obj.UniqueIds = sessionStorage.getItem("changestatus_uniqueids");
    obj.AssetIds = sessionStorage.getItem("changestatus_assetids");
    obj.StatusId = parseInt(sessionStorage.getItem("ChangeStatusId"));
    obj.Details = $('#txtOtherStatusDetails').val();
    obj.StatusDate = ($('#txtStatusDate').val() == "") ? "01/01/1900" : $('#txtStatusDate').val();
    obj.UserId = checkoutuserid;
    obj.CreatedBy = 1;
    $.ajax({
        url: apiUrl + "Asset/InsertAssetOtherStatusChange",
        type: 'POST',
        dataType: 'json',
        data: obj,
        success: function (response) {

            var x = response;
            location.reload();
        },
        failure: function (response) {
            console.lo(response.responseText);
        }
    });
}
function saveAssetGlobalFiedls() {

    var fields = new Array();
    var count = $('#tblAssetGlobalFields tr:last').attr('id').replace(/tablerow_/, '');
    for (var idx = 0; idx < count; idx++) {
        if ($('#txtFieldName_' + (idx + 1).toString()).val() != "") {
            var obj = {
                "UniqueId": 0,
                "CategoryId": $('#MainContent_ddlAssetCategories').val(),
                "SubCategoryId": $('#MainContent_ddlSubCategories').val(),
                "FieldName": $('#txtFieldName_' + (idx + 1).toString()).val()
            };
            fields.push(obj);
        }
    }
    $.ajax({
        url: apiUrl + "Asset/InsertAssetGlobalFields",
        type: 'POST',
        data: JSON.stringify(fields),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {

            var x = response;
            location.reload();
        },
        failure: function (response) {
            console.lo(response.responseText);
        }
    });
}
function filterAssets() {
    getAllAssetsForCheckin(sessionStorage.getItem("personorid"));
}


var assetChangeStatus='';
function getAssetsForCheckin(personorid) {
    assetChangeStatus = "Check In";
    $('#btnChangeStatus').html("Check In");
    sessionStorage.setItem("personorid", personorid);
    var obj = new Object;
    obj.CategoryId = ($('#MainContent_ddlAssetCategories').val() == "") ? 0 : $('#MainContent_ddlAssetCategories').val();
    obj.SubCategoryId = ($('#MainContent_ddlSubCategories').val() == "") ? 0 : $('#MainContent_ddlSubCategories').val();
    obj.SiteId = ($('#MainContent_ddlAssetSites').val() == "") ? 0 : $('#MainContent_ddlAssetSites').val();
    obj.LocationId = ($('#MainContent_ddlAssetLocations').val() == "") ? 0 : $('#MainContent_ddlAssetLocations').val();
    obj.DepartmentId = ($('#MainContent_ddlAssetDepartments').val() == "") ? 0 : $('#MainContent_ddlAssetDepartments').val();
    obj.VendorId = 0;
    obj.PurchasedTypeId = 0;
    obj.PersonId = 0;
    obj.Personname = "";
    var html = '';
    var filteredAssets = [];
    $.ajax({
        url: apiUrl + "Asset/getAllAssetsForCheckin",
        type: "POST",
        dataType: 'json',
        data: obj,
        success: function (result) {
            if (result.length > 0) {
                sessionStorage.setItem("checkinAssets", JSON.stringify(result))
                //Clear the Data Table for new fetch
                if ($.fn.DataTable.isDataTable("#tblCheckinAssets")) {
                    $('#tblCheckinAssets').DataTable().clear().destroy();
                }
                sessionStorage.setItem("AssetsForInventory", JSON.stringify(result));
                $.each(result, function (key, asset) {
                    html += '<tr style="cursor:pointer;hover:green" id=tr_' + asset.AssetId + ' onclick="assetView(' + asset.AssetId + ')">';
                    html += '<td onclick=event.stopPropagation()><input type="checkbox" name="chk_Checkin_' + asset.AssetId + '" id="chk_Checkin_' + asset.AssetId + '" onclick="getCheckinAssetIds(' + asset.AssetId + ',' + asset.UniqueId + ')" /></td>';
                    html += '<td>' + (parseInt(key) + 1) + '</td>';
                    html += '<td>' + asset.AssetTagId + '</td>';
                    html += '<td>' + asset.AssetName + '</td>';
                    html += '<td>' + ((asset.PersonOrSite == 1) ? "Person" : "Site/Location") + '</td>';
                    html += '<td>' + ((asset.Personname == "") ? "--" : asset.Personname) + '</td>';
                    html += '<td>' + ((asset.SiteName == "") ? "--" : asset.SiteName) + '</td>';
                    html += '<td>' + ((asset.LocationName == "") ? "--" : asset.LocationName) + '</td>';
                    html += '<td>' + ((asset.DepartmentName == "") ? "--" : asset.DepartmentName) + '</td>';
                    html += '<td>' + asset.CheckoutDate + '</td>';
                    html += '<td>' + asset.DueDate + '</td>';
                    //  html += '<td>' + asset.CheckoutRemarks + '</td>';
                    html += '</tr>';
                });
                $('.checkinAssetBody').html(html);
                //Make it as a Data Table
                $('#tblCheckinAssets').DataTable({
                });
                $('#tblCheckinAssets').css("display", "block");
                //$('#tblCheckinAssets').show();


            }

        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });

}
function assetView(assetid) {
    window.location.href = "view-ind-asset.aspx?assetId=" + assetid;
}




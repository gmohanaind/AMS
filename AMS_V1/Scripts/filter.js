var apiUrl = "http://localhost:57080/api/";


function selectAllAssets(obj) {
    // alert(obj.checked);
    if (obj.checked) {
        $('input[type="checkbox"]').prop('checked', 'checked')
    } else {
        $('input[type="checkbox"]').prop('checked', 'false')
    }
}


function setOptions(id, results, val) {
    var options = $('#' + id);
    options.empty();
    options.append(
            $('<option disabled></option>').val(-1).html("Select")
        );
    $.each(results, function (key, object) {
        var name = val + "Name";
        if (val == "Purchased")
            name = "PurchasedType";
        else if (val == "insurance")
            name = "policyName";
        options.append(
            $('<option></option>').val(object[val + "Id"]).html(object[name])
        );
    });
}

function getCategories() {
    $.ajax({
        url: apiUrl + "Asset/getAssetCategories",
        type: "GET",
        success: function (result) {
            if (result.length > 0) {
                setOptions("MainContent_ddlAssetCategories", result, "category");
            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            console.log(errormessage.responseText);
        }
    });
}

function getSubCategories() {
    $.ajax({
        url: apiUrl + "Asset/getAssetSubCategories?categoryId=0",
        type: "GET",
        success: function (result) {
            if (result.length > 0) {
                setOptions("MainContent_ddlSubCategories", result, "subCategory");
            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}

function getSites() {
    $.ajax({
        url: apiUrl + "Asset/getAllSites",
        type: "GET",
        success: function (result) {
            if (result.length > 0) {
                setOptions("MainContent_ddlAssetSites", result, "Site");
            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}

function getLocations() {
    $.ajax({
        url: apiUrl + "Asset/getAllLocations?SiteId=0",
        type: "GET",
        success: function (results) {
            var html = '';
            if (results.length > 0) {
                setOptions("MainContent_ddlLocations", results, "Location");
            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });
}

function getDepartments() {
    $.ajax({
        url: apiUrl + "Asset/getAssetDepartments?locationId=0",
        type: "GET",
        success: function (result) {
            if (result.length > 0) {
                setOptions("MainContent_ddlDepartments", result, "dept");
            }
        },
        error: function (errormessage) {
            alert(errormessage.responseText);
        }
    });
}

function getAllVendors() {
    $.ajax({
        url: apiUrl + "Asset/getVendors?vendorId=0",
        type: "GET",
        success: function (result) {
            if (result.length > 0) {
                setOptions("MainContent_ddlVendor", result, "vendor");
            }
        },
        error: function (errormessage) {
            $('#divLoader').hide();
            alert(errormessage.responseText);
        }
    });
}

function getPurchasedTypes() {
    $.ajax({
        url: apiUrl + "Asset/getAllPurchasedTypes",
        type: "GET",
        success: function (result) {
            if (result.length > 0) {
                setOptions("MainContent_ddlPurchasedType", result, "Purchased");
            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}

function getInsurancePolicies() {
    $.ajax({
        url: apiUrl + "Asset/getAssetInsurancePolicies?insuranceId=0",
        type: "GET",
        success: function (result) {
            if (result.length > 0) {
                setOptions("MainContent_ddlAssetInsurance", result, "insurance");
            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}
function getAssetStatus() {
    $.ajax({
        url: apiUrl + "Asset/GetAssetStatus",
        type: "GET",
        success: function (result) {
            if (result.length > 0) {
                setOptions("MainContent_ddlAssetStatus", result, "status");
            }
        },
        error: function (errormessage) {
            console.log(errormessage.responseText);
        }
    });
}
function resetFilterForm() {
    document.getElementById("frmFilter").reset();
    getAllAssetsForCheckin(sessionStorage.getItem("personorid"));
}
function getAllAssetsForCheckin(personorid) {
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
    if (personorid == 1) {
        if ($.fn.DataTable.isDataTable("#tblCheckinAssetsPerson")) {
            $('#tblCheckinAssetsPerson').DataTable().clear().destroy();
        }
    }
    else {
        if ($.fn.DataTable.isDataTable("#tblCheckinAssetsSite")) {
            $('#tblCheckinAssetsSite').DataTable().clear().destroy();
        }
    }
   

    $.ajax({
        url: apiUrl + "Asset/getAllAssetsForCheckin",
        type: "POST",
        dataType: 'json',
        data: obj,
        success: function (result) {
            if (result.length > 0) {
                sessionStorage.setItem("AssetsForInventory", JSON.stringify(result));
                if (personorid == 1) {
                    filteredAssets = result.filter(function (obj) {
                        return obj.PersonOrSite === 1;
                    });
                  
                }
                else {
                    filteredAssets = result.filter(function (obj) {
                        return obj.PersonOrSite === 2;
                    });
                }

                if (personorid == 1) {
                    $.each(filteredAssets, function (key, asset) {
                        html += '<tr style="cursor:pointer;hover:green" id=tr_' + asset.AssetId + ' onclick="assetView(' + asset.AssetId + ')">';
                        html += '<td>' + (parseInt(key) + 1) + '</td>';
                        html += '<td>' + asset.AssetTagId + '</td>';
                        html += '<td>' + asset.AssetName + '</td>';
                        html += '<td>' + asset.Personname + '</td>';
                        html += '<td>' + asset.CheckoutDate + '</td>';
                        html += '<td>' + asset.DueDate + '</td>';
                        html += '</tr>';
                    });
                    $('.bodyCheckinAssetsPerson').html(html);
                    //Make it as a Data Table
                    $('#tblCheckinAssetsPerson').DataTable({
                    });
                   
                    $('#tblCheckinAssetsPerson').show();
                }
                else {
                    $.each(filteredAssets, function (key, asset) {
                        html += '<tr style="cursor:pointer;hover:green" id=tr_' + asset.AssetId + ' onclick="assetView(' + asset.AssetId + ')">';
                        html += '<td>' + (parseInt(key) + 1) + '</td>';
                        html += '<td>' + asset.AssetTagId + '</td>';
                        html += '<td>' + asset.AssetName + '</td>';
                        html += '<td>' + ((asset.SiteName == "") ? "--" : asset.SiteName) + '</td>';
                        html += '<td>' + ((asset.LocationName == "") ? "--" : asset.LocationName) + '</td>';
                        html += '<td>' + ((asset.DepartmentName == "") ? "--" : asset.DepartmentName) + '</td>';
                        html += '<td>' + asset.CheckoutDate + '</td>';
                        html += '<td>' + asset.DueDate + '</td>';
                        html += '</tr>';
                    });
                    $('.bodyCheckinAssetsSite').html(html);
                    //Make it as a Data Table
                    $('#tblCheckinAssetsSite').DataTable({
                    });
                    $('#tblCheckinAssetsSite').show();
                }

            }
            else {
                if (personorid == 1) {
                    loadDataTable("tblCheckinAssetsPerson", "No records found.");
                }
                else {
                    loadDataTable("tblCheckinAssetsSite", "No records found.");
                }
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
function saveAssetForInventoryCheck() {

}
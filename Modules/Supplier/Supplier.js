function ResetFields() {
    $('#txtCusName').val("");
    $('#txtBusinessId').val("");
    $('#txtPhoneNo').val("");
    $('#txtAddress').val("");
    $('#txtTripRate').val("");
    $('#txtRemarks').val("");
}
$(document).ready(function () {
    $('#txtOpeningBalance').attr('disabled', false);
});
function Edit(CustomerId) {

    $.ajax({
        url: 'Supplier.ashx',
        type: "POST",
        data: { 'fun': 'Edit', 'CustomerId': CustomerId },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    var CustomerData = JSON.parse(data)
                    $.each(CustomerData, function (i, obj) {
                        $('#hdnCustomerId').val(obj.Id);
                        $("#txtCusName").val(obj.Name);
                        $("#txtBusinessId").val(obj.Business_Id);
                        $('#txtPhoneNo').val(obj.Phone_no);
                        $('#txtAddress').val(obj.Address);
                        $('#txtRemarks').val(obj.Remarks);
                        $('#txtOpeningBalance').val(obj.OpeningBalance);
                        $('#txtTripRate').val(obj.TripRate);
                        if ($('#txtOpeningBalance').val() > 1) {
                            $('#txtOpeningBalance').attr('disabled', true);
                        }
                        $('#btnSave').html("Update");
                    });
                }
            }
        }
    });
}
function Save_Supplier() {

    var InsertArray = $('#txtCusName').val() + "|" + $('#txtBusinessId').val() + "|" + $('#txtPhoneNo').val() + "|" + $('#txtAddress').val() + "|" + $('#txtRemarks').val() + "|" + $('#txtTripRate').val() + "|" + $('#txtOpeningBalance').val();
    var Controls = "txtCusName,txtBusinessId,txtPhoneNo,txtAddress,txtTripRate,txtRemarks";

    if (setBorderColor_Validation(Controls)) {
        var caption = $('#btnSave').html();
        if (caption == "Save") {
            $.ajax({
                url: 'Supplier.ashx',
                type: "POST",
                data: {
                    'fun': 'Save_Supplier', 'InsertArray': InsertArray
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#Popup').modal('toggle');
                            calltoast("Data Saved Sucessfully", "success");
                            ListAllSupplier();
                        }
                        else {
                            calltoast("Something went wrong", "error");
                        }

                    }
                }
            });
            ListAllSupplier();
        }
        else if (caption == "Update") {

            $.ajax({
                url: 'Supplier.ashx',
                type: "POST",
                data: {
                    'fun': 'Update_Supplier', 'InsertArray': InsertArray, 'CustomerId': $('#hdnCustomerId').val()
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#Popup').modal('toggle');
                            calltoast("Updated Saved Sucessfully", "success");
                        }
                    }
                }
            });
            ListAllSupplier();
        }
    }
    else {
        calltoast("Please fill the mandatory infromaton.", "error");
    }
}

function ListAllSupplier() {

    // var SourceType = $('#DdlListDiv').val()
    // var Status = $('#DdlListStatus').val()
    var SearchString = $('#txtSearch').val()
    var Page_No = $('#hdn_PageNo').val()

    $.ajax({
        url: 'Supplier.ashx',
        type: "POST",
        data: {
            'fun': 'ListAllSupplier', 'SearchString': SearchString, 'Page_No': Page_No
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                if (data != "") {

                    SetInnerVal("Supplier_list_Body", data.split("|")[0])
                    SetInnerVal("Div_Paging", data.split("|")[1])
                }
            }
        }
    });
}


function calltoast(msg, msgtype) {
    $.toast({
        heading: '',
        text: msg,
        position: 'top-right',
        loaderBg: '#ff6849',
        icon: msgtype,
        hideAfter: 3000,
        stack: 6
    });
}


function Searchtxt() {
    SetVal("hid_page", 0);
    ListAllSupplier();
}


function pageNo(pno) {
    SetVal("hid_page", pno);
    ListAllSupplier();
}




function ResetFields() {
    $('#txtCusName').val("");
    $('#txtBusinessId').val("");
    $('#txtPhoneNo').val("");
    $('#txtAddress').val("");
    $('#txtTripRate').val("");
    $('#txtRemarks').val("");
}

function GetBusinessInfo() {

    $.ajax({
        url: 'BusinessInfo.ashx',
        type: "POST",
        data: {
            'fun': 'GetBusinessInfo'
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    var CustomerData = JSON.parse(data)
                    $.each(CustomerData, function (i, obj) {

                        $("#txtBusinesName").val(obj.BizName);
                        $("#txtBusinessAddress").val(obj.BizAddress);
                        $('#txtBusinessPhone').val(obj.Mobile);
                        $('#txtBusinessEmail').val(obj.Email);
                        $('#txtBusinessWebsite').val(obj.Website);
                        $('#TxtBusinessTagline').val(obj.Tagline);
                        $('#txtBusinessGSTIN').val(obj.GSTIN);
                        $('#txtBusinessCGST').val(obj.CGST);
                        $('#txtBusinessSGST').val(obj.SGST);
                        $('#txtBusinessIGST').val(obj.IGST);
                        $('#txtBankName').val(obj.BankName);
                        $('#txtBankAccountNo').val(obj.AccountNo);
                        $('#txtBranchName').val(obj.Branch);
                        $('#txtIfsc').val(obj.IFSC);

                    });
                }
            }
        }
    });
}
function Save_BusinessInfo() {

    var InsertArray = $('#txtBusinesName').val() + "|" + $('#txtBusinessAddress').val() + "|" + $('#txtBusinessPhone').val() + "|" + $('#txtBusinessEmail').val() +
        "|" + $('#txtBusinessWebsite').val() + "|" + $('#TxtBusinessTagline').val() +
        "|" + $('#txtBusinessGSTIN').val() + "|" + $('#txtBusinessCGST').val() + "|" + $('#txtBusinessSGST').val() + "|" + $('#txtBusinessIGST').val() + "|" + $('#txtBankAccountNo').val() +
        "|" + $('#txtBankName').val() + "|" + $('#txtBranchName').val() + "|" + $('#txtIfsc').val();
    var Controls = "txtBusinesName,txtBusinessAddress,txtBusinessPhone,txtBusinessEmail,txtBusinessWebsite,TxtBusinessTagline,txtBusinessGSTIN,txtBusinessCGST,txtBusinessSGST,txtBusinessIGST,txtBankAccountNo,txtBankName,txtBranchName,txtIfsc";

    if (setBorderColor_Validation(Controls)) {
        var caption = $('#btnSave').html();
        if (caption == "Save") {
            $.ajax({
                url: 'BusinessInfo.ashx',
                type: "POST",
                data: {
                    'fun': 'Save_BusinessInfo', 'InsertArray': InsertArray
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#Popup').modal('toggle');
                            calltoast("Data Saved Sucessfully", "success");
                            GetBusinessInfo();
                        }
                        else {
                            calltoast("Something went wrong", "error");
                        }

                    }
                }
            });
            GetBusinessInfo();
        }
    }
    else {
        calltoast("Please fill the mandatory infromaton.", "error");
    }
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






function ResetFields() {
    $('#txtCusName').val("");
    $('#txtBusinessId').val("");
    $('#txtPhoneNo').val("");
    $('#txtAddress').val("") +
   $('#txtRemarks').val("");
}

function Save_Customer() {

    var InsertArray = $('#txtCusName').val() + "|" + $('#txtBusinessId').val() + "|" + $('#txtPhoneNo').val() + "|" + $('#txtAddress').val() +
        "|" + $('#txtRemarks').val();
    var Controls = "txtCusName,DdlSourseName,txtBusinessId,txtPhoneNo,txtAddress";

    if (setBorderColor_Validation(Controls)) {
        var caption = $('#btnSave').html();
        if (caption == "Save") {
            $.ajax({
                url: 'Customer.ashx',
                type: "POST",
                data: {
                    'fun': 'Save_Customer', 'InsertArray': InsertArray
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#Popup').modal('toggle');
                            calltoast("Data Saved Sucessfully", "success");
                        }
                        else {
                            calltoast("Something went wrong", "error");
                        }
                        
                    }
                }
            });
        }
        else if (caption == "Update") {

            $.ajax({
                url: 'Customer.ashx',
                type: "POST",
                data: {
                    'fun': 'Update_Budget', 'InsertArray': InsertArray, 'Budget_Id': $('#hdn_Budget_Id').val()
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
        }
    }
    else {
        calltoast("Please fill the mandatory infromaton.", "error");
    }
}

function ListAllBudget() {

   // var SourceType = $('#DdlListDiv').val()
   // var Status = $('#DdlListStatus').val()
    var SearchString = $('#txtSearch').val()
    var Page_No = $('#hdn_PageNo').val()

    $.ajax({
        url: 'Customer.ashx',
        type: "POST",
        data: {
            'fun': 'ListAllCustomer', 'SearchString': SearchString,'Page_No': Page_No },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                if (data != "") {

                    SetInnerVal("tblbdyListallBudgets", data.split("|")[0])
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


function pageNo(pno) {
    SetVal("hid_page", pno);
   
}




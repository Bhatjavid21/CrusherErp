function ResetFields() {
    $('#txtCusName').val("");
    $('#txtBusinessId').val("");
    $('#txtPhoneNo').val("");
    $('#txtAddress').val("") +
   $('#txtRemarks').val("");
}

function Save_Product() {

    var InsertArray = $('#txtProName').val() + "|" + $('#txtqty').val() + "|" + $('#txtRate').val() + "|" + $('#txtDescrp').val();
        
    var Controls = "txtProName,txtqty,txtRate";

    if (setBorderColor_Validation(Controls)) {
        var caption = $('#btnSave').html();
        if (caption == "Save") {
            $.ajax({
                url: 'Product.ashx',
                type: "POST",
                data: {
                    'fun': 'Save_Product', 'InsertArray': InsertArray
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#Popup').modal('toggle');
                            calltoast("Data Saved Sucessfully", "success");
                            ListAllProduct();
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
                url: 'Product.ashx',
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

function ListAllProduct() {

   // var SourceType = $('#DdlListDiv').val()
   // var Status = $('#DdlListStatus').val()
    var SearchString = $('#txtSearch').val()
    var Page_No = $('#hdn_PageNo').val()

    $.ajax({
        url: 'Product.ashx',
        type: "POST",
        data: {
            'fun': 'ListAllProduct', 'SearchString': SearchString,'Page_No': Page_No },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                if (data != "") {

                    SetInnerVal("Product_list_Body", data.split("|")[0])
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
    ListAllProduct();
}


function pageNo(pno) {
    SetVal("hid_page", pno);
    ListAllProduct();
}




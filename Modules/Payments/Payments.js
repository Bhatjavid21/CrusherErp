function bindddls(IsEdit, Customer_Id, Product_Id) {
    $.ajax({
        url: 'Payments.ashx',
        type: "POST",
        data: { 'fun': 'bindddls' },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    var CustomerData = JSON.parse(data.split("|")[0]);
                    var SupplierData = JSON.parse(data.split("|")[1]);
                    //$('#SalesMaxNum').val(data.split("|")[2])

                    //================Bind Customer===============

                    $('#ddlcustomer').empty();
                    $('#ddlcustomer').append($('<option>').text('Select Customer').attr('value', 0));

                    $('#ddlListcustomer').empty();
                    $('#ddlListcustomer').append($('<option>').text('Select Customer').attr('value', 0));
                    $.each(CustomerData, function (i, obj) {
                        $('#ddlcustomer').append($('<option>').text(obj.Name.split(',').join(' ')).attr('value', obj.Id));
                        $('#ddlListcustomer').append($('<option>').text(obj.Name.split(',').join(' ')).attr('value', obj.Id));
                    });

                    $('#ddlListsupplier').empty();
                    $('#ddlListsupplier').append($('<option>').text('Select').attr('value', 0));
                    $('#ddlSupplier').empty();
                    $('#ddlSupplier').append($('<option>').text('Select').attr('value', 0));
                    $.each(SupplierData, function (i, obj) {
                        $('#ddlSupplier').append($('<option>').text(obj.Name.split(',').join(' ')).attr('value', obj.Id));
                        $('#ddlListsupplier').append($('<option>').text(obj.Name.split(',').join(' ')).attr('value', obj.Id));
                    });

                    if (IsEdit == true) {
                        $('#ddlcustomer').val(Customer_Id)
                        $('#ddlSupplier').val(Product_Id)
                    }
                    else {
                        $('#ddlcustomer').val(0)
                        $('#ddlSupplier').val(0)
                    }
                    $(".select2").select2();
                }
            }
        }
    });
}

function Save_CustomerPayment() {

    var InsertArray = $('#txtCusPaymentdate').val() + "|" + $('#ddlcustomer').val() + "|" +
        $('#ddlPaymentMode').val() + "|" + $('#txtChqNoTrans').val() + "|" + $('#txtPaymentAmount').val() + "|" + $('#txtReceivedBy').val()
        + "|" + $('#txtRemarks').val();

    var Controls = "txtCusPaymentdate,ddlcustomer,ddlPaymentMode,txtPaymentAmount,txtReceivedBy";

    if (setBorderColor_Validation(Controls)) {
        var caption = $('#btnSaveCusPayment').html();
        if (caption == "Save") {
            $.ajax({
                url: 'Payments.ashx',
                type: "POST",
                data: {
                    'fun': 'Save_CustomerPayment', 'InsertArray': InsertArray
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#PopupAddCusPayments').modal('toggle');
                            calltoast("Data Saved Sucessfully", "success");
                            //ListAllSales();
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
                url: 'Sales.ashx',
                type: "POST",
                data: {
                    'fun': 'Update_CusPaymnet', 'InsertArray': InsertArray, 'Sales_Id': $('#hdn_Sales_Id').val()
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#Popup').modal('toggle');
                            calltoast("Updated Saved Sucessfully", "success");
                            //  ListAllSales();
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

function Save_SupplierPayment() {

    var InsertArray = $('#txtSupPaymentdate').val() + "|" + $('#ddlSupplier').val() + "|" +
        $('#ddlSupPaymentMode').val() + "|" + $('#txtChqNoTransSup').val() + "|" + $('#txtSupPaymentAmount').val() + "|" + $('#txtPaidBy').val()
        + "|" + $('#txtSupRemarks').val();

    var Controls = "txtSupPaymentdate,ddlSupplier,ddlSupPaymentMode,txtSupPaymentAmount,txtPaidBy";

    if (setBorderColor_Validation(Controls)) {
        var caption = $('#btnSaveSupPayment').html();
        if (caption == "Save") {
            $.ajax({
                url: 'Payments.ashx',
                type: "POST",
                data: {
                    'fun': 'Save_SupplierPayment', 'InsertArray': InsertArray
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#PopupAddSupPayments').modal('toggle');
                            calltoast("Data Saved Sucessfully", "success");
                            //ListAllSales();
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
                url: 'Sales.ashx',
                type: "POST",
                data: {
                    'fun': 'Update_SuplierPayment', 'InsertArray': InsertArray, 'Sales_Id': $('#hdn_Sales_Id').val()
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#Popup').modal('toggle');
                            calltoast("Updated Saved Sucessfully", "success");
                            //  ListAllSales();
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

function SetPage(Op) {
    $('#Hid_Operation').val(Op);
    $('#hdn_PageNo').val(0)
    if (Op == "Customer") {
        ListAllCustomerPayments
    }
    else {
        ListAllSuplierPayments();
    }
}

function SearchCustxt() {
    SetVal("hid_page", 0);
    ListAllCustomerPayments();
}

function SearchSuptxt() {
    SetVal("hid_page", 0);
    ListAllSuplierPayments();
}

function ListAllSuplierPayments() {

    // var SourceType = $('#DdlListDiv').val()
    // var Status = $('#DdlListStatus').val()
    var SearchString = $('#txtSupplierSearch').val();
    var Page_No = $('#hdn_PageNo').val();
    var Supplier_Id = $('#ddlListsupplier').val();
    $.ajax({
        url: 'Payments.ashx',
        type: "POST",
        data: {
            'fun': 'ListAllSuplierPayments', 'SearchString': SearchString, 'Page_No': Page_No, 'Supplier_Id': Supplier_Id
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    SetInnerVal("tblbodySupplier", data.split("|")[0])
                    SetInnerVal("Div_Paging1", data.split("|")[1])
                }
            }
        }
    });
}

function ListAllCustomerPayments() {

    // var SourceType = $('#DdlListDiv').val()
    // var Status = $('#DdlListStatus').val()
    var SearchString = $('#txtCutomerSearch').val();
    var Page_No = $('#hdn_PageNo').val();
    var Customer_Id = $('#ddlListcustomer').val();
    $.ajax({
        url: 'Payments.ashx',
        type: "POST",
        data: {
            'fun': 'ListAllCustomerPayments', 'SearchString': SearchString, 'Page_No': Page_No, 'Customer_Id': Customer_Id
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    SetInnerVal("tblbodyMainCustomer", data.split("|")[0])
                    SetInnerVal("Div_Paging", data.split("|")[1])
                }
            }
        }
    });
}

function pageNo(pno) {
    SetVal("hid_page", pno);
    if ($('#Hid_Operation').val() == "Customer") {
        ListAllCustomerPayments();
    }
    else {
        ListAllSuplierPayments();
    }
}

function SetTodaysDate(obj) {
    var date = new Date();
    Date.prototype.setDate = function () {
        var yyyy = this.getFullYear().toString();
        var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
        var dd = this.getDate().toString();
        return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]); // padding
    };
    $(obj).val(date.setDate());
}

function SetDateFormat(datestring) {
    var date = new Date(datestring);
    var yyyy = date.getFullYear().toString();
    var mm = (date.getMonth() + 1).toString(); // getMonth() is zero-based
    var dd = date.getDate().toString();
    return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]); // padding
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


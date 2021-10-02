

function ResetFields() {
    SetInnerVal("PopUpTitle", "Add Sales")
    $('#SalesNo').html("");
    SetTodaysDate('#txtSalesdate')
    $('#ddlcustomer').attr("disabled", false)
    $('#ddlcustomer').val(0);
    $('#ddlproduct').attr("disabled", false)
    $('#ddlproduct').val(0);
    $('#txtQty').val("200");
    $('#txtRate').val("0.00") +
    $('#txtTrips').val("1");
    $('#txtSite').val("");
    $('#txtSalesPrice').val("0.00");
    $('#txtFuelPrice').val("0.00");
    $('#txtDiscount').val("0.00") +
    $('#txtTotalCost').val("0.00");
    $('#txtvehicle').val("");
    $('#btnSave').html("Save")
    $('#txtRemarks').val("");
    $('#ddlcustomer').tabIndex = 0;
    $('#ddlcustomer').focus();
    $(".select2").select2();
}
function bindddls(IsEdit, Customer_Id,Product_Id) {
    $.ajax({
        url: 'Sales.ashx',
        type: "POST",
        data: { 'fun': 'bindddls' },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    var CustomerData = JSON.parse(data.split("|")[0]);
                    var Proddata = JSON.parse(data.split("|")[1]);
                    $('#SalesMaxNum').val(data.split("|")[2])
                    
                    //================Bind Customer===============
                    
                    $('#ddlListcustomer').empty();
                    $('#ddlListcustomer').append($('<option>').text('Select Customer').attr('value', 0));

                    $('#ddlcustomer').empty();
                    $('#ddlcustomer').append($('<option>').text('Select Customer').attr('value', 0));
                    $.each(CustomerData, function (i, obj) {
                        $('#ddlcustomer').append($('<option>').text(obj.Name.split(',').join(' ')).attr('value', obj.Id));
                        $('#ddlListcustomer').append($('<option>').text(obj.Name.split(',').join(' ')).attr('value', obj.Id));
                    });

                    $('#ddlproduct').empty();
                    $('#ddlproduct').append($('<option>').text('Select').attr('value', 0));
                    $.each(Proddata, function (i, obj) {
                        $('#ddlproduct').append($('<option>').text(obj.Product_Name.split(',').join(' ')).attr('value', obj.Id));
                    });

                    if (IsEdit == true) {
                        $('#ddlcustomer').val(Customer_Id)
                        $('#ddlproduct').val(Product_Id)
                    }
                    else {
                        $('#ddlcustomer').val(0)
                        $('#ddlproduct').val(0)
                    }
                    $(".select2").select2();
                }
            }
        }
    });
}

function GetRate() {
    $.ajax({
        url: 'Sales.ashx',
        type: "POST",
        data: { 'fun': 'GetRate', 'Product_Id': $('#ddlproduct').val() },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    
                    $('#txtRate').val(data)
                   // $('#txtQty').val("200")
                    CalculateSalesPrice();
                }
            }
        }
    });
}

function CalculateSalesPrice()
{
   var rate= $('#txtRate').val()
   var qty= $('#txtQty').val()
   var trips= $('#txtTrips').val();
   var fuel= $('#txtFuelPrice').val();
   var discount = $('#txtDiscount').val() 

    var SalesPrice = (parseFloat(rate) * Number(qty)) * Number(trips);

    var TotalCost = parseFloat(SalesPrice) - parseFloat(discount) - parseFloat(fuel);
    $('#txtSalesPrice').val(SalesPrice);
    $('#txtTotalCost').val(TotalCost);

}
function Save_Sales() {
    
    var InsertArray = $('#ddlcustomer').val() + "|" + $('#ddlproduct').val() + "|" +
        $('#txtQty').val() + "|" + $('#txtRate').val() + "|" + $('#txtTrips').val() + "|" + $('#txtSite').val()
        + "|" + $('#txtSalesPrice').val() + "|" + $('#txtFuelPrice').val() + "|" + $('#txtDiscount').val()
        + "|" + $('#txtTotalCost').val() + "|" + $('#txtvehicle').val() + "|" + $('#txtRemarks').val() + "|" + $('#SalesMaxNum').val() + "|" + $('#txtSalesdate').val() 
        
    var Controls = "txtSalesdate,ddlcustomer,ddlproduct,txtQty,txtRate,txtTrips,txtSite,txtSalesPrice,txtTotalCost,txtvehicle";

    if (setBorderColor_Validation(Controls)) {
        var caption = $('#btnSave').html();
        if (caption == "Save") {
            $.ajax({
                url: 'Sales.ashx',
                type: "POST",
                data: {
                    'fun': 'Save_Sales', 'InsertArray': InsertArray
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#Popup').modal('toggle');
                            calltoast("Data Saved Sucessfully", "success");
                            ListAllSales();
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
                    'fun': 'Update_Sales', 'InsertArray': InsertArray, 'Sales_Id': $('#hdn_Sales_Id').val()
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {
                           
                            $('#Popup').modal('toggle');
                            calltoast("Updated Saved Sucessfully", "success");
                            ListAllSales();
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

function Edit(Sales_Id, Isview) {
 
    $.ajax({
        url: 'Sales.ashx',
        type: "POST",
        data: { 'fun': 'Edit', 'Sales_Id': Sales_Id },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    var SalesData = JSON.parse(data)

                    $.each(SalesData, function (i, obj) {
                        bindddls(true, obj.Customer_Id, obj.Product_Id);
                        $('#ddlcustomer').attr("disabled", true)
             
                        $('#ddlproduct').attr("disabled", true)
                        
                        $('#txtSalesdate').val(SetDateFormat(obj.Sale_Date))
                        $('#hdn_Sales_Id').val(obj.Id);
                        $('#txtQty').val(obj.Quantity);
                        $('#txtRate').val(obj.Rate) +
                        $('#txtTrips').val(obj.Trips);
                        $('#txtSite').val(obj.Site);
                        $('#txtSalesPrice').val(obj.Sales_Price);
                        $('#txtFuelPrice').val(obj.Fuel_Price);
                        $('#txtDiscount').val(obj.Discount_Amount) +
                        $('#txtTotalCost').val(obj.Total_Cost);
                        $('#txtvehicle').val(obj.Vehicle_No);

                        $('#txtRemarks').val(obj.Remarks);
                        $('#btnSave').html("Update")
                        
                        $('#SalesNo').html("<b>Sales Order Number: </b>"+obj.Sale_Order_No)
                        SetInnerVal("PopUpTitle","Update Sales")
                        
                      
                        if (Isview == 1) {
                            $("#AllContent :input").prop("disabled", true);
                            SetInnerVal("PopUpTitle", "View Sales")
                        }
                        else {
                            
                            $("#AllContent :input").prop("disabled", false);
                            $('#ddlcustomer').attr("disabled", true)

                            $('#ddlproduct').attr("disabled", true)
                        }
                        
                        $(".select2").select2();
                    });
                }
            }
        }
    });
}
function ListAllSales() {
    
    var customer = $('#ddlListcustomer').val()
   // var Status = $('#DdlListStatus').val()
    var SearchString = $('#txtSearch').val()
    var Page_No = $('#hdn_PageNo').val()

    $.ajax({
        url: 'Sales.ashx',
        type: "POST",
        data: {
            'fun': 'ListAllSales', 'SearchString': SearchString, 'Page_No': Page_No, 'customer': customer },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                if (data != "") {

                    SetInnerVal("Sales_list_Body", data.split("|")[0])
                    SetInnerVal("Div_Paging", data.split("|")[1])
                }
            }
        }
    });
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

function AddVoucher(Sales_id,Vouchers) {
    $('#hdn_Sales_Id').val(Sales_id);
    $('#txtVouchers').val(Vouchers);
    
}

function SaveVoucher() {
    $.ajax({
        url: 'Sales.ashx',
        type: "POST",
        data: {
            'fun': 'SaveVoucher', 'Sales_id': $('#hdn_Sales_Id').val(), 'Vouchers': $('#txtVouchers').val()
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                if (data != "") {

                    $('#Popupvocher').modal('toggle');
                    calltoast("Vouchers Added Sucessfully", "success");
                    ListAllSales();

                }
            }
        }
    });
}

function deletesale(sales_id) {
    $.ajax({
        url: 'Sales.ashx',
        type: "POST",
        data: {
            'fun': 'deletesale', 'Sales_id': Sales_id
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                if (data != "") {

                    

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
    ListAllSales();
}


function pageNo(pno) {
    SetVal("hid_page", pno);
    ListAllSales();
}




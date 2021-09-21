

function ResetFields() {
    $('#ddlcustomer').val(0);
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
                    $('#ddlcustomer').empty();
                    $('#ddlcustomer').append($('<option>').text('Select Customer').attr('value', 0));
                    $.each(CustomerData, function (i, obj) {
                        $('#ddlcustomer').append($('<option>').text(obj.Name.split(',').join(' ')).attr('value', obj.Id));
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
        + "|" + $('#txtTotalCost').val() + "|" + $('#txtvehicle').val() + "|" + $('#txtRemarks').val() +"|" + $('#SalesMaxNum').val()
        
    var Controls = "ddlcustomer,ddlproduct,txtQty,txtRate,txtTrips,txtSite,txtSalesPrice,txtTotalCost,txtvehicle";

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
                        
                        //AllContent
                        btnSave
                        $(".select2").select2();
                    });
                }
            }
        }
    });
}
function ListAllSales() {

   // var SourceType = $('#DdlListDiv').val()
   // var Status = $('#DdlListStatus').val()
    var SearchString = $('#txtSearch').val()
    var Page_No = $('#hdn_PageNo').val()

    $.ajax({
        url: 'Sales.ashx',
        type: "POST",
        data: {
            'fun': 'ListAllSales', 'SearchString': SearchString,'Page_No': Page_No },
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




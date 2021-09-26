

function ResetFields() {
    $("#tbl_Sales_Body").empty();
    $('#ddlcustomer').val(0);
    $('#Frmdt').val("");
    $('#Todt').val("")
    $('#txtInvoiceAmount').val("0.00");
    $(".select2").select2();
}
function bindddls(IsEdit, Customer_Id) {
    $.ajax({
        url: 'Invoice.ashx',
        type: "POST",
        data: { 'fun': 'bindddls' },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    var CustomerData = JSON.parse(data);
                  
                    
                    //================Bind Customer===============
                    $('#ddlcustomer').empty();
                    $('#ddlcustomer').append($('<option>').text('Select Customer').attr('value', 0));
                    $.each(CustomerData, function (i, obj) {
                        $('#ddlcustomer').append($('<option>').text(obj.Name.split(',').join(' ')).attr('value', obj.Id));
                    });

                   

                    if (IsEdit == true) {
                        $('#ddlcustomer').val(Customer_Id)
                        
                    }
                    else {
                        $('#ddlcustomer').val(0)
                        
                    }
                    $(".select2").select2();
                }
            }
        }
    });
}
function Getitems()
{
    if (setBorderColor_Validation("ddlcustomer,Frmdt,Todt")) {
        Cus_Id = $('#ddlcustomer').val();
        GetSalesItems(false, Cus_Id)
    } else {
       // calltoast("Please Select Customer", "error");
    }
}

function GetSalesItems(IsEdit, Customer_Id) {
    $('#tbl_Sales_Body').empty();
    var Frmdate = $('#Frmdt').val();
    var Todate = $('#Todt').val();
    $.ajax({
        url: 'Invoice.ashx',
        type: "POST",
        data: { 'fun': 'GetSalesItems', 'Cus_Id': Customer_Id, 'Frmdate': Frmdate, 'Todate': Todate },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    var SalesData = JSON.parse(data);

                    var GrandTotal = 0.00;
                    //================Bind Customer===============
                    //  $('#ddlcustomer').empty();
                    var i = 0;
                    $.each(SalesData, function (i, obj) {
                        GrandTotal += parseFloat(obj.total_cost);
                        $('#tbl_Sales_Body').append($("<tr>"
                            + " <td style='display:none' id='Sales_"+i+"'>" + obj.id + "</td>"
                            + " <td >" + SetDateFormat(obj.Sale_Date) + "</td>"
                            + " <td >" + obj.Sale_order_no + "</td>"
                            + " <td >" + obj.product_name + "</td>"
                            + " <td >" + obj.quantity + "</td>"
                            + " <td >" + obj.trips + "</td>"
                            + " <td >" + obj.fuel_price + "</td>"
                            + " <td >" + obj.total_cost + "</td>"
                            + " </tr > "));
                        i++;
                    });
                    
                    $('#txtInvoiceAmount').val(GrandTotal)
                }
                else {
                    $('#tbl_Sales_Body').append($("<tr><td colspan='7'>No Record Found</td></tr>"));
                }
            }
        }
    });
}

function GetRate() {
    $.ajax({
        url: 'Invoice.ashx',
        type: "POST",
        data: { 'fun': 'GetRate', 'Product_Id': $('#ddlproduct').val() },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    
                    $('#txtRate').val(data)
                   // $('#txtQty').val("200")
                    CalculateInvoicePrice();
                }
            }
        }
    });
}


function Save_Invoice() {

    var MainArray = $('#ddlcustomer').val() + "|" + $('#Frmdt').val() + "|" +
        $('#Todt').val() + "|" + $('#txtInvoiceAmount').val();        
    var Controls = "ddlcustomer,Frmdt,Todt,txtInvoiceAmount";
    var i = 0;
    //alert(Invoice_Id);
    TableData = "";
 

    $("#tbl_Sales_Body tr").each(function () {
        //alert($('#Sales_' + i).html())
        TableData = $('#Sales_' + i).html() + '|' +
        i++;
    });
    if (setBorderColor_Validation(Controls)) {
        var caption = $('#btnSave').html();
        if (caption == "Save") {
            $.ajax({
                url: 'Invoice.ashx',
                type: "POST",
                data: {
                    'fun': 'Save_Invoice', 'MainArray': MainArray, 'TableData': TableData
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {

                            $('#Popup').modal('toggle');
                            calltoast("Data Saved Sucessfully", "success");
                            ResetFields();
                            ListAllInvoice();
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
                url: 'Invoice.ashx',
                type: "POST",
                data: {
                    'fun': 'Update_Invoice', 'InsertArray': InsertArray, 'Invoice_Id': $('#hdn_Invoice_Id').val()
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {

                        if (data != "") {
                           
                            $('#Popup').modal('toggle');
                            calltoast("Updated Saved Sucessfully", "success");
                            ListAllInvoice();
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

function Edit(Invoice_Id, Isview) {
 
    $.ajax({
        url: 'Invoice.ashx',
        type: "POST",
        data: { 'fun': 'Edit', 'Invoice_Id': Invoice_Id },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                if (data != "") {
                    var InvoiceData = JSON.parse(data)

                    $.each(InvoiceData, function (i, obj) {
                        bindddls(true, obj.Customer_Id, obj.Product_Id);
                        $('#ddlcustomer').attr("disabled", true)
             
                        $('#ddlproduct').attr("disabled", true)
                        
                        $('#hdn_Invoice_Id').val(obj.Id);
                        $('#txtQty').val(obj.Quantity);
                        $('#txtRate').val(obj.Rate) +
                        $('#txtTrips').val(obj.Trips);
                        $('#txtSite').val(obj.Site);
                        $('#txtInvoicePrice').val(obj.Invoice_Price);
                        $('#txtFuelPrice').val(obj.Fuel_Price);
                        $('#txtDiscount').val(obj.Discount_Amount) +
                        $('#txtTotalCost').val(obj.Total_Cost);
                        $('#txtvehicle').val(obj.Vehicle_No);

                        $('#txtRemarks').val(obj.Remarks);
                        $('#btnSave').html("Update")
                        
                        $('#InvoiceNo').html("<b>Invoice Order Number: </b>"+obj.Sale_Order_No)
                        SetInnerVal("PopUpTitle","Update Invoice")
                        
                      
                        if (Isview == 1) {
                            $("#AllContent :input").prop("disabled", true);
                            SetInnerVal("PopUpTitle", "View Invoice")
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
function ListAllInvoice() {

   // var SourceType = $('#DdlListDiv').val()
   // var Status = $('#DdlListStatus').val()
    var SearchString = $('#txtSearch').val()
    var Page_No = $('#hdn_PageNo').val()

    $.ajax({
        url: 'Invoice.ashx',
        type: "POST",
        data: {
            'fun': 'ListAllInvoice', 'SearchString': SearchString,'Page_No': Page_No },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                if (data != "") {

                    SetInnerVal("Invoice_list_Body", data.split("|")[0])
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
    ListAllInvoice();
}


function pageNo(pno) {
    SetVal("hid_page", pno);
    ListAllInvoice();
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
function DateFormat(datestring) {
    var date = new Date(datestring);
    var yyyy = date.getFullYear().toString();
    var mm = (date.getMonth() + 1).toString(); // getMonth() is zero-based
    var dd = date.getDate().toString();
    return (dd[1] ? dd : "0" + dd[0]) + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + yyyy; // padding
}

function SetDateFormat(datestring) {
    var date = new Date(datestring);
    var yyyy = date.getFullYear().toString();
    var mm = (date.getMonth() + 1).toString(); // getMonth() is zero-based
    var dd = date.getDate().toString();
    return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]); // padding
}


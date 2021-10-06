<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sales_Master.aspx.cs" Inherits="Modules_MRM_mrm_list" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>

<% 
    Session["top_menu"] = "Sales";
    Session["sub_menu"] = "Sales-list";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="<%=G.B%>assets/images/favicon.ico">
    <title>Sales List</title>

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/vendor_components/datatable/datatables.min.css" />
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/icheck/skins/all.css">
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css"
        rel="stylesheet">
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
    <style>
        .modal-dialog {
            width: 900px;
            max-width: 1100px;
        }
    </style>
</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">
    <form id="frm" runat="server" >
        <div class="wrapper">

            <uc1:uch ID="uch1" runat="server" />
            <uc2:ucs ID="ucs1" runat="server" />
            <input type="hidden" value="0" id="SalesMaxNum" />
            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Main content -->
                <section class="content mt-20">
                    <input type="hidden" id="hdn_PageNo" value="0" />
                    <input type="hidden" id="hdn_Sales_Id" value="0" />
                    <div class="box">
                        <div class="col-lg-12 col-12 text-center" hidden id="divViewAccess">
                            <div class="box">
                                <div class="box-header with-border">
                                    <h1><i class="fa fa-ban font-size-100 text-danger"></i>
                                        <br />
                                        Access Denied</h1>
                                </div>
                            </div>
                        </div>
                        <div class="box-body" id="MianDiv">
                            <div class="row mb-10">

                                <div class="col-md-3 mt-25">
                                    <input type="text" id="txtSearch" class="form-control" onkeyup="Searchtxt()" placeholder="Search">
                                    <span class="tblsearch-btn"><i class="ti-search"></i></span>

                                </div>
                                  <div class="col-md-3">
                              <label>Customer<span class="text-danger">*</span></label>
                                <select id="ddlListcustomer" class="form-control enq-dropdown select2" onchange="ListAllSales()">
                                    <option value="0" tabindex="0">Select</option>
                                </select>
                            </div>
                                <div class="col-md-6 mt-25 ">
                                    <button class="btn btn-success right fa fa-plus" id="btnAdd" onclick="ResetFields();" data-toggle="modal" data-target="#Popup"></button>

                                </div>
                            </div>
                            <div class=" row media-list media-list-divided media-list-hover ">
                                <div class="col-md-12">

                                    <table class="table table-hover table-bordered ">
                                        <thead>
                                            <tr>
                                                <th>Sale Date </th>
                                                <th>Customer </th>
                                                <th>Product </th>
                                                <th>Sale Order No </th>
                                                <th>Qty</th>
                                                <th>Rate/ft</th>
                                                <th>Sales Price</th>
                                                <th>Discount</th> 
                                                <th>Fuel Amount</th>
                                                <th>Voucher Nos</th>
                                                <th>Total Cost</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="Sales_list_Body">
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                        <div class="box-footer mb-40" id="Div_Paging">
                        </div>
                    </div>

                    <!-- /.box-body -->

                    <!-- /.col -->


                    <!-- /.row -->
                    <input type="hidden" id="hid_page" value="0" />
                    <input type="hidden" id="hid_SortField" value="order by Job_Order_Id  desc" />
                </section>

                <!-- /.content -->
            </div>
            <!-- /.cont<ent-wrapper -->
        </div>
        

        <script src="<%=G.S%>General/jquery.min.js"></script>
        <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
        <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
        <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>

        <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>
        <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>

        <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
        <script src="<%=G.B%>assets/js/template.js"></script>
        <script src="<%=G.B%>assets/js/demo.js"></script>

        <script src="../General/libo.js" type="text/javascript"></script>
        <script src="Sales.js"></script>

        <script>


            $(document).ready(function () {
                //  GetUserAccess();
                bindddls(false, 0, 0);
                ListAllSales();
            });






        </script>
    </form>
    <div class="modal fade  bs-example-modal-lg" id="Popup" tabindex="">
            <div class="modal-dialog ">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="PopUpTitle">Add Sales</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body pt-5" id="AllContent">
                        <div class="row mb-10">
                            <div class='col-md-6'>
                                <label id="SalesNo"></label>

                            </div>
                        </div>
                        <div class="row mb-10">

                            <div class="col-md-3">
                                <label>Sales Date<span class="text-danger">*</span></label>
                                <input class="form-control " tabindex="0" type="date" id="txtSalesdate" onkeyup="CalculateSalesPrice()" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>

                            <div class="col-md-3">
                                <label>Customer<span class="text-danger">*</span></label>
                                <select id="ddlcustomer" class="form-control enq-dropdown select2">
                                    <option value="0" tabindex="0">Select</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label>Product<span class="text-danger">*</span></label>
                                <select id="ddlproduct" class="form-control enq-dropdown select2" onchange="GetRate()">
                                    <option value="0" tabindex="1">Select</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label>Quantity (ft)<span class="text-danger">*</span></label>
                                <input class="form-control " tabindex="2" value="200" id="txtQty" onkeyup="CalculateSalesPrice()" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>
                           
                        </div>
                        <div class="row mb-10">
                             <div class="col-md-3">
                                <label>Rate Per ft<span class="text-danger">*</span></label>
                                <input class="form-control " tabindex="3" value="0.00" id="txtRate" onkeyup="CalculateSalesPrice()" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>
                            <div class="col-md-3">
                                <label>No.Of Trips<span class="text-danger">*</span></label>
                                <input type="number" tabindex="4" onchange="CalculateSalesPrice()" class="form-control " onkeyup="CalculateSalesPrice()" value="1" id="txtTrips" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>
                            <div class="col-md-6">
                                <label>Site<span class="text-danger">*</span></label>
                                <input class="form-control " tabindex="5" id="txtSite" />

                            </div>

                            

                        </div>
                        <div class="row mb-10">
                            <div class="col-md-3">
                                <label>Sales Price<span class="text-danger">*</span></label>
                                <input class="form-control " readonly value="0.00" id="txtSalesPrice" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>
                            <div class="col-md-3">
                                <label>Fuel Amount</label>
                                <input class="form-control " tabindex="6" onkeyup="CalculateSalesPrice()" value="0.00" id="txtFuelPrice" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>

                            <div class="col-md-3">
                                <label>Discount Amount</label>
                                <input class="form-control " tabindex="7" onkeyup="CalculateSalesPrice()" value="0.00" id="txtDiscount" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>
                            <div class="col-md-3">
                                <label>Total Cost<span class="text-danger">*</span></label>
                                <input class="form-control " value="0.00" readonly id="txtTotalCost" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>
                            <div class="col-md-3">
                                <label>Vehicle No<span class="text-danger">*</span></label>
                                <input class="form-control " tabindex="8" value="" id="txtvehicle" />

                            </div>
                            <div class="col-md-6 ">
                                <label>Remarks </label>
                                <textarea class="form-control " tabindex="9" id="txtRemarks"></textarea>

                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <button class="btn btn-success right" tabindex="10" id="btnSave" onclick="Save_Sales()">Save</button>
                            </div>
                        </div>



                        <div class="modal-footer"></div>
                    </div>
                </div>
            </div>
        </div>

     <div class="modal fade  bs-example-modal-lg" id="Popupvocher" tabindex="">
            <div class="modal-dialog " style="width: 500px!important">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="PopUpTitlevocher">Add Vouchers</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body pt-5" id="AllContentvocher">
                        
                        <div class="row mb-10">
                            <div class="col-md-12 ">
                                <label>Vouchers </label>
                                <textarea class="form-control " placeholder="Eg: voucher1,voucher2,.." id="txtVouchers"></textarea>

                            </div>
                            </div>
                       
                        <div class="row">
                            <div class="col-md-12">
                                <button class="btn btn-success right" tabindex="10" id="btnSavevoucher" onclick="SaveVoucher()">Save</button>
                            </div>
                        </div>



                        
                    </div>
                </div>
            </div>
        </div>



</body>
</html>
<script>

    $('#btnDelete').on('click', function (e) {
        confirmDialog('Are You Sure To delete this Supplier', function () {
            
        });
    });

    function confirmDialog(message, onConfirm) {
        var fClose = function () {
            modal.modal("hide");
        };
        var modal = $("#confirmModal");
        modal.modal("show");
        $("#confirmMessage").empty().append(message);
        $("#confirmOk").unbind().one('click', onConfirm).one('click', fClose);
        $("#confirmCancel").unbind().one("click", fClose);
    }
</script>

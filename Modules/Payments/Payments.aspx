
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Payments.aspx.cs" Inherits="Modules_MRM_mrm_list" %>


<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>

<%
    Session["top_menu"] = "payments";
    Session["sub_menu"] = "payments";
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
    <title>SUS ERP - Monthly Posting</title>
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
    <%--    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/vendor_components/datatable/datatables.min.css" />--%>
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.css">

    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
    <style>
        #pagination a {
            display: inline-block;
            margin-right: 5px;
        }
    </style>
    <style>
      

        .modal-lg {
            max-width: 1100px;
            width: 1100px !important;
        }
    </style>

</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">
      <form id="frm" runat="server">
    <div class="wrapper">

        <uc1:uch ID="uch1" runat="server" />
        <uc2:ucs ID="ucs1" runat="server" />
        <input type="hidden" id="Hid_Operation" value="Customer" />
        <input type="hidden" id="hdn_PageNo" value="0" />
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content mt-20">
                
                <div class="box">
                    <div class="col-lg-12 col-12 text-center" hidden  id="divViewAccess">
                            <div class="box">
                                <div class="box-header with-border">
                                    <h1><i class="fa fa-ban font-size-100 text-danger"></i>
                                        <br />
                                        Access Denied</h1>
                                </div>
                            </div>
                        </div>

                    <div class="box-body"   id="MianDiv">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="lnk-post" data-toggle="tab" onclick="SetPage('Customer')" href="#CustomerPayments" role="tab">

                                    <span class="hidden-xs-down">Customer Payments</span></a> </li>
                            <li class="nav-item disabled">
                                <a class="nav-link " id="lnk-posted" data-toggle="tab" onclick="SetPage('Supplier')" href="#SupplierPayments" role="tab">

                                    <span class="hidden-xs-down">Supplier Payments</span></a> </li>

                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="CustomerPayments" role="tabpanel">
                                <div class="row">


                                    <div class="col-md-3">
                                        <label>Customer</label>
                                         <select id="ddlListcustomer" class="form-control enq-dropdown select2" onchange="SearchCustxt()">
                                            <option value="0" tabindex="0">Select</option>
                                          </select>

                                    </div>
                                    <div class="col-md-3 mt-25 ">
                                        <input type="text" class="form-control enq-txtbx-pd " id="txtCutomerSearch" onkeyup="SearchCustxt()" placeholder="Search by Customer Name">
                                        <span class="tblsearch-btn"><i class="ti-search"></i></span>

                                    </div>
                                   
                                    <div class="col-md-6 col-sm-6 mt-25">
                                        <a href="#" id="btn_Add" data-toggle="modal" data-target="#PopupAddCusPayments" class="btn btn-success right" title="Add Payment" "><i class="fa fa-plus"></i></a>

                                        
                                    </div>

                                </div>

                                <div class="row mt-10">

                                    <div class="col-md-12">
                                        <div>
                                            <table class="table table-hover table-bordered table-striped  table-responsive">
                                                <thead>
                                                    <tr>
                                                        <th>Date</th>
                                                        <th>Customer Name</th>
                                                        <th>Payment Number</th>
                                                        <th>Payment Mode</th>
                                                        <th>Cheque/Transaction No</th>
                                                        <th>Amount</th>
                                                        <th>Recieved By</th>
                                                        <th>Remarks</th>
                                                        <th>Action</th>
                                                      
                                                    </tr>
                                                </thead>
                                                <tbody id="tblbodyMainCustomer">
                                                </tbody>
                                            </table>

                                        </div>

                                        <div class="box-footer mb-40" id="Div_Paging"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane " id="SupplierPayments" role="tabpanel">
                                <div class="row">


                                    <div class="col-md-3">
                                        <label>Supplier</label>
                                         <select id="ddlListsupplier" class="form-control enq-dropdown select2" onchange="SearchSuptxt()">
                                            <option value="0" tabindex="0">Select</option>
                                          </select>
                                    </div>
                                    <div class="col-md-3  mt-25">
                                        <input type="text" class="form-control enq-txtbx-pd " id="txtSupplierSearch" onkeyup="SearchSuptxt()" placeholder="Search by Suppier Name">
                                        <span class="tblsearch-btn"><i class="ti-search"></i></span>

                                    </div>
                                     <div class="col-md-6 col-sm-6 mt-25">
                                        <a href="#" id="btn_AddSuplierPayment" data-toggle="modal" data-target="#PopupAddSupPayments"  class="btn btn-success right" title="Add Payment" "><i class="fa fa-plus"></i></a>

                                        
                                    </div>
                                </div>

                                <div class="row mt-10">

                                    <div class="col-md-12">
                                        <div>
                                            <table class="table table-hover table-bordered table-striped  table-responsive">
                                                <thead>
                                                    <tr>
                                                        <th>Date</th>
                                                        <th>Supplier No</th>
                                                        <th>Payment Number</th>
                                                        <th>Payment Mode</th>
                                                        <th>Cheque/Trans No</th>
                                                        <th>Amount</th>
                                                        <th>Paid By</th>

                                                        <th>Remarks</th>
                                                         <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tblbodySupplier">
                                                </tbody>
                                            </table>

                                        </div>

                                        <div class="box-footer mb-40" id="Div_Paging1"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>




                </div>
              
                <div class="box-footer mb-40"></div>
                <!-- /.box-body -->


                <!-- /.row -->
                <input type="hidden" id="hid_page" value="0" />
            </section>
            <!-- /.content -->
        </div>
       
        <uc3:ucf ID="ucf1" runat="server" />
    </div>
    <!-- /.content-wrapper -->
          </form>

      <div class="modal fade  bs-example-modal-lg" id="PopupAddCusPayments" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="PopUpTitlevocher">Add Customer Payment</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body pt-5" id="AllContent">
                        
                        <div class="row mb-10">
                            
                               <div class="col-md-6">
                                <label>Payment Date<span class="text-danger">*</span></label>
                                <input class="form-control " tabindex="0" type="date" id="txtCusPaymentdate" onkeyup="CalculateSalesPrice()" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>

                            <div class="col-md-6">
                                <label>Customer<span class="text-danger">*</span></label>
                                <select id="ddlcustomer" class="form-control enq-dropdown select2">
                                    <option value="0" tabindex="0">Select</option>
                                </select>
                            </div>
                            </div>
                         <div class="row mb-10">
                             <div class="col-md-6">
                                <label>Payment Mode<span class="text-danger">*</span></label>
                                <select id="ddlPaymentMode" class="form-control enq-dropdown select2">
                                    <option value="Cash" tabindex="1">Cash</option>
                                    <option value="Cheque" tabindex="1">Cheque</option>
                                    <option value="Online" tabindex="1">Online</option>
                                </select>
                            </div>
                          <div class="col-md-6" id="Div_ChqNum">
                                <label>Cheque No/Trans Id<span class="text-danger">*</span></label>
                                <input class="form-control " readonly  id="txtChqNoTrans" />

                          </div>
                            
                              </div>
                             <div class="row mb-10">
                             <div class="col-md-6" >
                                <label>Payment Amount<span class="text-danger">*</span></label>
                                <input class="form-control " placeholder="0.00"  id="txtPaymentAmount" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                          </div>
                            <div class="col-md-6" >
                                <label>Received By<span class="text-danger">*</span></label>
                                <input class="form-control "  id="txtReceivedBy" />

                          </div>
                                 </div>
                            
                         <div class="row mb-10">
                             <div class="col-md-12">
                                <label>Remarks </label>
                                <textarea class="form-control " id="txtRemarks"></textarea>

                            </div>
                            </div>
                       
                        <div class="row">
                            <div class="col-md-12">
                                <button class="btn btn-success right" tabindex="10" id="btnSaveCusPayment" onclick="Save_CustomerPayment()">Save</button>
                            </div>
                        </div>



                        
                    </div>
                </div>
            </div>
        </div>

     <div class="modal fade  bs-example-modal-lg" id="PopupAddSupPayments" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="PopUpTitle">Add Supplier Payment</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body pt-5" id="AllContent2">
                        
                        <div class="row mb-10">
                            
                               <div class="col-md-6">
                                <label>Payment Date<span class="text-danger">*</span></label>
                                <input class="form-control " tabindex="0" type="date" id="txtSupPaymentdate" onkeyup="CalculateSalesPrice()" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>

                            <div class="col-md-6">
                                <label>Supplier<span class="text-danger">*</span></label>
                                <select id="ddlSupplier" class="form-control enq-dropdown select2">
                                    <option value="0" tabindex="0">Select</option>
                                </select>
                            </div>
                            </div>
                         <div class="row mb-10">
                             <div class="col-md-6">
                                <label>Payment Mode<span class="text-danger">*</span></label>
                                <select id="ddlSupPaymentMode" class="form-control enq-dropdown select2">
                                    <option value="Cash" tabindex="1">Cash</option>
                                    <option value="Cheque" tabindex="1">Cheque</option>
                                    <option value="Online" tabindex="1">Online</option>
                                </select>
                            </div>
                          <div class="col-md-6" id="Div_ChqNumSup">
                                <label>Cheque No/Trans Id<span class="text-danger">*</span></label>
                                <input class="form-control " readonly  id="txtChqNoTransSup" />

                          </div>
                            
                              </div>
                             <div class="row mb-10">
                             <div class="col-md-6" >
                                <label>Payment Amount<span class="text-danger">*</span></label>
                                <input class="form-control " placeholder="0.00"  id="txtSupPaymentAmount" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                          </div>
                            <div class="col-md-6" >
                                <label>Paid By<span class="text-danger">*</span></label>
                                <input class="form-control "  id="txtPaidBy" />

                          </div>
                                 </div>
                            
                         <div class="row mb-10">
                             <div class="col-md-12">
                                <label>Remarks </label>
                                <textarea class="form-control " id="txtSupRemarks"></textarea>

                            </div>
                            </div>
                       
                        <div class="row">
                            <div class="col-md-12">
                                <button class="btn btn-success right" tabindex="10" id="btnSaveSupPayment" onclick="Save_SupplierPayment()">Save</button>
                            </div>
                        </div>



                        
                    </div>
                </div>
            </div>
        </div>



</body>
</html>

    <!-- ./wrapper -->

    <!-- jQuery 3 -->
    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <%--<script src="<%=G.B%>assets/vendor_components/fastclick/lib/fastclick.js"></script>--%>
    <%--<script src="<%=G.B%>assets/vendor_components/datatable/datatables.min.js"></script>--%>
    <script src="<%=G.B%>assets/vendor_components/moment/min/moment.min.js"></script>

    <script src="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.js"></script>

    <%--    <script src="<%=G.B%>assets/js/pages/form-validation.js"></script>--%>
    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>

    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
    <script src="<%=G.B%>assets/js/template.js"></script>
    <script src="<%=G.B%>assets/js/demo.js"></script>

    <script src="../General/libo.js"></script>
    <script src="Payments.js"></script>

    <script>
        $(document).ready(function () {
            $('.select2').select2();
            SetTodaysDate("#txtCusPaymentdate");
            SetTodaysDate("#txtSupPaymentdate");
            bindddls();
            ListAllCustomerPayments()
        });






    </script>


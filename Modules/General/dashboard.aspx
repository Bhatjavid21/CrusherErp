<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="dashboard" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>
<% 
    Session["top_menu"] = "";
    Session["sub_menu"] = "dashboard";
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

    <title>Stone Crusher System - Dashboard</title>
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/clockpicker/dist/jquery-clockpicker.min.css">

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/fullcalendar/fullcalendar.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/fullcalendar/fullcalendar.print.min.css" media="print">
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/vendor_components/datatable/datatables.min.css" />
    <!-- Bootstrap extend-->
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css" />
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css" />
    <!-- Date Picker-->
    <link href="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet" type="text/css" />
    <!-- toast CSS -->
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet" />
    <!-- theme style -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <!-- Al Manal skins -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-switch/switch.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/jquery.autocomplete/easy-autocomplete.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/icheck/skins/all.css">
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/js/froiden-helper/helper.css">
    <script src="https://kit.fontawesome.com/ce15a19fdb.js" crossorigin="anonymous"></script>
    <style>
        .chat-body {
            background: #eee;
            border-radius: 13px;
            margin-top: 10px;
            padding: 4px 17px;
        }

        .scroll1 {
            height: 300px;
            overflow-y: auto;
        }

        .scroll1 {
            display: flex;
            flex-direction: column-reverse;
        }

        .btn-toggle.btn-sm:before {
            content: 'Open';
            left: -0.5rem;
        }

        .btn-toggle.btn-sm:after {
            content: 'Close';
            right: -0.5rem;
            opacity: .5;
        }

        .btn-toggle.btn-sm.btn-sm:after {
            left: 3px;
            width: 3.7rem;
        }

        .btn-toggle.btn-sm.btn-sm:before {
            left: 12px;
        }

        .btn-toggle.btn-sm.active > .handle {
            left: 37px;
        }

        .btn-toggle.btn-sm {
            width: 3.7rem;
        }

        .clockpicker-popover {
            z-index: 999999 !important;
        }

        /*.table > thead > tr > th {
            text-align: center;
        }

        .table > tbody > tr > td {
            padding: 20px !important;
            text-align: right !important;
        }*/
    </style>
</head>

<body class="hold-transition fixed skin-info-light sidebar-mini">
    <form id="frm" runat="server">
        <div class="wrapper">

            <uc1:uch ID="uch1" runat="server" />
            <uc2:ucs ID="ucs1" runat="server" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <input type="hidden" id="hdfmode" value="">
                <input type="hidden" id="hid_Task_Main_Id" value="0" />
                <!-- Content Header (Page header) -->
                <div class="content-header display-none">
                    <div class="d-flex align-items-center">
                        <div class="mr-auto">
                            <h3 class="page-title">Dashboard</h3>
                            <div class="d-inline-block align-items-center">
                                <nav>
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
                                    </ol>
                                </nav>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Main content -->

                <h5 class="mt-3 mb-4 text">Dashboard</h5>
                <br />
                <div class="container d-flex  mt-4">

                    <br />
                    <div class="p-3 mt-3 rounded border">
                        <a href="#">
                            <div class=" p-2  d-flex flex-row align-items-center">
                                <div class="p-1 px-4 d-flex flex-column align-items-center rounded"><span class="d-block char text-success">
                                    <asp:Literal ID="ltrCustomers" runat="server" Text="240"></asp:Literal></span></div>
                            </div>
                            <div class="d-flex flex-row align-items-center">
                                <div class="ml-2 p-3 d-inline">                                   
                                    <h6 class="heading1"><i class="fas fa-user-friends"></i>  Customers</h6>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="p-3 mt-3 ml-10 rounded border">
                        <a href="#">
                            <div class=" p-2  d-flex flex-row align-items-center">
                                <div class="p-1 px-4 d-flex flex-column align-items-center  rounded"><span class="d-block char text-success">
                                    <asp:Literal ID="ltrProducts" runat="server" Text="4"></asp:Literal></span></div>
                            </div>
                            <div class="d-flex flex-row align-items-center">
                                <div class="ml-2 p-3 d-inline">                                   
                                    <h6 class="heading1"><i class="fas fa-shopping-basket"></i>  Products</h6>
                                </div>
                            </div>
                        </a>

                    </div>
                    <div class="p-3 mt-3 ml-10 rounded border">
                        <a href="#">
                            <div class=" p-2  d-flex flex-row align-items-center">
                                <div class="p-1 px-4 d-flex flex-column align-items-center  rounded"><span class="d-block char text-success">
                                    <asp:Literal ID="ltrSuppliers" runat="server" Text="34"></asp:Literal></span></div>
                            </div>
                            <div class="d-flex flex-row align-items-center">
                                <div class="ml-2 p-3 d-inline">                                   
                                    <h6 class="heading1"><i class="fas fa-truck-moving"></i>  Suppliers</h6>
                                </div>
                            </div>
                        </a>

                    </div>
                    <div class="p-3 mt-3 ml-10 rounded border">
                        <a href="#">
                            <div class=" p-2  d-flex flex-row align-items-center">
                                <div class="p-1 px-4 d-flex flex-column align-items-center  rounded"><span class="d-block char text-success">
                                    <asp:Literal ID="ltsPurchases" runat="server" Text="300"></asp:Literal></span></div>
                            </div>
                            <div class="d-flex flex-row align-items-center">
                                <div class="ml-2 p-3 d-inline">                                    
                                    <h6 class="heading1"><i class="fas fa-shopping-cart"></i>  Purchases</h6>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="p-3 mt-3 ml-10 rounded border">
                        <a href="#">
                            <div class=" p-2  d-flex flex-row align-items-center">
                                <div class="p-1 px-4 d-flex flex-column align-items-center  rounded"><span class="d-block char text-success">
                                    <asp:Literal ID="ltrSales" runat="server" Text="1001"></asp:Literal></span></div>
                            </div>
                            <div class="d-flex flex-row align-items-center">
                                <div class="ml-2 p-3 d-inline">                                   
                                    <h6 class="heading1"><i class="fas fa-balance-scale"></i>  Sales</h6>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="p-3 mt-3 ml-10 rounded border">
                        <a href="#">
                            <div class=" p-2  d-flex flex-row align-items-center">
                                <div class="p-1 px-4 d-flex flex-column align-items-center  rounded"><span class="d-block char text-success">
                                    <asp:Literal ID="ltrInvoices" runat="server" Text="356"></asp:Literal></span></div>
                            </div>
                            <div class="d-flex flex-row align-items-center">
                                <div class="ml-2 p-3 d-inline">                                   
                                    <h6 class="heading1"><i class="fas fa-file-invoice-dollar"></i>  Invoices</h6>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <!-- /.content -->
            </div>

            <uc3:ucf ID="ucf1" runat="server" />
        </div>
        <!-- ./wrapper -->

        <!-- BEGIN MODAL -->
        <div class="modal none-border" id="taskPopup">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="col-md-4">
                            <h4 class="modal-title" id="lbl_Modal_Title"><strong>Add Task</strong></h4>
                        </div>
                        <div class="col-md-8 right">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <button type="button" class="close fa fa-pencil pt-20 hide" id="btn_Enable_Task_Controls"></button>
                        </div>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class='col-md-6'>

                                <label class='control-label'>Task Name <span class="red-bold">*</span></label>
                                <input class='form-control enq-txtbx-pd' type="text" maxlength="50" id="txt_Task_Name" />

                                <div id="div_Status" class="hide">
                                    <label><b>Status : </b></label>
                                    <button type='button' id="btn_Status" class='btn btn-sm btn-toggle' data-toggle='button' aria-pressed='true' autocomplete='off'>
                                        <div class='handle'></div>
                                    </button>
                                </div>
                            </div>

                            <div class='col-md-6'>
                                <label class="">
                                    Assigned To <span class="red-bold">*</span></label>

                                <select class="form-control enq-txtbx-pd fnt11 enq-dropdown select2" id="ddl_Assigned_To" multiple required>
                                </select>

                            </div>

                            <div class='col-md-3'>
                                <div class='form-group'>
                                    <label class='control-label'>Task Date <span class="red-bold">*</span></label>
                                    <input class='form-control enq-txtbx-pd' type='date' id="txt_Task_Date" />
                                </div>
                            </div>

                            <div class='col-md-3'>
                                <div class='form-group'>
                                    <label class='control-label'>End Date <span class="red-bold">*</span></label>
                                    <input class='form-control enq-txtbx-pd' type='date' id="txt_End_Date" />
                                </div>
                            </div>

                            <div class='col-md-2'>
                                <div class='form-group'>
                                    <label class='control-label'>Task Time <span class="red-bold">*</span></label><div class="input-group clockpicker " data-placement="right" data-align="top" data-autoclose="true">
                                        <input type="text" class="form-control enq-txtbx-pd fa fa-clock-o" value="" id="txt_Task_Time">
                                    </div>
                                </div>
                            </div>

                            <div class='col-md-2'>
                                <div class='form-group'>
                                    <label class='control-label'>End Time <span class="red-bold">*</span></label><div class="input-group clockpicker " data-placement="right" data-align="top" data-autoclose="true">
                                        <input type="text" class="form-control enq-txtbx-pd fa fa-clock-o" value="" id="txt_End_Time">
                                    </div>
                                </div>
                            </div>

                            <div class='col-md-2'>
                                <div class='form-group'>
                                    <label class='control-label'>Priority <span class="red-bold">*</span></label>
                                    <select class="form-control enq-dropdown select2" id="ddl_Task_Priority">
                                        <option value="0">Select</option>
                                        <option value="1">Low</option>
                                        <option value="2">Medium</option>
                                        <option value="3">High</option>
                                    </select>
                                </div>
                            </div>

                            <div class='col-md-12'>
                                <div class='form-group'>
                                    <label class='control-label'>Task Description <span class="red-bold">*</span></label>
                                    <textarea class='form-control' rows="2" onkeyup="inputDynamicHeight(this);" maxlength="200" id="txt_Task_Description"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <%--<button type="button" class="btn btn-dark" data-dismiss="modal" id="btn_Close_Task_Main">Close</button>--%>
                                <button type="button" class="btn btn-success right" id="btn_Save_Task_Main" onclick="Save_Task_Main();">Save</button>
                            </div>
                        </div>
                    </div>

                    <div class="modal-body none-border hide" id="divComments">
                        <div id="div_Task_Comments">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <button type="button" id="btn_Save_Exit_Task_Comments" class="btn btn-success right" onclick="Insert_Task_Comment('exit');"><i class="fa fa-save"></i>&nbsp;Save & Exit</button>
                                <button type="button" id="btn_Save_Stay_Task_Commments" class="btn btn-success right mr-5" onclick="Insert_Task_Comment('stay');"><i class="fa fa-save"></i>&nbsp;Save & Stay</button>
                                <button type="button" class="btn btn-dark " data-dismiss="modal" id="btn_Task_Comment_Popup_Close"><i class="fa fa-close"></i>&nbsp;Close</button>
                            </div>
                            <div class="col-md-2 pl-0">
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>

    </form>
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>

    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-ui/jquery-ui.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.js"></script>

    <script src="<%=G.B%>assets/vendor_components/fullcalendar/lib/moment.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/fullcalendar/fullcalendar.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>

    <script src="<%=G.B%>assets/js/bootstrap-growl.min.js"></script>
    <script src="<%=G.B%>assets/js/froiden-helper/helper.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
    <script src="<%=G.B%>assets/vendor_components/clockpicker/dist/jquery-clockpicker.min.js"></script>

    <script src="<%=G.B%>assets/js/template.js"></script>
    <script src="<%=G.B%>assets/js/demo.js"></script>
    <script src="libo.js"></script>
    <script src="dashboard.js"></script>
    <script>
        $('.select2').select2();
    </script>
    <style>
        .card {
            width: 380px;
            border: none
        }

        .border {
            border-radius: 12px
        }

        .score {
            background-color: #dcddea
        }

        .heading1 {
            color: #0D47A1;
            font-size: 20px;
        }

        .text {
            color: #0D47A1
        }

        .speed {
            background-color: #FFE082
        }

        .char {
            font-size: 50px;
            font-weight: 700;
            color: #4bbe36 !important;
        }
    </style>
</body>
</html>

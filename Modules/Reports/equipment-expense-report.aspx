<%@ Page Language="C#" AutoEventWireup="true" CodeFile="equipment-expense-report.aspx.cs" Inherits="Modules_Report_equipment_expense_report" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>

<% 
    Session["top_menu"] = "report";
    Session["sub_menu"] = "equipment-expense-report";
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
    <title>Equipment Expense Report</title>
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/icheck/skins/all.css">
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">
    <div class="wrapper">

        <uc1:uch ID="uch1" runat="server" />
        <uc2:ucs ID="ucs1" runat="server" />

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content mt-20">
                <div class="box">
                    <div class="box-body">
                        <div class="row mb-10">
                            <div class="col-md-3">
                                <label>Voucher Date</label>
                                <input type='text' id="txtVoucherDate" class='form-control t enq-txtbx-pd  pull-right dtVoucherDate' />
                            </div>
                            <div class="col-md-3">
                                <label>Search</label>
                                <input type="text" id="txtSearch" class="form-control">
                                <span class="tblsearch-btn mt-25"><i class="ti-search"></i></span>
                            </div>
                            <div class="col-md-6 mt-25">
                                <button class="btn btn-success right fa fa-download" onclick="Export_To_Excel();"></button>
                            </div>
                        </div>
                        <div class="row mb-40">
                            <div class="col-md-12">
                                <table class="table table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Document Number</th>
                                            <th>Payment Date</th>
                                            <th>Account Code</th>
                                            <th>Account Name</th>
                                            <th>Amount</th>
                                            <th>Comments</th>
                                            <th>Equipment</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbody_Equipment_Expense_Report">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <script src="<%=G.S%>General/jquery.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/moment/min/moment.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>

    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
    <script src="<%=G.B%>assets/js/template.js"></script>
    <script src="<%=G.B%>assets/js/demo.js"></script>

    <script src="../General/libo.js" type="text/javascript"></script>

    <script src="equipment_expense_report.js"></script>
</body>
</html>

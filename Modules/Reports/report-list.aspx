<%@ Page Language="C#" AutoEventWireup="true" CodeFile="report-list.aspx.cs" Inherits="Modules_Reports_sales_report_list" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>

<%
    Session["top_menu"] = "report";
    Session["sub_menu"] = "sales-report-list";
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
    <title>SUS ERP - Sales Reports List</title>
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
    <style>
        #pagination a {
            display: inline-block;
            margin-right: 5px;
        }

        .skin-info-light #myUL li:hover {
            background-color: #2962ff;
            color: #fff;
        }

        .skin-warning #myUL li:hover {
            background-color: #36bea6;
            color: #fff;
        }

        .skin-primary #myUL li:hover {
            background-color: #0f204b;
            color: #fff;
        }

        .skin-black #myULli:hover {
            background-color: #02007c;
            color: #fff;
        }

        .show {
            display: block;
        }

        ul, #myUL {
            list-style-type: none;
        }

        #myUL {
            margin: 0;
            padding: 5px 8px;
            list-style-type: none;
        }



        [type=checkbox]:checked, [type=checkbox]:not(:checked) {
            position: unset;
            left: -9999px;
            margin-right: 5px;
            margin-left: 5px;
            opacity: 1 !important;
        }

        .fa-filter:after {
            content: "\f0b0" !important;
        }

        .fa-filter:before {
            content: "" !important;
        }

        [type=checkbox] + label:before, [type=checkbox]:not(.filled-in) + label:after {
            display: none;
        }

        [type=checkbox] + label {
            padding-left: 0px !important;
        }

        li a:hover {
            background: #2980B9;
        }

        .badge-cancel {
            background-color: #757d7c;
        }

            .badge-cancel[href]:focus, .badge-cancel[href]:hover {
                background-color: #757d7c;
            }

        .dropdown1 {
            box-shadow: 0 0 2px #777;
            display: none;
            left: 0;
            position: absolute;
            min-width: 170px;
        }

        .dropdown a {
            font-size: 10px;
            padding: 4px;
        }


        .dropdown1.is-open {
            display: block;
        }
    </style>

</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">

    <form id="frm" runat="server">

        <div class="wrapper">

            <uc1:uch ID="uch1" runat="server" />
            <uc2:ucs ID="ucs1" runat="server" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Main content -->
                <section class="content mt-20">
                    <div class="box" hidden  id="divViewAccess">
                        <div class="col-lg-12 col-12 text-center" >
                            <div class="box">
                                <div class="box-header with-border">
                                    <h1><i class="fa fa-ban font-size-100 text-danger"></i>
                                        <br />
                                        Access Denied</h1>
                                </div>
                            </div>
                        </div>
                        </div>
                    <div class="box" hidden  id="MianDiv">
                        <div class="box-header with-border flexbox align-items-center curr-head-margin ">
                            <div class="flexbox align-items-center">
                                <div class="lookup lookup-circle lookup-left">
                                    <h4 class="box-title">Report List</h4>
                                </div>
                            </div>

                        </div>

                        <div class="box-body ">
                            <div class="row">
                                <div class="col-md-3 col-sm-3">
                                    <label>Report Module</label>
                                    <select class="select2 form-control enq-dropdown" id="DdlReportModule" onchange="LoadReportList();">
                                    </select>
                                </div>
                                <div class="col-md-3 col-sm-3 mt-25">
                                    <input type="text" class="form-control  " id="txtSearch" placeholder="Search">
                                    <span class="tblsearch-btn"><i class="ti-search"></i></span>
                                </div>
                            </div>

                            <hr />



                            <div class="row mb-15">
                                <div class="col-md-12">

                                    <div>
                                        <input type="hidden" id="hdn_PageNo" value="0" />
                                        <table class="table  table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Sl No.</th>
                                                    <th>Report Name</th>
                                                    <th>Report Description</th>
                                                    <th>Report Module</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tblReportBody">
                                            </tbody>
                                        </table>
                                        <div id="tblFooter" class="mt-20">
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <!-- /.box-body -->
                        </div>

                    </div>
                    <!-- /.row -->
                </section>
                <!-- /.content -->
            </div>
            <!-- /.content-wrapper -->



            <%--<uc3:ucf ID="ucf1" runat="server" />--%>
        </div>
    </form>

    <!-- ./wrapper -->

    <!-- jQuery 3 -->
    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
    <script src="<%=G.B%>assets/js/template.js"></script>
    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>
    <script src="<%=G.B%>assets/js/demo.js"></script>
    <script src="../General/libo.js"></script>
    <script>
        function GenerateReport(Report_Name) {
           
            if (Report_Name == "EquipmentExpense") {
                window.location = "equipment-expense-report.aspx";
            }
            if (Report_Name == "ShiftAllocation") {
                window.location = "shift-allocation-report.aspx";
            }
            else if (Report_Name == "JobCosting") {
                window.location = "Job-Casting-Reprt.aspx";
            }
            else {
                window.location = "view-report.aspx?Report=" + Report_Name;

            }
        }
        $(document).ready(function () {
            //BindDdlReportModules();
            //LoadReportList();
            GetUserAccess();
        });
     //=======================Bind Ddl Report Module on Report List ==============================//

        function BindDdlReportModules() {
            $('#DdlReportModule').empty();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                dataType: "json",
                data: {
                    'fun': 'BindDdlReportModules',
                },
                success: function (data) {
                    $('#DdlReportModule').empty();
                    $('#DdlReportModule').append($('<option>').text("Select").attr('value', "0"));
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(data, function (i, obj) {
                            $('#DdlReportModule').append($('<option>').text(obj.Report_Module).attr('value', obj.Report_Module));
                        });
                        $('.select2').select2();
                    }
                }
            });
        }
       //=======================Load Report List Function ==============================//

        //=================txt Search Key Down Event =========================//
        $('#txtSearch').on('keyup', function () {

                SetVal("hdn_PageNo", "0");
                LoadReportList();
        }); 

        function LoadReportList() {
       
            $('#tblReportBody').empty();        
            var ReportModule = $('#DdlReportModule').val();
            var Page_No = $('#hdn_PageNo').val();
            var TextSearch = $('#txtSearch').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'LoadReportList', 'ReportModule': ReportModule, 'Page_No': Page_No, 'TextSearch': TextSearch
                },
                success: function (data) {
                    $('#tblReportBody').empty();
                    if (data.toString().trim() == '|') {
                        $('#tblReportBody').append('<tr> <td> No Record Found <td> </tr>');
                        $('#tblFooter').hide();
                    }
                    else {

                        $('#tblFooter').show();
                        var arr = data.split("|");
                        var tbldata = JSON.parse(arr[0]);
                        $.each(tbldata, function (i, obj) {
                           
                            var Param = obj.Report_Name.toString().trim().replace(/\s+/g, '');
                            Param = Param.replace(/[&]/g, '');
                            $('#tblReportBody').append("<tr> <td> " + (i + 1) + " </td> <td> " + obj.Report_Name + " </td> <td> " + obj.Report_Description + " </td> <td> " + obj.Report_Module + " </td> <td> <a href='#'  onclick =GenerateReport('" + Param + "')> View </a> </td> </tr>");

                        });
                        SetInnerVal("tblFooter", arr[1]);
                    }
                }
            });
        }

        function GetUserAccess() {
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'GetUserAccess',
                },
                success: function (data) {
                    
                    if (Chk_Res(data.errorMessage) == false) {
                        if (data.toString() == "true") {
                            
                            BindDdlReportModules();
                            LoadReportList();
                           
                            $('#divViewAccess').attr("hidden");
                            $('#MianDiv').removeAttr("hidden");
                        }
                        else {
                            $('#divViewAccess').removeAttr("hidden");
                            $('#MianDiv').attr("hidden");
                        }
                        
                    }
                }
            });
        }
     //=======================Pagination Page Function ==============================//
        function pageNo(pno) {
            SetVal("hdn_PageNo", pno);
            LoadReportList();
        }


    </script>


</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Job-Casting-Reprt.aspx.cs" Inherits="Modules_Reports_view_report" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%--<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>--%>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="<%=G.B%>assets/images/favicon.ico">
    <title>SUS ERP - View Report</title>
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
	<!-- Data Table-->
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/vendor_components/datatable/datatables.min.css" />
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.css">
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
    <style type="text/css" id="pageInit">
        /*.etat_header, .etat_content, .etat_footer {*/
            /*width: 20cm;*/
        /*}

        .fnt12 {
            font-size: 12px !important;
        }

        .table > tbody > tr > td {
            white-space: pre-wrap !important;
        }*/
         pl-8 {
            padding-left: 8px;
        }

        input {
            overflow: visible;
            width: -webkit-fill-available;
        }
        .pagination {
    margin-bottom: 0px;
}
      

        .sidebar-menu1 .menu-open > a > .fa-angle-right, .sidebar-menu1 .menu-open > a > div > span  > .pull-right-container > .fa-angle-right {
            -webkit-transform: rotate(270deg);
            -ms-transform: rotate(270deg);
            -o-transform: rotate(270deg);
            transform: rotate(270deg);
        }

        .fat {
            font-size: 15px;
            font-weight: 900;
            margin-top: 6px !important;
        }

        .sidebar-menu1 li > a {
            background: linear-gradient(#f5f0f0, #dcdcd2);
        }

        .skin-info-light .sidebar-menu1 > li:hover > a, .skin-info-light .sidebar-menu1 > li.active > a, .skin-info-light .sidebar-menu1 > li.menu-open > a {
            background: linear-gradient(#7499ff, #5a6da0);
        }

        .skin-warning .sidebar-menu1 > li:hover > a, .skin-warning .sidebar-menu1 > li.active > a, .skin-warning .sidebar-menu1 > li.menu-open > a {
            background: linear-gradient(#56cab5, #539c8f);
        }

        .skin-black .sidebar-menu1 > li:hover > a, .skin-black .sidebar-menu1 > li.active > a, .skin-black .sidebar-menu1 > li.menu-open > a {
            background: linear-gradient(#5a59aa, #34336b);
        }

        .skin-primary .sidebar-menu1 > li:hover > a, .skin-primary .sidebar-menu1 > li.active > a, .skin-primary .sidebar-menu1 > li.menu-open > a {
            background: linear-gradient(#636e8a, #33436b);
        }
        .colmd8{
            flex: 0 0 69% !important;
    max-width: 69% !important;
        }
        .colmd2{
            flex: 0 0 15% !important;
    max-width: 15% !important;
        }
        #loader
        {
            
             border :8px solid silver;
             border-top:8px solid #7499ff ;
             border-radius:50%;
             width :40px;
             height:40px;
             animation : spin 700ms linear infinite;
             top:300px;
             left :45%;
             position:absolute;
             z-index: 10;
        }
        @keyframes spin
        {
            0%{
                transform :rotate(0deg);
            }
               100%{
                transform :rotate(360deg);
            }
        }
    </style>


</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">
    <div class="wrapper">
        <uc1:uch ID="uch1" runat="server" />

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper" style="margin-left: 0px !important">
            <!-- Main content -->
            <div class="row" id="loader"  hidden="hidden">   </div>
            <section class="content mt-20">
                <div class="box">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-md-12">

                                <table style="width: 100%;">
                                    <tr>
                                        <td width="5%">
                                            <button id="btnback" class="btn btn-success" onclick="javascript:window.location ='report-list.aspx';">Back</button>

                                        </td>
                                        <td width="15%" style="display: none" id="txtincReport">
                                            <div class="pl-5">
                                                <select id="DDL_Division" class="form-control select2 enq-dropdown" style="width: 150px">
                                                    <option value="129">TRANSPORT</option>
                                                    <option value="253">FREIGHT</option>
                                                </select>
                                            </div>
                                        </td>
                                        <td width="15%" id="txtnonincReport">
                                            <input type="text" id="txtSearchSo" class="form-control" value="" placeholder="Search">
                                            <select id="DDL_AssetCategory" class="form-control select2 enq-dropdown" style="display: none; width: 150px">
                                            </select>
                                            <span class="tblsearch-btn"></span></td>
                                        <td><i class="mdi mdi-information-outline"></i></td>
                                        <td width="25%"  id="txtCalenderSearch1">
                                            <div class="pl-5">
                                                <input type='text' id="txtDateFrom" class='form-control t enq-txtbx-pd  pull-right dtleave' />
                                                <input type='date' id="id=txtDateTo" class='form-control enq-txtbx-pd  hide pull-right dtfull' />

                                            </div>
                                            

                                        </td>
										<td width="12%" style="display: none" id="txtAssetReport1">
                                            <div class="pl-5">
                                                <input type='date' id="fromDate" class='form-control' />
                                            </div>


                                        </td>
                                        <td width="13%" style="display: none" id="txtAssetReport2">
                                            <div class="pl-5">
                                                <input type='date' id="todate" class='form-control' />
                                            </div>
                                        </td>
									   <td width="13%" style="display: none;" id="txtAssetReport3">
                                           <div class="row" style="margin-left:5px;">
                                               As Of <div class="pl-12">
                                                     <input type='date' id="asOfdate" class='form-control' />
                                                </div>
                                           </div> 
                                        </td>
                                        <td><button class="btn btn-success"   id="BtnCalenderSearch1">Search</button></td>

                                        <td width="20%">
                                            <h3 id="title" style="text-align: center"><b>Report</b> </h3>
                                            </></td>

                                        <td width="30%">
                                            <button id="BtnGenerate" class="btn btn-success right">Export To Excel</button></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                
                                    
                                    <div class="tableFixHead" style="display:none" id="divJobcost">
                                         <table class="table table-bordered " style="display:none"  id="tblJobcost">
                                        <thead>
                                            <tr>
                                                
                                               <tr>
                                            <%--      <th width="2%">
                                                <input type="checkbox" id="Chk_all"><label for="Chk_all"></label></th>--%>
                                            <th width="10%">Post Date</th>
                                            <th width="30%">Account Name</th>
                                            <th width="28%">Expense Code</th>
                                            <th width="15%">Job Number</th>
                                            <th width="15%">Job Cost</th>
                                        </tr>
                      
                                       </tr>
                                            </thead>
                                             <tbody>
                                                 <tr>
                                                <td colspan="5" class="p-0">
                                                <ul class="tree sidebar-menu1 pt-0" data-widget="tree" id="tblBodyJobcost">
                                                    
                                                </ul>
                                            </td>
                                        </tr>
                                             </tbody>
                                            
                                    </table>
                                            </div>
                                       
                                 
                            </div>
                        </div>
                        <div class="box-footer mb-40">
                        </div>
                    </div>
                </div>

            </section>

    </div>
        </div>
        


    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- This is data table -->
    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery.dataTables.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/moment/min/moment.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="../General/libo.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="<%=G.B%>assets/js/template.js"></script>
    <script src="<%=G.B%>assets/js/demo.js"></script>

    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const Report = urlParams.get('Report');
        var IsDateSearch = 0;
		var today = new Date();
        var mm = (today.getMonth() + 1) + ""
        var dd = today.getDate() + "";
        var date = today.getFullYear() + '-' + (mm.length == 1 ? '0' + mm : mm) + '-' + (dd.length == 1 ? '0' + dd : dd);
        $(document).ready(function () {
			$('#fromDate').val(date);
            $('#todate').val(date);
           // ShowJobCosting();
            $('#title').text('Job Costing Report').css('font-size', '20px');
           
          
        });


        //=======================================Show Date Picker Control In Trial Balance Report==================/
        function ShowControls() {
            $('#txtCalenderSearch1').show();
            $('#txtCalenderSearch1').show();
        }


        //========================================Serach Functionality==============================================//

        $('#txtSearchSo').on('keyup', function () {
            
           
                ShowJobCosting();
          
        });

        //==============================================================================Format date Function=======================================================================//
        function FormatDate(curr_date) {
            if (curr_date < 10) {
                curr_date = "0" + curr_date
            }
            return curr_date;
        }
		
		
        //=======================Date Range apply Click Handler==============================//

        $('#BtnCalenderSearch1').on('click', function () {
            IsDateSearch = 1;
           
            ShowJobCosting();
        });
		
        //=======================Export To Excel Click Handler==============================//

        $('#BtnGenerate').on('click', function () {
           
                 ExportJobCosting(); 


        });
		
		
        $(document).ready(function () {
            $('.dtleave').daterangepicker();
        });
        function ShowJobCosting() {
            //$('#tbodyConsolidatedPl').empty();
           // alert('')
            var date = $('#txtDateFrom').val();
            $('#divJobcost').show();
            $('#tblJobcost').show();
            
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowJobCosting', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                   
                    if (Chk_Res(data.errorMessage) == false) {
                        //alert(data)
                        if (data != "") {
                            $('#tblBodyJobcost').empty();
                            SetInnerVal("tblBodyJobcost", data);
                        }
                    }
                }
            });
        }
        function BindJobCostDetails(id,index) {
            var Revenue = $('#Rev_' + index).html();  
            Revenue = Revenue.replace("Revenue:", "");
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: { 'fun': 'BindJobCostDetails', 'id': id },
                success: function (data) {
                    // alert(data);
                    if (Chk_Res(data.errorMessage) == false) {

                        SetInnerVal("tblInnJobCost_" + index, data.split("|")[0]);
                        var profit = parseFloat(Revenue) - parseFloat(data.split("|")[1])
                        SetInnerVal("Pro_" + index, "Profit:  "+parseFloat(profit))
                       
                    }
                }
            });


        }
        function ExportJobCosting() {
            $('#loader').prop("hidden", false);
            var SearchString = $('#txtSearchSo').val();
            var date = $('#txtDateFrom').val();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'EportJobCasting', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            $('#loader').prop("hidden", true);
                            window.open("Downloaded_Reports/" + data);
                        }
                    }
                }

            });

        }
        
    </script>
</body>
</html>

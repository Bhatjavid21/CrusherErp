<%@ Page Language="C#" AutoEventWireup="true" CodeFile="view-report.aspx.cs" Inherits="Modules_Reports_view_report" %>

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
        .etat_header, .etat_content, .etat_footer {
            /*width: 20cm;*/
        }

        .fnt12 {
            font-size: 12px !important;
        }

        .table > tbody > tr > td {
            white-space: pre-wrap !important;
        }
    </style>


</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">
    <div class="wrapper">
        <uc1:uch ID="uch1" runat="server" />

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper" style="margin-left: 0px !important">
            <!-- Main content -->
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
                                        <td width="25%" style="display: none" id="txtCalenderSearch">
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
                                        <td><button class="btn btn-success"  style="display: none" id="btncalenderSearch">Search</button></td>

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
                                <div class="tableFixHead1">
                                    <table class="table table-bordered table-striped " id="tblSOReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th>Sales Order Date</th>
                                                <th>Sales Order Number</th>
                                                <th>Sales Order (SO) created by</th>
                                                <th>Division</th>
                                                <th>Customer Name</th>
                                                <th>Customer PO Number</th>
                                                <th>Customer PO Date</th>
                                                <th>Customer Line Item No.</th>
                                                <th>Material Item Code</th>
                                                <th>Material Description	</th>
                                                <th>Unit of Measure (UoM)</th>
                                                <th>Quantity</th>
                                                <th>Customer Unit Price</th>
                                                <th>Customer Total Price</th>
                                                <th>Customer Currency</th>
                                                <th>Customer Scheduled  Delivery Date</th>
                                                <th>Customer Actual Delivery Date</th>
                                                <th>Customer Order Status (OPEN/CLOSE)</th>
                                                <th>Delivery to Customer (On Time / Delayed by ____ Days)
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblSOReportBody">
                                        </tbody>
                                    </table>
									
									<table class="table table-bordered table-striped " id="tblAssetRegisterReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th>Asset Code</th>
                                                <th>Description</th>
                                                <th>QTY</th>
                                                <th>DD/MM/YYYY</th>
                                                <th>Location</th>
                                                <th>Total Cost</th>
                                                <th>Depreciation</th>
                                                <th>End Of Last Year</th>
                                                <th>Depreciation Current Month</th>
                                                <th>YTD</th>
                                                <th>Total</th>
                                                <th>Book Value</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblAssetRegisterReportBody">
                                        </tbody>
                                    </table>
									
									<table class="table table-bordered table-striped " id="tblAssetRegisterNestedReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>Account Name</th>
                                                <th>Account Code</th>
                                                <th>Balance</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblAssetRegisterReportNestedBody">
                                        </tbody>
                                    </table>
                                    
                                    <table class="table table-bordered table-striped " id="tblTrackingReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th>SO No.</th>
                                                <th>SO Date</th>
                                                <th>Customer Name</th>
                                                <th>Division</th>
                                                <th>Salesman Name</th>
                                                <th>PO No.</th>
                                                <th>PO Date</th>
                                                <th>Vendor Name</th>
                                                <th>MRN No.</th>
                                                <th>MRN Date</th>
                                                <th>DN No.</th>
                                                <th>DN Date	</th>
                                                <th>GRN No. </th>
                                                <th>GRN Date</th>
                                               <%-- <th>RT No.</th>
                                                <th>RT Date</th>--%>
                                                <th>AEGG Invoice No.</th>
                                                <th>AEGG Invoice Date
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodyTrackingReport">
                                        </tbody>
                                    </table>

                                    <table class="table table-bordered table-striped " id="tblReturnMaterialReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th>S.NO</th>
                                                <th>CUSTOMER	</th>
                                                <th>RCVD D</th>
                                                <th>DN NO</th>
                                                <th>PO NO	</th>
                                                <th>DESCRIPTION</th>
                                                <th>QTY	</th>
                                                <th>LINE NO	</th>
                                                <th>REASON</th>
                                                <th>STATUS	</th>
                                                <th>DRIVER	</th>
                                                <th>IPO</th>
                                                <th>BUYER</th>
                                                <th>STATUS</th>
                                                <th>IPO value</th>
                                                <th>Sales Value</th>
                                                <th>Responsibility</th>
                                                <th>Remarks
                                                </th>
                                            </tr>
                                            <tbody id="tbodyReturnMaterialReport"></tbody>
                                    </table>

                                    <table class="table table-bordered table-striped" id="tblPOReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th>PO Number</th>
                                                <th>PO Date</th>
                                                <th>Vendor Name	</th>
                                                <th>Purchase Type (Local/ Overseas)	</th>
                                                <th>PO Line Item No.</th>
                                                <th>Item Code</th>
                                                <th>Unit Price	</th>
                                                <th>Total Price</th>
                                                <th>Currency</th>
                                                <th>Delivery Note (DN) Number</th>
                                                <th>DN Date	</th>
                                                <th>Scheduled Delivery Date</th>
                                                <th>Actual Delivery Date</th>
                                                <th>PO Status (Open/Close)</th>
                                                <th>Delivery Time Status (On Time / Delayed by ____ Days)	</th>
                                                <th>SO Number</th>

                                            </tr>
                                            <tbody id="tblPOReportBody"></tbody>
                                    </table>

                                    <table class="table table-bordered table-striped " id="tblMrnReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th>MRN Number</th>
                                                <th>MRN Date	</th>
                                                <th>Vendor Name</th>
                                                <th>AEGG PO Number	</th>
                                                <th>AEGG PO Date</th>
                                                <th>Material Description	</th>
                                                <th>Material Item Code</th>
                                                <th>UoM</th>
                                                <th>Qty</th>
                                                <th>Vendor DN No. </th>
                                                <th>Vendor Invoice No. </th>
                                                <th>Vendor Delivery Date</th>
                                                <th>SO Number	</th>
                                                <th>SO Date</th>

                                            </tr>
                                            <tbody id="tblMrnReportBody"></tbody>
                                    </table>

                                    <table class="table table-bordered table-striped " id="tblDNReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th>DN Number</th>
                                                <th>DN Date</th>
                                                <th>Customer Name</th>
                                                <th>Customer PO Number	</th>
                                                <th>Customer PO Date</th>
                                                <th>Delivered By (Driver Name)</th>
                                                <th>Accepted / Returned</th>
                                                <th>Reason for Return</th>
                                                <th>GRN Number</th>
                                                <th>GRN Date</th>
                                                <th>SO Number</th>


                                            </tr>
                                            <tbody id="tblDNReportBody"></tbody>
                                    </table>

                                    <table class="table table-bordered table-striped " id="tblOverseaShipmentReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th>Sl. No.</th>
                                                <th>PO Number	</th>
                                                <th>Division</th>
                                                <th>Supplier</th>
                                                <th>Material Description	</th>
                                                <th>Origin </th>
                                                <th>BL No.	</th>
                                                <th>Port of Arrival</th>
                                                <th>Mode of Shipment	</th>
                                                <th>Document Status</th>
                                                <th>ETD</th>
                                                <th>ETA</th>
                                                <th>Status</th>
                                                <th>Clearing Agent/ Broker</th>
                                                <th>OPEN/CLOSED</th>
                                                <th>Bayan No.</th>
                                                <th>REMARKS</th>

                                            </tr>
                                            <tbody id="tbodyOverseaShipmentReport"></tbody>
                                    </table>

                                    <table class="table table-bordered table-striped " id="tblSalesRectificationReport" style="display: none">
                                        <thead>
                                            <tr>
                                                <th>Customer</th>
                                                <th>Salesman</th>
                                                <th>Buyer Name</th>
                                                <th>Customer RFQ</th>
                                                <th>Closing Date</th>
                                                <th>AEGG Enquiry</th>
                                                <th>AEGG Quote</th>
                                                <th>Customer PO</th>
                                                <th>PO Value</th>
                                                <th>SO</th>
                                                <th>SO Value</th>


                                            </tr>
                                            <tbody id="tbodySalesRectificationReport"></tbody>
                                    </table>
                                    <table class="table table-bordered table-striped " id="tbltrialbalance" style="display: none">
                                        <thead>
                                            <tr>
                                                <th style="display:none;">Tr Id</th>
                                                <th>Account Code</th>
                                                <th>Account Group Name</th>
                                                <th>Account Name</th>
                                                <th>Opening Balance </th>
                                                <th>Debit</th>
                                                <th>Credits</th>
                                               <th>Closing Balance</th>
                                                

                                            </tr>
                                            <tbody id="tbodytrialbalance"></tbody>
                                    </table>
                                    <table class="table table-bordered table-striped " style="display: none" id="tblAgingAnalysis" >
                                        <thead>
                                            <tr>
                                                
                                                <th>Account Code</th>
                                                <th>Customer Name</th>
                                                <th>Closing Balance Balance</th>
                                                <th>[0-30]</th>
                                                <th>[31-60]</th>
                                                <th>[61-90]</th>
                                                <th>[91-120]</th>
                                                <th>[121-180]</th>
                                                <th>Above 180</th>

                                            </tr>
                                            <tbody id="tbodyAgingAnalysis"></tbody>
                                    </table>
                                     <table class="table table-bordered table-striped " style="display:none" id="tblSupAgingAnalysis" >
                                        <thead>
                                            <tr>
                                                
                                                <th>Account Code</th>
                                                <th>Supplier Name</th>
                                                <th>Closing Balance Balance</th>
                                                <th>[0-30]</th>
                                                <th>[31-60]</th>
                                                <th>[61-90]</th>
                                                <th>[91-120]</th>
                                                <th>[121-180]</th>
                                                <th>Above 180</th>

                                            </tr>
                                            <tbody id="tbodySupAgingAnalysis"></tbody>
                                    </table>
                                  
                                            <div class="tableFixHead" style="display:none"  id="DivEmployeeAdvances">
                                         <table class="table table-bordered table-striped " style="display:none"  id="tblEmployeeAdvances"  >
                                        <thead>
                                            <tr>
                                                
                                                <th>Account Code</th>
                                                <th>Employee Name</th>
                                                <th>Debit</th>
                                                <th>Credit</th>
                                                <th>Balance</th>
                                                <th>Narration</th>
                      
                                       </tr>
                                            </thead>
                                            <tbody id="tbodyEmployeeAdvances"></tbody>
                                    </table>
                                       </div>
                                    <div class="tableFixHead" style="display:none" id="DivConsolidatedPl">
                                         <table class="table table-bordered table-striped" style="display:none"  id="tblConsolidatedPl">
                                        <thead>
                                            <tr>
                                                
                                                <th>S.No.</th>
                                                <th>PL Descpriction</th>
                                                <th>JAN</th>
                                                <th>FAB</th>
                                                <th>MAR</th>
                                                <th>APR</th>
                                                <th>MAY</th>
                                                <th>JUN</th>
                                                <th>JULY</th>
                                                <th>AUG</th>
                                                <th>SEPT</th>
                                                <th>OCT</th>
                                                <th>NOV</th>
                                                <th>DEC</th>
                                                <th>TOTAL</th>
                      
                                       </tr>
                                            </thead>
                                            
                                    </table>
                                            </div>

                                 <div class="tableFixHead" style="display:none"  id="DivEmployeeGraduity">
                                         <table class="table table-bordered table-striped " style="display:none"  id="tblEmployeeGraduity"  >
                                       
                                             <thead>
                                                 <%--<tr>
                                                   <th colspan="6"></th>
                                                     <th colspan="5">Accrued Liablity Leave</th>
                                                     <th colspan="5">Accrued Liablity Gratuity</th>
                                                 </tr>--%>
                                            <tr>
                                                
                                                <th>Employee No</th>
                                                <th>Employee Name</th>
                                                <th>Date Of Joining </th>
                                                <th>Prev Leave Start</th>
                                                <th>Basic Salary</th>
                                                <th>Others</th>
                                                <th id="hdr_Opn_bal1">Opening Bal </th>
                                                <th>Accrued For the</th>
                                                <th>Leave Payment</th>
                                                <th>Leave Bal</th>
                                                <th>Leave Bal Days</th>
                                                <th id="hdr_Opn_bal2">Opening Bal</th>
                                                <th>Accrued For the</th>
                                                <th>Gratuity Payment</th>
                                                <th>Gratuity Bal</th>
                                                <th>Gratuity Bal Days</th>
                                                
                      
                                       </tr>
                                            </thead>
                                            <tbody id="tbodyEmployeeGraduity"></tbody>
                                    </table>
                                   </div>
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
            $('#tblAgingAnalysis').hide();
            $('#DDL_AssetCategory').hide();
            switch (Report) {
                 
                case "SalesOrder": ShowSOReport(); break;
                case "PurchaseOrder": ShowPOReport(); break;
                case "DeliveryNote": ShowDNReport(); break;
                case "MRN": ShowMrnReport(); break;
                case "TrialBalance": ShowControls(); $('#tbltrialbalance').show(); break;
                case "TrackingReport": ShowTrackingReport(); break;
                case "CustomerAgingAnalysis": ShowControls(); $('#tblAgingAnalysis').show(); break;
                case "SupplierAgingAnalysis": ShowControls(); $('#tblSupAgingAnalysis').show(); break;
				case "AssetRegister": ShowAssetRegisterReport(); break;
                case "PLReport": ShowIncomeAccountReport(); break;
                case "EmployeeAdvances": ShowEmpolyeeAdvancesReport(); break; 
                case "ConsolidatedPLReport": ShowConsolidatedPl(); break;  
                case "LeaveGraduity": LeaveGraduity(); break;  
            }
        });


        //=======================================Show Date Picker Control In Trial Balance Report==================/
        function ShowControls() {
            $('#txtCalenderSearch').show();
            $('#btncalenderSearch').show();
        }


        //========================================Serach Functionality==============================================//

        $('#txtSearchSo').on('keyup', function () {
            
            switch (Report) {
                case "SalesOrder": ShowSOReport(); break;
                case "PurchaseOrder": ShowPOReport(); break;
                case "DeliveryNote": ShowDNReport(); break;
                case "MRN": ShowMrnReport(); break;
                case "TrialBalance": ShowTrialBalanceReport(); break;
                case "TrackingReport": ShowTrackingReport(); break;
                case "CustomerAgingAnalysis": AgingAnalysis(); break;
                case "SupplierAgingAnalysis": SupAgingAnalysis(); break;
                case "EmployeeAdvances": ShowEmpolyeeAdvancesReport(); break;
                case "EmployeeAdvances": EmployeeAdvancesExport();
                case "LeaveGraduity": LeaveGraduity(); break;  
            }
        });

        //==============================================================================Format date Function=======================================================================//
        function FormatDate(curr_date) {
            if (curr_date < 10) {
                curr_date = "0" + curr_date
            }
            return curr_date;
        }
		
		
        //=======================Date Range apply Click Handler==============================//

        $('#btncalenderSearch').on('click', function () {
            switch (Report) {
                case "AssetRegister": ShowAssetRegisterReport(); break;
				case "PLReport": ShowIncomeAccountReport(); break;
            }

        });
		
        //=======================Export To Excel Click Handler==============================//

        $('#BtnGenerate').on('click', function () {
            switch (Report) {
                case "SalesOrder": SOGenerateExcel(); break;
                case "PurchaseOrder": POGenerateExcel(); break;
                case "MRN": MRNGenerateExcel(); break;
                case "DeliveryNote": DNGenerateExcel(); break;
                case "TrialBalance": TrialBalanceGenerateExcel(); break; 
                case "TrackingReport": TrackingReportExportToExcel(); break;
                case "CustomerAgingAnalysis": AgingAnalysisExportToExcel(); break;
                case "SupplierAgingAnalysis": SupAgingAnalysisExportToExcel(); break;
				case "AssetRegister": AssetRegisterReportExportToExcel(); break;
                case "PLReport": PLReportExport(); break;
                case "EmployeeAdvances": EmployeeAdvancesExport();
                case "ConsolidatedPLReport": ExportConsolidatedPl(); break; 
                case "LeaveGraduity": EportLeaveGraduity(); break; 

            }

        });
		
		function PLReportExport() {

            var division_id = $('#DDL_Division').val();
            var fromDate = $('#fromDate').val();
            var toDate = $('#todate').val();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'PandLReportExport', 'fromDate': fromDate, 'toDate': toDate, 'division_id': division_id
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }

                }
            });
        }

        function EmployeeAdvancesExport() {
            var SearchString = $('#txtSearchSo').val();
            var date = $('#txtDateFrom').val();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'EmployeeAdvancesExportToExcel', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        // alert(data)
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }
                }

            });
        }
		function ShowIncomeAccountReport() {

            $('#tblAssetRegisterReportNestedBody').empty();
            var division_id = $('#DDL_Division').val();
            var fromDate = $('#fromDate').val();
            var toDate = $('#todate').val();

            $('#tblAssetRegisterNestedReport').show();
            $('#txtAssetReport1').show();
            $('#txtAssetReport2').show();
            $('#txtnonincReport').hide();
            $('#txtincReport').show();
            $('#txtSearchSo').hide();
            $('#btncalenderSearch').show();
            $('#title').text('P&L Report ').css('font-size', '20px')
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowIncomeAccountReport', 'division_id': division_id, 'fromDate': fromDate, 'toDate': toDate
                },
                success: function (data) {
                    $('#tblAssetRegisterReportNestedBody').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(JSON.parse(data), function (i, obj) {
                            var bal = parseFloat(obj.total_credit == "" || obj.total_credit == null ? "0" : obj.total_credit) - parseFloat(obj.total_debit == "" || obj.total_debit == null ? "0" : obj.total_debit);
                            $('#tblAssetRegisterReportNestedBody').append("<tr id='" + obj.Account_Code + "'>"
                                + "<td> <a href='#' onclick=ViewItemsForAccount('" + obj.Account_Code + "')> <span><i class='ti-plus'></i></span> </td>"
                                + "<td> " + obj.Ledger_Account_Name + " </td>"
                                + "<td> " + obj.Account_Code + "</td>"
                                + "<td> " + Math.abs(bal) + "</td>"
                                + "</tr>");
                        });
                    }
                }
            });
        }
		
		function ViewItemsForAccount(rowId) {
            // $('.' + code).toggle();
            //$("." + code).slideDown();
            if ($('#' + rowId+' >td > a > span > i').hasClass('ti-minus')) {
                $('#' + rowId + ' >td > a > span > i').removeClass('ti-minus').addClass('ti-plus');
                $('#row' + rowId).remove();
            } else {
                $('#' + rowId + ' >td > a > span > i').removeClass('ti-plus').addClass('ti-minus');
                var tblRows = "";
                var category = $('#DDL_AssetCategory').val();
                var fromDate = $('#fromDate').val();
                var toDate = $('#todate').val();
                $.ajax({
                    url: 'reports.ashx',
                    type: "POST",
                    data: {
                        'fun': 'ShowIncomeAccountReportSubItem', 'Account_code': rowId, 'fromDate': fromDate, 'toDate': toDate
                    },
                    success: function (data) {
                        if (Chk_Res(data.errorMessage) == false) {
                            $.each(JSON.parse(data), function (i, obj) {

                                tblRows += "<tr>"
                                    + "<td>" + obj.Posted_Date1 + "</td>"
                                    + "<td> " + obj.Entry_Type + " </td>"
                                    + "<td> " + obj.Narration + "</td>"
                                    + "<td> " + obj.Debit + "</td>"
                                    + "<td> " + obj.Credit + "</td>"
                                    + "</tr>";
                            });

                            $('#' + rowId).after("<tr id='row" + rowId + "'>"
                                + "<td></td>"
                                + "<td colspan='3'> " + "<table id='" + "test" + rowId + "' class='table table-bordered table-striped'><thead>" +
                                '<tr><th>Date</th><th>Entry Type</th><th>Narration</th><th>Debit</th><th>Credits</th></tr>' +
                                '<tbody>' + tblRows + '</tbody>' +
                                '</table></td>'
                                + "</tr>");

                            $('#test' + rowId).DataTable();
                        }
                    }
                });


            }

        }

		
		BindDdlAssetCategory();
		function BindDdlAssetCategory() {
            $('#DdlReportModule').empty();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                dataType: "json",
                data: {
                    'fun': 'BindDdlAssetCategory',
                },
                success: function (data) {
                    $('#DDL_AssetCategory').empty();
                    $('#DDL_AssetCategory').append($('<option>').text("Select").attr('value', "0"));
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(data, function (i, obj) {
                            $('#DDL_AssetCategory').append($('<option>').text(obj.Name).attr('value', obj.Name));
                        });
                        //$('.select2').select2();
                    }
                }
            });
        }
		
		//=======================Display Asset Register Report List ==============================//
        function ShowAssetRegisterReport() {
			
            $('#tblAssetRegisterReportBody').empty();
            var category = $('#DDL_AssetCategory').val();
            var fromDate = $('#fromDate').val();
            var toDate = $('#todate').val();
			var asoFDate = $('#asOfdate').val();


            $('#tblAssetRegisterReport').show();
            $('#txtAssetReport1').show();
            $('#txtAssetReport2').show();
			$('#txtAssetReport3').show();
            
            $('#DDL_AssetCategory').show();
            $('#txtSearchSo').hide();
            $('#btncalenderSearch').show();
            $('#title').text('Asset Register Report ').css('font-size', '20px')
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowAssetRegisterReport', 'category': category, 'fromDate': fromDate, 'toDate': toDate, 'asOf': asoFDate
                },
                success: function (data) {
                    $('#tblAssetRegisterReportBody').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(JSON.parse(data), function (i, obj) {

                            $('#tblAssetRegisterReportBody').append("<tr>"
                                + "<td> " + obj.Asset_Code + " </td>"
                                + "<td> " + obj.Description + "</td>"
                                + "<td> " + obj.QTY + "</td>"
                                + "<td> " + obj.DDMMYYYY + " </td>"
                                + "<td> " + obj.Location + "</td>"
                                + "<td> " + obj.totalcost + "</td>"
                                + "<td> " + obj.Depreciation + " </td>"
                                + "<td> " + obj.EndOfLastYear + " </td>"
                                + "<td> " + obj.DepreciationCurrentMonth + " </td>"
                                + "<td> " + obj.YTD + " </td>"
                                + "<td> " + obj.Total + " </td>"
                                + "<td> " + obj.BookValue + " </td>"
                                + "</tr>");
                        });
                    }
                }
            });
        }
		
        //=======================Display Sales Order Report List ==============================//
        function ShowSOReport() { 
            $('#tblSOReportBody').empty();
            var SearchString = $('#txtSearchSo').val();
            $('#tblSOReport').show();
           
            $('#title').text('Sales Order Report ').css('font-size', '20px')
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowSOReport', 'SearchString': SearchString
                },
                success: function (data) {
                    $('#tblSOReportBody').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(JSON.parse(data), function (i, obj) {
                           // alert(obj.so_date)
                            var FormatedSODate = new Date(obj.SO_Date);
                            var month = FormatDate(FormatedSODate.getMonth() + 1)   //Months are zero based
                            var year = FormatedSODate.getFullYear();
                            var date = FormatDate(FormatedSODate.getDate());
                            FormatedSODate = (date + "-" + month + "-" + year);

                            var FormatedPODate = new Date(obj.PO_Date);
                            var month = FormatDate(FormatedPODate.getMonth() + 1)   //Months are zero based
                            var year = FormatedPODate.getFullYear();
                            var date = FormatDate(FormatedPODate.getDate());
                            FormatedPODate = (date + "-" + month + "-" + year);

                            var FormatedCSDate = new Date(obj.Delivery_Date);
                            var month = FormatDate(FormatedCSDate.getMonth() + 1)   //Months are zero based
                            var year = FormatedCSDate.getFullYear();
                            var date = FormatDate(FormatedCSDate.getDate());
                            FormatedCSDate = (date + "-" + month + "-" + year);

                            var FormatedActualDate = "Not Delivered"
                            if (!obj.Actual_Delivery_Date.toString().includes("1900")) {
                                FormatedActualDate = new Date(obj.Actual_Delivery_Date);
                                var month = FormatDate(FormatedActualDate.getMonth() + 1)   //Months are zero based
                                var year = FormatedActualDate.getFullYear();
                                var date = FormatDate(FormatedActualDate.getDate());
                                FormatedActualDate = (date + "-" + month + "-" + year);

                                
                            }


                            $('#tblSOReportBody').append("<tr>"
                                + "<td> " + FormatedSODate + " </td>"
                                + "<td> " + obj.Sales_Order_Number + "</td>"
                                + "<td> " + obj.employee_name + "</td>"
                                + "<td> " + obj.Division_Name + "</td>"
                                + "<td> " + obj.Cus_Company_Name + "</td>"
                                + "<td> " + obj.Customer_PO_Ref + "</td>"
                                + "<td>" + FormatedPODate + " </td>"
                                + "<td> " + obj.Item_Line_Number + " </td>"
                                + "<td> " + obj.ITEM_CODE + " </td>"
                                + "<td>" + obj.Description + " </td>"
                                + "<td> " + obj.UNIT + " </td>"
                                + "<td> " + obj.Quantity + "</td>"
                                + "<td> " + obj.Sales_Price_Per_Unit_After_Margin + " </td>"
                                + "<td> " + obj.total_price + " </td>"
                                + "<td> " + obj.Currency_Name + " </td>"
                                + "<td>" + FormatedCSDate + "  </td>"
                                + "<td> " + FormatedActualDate + " </td>"
                                + "<td> " + obj.Delivery_Status + " </td>"
                                + "<td> " + obj.Delaydays + "</td>"


                                + "</tr>");
                        });
                    }
                }
            });
        }
        //=======================Display Purchase Order Report List ==============================//
        function ShowPOReport() {
            $('#tblPOReport').show();
            $('#tblPOReportBody').empty();
            $('#title').text('Purchase Order Report').css('font-size', '20px');
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowPOReport', 'SearchString': SearchString
                },
                success: function (data) {
                    $('#tblPOReportBody').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(JSON.parse(data), function (i, obj) {

                            var FormatedPODate = new Date(obj.po_date);
                            var month = FormatDate(FormatedPODate.getMonth() + 1)   //Months are zero based
                            var year = FormatedPODate.getFullYear();
                            var date = FormatDate(FormatedPODate.getDate());
                            FormatedPODate = (date + "-" + month + "-" + year);

                            var FormatedDeliveryDate = new Date(obj.Delivery_Date);
                            var month = FormatDate(FormatedDeliveryDate.getMonth() + 1)   //Months are zero based
                            var year = FormatedDeliveryDate.getFullYear();
                            var date = FormatDate(FormatedDeliveryDate.getDate());
                            FormatedDeliveryDate = (date + "-" + month + "-" + year);

                            var FormatedMrnDate = new Date(obj.MRN_Date);
                            var month = FormatDate(FormatedMrnDate.getMonth() + 1)   //Months are zero based
                            var year = FormatedMrnDate.getFullYear();
                            var date = FormatDate(FormatedMrnDate.getDate());
                            FormatedMrnDate = (date + "-" + month + "-" + year);

                            $('#tblPOReportBody').append("<tr>"
                                + "<td> " + obj.PO_Number + " </td>"
                                + "<td> " + FormatedPODate + "</td>"
                                + "<td> " + obj.supplier_name + "</td>"
                                + "<td>  " + obj.PO_Type + " </td>"
                                + "<td> " + obj.Line_Item_Number + "</td>"
                                + "<td> " + obj.item_code + "</td>"
                                + "<td>" + obj.unit_cost + " </td>"
                                + "<td> " + obj.Total_Amount + " </td>"
                                + "<td> " + obj.Currency_Name + " </td>"
                                + "<td> " + obj.supplier_dn_no + " </td>"
                                + "<td>  </td>"
                                + "<td>  " + FormatedDeliveryDate + " </td>"
                                + "<td> " + FormatedMrnDate + " </td>"
                                + "<td> " + obj.PO_Status + " </td>"
                                + "<td> " + obj.Delay_days + " </td>"
                                + "<td>  " + obj.Sales_Order_Number + "</td>"
                                + "</tr>");
                        });
                    }
                }
            });
        }

        //=======================Display Mrn  Report List ==============================//
        function ShowMrnReport() {
            $('#tblMrnReport').show();
            $('#title').text('MRN Report').css('font-size', '20px')
            $('#tblMrnReportBody').empty();
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowMrnReport', 'SearchString': SearchString
                },
                success: function (data) {
                    $('#tblMrnReportBody').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(JSON.parse(data), function (i, obj) {
                            var FormatedMrnDate = new Date(obj.MRN_DATE);
                            var month = FormatDate(FormatedMrnDate.getMonth() + 1)   //Months are zero based
                            var year = FormatedMrnDate.getFullYear();
                            var date = FormatDate(FormatedMrnDate.getDate());
                            FormatedMrnDate = (date + "-" + month + "-" + year);

                            var FormatedPODate = new Date(obj.PO_Date);
                            var month = FormatDate(FormatedPODate.getMonth() + 1)   //Months are zero based
                            var year = FormatedPODate.getFullYear();
                            var date = FormatDate(FormatedPODate.getDate());
                            FormatedPODate = (date + "-" + month + "-" + year);

                            var FormatedDeliveryDate = new Date(obj.vendor_date);
                            var month = FormatDate(FormatedDeliveryDate.getMonth() + 1)   //Months are zero based
                            var year = FormatedDeliveryDate.getFullYear();
                            var date = FormatDate(FormatedDeliveryDate.getDate());
                            FormatedDeliveryDate = (date + "-" + month + "-" + year);

                            var FormatedSoDate = new Date(obj.so_date);
                            var month = FormatDate(FormatedSoDate.getMonth() + 1)   //Months are zero based
                            var year = FormatedSoDate.getFullYear();
                            var date = FormatDate(FormatedSoDate.getDate());
                            FormatedSoDate = (date + "-" + month + "-" + year);



                            $('#tblMrnReportBody').append("<tr>"
                                + "<td> " + obj.MRN_NO + " </td>"
                                + "<td> " + FormatedMrnDate + "</td>"
                                + "<td> " + obj.SUPPLIER_NAME + "</td>"
                                + "<td> " + obj.PO_Number + "</td>"
                                + "<td> " + FormatedPODate + "</td>"
                                + "<td> " + obj.Item_Description + "</td>"
                                + "<td>" + obj.Item_Code + " </td>"
                                + "<td> " + obj.unit + " </td>"
                                + "<td> " + obj.MRN_Received_Quantity + " </td>"
                                + "<td>" + obj.supplier_dn_no + " </td>"
                                + "<td> " + obj.supplier_invoice_no + " </td>"
                                + "<td> " + FormatedDeliveryDate + "</td>"
                                + "<td> " + obj.Sales_Order_Number + " </td>"
                                + "<td> " + FormatedSoDate + " </td>"



                                + "</tr>");
                        });
                    }
                }
            });
        }

        //=======================Display DN  Report List ==============================//
        function ShowDNReport() {
            $('#tblDNReport').show();
            $('#tblDNReportBody').empty();
            $('#title').text('Delivery Note Report').css('font-size', '20px')
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowDNReport', 'SearchString': SearchString
                },
                success: function (data) {
                    $('#tblDNReportBody').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(JSON.parse(data), function (i, obj) {
                            var FormatedDnDate = new Date(obj.dn_date);
                            var month = FormatDate(FormatedDnDate.getMonth() + 1)   //Months are zero based
                            var year = FormatedDnDate.getFullYear();
                            var date = FormatDate(FormatedDnDate.getDate());
                            FormatedDnDate = (date + "-" + month + "-" + year);

                            var FormatedPODate = new Date(obj.Customer_PO_Date);
                            var month = FormatDate(FormatedPODate.getMonth() + 1)   //Months are zero based
                            var year = FormatedPODate.getFullYear();
                            var date = FormatDate(FormatedPODate.getDate());
                            FormatedPODate = (date + "-" + month + "-" + year);


                            $('#tblDNReportBody').append("<tr>"
                                + "<td> " + obj.delivery_note_number + " </td>"
                                + "<td> " + FormatedDnDate + "</td>"
                                + "<td> " + obj.customer_name + "</td>"
                                + "<td> " + obj.PO_Reference + "</td>"
                                + "<td> " + FormatedPODate + "</td>"
                                + "<td> " + obj.driver_name + "</td>"
                                + "<td> </td>"
                                + "<td> </td>"
                                + "<td>  </td>"
                                + "<td>  </td>"
                                + "<td> " + obj.Sales_Order_Number + " </td>"




                                + "</tr>");
                        });
                    }
                }
            });
        }

        //=======================Display Trial Balance  Report List ==============================//
        function ShowTrialBalanceReport() {
           
            $('#tbodytrialbalance').empty();
            $('#title').text('Trial Balance Report').css('font-size', '20px');
            var date = $('#txtDateFrom').val();
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowTrialBalanceReport', 'date': date , 'SearchString': SearchString
                },
                success: function (data) {
                    $('#tbodytrialbalance').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(JSON.parse(data), function (i, obj) {     

                            $('#tbodytrialbalance').append("<tr>"
                                + "<td style='display:none;'> " + obj.tr_rpt_id + " </td>"
                                + "<td> " + obj.account_code  + "</td>"
                                + "<td> " + obj.account_grp_name  + "</td>"
                                + "<td> " + obj.account_name  + "</td>"
                                + "<td> " + obj.opening_bal  + "</td>"
                                + "<td> " + obj.Debits  + "</td>"
                                + "<td> " + obj.Credits  + "</td>"
                                + "<td> " + obj.Closing_Balance + "</td>"
                               
                                + "</tr>");
                        });
                    }
                }
            });
        }

        //=======================Display Tracking Report  Report List ==============================//
        function ShowTrackingReport() {
           
            $('#tbodyTrackingReport').empty();
            $('#title').text('Tracking Report').css('font-size', '20px');
            var date = $('#txtDateFrom').val();
            $('#tblTrackingReport').show();
             $('#txtCalenderSearch').show();
            $('#btncalenderSearch').show();
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowTrackingReport', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    $('#tbodyTrackingReport').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(JSON.parse(data), function (i, obj) {

                            var FormatedSODate = new Date(obj.so_date);
                            var month = FormatDate(FormatedSODate.getMonth() + 1)   //Months are zero based
                            var year = FormatedSODate.getFullYear();
                            var date = FormatDate(FormatedSODate.getDate());
                            FormatedSODate = (date + "-" + month + "-" + year); 
                            var FormatedPODate = "";
                           
                            if (!obj.PO_Date.toString().includes("1900")) {
                               // alert(obj.PO_Date + ':' + typeof (obj.PO_Date))
                                 FormatedPODate = new Date(obj.PO_Date);
                                var month = FormatDate(FormatedPODate.getMonth() + 1)   //Months are zero based
                                var year = FormatedPODate.getFullYear();
                                var date = FormatDate(FormatedPODate.getDate());
                                FormatedPODate = (date + "-" + month + "-" + year);
                            }
                            var FormatedMRNDate = "";
                            if (!obj.MRN_Date.toString().includes("1900")) {
                                FormatedMRNDate = new Date(obj.MRN_Date);
                                var month = FormatDate(FormatedMRNDate.getMonth() + 1)   //Months are zero based
                                var year = FormatedMRNDate.getFullYear();
                                var date = FormatDate(FormatedMRNDate.getDate());
                                FormatedMRNDate = (date + "-" + month + "-" + year);
                            }

                            var FormatedDNDate = "";
                            if (!obj.DN_Date.toString().includes("1900")) {
                                 FormatedDNDate = new Date(obj.DN_Date);
                                var month = FormatDate(FormatedDNDate.getMonth() + 1)   //Months are zero based
                                var year = FormatedDNDate.getFullYear();
                                var date = FormatDate(FormatedDNDate.getDate());
                                FormatedDNDate = (date + "-" + month + "-" + year);
                            }
                            var FormatedGRNDate = "";
                            if (!obj.Grn_Date.toString().includes("1900")) {
                                 FormatedGRNDate = new Date(obj.Grn_Date);
                                var month = FormatDate(FormatedGRNDate.getMonth() + 1)   //Months are zero based
                                var year = FormatedGRNDate.getFullYear();
                                var date = FormatDate(FormatedGRNDate.getDate());
                                FormatedGRNDate = (date + "-" + month + "-" + year);
                            }

                            var FormatedInvDate = "";
                            if (!obj.Invoice_Date.toString().includes("1900")) {
                                  FormatedInvDate = new Date(obj.Invoice_Date);
                                var month = FormatDate(FormatedInvDate.getMonth() + 1)   //Months are zero based
                                var year = FormatedInvDate.getFullYear();
                                var date = FormatDate(FormatedInvDate.getDate());
                                FormatedInvDate = (date + "-" + month + "-" + year);
                            }
                           
                            $('#tbodyTrackingReport').append("<tr>"
                                + "<td> " + obj.Sales_Order_Number + " </td>"
                                + "<td> " + FormatedSODate + "</td>"
                                + "<td> " + obj.Cus_Company_Name  + "</td>"
                                + "<td> " + obj.Division_Name+" </td>"
                                + "<td> " + obj.salesman + "</td>"
                                + "<td> " + obj.PO_Number + "</td>"
                                + "<td> " + FormatedPODate + "</td>"
                                + "<td> " + obj.Supplier_Name + "</td>"
                                + "<td> " + obj.MRN_No + "</td>"
                                + "<td> " + FormatedMRNDate + "</td>"
                                + "<td> " + obj.Delivery_Note_Number + "</td>"
                                + "<td> " + FormatedDNDate + "</td>"
                                + "<td> " + obj.Grn_No + "</td>"
                                + "<td> " + FormatedGRNDate + "</td>" 
                                //+ "<td> RT No </td>"
                                //+ "<td> RT Date </td>"
                                + "<td> " + obj.Invoice_Number + "</td>"
                                + "<td> " + FormatedInvDate + "</td>"
                                + "</tr>");
                        });
                    }
                }
            });
        }
        //=========================================Aging Analysis Report==================================================//
        function AgingAnalysis() {
            
            $('#tbodyAgingAnalysis').empty();
            var SearchString = $('#txtSearchSo').val();
            var date = $('#txtDateFrom').val();
            
           
            //$('#txtCalenderSearch').show();
            //$('#btncalenderSearch').show();
            $('#title').text('Customer Aging Analysis Report ').css('font-size', '20px')
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'CustomerAgingAnalysis', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    $('#tbodyAgingAnalysis').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        var CLOSING_BALANCE = 0.00
                        var a = 0.00;
                        var b = 0.00;
                        var c = 0.00;
                        var d = 0.00;
                        var e = 0.00;
                        var f = 0.00;
                        $.each(JSON.parse(data), function (i, obj) {
                         
                           

                            $('#tbodyAgingAnalysis').append("<tr>"
                                + "<td>" + obj.Account_code+" </td>"
                                + "<td>" + obj.Cus_Company_Name+" </td>"
                                + "<td>" + obj.CLOSING_BALANCE+" </td>"
                                + "<td>" + obj.a+"</td>"
                                + "<td> " + obj.b+"</td>"
                                + "<td> " + obj.c+" </td>"
                                + "<td>  " + obj.d + "</td>"
                                + "<td>  " + obj.e + "</td>"
                                + "<td>  " + obj.ABOVE180 + "</td>"
                                


                                + "</tr>");
                            CLOSING_BALANCE += obj.CLOSING_BALANCE;
                            a += obj.a;
                            b += obj.b;
                            c += obj.c;
                            d += obj.d;
                            e += obj.e;
                            f += obj.ABOVE180;
                        });
                        $('#tbodyAgingAnalysis').append("<tr>"
                           
                            + "<td colspan='2'><b> Grand Total</b> </td>"
                            + "<td> <b>" + CLOSING_BALANCE +" </b> </td>"
                            + "<td><b>" + a +" </b></td>"
                            + "<td><b>" + b +" </b> </td>"
                            + "<td><b>" + c +" </b> </td>"
                            + "<td> <b>" + d +" </b> </td>"
                            + "<td> <b>" + e +" </b> </td>"
                            + "<td> <b>" + f + " </b> </td>"
                            + "</tr>");
                    
                    }
                }
            });
        }

        //=========================================Aging Analysis Report==================================================//
        function SupAgingAnalysis() {

            $('#tbodySupAgingAnalysis').empty();
            var SearchString = $('#txtSearchSo').val();
            var date = $('#txtDateFrom').val();


            //$('#txtCalenderSearch').show();
            //$('#btncalenderSearch').show();
            $('#title').text('Supplier Aging Analysis Report ').css('font-size', '20px')
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'SupAgingAnalysis', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    $('#tbodySupAgingAnalysis').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        var CLOSING_BALANCE = 0.00
                        var a = 0.00;
                        var b = 0.00;
                        var c = 0.00;
                        var d = 0.00;
                        var e = 0.00;
                        var f = 0.00;
                        $.each(JSON.parse(data), function (i, obj) {



                            $('#tbodySupAgingAnalysis').append("<tr>"
                                + "<td>" + obj.Account_code + " </td>"
                                + "<td>" + obj.Supplier_Name + " </td>"
                                + "<td>" + obj.CLOSING_BALANCE + " </td>"
                                + "<td>" + obj.a + "</td>"
                                + "<td> " + obj.b + "</td>"
                                + "<td> " + obj.c + " </td>"
                                + "<td>  " + obj.d + "</td>"
                                + "<td>  " + obj.e + "</td>"
                                + "<td>  " + obj.ABOVE180 + "</td>"



                                + "</tr>");
                            CLOSING_BALANCE += obj.CLOSING_BALANCE;
                            a += obj.a;
                            b += obj.b;
                            c += obj.c;
                            d += obj.d;
                            e += obj.e;
                            f += obj.ABOVE180;
                        });
                        $('#tbodySupAgingAnalysis').append("<tr>"

                            + "<td colspan='2'><b> Grand Total</b> </td>"
                            + "<td> <b>" + CLOSING_BALANCE + " </b> </td>"
                            + "<td><b>" + a + " </b></td>"
                            + "<td><b>" + b + " </b> </td>"
                            + "<td><b>" + c + " </b> </td>"
                            + "<td> <b>" + d + " </b> </td>"
                            + "<td> <b>" + e + " </b> </td>"
                            + "<td> <b>" + f + " </b> </td>"
                            + "</tr>");

                    }
                }
            });
        }
        //======================= Sales Order Export To Excel Funtionality ==============================//
        function SOGenerateExcel() {
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'SOExportToExcel', 'SearchString': SearchString
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }

                }
            });
        }

        //======================= purchase Order Export To Excel Funtionality ==============================//
        function POGenerateExcel() {
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'POExportToExcel', 'SearchString': SearchString
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }

                }
            });
        }

        //======================= Mrn Export To Excel Funtionality ==============================//
        function MRNGenerateExcel() {
            var SearchString = $('#txtSearchSo').val();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'MRNExportToExcel', 'SearchString': SearchString
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }

                }
            });
        }

        //======================= Delivery Note To Excel Funtionality ==============================//
        function DNGenerateExcel() {
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'DNExportToExcel', 'SearchString': SearchString
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }

                }
            });
        }

        //==========================  Trial Balance To Excel Functionality=====================//
        function TrialBalanceGenerateExcel() {
            var date = $('#txtDateFrom').val();
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'TrialBalanceGenerateExcel', 'date': date, 'SearchString': SearchString
                },
                 success: function (data) {
                     if (Chk_Res(data) == false) {
                         if (data.indexOf("!error!") > -1) {
                             alert("Something Went Wrong..\n\n" + data);
                         }
                         else {
                             window.open("Downloaded_Reports/" + data);
                         }
                     }
                    }
                
            });

        }

         //==========================  Trial Balance To Excel Functionality=====================//
        function TrackingReportExportToExcel() {
            var date = $('#txtDateFrom').val();
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'TrackingReportExportToExcel', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                 success: function (data) {
                     if (Chk_Res(data) == false) {
                         if (data.indexOf("!error!") > -1) {
                             alert("Something Went Wrong..\n\n" + data);
                         }
                         else {
                             window.open("Downloaded_Reports/" + data);
                         }
                     }
                    }
                
            });

        } 
        //========================SupAgingAnalysisExportToExcel==============
        function SupAgingAnalysisExportToExcel() {

            var SearchString = $('#txtSearchSo').val();
            var date = $('#txtDateFrom').val();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'SupAgingAnalysisExportToExcel', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                       // alert(data)
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }
                }

            });

        }
        //==========================  Aging Analysis To Excel Functionality=====================//
        function AgingAnalysisExportToExcel() {
            
            var SearchString = $('#txtSearchSo').val();
            var date = $('#txtDateFrom').val();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'AgingAnalysisExportToExcel', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }
                }

            });

        }
		
		function AssetRegisterReportExportToExcel() {
            var category = $('#DDL_AssetCategory').val();
            var fromDate = $('#fromDate').val();
            var toDate = $('#todate').val();
			var asOfDate = $('#asOfdate').val();


            para = 'reports.ashx?fun=AssetRegisterReportExportToExcel&category=' + category
                + '&fromDate=' + fromDate
                + '&toDate=' + toDate
                + '&asOf=' + asOfDate;

            window.open(para);
            //$.ajax({
            //    url: 'reports.ashx',
            //    type: "POST",
            //    data: {
            //        'fun': 'AssetRegisterReportExportToExcel', 'category': category, 'fromDate': fromDate, 'toDate': toDate
            //    },
            //    success: function (data) {
            //        if (Chk_Res(data) == false) {
            //            if (data.indexOf("!error!") > -1) {
            //                alert("Something Went Wrong..\n\n" + data);
            //            }
            //            else {
            //                window.open("Downloaded_Reports/" + data);
            //            }
            //        }
            //    }

            //});

        }
        function ShowEmpolyeeAdvancesReport()
        {  
            $('#tbodyEmployeeAdvances').empty();
            $('#title').text('Employee Advances Report').css('font-size', '20px');
            var date = $('#txtDateFrom').val();
            $('#DivEmployeeAdvances').show(); 
            $('#tblEmployeeAdvances').show();
            $('#txtCalenderSearch').show();
            $('#btncalenderSearch').show();
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowEmployeeAdvances', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    $('#tbodyEmployeeAdvances').empty();
                    if (Chk_Res(data.errorMessage) == false) {
                        $.each(JSON.parse(data), function (i, obj) {

                           // alert(obj.account_code)

                            //var FormatedSODate = new Date(obj.so_date);
                            //var month = FormatDate(FormatedSODate.getMonth() + 1)   //Months are zero based
                            //var year = FormatedSODate.getFullYear();
                            //var date = FormatDate(FormatedSODate.getDate());
                            //FormatedSODate = (date + "-" + month + "-" + year);
                            //" + obj.narration + obj.account_code obj.account_name obj.debit obj.credit  obj.debit - obj.credit"
                            $('#tbodyEmployeeAdvances').append('<tr>'
                                + '<td>' + obj.account_code+ '</td>'
                                + '<td>'+obj.account_name+' </td>'
                                + '<td>'+obj.debit+'</td>'
                                + '<td> ' + obj.credit+' </td>'
                                + '<td>' + (obj.debit - obj.credit)+'</td>'
                                + '<td>'+ obj.narration +'</td>'
                                
                               
                                + '</tr>');
                        });
                    }
                }
            });
        }
        $(document).ready(function () {
            $('.dtleave').daterangepicker();
        });
        function ShowConsolidatedPl() {
            //$('#tbodyConsolidatedPl').empty();
            $('#title').text('Consolidated Pl Report').css('font-size', '20px');
            var date = $('#txtDateFrom').val();
           $('#tblConsolidatedPl').show();
           $('#DivConsolidatedPl').show();
            $('#txtCalenderSearch').show();
            $('#btncalenderSearch').show();
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ShowConsolidatedPl', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                   
                    if (Chk_Res(data.errorMessage) == false) {
                        if (data != "") {
                            $('#tbodyConsolidatedPl').empty();
                            SetInnerVal("tblConsolidatedPl", data);
                        }
                    }
                }
            });
        }
        function ExportConsolidatedPl() {

            var SearchString = $('#txtSearchSo').val();
            var date = $('#txtDateFrom').val();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'ExportConsolidatedPl', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }
                }

            });

        }

        function LeaveGraduity() {
            //$('#tbodyConsolidatedPl').empty();
            $('#title').text('Leave & Graduity Report').css('font-size', '20px');
            var date = $('#txtDateFrom').val();
            $('#tblEmployeeGraduity').show();
            $('#DivEmployeeGraduity').show();
            
            $('#hdr_Opn_bal1').html("Opening Bal " + new Date().getFullYear());
            $('#hdr_Opn_bal2').html("Opening Bal " + new Date().getFullYear());
            //$('#btncalenderSearch').show();
            var SearchString = $('#txtSearchSo').val();
            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'LeaveGraduity', 'SearchString': SearchString
                },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {
                        if (data != "") {
                            $('#tbodyEmployeeGraduity').empty();
                            SetInnerVal("tbodyEmployeeGraduity", data);
                        }
                    }
                }
            });
        }
        $('#btncalenderSearch').on('click', function () {

            IsDateSearch = 1;
             switch (Report) {
               
                 case "TrialBalance": ShowTrialBalanceReport(); break;
                 case "TrackingReport": ShowTrackingReport(); break;
                 case "CustomerAgingAnalysis": AgingAnalysis(); break; 
                 case "SupplierAgingAnalysis": SupAgingAnalysis(); break;
                 case "EmployeeAdvances": ShowEmpolyeeAdvancesReport(); break;
                 case "ConsolidatedPLReport": ShowConsolidatedPl(); break; 
                 case "LeaveGraduity": LeaveGraduity(); break;  
             }
        })

        function EportLeaveGraduity() {

            var SearchString = $('#txtSearchSo').val();
            var date = $('#txtDateFrom').val();

            $.ajax({
                url: 'reports.ashx',
                type: "POST",
                data: {
                    'fun': 'EportLeaveGraduity', 'date': date, 'SearchString': SearchString, 'IsDateSearch': IsDateSearch
                },
                success: function (data) {
                    if (Chk_Res(data) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else {
                            window.open("Downloaded_Reports/" + data);
                        }
                    }
                }

            });

        }
        
    </script>
</body>
</html>

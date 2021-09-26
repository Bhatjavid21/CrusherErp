<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Invoice_List.aspx.cs" Inherits="Modules_MRM_mrm_list" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>

<% 
    Session["top_menu"] = "Invoice";
    Session["sub_menu"] = "Invoice-list";
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
    <title>Invoice List</title>

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/vendor_components/datatable/datatables.min.css" />
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/icheck/skins/all.css">
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css"
        rel="stylesheet">
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
     <style>
        .modal-dialog {
    width: 90% ;
   max-width:90%;
}
    </style>
</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">
 <form id="frm" runat="server">
     <div class="wrapper">

        <uc1:uch ID="uch1" runat="server" />
        <uc2:ucs ID="ucs1" runat="server" />
        <input type="hidden" value="0" id="InvoiceMaxNum" />
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content mt-20"> 
               <input type="hidden" id="hdn_PageNo" value="0" />
                 <input type="hidden" id="hdn_Invoice_Id" value="0" />
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
                    <div class="box-body"  id="MianDiv">
                        <div class="row mb-10">

                               <div class="col-md-4 mt-25">
                                                <input type="text" id="txtSearch" class="form-control" onkeyup="Searchtxt()" placeholder="Search">
                                                <span class="tblsearch-btn"><i class="ti-search"></i></span>

                                   </div>

                            <div class="col-md-8 mt-25 ">
                                <button class="btn btn-success right fa fa-plus" id="btnAdd" onclick="ResetFields();" data-toggle="modal" data-target="#Popup" ></button>

                            </div>
                        </div>
                        <div class=" row media-list media-list-divided media-list-hover ">
                            <div class="col-md-12">

                                <table class="table table-hover table-bordered ">
                                    <thead>
                                        <tr>
                                            <th>Invoice Date </th>
                                            <th>Customer  </th>
                                            <th>From Date </th>
                                             <th>To Date</th>
                                            <th>No. Of Sales</th>
                                            <th>Invoice Amount</th>
                                                                  
                                             <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="Invoice_list_Body">
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
     <div class="modal fade  bs-example-modal-lg" id="Popup" tabindex="">
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="PopUpTitle">Add Invoice</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body pt-5" id="AllContent">
                      
                    <div class="row mb-10">
                        <div class="col-md-3">
                            <label>Customer<span class="text-danger">*</span></label>
                            <select id="ddlcustomer" onchange="Getitems()" class="form-control enq-dropdown select2">
                                <option value="0"> Select</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                             <label>From Date<span class="text-danger">*</span></label>
                            <input type="date" class="form-control " onchange="Getitems()" id="Frmdt"  />
                            

                        </div>
                        <div class="col-md-2">
                             <label>To Date<span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="Todt" onchange="Getitems()"  />
                         </div>
                       
                        <div class="col-md-3">
                            <label>Invoice Amount (ft)</label>
                            <input class="form-control " value="0.00" ReadOnly id="txtInvoiceAmount" onkeyup="CalculateInvoicePrice()" onkeydown=' return isNumeric(window.event.keyCode,this);' />
                          
                        </div>
                       
                    
                   
                 
                     
                   
                        <div class="col-md-2 mt-15">
                            <button class="btn btn-success right" id="btnSave" onclick="Save_Invoice()">Save</button>
                         </div>
                    </div> 
                    <hr />
                       
                    

               <div class="row mb-10 mt-5">
                 <table class="table table-hover table-bordered ">
                                    <thead>
                                        <tr>
                                            
                                            
                                            <th>Sales Date </th>
                                            <th>Sales Order No  </th>
                                            <th>Material  </th>
                                            <th>Quantity (ft)  </th>
                                             <th>Trips</th>
                                            <th>Fuel Amount </th>
                                            <th>Total Amount</th>
                                                                  
                                            
                                        </tr>
                                    </thead>
                                    <tbody id="tbl_Sales_Body">
                                    </tbody>
                                </table>
            </div>
                    <div class="modal-footer"></div>
        </div>
    </div>
        </div>
 </div>
 </form>
   </body>
</html>
    <script src="<%=G.S%>General/jquery.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <script src="<%=G.B%>assets/vendor_components/moment/min/moment.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>

    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
    <script src="<%=G.B%>assets/js/template.js"></script>
    <script src="<%=G.B%>assets/js/demo.js"></script>

    <script src="../General/libo.js" type="text/javascript"></script>
    <script src="Invoice.js"></script>

    <script>


        $(document).ready(function () {
          //  GetUserAccess();
            $('.dtleave').daterangepicker();
            bindddls(false,0);
            ListAllInvoice();
        });




       

    </script>


<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Supplier_Master.aspx.cs" Inherits="Modules_MRM_mrm_list" %>

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
    <title>Supplier List</title>

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
    <form id="frm" runat="server">
        <div class="wrapper">

            <uc1:uch ID="uch1" runat="server" />
            <uc2:ucs ID="ucs1" runat="server" />

            <!-- Content Wrapper. Contains page content -->
            <div class="content-wrapper">
                <!-- Main content -->
                <section class="content mt-20">
                    <input type="hidden" id="hdn_PageNo" value="0" />
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

                                <div class="col-md-4 mt-25">
                                    <input type="text" id="txtSearch" class="form-control" onkeyup="Searchtxt()" placeholder="Search">
                                    <span class="tblsearch-btn"><i class="ti-search"></i></span>

                                </div>

                                <div class="col-md-8 mt-25 ">
                                    <button class="btn btn-success right fa fa-plus" id="btnAdd" onclick="ResetFields();" data-toggle="modal" data-target="#Popup"></button>

                                </div>
                            </div>
                            <div class=" row media-list media-list-divided media-list-hover ">
                                <div class="col-md-12">

                                    <table class="table table-hover table-bordered ">
                                        <thead>
                                            <tr>

                                                <th>Supplier Name</th>
                                                <th>Business Id</th>
                                                <th>Address</th>

                                                <th>Phone No.</th>
                                                <th>Balance</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="Supplier_list_Body">
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
                        <h5 class="modal-title" id="PopUpTitle">Add Supplier</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body pt-5" id="AllContent">
                        <div class="row mb-10">
                            <div class='col-md-6'>

                                <div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-10">
                            <div class="col-md-5">
                                <label>Supplier Name<span class="text-danger">*</span></label>
                                <input class="form-control " id="txtCusName" />
                            </div>
                            <div class="col-md-4">
                                <label>Business Id<span class="text-danger">*</span></label>
                                <input class="form-control " id="txtBusinessId" />
                            </div>
                            <div class="col-md-3 ">
                                <label>Phone No/Mobile No<span class="text-danger">*</span></label>
                                <input class="form-control " id="txtPhoneNo" onkeydown=' return isNumeric(window.event.keyCode,this);' />

                            </div>

                        </div>
                        <div class="row mb-10">

                            <div class="col-md-6 ">
                                <label>Address<span class="text-danger">*</span></label>
                                <textarea class="form-control " id="txtAddress"></textarea>

                            </div>
                            <div class="col-md-6 ">
                                <label>Remarks</label>
                                <textarea class="form-control " id="txtRemarks"></textarea>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <button class="btn btn-success right" id="btnSave" onclick="Save_Supplier()">Save</button>
                            </div>
                        </div>



                        <div class="modal-footer"></div>
                    </div>
                </div>
            </div>
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
        <script src="Supplier.js"></script>

        <script>


            $(document).ready(function () {
                //  GetUserAccess();
                ListAllSupplier();
            });






        </script>
    </form>
</body>
</html>

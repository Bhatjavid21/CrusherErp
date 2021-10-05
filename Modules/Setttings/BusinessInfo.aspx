<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BusinessInfo.aspx.cs" Inherits="Modules_MRM_mrm_list" %>

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
                        <div class="box">
                            <div class="row mb-10">
                                <div class="col-md-4">
                                    <label>Business Name<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBusinesName" />
                                </div>
                                <div class="col-md-4">
                                    <label>Business Address<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBusinessAddress" />
                                </div>
                                <div class="col-md-4">
                                    <label>Business Contact<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBusinessPhone" type="number" onkeydown=' return isNumeric(window.event.keyCode,this);' />
                                </div>

                            </div>
                            <div class="row mb-10">
                                <div class="col-md-4 ">
                                    <label>Business Email<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBusinessEmail" type="email" />
                                </div>
                                <div class="col-md-4">
                                    <label>Web Site<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBusinessWebsite" />
                                </div>
                                <div class="col-md-4 ">
                                    <label>Tag Line<span class="text-danger">*</span></label>
                                    <input class="form-control " id="TxtBusinessTagline" />

                                </div>
                            </div>
                            <div class="row mb-10">
                                <div class="col-md-4 ">
                                    <label>GSTIN<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBusinessGSTIN" />
                                </div>
                                <div class="col-md-4">
                                    <label>CGST<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBusinessCGST" />
                                </div>
                                <div class="col-md-4 ">
                                    <label>SGST<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBusinessSGST" />

                                </div>
                            </div>
                            <div class="row mb-10">
                                <div class="col-md-4 ">
                                    <label>IGST<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBusinessIGST" />
                                </div>
                                <div class="col-md-4">
                                    <label>Bank Name<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBankName" />
                                </div>
                                <div class="col-md-4 ">
                                    <label>Bank Account No<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBankAccountNo" />

                                </div>
                            </div>
                            <div class="row mb-10">
                                <div class="col-md-4 ">
                                    <label>Branch Name<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtBranchName" />
                                </div>
                                <div class="col-md-4">
                                    <label>IFSC Code<span class="text-danger">*</span></label>
                                    <input class="form-control " id="txtIfsc" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <button class="btn btn-success right" id="btnSave" onclick="Save_BusinessInfo()">Save</button>
                                </div>
                            </div>
                        </div>
                    </div>
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
        <script src="BusinessInfo.js"></script>

        <script>


            $(document).ready(function () {
                //  GetUserAccess();
                GetBusinessInfo();
            });
         </script>
    </form>
</body>
</html>

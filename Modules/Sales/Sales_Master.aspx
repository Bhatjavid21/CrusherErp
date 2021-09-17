<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sales_Master.aspx.cs" Inherits="Modules_MRM_mrm_list" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>

<% 
    Session["top_menu"] = "Sales";
    Session["sub_menu"] = "Sales_list";
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
    <title>Sales</title>

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
                                                <input type="text" id="txtSearch" class="form-control" onkeyup="SearchMrms()" placeholder="Search">
                                                <span class="tblsearch-btn"><i class="ti-search"></i></span>

                                            </div>

                            <div class="col-md-8 mt-25 ">
                                <a href="mrm-add.aspx" id="btnAdd" class="btn btn-success right" data-toggle="tooltip" data-original-title="Add Mrm "><i class="mdi mdi-plus plusicon"></i>Add</a>


                            </div>
                        </div>
                        <div class=" row media-list media-list-divided media-list-hover ">
                            <div class="col-md-12">

                                <table class="table table-hover table-bordered ">
                                    <thead>
                                        <tr>

                                            <th>Customer Name</th>
                                            <th>Date</th>
                                            <th>Customer Name</th>

                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody id="Customer_list_Body">
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
    <script src="Mrm.js"></script>

    <script>


        $(document).ready(function () {
          //  GetUserAccess();
        });


       

    </script>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="logout.aspx.cs" Inherits="logout" %>

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

    <title>Trading ERP - Dashboard</title>
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/fullcalendar/fullcalendar.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/fullcalendar/fullcalendar.print.min.css" media="print">

    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/js/froiden-helper/helper.css">
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet">

    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
</head>

<body class="hold-transition fixed skin-info-light sidebar-mini">
    <div class="wrapper">

        <uc1:uch ID="uch1" runat="server" />
        <uc2:ucs ID="ucs1" runat="server" />

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
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
            <section class="content">
                <div class="row">
                    <div class="col-md-6">
                        <div class="box">
                            <div class="box-header with-border">
                                <h5 class="box-title">To Do List</h5>
                            </div>
                            <div class="box-body p-0">
                                <!-- THE CALENDAR -->
                                <div id="calendar"></div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                        <!-- /. box -->

                    </div>

                    <div class="col-md-6">
                        <div class="box box-solid">
                            <div class="box-header with-border">
                                <h5 class="box-title">Work Items</h5>
                            </div>
                            <div class="box-body p-15">

                                <ul class="nav nav-tabs" role="tablist">
                                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#home" role="tab"><span class="heartbeat"></span><span class="hidden-xs-down pl-5">6 Approvals</span></a> </li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#profile" role="tab"><span class="heartbeat"></span><span class="hidden-xs-down pl-5">6 Leaves</span></a> </li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#messages" role="tab"><span class="heartbeat"></span><span class="hidden-xs-down pl-5">6 Tab 3</span></a> </li>
                                </ul>

                                <div class="tab-content tabcontent-border">
                                    <div class="tab-pane active" id="home" role="tabpanel">
                                        <ul class="todo-list">
                                            <li class="p-15">
                                                <div class="box p-15 mb-0 d-block bb-2 border-danger">
                                                    <span class="pull-right badge badge-danger">Urgent</span>
                                                    <span class="font-size-18 text-line"><a href="#">Approval 1</a> </span>
                                                </div>
                                            </li>
                                            <li class="p-15">
                                                <div class="box p-15 mb-0 d-block bb-2 border-warning">
                                                    <span class="pull-right badge badge-warning">High</span>
                                                    <span class="font-size-18 text-line"><a href="#">Approval 2</a> </span>
                                                    
                                                </div>
                                            </li>
                                            <li class="p-15">
                                                <div class="box p-15 mb-0 d-block bb-2 border-secondary">
                                                    <span class="font-size-18 text-line"><a href="#">Approval 3</a> </span>
                                                    
                                                </div>
                                            </li>
                                            <li class="p-15">
                                                <div class="box p-15 mb-0 d-block bb-2 border-secondary">
                                                    <span class="font-size-18 text-line"><a href="#">Approval 4</a> </span>
                                                    
                                                </div>
                                            </li>

                                        </ul>
                                        
                                    </div>
                                    <div class="tab-pane" id="profile" role="tabpanel">
                                        <ul class="todo-list">
                                            <li class="p-15">
                                                <div class="box p-15 mb-0 d-block bb-2 border-danger">
                                                    <span class="pull-right badge badge-danger">Urgent</span>
                                                    <span class="font-size-18 text-line"><a href="#">Leave 1</a> </span>
                                                </div>
                                            </li>
                                            <li class="p-15">
                                                <div class="box p-15 mb-0 d-block bb-2 border-warning">
                                                    <span class="pull-right badge badge-warning">High</span>
                                                    <span class="font-size-18 text-line"><a href="#">Leave 2</a> </span>
                                                    
                                                </div>
                                            </li>
                                            <li class="p-15">
                                                <div class="box p-15 mb-0 d-block bb-2 border-secondary">
                                                    <span class="font-size-18 text-line"><a href="#">Leave 3</a> </span>
                                                    
                                                </div>
                                            </li>
                                            <li class="p-15">
                                                <div class="box p-15 mb-0 d-block bb-2 border-secondary">
                                                    <span class="font-size-18 text-line"><a href="#">Leave 4</a> </span>
                                                    
                                                </div>
                                            </li>

                                        </ul>
                                    </div>
                                    <div class="tab-pane" id="messages" role="tabpanel">3</div>
                                </div>


                            </div>
                        </div>

                    </div>

                </div>
                <!-- /.row -->
            </section>
            <!-- /.content -->
        </div>

        <uc3:ucf ID="ucf1" runat="server" />



    </div>
    <!-- ./wrapper -->

    <!-- BEGIN MODAL -->
    <div class="modal none-border" id="my-event">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><strong>Add Event</strong></h4>
                </div>
                <div class="modal-body"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-white waves-effect" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-success save-event waves-effect waves-light">Create event</button>
                    <button type="button" class="btn btn-danger delete-event waves-effect waves-light" data-dismiss="modal">Delete</button>
                </div>
            </div>
        </div>
    </div>




    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-ui/jquery-ui.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.js"></script>

    <script src="<%=G.B%>assets/vendor_components/fullcalendar/lib/moment.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/fullcalendar/fullcalendar.min.js"></script>

    <script src="<%=G.B%>assets/js/bootstrap-growl.min.js"></script>
    <script src="<%=G.B%>assets/js/froiden-helper/helper.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>

    <script src="<%=G.B%>assets/js/template.js"></script>
    <script src="<%=G.B%>assets/js/demo.js"></script>
    <script src="dashboard.js"></script>

</body>
</html>

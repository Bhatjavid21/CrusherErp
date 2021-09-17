<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="<%=G.B%>images/favicon.ico">

    <title>SUS ERP - Log in </title>

    <link rel="stylesheet" href="assets/vendor_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap-extend.css">
    <link rel="stylesheet" href="assets/css/master_style.css">
    <link rel="stylesheet" href="assets/css/skins/_all-skins.css">

    <link rel="stylesheet" type="text/css" href="assets/js/froiden-helper/helper.css">
    <link rel="stylesheet" href="assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css">
</head>
<body class="hold-transition bg-img" style="" data-overlay="4" onload="loadpopup()">
    <input type="hidden" id="baseurl" name="baseurl" value="<%=ConfigurationManager.AppSettings["base_url"] %>" />

    <div class="auth-2-outer row align-items-center h-p100 m-0">
        <div class="auth-2">
            <div class="auth-logo font-size-40">
                <a href="index.html" class="text-white"><b>PILLAR</b> ERP</a>
            </div>
            <!-- /.login-logo -->
            <div class="auth-body">
                <p class="auth-msg">Sign in to start your session</p>

                <form novalidate id="frm" runat="server" class="ajax-form form-element">
                    <asp:Literal ID="ltrmsg" runat="server"></asp:Literal>


                    <div class="form-group has-feedback">
                        <div class="controls">
                            <input type="email" class="form-control loginfont" name="txt_user_email" id="txt_user_email" placeholder="Email" required>
                        </div>
                        <span class="ion ion-email form-control-feedback"></span>
                    </div>
                    <div class="form-group has-feedback">
                        <input type="password" class="form-control loginfont" name="txt_user_password" id="txt_user_password" placeholder="Password" required="">
                        <span class="ion ion-locked form-control-feedback"></span>
                    </div>


                    <div class="row">
                        <div class="col-6">
                            <div class="checkbox">
                                <input type="checkbox" id="basic_checkbox_1">
                                <label for="basic_checkbox_1">Remember Me</label>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-6">
                            <div class="fog-pwd">
                                <a href="<%=G.S%>Login/forgot-password.aspx" class="text-white"><i class="ion ion-locked"></i>Forgot Password?</a><br>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-12 text-center">
                            <input type="hidden" id="hdf_sysgen" value="0" runat="server" />
                            <asp:HiddenField ID="txt_EmpID" runat="server" />
                            <asp:Button ID="btnLogin" class="btn btn-block mt-10 btn-success p-10" runat="server" Text="SIGN IN" OnClick="btnLogin_Click" OnClientClick="errormesg()" />
                        </div>

                        <%--<div class="custom-control custom-checkbox mb-10">
                            <i class="mdi mdi-plus plusicon" id="lnk-add_users" data-toggle="modal" data-target="#myModal"></i>
                        </div>--%>

                        <!-- /.col -->
                    </div>



                </form>


            </div>
        </div>

    </div>


    <!-- jQuery 3 -->
    <script src="assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="assets/vendor_components/popper/dist/popper.min.js"></script>
    <script src="assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <script src="assets/js/bootstrap-growl.min.js"></script>
    <script src="assets/js/froiden-helper/helper.js"></script>
    <script src="assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>

    <!-- Form validator JavaScript -->
    <script src="assets/js/pages/validation.js"></script>
    <script src="assets/js/pages/form-validation.js"></script>

    <!-- Popup Model Plase Here -->
    <div id="myModal" class="modal fade  bs-example" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form novalidate class="ajax-form" id="frm_password_change">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">Change Your Password</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="closepopup()">×</button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">

                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group mb-0">
                                            <label class="mb-0 pr-10" for="exampleInputEmail1">New Password <small class="text-danger">*</small></label>
                                        </div>
                                    </div>
                                    <div class="col-md-8 pl-0">
                                        <div class="form-group mb-0">
                                            <div class="controls">
                                                <input type="password" id="txt_new_password" name="txt_new_password" class="form-control fnt12 enq-txtbx-pd mb-15 col-md-8 users-select2">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group mb-0">
                                            <label class="mb-0 pr-10" for="exampleInputEmail1">Conform Password <small class="text-danger">*</small></label>
                                        </div>
                                    </div>
                                    <div class="col-md-8 pl-0">
                                        <div class="form-group mb-0">
                                            <input id="hdf_EmpID" name="hdf_EmpID" type="hidden" />
                                            <div class="controls">
                                                <input type="password" id="txt_conform_password" name="txt_conform_password" class="form-control fnt12 enq-txtbx-pd mb-15 col-md-8 users-select2">
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>


                    </div>

                    <div class="modal-footer modal-footer-uniform p-0">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="box-footer">
                                    <div class="text-right mr-10">
                                        <button type="button" class="btn btn-success" onclick="update_password()">
                                            <i class="ti-save-alt mr-5"></i>Save 
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /Popup Model Plase Here -->

    <script src="Modules/General/libo.js"></script>
    <script src="Modules/Login/login.js"></script>

    <script>
        function loadpopup() {
            if (getVal("hdf_sysgen") == '1') {
                $("#hdf_EmpID").val($("#txt_EmpID").val());
                $("#myModal").addClass("show");
                document.getElementById("myModal").style.display = "block";
                return false;
            }
        }

        function closepopup() {
            $("#myModal").addClass("hide");
            document.getElementById("myModal").style.display = "none";
            return false;
        }

    </script>
</body>
</html>


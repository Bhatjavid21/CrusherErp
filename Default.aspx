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

    <title>Stone Crusher System </title>

    <link rel="stylesheet" href="assets/vendor_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap-extend.css">
    <link rel="stylesheet" href="assets/css/master_style.css">
    <link rel="stylesheet" href="assets/css/skins/_all-skins.css">

    <link rel="stylesheet" type="text/css" href="assets/js/froiden-helper/helper.css">
    <link rel="stylesheet" href="assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css">
</head>
<body class="hold-transition bg-img" style="" data-overlay="4" onload="loadpopup()">
    <input type="hidden" id="baseurl" name="baseurl" value="<%=ConfigurationManager.AppSettings["base_url"] %>" />

    <div id="login">
        <h3 class="text-center text-white ">Login</h3>
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="frm" runat="server" class="form-element">
                           
                            <div class="form-group">
                                <label for="username" class="text-info">Username:</label><br>
                                <input type="email" class="form-control" name="txt_user_email" id="txt_user_email" placeholder="Username" required >                               
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-info">Password:</label><br>
                                <input type="password" class="form-control" name="txt_user_password" id="txt_user_password" placeholder="Password" required>                            
                            </div>
                            <div>
                                &nbsp;
                            </div>
                            <div class="form-group">
                                <a href="<%=G.S%>Login/forgot-password.aspx" class="link-primary"><i class="ion ion-locked"></i>Forgot Password?</a><br>
                                <input type="hidden" id="hdf_sysgen" value="0" runat="server" />
                                <asp:HiddenField ID="txt_EmpID" runat="server" />
                                <asp:Button ID="btnLogin" class="btn btn-block mt-10 btn-success p-10" runat="server" Text="Login" OnClick="btnLogin_Click" />
                                 <asp:Literal ID="ltrmsg" runat="server"></asp:Literal>
                            </div>
                        </form>
                    </div>
                </div>
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
  <%--  <script src="Modules/Login/login.js"></script>--%>

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
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #17a2b8;
            height: 100vh;
        }

        #login .container #login-row #login-column #login-box {
            margin-top: 120px;
            max-width: 600px;
            height: 320px;
            border: 1px solid #9C9C9C;
            background-color: #EAEAEA;
        }

            #login .container #login-row #login-column #login-box #login-form {
                padding: 20px;
            }

                #login .container #login-row #login-column #login-box #login-form #register-link {
                    margin-top: -85px;
                }
    </style>
</body>
</html>


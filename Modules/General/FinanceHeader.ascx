<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FinanceHeader.ascx.cs" Inherits="user_controls_header" %>

<!-- Header Start -->
<header class="main-header">
    <!-- Logo -->
    <a href="<%=G.S%>general/dashboard.aspx" class="logo">
        <!-- mini logo -->
        <div class="logo-mini">
            <span class="light-logo">
                <img src="<%=G.B%>assets/images/logo-dark.png" alt="logo"></span>
            <span class="dark-logo">
                <img src="<%=G.B%>assets/images/logo-dark.png" alt="logo"></span>
        </div>
        <!-- logo-->
        <div class="logo-lg">
            <span class="light-logo">
                <img src="<%=G.B%>assets/images/logo-dark.png" alt="logo"></span>
            <span class="dark-logo">
                <img src="<%=G.B%>assets/images/logo-dark.png" alt="logo"></span>
        </div>
    </a>
    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top">
        <!-- Sidebar toggle button-->
        <div>
            <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
        </div>
        <div>
    <h2 style="color:#fff">Finance  Dashboard</h2>
        </div>
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">

                <li class="search-box">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-plus-circle"></i></a>
                    <ul class="dropdown-menu animated  p-15" style="width: 700px; box-shadow: 3px 3px #595a6147;">
                        <!-- User image -->

                        <!-- Menu Body -->
                        <li class="user-body ">
                            <div class="row">
                                <div class="col-lg-4">

                                    <h5><u>Master</u></h5>
                                    <a class="dropdown-item m-0" href="../Customer/Customer-List.aspx"><i class="ion ion-person"></i><u>Customer </u>&nbsp;&nbsp;&nbsp;<i class="fa fa-plus-circle" onclick="openCustomer();"></i></a>
                                    <a class="dropdown-item m-0" href="../Supplier/Supplier.aspx"><i class="ion ion-bag"></i><u>Supplier</u>&nbsp;&nbsp;&nbsp;<i class="fa fa-plus-circle" onclick="openSupplier();"></i></a>
                                    <a class="dropdown-item m-0" href="../Item/items.aspx"><i class="ion ion-email-unread"></i><u>Item</u>&nbsp;&nbsp;&nbsp;<i class="fa fa-plus-circle" onclick="openItem();"></i></a>

                                    <h5 class="mt-10"><u>Purchase</u></h5>
                                    <a class="dropdown-item m-0" href="#"><i class=" fa fa-chevron-circle-right"></i>RFQ's</a>
                                    <a class="dropdown-item m-0" href="../Purchase_Order/purchase-order.aspx"><i class=" fa fa-chevron-circle-right"></i>Purchase Order</a>
                                    <a class="dropdown-item m-0" href="#"><i class=" fa fa-chevron-circle-right"></i>Good's Return</a>

                                    <a class="dropdown-item m-0" href="../MRN/mrn.aspx"><i class=" fa fa-chevron-circle-right"></i>MRN</a>
                                    <a class="dropdown-item m-0" href="#"><i class=" fa fa-chevron-circle-right"></i>Material Issue Request</a>
                                    <h5 class="mt-10"><u>Finance</u></h5>
                                    <a class="dropdown-item m-0 " href="../Finance/accounts.aspx"><i class=" fa fa-chevron-circle-right"></i>Account's</a>
                                    <a class="dropdown-item m-0 " href="../Finance/transactions.aspx"><i class=" fa fa-chevron-circle-right"></i>Transaction's</a>

                                </div>

                                <div class="col-lg-4">
                                    <h5><u>Sales</u></h5>
                                    <a class="dropdown-item m-0 " href="../Enquiry/enquiryList.aspx"><i class=" fa fa-chevron-circle-right"></i>Enquiry</a>
                                    <a class="dropdown-item m-0 " href="../Estimation/estimation.aspx"><i class=" fa fa-chevron-circle-right"></i>Estimation</a>
                                    <a class="dropdown-item m-0 " href="../Quotation/quotation.aspx"><i class=" fa fa-chevron-circle-right"></i>Quotation</a>

                                    <a class="dropdown-item m-0" href="../Sales_Order/sales-order.aspx"><i class=" fa fa-chevron-circle-right"></i>Sale Order</a>
                                    <a class="dropdown-item m-0" href="../Sales_Return/sales-return.aspx"><i class=" fa fa-chevron-circle-right"></i>Sales Return</a>
                                    <a class="dropdown-item m-0" href="../Delivery_Note/delivery-note.aspx"><i class=" fa fa-chevron-circle-right"></i>Delivery Note</a>
                                    <a class="dropdown-item m-0" href="#"><i class=" fa fa-chevron-circle-right"></i>Invoice</a>
                                    <h5 class="mt-10"><u>Inventory</u></h5>
                                    <a class="dropdown-item m-0" href="#"><i class=" fa fa-chevron-circle-right"></i>Add Stock</a>
                                    <a class="dropdown-item m-0" href="#"><i class=" fa fa-chevron-circle-right"></i>Issue Stock</a>
                                    <a class="dropdown-item m-0" href="#"><i class=" fa fa-chevron-circle-right"></i>Upadate Stock</a>
                                </div>


                                <div class="col-lg-4">
                                    <h5><u>Human Resource</u></h5>

                                    <a class="dropdown-item m-0 " href="../Employee/Employee.aspx"><i class=" fa fa-chevron-circle-right"></i>Employee</a>
                                    <a class="dropdown-item m-0 " href="../HR/employee-allocation.aspx"><i class=" fa fa-chevron-circle-right"></i>Employee Allocation</a>
                                    <a class="dropdown-item m-0 " href="../HR/hr-config.aspx"><i class=" fa fa-chevron-circle-right"></i>HR Configuration</a>
                                    <a class="dropdown-item m-0 " href="../HR/hr-leave.aspx"><i class=" fa fa-chevron-circle-right"></i>Leave</a>
                                    <a class="dropdown-item m-0" href="../HR/hr-salary.aspx"><i class=" fa fa-chevron-circle-right"></i>Salary</a>
                                    <a class="dropdown-item m-0" href="../HR/hr-attendance.aspx"><i class=" fa fa-chevron-circle-right"></i>Attendence</a>
                                    <a class="dropdown-item m-0" href="../HR/hr-appattendance.aspx"><i class=" fa fa-chevron-circle-right"></i>Approve Attendence</a>

                                    <a class="dropdown-item m-0 " href="../HR/hr_document.aspx"><i class=" fa fa-chevron-circle-right"></i>Document</a>
                                    <a class="dropdown-item m-0 " href="../Currency/currency.aspx"><i class=" fa fa-chevron-circle-right"></i>Currency</a>


                                </div>


                            </div>


                        </li>
                    </ul>

                </li>
                <!-- User Account-->
                <li class="dropdown user user-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <img src="abc.jpg" id="imgEmployeeHeaderImage" runat="server" class="user-image rounded-circle" alt="User Image">
                    </a>
                    <ul class="dropdown-menu animated flipInY">
                        <!-- User image -->
                        <li class="user-header bg-img" style="background-image: url(assets/images/user-info.jpg)" data-overlay="3">
                            <div class="flexbox align-self-center">
                                <img src="abc.jpg" id="imgEmployeePopupImage" runat="server" class="float-left rounded-circle" alt="User Image">
                                <h4 class="user-name align-self-center">
                                    <span id="spnEmployeeName" runat="server"></span>
                                    <small id="spnEmployeeEmail" runat="server"></small>
                                </h4>
                            </div>
                        </li>
                        <!-- Menu Body -->
                        <li class="user-body">
                            <a class="dropdown-item" href="#" target="_blank" id="btnViewProfile" runat="server"><i class="ion ion-person"></i>My Profile</a>
                            <div class="dropdown-divider"></div>
                            <div class="p-10"><a class="btn btn-sm btn-rounded btn-success" href="../../Default.aspx"><i class="ion-log-out"></i>Logout</a></div>
                        </li>
                    </ul>
                </li>


                <!-- Blacklist-->
                <li class="dropdown user user-menu">
                    <ul class="dropdown-menu animated flipInY" style='display: none;' id="blacklistpopup">
                        <li class="user-body" style='border: 1px solid #dedede;'>

                            <a class="dropdown-item" href="javascript:void(0)">Blacklist Reason <span style="color: Red; font-weight: bold;">*</span><i onclick='javascript:document.getElementById("blacklistpopup").style="display:none;"' style="float: right; margin-left: 20px;">X</i></a>
                            <div class="controls col-md-12">

                                <textarea name="bkl-reason" id="txt_black_list_reason" onkeyup="Only_String(this);" maxlength="300" class="form-control" required="" style="border-color: #007bff;" onblur="return ValidateOne(this);" aria-invalid="true"></textarea>

                                <div class="help-block"></div>
                                <div>
                                    <input type='hidden' id='hid_blacklist'><input id="btn_blacklist" value="Submit" type="button" onclick="Make_Balcklist('0');" style="float: right; margin-bottom: 10px; margin-top: 10px;">
                                </div>
                            </div>

                        </li>
                    </ul>
                </li>


          
             
                <!-- Control Sidebar Toggle Button -->
                <li class="dropdown tasks-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cog fa-spin"></i></a>
                 
        <ul class="dropdown-menu animated fadeInDown pb-20">
            <li style="padding:20px  10px 0px 10px"> <h5>Theme Option</h5></li>
            <li style="float: left; width: 100%; padding:10px;"><a href="javascript:void(0)" data-skin="skin-info-light" style="display: block;" class="clearfix full-opacity-hover">
                <div>
                    <span style="display: block; width: 100%; box-shadow: 1px 2px #70747a; float: left; height: 50px; border-radius: 8px; background: #2962FF; opacity: 1;"></span>
                </div>
            </a></li>

            <li style="float: left; width: 100%; padding:10px;"><a href="javascript:void(0)" data-skin="skin-warning" style="display: block;" class="clearfix full-opacity-hover">
                <div><span style="display: block; width: 100%; float: left; height: 50px; box-shadow: 1px 2px #70747a; background: #1ba78e; border-radius: 8px; opacity: 1;"></span></div>
            </a></li>
            <li style="float: left; width: 100%; padding:10px;"><a href="javascript:void(0)" data-skin="skin-black" style="display: block;" class="clearfix full-opacity-hover">
                <div class="clearfix"><span style="display: block; width: 100%; float: left; box-shadow: 1px 2px #70747a; float: left; height:50px; border-radius: 8px; background: #02007C;"></span></div>
            </a></li>
            <li style="float: left; width: 100%; padding:10px;"><a href="javascript:void(0)" data-skin="skin-primary" style="display: block;" class="clearfix full-opacity-hover">
                <div><span style="display: block; float: left; height: 60px; background: #0f204b; width: 100%; box-shadow: 1px 2px #70747a; float: left; height: 50px; border-radius: 8px;"></span></div>
            </a></li>

        </ul>
   
                </li>
            </ul>
        </div>
    </nav>
    
    <!-- /.control-sidebar -->

    <!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>
    <!-- Header end -->
</header>
<script>
    function openCustomer() {
        window.open("../customer/customer-list.aspx?enq=y", target = '_blank', 'toolbar=0,status=0,width=1360,height=650');
    }


    function openSupplier() {
        window.open("../Supplier/Supplier.aspx?enq=y", target = '_blank', 'toolbar=0,status=0,width=1360,height=650');
    }
</script>

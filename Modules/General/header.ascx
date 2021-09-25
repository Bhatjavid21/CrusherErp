<%@ Control Language="C#" AutoEventWireup="true" CodeFile="header.ascx.cs" Inherits="user_controls_header" %>
<style>
    a:active, a:focus, a:hover {
        outline: 0;
        text-decoration: none;
        /*color: #ffffff;*/
    }

    .skin-info-light .dropdown-item:hover, .dropdown-item:focus {
        color: #fff;
        background: #7499ff;
    }

    .dropdown-item:hover a {
        color: #fff;
    }

    .skin-warning .dropdown-item:hover, .dropdown-item:focus {
        color: #fff;
        background: #36bea6;
    }

    .skin-black .dropdown-item:hover, .dropdown-item:focus {
        color: #fff;
        background: #5a59aa;
    }

    .skin-primary .dropdown-item:hover, .dropdown-item:focus {
        color: #fff;
        background: #0f204b;
    }
    .mt-4{
        margin-top:4px !important
    }
</style>
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
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">

                
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
                            <div class="p-10"><asp:LinkButton ID="lnkBtnSignOut" runat="server" class="btn btn-sm btn-rounded btn-success" OnClick="lnkBtnSignOut_Click"><i class="ion-log-out"></i>Logout</asp:LinkButton></div>
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
                        <li style="padding: 20px  10px 0px 10px">
                            <h5>Theme Option</h5>
                        </li>
                        <li style="float: left; width: 100%; padding: 10px;"><a href="javascript:void(0)" data-skin="skin-info-light" style="display: block;" class="clearfix full-opacity-hover">
                            <div>
                                <span style="display: block; width: 100%; box-shadow: 1px 2px #70747a; float: left; height: 50px; border-radius: 8px; background: #2962FF; opacity: 1;"></span>
                            </div>
                        </a></li>

                        <li style="float: left; width: 100%; padding: 10px;"><a href="javascript:void(0)" data-skin="skin-warning" style="display: block;" class="clearfix full-opacity-hover">
                            <div><span style="display: block; width: 100%; float: left; height: 50px; box-shadow: 1px 2px #70747a; background: #1ba78e; border-radius: 8px; opacity: 1;"></span></div>
                        </a></li>
                        <li style="float: left; width: 100%; padding: 10px;"><a href="javascript:void(0)" data-skin="skin-black" style="display: block;" class="clearfix full-opacity-hover">
                            <div class="clearfix"><span style="display: block; width: 100%; float: left; box-shadow: 1px 2px #70747a; float: left; height: 50px; border-radius: 8px; background: #02007C;"></span></div>
                        </a></li>
                        <li style="float: left; width: 100%; padding: 10px;"><a href="javascript:void(0)" data-skin="skin-primary" style="display: block;" class="clearfix full-opacity-hover">
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

    function enquirylist(e) {
        window.open("../Enquiry/add-edit-enquiry.aspx", "_parent");
        e.stopPropagation();
    }
    function soadd(e) {
        window.open("../Sales_Order/sales-order-add.aspx", "_parent");
        e.stopPropagation();
    }
    function poadd(e) {
        window.open("../Purchase_Order/purchase-order-add.aspx", "_parent");
        e.stopPropagation();
    }
    function invoiceadd(e) {
        window.open("../Invoice/Invoice.aspx", "_parent");
        e.stopPropagation();
    }
    function dnadd(e) {
        window.open("../Delivery_Note/delivery-note-add.aspx", "_parent");
        e.stopPropagation();
    }
    function mrnadd(e) {
        window.open("../MRN/mrn-add.aspx", "_parent");
        e.stopPropagation();
    }
    function gpoadd(e) {
        window.open("#", "_parent");
        e.stopPropagation();
    }
    function paymentadd(e) {
        window.open("#", "_parent");
        e.stopPropagation();
    }
    function receiptadd(e) {
        window.open("#", "_parent");
        e.stopPropagation();
    }
    function debitadd(e) {
        window.open("#", "_parent");
        e.stopPropagation();
    }
    function credit(e) {
        window.open("#", "_parent");
        e.stopPropagation();
    }
    function journalvoucheradd(e) {
        window.open("../Finance/journal_voucher.aspx", "_parent");
        e.stopPropagation();
    }
    function supplierinvoiceadd(e) {
        window.open("#", "_parent");
        e.stopPropagation();
    }
    function sradd(e) {
        window.open("../Sales_Return/sales-return-add.aspx", "_parent");
        e.stopPropagation();
    }
    function pradd(e) {
        window.open("../Purchase_Return/purchase-return-add.aspx", "_parent");
        e.stopPropagation();
    }
    function leaveadd(e) {
        window.open("../hr/hr-leaves-add.aspx", "_parent");
        e.stopPropagation();
    }
    function logisticadd(e) {
        window.open("../Logistics/logistics.aspx", "_parent");
        e.stopPropagation();
    }
    function purchaserequisitionadd(e) {
        window.open("../Purchase-Requisition/purchase_requisition.aspx", "_parent");
        e.stopPropagation();
    }
    function quotationadd(e) {
        window.open("../Quotation/quotation.aspx", "_parent");
        e.stopPropagation();
    }
</script>

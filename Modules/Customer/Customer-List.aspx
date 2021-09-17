<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Customer-List.aspx.cs" Inherits="Customer_Main" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>
<% 
    Session["top_menu"] = "";
    Session["sub_menu"] = "customer";
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
    <title>Customer - Trading ERP</title>

    <!-- Bootstrap 4.0-->

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css" />
    <!-- Data Table-->
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/vendor_components/datatable/datatables.min.css" />
    <!-- Bootstrap extend-->
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css" />
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css" />
    <!-- Date Picker-->
    <%--<link href="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet" type="text/css" />--%>
    <!-- toast CSS -->
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet" />
    <!-- theme style -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <!-- Al Manal skins -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
    <%--<link rel="stylesheet" href="<%=G.B%>assets/vendor_components/fileuploader/jquery.fileuploader.css" />--%>

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-switch/switch.css">

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/icheck/skins/all.css">
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/js/froiden-helper/helper.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.css">
    <style>
        .table > tbody > tr > td {
            line-break: anywhere;
        }
    </style>
</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">
    <div class="wrapper">
        <uc1:uch ID="uch1" runat="server" />
        <uc2:ucs ID="ucs1" runat="server" />
        <%--<div id="div_header"></div>--%>
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <input type='hidden' value='0' id='Hid_CustomerMain' />
            <input type='hidden' value='0' id="hid_Contact_Person" />
            <input type='hidden' value='0' id="hid_External_Party_Address" />
            <input type='hidden' value='0' id="hid_Doc" />
            <input type='hidden' value='0' id="hid_readOnly" />
            <input type='hidden' value='0' id="hid_Open_From_Enquiry_Page" runat="server" />
            <input type="hidden" name="hdf_branch_id" id="hdf_branch_id" runat="server">
            <input type='hidden' value='1' id="hid_customer_type" />
            <input type='hidden' value='0' id="hid_accounts_access" />
            <input type="hidden" id="hid_Ledger_Account_Id" value="0" />
            <input type="hidden" id="hid_Save_Btn_Values" value="0" />
            <input type="hidden" id="Cus_Bal_Id" value="" />
            <input type="hidden" id="Budget_Id" value="" />
            <input type="hidden" id="hid_page" value="0" />

            <!-- Main content -->
            <section class="content mt-20">
                <div class="box">
                    <div class="box-header display-none">
                        <div class="row m-10">
                            <div class="col-10">
                                <h4 class="page-title" runat="server" id="lbl_error">Customer List</h4>

                            </div>

                        </div>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <%--id="stickyHeader"--%>
                        <div class="row">
                            <div class="col-md-2 col-sm-3  pr-5">
                                <div class="form-group validate">
                                    <%-- <label class="mb-0" for="exampleInputEmail1">Branch</label>--%>
                                    <select class="form-control select2   enq-dropdown" onchange="View(0);" runat="server" id="DDL_Branch" aria-invalid="false"></select>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3 ">
                                <div class="form-group ">
                                    <%--   <label class="mb-0" for="exampleInputEmail1">Search Customer</label>--%>
                                    <div class="input-group">

                                        <input type="text" id="txtinput" onkeyup="GetSuggestions(0)" placeholder="Search" title="This search brings all relevant results from Customer Name, Account Code and Contact Person Name fields." class="form-control  enq-txtbx-pd"><%--attsrch--%>
                                        <span class="search-btn"><i class="ti-search"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4  col-sm-3 pl-5 pr-5">
                                <div class="form-group ">
                                    <%--    <label class="mb-0" for="exampleInputEmail1">Customer Status</label>--%>
                                    <div class="input-group">

                                        <table>
                                            <tr>
                                                <td>
                                                    <div class="form-group input-group mb-0 ml-0">
                                                        <div class="checkbox text-xs-left  ">
                                                            <ul class="icheck-list">

                                                                <li>
                                                                    <div class="iradio_line-red grp2 checked leave-left-border checked" id="div_all" onclick="filter(this, '0')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="All" id="btn_all" data-id="0" />
                                                                        All<ins class="iCheck-helper"></ins>
                                                                    </div>
                                                                </li>

                                                                <li>
                                                                    <div class="iradio_line-red grp2" id="div_prospect" onclick="filter(this, '1')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Prospects" id="btn_prospect" data-id="0" />
                                                                        Prospects<ins class="iCheck-helper"></ins>
                                                                    </div>
                                                                </li>

                                                                <li>
                                                                    <div class="iradio_line-red grp2" id="div_customers" onclick="filter(this, '2')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Customers" id="btn_customers" data-id="0" />
                                                                        Customers<ins class="iCheck-helper"></ins>
                                                                    </div>
                                                                </li>

                                                                <li>
                                                                    <div class="iradio_line-red grp2" id="div_blacklisted" onclick="filter(this, '4')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Blacklisted" id="btn_blacklisted" data-id="0" />
                                                                        Blacklisted<ins class="iCheck-helper"></ins>
                                                                    </div>
                                                                </li>

                                                                <li>
                                                                    <div class="iradio_line-red grp2 leave-right-border" id="div_suspended" onclick="filter(this, '5')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Suspended" id="btn_suspended" data-id="0" />
                                                                        Suspended<ins class="iCheck-helper"></ins>
                                                                    </div>
                                                                </li>

                                                                <li><i class="mdi mdi-information-outline" title="Clicking on any of the tiles filters the Listed Customers based on their Status"></i></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>

                                        </table>


                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2 col-sm-3 ">
                                <div class="form-group  validate">
                                    <%--  <label class="mb-0" for="exampleInputEmail1">Limit</label>--%>
                                    <select class="form-control select2    enq-dropdown " onchange="View(0);" runat="server" id="ddl_limit" aria-invalid="false">
                                        <option>Default</option>
                                        <option>100 Rows</option>
                                        <option>1000 Rows</option>
                                        <%--<option>Half of All Data</option>
                                        <option>All Data</option>--%>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-6 ">
                                <span id="span_excel">
                                    <a href="#" id="btn_Download_Leave" target="_blank" class="btn btn-success right" title="Download Customer Checklist" onclick="Excel_Data()"><i class="fa fa-download"></i></a>
                                </span>

                                <button class="btn btn-success right mr-5" data-toggle="modal" data-target="#myModal" id="inputModal" onclick="Bind_All_DDLs_For_Cust_General(0);GetLedgerAccountsForNewCustomer(false,0);"><i class="mdi mdi-plus plusicon"></i>New</button>

                            </div>
                        </div>


                        <hr />
                        <div class="row ">
                            <div class="col-md-12 mb-15">
                                <%--<div class="tableFixHead">--%>
                                <div>
                                    <table class="table table-hover table-bordered table-striped table-responsive mb-10">
                                        <thead>
                                            <tr>
                                                <th onclick='setSort("Account_Code")' class="sorting fntbld" style='cursor: pointer; width: 12%' id="Account_Code">Code</th>
                                                <th onclick='setSort("Cus_Company_Name")' class="sorting fntbld" id="Cus_Company_Name" style='cursor: pointer; width: 38.7%'>Name</th>

                                                <th onclick='setSort("Customer_Type")' class="sorting fntbld" style='cursor: pointer; width: 12%' id="Customer_Type">Status</th>
                                                <th onclick='setSort("Phone_Number")' class="sorting fntbld" style='cursor: pointer; width: 15%' id="Phone_Number">Phone</th>
                                                <%--<th onclick='setSort("Sales_Man")' class="sorting fntbld" style='cursor: pointer;' id="Sales_Man">Sales Man</th>--%>
                                                <th onclick='setSort("Credit_Facility")' class="sorting fntbld" style='cursor: pointer; width: 12%' id="Credit_Facility">Credit Facility</th>
                                                <th class="fntbld">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbody_Customer_List"></tbody>
                                        <%--    <tbody></tbody>--%>
                                    </table>
                                    <%-- </div>--%>

                                    <%--                            <div class="table-responsive" style="overflow:auto; max-height:330px; width: 100%;">
                                <table class="table table-hover table-bordered table-striped">
                                    <tbody id="tbody_Customer_List"></tbody>
                                </table>
                            </div>--%>
                                </div>
                            </div>
                            <div class="box-footer mb-40">
                            </div>

                            <%--<uc3:ucf ID="ucf1" runat="server" />--%>
                        </div>
                        <div class="box-footer mb-40" id="Div_Paging"></div>
                    </div>
                </div>


            </section>
            <!-- /.content -->
        </div>
        <uc3:ucf ID="ucf1" runat="server" />
        <!-- /.content-wrapper -->
        <!-- Popup Model Plase Here -->
        <div id="myModal" class="modal fade  bs-example-modal-lg" tabindex="" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="myModalLabel">Add Prospect</h6>
                        <button type="button" class="close" data-dismiss="modal" onclick="ClearFields_General();Remove_Customer_Id();"
                            aria-hidden="true">
                            ×</button>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item"><a class="nav-link active show" aria-selected="true" data-toggle="tab"
                                href="#general" id="gen_tab_lnk" role="tab"><span class="hidden-sm-up"><i class="ion-home"></i></span><span class="hidden-xs-down">General</span></a> </li>
                            <li class="nav-item disabled" onclick="View_Contact_Person(0)"><a class="nav-link disabled"
                                id="cp_tab_lnk" data-toggle="tab" href="#cperson" role="tab"><span class="hidden-sm-up">
                                    <i class="ion-person"></i></span><span class="hidden-xs-down">Contact Person</span></a>
                            </li>
                            <li class="nav-item disabled" onclick="View_external_party(0);"><a class="nav-link disabled"
                                id="address_tab_lnk" data-toggle="tab" href="#addresses" role="tab"><span class="hidden-sm-up">
                                    <i class="ion-email"></i></span><span class="hidden-xs-down">Address</span></a>
                            </li>
                            <li class="nav-item disabled" id="tab_accounts_info" onclick="tabAccInfo()"><a class="nav-link disabled" data-toggle="tab" href="#account"
                                id="account_info_tab_lnk" role="tab"><span class="hidden-sm-up"><i class="ion-email"></i></span><span class="hidden-xs-down">Accounts Info</span></a> </li>
                            <li class="nav-item disabled" onclick="View_Doc(0);Bind_All_DDLs_For_Document(0);"><a
                                id="doc_tab_lnk" class="nav-link disabled" data-toggle="tab" href="#documents"
                                role="tab"><span class="hidden-sm-up"><i class="ion-email"></i></span><span class="hidden-xs-down">Documents</span></a></li>
                            <%--  <li class="nav-item disabled"><a
                                id="add_details_tab_lnk" class="nav-link disabled" data-toggle="tab" href="#addtional_Details"
                                role="tab"><span class="hidden-sm-up"><i class="ion-email"></i></span><span class="hidden-xs-down">Additional Details</span></a></li>--%>
                        </ul>
                        <div class="tab-content ">
                            <!-- General Tab starts here -->
                            <div class="tab-pane active pt-10" id="general" role="tabpanel">
                                <div class="row">
                                    <div class="col-sm-12 col-lg-6">
                                        <div class="form-group">
                                            <label onclick="GetDivisions();">
                                                Name <span class="red-bold">*</span></label>
                                            <div class=" controls">
                                                <%--<input type="text" id="txt_cus_company_name" maxlength="50" name="name" onblur="return ValidateOne(this);" class="form-control    " required data-validation-required-message="Name is required">--%>

                                                <select class="form-control    enq-dropdown h27" id="txt_cus_company_name" onblur="return ValidateOne(this);">
                                                    <option value="0">
                                                        <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>
                                                Arabic Name
                                            </label>
                                            <div class=" controls">
                                                <input type="text" id="txt_Customer_Arabic_Name" maxlength="50" class="form-control " />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="">
                                                Short Name <span class="red-bold">*</span></label>
                                            <div class=" controls">
                                                <input type="text" id="txt_Cus_Company_Short_Name" maxlength="10" name="name" onkeyup="Only_String(this);"
                                                    onblur="return ValidateOne(this);" class="form-control    " required data-validation-required-message="Name is required">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="">
                                                Customer Branch</label>
                                            <div class=" controls">
                                                <input type="text" name="branch" id="txt_cus_company_branch" maxlength="30" class="form-control    "
                                                    required data-validation-required-message="Branch is required">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="">
                                                Email <span class="red-bold">*</span>
                                            </label>
                                            <div class=" controls">
                                                <input type="email" name="email" id="txt_email" maxlength="50" onblur="return ValidateOne(this);"
                                                    class="form-control    " required data-validation-required-message="Email is required">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="">Phone</label>
                                            <div class="controls">
                                                <input type="tel" name="phone" id="txt_phone_number" class="form-control "
                                                    required data-validation-required-message="Phone is required" onkeypress="return phoneno(event);" maxlength="25">
                                                <%--  onkeydown="javascript:return isNumeric(window.event.keyCode,this)"--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-lg-6">
                                        <div class="form-group">
                                            <label class="">
                                                Fax</label>
                                            <div class="">
                                                <input type="text" id="txt_fax" class="form-control  " onkeypress="return phoneno(event);" maxlength="25">
                                            </div>
                                            <label class="">
                                                Website</label>
                                            <div class="">
                                                <input type="website" id="txt_website" maxlength="55" class="form-control    " />
                                            </div>
                                            <label class="">
                                                Division<span class="red-bold">*</span></label>

                                            <div class="" id="div_DDL_Get_Division">
                                                <%--<select class="form-control  select2  enq-dropdown" name="division" id="DDL_Get_Division" multiple="multiple">
                                                                        <option value="0">parvaiz</option>
                                                                    </select>--%>
                                            </div>


                                            <%--  <div class="col-md-12" id="div_DDL_Get_Division">
                                               <select class="form-control mb-10" name="division" id="DDL_Get_Division">
                                                    <option value="0">
                                                        <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                </select>



                                            </div>--%>
                                            <label class="">
                                                Salesman <span class="red-bold">*</span></label>
                                            <div class="" id="div_DDL_Get_Salesman">
                                                <%--  <select class="form-control  select2  enq-dropdown mb-10" name="salesman" id="DDL_Get_Salesman" onblur="return ValidateOne(this);">
                                                    <option value="0">
                                                        <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                </select>--%>
                                            </div>
                                            <label class="">
                                                Approver <span class="red-bold">*</span></label>
                                            <div class="" id="div_DL_Get_Approver">
                                                <select class="form-control    enq-dropdown h27" name="approver" id="DDL_Get_Approver" onblur="return ValidateOne(this);">
                                                    <option value="0">
                                                        <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 ">
                                        <div class=" box-footer">


                                            <button type="button" class="btn btn-dark  " id="btn_Cancel_Cus_Gen"
                                                onclick="ClearFields_General();Remove_Customer_Id();" data-dismiss="modal">
                                                <i class="ti-trash"></i>&nbsp;Cancel
                                            </button>


                                            <button type="button" id="btn_Save_Continue_GenCus" onclick="exe('bigGen')" class="btn btn-success right">
                                                <i class="ti-save-alt"></i>&nbsp;Save &amp; Continue
                                            </button>
                                            <button class="btn btn-success right mr-5" id="btn_general_stay" onclick="exe('gen_Stay');"><i class="ti-save-alt"></i>&nbsp;Save &amp; Stay</button>
                                            <button type="button" id="btn_general_save" onclick="exe('gen');"
                                                class="btn btn-success  right mr-5">
                                                <i class="ti-save-alt"></i>&nbsp;Save &amp; Exit
                                            </button>
                                        </div>
                                    </div>
                                </div>



                                <!--<button type="button" id="btn_update_General" onclick="Update_General(0);" style="float: right;"
                                                    class="btn btn-success btn-outline">
                                                    <i class="ti-save-alt"></i>Save
                                                </button>-->




                            </div>
                            <!-- Contact Tab starts here -->
                            <div class="tab-pane" id="cperson" role="tabpanel">
                                <div class="row" id="rwplus">
                                    <div class="col-md-12 ">
                                        <div class="mt-10">
                                            <div class="box-controls pull-right">
                                                <div class="box-header-actions" onclick="ClearFields_Contact_Person(0);" id="Div_Input_Box_Opner_CP">
                                                    <button data-toggle="tooltip" id="btn-contact-add" class="btn btn-success"><i class="mdi mdi-plus plusicon"></i>&nbsp;New</button>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row  ">
                                    <div class="col-sm-12 hide" id="rwcontact-add">
                                        <div class="row ">
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>
                                                        Name <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control    " id="txt_name" onkeyup="Only_String(this);"
                                                        onblur="return ValidateOne(this);" maxlength="50">
                                                </div>
                                                <!-- /.form-group -->
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>
                                                        Mobile <span class="text-danger">*</span>
                                                    </label>
                                                    <input type="text" class="form-control    " id="txt_mobile" onkeypress="return phoneno(event);" maxlength="25">
                                                </div>
                                                <!-- /.form-group -->
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>
                                                        Email <span class="text-danger">*</span></label>
                                                    <input type="email" class="form-control    " id="txt_email_id" maxlength="60">
                                                </div>
                                                <!-- /.form-group -->
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>
                                                        Branch</label>
                                                    <input type="text" class="form-control    " id="txt_branch" maxlength="30">
                                                </div>
                                                <!-- /.form-group -->
                                            </div>
                                            <%--  </div>
                                                    <div class="row">--%>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>
                                                        Department</label>
                                                    <input type="text" class="form-control    " id="txt_department" maxlength="60">
                                                </div>
                                                <!-- /.form-group -->
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>
                                                        Designation</label>
                                                    <input type="text" class="form-control    " id="txt_designation" maxlength="30">
                                                </div>
                                                <!-- /.form-group -->
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>
                                                        Phone <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control " onkeypress="return phoneno(event);" maxlength="25" id="txt_phone_number_CP">
                                                </div>
                                                <!-- /.form-group -->
                                            </div>
                                            <div class="col-md-6 col-12">
                                                <div class="form-group">
                                                    <label>
                                                        Fax</label>
                                                    <input type="text" class="form-control " id="txt_fax_CP" onclick="phoneNumberCheck(document.form1.phone)" onkeypress="return phoneno(event);" maxlength="25">
                                                </div>
                                                <!-- /.form-group -->
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12 ">
                                                <div class=" ">
                                                    <button type="button" class="btn btn-success right" id="btn_save_Contact_Person" onclick="exe('contact_person')">
                                                        <i class="ti-save-alt"></i>&nbsp;Save</button>
                                                    <button type="button" id="btn-contact-close"
                                                        class="btn btn-dark">
                                                        <i class="ti-trash"></i>&nbsp;Cancel</button>
                                                    <!--id="btn-contact-save"
                                                                    <button type="button" class="btn btn-success" id="btn_update_Contact_Person" onclick="Update_Contact_Person(0)"                                                                        style="float: right;">
                                                                        <i class="ti-save-alt"></i>Update</button>-->
                                                    <!--<button type="button" class="btn btn-default btn-outline mr-1" id="btn_cancel_CP"  onclick="ClearFields_Contact_Person();" data-dismiss="modal">-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 mt-10">
                                        <div class="form-group">
                                            <table id="dtcontact" class="table table-hover table-bordered table-striped table-responsive">
                                                <thead>
                                                    <tr>
                                                        <th>Name
                                                        </th>
                                                        <th>Mobile
                                                        </th>
                                                        <th>Email
                                                        </th>
                                                        <th>Phone
                                                        </th>
                                                        <th>Department
                                                        </th>
                                                        <th>Action
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbody_List_CP">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button class="btn btn-success right" onclick="Go_To_Next_Tab('contact');">Next <i class="fa fa-arrow-right"></i></button>
                                </div>
                            </div>
                            <!-- Address Tab starts here -->
                            <div class="tab-pane" id="addresses" role="tabpanel">
                                <div class="row" id="rwaddplus">
                                    <div class="col-md-12 h-40">
                                        <div class="mt-10">
                                            <div class="box-controls pull-right">
                                                <div class="box-header-actions">
                                                    <button class="btn btn-success" data-toggle="tooltip" id="btn-address-add" onclick="ddl_external_party_country(0);ClearFields_External_Party_Address();">
                                                        <i class="mdi mdi-plus plusicon"></i>&nbsp;New</button>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-sm-12 hide display-none" id="rwaddress-add">
                                        <div class="row">
                                            <div class="">
                                                <div class="">
                                                    <%--<h5 class="modal-title">Add Address</h5>--%>
                                                    <div class="box-tools pull-right">
                                                        <ul class="box-controls">
                                                            <li>
                                                                <%--  <button type="button" id="btn-address-close" onclick="ClearFields_External_Party_Address();"
                                                                    class="close" style="font-size: 17px; color: #455A64;" aria-hidden="true">
                                                                    ×</button>--%>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="">
                                                    <div class="row mauto">
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Address <span class="text-danger">*</span></label>
                                                                <input type="text" class="form-control    " id="txt_external_party_address" maxlength="150"
                                                                    onblur="return ValidateOne(this);">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Post Office</label>
                                                                <input type="text" class="form-control" maxlength="10" id="txt_external_party_post_office">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Country <span class="text-danger">*</span></label>
                                                                <!--<input type="text" class="form-control mb-10" >-->
                                                                <div class="" id="div_external_party_country">
                                                                    <select class="form-control    enq-dropdown h27" id="ddl_external_party_country" name="country" onblur="return ValidateOne(this);">
                                                                        <option value="0">
                                                                            <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    State <span class="text-danger">*</span></label>
                                                                <div class="" id="div_external_party_state">
                                                                    <select class="form-control    enq-dropdown h27" id="ddl_external_party_state" name="state" onblur="return ValidateOne(this);">
                                                                        <option value="0">.......</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <%--  </div>
                                                    <div class="row">--%>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    City <span class="text-danger">*</span></label>
                                                                <div class="" id="div_external_party_city">
                                                                    <select class="form-control    enq-dropdown h27" id="ddl_external_party_city" name="city" onblur="return ValidateOne(this);">
                                                                        <option value="0">.......</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Zip</label>
                                                                <input type="text" class="form-control    " id="txt_external_party_zip" maxlength="12"
                                                                    onkeydown="javascript:isNumeric(window.event.keyCode,this)">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="col-md-12   mr-10">
                                                    <button type="button" class="btn btn-success right mb-5" id="btn_save_External_Party_Address"
                                                        onclick="exe('address')">
                                                        <i class="ti-save-alt"></i>&nbsp;Save</button>
                                                    <button type="button" id="btn-address-close" onclick="ClearFields_External_Party_Address();"
                                                        class="btn btn-dark">
                                                        <i class="ti-trash"></i>&nbsp;Cancel</button>
                                                    <!--<button type="button" class="btn btn-success" id="btn_update_External_Party_Address"
                                                                            onclick="Update_External_Party_Address(0)" style="float: right;">
                                                                            <i class="ti-save-alt"></i>Update
                                                                        </button>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12 mt-10">
                                        <div class="form-group">
                                            <table id="dtaddress" class="table table-hover table-bordered table-striped table-responsive">
                                                <thead>
                                                    <tr>
                                                        <th>Address
                                                        </th>
                                                        <th>Country
                                                        </th>
                                                        <th>State
                                                        </th>
                                                        <th>City
                                                        </th>
                                                        <th>Zip
                                                        </th>
                                                        <th>Action
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbody_List_External_Party_Address">
                                                </tbody>
                                            </table>
                                        </div>

                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button class="btn btn-success right" onclick="Go_To_Next_Tab('address');">Next <i class="fa fa-arrow-right"></i></button>
                                </div>
                            </div>
                            <!-- Account Tab starts here -->
                            <div class="tab-pane pt-20" id="account" role="tabpanel">

                                <div class="row">
                                    <div class="col-sm-12 col-lg-6">
                                        <div class="form-group">
                                            <label class="">
                                                Account Code <span class="text-danger">*</span></label>
                                            <div class="">
                                                <input type="text" class="form-control    " maxlength="10" id="txt_account_code"
                                                    onblur="return ValidateOne(this);" onkeydown="javascript:return isNumeric(window.event.keyCode,this)">
                                            </div>
                                            <label class="">
                                                Opening Balance <span class="text-danger">*</span></label>
                                            <div class="">
                                                <input type="text" class="form-control  isDecimalNumber" maxlength="10" id="txt_Opening_Balance" value="0.00">
                                            </div>
                                            <label class="">
                                                Openinig Balance Type <span class="text-danger">*</span></label>
                                            <div class="">
                                                <select class="form-control select2   enq-dropdown h27" onblur="return ValidateOne(this);" id="ddl_Opening_Balance_Type">
                                                    <option value="0" selected>Select</option>
                                                    <option value="Cr">Cr</option>
                                                    <option value="Dr">Dr</option>
                                                </select>
                                            </div>
                                            <div class="">
                                                <div class="checkbox">
                                                    <input type="checkbox" id="chk_subaccount">
                                                    <label for="chk_subaccount">
                                                        Link Supplier</label>
                                                </div>
                                            </div>
                                            <div class="hide" id="dp-account">
                                                <label class="">
                                                    Supplier Account <span class="text-danger">*</span></label>
                                                <div class="" id="div_DDL_Get_Parent_Account">
                                                    <select class="form-control    enq-dropdown h27" id="DDL_Get_Parent_Account" name="parentaccount">
                                                        <option value="0">
                                                            <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                    </select>
                                                </div>
                                            </div>
                                            <label class="">
                                                CR Number   <span class="text-danger">*</span></label>
                                            <div class="">
                                                <input type="text" class="form-control    " maxlength="15" onblur="return ValidateOne(this);"
                                                    id="txt_cr_number">
                                            </div>
                                            <label class="">
                                                VAT Number  <span class="text-danger">*</span></label>
                                            <div class="">
                                                <input type="text" class="form-control    " maxlength="15" onblur="return ValidateOne(this);"
                                                    id="txt_vat_number">
                                            </div>
                                            <div class="">
                                                <div class="checkbox">
                                                    <input type="checkbox" id="chk_credit">
                                                    <label for="chk_credit">
                                                        Credit Facility</label>
                                                </div>
                                            </div>
                                            <div class="hide" id="dp-credit">
                                                <label class=""><span class="text-danger">*</span>Credit days</label>
                                                <div class="">
                                                    <div class="controls">
                                                        <input type="text" name="crdays" id="txt_credit_days" onkeydown="javascript:return isNumeric(window.event.keyCode,this)"
                                                            class="form-control    " maxlength="3" required data-validation-containsnumber-regex="(\d)+"
                                                            data-validation-containsnumber-message="No Characters Allowed, Only Numbers">
                                                    </div>
                                                </div>
                                                <label class="">
                                                    Credit Amount <span class="text-danger">*</span></label>
                                                <div class="">
                                                    <div class="controls">
                                                        <input type="text" name="cramount" id="txt_credit_amount" onkeydown="javascript:return isNumeric(window.event.keyCode,this)"
                                                            class="form-control    " maxlength="7" required data-validation-containsnumber-regex="(\d)+"
                                                            data-validation-containsnumber-message="No Characters Allowed, Only Numbers">
                                                    </div>
                                                </div>
                                            </div>
                                            <label class="">
                                                Currency    <span class="text-danger">*</span></label>
                                            <div class="" id="div_Get_DDL_Currency">
                                                <select class="form-control    enq-dropdown h27" id="ddl_currency_id" onblur="return ValidateOne(this);"
                                                    name="currency">
                                                    <option value="0">
                                                        <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-lg-6">
                                        <div class="form-group">
                                            <label class="">
                                                Bank Name</label>
                                            <div class="">
                                                <input type="text" class="form-control    " maxlength="40" onkeyup="Only_String(this);"
                                                    id="txt_bank_name">
                                            </div>
                                            <label class="">
                                                Branch Name</label>
                                            <div class="">
                                                <input type="text" class="form-control    " maxlength="30" id="txt_bank_branch_name"
                                                    onkeyup="Only_String(this);">
                                            </div>
                                            <label class="">
                                                Account Holder Name</label>
                                            <div class="">
                                                <input type="text" class="form-control    " maxlength="30" onkeyup="Only_String(this);"
                                                    id="txt_account_holder_name" />
                                            </div>
                                            <label class="">
                                                Account Number</label>
                                            <div class="">
                                                <div class="controls">
                                                    <input type="text" name="accno" id="txt_account_number" onkeydown="javascript:return isNumeric(window.event.keyCode,this)"
                                                        class="form-control    " maxlength="16" required data-validation-containsnumber-regex="(\d)+"
                                                        data-validation-containsnumber-message="No Characters Allowed, Only Numbers">
                                                </div>
                                            </div>
                                            <label class="">
                                                IBAN Number</label>
                                            <div class="">
                                                <input type="text" class="form-control    " id="txt_iban_number" maxlength="20">
                                            </div>
                                            <label class="">
                                                Swift Code</label>
                                            <div class="">
                                                <input type="text" class="form-control    " id="txt_swift_code" maxlength="20">
                                            </div>
                                            <div id="div_balcklistpart">
                                                <div class="" id="div_blacklist">
                                                    <div class="checkbox">
                                                        <input type="checkbox" id="chk_blacklisted" class="form-control    ">
                                                        <label for="chk_blacklisted">
                                                            Blacklisted</label>
                                                    </div>
                                                </div>
                                                <div class="hide" id="dp-blacklist">
                                                    <label class="">
                                                        Reason <span class="red-bold">*</span></label>
                                                    <div class="controls col-md-12">
                                                        <textarea name="bkl-reason" id="txt_blacklisted_reason" onkeyup="Only_String(this);"
                                                            maxlength="300" class="form-control    " required></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="box-footer  ">
                                            <button type="button" class="btn btn-dark " id="btn_Cancel_Account_Info"
                                                onclick="ClearFields_AccountInfo();" data-dismiss="modal">
                                                <i class="ti-trash"></i>&nbsp;Cancel
                                            </button>
                                            <button type="button" class="btn btn-success right " id="btn_Save_Continue_AccountInfo" onclick="save_Accounts_Info('continue');">
                                                <i class="ti-save-alt"></i>&nbsp;Save &amp; Continue
                                            </button>
                                            <button type="button" class="btn btn-success right mr-5" id="btn_Save_Exit_AccountInfo" onclick="save_Accounts_Info('stay');">
                                                <i class="ti-save-alt"></i>&nbsp;Save &amp; Stay
                                            </button>
                                            <button type="button" class="btn btn-success  right mr-5" id="btn_txtAccountInfo" onclick="save_Accounts_Info('exit');">
                                                <i class="ti-save-alt"></i>&nbsp;Save & Exit
                                            </button>
                                        </div>
                                    </div>
                                </div>



                            </div>
                            <!-- Document Tab starts here -->
                            <div class="tab-pane" id="documents" role="tabpanel">
                                <div class="row" id="rwdocplus">
                                    <div class="col-md-12 h-40">
                                        <div class="mt-10">
                                            <div class="box-controls pull-right">
                                                <div class="box-header-actions">
                                                    <button class="btn btn-success" data-toggle="tooltip" id="btn-doc-add" onclick="ClearFields_Doc();"><i class="mdi mdi-plus plusicon"></i>&nbsp;New</button>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-sm-12 hide" id="rwdoc-add">
                                        <div class="row">
                                            <div class="">
                                                <div class="">
                                                    <%-- <h5 class="modal-title">Add Documents</h5>--%>
                                                    <div class="box-tools pull-right">
                                                        <ul class="box-controls">
                                                            <li>
                                                                <%--   <button type="button" id="btn-doc-close" onclick="ClearFields_Doc();" class="close"
                                                                        style="font-size: 17px; color: #455A64;" aria-hidden="true">
                                                                        ×</button>--%>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="">
                                                    <div class="row mauto">
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Document name <span class="text-danger">*</span></label>
                                                                <div id="div_ddl_doc_type">
                                                                    <select class="form-control    enq-dropdown h27" id="Document_Type_Id" onblur="return ValidateOne(this);"
                                                                        name="doctype">
                                                                        <option value="0">
                                                                            <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Document Number</label>
                                                                <input type="text" class="form-control    " id="Document_Number" maxlength="40">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Issuing Authority</label>
                                                                <input type="text" class="form-control    " id="Issuing_Athourity" maxlength="40">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Expiry Date</label>
                                                                <input class="form-control    " type="date" placeholder="dd/mm/yyyy" id="Expiry_Date"
                                                                    maxlength="30">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <%--   </div>
                                                    <div class="row">--%>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Assign to</label>
                                                                <div id="div_Assigned_To">
                                                                    <select class="form-control    enq-dropdown h27" name="salesman" id="Assigned_To" onblur="return ValidateOne(this);">
                                                                        <option value="0">
                                                                            <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Upload <span class="text-danger">*</span></label>
                                                                <div class="controls">
                                                                    <form>
                                                                        <input type="file" name="File_Name" id="File_Name" onchange="upload_File('Customer/Documents','0','File_Name')" onblur="return ValidateOne(this);" class="form-control" />
                                                                        <input type='hidden' value="" id='hid_fileName' />
                                                                        <span id="spn_loading" style="color: blue; display: none;">Uploading...</span>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                    </div>


                                                    <div class="col-md-12 mr-10 ">
                                                        <button type="button" class="btn btn-success right mb-5" id="btn_save_doc" onclick="exe('doc')">
                                                            <i class="ti-save-alt"></i>&nbsp;Save
                                                        </button>
                                                        <button class="btn btn-dark" id="btn-doc-close" onclick="ClearFields_Doc();"><i class="ti-trash"></i>&nbsp;Cancel</button>
                                                        <!--<button type="button" class="btn btn-success" id="btn_update_doc" onclick="Update_Doc(0)"
                                                                        style="float: right;">
                                                                        <i class="ti-save-alt"></i>Update
                                                                    </button>-->
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12 mt-10">
                                        <div class="form-group">
                                            <table id="dtdoc" class="table table-hover table-bordered table-striped table-responsive">
                                                <thead>
                                                    <tr>
                                                        <th>Document Name
                                                        </th>
                                                        <th>Document Number
                                                        </th>
                                                        <th>Expiry Date
                                                        </th>
                                                        <th>Assign To
                                                        </th>
                                                        <th>Document
                                                        </th>
                                                        <th>Action
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbody_List_Doc">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button class="btn btn-success right" onclick="Go_To_Next_Tab('documents');">Next <i class="fa fa-arrow-right"></i></button>
                                </div>
                            </div>
                            <!-- Additional Details Tab starts here -->
                            <div class="tab-pane" id="addtional_Details" role="tabpanel">
                                <div class="col-md-12 h-10">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <div id="AddBalances" class="modal fade  bs-example-modal-lg" tabindex="" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" id="ModalLabel">Add Balance</h6>
                        <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">
                            ×</button>
                    </div>
                    <div class="modal-body">

                        <div class="row" id="rwaddbalanceplus">
                            <div class="col-md-12 h-40">
                                <div class="mt-10">
                                    <div class="box-controls pull-right">
                                        <div class="box-header-actions">
                                            <button class="btn btn-success" data-toggle="tooltip" id="btn-add">
                                                <i class="mdi mdi-plus plusicon"></i>&nbsp;New</button>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">

                            <div class="col-sm-12 hide display-none mt-0" id="rwaddbalance-add">
                                <div class="row mauto">
                                    <div class="col-md-6 col-12">
                                        <div class="form-group">
                                            <label>
                                                Date <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="txtBalDate" />

                                        </div>
                                        <!-- /.form-group -->
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="form-group">
                                            <label>
                                                Invoice <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" maxlength="30" id="txt_Invoice">
                                        </div>
                                        <!-- /.form-group -->
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="form-group">
                                            <label>
                                                Debit <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" onkeydown=' return isNumeric(window.event.keyCode,this);' id="txt_Debit" onkeyup="calculateBal()" value="0.00">
                                        </div>
                                        <!-- /.form-group -->
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="form-group">
                                            <label>
                                                Credit <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" onkeydown=' return isNumeric(window.event.keyCode,this);' id="txt_Credit" onkeyup="calculateBal()" value="0.00">
                                        </div>
                                        <!-- /.form-group -->
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <div class="form-group">
                                            <label>
                                                Balance <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" readonly id="txt_Balance" value="0.00">
                                        </div>
                                        <!-- /.form-group -->
                                    </div>
                                </div>
                                <div class="col-md-12   mr-10">
                                    <button id="btnSaveBalance" class="btn btn-success right">Save</button>
                                    <button type="button" id="btn-addbalance-close"
                                        class="btn btn-dark">
                                        <i class="ti-trash"></i>&nbsp;Cancel</button>

                                </div>

                            </div>
                        </div>


                    </div>
                    <div class="box-footer mb-30">
                          <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="lnk-post" data-toggle="tab" onclick="" href="#OpenInv" role="tab">

                                    <span class="hidden-xs-down">Open Invoices</span></a> </li>
                            <li class="nav-item disabled">
                                <a class="nav-link " id="lnk-posted" data-toggle="tab"  href="#ClosedInv" role="tab">

                                    <span class="hidden-xs-down">Closed Invoices</span></a> </li>

                        </ul>
                          <div class="tab-content">
                          <div id="OpenInv" class="tab-pane active" role="tabpanel">
                        <table id="tblAddbalance" class="table table-hover table-bordered table-striped table-responsive">
                            <thead>
                                <tr>
                                    <th>Invoice Date 
                                    </th>
                                    <th>Invoice No 
                                    </th>
                                    <th>Debit
                                    </th>
                                    <th>Credit
                                    </th>
                                    <th>Balance
                                    </th>
                                    <th>Paid Status
                                    </th>
                                    <th>Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tbody_tblAddbalance">
                                <tr>
                                    <td><span>Loading...</span></td>
                                </tr>
                            </tbody>
                        </table>
                        </div>
                        <div id="ClosedInv" class="tab-pane" role="tabpanel">
                        <table id="tblAddbalanceClosed" class="table table-hover table-bordered table-striped table-responsive">
                            <thead>
                                <tr>
                                    <th>Invoice Date 
                                    </th>
                                    <th>Invoice No 
                                    </th>
                                    <th>Debit
                                    </th>
                                    <th>Credit
                                    </th>
                                    <th>Balance
                                    </th>
                                    <th>Paid Status
                                    </th>
                                    <th>Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="tbody_tblAddbalanceClosed">
                                <tr>
                                    <td><span>Loading...</span></td>
                                </tr>
                            </tbody>
                        </table>
                        </div>
                          </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade  bs-example-modal-lg" id="SetDatesForSOA" data-backdrop="static">
            <div class="modal-dialog ">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Set Invoice Dates</h5>
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body pt-5">
                        <div class="row">

                            <div class="col-md-6">
                                <label>From-To Date</label>
                                <div class="pl-5">
                                    <input type='text' id="txtDateFrom" class='form-control t enq-txtbx-pd  pull-right dtleave' />
                                    <input type='date' id="id=txtDateTo" class='form-control enq-txtbx-pd  hide pull-right dtfull' />

                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Division</label>
                                <select class="form-control select2   enq-dropdown" id="ddlDivision">
                                    <option value="0">Select</option>
                                </select>
                            </div>


                        </div>
                        <div class="row mt-10">
                            <div class="col-md-12">
                                <button class="btn btn-success right" onclick="RedirectToSOA();">
                                    Submit</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="AddBudget" class="modal fade  bs-example-modal-lg" tabindex="" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" >Add Budget</h6>
                        <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">
                            ×</button>
                    </div>
                    <div class="modal-body">
 <div class="row">
    <div class="col-md-3">
        <label>Budget Amount <span class="text-danger">*</span></label><input type="text" class="form-control" onblur='Mformat(this.id,this.value)' onkeydown=' return isNumeric(window.event.keyCode,this);' id="txtBudgetAmount" placeholder="0.00" />
</div>
  <div class="col-md-3">
        <label>Previous Year Budget</label><input type="text" readonly value="0.00" class="form-control" onblur='Mformat(this.id,this.value)' onkeydown=' return isNumeric(window.event.keyCode,this);' id="txtPrBudgetAmount" placeholder="0.00" />
</div>
    <div class="col-md-3">
        <label>Sales Executive<span class="text-danger">*</span></label><select class="form-control select2 enq-dropdown" id="ddlCustomerManager"></select>
</div>
<div class="col-md-3">
        <label>Product</label><input type="text"  class="form-control"  id="txtProduct"  />
</div>
 </div>

  <div class="row">
     <div class="col-md-3">
        <label>Financial Year<span class="text-danger">*</span></label><input type="text" class="form-control" id="txtFinancialYear" placeholder="eg : 2019" />
</div>
  <div class="col-md-3">
        <label>Budget Frequency<span class="text-danger">*</span></label><select class="form-control select2 enq-dropdown" id="ddlFrequency">
            <option value="0">Select</option>
            <option value="Monthly">Monthly</option>
            <option value="Sami-annually">Sami-annually</option>
            <option value="Quaterly">Quaterly</option>
     </select>
</div>
     <div class="col-md-6">
        <label>Comment</label><textarea class="form-control" id="txtComment" ></textarea>
</div>
       </div>
                        <div class="row mt-5">
                            <div class="col-md-12">
                        <button class="btn btn-success right" onclick="Save_Budget()" id="btnSave">Save</button>
                    </div>
                        </div>
                    <hr />
                <div class="row mt-5">
                    <table id="tblBudget" class="table table-hover table-bordered table-striped table-responsive">
                            <thead>
                                <tr>
                                    <th>Financial Year
                                    </th>
                                    <th>Budget Amount
                                    </th>
                                    <th>Previous Year Budget
                                    </th>
                                    <th>Product
                                    </th>
                                    <th>Budget Frequency
                                    </th>
                                    <th>Comment
                                    
                                </tr>
                            </thead>
                            <tbody id="tbody_tblBudget">
                            </tbody>
                        </table>
                  </div>

                    </div>
                   
                    

                    
                </div>
            </div>
        </div>

    </div>

    <!-- ./wrapper -->
    <!-- jQuery 3 -->
    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <!-- popper -->
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
    <!-- Bootstrap 4.0-->
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>
    <!-- DatePicker -->
    <script src="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"
        type="text/javascript"></script>
    <!-- SlimScroll -->
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <%--<script src="<%=G.B%>assets/vendor_components/fastclick/lib/fastclick.js"></script>--%>
    <!-- This is data table -->
    <script src="<%=G.B%>assets/vendor_components/datatable/datatables.min.js"></script>
    <!-- Form validator JavaScript -->
    <script src="<%=G.B%>assets/js/pages/validation.js"></script>
    <script src="<%=G.B%>assets/js/pages/form-validation.js"></script>
    <!-- toast -->
    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
    <!-- Al Manal App -->
    <script src="<%=G.B%>assets/js/template.js"></script>
    <%--<script src="<%=G.B%>assets/vendor_components/fileuploader/jquery.fileuploader.js"></script>--%>
    <!-- Al Manal for demo purposes -->
    <script src="<%=G.B%>assets/js/demo.js"></script>
    <script src="<%=G.S%>General/libo.js"></script>
    <script src="customer.js"></script>
    <script src="<%=G.B%>assets/vendor_components/moment/min/moment.min.js"></script>

    <script src="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script>
        $('.select2').select2();

        // $('.select2').addClass("est-item-dropdown");
    </script>
    <script>
        $('#txtFinancialYear').datepicker({
            format: "yyyy",
            weekStart: 1,
            orientation: "bottom",
            language: "{{ app.request.locale }}",
            keyboardNavigation: false,
            viewMode: "years",
            minViewMode: "years"
        });
        $(document).ready(function () {
            $('.dtleave').daterangepicker();
        });
        function phoneNumberCheck(phoneNumber) {
            var regEx = "^\+{0,2}([\-\. ])?(\(?\d{0,3}\))?([\-\. ])?\(?\d{0,3}\)?([\-\. ])?\d{3}([\-\. ])?\d{4}";
            if (phoneNumber.value.match(regEx)) {
                return true;
            }
            else {
                alert("Please enter a valid phone number.");
                return false;
            }
        }
        function GetVat() {
            var SupplierId = $('#DDL_Get_Parent_Account').val();
            var ExistingVat = $('#txt_vat_number').val();
           
            if (ExistingVat.trim() == "") {
                $.ajax({
                    url: 'H_tbl_Customer.ashx',
                    type: "POST",
                    data: {
                        'fun': 'GetVat', 'SupplierId': SupplierId
                    },
                    success: function (data) {

                        if (Chk_Res(data.errorMessage) == false) {
                            $('#txt_vat_number').val(data);
                        }
                    }
                });
            }
        }
        function Mformat(obj, value) {
            $('#' + obj).val(MoneyFormatter(value))
        }
        function MoneyFormatter(Number1) {

            var Number = Number1.toString();
            const formatter = new Intl.NumberFormat('en-US', {
                style: 'decimal',
                currency: 'INR',
                minimumFractionDigits: 2
            })

            Number = Number.replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '');

            var FormattedNo = (formatter.format(Number))
            return FormattedNo;

        }

        function GetBudgetData(Customer_id, Isview) {
            $("#tbody_tblBudget").empty();
            $('#Hid_CustomerMain').val(Customer_id);
            $('#txtBudgetAmount').val("0.00");
            $('#txtPrBudgetAmount').val("0.00");
            $('#ddlCustomerManager').val(0);
            $('#txtFinancialYear').val("");
            $('#ddlCustomerManager').select2();
            $('#txtComment').val("");
                $.ajax({
                    url: 'H_tbl_Customer.ashx',
                    type: "POST",
                    data: {
                        'fun': 'GetBudgetData', 'Customer_id': Customer_id
                    },
                    success: function (data) {

                        if (Chk_Res(data.errorMessage) == false) {

                            if (data != "") {
                                var arr = data.split("|");
                                var DisplayData = JSON.parse(arr[0]);
                                var PrevData = "";
                               
                                
                                $('#ddlCustomerManager').append($('<option>').text("Select").attr('value', "0"));
                                $.each(DisplayData, function (i, obj) {
                                    //   
                                    $('#ddlCustomerManager').append($('<option>').text(obj.Employee_Name).attr('value', obj.Employee_Id));
                                });
                                if (Isview == 1) {
                                    // PrevData = arr[1];

                                    // $.each(PrevData, function (i, obj) {
                                    // alert(obj.Budget_Amount)
                                    $('#txtBudgetAmount').val(arr[1]);
                                    $('#txtFinancialYear').val(arr[2]);
                                    $('#txtPrBudgetAmount').val(arr[3]);
                                    $('#txtComment').val(arr[4]);
                                    $('#ddlCustomerManager').val(arr[5]);
                                    $('#ddlCustomerManager').select2();
                                    $('#txtProduct').val(arr[6]); 
                                    $('#ddlFrequency').val(arr[7]);
                                    $('#ddlFrequency').select2();
                                    $('#Budget_Id').val(arr[8]);
                                    $('#btnSave').html("Update");
                                    SetInnerVal("tbody_tblBudget", arr[9]);
                                    
                                }
                                else {
                                    $('#btnSave').html("Save");
                                   
                                }
                            }
                        }
                    }
                });
          
        }
        function Save_Budget() {
           
            var InsertArray = $('#Hid_CustomerMain').val() + "|" + $('#txtBudgetAmount').val() + "|" +
                $('#txtPrBudgetAmount').val() + "|" +
                $('#ddlCustomerManager').val() + "|" +
                $('#txtFinancialYear').val() + "|" +
                $('#txtComment').val() + "|" +
                $('#txtProduct').val() + "|" +
                $('#ddlFrequency').val();

            var controls = "ddlCustomerManager,txtBudgetAmount,txtFinancialYear,ddlFrequency";
            if (setBorderColor_Validation(controls)) {
                var Caption = $('#btnSave').html()
                if (Caption == "Save") {
                    $.ajax({
                        url: 'H_tbl_Customer.ashx',
                        type: "POST",
                        data: {
                            'fun': 'Save_Budget', 'InsertArray': InsertArray
                        },
                        success: function (data) {

                            if (Chk_Res(data.errorMessage) == false) {
                                calltoast("Budget Added Sucessfully", "success");
                                $('#AddBudget').modal('hide');
                            }
                        }
                    });
                }
                else {
                    Budget_Id = $('#Budget_Id').val();
                    $.ajax({
                        url: 'H_tbl_Customer.ashx',
                        type: "POST",
                        data: {
                            'fun': 'Update_Budget', 'InsertArray': InsertArray, "Budget_Id": Budget_Id
                        },
                        success: function (data) {

                            if (Chk_Res(data.errorMessage) == false) {
                                calltoast("Budget Updated Sucessfully", "success");
                                $('#AddBudget').modal('hide');
                            }
                        }
                    });
                }
            }
            else {
                calltoast("Please fill all the required fields", "error");
            }
        }
    </script>
</body>
</html>

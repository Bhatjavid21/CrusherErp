<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Supplier.aspx.cs" Inherits="Supplier_Main" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>

<% 
    Session["top_menu"] = "";
    Session["sub_menu"] = "supplier";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link rel="icon" href="<%=G.B%>assets/images/favicon.ico" />
    <title>Supplier - Trading ERP</title>
    <!-- Bootstrap 4.0-->
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css" />
    <!-- Data Table-->
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/vendor_components/datatable/datatables.min.css" />
    <!-- Bootstrap extend-->
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css" />
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css" />
    <!-- Date Picker-->
    <link href="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.css" rel="stylesheet" type="text/css" />
    <!-- toast CSS -->
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet" />
    <!-- theme style -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css" />
    <!-- Al Manal skins -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css" />
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/fileuploader/jquery.fileuploader.css" />

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-switch/switch.css" />

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/icheck/skins/all.css" />
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/js/froiden-helper/helper.css" />
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.css">
    <style>
        .rbtDisabled {
            pointer-events: none;
            opacity: 1;
        }

        icheckbox_line-red.disabled, .iradio_line-red.disabled {
            background: #eee !important;
            cursor: default;
        }

        .h-34 {
            height: 34px;
        }

        .table > tbody > tr > td {
            line-break: anywhere;
        }
    </style>
</head>
<body class="hold-transition skin-info-light fixed sidebar-mini">


    <div class="wrapper">

        <uc1:uch ID="uch1" runat="server" />
        <uc2:ucs ID="ucs1" runat="server" />

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->

            <input type='hidden' value='0' id='Hid_SupplierMain' />
            <input type='hidden' value='0' id="hid_Contact_Person" />
            <input type='hidden' value='0' id="hid_External_Party_Address" />
            <input type='hidden' value='0' id="hid_Doc" />
            <input type='hidden' value='0' id="hid_readOnly" />
            <input type='hidden' value='0' id="hid_Status" />
            <input type='hidden' value='0' id="hid_IsEdit" />
            <input type='hidden' value='0' id="hid_Supplier_Scope_Id" />
            <input type="hidden" name="hdf_branch_id" id="hdf_branch_id" runat="server">
            <input type='hidden' value='0' id="hid_accounts_access" />
            <input type="hidden" id="hid_Ledger_Account_Id" value="0" />
            <input type="hidden" id="hid_Save_Btn_Values" value="0" />
            <input type="hidden" id="Sup_Bal_Id" value="" />
            <input type="hidden" id="hid_page" value="0" />

            <section class="content mt-20">
                <div class="box">
                    <div class="box-header display-none">
                        <div class="row m-10">
                            <div class="col-10">
                                <h4 class="page-title " runat="server" id="lbl_h4">Supplier List</h4>
                                <%--<div style="float:right; width:200px"> 
                    <table>
                          <tr><td><input type="text" id="txtinput"  onkeyup="GetSuggestions(0)" style="width: 258px;border: 1px solid #d2d6de;border-radius: 4px 4px 0px 0px;height: 32px;padding:4px;color:#495057;"/> </td></tr>
                            <tr><td><div id="td_resSug" class='autosug'> </div></td></tr></table>
            
        
    
                    
                    
                    </div>--%>
                            </div>
                            <%-- <div class="right-title col-md-2 text-right">      
                  <i class="mdi mdi-plus plusicon" data-toggle="modal" onclick="Bind_All_DDLs_For_Cust_General();" data-target="#myModal"></i>
                </div>--%>
                        </div>
                    </div>

                    <!-- /.box-header -->
                    <div class="box-body">

                        <div class="row ">
                            <div class="col-md-2 col-sm-3 pr-5 ">
                                <div class="form-group validate">
                                    <%-- <label class="mb-0" for="exampleInputEmail1">Branch</label>--%>
                                    <%-- <select class="form-control enq-txtbx-pdselect2 mb-7 enq-dropdown" style='border: 1px solid #ced4da; border-radius: 25px;' onchange="View(0);" runat="server" id="DDL_Branch" aria-invalid="false">
                                                            <option>Branch 1</option>
                                                            <option>Branch 2</option>
                                                            <option>Branch 3</option>
                                                        </select>--%>
                                    <select class="form-control select2 enq-dropdown h27" onchange="View(0);" runat="server" id="DDL_Branch" aria-invalid="false"></select>
                                </div>
                            </div>

                            <div class="col-md-2 col-sm-3 ">
                                <div class="form-group">
                                    <%--         <label class="mb-0" for="exampleInputEmail1">Search Supplier</label>--%>
                                    <div class="input-group">
                                        <input type="text" id="txtinput" onkeyup="GetSuggestions(0)" placeholder="Search" class="form-control  fnt12" title="This search brings all relevant results from Supplier Name, Account Code and Contact Person Name fields.">
                                        <span class="search-btn"><i class="ti-search"></i></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4 col-sm-3">
                                <div class="form-group mb-15">
                                    <%-- <label class="mb-0" for="exampleInputEmail1">Supplier Status</label>--%>
                                    <div class="input-group">

                                        <table>
                                            <tr>
                                                <td>
                                                    <div class="form-group input-group mb-0 ml-0">
                                                        <div class="checkbox text-xs-left fnt12">
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
                                                                        New<ins class="iCheck-helper"></ins>
                                                                    </div>
                                                                </li>

                                                                <li style="padding-right: 1px;">
                                                                    <div class="iradio_line-red grp2" id="div_customers" onclick="filter(this, '2')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Customers" id="btn_customers" data-id="0" />
                                                                        Approved<ins class="iCheck-helper"></ins>
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

                                                                <li><i class="mdi mdi-information-outline" title="Clicking on any of the tiles filters the Listed Suppliers based on their Status"></i></li>

                                                            </ul>
                                                        </div>
                                                    </div>
                                                </td>


                                                <td></td>
                                            </tr>

                                        </table>


                                    </div>

                                </div>
                            </div>

                            <div class="col-md-2 col-sm-3 ">
                                <div class="form-group mb-15 validate">
                                    <%--   <label class="mb-0" for="exampleInputEmail1">Limit</label>--%>
                                    <select class="form-control select2 h27 enq-dropdown" onchange="View(0);" runat="server" id="ddl_limit" aria-invalid="false">
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
                                    <a href="#" id="btn_Download_Leave" target="_blank" class="btn btn-success right" onclick="Excel_Data()" title="Download Supplier Checklist"><i class="fa fa-download"></i></a>
                                </span>

                                <button class="btn btn-success right mr-5" data-toggle="modal" onclick="Bind_All_DDLs_For_Cust_General(0);" data-target="#myModal" id="inputModal"><i class="mdi mdi-plus plusicon"></i>New</button>

                            </div>
                        </div>
                        <hr />
                        <div class="row ">
                            <div class="col-md-12 mb-15">
                                <%--<div class="tableFixHead">--%>
                                <div>
                                    <table class="table table-hover table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th onclick='setSort("Account_Code")' class="sorting fntbld" style='cursor: pointer; width: 12%' id="Account_Code">Code</th>
                                                <th onclick='setSort("Supplier_Name")' class="sorting fntbld" id="Supplier_Name" style='cursor: pointer; width: 38.7%'>Name</th>
                                                <th onclick='setSort("VAT_Number")' class="sorting fntbld" id="VAT_Number" style='cursor: pointer; width: 20%'>VAT Number</th>
                                                <th onclick='setSort("Status")' class="sorting fntbld" style='cursor: pointer; width: 12%' id="Status">Status</th>
                                                <th onclick='setSort("Phone_Number")' class="sorting fntbld" style='cursor: pointer; width: 15%' id="Phone_Number">Phone</th>
                                                <th onclick='setSort("Credit_Facility")' class="sorting fntbld" style='cursor: pointer; width: 12%' id="Credit_Facility">Credit Facility</th>
                                                <th class="fntbld" style="width: 6%">Actions</th>
                                            </tr>
                                        </thead>
                                        <%--  <tbody></tbody>--%>
                                        <tbody id="tbody_Supplier_List"></tbody>
                                    </table>
                                </div>
                            </div>

                            <%--  <div class="table-responsive" style='overflow:auto;height:330px;width:100%;'>

                                                    <table class="table table-hover table-bordered table-striped">
                                                        <tbody  id="tbody_Supplier_List"></tbody>
                                                    </table>

                                </div>--%>
                        </div>
                        <div class="box-footer mb-40" id="Div_Paging">
                        </div>
                    </div>
                </div>
                <!-- /.box -->

            </section>
            <!-- /.content -->
        </div>



        <!-- /.content-wrapper -->
        <!-- Popup Model Plase Here -->
        <div id="myModal" class="modal fade  bs-example-modal-lg" tabindex="" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">Add Supplier</h4>
                        <button type="button" class="close" data-dismiss="modal" onclick="ClearFields_General();Remove_Supplier_Id();"
                            aria-hidden="true">
                            ×</button>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs" role="tablist">

                            <li class="nav-item active"><a class="nav-link" aria-selected="true" data-toggle="tab" href="#general" id="gen_tab_lnk"
                                role="tab"><span class="hidden-sm-up"><i class="ion-home"></i></span><span class="hidden-xs-down">General</span></a> </li>

                            <li class="nav-item disabled" onclick="View_Contact_Person(0)"><a class="nav-link disabled" id="cp_tab_lnk"
                                data-toggle="tab" href="#cperson" role="tab"><span class="hidden-sm-up">
                                    <i class="ion-person"></i></span><span class="hidden-xs-down">Contact Person</span></a> </li>

                            <li class="nav-item disabled" onclick="View_external_party(0);"><a class="nav-link disabled" id="address_tab_lnk"
                                data-toggle="tab" href="#addresses" role="tab"><span class="hidden-sm-up"><i class="ion-email"></i></span><span class="hidden-xs-down">Address</span></a> </li>

                            <li class="nav-item disabled" id="tab_accounts_info" onclick="tabAccInfo()"><a class="nav-link disabled" data-toggle="tab" href="#account" id="account_info_tab_lnk"
                                role="tab"><span class="hidden-sm-up"><i class="ion-email"></i></span><span class="hidden-xs-down">Accounts Info</span></a> </li>

                            <li class="nav-item disabled" onclick="View_Doc(0);Bind_All_DDLs_For_Document(0);"><a id="doc_tab_lnk"
                                class="nav-link disabled" data-toggle="tab" href="#documents" role="tab"><span class="hidden-sm-up">
                                    <i class="ion-email"></i></span><span class="hidden-xs-down">Documents</span></a></li>

                            <li class="nav-item disabled" onclick="Bind_Scope_Of_Supply_Table();"><a id="items_tab_link"
                                class="nav-link disabled" data-toggle="tab" href="#Items" role="tab"><span class="hidden-sm-up">
                                    <i class="ion-email"></i></span><span class="hidden-xs-down">Scope of Supply</span></a></li>
                        </ul>
                        <div class="tab-content ">
                            <!-- General Tab starts here -->
                            <div class="tab-pane active pt-10" id="general" role="tabpanel">

                                <div class="row">
                                    <div class="col-sm-12 col-lg-12 ">
                                        <div class="form-group ">
                                            <label class="mb-0" for="exampleInputEmail1">Supplier Type</label>
                                            <div class="input-group">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <div class="form-group input-group mb-0 ml-0">
                                                                <div class="checkbox text-xs-left enq-txtbx-pdmb-0">
                                                                    <ul class="icheck-list">

                                                                        <li>
                                                                            <div class="iradio_line-red grp2 checked leave-left-border checked" id="div_Local" onclick="Supplier_Type_filter(this, '0')">
                                                                                <input type="radio" class="check" data-radio="iradio_line-red grp2" data-label="Stock" id="rbt_Local" data-id="0" style="position: absolute; opacity: 0;" />
                                                                                Local<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; border: 0px none; opacity: 0;"></ins>
                                                                            </div>
                                                                        </li>

                                                                        <li>
                                                                            <div class="iradio_line-red grp2 leave-right-border" id="div_Overseas" onclick="Supplier_Type_filter(this, '1')">
                                                                                <input type="radio" class="check" data-radio="iradio_line-red grp2" data-label="Non-Stock" id="rbt_Overseas" data-id="0" style="position: absolute; opacity: 0;" />
                                                                                Overseas<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; border: 0px none; opacity: 0;"></ins>
                                                                            </div>
                                                                        </li>
                                                                        <li><i class="mdi mdi-information-outline" title="Clicking on any of the tiles selects the supplier type"></i></li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                Name <span style="color: Red; font-weight: bold;">*</span></label>
                                            <div class="controls">
                                                <input type="text" id="txt_Supplier_Name" maxlength="55" name="name" onblur="return ValidateOne(this);"
                                                    class="form-control fnt12" required data-validation-required-message="Name is required">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>
                                                Short Name <span style="color: Red; font-weight: bold;">*</span></label>
                                            <div class="controls">
                                                <input type="text" id="txt_Supplier_Short_Name" maxlength="10" name="name" onkeyup="Only_String(this);" onblur="return ValidateOne(this);"
                                                    class="form-control fnt12" required data-validation-required-message="Name is required">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>
                                                Supplier Branch</label>
                                            <div class="controls">
                                                <input type="text" name="branch" id="txt_sup_company_branch" maxlength="30" class="form-control fnt12"
                                                    required data-validation-required-message="Branch is required">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>
                                                Email <span style="color: Red; font-weight: bold;">*</span>
                                            </label>
                                            <div class="controls">
                                                <input type="email" name="email" id="txt_email" maxlength="60" onblur="return ValidateOne(this);" class="form-control fnt12"
                                                    required data-validation-required-message="Email is required">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                Phone</label>
                                            <div class="controls">
                                                <input type="tel" name="phone" id="txt_phone_number" class="form-control fnt12" required data-validation-required-message="Phone is required" onkeypress="return phoneno(event);" maxlength="25">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>
                                                Fax</label>
                                            <div>
                                                <input type="text" id="txt_fax" class="form-control fnt12" onkeypress="return phoneno(event);" maxlength="25">
                                            </div>

                                            <label>
                                                Website</label>
                                            <div>
                                                <input type="website" id="txt_website" maxlength="55" class="form-control fnt12" />
                                            </div>
                                            <!--<label >
                                                Division</label>-->
                                            <!--<div  id="div_DDL_Get_Division">
                                                <select class="form-control mb-10" name="division" id="DDL_Get_Division">
                                                    <option value="0" ><img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                </select>
                                            </div>-->
                                            <!-- <label >
                                                Salesman <span style="color:Red;font-weight:bold;"> *</span></label>-->
                                            <!--<div  id="div_DDL_Get_Salesman">
                                                <select class="form-control mb-10" name="salesman" id="DDL_Get_Salesman" onblur="return ValidateOne(this);">
                                                    <option value="0"><img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                </select>
                                            </div>-->
                                            <label>
                                                Approver <span style="color: Red; font-weight: bold;">*</span></label>
                                            <div id="div_DL_Get_Approver">
                                                <select class="form-controlselect2 h27" name="approver" id="DDL_Get_Approver" onblur="return ValidateOne(this);">
                                                    <option value="0">
                                                        <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer mt-10">

                                    <button type="button" class="btn btn-dark" id="btn_Cancel_sup_Gen"
                                        onclick="ClearFields_General();Remove_Supplier_Id();" data-dismiss="modal">
                                        <i class="ti-trash"></i>&nbsp;Cancel
                                    </button>

                                    <button type="button" id="btn_Save_Continue_GenCus" onclick="exe('bigGen')" class="btn btn-success right">
                                        <i class="ti-save-alt"></i>&nbsp;Save &amp; Continue
                                    </button>
                                    <button type="button" id="btn_general_save_stay" onclick="exe('gen_Stay')" class="btn btn-success right mr-10">
                                        <i class="ti-save-alt"></i>&nbsp;Save &amp; Stay
                                    </button>
                                    <button type="button" id="btn_general_save" onclick="exe('gen');" class="btn btn-success right mr-10">
                                        <i class="ti-save-alt"></i>&nbsp;Save &amp; Exit
                                    </button>
                                </div>
                            </div>

                            <!-- Contact Tab starts here -->
                            <div class="tab-pane" id="cperson" role="tabpanel">
                                <div class="row" id="rwplus">
                                    <div class="col-md-12">
                                        <div class="mt-10 ">
                                            <div class="box-controls pull-right">
                                                <div class="box-header-actions" onclick="ClearFields_Contact_Person(0);" id="Div_Input_Box_Opner_CP">
                                                    <button class="btn btn-success mb-10" data-toggle="tooltip" id="btn-contact-add"><i class="mdi mdi-plus plusicon"></i>&nbsp;New</button>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-sm-12 hide" id="rwcontact-add">
                                        <div class="row">
                                            <div class="">
                                                <div class="">
                                                    <%-- <h5 class="modal-title">Add Contact</h5>--%>
                                                    <div class="box-tools pull-right">
                                                        <ul class="box-controls">
                                                            <li>
                                                                <%-- <button type="button" id="btn-contact-close" class="close" style="font-size: 17px; color: #455A64;"
                                                                        aria-hidden="true">
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
                                                                    Name<span class="text-danger">*</span></label>
                                                                <input type="text" class="form-control fnt12" id="txt_name" onkeyup="Only_String(this);" onblur="return ValidateOne(this);" maxlength="50">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Mobile <span class="text-danger">*</span></label>
                                                                <input type="text" class="form-control fnt12" onkeypress="return phoneno(event);" maxlength="25" id="txt_mobile">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Email<span class="text-danger">*</span></label>
                                                                <input type="email" class="form-control fnt12" id="txt_email_id" maxlength="60">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Branch</label>
                                                                <input type="text" class="form-control fnt12" id="txt_branch" maxlength="30">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <%--  </div>
                                                        <div class="row">--%>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Department</label>
                                                                <input type="text" class="form-control fnt12" id="txt_department" maxlength="30">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Designation</label>
                                                                <input type="text" class="form-control fnt12" id="txt_designation" maxlength="30">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Phone <span class="text-danger">*</span></label>
                                                                <input type="text" class="form-control fnt12" onkeypress="return phoneno(event);" maxlength="25" id="txt_phone_number_CP">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Fax</label>
                                                                <input type="text" class="form-control fnt12" id="txt_fax_CP" onkeypress="return phoneno(event);" maxlength="25">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 mb-10 mt-10">
                                                        <button type="button" id="btn-contact-close" class="btn btn-dark"><i class="ti-trash"></i>&nbsp;Cancel</button>
                                                        <button type="button" class="btn btn-success right mb-10" id="btn_save_Contact_Person" onclick="exe('contact_person')">
                                                            <i class="ti-save-alt"></i>&nbsp;Save</button>
                                                        <!--<button type="button" class="btn btn-default btn-outline mr-1" id="btn_cancel_CP"  onclick="ClearFields_Contact_Person();" data-dismiss="modal">-->
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12">
                                        <div class="form-group">

                                            <table id="dtcontact" class="table table-hover table-bordered table-striped">
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
                                                <tbody id="tbody_List_CP"></tbody>
                                            </table>
                                        </div>

                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button class="btn btn-success right mb-10" onclick="Go_To_Next_Tab('contact');">Next <i class="fa fa-arrow-right"></i></button>
                                </div>

                            </div>
                            <!-- Address Tab starts here -->
                            <div class="tab-pane" id="addresses" role="tabpanel">
                                <div class="row" id="rwaddplus">
                                    <div class="col-md-12">
                                        <div class="mt-10">
                                            <div class="box-controls pull-right">
                                                <div class="box-header-actions">
                                                    <button class="btn btn-success mb-10" data-toggle="tooltip"
                                                        onclick="ddl_external_party_country(0);ClearFields_External_Party_Address();"
                                                        id="btn-address-add">
                                                        <i class="mdi mdi-plus plusicon"></i>&nbsp;New</button>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-sm-12 hide" id="rwaddress-add" style='display: none;'>
                                        <div class="row">
                                            <div class="">
                                                <div class="">
                                                    <%--<h5 class="modal-title">Add Address</h5>--%>
                                                    <div class="box-tools pull-right">
                                                        <ul class="box-controls">
                                                            <li>
                                                                <%-- <button type="button" id="btn-address-close" onclick="ClearFields_External_Party_Address();"
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
                                                                    Address<span class="text-danger">*</span></label>
                                                                <input type="text" class="form-control fnt12" id="txt_external_party_address" maxlength="150" onblur="return ValidateOne(this);">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Post Office</label>
                                                                <input type="text" class="form-control fnt12" maxlength="10" maxlength="30" id="txt_external_party_post_office">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Country<span class="text-danger">*</span></label>
                                                                <!--<input type="text" class="form-control mb-10">-->
                                                                <div id="div_external_party_country">
                                                                    <select class="form-control h27" id="ddl_external_party_country" name="country" onblur="return ValidateOne(this);">
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
                                                                    State<span class="text-danger">*</span></label>
                                                                <div id="div_external_party_state">
                                                                    <select class="form-control h27" id="ddl_external_party_state" name="state" onblur="return ValidateOne(this);">
                                                                        <option value="0">.......</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>

                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    City<span class="text-danger">*</span></label>
                                                                <div id="div_external_party_city">
                                                                    <select class="form-control h27" id="ddl_external_party_city" name="city" onblur="return ValidateOne(this);">
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
                                                                <input type="text" class="form-control fnt12" id="txt_external_party_zip" maxlength="12" onkeydown="javascript:isNumeric(window.event.keyCode,this)">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>

                                                    </div>


                                                </div>
                                                <div class="col-md-12 mb-10 mt-10">
                                                    <button id="btn-address-close" onclick="ClearFields_External_Party_Address();" class="btn btn-dark"><i class="ti-trash"></i>&nbsp;Cancel</button>
                                                    <button type="button" class="btn btn-success right" id="btn_save_External_Party_Address"
                                                        onclick="exe('address')">
                                                        <i class="ti-save-alt"></i>&nbsp;Save
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12 ">
                                        <div class="form-group">

                                            <table id="dtaddress" class="table table-hover table-bordered table-striped">
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
                                                <tbody id="tbody_List_External_Party_Address"></tbody>
                                            </table>
                                        </div>

                                    </div>

                                </div>
                                <div class="box-footer mt-10">
                                    <button class="btn btn-success right mb-10" onclick="Go_To_Next_Tab('address');">Next <i class="fa fa-arrow-right"></i></button>
                                </div>
                            </div>
                            <!-- Account Tab starts here -->
                            <div class="tab-pane pt-20" id="account" role="tabpanel">

                                <div class="row">
                                    <div class="col-sm-12 col-lg-6">
                                        <div class="form-group">
                                            <label>
                                                Account Code</label>
                                            <div>
                                                <input type="text" class="form-control fnt12" maxlength="15" id="txt_account_code" onblur="return ValidateOne(this);" onkeydown="javascript:return isNumeric(window.event.keyCode,this)">
                                            </div>
                                            <label class="">
                                                Opening Balance <span class="text-danger">*</span></label>
                                            <div class="">
                                                <input type="text" class="form-control isDecimalNumber" maxlength="15" id="txt_Opening_Balance" value="0.00">
                                            </div>
                                            <label class="">
                                                Openinig Balance Type <span class="text-danger">*</span></label>
                                            <div class="">
                                                <select class="form-control select2 enq-dropdown h27" onblur="return ValidateOne(this);" id="ddl_Opening_Balance_Type">
                                                    <option value="0" selected>Select</option>
                                                    <option value="Cr">Cr</option>
                                                    <option value="Dr">Dr</option>
                                                </select>
                                            </div>
                                            <div>
                                                <div class="checkbox">
                                                    <input type="checkbox" id="chk_subaccount">
                                                    <label for="chk_subaccount">
                                                        Link Customers</label>
                                                </div>
                                            </div>
                                            <div class="hide" id="dp-account">
                                                <label>
                                                    Link Customers</label>
                                                <div id="div_DDL_Get_Parent_Account">
                                                    <select class="form-control h27" id="DDL_Get_Parent_Account" name="parentaccount" onblur="return ValidateOne(this);">
                                                        <option value="0">
                                                            <img src="<%=G.B%>assets/images/Loading.gif" alt="Loading..." /></option>
                                                    </select>
                                                </div>
                                            </div>
                                            <label>
                                                CR Number</label><span class="text-danger">*</span>
                                            <div>
                                                <input type="text" class="form-control fnt12" maxlength="15" onblur="return ValidateOne(this);"
                                                    id="txt_cr_number">
                                            </div>
                                            <label>
                                                VAT Number</label><span class="text-danger">*</span>
                                            <div>
                                                <input type="text" class="form-control fnt12" maxlength="15" onblur="return ValidateOne(this);"
                                                    id="txt_vat_number">
                                            </div>
                                            <div>
                                                <div class="checkbox">
                                                    <input type="checkbox" id="chk_credit">
                                                    <label for="chk_credit">
                                                        Credit Facility</label>
                                                </div>
                                            </div>
                                            <div class="hide" id="dp-credit">
                                                <label>
                                                    Credit days</label>
                                                <div>
                                                    <div class="controls">
                                                        <input type="text" name="crdays" id="txt_credit_days" onblur="return ValidateCreditFacility();" onkeydown="javascript:return isNumeric(window.event.keyCode,this)" class="form-control fnt12"
                                                            maxlength="3" required data-validation-containsnumber-regex="(\d)+"
                                                            data-validation-containsnumber-message="No Characters Allowed, Only Numbers">
                                                    </div>
                                                </div>
                                                <label>
                                                    Credit Amount</label>
                                                <div>
                                                    <div class="controls">
                                                        <input type="text" name="cramount" id="txt_credit_amount" onblur="return ValidateCreditFacility();" onkeydown="javascript:return isNumeric(window.event.keyCode,this)" class="form-control fnt12"
                                                            maxlength="7" required data-validation-containsnumber-regex="(\d)+"
                                                            data-validation-containsnumber-message="No Characters Allowed, Only Numbers">
                                                    </div>
                                                </div>
                                            </div>
                                            <label>
                                                Currency</label>
                                            <div id="div_Get_DDL_Currency">
                                                <select class="form-control h27" id="ddl_currency_id" onblur="return ValidateOne(this);"
                                                    name="currency">
                                                    <option value="0"></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-lg-6">
                                        <div class="form-group">
                                            <label>
                                                Bank Name</label>
                                            <div>
                                                <input type="text" class="form-control fnt12" maxlength="40" onkeyup="Only_String(this);"
                                                    id="txt_bank_name">
                                            </div>
                                            <label>
                                                Branch Name</label>
                                            <div>
                                                <input type="text" class="form-control fnt12" maxlength="30"
                                                    id="txt_bank_branch_name" onkeyup="Only_String(this);">
                                            </div>
                                            <label>
                                                Account Holder Name</label>
                                            <div>
                                                <input type="text" class="form-control fnt12" maxlength="30" onkeyup="Only_String(this);"
                                                    id="txt_account_holder_name" />
                                            </div>
                                            <label>
                                                Account Number</label>
                                            <div>
                                                <div class="controls">
                                                    <input type="text" name="accno" id="txt_account_number" onkeydown="javascript:return isNumeric(window.event.keyCode,this)"
                                                        class="form-control fnt12" maxlength="16" required
                                                        data-validation-containsnumber-regex="(\d)+" data-validation-containsnumber-message="No Characters Allowed, Only Numbers">
                                                </div>
                                            </div>
                                            <label>
                                                IBAN Number</label>
                                            <div>
                                                <input type="text" class="form-control fnt12" id="txt_iban_number" maxlength="20">
                                            </div>
                                            <label>
                                                Swift Code</label>
                                            <div>
                                                <input type="text" class="form-control fnt12" id="txt_swift_code" maxlength="20">
                                            </div>
                                            <div id="div_balcklistpart">
                                                <div>
                                                    <div class="checkbox">
                                                        <input type="checkbox" id="chk_blacklisted">
                                                        <label for="chk_blacklisted">
                                                            Blacklisted</label>
                                                    </div>
                                                </div>
                                                <div class="hide" id="dp-blacklist">
                                                    <label>
                                                        Reason <span style="color: Red; font-weight: bold;">*</span></label>
                                                    <div class="controls col-md-12">
                                                        <textarea name="bkl-reason" id="txt_blacklisted_reason" onkeyup="Only_String(this);" maxlength="300" class="form-control fnt12" required></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="box-footer">



                                    <button type="button" class="btn btn-dark" id="btn_Cancel_Account_Info"
                                        onclick="ClearFields_AccountInfo();" data-dismiss="modal">
                                        <i class="ti-trash"></i>&nbsp;Cancel
                                    </button>

                                    <button type="button" class="btn btn-success right mr-5" id="btn_Save_Continue_AccountInfo" onclick="save_Accounts_Info('continue');">
                                        <i class="ti-save-alt"></i>&nbsp;Save &amp; Continue
                                    </button>
                                    <button type="button" class="btn btn-success right mr-5" id="btn_Save_Exit_AccountInfo" onclick="save_Accounts_Info('stay');">
                                        <i class="ti-save-alt"></i>&nbsp;Save &amp; Stay
                                    </button>
                                    <button type="button" class="btn btn-success  right mr-5" id="btn_txtAccountInfo" onclick="save_Accounts_Info('exit');">
                                        <i class="ti-save-alt"></i>&nbsp;Save & Exit
                                    </button>


                                    <%--<button type="button" class="btn btn-success right" id="btn_txtAccountInfo" onclick="exe('Acc_Info')">
                                        <i class="ti-save-alt"></i>&nbsp;Save
                                    </button>
                                    <button class="btn btn-success right mr-10">Save &amp; Continue</button>--%>

                                    <!--<button type="button" class="btn btn-success" id="btn_Save_Continue_AccountInfo" style="float: right;">
                                                    <i class="ti-save-alt"></i>Save &amp; Continue
                                                </button>-->
                                </div>



                            </div>
                            <!-- Document Tab starts here -->
                            <div class="tab-pane" id="documents" role="tabpanel">
                                <div class="row" id="rwdocplus">
                                    <div class="col-md-12">
                                        <div class="mt-10">
                                            <div class="box-controls pull-right">
                                                <div class="box-header-actions">
                                                    <button class="btn btn-success mb-10" data-toggle="tooltip"
                                                        id="btn-doc-add" onclick="ClearFields_Doc();">
                                                        <i class="mdi mdi-plus plusicon"></i>&nbsp;New</button>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-sm-12 hide display-none" id="rwdoc-add">
                                        <div class="row">
                                            <div class="">
                                                <div class="">
                                                    <%-- <h5 class="modal-title">Add Documents</h5>--%>
                                                    <div class="box-tools pull-right">
                                                        <ul class="box-controls">
                                                            <li>
                                                                <%--<button type="button" id="btn-doc-close" onclick="ClearFields_Scope();" class="close" style="font-size: 17px; color: #455A64;" aria-hidden="true">×</button>--%>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="">
                                                    <div class="row mauto">
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Document name<span class="text-danger">*</span></label>
                                                                <div id="div_ddl_doc_type">
                                                                    <select class="form-control h27" id="Document_Type_Id" onblur="return ValidateOne(this);" name="doctype">
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
                                                                <input type="text" class="form-control fnt12" id="Document_Number" maxlength="40">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Issuing Authority</label>
                                                                <input type="text" class="form-control fnt12" id="Issuing_Athourity" maxlength="40">
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                        <div class="col-md-6 col-12">
                                                            <div class="form-group">
                                                                <label>
                                                                    Expiry Date</label>
                                                                <input class="form-control fnt12" type="date" placeholder="mm/dd/yyyy" id="Expiry_Date" maxlength="30">
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
                                                                    <select class="form-control h27" name="salesman" id="Assigned_To" onblur="return ValidateOne(this);">
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
                                                                    Upload<span class="text-danger">*</span></label>
                                                                <div class="controls">
                                                                    <form id="form1">
                                                                        <input type="file" name="File_Name" id="File_Name" onchange="upload_File('Supplier/Documents','0','File_Name')" onblur="return ValidateOne(this);" class="form-control fnt12">
                                                                        <input type='hidden' value="" id='hid_fileName' />
                                                                        <span id="spn_loading" style="color: blue; display: none;">Uploading...</span>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                            <!-- /.form-group -->
                                                        </div>
                                                    </div>

                                                    <div class="col-md-12 mt-10">


                                                        <button class="btn btn-dark" id="btn-doc-close" onclick="ClearFields_Scope();"><i class="ti-trash"></i>&nbsp;Cancel</button>
                                                        <button type="button" class="btn btn-success right mb-10" id="btn_save_doc" onclick="exe('doc')">
                                                            <i class="ti-save-alt"></i>&nbsp;Save
                                                        </button>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <table id="dtdoc" class="table table-hover table-bordered table-striped">
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
                                                <tbody id="tbody_List_Doc"></tbody>
                                            </table>
                                        </div>

                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button class="btn btn-success right mb-10" onclick="Go_To_Next_Tab('documents');">Next <i class="fa fa-arrow-right"></i></button>
                                </div>
                            </div>
                            <!-- Items Tab starts here -->
                            <div class="tab-pane" id="Items" role="tabpanel">
                                <div class="row" id="rwScopePlus">
                                    <div class="col-md-12 h-34">
                                        <div class="mt-10">

                                            <div class="box-controls pull-right">
                                                <div class="box-header-actions">
                                                    <button class="btn btn-success" data-toggle="tooltip"
                                                        id="btn_Scope_Add" onclick="Bind_DDL_Items(1,0);">
                                                        <i class="mdi mdi-plus plusicon"></i>&nbsp;New</button>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-12 hide mt-0" id="rwScopeAdd">
                                        <div class="row">
                                            <div class="col-md-12 pl-0 pr-0">
                                                <div class="">
                                                    <%-- <h5 class="modal-title">Scope of Supply</h5>--%>
                                                    <div class="box-tools pull-right">
                                                        <ul class="box-controls">
                                                            <li>
                                                                <%--<button type="button" id="btn_Scope_Close" onclick="ClearFields_Scope();" class="close" style="font-size: 17px; color: #455A64;" aria-hidden="true">×</button>--%>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="">
                                                    <div class="row mauto">
                                                        <div class="col-sm-12 col-lg-12">
                                                            <div class="form-group mb-15">
                                                                <label class="mb-0" for="exampleInputEmail1">Item Type</label>
                                                                <div class="input-group mb-10">

                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <div class="form-group input-group mb-0 ml-0">
                                                                                    <div class="checkbox text-xs-left enq-txtbx-pdmb-0">
                                                                                        <ul class="icheck-list">

                                                                                            <li>
                                                                                                <div class="iradio_line-red grp2 checked leave-left-border checked" id="div_Stock" onclick="Item_filter(this, '0');Bind_DDL_Items(1,0);">
                                                                                                    <input type="radio" class="check" data-radio="iradio_line-red grp2" data-label="Stock" id="rbt_Stock_Items" data-id="0" />
                                                                                                    Stock<ins class="iCheck-helper"></ins>
                                                                                                </div>
                                                                                            </li>

                                                                                            <li>
                                                                                                <div class="iradio_line-red grp2 leave-right-border" id="div_Non_Stock" onclick="Item_filter(this, '1');Bind_DDL_Items(2,0);">
                                                                                                    <input type="radio" class="check" data-radio="iradio_line-red grp2" data-label="Non-Stock" id="rbt_Non_Stock" data-id="0" />
                                                                                                    Non Stock <ins class="iCheck-helper"></ins>
                                                                                                </div>
                                                                                            </li>
                                                                                            <li><i class="mdi mdi-information-outline" title="Clicking on any of the tiles filters the item categories based on their type"></i></li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-sm-12 col-lg-6">
                                                            <label for="exampleInputEmail1">Item Sub Category</label>
                                                            <span class="red-bold">*</span>
                                                            <select id="ddl_ItemSubCategory" class="form-control select2 h27"></select>
                                                        </div>
                                                        <div class="col-sm-12 col-lg-6">
                                                            <label class="mb-0" for="exampleInputEmail1">Comments</label>
                                                            <textarea rows="1" id="txt_Item_Des" maxlength="200" class="form-control fnt12"></textarea>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-12 mb-10 mt-10">

                                                        <button type="button" class="btn btn-dark  " id="btn_Scope_Close" onclick="ClearFields_Scope();">
                                                            <i class="ti-trash"></i>&nbsp;Cancel
                                                        </button>
                                                        <button type="button" id="btn_Item_Save" onclick="Save_Scope_Of_Supplier();" class="btn btn-success right">
                                                            <i class="ti-save-alt"></i>&nbsp;Save
                                                        </button>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <table id="tbl_Supplier_Scopes" class="table table-hover table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th class="fntbld">Item Type</th>
                                                        <th class="fntbld">Item Sub Category</th>
                                                        <th class="fntbld">Comments</th>
                                                        <th class="fntbld">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbody_Supplier_Scopes"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button class="btn btn-success right mb-10" onclick="Go_To_Next_Tab('scope');"><i class="ion-log-out"></i>&nbsp;Finish</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->

        <!-- /Popup Model Plase Here -->
        <%--<div id="footer">
        </div>--%>

        <%--<uc3:ucf ID="ucf1" runat="server" />--%>

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
                                                Invoice Date <span class="text-danger">*</span></label>
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
                            </tbody>
                        </table>
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

    </div>
    <!-- ./wrapper -->


    <!-- jQuery 3 -->
    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <!-- popper -->
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
    <!-- Bootstrap 4.0-->
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- DatePicker -->
    <script src="<%=G.B%>assets/vendor_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"
        type="text/javascript"></script>
    <!-- SlimScroll -->
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="<%=G.B%>assets/vendor_components/fastclick/lib/fastclick.js"></script>
    <!-- This is data table -->
    <script src="<%=G.B%>assets/vendor_components/datatable/datatables.min.js"></script>
    <!-- Form validator JavaScript -->
    <script src="<%=G.B%>assets/js/pages/validation.js"></script>
    <script src="<%=G.B%>assets/js/pages/form-validation.js"></script>

    <!-- toast -->
    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
    <!-- Al Manal App -->
    <script src="<%=G.B%>assets/js/template.js"></script>
    <!-- Al Manal for demo purposes -->
    <script src="<%=G.B%>assets/js/demo.js"></script>

    <!-- searchable ddl purposes & multiselect-->
    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>
    <script src="<%=G.B%>assets/vendor_components/moment/min/moment.min.js"></script>

    <script src="<%=G.B%>assets/vendor_components/bootstrap-daterangepicker/daterangepicker.js"></script>
    <script src="<%=G.S%>General/libo.js"></script>
    <script src="supplier.js"></script>
    <script>
        $('.select2').select2();
        $(document).ready(function () {
            $('.dtleave').daterangepicker();
        });

        function Item_filter(obj, ItemType) {
            $("#div_Stock").removeClass("checked")
            $("#div_Non_Stock").removeClass("checked")

            if ($(obj).hasClass("checked")) {
                $(obj).removeClass("checked");
            }
            else {
                $(obj).addClass("checked");
            }
            //item_type = ItemType;
        }


        function Supplier_Type_filter(obj, SupplierType) {
            $("#div_Local").removeClass("checked");
            $("#div_Overseas").removeClass("checked");

            if ($(obj).hasClass("checked")) {
                $(obj).removeClass("checked");
            }
            else {
                $(obj).addClass("checked");
            }
            Make_ReadWrite("btn_general_save");
            Make_ReadWrite("btn_Save_Continue_GenCus");
            Make_ReadWrite("btn_general_save_stay");
            //item_type = SupplierType;
        }
        function GetVat() {
            var Customer_Id = $('#DDL_Get_Parent_Account').val();
            var ExistingVat = $('#txt_vat_number').val();

            if (ExistingVat != "") {
                $.ajax({
                    url: 'H_tbl_Supplier.ashx',
                    type: "POST",
                    data: {
                        'fun': 'GetVat', 'Customer_Id': Customer_Id
                    },
                    success: function (data) {

                        if (Chk_Res(data.errorMessage) == false) {

                        }
                    }
                });
            }
        }
    </script>
</body>
</html>


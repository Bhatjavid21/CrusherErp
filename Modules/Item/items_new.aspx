<%@ Page Language="C#" AutoEventWireup="true" CodeFile="items_new.aspx.cs" Inherits="items" %>


<%@ Register Src="../General/header.ascx" TagName="header" TagPrefix="uc1" %>

<%@ Register Src="../General/sidebar.ascx" TagName="sidebar" TagPrefix="uc2" %>

<%@ Register Src="../General/footer.ascx" TagName="footer" TagPrefix="uc3" %>

<% 
    Session["top_menu"] = "";
    Session["sub_menu"] = "item";    
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../assets/images/favicon.ico">
    <title>Trading ERP - Dashboard</title>
    <!-- Bootstrap 4.0-->
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">

    <!-- Data Table-->
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/vendor_components/datatable/datatables.min.css" />

    <!-- Bootstrap extend-->
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">

    <link href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css" rel="stylesheet" />

    <!-- toast CSS -->
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/js/froiden-helper/helper.css">

    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet">

    <!-- theme style -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">

    <!-- Al Manal skins -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">




    <!--alerts CSS -->
    <link href="<%=G.B%>assets/vendor_components/sweetalert/sweetalert.css" rel="stylesheet" type="text/css">


    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/icheck/skins/all.css">

    <style>
        .fntbld {
            font-weight: bold !important;
        }
    </style>

</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">
    <input type="hidden" id="baseurl" name="baseurl" value="<%=G.B %>" />

    <input type="hidden" id="hid_" name="baseurl" value="" />


    <div class="wrapper">

        <!-- Header Start -->
        <uc1:header ID="header1" runat="server" />
        <!-- Header end -->

        <!-- Sidebar Start -->
        <!-- Left side column. contains the logo and sidebar -->
        <uc2:sidebar ID="sidebar1" runat="server" />
        <!-- Sidebar End -->

        <input type="hidden" name="hdf_branch_id" id="hdf_branch_id" runat="server">
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content mt-20">
                <div class="row">
                    <div class="col-12">
                        <div class="box">

                            <div class="box-header">
                                <div class="row m-10">
                                    <div class="col-10">

                                        <h4 class="page-title">Item List</h4>
                                    </div>
                                    <%-- <div class="right-title col-md-2 text-right">
                                        <i class="mdi mdi-plus plusicon additemlist"></i>
                                    </div>--%>
                                </div>
                            </div>
                            <!-- /.box-header -->

                            <div class="row ml-15" style="margin-bottom: -20px">
                                <div class="col-lg-2">
                                    <div class="form-group mb-15 validate">
                                        <label class="mb-0" for="exampleInputEmail1">Branch</label>
                                        <select class="form-control enq-txtbx-pd fnt12 select2 mb-7 enq-dropdown" style='border: 1px solid #ced4da; border-radius: 25px;' onchange="Bind_Item_grid(0);" runat="server" id="DDL_Branch" aria-invalid="false"></select>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="form-group mb-15">
                                        <label class="mb-0" for="exampleInputEmail1">Search Item</label>
                                        <div class="input-group">
                                            <input type="text" id="txtinput" onkeyup="Bind_Item_grid(0)" class="form-control enq-txtbx-pd attsrch" title="This search brings all relevant results from Item Category, Item Sub-Category, Item Code, OEM Reference, Item Description, Customer Item Code and Customer Item Description fields.">
                                            <span class="search-btn"><i class="ti-search"></i></span>
                                        </div>
                                    </div>
                                </div>



                                <div class="col-lg-3">
                                    <div class="form-group mb-15" style="width: 245px;">
                                        <label class="mb-0" for="exampleInputEmail1">Item Type</label>
                                        <div class="input-group">

                                            <table>
                                                <tr>
                                                    <td>
                                                        <div class="form-group input-group mb-0 ml-0">
                                                            <div class="checkbox text-xs-left enq-txtbx-pd fnt12 mb-0">
                                                                <ul class="icheck-list">

                                                                    <li>
                                                                        <div class="iradio_line-red grp2 checked leave-left-border checked" id="div_all" onclick="filter(this, '0')">
                                                                            <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="All" id="btn_all" data-id="0" style="position: absolute; opacity: 0;" />
                                                                            All<ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; border: 0px none; opacity: 0;"></ins>
                                                                        </div>
                                                                    </li>

                                                                    <li>
                                                                        <div class="iradio_line-red grp2" id="div_stock" onclick="filter(this, '1')">
                                                                            <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Prospects" id="btn_prospect" data-id="0" style="position: absolute; opacity: 0;" />
                                                                            Stock <ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; border: 0px none; opacity: 0;"></ins>
                                                                        </div>
                                                                    </li>


                                                                    <li style="padding-left: 1px;">
                                                                        <div class="iradio_line-red grp2 leave-right-border" id="div_non_stock" onclick="filter(this, '2')">
                                                                            <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Blacklisted" id="btn_blacklisted" data-id="0" style="position: absolute; opacity: 0;" />
                                                                            Non Stock <ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; border: 0px none; opacity: 0;"></ins>
                                                                        </div>
                                                                    </li>
                                                                    <li><i class="mdi mdi-information-outline" title="Clicking on any of the tiles' filters the listed Items based on their Type"></i></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>

                                            </table>


                                        </div>
                                    </div>
                                </div>



                                <div class="col-lg-4">
                                    <div class="form-group mt-15 pr-25 float-right text-right">
                                        <div class="right-title col-md-2 text-right">
                                            <i class="mdi mdi-plus plusicon additemlist"></i>
                                        </div>
                                    </div>
                                </div>

                            </div>



                            <div class="box-body" style="padding-top: 0px !important;">
                                <div class="table-responsive">
                                    <table id="tbl_itemlist" class="table table-hover table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th style="width: 10%; font-weight: bold;">Item Type</th>
                                                <th class="fntbld" style="width: 20%;">Item Sub Category</th>
                                                <th class="fntbld" style="width: 10%;">Item Code</th>
                                                <th class="fntbld" style="width: 45%;">Description</th>
                                                <th class="fntbld" style="width: 5%;">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                        <!-- /.box -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Popup Model Plase Here -->
        <div class="modal fade  bs-example-modal-lg" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel"></h4>
                        <input type="hidden" id="detailsId" name="detailsId" value="" />
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    </div>
                    <div class="modal-body">


                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="lnk-general" data-toggle="tab" href="#tab-general" role="tab">
                                    <span class="hidden-sm-up"><i class="ion-home"></i></span>
                                    <span class="hidden-xs-down">General</span></a> </li>
                            <li class="nav-item disabled">
                                <a class="nav-link disabled" id="lnk-storage" data-toggle="tab" href="#tab-storage" role="tab">
                                    <span class="hidden-sm-up"><i class="ion-person"></i></span>
                                    <span class="hidden-xs-down">Storage Details</span></a> </li>
                            <li class="nav-item disabled">
                                <a class="nav-link disabled" id="lnk-stock" data-toggle="tab" href="#tab-stock" role="tab">
                                    <span class="hidden-sm-up"><i class="ion-email"></i></span>
                                    <span class="hidden-xs-down">Stock Details</span></a> </li>
                            <li class="nav-item disabled">
                                <a class="nav-link disabled" id="lnk-attach" data-toggle="tab" href="#tab-attach" role="tab">
                                    <span class="hidden-sm-up"><i class="ion-email"></i></span>
                                    <span class="hidden-xs-down">Attachments</span></a> </li>
                            <li class="nav-item disabled">
                                <a class="nav-link disabled" id="lnk-external" data-toggle="tab" href="#tab-external" role="tab">
                                    <span class="hidden-sm-up"><i class="ion-email"></i></span>
                                    <span class="hidden-xs-down">External Details</span></a> </li>
                        </ul>

                        <div class="tab-content tabcontent-border">

                            <!-- General Tab starts here -->
                            <div class="tab-pane active pt-20" id="tab-general" role="tabpanel">

                                <input type="hidden" id="hdfmode" value="">
                                <input type="hidden" id="hdf-item-id" value="">
                                <input type="hidden" name="hdf_branch_id" id="Hidden1" runat="server">
                                <input type="hidden" id="hdf_itmcodeDesc" value="">
                                <div class="box-body">
                                    <div class="row">

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Item Type <span class="text-danger">*</span></label>
                                                <div class="controls">
                                                    <input name="group1" type="radio" id="radio_1" value="1" class="clsType" required data-validation-required-message="Item type required">
                                                    <label for="radio_1">Stock</label>
                                                    <input name="group1" type="radio" id="radio_2" value="2" class="clsType">
                                                    <label for="radio_2">Non Stock</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Item Sub Category <span class="text-danger">*</span></label>
                                                <select class="form-control enq-txtbx-pd" name="ddl_item_Sub_Category" id="ddl_item_Sub_Category" required>
                                                    <option value="" selected>Select..</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Item Code <span class="text-danger">*</span></label>
                                                <input type="text" name="txt_ItemCode" id="txt_ItemCode" readonly="true" class="form-control enq-txtbx-pd" required>
                                            </div>
                                        </div>

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>New Item Code</label>
                                                <input type="text" name="txt_new_item_code" class="form-control enq-txtbx-pd" maxlength="20">
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row">

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Brand</label>
                                                <input type="Text" name="txt_brand" id="txt_brand" class="form-control enq-txtbx-pd" maxlength="20">
                                            </div>
                                        </div>

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Manufacturer</label>
                                                <input type="text" name="txt_manufacturer" id="txt_manufacturer" class="form-control enq-txtbx-pd" maxlength="20">
                                            </div>
                                        </div>

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>OEM Reference</label>
                                                <input type="text" name="txt_oem_reference" id="txt_oem_reference" class="form-control enq-txtbx-pd" maxlength="20">
                                            </div>
                                        </div>

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Capacity</label>
                                                <input type="text" name="txt_capacity" id="txt_capacity" class="form-control enq-txtbx-pd" maxlength="20">
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Unit <span class="text-danger">*</span></label>
                                                <input type="text" name="txt_unit" id="txt_unit" class="form-control enq-txtbx-pd" required maxlength="10">
                                            </div>
                                        </div>

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Retail Min Margin % <span class="text-danger">*</span></label>
                                                <input type="text" name="txt_Minimum_Margin" id="txt_Minimum_Margin" class="form-control enq-txtbx-pd ipfloat" required="" data-v-min="0" value="00.00" placeholder="00.00" data-v-max="1000.00">
                                            </div>
                                        </div>


                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>VAT % <span class="text-danger">*</span></label>
                                                <input type="text" name="txt_VAT_Percent" id="txt_VAT_Percent" placeholder="00.00" class="form-control  enq-txtbx-pd ipfloat" data-v-min="0" value="00.00" data-v-max="1000.00" required="">
                                            </div>
                                        </div>

                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Min. Wholesale Quantity <span class="text-danger">*</span></label>
                                                <input type="text" name="txt_wholesale_quantity" id="txt_wholesale_quantity" class="form-control enq-txtbx-pd autonumber" data-v-max="9999999999" data-v-min="0" required="">
                                            </div>
                                        </div>


                                        <div class="col-md-3 col-12">
                                            <div class="form-group">
                                                <label>Min. Wholesale Margin %</label><span class="text-danger">* </span>
                                                <input type="text" name="txt_wholesale_margin" id="txt_wholesale_margin" placeholder="00.00" value="00.00" class="form-control enq-txtbx-pd  ipfloat" data-v-min="0" data-v-max="1000.00" required="">
                                            </div>
                                        </div>


                                        <!--  <div class="row form-group">
                        <div class="col-sm-3">
                            <label class="col-form-label">Rupee (Rs.)</label>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" class="form-control autonumber" data-a-sign="Rs. ">
                        </div>
                    </div>-->

                                        <!-- <div class="row form-group">
                        <div class="col-sm-3">
                            <label class="col-form-label">Range Value (-99.99 - 1000.00)</label>
                        </div>
                        <div class="col-sm-9">
                            <input type="text" class="form-control autonumber" data-v-min="-99.99" data-v-max="1000.00">
                        </div>
                    </div>-->

                                    </div>

                                    <div class="row">
                                        <div class="col-12">
                                            <div class="form-group">
                                                <h5>Description <span class="text-danger">*</span></h5>
                                                <textarea name="txt_description" id="txt_description" class="form-control" required aria-invalid="false" maxlength="300"></textarea>
                                                <div class="help-block"></div>
                                            </div>
                                        </div>
                                        <%--<div class="col-12">
                        <div class="form-group">
                            <h5>Long Description </h5>
                            <div class="controls">
                                <textarea name="txt_long_description" id="txt_long_description" class="form-control" aria-invalid="false" maxlength="300"></textarea>
                                <div class="help-block"></div>
                            </div>
                        </div>
                    </div>--%>
                                        <div class="col-12">
                                            <div class="form-group">
                                                <h5>Arabic Description </h5>
                                                <div class="controls">
                                                    <textarea name="txt_arabic_description" id="txt_arabic_description" class="form-control" aria-invalid="false" maxlength="300"></textarea>
                                                    <div class="help-block"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="box-footer">
                                            <div style="float: left;" class="ml-10">
                                                <button type="button" class="btn btn-default btn-outline mr-1" data-dismiss="modal">
                                                    <i class="ti-trash"></i>Cancel
                                                </button>
                                                <button type="submit" class="btn btn-success btn-outline btn-item-check" id="btnsave" data-value="save" disabled onclick="fillitemsDetailsValidation()">
                                                    <i class="ti-save-alt"></i>Save
                                                </button>
                                            </div>
                                            <div class="text-right mr-10">
                                                <button type="submit" class="btn btn-success btn-item-check" data-value="continue" id="continue" disabled onclick="fillitemsDetailsValidation()">
                                                    <i class="ti-save-alt"></i>Save &amp; Continue
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Storage Details starts here -->
                            <div class="tab-pane" id="tab-storage" role="tabpanel">
                            </div>


                            <!-- Stock Details Tab starts here -->
                            <div class="tab-pane" id="tab-stock" role="tabpanel">
                            </div>
                            <!-- Scope Tab ends here -->

                            <!-- Attachments Tab starts here -->
                            <div class="tab-pane" id="tab-attach" role="tabpanel">
                            </div>
                            <!-- Attachments Tab ends here -->

                            <!-- External Details Tab starts here -->
                            <div class="tab-pane" id="tab-external" role="tabpanel">
                            </div>



                        </div>



                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /Popup Model Plase Here -->



        <!-- /Popup Model Plase Here -->

        <!--footer Start -->
        <uc3:footer ID="footer1" runat="server" />
        <!-- footer end -->

    </div>
    <!-- ./wrapper -->



    <script>
        //  filter("div_all", 0);
    </script>

    <!-- jQuery 3 -->
    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>

    <!-- popper -->
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>

    <!-- Bootstrap 4.0-->
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>

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
    <script src="<%=G.B%>assets/js/bootstrap-growl.min.js"></script>
    <script src="<%=G.B%>assets/js/froiden-helper/helper.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>

    <!-- Al Manal App -->
    <script src="<%=G.B%>assets/js/template.js"></script>

    <!-- Al Manal for demo purposes -->
    <script src="<%=G.B%>assets/js/demo.js"></script>

    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>

    <!-- Sweet-Alert  -->
    <script src="<%=G.B%>assets/vendor_components/sweetalert/sweetalert.min.js"></script>

    <script src="../General/libo.js"></script>

    <script src="item.js"></script>


    <script>
        $(document).ready(function () {



            //Edit Modal Popup
            $(document).on("click", ".lnkitemedit", function (e) {
                var itemId = $(this).attr("data-id");
                var url = "edit-item.aspx?itemid=" + itemId;

                $.easyBlockUI("body");
                $.ajaxModal('.modal', url);
                $(".modal .modal-title").text("Edit Item");
                $.unblockUI();


                $('#detailsId').val("no");

                var strqry = "item_id=" + itemId + "&fun=Edit_Item";

                $.easyAjax({
                    url: "H_tbl_Item.ashx",
                    data: strqry,
                    type: "POST",
                    success: function (response) {
                        if (Chk_Res(response.errorMessage) == false) {
                            $.easyBlockUI("body");
                            var itemlist = response.itemvalue.split("|");
                            //alert(itemlist)
                            $('#hdf-item-id').val(itemId);
                            $('group1').val(itemlist[0]);
                            if (itemlist[0] == 1) {
                                $('#radio_1').attr("checked", true);
                            }
                            else {
                                $('#radio_2').attr("checked", true);
                            }
                            $('#ddl_item_Sub_Category').val(itemlist[1]);
                            populate_dropdown(url, itemlist[0], itemlist[1], $("#hdf_branch_id").val());
                            $('#txt_ItemCode').val(itemlist[2]);
                            $('#txt_new_item_code').val(itemlist[3]);
                            $('#txt_brand').val(itemlist[4]);
                            $('#txt_manufacturer').val(itemlist[5]);
                            $('#txt_oem_reference').val(itemlist[6]);
                            $('#txt_capacity').val(itemlist[7]);
                            $('#txt_unit').val(itemlist[8]);
                            $('#txt_Minimum_Margin').val(itemlist[9]);
                            $('#txt_VAT_Percent').val(itemlist[10]);
                            $('#txt_description').val(itemlist[11]);
                            $('#txt_long_description').val(itemlist[12]);
                            $('#txt_arabic_description').val(itemlist[13]);
                            $('#txt_barcode').val(itemlist[14]);
                            $('#txt_hsecode').val(itemlist[15]);
                            $('#txt_Storage_temprature').val(itemlist[16]);
                            $('#txt_Lenght').val(itemlist[17]);
                            $('#txt_Width').val(itemlist[18]);
                            $('#txt_Height').val(itemlist[19]);
                            $('#chk_has_expiry').val(itemlist[20]);
                            $('#chk_has_Warrenty').val(itemlist[21]);
                            $('#txt_wholesale_quantity').val(itemlist[22]);
                            $('#txt_wholesale_margin').val(itemlist[23]);

                            $.unblockUI();
                        }
                    }
                });

            });

            //Details Modal Popup
            $(document).on("click", ".lnkitemdetails", function (e) {
                var itemId = $(this).attr("data-id");
                var url = "edit-item.aspx?itemid=" + itemId;
                $.easyBlockUI("body");
                $.ajaxModal('.modal', url);
                $(".modal .modal-title").text("Edit Item");
                $.unblockUI();
                var itemId = $(this).attr("data-id");

                $('#detailsId').val("yes");
                var strqry = "item_id=" + itemId + "&fun=Edit_Item";

                $.easyAjax({
                    url: "H_tbl_Item.ashx",
                    data: strqry,
                    type: "POST",
                    success: function (response) {
                        if (Chk_Res(response.errorMessage) == false) {
                            $.easyBlockUI("body");
                            var itemlist = response.itemvalue.split("|");
                            $('#hdf-item-id').val(itemId);
                            $('group1').val(itemlist[0]);
                            if (itemlist[0] == 1) {
                                $('#radio_1').attr("checked", true);
                            }
                            else {
                                $('#radio_2').attr("checked", true);
                            }
                            //$('#ddl_item_Sub_Category').val(itemlist[1]);
                            populate_dropdown(url, itemlist[0], itemlist[1], $("#hdf_branch_id").val());
                            $('#txt_ItemCode').val(itemlist[2]);
                            $('#txt_new_item_code').val(itemlist[3]);
                            $('#txt_brand').val(itemlist[4]);
                            $('#txt_manufacturer').val(itemlist[5]);
                            $('#txt_oem_reference').val(itemlist[6]);
                            $('#txt_capacity').val(itemlist[7]);
                            $('#txt_unit').val(itemlist[8]);
                            $('#txt_Minimum_Margin').val(itemlist[9]);
                            $('#txt_VAT_Percent').val(itemlist[10]);
                            $('#txt_description').val(itemlist[11]);
                            $('#txt_long_description').val(itemlist[12]);
                            $('#txt_arabic_description').val(itemlist[13]);
                            $('#txt_barcode').val(itemlist[14]);
                            $('#txt_hsecode').val(itemlist[15]);
                            $('#txt_Storage_temprature').val(itemlist[16]);
                            $('#txt_Lenght').val(itemlist[17]);
                            $('#txt_Width').val(itemlist[18]);
                            $('#txt_Height').val(itemlist[19]);
                            $('#chk_has_expiry').val(itemlist[20]);
                            $('#chk_has_Warrenty').val(itemlist[21]);
                            $('#txt_wholesale_quantity').val(itemlist[22]);
                            $('#txt_wholesale_margin').val(itemlist[23]);

                            $.unblockUI();
                        }
                    }
                });

            });


            $(document).on("click", ".lnkitemdelete", function (e) {
                e.preventDefault();
                e.stopImmediatePropagation();
                var itemid = $(this).attr("data-id");
                var strqry = "";

                strqry = "item_id=" + itemid + "&fun=Deactivate_Item";
                swal({
                    title: "Are you sure?",
                    text: "You will not be able to recover this item",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "btn-danger",
                    confirmButtonText: "Yes, delete it!",
                    closeOnConfirm: false
                }, function (isConfirm) {
                    // swal("Deleted!", "Your imaginary file has been deleted.", "success");
                    if (isConfirm) {
                        $.easyAjax({
                            url: "H_tbl_Item.ashx",
                            data: strqry,
                            type: "POST",
                            success: function (response) {
                                if (Chk_Res(response.errorMessage) == false) {
                                    if (response.status == "success") {
                                        $.unblockUI();
                                        reloadtable();
                                        swal("Deleted!", "Your Item has been deleted.", "success");
                                    }
                                }
                            }
                        });
                    }
                });

            });
        });


        function reloadtable() {
            $('#tbl_itemlist').DataTable().ajax.reload();
            document.getElementById("tbl_itemlist_paginate").innerHTML = "";
        }




        function populate_dropdown(base_url, itemid, subcatid, branch_Id) {

            $("#ddl_item_Sub_Category").html("");
            $("input[name='txt_ItemCode']").val("");

            $.easyAjax({
                url: "H_tbl_Item.ashx",
                type: "POST",
                redirect: true,
                data: { 'fun': 'item_Sub_Category', 'itemtypeid': itemid, 'subcat': subcatid, 'Branch_Id': branch_Id },
                success: function (data) {
                    if (Chk_Res(data.errorMessage) == false) {
                        if (data.status == "success") {
                            $("#ddl_item_Sub_Category").html("");
                            $("#ddl_item_Sub_Category").append(data.html);
                        }
                    }
                }
            });
        }





        var item_type = "0"; filter("div_all", 0); // this function calls view also

        function Bind_Item_grid(res) {

            var itemslist_table;

            var Branch_Id = $("#DDL_Branch").val();
            // alert(item_type);
            //Bind Datatable here
            itemslist_table = $('#tbl_itemlist').DataTable({
                dom: 'Bfrtip',
                destroy: true,
                "pageLength": 100,
                "processing": false,
                "serverSide": true,
                "aaSorting": [[1, "desc"]],
                'lengthChange': false,
                'searching': false,
                'paging': false,
                'ordering': false,
                'info': false,
                'autoWidth': false,
                "ajax": {
                    "url": "H_tbl_Item.ashx",
                    "type": "POST",
                    "data": {
                        "fun": "View_Item",
                        "branch_id": Branch_Id,
                        "searchTerm": $("#txtinput").val(),
                        "itemType": item_type
                    }
                },
                "fnDrawCallback": function (oSettings) {
                    $("body").tooltip({
                        selector: '[data-toggle="tooltip"]'
                    });
                },
                "columns":
                [
                    {
                        "data": null,
                        "render": function (data, type, row) {
                            var strtype = ""
                            if (data.type_id == 1) {
                                strtype = "Stock";
                            }
                            else {
                                strtype = "Non Stock";
                            }
                            return strtype;
                        }

                    },
                    { "data": "subcatname" },
                    { "data": "itemcode" },
                    { "data": "description" },
                    {
                        "data": null,
                        "render": function (data, type, row) {

                            var straction = '<div class="btn-group">';
                            straction += '          <button data-toggle="dropdown" class="btn btn-outline btn-default dropdown-toggle" aria-expanded="true">';
                            straction += '                           <span><i class="ti-settings"></i></span>';
                            straction += '                        </button>';
                            straction += '                       <ul class="dropdown-menu dropdown-menu-right">';
                            straction += '                            <li><a href="javascript:void(0)" data-id="' + data.itemid + '" class="dropdown-item lnkitemdetails"><i class="fa fa-eye"></i>Details</a></li>';
                            straction += '                              <li class="dropdown-divider"></li>';
                            straction += '                              <li><a href="javascript:void(0)" data-id="' + data.itemid + '" class="dropdown-item lnkitemedit"><i class="fa fa-pencil"></i>Edit</a></li>';
                            straction += '                             <li class="dropdown-divider"></li>';
                            straction += '                              <li><a href="javascript:void(0)" data-id="' + data.itemid + '" class="dropdown-item lnkitemdelete"><i class="fa fa-trash"></i>Delete</a></li>';

                            straction += '                   </ul>';
                            straction += '                  </div>';

                            $('#tbl_itemlist').removeClass("dataTable"); //to change the header design of the grid

                            return straction;
                        }
                    }
                ],
                buttons: []
            });
        }






        //===========================================================filter============================================================


        function filter(obj, ItemType) {
            $("#div_all").removeClass("checked")
            $("#div_stock").removeClass("checked")
            $("#div_non_stock").removeClass("checked")

            if ($(obj).hasClass("checked")) {
                $(obj).removeClass("checked");
            }
            else {
                $(obj).addClass("checked");
            }


            if ($("#div_all").hasClass("checked") == false && $("#div_stock").hasClass("checked") == false && $("#div_non_stock").hasClass("checked") == false) {
                $("#div_all").addClass("checked"); ItemType = 0;

            }

            item_type = ItemType;
            Bind_Item_grid(0);
        }

        //=========================================================================================================================


    </script>


</body>
</html>



<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Copy of edit-item.aspx.cs" Inherits="Modules_Item_edit_item" %>

<ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="lnk-general" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-general" role="tab">
            <span class="hidden-sm-up"><i class="ion-home"></i></span>
            <span class="hidden-xs-down">General</span></a> </li>
    <li class="nav-item">
        <a class="nav-link" id="lnk-storage" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-storage" role="tab">
            <span class="hidden-sm-up"><i class="ion-person"></i></span>
            <span class="hidden-xs-down">Storage Details</span></a> </li>
    <li class="nav-item">
        <a class="nav-link" id="lnk-stock" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-stock" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">Stock Details</span></a> </li>
    <li class="nav-item">
        <a class="nav-link" id="lnk-attach" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-attach" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">Attachments</span></a> </li>
    <li class="nav-item">
        <a class="nav-link" id="lnk-external" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-external" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">External Details</span></a> </li>
</ul>

<div class="tab-content tabcontent-border">

    <!-- General Tab starts here -->
    <div class="tab-pane active pt-20" id="tab-general" role="tabpanel">
        <form novalidate class="ajax-form" id="frm-general-item">
            <input type="hidden" name="hdf-item-id" id="hdf-item-id" value="<%Response.Write(Request.QueryString["itemid"].ToString()); %>"> 
             <input type="hidden" id="hdfmode" value="">
            <div class="box-body">
                <div class="row">

                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>Item Type <span class="text-danger">*</span></label>
                           <div class="controls">
                                <input name="group1" type="radio" id="radio_1"  value="1" class="clsType" required data-validation-required-message="Item type required">
                                <label for="radio_1">Stock</label>
                                <input name="group1" type="radio" id="radio_2"  value="2" class="clsType">
                                <label for="radio_2">Non Stock</label>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>Item Sub Category <span class="text-danger">*</span></label>
                            <select class="form-control" name="ddl_item_Sub_Category" id="ddl_item_Sub_Category">
                                <option value="" selected>Select..</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>Item Code <span class="text-danger">*</span></label>
                            <input type="text" name="txt_ItemCode" id="txt_ItemCode" readonly="true" class="form-control" required data-validation-required-message="Item Code required">
                        </div>
                    </div>

                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>New Item Code</label>
                            <input type="text" name="txt_new_item_code" id="txt_new_item_code" class="form-control">
                        </div>
                    </div>

                </div>

                <div class="row">

                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>Brand</label>
                            <input type="Text" name="txt_brand" id="txt_brand" class="form-control">
                        </div>
                    </div>

                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>Manufacturer</label>
                            <input type="text" name="txt_manufacturer" id="txt_manufacturer" class="form-control">
                        </div>
                    </div>

                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>OEM Reference</label>
                            <input type="text" name="txt_oem_reference" id="txt_oem_reference" class="form-control">
                        </div>
                    </div>

                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>Capacity</label>
                            <input type="text" name="txt_capacity" id="txt_capacity" class="form-control">
                        </div>
                    </div>

                </div>

                <div class="row">
                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>Unit <span class="text-danger">*</span></label>
                            <input type="text" name="txt_unit" id="txt_unit" class="form-control" required data-validation-required-message="Unit required">
                        </div>
                    </div>

                     <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>Minimum Margin % <span class="text-danger">*</span></label>
                            <input type="text" name="txt_Minimum_Margin" id="txt_Minimum_Margin" placeholder="00.00"  class="form-control ipfloat" required="" data-v-min="0" data-v-max="1000.00">
                        </div>
                    </div>


                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label>VAT % <span class="text-danger">*</span></label>
                            <input type="text" name="txt_VAT_Percent" id="txt_VAT_Percent" placeholder="00.00"  class="form-control  ipfloat"  data-v-min="0" data-v-max="1000.00" required="">
                        </div>
                    </div>

                      <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label> Min. Wholesale Quantity <span class="text-danger">*</span></label>
                            <input type="text" name="txt_wholesale_quantity"  id="txt_wholesale_quantity" class="form-control autonumber"  data-v-max="9999999999" data-v-min="0" required="">
                        </div>
                    </div>


                    <div class="col-md-3 col-12">
                        <div class="form-group">
                            <label> Min. Wholesale Margin % <span class="text-danger"> </span></label>
                            <input type="text" name="txt_wholesale_margin" id="txt_wholesale_margin" placeholder="00.00" class="form-control  ipfloat"  data-v-min="0" data-v-max="1000.00" required="">
                        </div>
                    </div>


                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="form-group">
                            <h5>Description <span class="text-danger">*</span></h5>
                            <div class="controls">
                                <textarea name="txt_description" id="txt_description" class="form-control" required=""  aria-invalid="false"></textarea>
                                <div class="help-block"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12" style="display:none;">
                        <div class="form-group">
                            <h5>Long Description </h5>
                            <div class="controls">
                                <textarea name="txt_long_description" id="txt_long_description" class="form-control" aria-invalid="false"></textarea>
                                <div class="help-block"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-group">
                            <h5>Arabic Description </h5>
                            <div class="controls">
                                <textarea name="txt_arabic_description" id="txt_arabic_description" class="form-control" aria-invalid="false"></textarea>
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
                                <i class="ti-trash"></i> Cancel
                            </button>
                            <button type="submit" class="btn btn-success btn-outline btn-item-check" id="btn-item-save" data-value="save">
                                <i class="ti-save-alt"></i> Save
                            </button>
                        </div>
                        <div class="text-right mr-10">
                            <button type="submit" class="btn btn-success btn-item-check" id="btn-item-continue" data-value="continue">
                                <i class="ti-save-alt"></i> Save &amp; Continue
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
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
            <input type="hidden" name="hdf_branch_id" id="hdf_branch_id" runat="server">

</div>

   <script src="../../assets/vendor_components/form-masking/inputmask.js"></script>
<!-- Form validator JavaScript -->
<script src="../../assets/js/pages/validation.js"></script>
<script src="../../assets/js/pages/form-validation.js"></script>



<script>
    $(document).ready(function () {

        //        var base_url = $("#baseurl").val(); //alert(base_url);
        //        var itemId = $("#hdf-item-id").val();
        //        alert(itemId);
        var itemsExternallist_table;

//        //this is used for hide buttons & disable controls on details view mode;
//        var detailsId = $("#detailsId").val();
//       
//        readOnlyControls(detailsId);
//        //End function for hide buttons & disable controls on details view mode;


        // $('[data-mask]').inputmask();
        var base_url = $("#baseurl").val();
        var btnsave = "";



        //Tabs functions
        $("#lnk-general").bind("click", function (e) {
            var itemid = $("#hdf-item-id").val();
            tabgeneral(base_url, itemid);
            //$("#detailsId").val(detailsId);
        });

        $("#lnk-storage").bind("click", function (e) {
            var itemid = $("#hdf-item-id").val();
            tabstorage(base_url, itemid);

        });

        $("#lnk-stock").bind("click", function (e) {
            var itemid = $("#hdf-item-id").val();
            tabstock(base_url, itemid);
        });

        $("#lnk-attach").bind("click", function (e) {
            var itemid = $("#hdf-item-id").val();
            tabattachment(base_url, itemid);
        });

        $("#lnk-external").bind("click", function (e) {
            var itemid = $("#hdf-item-id").val();
            tabexternal(base_url, itemid);
        });



        function tabgeneral(base_url, itemid) {
            $(".modal-backdrop").remove();
            var url = "edit-item.aspx?itemid=" + itemid;
            $.easyBlockUI("body");
            $.ajaxModal('.modal', url);
            $.unblockUI();
        }

        function tabstorage(base_url, itemid) {
            // alert(itemid);
            $(".modal-backdrop").remove();
            var url = "add-storage.aspx?itemid=" + itemid;
            $.easyBlockUI("body");
            $.ajaxModal('.modal', url);
            $.unblockUI();
        }

        function tabstock(base_url, itemid) {
            $(".modal-backdrop").remove();
            var url = "add-stock.aspx?itemid=" + itemid;
            $.easyBlockUI("body");
            $.ajaxModal('.modal', url);
            $.unblockUI();
        }

        function tabattachment(base_url, itemid) {
            $(".modal-backdrop").remove();
            var url = "add-attachment.aspx?itemid=" + itemid;

            $.easyBlockUI("body");
            $.ajaxModal('.modal', url);
            $.unblockUI();
        }

        function tabexternal(base_url, itemid) {
            $(".modal-backdrop").remove();
            var url = "add-external.aspx?itemid=" + itemid;
            $.easyBlockUI("body");
            $.ajaxModal('.modal', url);
            $.unblockUI();
        }

        //this is used for hide buttons & disable controls on details view mode;
        var detailsId = $("#detailsId").val();

        readOnlyControls(detailsId);
        //End function for hide buttons & disable controls on details view mode;

        $(document).on("click", ".btn-item-check", function (e) {
            $("#hdfmode").val($(this).attr("data-value"));
        });

        $(".nav-tabs li a").each(function () {
            $(this).attr("data-id", $("#hdf-item-id").val());
        });

        // Bind ddl Sub Category By Item Type Id on radio button click
        $(document).on("click", ".clsType", function (e) {

            var itemtype_id = $("input[name='group1']:checked").val();
            var branch_Id = $("#hdf_branch_id").val();

            populate_dropdown("", itemtype_id, '0')

            $("#ddl_item_Sub_Category").html("");
            $("input[name='txt_ItemCode']").val("");

        });

        //Fill Edit Details Controls Start;
        var itemId = $("#hdf-item-id").val();
        var strqry = "item_id=" + itemId + "&fun=Edit_Item";
        $.easyAjax({
            url: "H_tbl_Item.ashx",
            data: strqry,
            type: "POST",
            success: function (response) {
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
                populate_dropdown(base_url, itemlist[0], itemlist[1]);
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
        });
        //Fill Edit Details Controls End;


        $(".nav-tabs li a").each(function () {
            $(this).attr("data-id", $("#hdf-item-id").val());
        });

        // Bind ddl Sub Category By Item Type Id on radio button click
        $(document).on("click", ".clsType", function (e) {

            var itemtype_id = $("input[name='group1']:checked").val();
            $("#ddl_item_Sub_Category").html("");
            $("input[name='txt_ItemCode']").val("");
            $.easyAjax({
                url: "H_tbl_Item.ashx",
                type: "POST",
                redirect: true,
                data: { 'fun': 'item_Sub_Category', 'itemtypeid': itemtype_id, 'subcat': '0', 'Branch_Id': branch_Id },
                success: function (data) {
                    if (data.status == "success") {
                        $("#ddl_item_Sub_Category").html("");
                        $("#ddl_item_Sub_Category").append(data.html.replace("selected", ""));
                    }
                }
            });

        });

        // Bind Item Code By Item Sub Cat Id on dropdown change
        $(document).on("change", "#ddl_item_Sub_Category", function (e) {
            var subcat_id = document.getElementById("ddl_item_Sub_Category").value;
            $.easyAjax({
                url: "H_tbl_Item.ashx",
                type: "POST",
                redirect: true,
                data: { 'fun': 'Prefix_Code', 'ddl_subcatId': subcat_id },
                success: function (data) {
                    if (data.status == "success") {
                        $('#txt_ItemCode').val(data.html);
                    }
                }
            });

        });


        //Update General Item Details 
        $('#frm-general-item').submit(function (e) {
            btnsave = $("#hdfmode").val();
            e.preventDefault();
            if (validateForm()) {
                e.stopImmediatePropagation();
                var item_id = $("#hdf-item-id").val();
                var strqry = "";
                strqry = $("#frm-general-item").serialize();
                strqry = strqry + "&fun=Update_Item";
                $.easyAjax({
                    url: "H_tbl_Item.ashx",
                    data: strqry,
                    type: "POST",
                    success: function (response) {
                        if (response.status == "success") {
                            $.easyBlockUI("body");
                            if (btnsave == "save") {
                                hideModal();
                            }
                            else {
                                tabstorage(base_url, item_id);
                            }
                            reloadtable();
                            $.unblockUI();
                            ResetFields();
                            $("#ddl_item_Sub_Category").html("");
                        }

                    }
                });
            }
        });


        $(document).on("click", "#lnk-storage", function (e) {
            //$("#lnk-storage").bind("click", function (e) {

            var itemtype = $(".clsType").is(":checked");
            var itemid = $("#hdf-item-id").val();

            if (itemid == "") {
                $(".nav-tabs li a").addClass("disabled");
                // calltoast("Tab is blocked in edit form, Fill Details first.", "info");
            }
            else {
                tabstorage(base_url, itemid);
            }

        });

        $(document).on("click", "#lnk-stock", function (e) {
            var itemid = $("#hdf-item-id").val();

            if (itemid == "") {
                $(".nav-tabs li a").addClass("disabled");
                //calltoast("Tab is blocked in edit form, Fill Details first.", "info");
            }
            else {
                tabstock(base_url, itemid);
            }
        });

        $(document).on("click", "#lnk-attach", function (e) {
            var itemid = $("#hdf-item-id").val();

            if (itemid == "") {
                $(".nav-tabs li a").addClass("disabled");
                // calltoast("Tab is blocked in edit form, Fill Details first.", "info");
            }
            else {
                tabattachment(base_url, itemid);
            }
        });

        $(document).on("click", "#lnk-external", function (e) {
            var itemid = $("#hdf-item-id").val();
            if (itemid == "") {
                $(".nav-tabs li a").addClass("disabled");
                // calltoast("Tab is blocked in edit form, Fill Details first.", "info");
            }
            else {
                tabexternal(base_url, itemid);
            }
        });

    });

    function readOnlyControls(detailsId) {
        if (detailsId == "yes") {
            alert("disable")
            toHide("btn-item-save,btn-item-continue");
            Make_ReadOnly("radio_1,radio_2,ddl_item_Sub_Category,txt_new_item_code,txt_brand,txt_manufacturer,txt_oem_reference,txt_capacity,txt_unit,txt_Minimum_Margin,txt_VAT_Percent,txt_description,txt_long_description,txt_arabic_description,txt_wholesale_quantity,txt_wholesale_margin");
        }
        else {

        }
    }



    function tabgeneral(base_url) {
        $(".modal-backdrop").remove();
        var url = "edit-item.aspx";
        $.easyBlockUI("body");
        $.ajaxModal('.modal', url);
        $.unblockUI();
    }

    function tabstorage(base_url, itemid) {
        $(".modal-backdrop").remove();
        var url = "add-storage.aspx?itemid=" + itemid;
        $.easyBlockUI("body");
        $.ajaxModal('.modal', url);
        $.unblockUI();
    }

    function tabstock(base_url, itemid) {
        $(".modal-backdrop").remove();
        var url = "add-stock.aspx?itemid=" + itemid;
        $.easyBlockUI("body");
        $.ajaxModal('.modal', url);
        $.unblockUI();
    }

    function tabattachment(base_url, itemid) {
        $(".modal-backdrop").remove();
        var url = "add-attachment.aspx?itemid=" + itemid;

        $.easyBlockUI("body");
        $.ajaxModal('.modal', url);
        $.unblockUI();
    }

    function tabexternal(base_url, itemid) {
        $(".modal-backdrop").remove();
        var url = "add-external.aspx?itemid=" + itemid;
        $.easyBlockUI("body");
        $.ajaxModal('.modal', url);
        $.unblockUI();
    }

    function validateForm() {
        var isValid = true;
        $('input,textarea,select').filter('[required]:visible').each(function () {
            if ($(this).val() === '')
                isValid = false;
        });
        return isValid;
    }

    function hideModal() {
        $(".modal").removeClass("show");
        $(".modal").removeAttr("style");
        $('body').removeClass('modal-open');
        $('body').removeAttr('style');
        $('.modal-backdrop').remove();
        $('.modal-backdrop').hide();
        $(".modal").hide();
    }

    function ResetFields() {
        $('#frm-general-item')[0].reset();

    }

    function reloadtable() {
        $('#tbl_itemlist').DataTable().ajax.reload();
    }


    function populate_dropdown(branch_Id, itemtype_id, subcat) 
    {
        var itemtype_id = $("input[name='group1']:checked").val();
        var branch_Id = $("#hdf_branch_id").val();
        //alert(itemtype_id + "==" + branch_Id)

        $("#ddl_item_Sub_Category").html("");
        $("input[name='txt_ItemCode']").val("");

        $.easyAjax({
            url: "H_tbl_Item.ashx",
            type: "POST",
            redirect: true,
            data: { 'fun': 'item_Sub_Category', 'itemtypeid': itemtype_id, 'subcat': subcat, 'Branch_Id': branch_Id },
            success: function (data) {
                if (data.status == "success") {
                    $("#ddl_item_Sub_Category").html("");
                    $("#ddl_item_Sub_Category").append(data.html);
                }
            }
        });
    }
</script>


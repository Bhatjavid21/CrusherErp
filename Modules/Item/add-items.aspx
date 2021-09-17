<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add-items.aspx.cs" Inherits="addItem" %>

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
    
    <li class="nav-item disabled">
        <a class="nav-link disabled" id="lnk-price" data-toggle="tab" href="#tab-price" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">Prices</span></a> </li>
</ul>

<div class="tab-content ">

    <!-- General Tab starts here -->
    <div class="tab-pane active pt-10" id="tab-general" role="tabpanel">
        <form novalidate class="ajax-form" id="frm-general-item">
            <input type="hidden" id="hdfmode" value="">
            <input type="hidden" id="hdf-item-id" value="">
            <input type="hidden" name="hdf_branch_id" id="hdf_branch_id" runat="server">
            <div class="">
                <div class="row">

                    <div class="col-md-12 col-12">
                        <div class="form-group">
                            <label>Item Type <span class="text-danger">*</span></label>
                            <div class="controls">
                                <input name="group1" type="radio" id="radio_1" value="1" class="clsType"  >
                                <label for="radio_1">Stock</label>
                                <input name="group1" type="radio" id="radio_2" value="2" class="clsType">
                                <label for="radio_2">Non Stock</label>

                                <input name="group1" type="radio" id="radio_3"  value="3" class="clsType">
                                <label for="radio_3">Service</label>
                            </div>
                        </div>



                       
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Item Sub Category <span class="text-danger">*</span></label>
                            <select class="form-control enq-txtbx-pd fnt12 enq-dropdown select2" name="ddl_item_Sub_Category" id="ddl_item_Sub_Category" >
                                <option value="" selected>Select..</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Item Code <span class="text-danger">*</span></label>
                            <input type="text" name="txt_ItemCode" id="txt_ItemCode" readonly="true" class="form-control enq-txtbx-pd" >
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>New Item Code</label>
                            <input type="text" name="txt_new_item_code" class="form-control enq-txtbx-pd" maxlength="50">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Unit <span class="text-danger">*</span></label>
                            <input type="text" name="txt_unit" id="txt_unit" class="form-control enq-txtbx-pd"  maxlength="20">
                        </div>
                    </div>
                </div>


                <div class="row" id="row2">

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Brand</label>
                            <input type="Text" name="txt_brand" id="txt_brand" class="form-control enq-txtbx-pd" maxlength="100">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Manufacturer</label>
                            <input type="text" name="txt_manufacturer" id="txt_manufacturer" class="form-control enq-txtbx-pd" maxlength="100">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>OEM Reference</label>
                            <input type="text" name="txt_oem_reference" id="txt_oem_reference" class="form-control enq-txtbx-pd" maxlength="100">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Capacity</label>
                            <input type="text" name="txt_capacity" id="txt_capacity" class="form-control enq-txtbx-pd" maxlength="20">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Retail Min Margin % </label>
                            <input type="text" name="txt_Minimum_Margin" id="txt_Minimum_Margin" class="form-control enq-txtbx-pd ipfloat"  data-v-min="0" data-v-max="1000.00">
                        </div>
                    </div>

                     <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label> Wholesale Min. Margin % <span class="text-danger"> </span></label>
                            <input type="text" name="txt_wholesale_margin" id="txt_wholesale_margin" class="form-control enq-txtbx-pd  ipfloat"  data-v-min="0" data-v-max="1000.00">
                        </div>
                    </div>

                </div>

                <div class="row">
                    
                    <div class="col-md-6 col-12" id="col_Min_Whole_QTY">
                        <div class="form-group">
                            <label> Min. Wholesale Quantity <span class="text-danger">*</span></label>
                            <input type="text" name="txt_wholesale_quantity" id="txt_wholesale_quantity" class="form-control enq-txtbx-pd autonumber"  maxlength="10" >
                        </div>
                    </div>

                    <div class="col-md-6 col-12" id="col_rate">
                        <div class="form-group">
                            <label>Rate <span class="text-danger"> </span></label>
                            <input type="text" name="txt_rate" id="txt_rate" class="form-control enq-txtbx-pd autonumber"  maxlength="10">
                        </div>
                    </div>

                     <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>VAT % <span class="text-danger">*</span></label>
                            <input type="text" name="txt_VAT_Percent" id="txt_VAT_Percent" class="form-control  enq-txtbx-pd ipfloat"  maxlength="10" >
                        </div>
                    </div>



                    <div class="col-md-6 col-12" id="col_fsp">
                        <div class="form-group">
                           <input type="checkbox" name="chk_Fixed_Sales_Price" id="chk_Fixed_Sales_Price" onclick="Chk_Fixed_Prices('1')" value="1"  aria-invalid="false">
                                <label for="chk_Fixed_Sales_Price">Fixed Sales Price</label>
                            <input type="text" name="txt_Fixed_Sales_Price" id="txt_Fixed_Sales_Price" class="form-control enq-txtbx-pd autonumber" style="display:none;" maxlength="10" data-v-max="9999999999" data-v-min="0">
                        </div>
                    </div>

                     <div class="col-md-6 col-12" id="col_fpp">
                        <div class="form-group">
                           <input type="checkbox" name="chk_Fixed_Purchase_Price" id="chk_Fixed_Purchase_Price" onclick="Chk_Fixed_Prices('1')" value="2"  aria-invalid="false">
                                <label for="chk_Fixed_Purchase_Price">Fixed Purchase Price</label>
                            <input type="text" name="txt_Fixed_Purchase_Price" id="txt_Fixed_Purchase_Price" class="form-control enq-txtbx-pd autonumber" style="display:none;"  maxlength="10">
                        </div>
                    </div>
                    <script>
                        function Chk_Fixed_Prices(which)
                        {
                            if (getObj("chk_Fixed_Sales_Price").checked == true) {
                                toShow("txt_Fixed_Sales_Price");
                            }
                            else
                            {
                                SetVal("txt_Fixed_Sales_Price", ""); 
                                toHide("txt_Fixed_Sales_Price")
                            }

                            if (getObj("chk_Fixed_Purchase_Price").checked == true) {
                                toShow("txt_Fixed_Purchase_Price")
                            }
                            else {
                                SetVal("txt_Fixed_Purchase_Price","")
                                toHide("txt_Fixed_Purchase_Price")
                            }
                        }
                    </script>
                    
             </div>

                <div class="row">
                    <div class="col-12">
                        <div class="form-group">
                            <label class="fnt16">Description <span class="text-danger">*</span></label>
                            <textarea name="txt_description" id="txt_description" class="form-control" aria-invalid="false" maxlength="2000"></textarea>
                            <div class="help-block"></div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-group" style="display:none;">
                            <label class="fnt16">Long Description </label>
                            <div class="controls">
                                <textarea name="txt_long_description" id="txt_long_description" class="form-control" aria-invalid="false" maxlength="2000"></textarea>
                                <div class="help-block"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="form-group">
                            <label class="fnt16">Arabic Description </label>
                            <div class="controls">
                                <textarea name="txt_arabic_description" id="txt_arabic_description" class="form-control" aria-invalid="false" maxlength="2000"></textarea>
                                <div class="help-block"></div>
                            </div>
                        </div>
                    </div>
                    
                </div>

            </div>

           
                    <div class="box-footer">
                       
                            <button type="button" class="btn btn-dark " data-dismiss="modal">
                                <i class="ti-trash"></i>&nbsp; Cancel
                            </button>
                            <button type="submit" class="btn btn-success right btn-item-check" data-value="save" id="btnsave" disabled onclick="fillitemsDetailsValidation()">
                                <i class="ti-save-alt"></i> Save
                            </button>
                      
                            <button type="submit" class="btn btn-success right mr-5 btn-item-check" data-value="continue" id="continue" disabled onclick="fillitemsDetailsValidation()">
                                <i class="ti-save-alt"></i> Save &amp; Continue
                            </button>
                       
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

    <!-- Fixed Price Details Tab starts here -->
    <div class="tab-pane" id="tab-price" role="tabpanel">
    </div>

</div>


<script src="../../assets/vendor_components/form-masking/inputmask.js"></script>

<!-- Form validator JavaScript -->
<script src="../General/libo.js"></script>
<script src="../../assets/js/pages/validation.js"></script>
<script src="../../assets/js/pages/form-validation.js"></script>
<%--<style type="text/css">
    .select2-container--default{
        border-radius: 5px;
        border: 1px solid red;
    }
</style>--%>

<script>

    function abc(obj) {
        if ($("#select2-" + obj + "-container")) { // if this is select2 ddl

            if (getVal(obj) == 0 || getVal(obj) == "") {
                $("#" + obj).siblings(".select2-container--default").css({'border':'1px solid red', 'border-radius':'5px'});
                //$("#" + obj).siblings(".select2-container--default").css();
            }
            else {
                $("#ddl_item_Sub_Category").siblings(".select2-container--default").css({ 'border': '1px solid green', 'border-radius': '5px' });
            }
        }
    }


    $(document).ready(function () {
        // $('[data-mask]').inputmask();
        var base_url = $("#baseurl").val();
        var btnsave = "";

        // Bind ddl Sub Category By Item Type Id on radio button click

        $(document).on("click", ".clsType", function (e) {
            var itemtype_id = $("input[name='group1']:checked").val();

            if (itemtype_id == 3) {

                toHide("row2");
                toHide("col_Min_Whole_QTY"); 
                toHide("col_fsp");
                toHide("col_fpp");
                toShow("col_rate");
                getObj("col_rate").style.display = '';

                if (getVal("txt_wholesale_quantity") == "") {
                    SetVal("txt_wholesale_quantity", "0");
                }
            }
            else {
                toHide("col_rate");
                toShow("row2");
                toShow("col_fsp");
                toShow("col_fpp");
                getObj("row2").style.display = '';
                toShow("col_Min_Whole_QTY");
                getObj("col_Min_Whole_QTY").style.display = '';
            }


            

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


        //Set Button data value on hidden field
        $(document).on("click", ".btn-item-check", function (e) {
            $("#hdfmode").val($(this).attr("data-value"));
        });


        //General Item Details Submit
        $('#frm-general-item').submit(function (e) {
            e.preventDefault();
            btnsave = $("#hdfmode").val();
            
            if (setBorderColor_Validation("ddl_item_Sub_Category,txt_ItemCode,txt_wholesale_quantity,txt_VAT_Percent,txt_description,txt_unit") == "0") {
                                calltoast("Please fill the mandatory infromaton.", "error");
                            }
                            else {
                               
                                if (validateForm()) {
                                    e.stopImmediatePropagation();
                                    var strqry = "";
                                    strqry = $("#frm-general-item").serialize();
                                    strqry = strqry + "&fun=Insert_Item";
                                    $.easyAjax({
                                        url: "H_tbl_Item.ashx?Branch_Id=" + $('#hdf_branch_id').val() + "",
                                        data: strqry,
                                        type: "POST",
                                        success: function (response) {
                                            if (response.status == "success") {
                                                $.easyBlockUI("body");
                                                if (btnsave == "save") {
                                                    hideModal();
                                                }
                                                else {
                                                    tabstorage(base_url, response.itemid);
                                                }
                                                // reloadtable();
                                                Bind_Item_grid_N();
                                                $.unblockUI();
                                                ResetFields();
                                                $("#ddl_item_Sub_Category").html("");
                                                $("#hdf-item-id").val(response.itemid);
                                            }

                                        }
                                    });
                                }
                            }
            //}
            //else {
            //    e.preventDefault();
            //    e.stopImmediatePropagation();
            //    calltoast("Please check mandatory fields", "error");
            //    return false;
            //}
        });

        Bind_Item_Category();
        function Bind_Item_Category() {

            var itemtype_id = $("input[name='group1']:checked").val();
            var branch_Id = $("#hdf_branch_id").val();

            $.easyAjax({
                url: "H_tbl_Item.ashx",
                type: "POST",
                redirect: true,
                data: { 'fun': 'item_Sub_Category', 'itemtypeid': itemtype_id, 'subcat': 0, 'Branch_Id': branch_Id },
                success: function (data) {
                    if (data.status == "success") {
                        $("input[name='txt_ItemCode']").val("");
                        $("#ddl_item_Sub_Category").html("");
                        $("#ddl_item_Sub_Category").append(data.html);
                        $('.select2').select2();
                    }
                }
            });
        }
        //Tabs functions
        //$("#lnk-general").bind("click", function (e) {
        //    var itemid = $("#hdf-item-id").val();
        //    tabgeneral(base_url);
        //});

        $("#lnk-storage").bind("click", function (e) {
            var itemid = $("#hdf-item-id").val();
            if (itemid == "") {
                $(".nav-tabs li a").addClass("disabled");
                calltoast("Tab is blocked, Fill Item Details first.", "info");
            }
            else {
                tabstorage(base_url, itemid);
            }

        });

        $("#lnk-stock").bind("click", function (e) {
            //$(document).on("click", "#lnk-stock", function (e) {
            //tabstock(base_url);
            var itemid = $("#hdf-item-id").val();
            if (itemid == "") {
                $(".nav-tabs li a").addClass("disabled");
                calltoast("Tab is blocked, Fill Details first.", "info");
            }
        });

        $("#lnk-attach").bind("click", function (e) {
            //$(document).on("click", "#lnk-attach", function (e) {
            //tabattachment(base_url);
            var itemid = $("#hdf-item-id").val();
            if (itemid == "") {
                $(".nav-tabs li a").addClass("disabled");
                calltoast("Tab is blocked, Fill Details first.", "info");
            }
        });

        $("#lnk-external").bind("click", function (e) {
            //tabexternal(base_url);
            var itemid = $("#hdf-item-id").val();
            if (itemid == "") {
                $(".nav-tabs li a").addClass("disabled");
                calltoast("Tab is blocked, Fill Details first.", "info");
            }
        });

        $("#lnk-price").bind("click", function (e) {
            
            var itemid = $("#hdf-item-id").val();
            if (itemid == "") {
                $(".nav-tabs li a").addClass("disabled");
                calltoast("Tab is blocked, Fill Details first.", "info");
            }
        });

        $("input,select,textarea").on("click", function (e) {
            $('#btnsave').removeAttr("disabled");
            $('#continue').removeAttr("disabled");
        });
        $("input,select,textarea").keypress(function (e) {
            $('#btn-item-save').removeAttr("disabled");
            $('#btn-item-continue').removeAttr("disabled");
        });

    });


    function fillitemsDetailsValidation() {
        var vld = 1
        //if ($('input[name="group1"]').is(":checked") == false || $('#ddl_item_Sub_Category').val() == "0" || $('#txt_ItemCode').val() == "" || $('#txt_unit').val() == "" || $('#txt_VAT_Percent').val() == "" || $('#txt_description').val() == "") {
        //    vld = 0;
        //}

        if (getObj("chk_Fixed_Sales_Price").checked == true) {
            if (ValidateOne(getObj("txt_Fixed_Sales_Price")) == false) {
                vld = 0;
            }
        }
        if (getObj("chk_Fixed_Purchase_Price").checked == true) {
            if (ValidateOne(getObj("txt_Fixed_Purchase_Price")) == false) {
                vld = 0;
            }
        }
        if (vld == 0) {
            calltoast("Please fill the mandatory infromaton.", "error"); return false;
        }
    }


    function tabgeneral(base_url) {
        $(".modal-backdrop").remove();
        var url = "add-items.aspx";
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

    function tabprice(base_url, itemid) {
        $(".modal-backdrop").remove();
        var url = "fixed_price.aspx?itemid=" + itemid;
        $.easyBlockUI("body");
        $.ajaxModal('.modal', url);
        $.unblockUI();
    }


    //function validateForm() {
    //    var isValid = true;
    //    $('input,textarea,select').filter('[required]:visible').each(function () {
    //        if ($(this).val() === '')
    //            isValid = false;
    //    });
    //    return isValid;
    //}

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


    function calltoast(msg, msgtype) {
        $.toast({
            heading: '',
            text: msg,
            position: 'top-right',
            loaderBg: '#ff6849',
            icon: msgtype,
            hideAfter: 3000,
            stack: 6
        });
    }

    function reloadtable() {
        $('#tbl_itemlist').DataTable().ajax.reload();
    }

</script>


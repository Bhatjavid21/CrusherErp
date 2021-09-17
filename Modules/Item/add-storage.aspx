<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add-storage.aspx.cs" Inherits="Modules_Item_add_storage" %>

<ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
        <a class="nav-link" id="lnk-general" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-general" role="tab">
            <span class="hidden-sm-up"><i class="ion-home"></i></span>
            <span class="hidden-xs-down">General</span></a> </li>
    <li class="nav-item ">
        <a class="nav-link active" id="lnk-storage" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-storage" role="tab">
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
    <li class="nav-item">
        <a class="nav-link" id="lnk-price" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-price" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">Prices</span></a> </li>
</ul>

<div class="tab-content ">
    <!-- General Tab starts here -->
    <div class="tab-pane " id="tab-general" role="tabpanel">
        
    </div>

    <!-- Storage Details starts here -->
    <div class="tab-pane active pt-10" id="tab-storage" role="tabpanel">
        <form novalidate class="ajax-form" id="frm-storage-item">
            <input type="hidden" id="hdf-item-id" name="hdf-item-id" value="<%Response.Write(Request.QueryString["itemid"].ToString()); %>">
              <input type="hidden" id="detailsId" name="detailsId" value="" />
              <input type="hidden" id="hdfmode" value="">
            <div class="">
                <div class="row">

                    <div class="controls">

                        <div class="help-block"></div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Barcode <span class="text-danger">*</span></label>
                            <input type="text" name="txt_barcode" id="txt_barcode" class="form-control enq-txtbx-pd"  maxlength="20">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>HSE Code</label>
                            <input type="text" name="txt_hsecode" id="txt_hsecode" class="form-control enq-txtbx-pd" maxlength="20">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Storage Temprature</label>
                            <input type="text" name="txt_Storage_temprature" maxlength="50" id="txt_Storage_temprature" class="form-control enq-txtbx-pd ipfloat" data-v-min="0" data-v-max="1000.00">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Length</label>
                            <input type="text" name="txt_length" id="txt_length" class="form-control enq-txtbx-pd" maxlength="20">
                        </div>
                    </div>

                </div>

                <div class="row">

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Width</label>
                            <input type="Text" name="txt_width" id="txt_width" class="form-control enq-txtbx-pd" maxlength="20">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label>Height</label>
                            <input type="text" name="txt_hight" id="txt_hight" class="form-control enq-txtbx-pd" maxlength="20">
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label></label>
                            <div class="controls">
                                <input type="checkbox" name="chk_has_expiry" id="basic_checkbox_1" value="1">
                                <label for="basic_checkbox_1">Has Expiry </label>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-12">
                        <div class="form-group">
                            <label></label>
                            <div class="controls">
                                <input type="checkbox"  name="chk_has_Warrenty" id="basic_checkbox_2" value="1">
                                <label for="basic_checkbox_2">Has Warrenty</label>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

          
                    <div class="box-footer">
                       
                            <button type="button" class="btn btn-dark" data-dismiss="modal">
                                <i class="ti-trash"></i>&nbsp; Cancel
                            </button>
                            <button type="submit" class="btn btn-success right" disabled id="btn-scope-save" data-value="save" onclick="fillitemsDetailsValidation()">
                                <i class="ti-save-alt"></i>&nbsp; Save
                            </button>
                       
                            <button type="submit" class="btn btn-success right mr-10" disabled id="btn-scope-update" data-value="continue" onclick="fillitemsDetailsValidation()">
                                <i class="ti-save-alt"></i>&nbsp; Save &amp; Continue
                            </button>
                        </div>
               
        </form>
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
    <div class="tab-pane" id="tab-external" role="tabpanel"></div>

        <div class="tab-pane" id="tab-price" role="tabpanel">
       
    </div>



</div>

<script src="../../assets/vendor_components/form-masking/inputmask.js"></script>

<!-- Form validator JavaScript -->
<script src="../../assets/js/pages/validation.js"></script>
<script src="../../assets/js/pages/form-validation.js"></script>



<script>
    $(document).ready(function () {
        // $('[data-mask]').inputmask();
        var base_url = $("#baseurl").val();
        var btnsave = "";

        //this is used for hide buttons & disable controls on details view mode;
        var detailsId = $("#detailsId").val();
        readOnlyControls(detailsId);
        //End function for hide buttons & disable controls on details view mode;


        $(document).on("click", ".btn-item-check", function (e) {
            $("#hdfmode").val($(this).attr("data-value"));
        });

        var itemId = $("#hdf-item-id").val();
        var strqry = "item_id=" + itemId + "&fun=Edit_Item";
        $.easyAjax({
            url: "H_tbl_Item.ashx",
            data: strqry,
            type: "POST",
            success: function (response) {
                $.easyBlockUI("body");
                var itemlist = response.itemvalue.split("|");
                $('#txt_barcode').val(itemlist[14]);
                $('#txt_hsecode').val(itemlist[15]);
                $('#txt_Storage_temprature').val(itemlist[16]);
                $('#txt_length').val(itemlist[17]);
                $('#txt_width').val(itemlist[18]);
                $('#txt_hight').val(itemlist[19]);
                if (itemlist[20] == "True") {
                    $('#basic_checkbox_1').attr("checked", true);
                }
                if (itemlist[21] == "True") {
                    $('#basic_checkbox_2').attr("checked", true);
                }

                $.unblockUI();
            }
        });

        //Update Storage Item Details 
        $('#frm-storage-item').submit(function (e) {
            btnsave = $("#hdfmode").val();
            if (setBorderColor_Validation("#txt_barcode'") == "0") {
                calltoast("Please fill the mandatory infromaton.", "error");
            }
            else {
                e.preventDefault();
                if (validateForm()) {
                    e.stopImmediatePropagation();
                    var item_id = $("#hdf-item-id").val();
                    var strqry = "";
                    strqry = $("#frm-storage-item").serialize();
                    strqry = strqry + "&fun=Update_Storage";
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
                                    tabstock(base_url, item_id);
                                }
                                // reloadtable();
                                $.unblockUI();
                                ResetFields();
                                $("#ddl_item_Sub_Category").html("");
                            }

                        }
                    });
                }
            }
        });

        //Tabs functions
        $("#lnk-general").bind("click", function (e) {
            var itemid = $("#hdf-item-id").val();
            tabgeneral(base_url, itemid);
            $("#detailsId").val(detailsId);
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

        $("#lnk-price").bind("click", function (e) {
            var itemid = $("#hdf-item-id").val();
            tabexternal(base_url, itemid);
        });

        $("input,select,textarea").on("click", function (e) {
            $('#btn-scope-save').removeAttr("disabled");
            $('#btn-scope-update').removeAttr("disabled");
        });
        $("input,select,textarea").keypress(function (e) {
            $('#btn-scope-save').removeAttr("disabled");
            $('#btn-scope-update').removeAttr("disabled");
        });

    });


    //function fillitemsDetailsValidation() {
    //    if ($('#txt_barcode').val() == "") { //|| $('#basic_checkbox_1').is(":checked") == false || $('#basic_checkbox_2').is(":checked") == false
    //        calltoast("Please fill the mandatory information.", "error");
    //    }
    //}


    function tabgeneral(base_url, itemid) {
        $(".modal-backdrop").remove();
        var url = "edit-item.aspx?itemid=" + itemid;
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

    function readOnlyControls(detailsId) {
        if (detailsId == "yes") {
            toHide("btn-scope-save,btn-scope-update");
            Make_ReadOnly("txt_barcode,txt_hsecode,txt_Storage_temprature,txt_length,txt_width,txt_hight,basic_checkbox_1,basic_checkbox_2");
        }
        else {

        }
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

</script>

<script src="../General/libo.js"></script>


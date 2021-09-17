<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add-stock.aspx.cs" Inherits="Modules_Item_add_stock" %>

<ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
        <a class="nav-link" id="lnk-general" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-general" role="tab">
            <span class="hidden-sm-up"><i class="ion-home"></i></span>
            <span class="hidden-xs-down">General</span></a> </li>
    <li class="nav-item">
        <a class="nav-link" id="lnk-storage" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-storage" role="tab">
            <span class="hidden-sm-up"><i class="ion-person"></i></span>
            <span class="hidden-xs-down">Storage Details</span></a> </li>
    <li class="nav-item">
        <a class="nav-link active" id="lnk-stock" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-stock" role="tab">
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
    <div class="tab-pane" id="tab-storage" role="tabpanel">
    </div>


    <!-- Stock Details Tab starts here -->
    <div class="tab-pane active pt-10" id="tab-stock" role="tabpanel">
        <div class="row" id="rwscopeplus">
            <div class="col-md-12">
                <div class=" ">
                    <div class="box-controls pull-right">
                        <div class="box-header-actions">
                            <button class="btn btn-success" data-toggle="tooltip" data-original-title="Add Stock Details" id="btn-scope-add"><i class="mdi mdi-plus plusicon" ></i>&nbsp;Add Stock</button>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <form novalidate class="form-horizontal ajax-form" id="frm-stock-details">
            <input type="hidden" name="hdf-item-id" id="hdf-item-id" value="<%Response.Write(Request.QueryString["itemid"].ToString()); %>">
            <input type="hidden" name="hdf-itemstock-id" id="hdf-itemstock-id" value="">
            <div class="row hide" id="rwscope-add">
                <div class="col-md-12 mb-5">
                    <div class="">
                        <%--<div class="box-header with-border">
                            <h5 class="modal-title">Add Stock Details</h5>
                            <div class="box-tools pull-right">
                                <ul class="box-controls">
                                    <li>
                                        <button type="button" id="btn-scope-close" class="close" style="font-size: 17px; color: #455A64;" aria-hidden="true">×</button>
                                    </li>
                                </ul>
                            </div>
                        </div>--%>
                        <div class="">
                            <div class="row">

                                <div class="col-md-6 col-12">
                                    <div class="form-group">
                                        <label>Warehouse <span class="text-danger">*</span></label>
                                        <div class="controls">
                                            <select class="form-control enq-txtbx-pd mb-10 select2"  name="ddl_warehouse_id" id="ddl_warehouse_id"  aria-invalid="true">
                                              
                                            </select>
                                            <div class="help-block"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 col-12">
                                    <div class="form-group">
                                        <div class="controls">
                                            <label>Minimum Balance Quantity <span class="text-danger">*</span></label>
                                            <input type="text" name="txt_Minimum_Balance_Qty" id="txt_Minimum_Balance_Qty" class="form-control enq-txtbx-pd autonumber" data-v-max="99999" data-v-min="0"  aria-invalid="true">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 col-12">
                                    <div class="form-group">
                                            <label>Re-Order Quantity</label>
                                            <input type="text" name="txt_Re-Order_Quantity" id="txt_Re-Order_Quantity" class="form-control enq-txtbx-pd autonumber"  aria-invalid="true" data-v-max="99999" data-v-min="0">
                                    </div>
                                    <!-- /.form-group -->
                                </div>

                            </div>
                            <div >
                           <button type="submit" id="btn-scope-close" class="btn btn-dark">&nbsp;Cancel</button>
                                            <button type="submit" class="btn btn-success right" id="btn-scope-save"  onclick="fillitemsDetailsValidation()">
                                                <i class="ti-save-alt"></i>&nbsp; Save
                                            </button>
                                            <button type="submit" class="btn btn-success right" id="btn-scope-update" disabled onclick="fillitemsDetailsValidation()">
                                                <i class="ti-save-alt"></i>&nbsp; Update
                                            </button>
                                    </div>
                             
                            </div>
                     
                    </div>
                </div>
            </div>
        </form>
        <div class="row">
            <div class="form-group table-responsive">
                <table id="tbl_itemStockDetails" class="table table-hover table-bordered table-striped mt-0">
                    <thead>
                        <tr>
                            <th>Warehouse</th>
                            <th>Minimum Balance Quantity</th>
                            <th>Re-Order Quantity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
    <!-- Scope Tab ends here -->

    <!-- Attachments Tab starts here -->
    <div class="tab-pane" id="tab-attach" role="tabpanel">
    </div>
    <!-- Attachments Tab ends here -->

    <!-- External Details Tab starts here -->
    <div class="tab-pane" id="tab-external" role="tabpanel">
    </div>

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
        var itemsStocklist_table;

        //this is used for hide buttons & disable controls on details view mode;
        var detailsId = $("#detailsId").val();
        readOnlyControls(detailsId);
        //End function for hide buttons & disable controls on details view mode;


        var itemId = $("#hdf-item-id").val();

        //Insert Stock Details goes here. 
        $('#frm-stock-details').submit(function (e) {
            e.preventDefault();
            if (setBorderColor_Validation("ddl_warehouse_id,txt_Minimum_Balance_Qty") == "0") {
                calltoast("Please fill the mandatory infromaton.", "error");
            }
            else {
                // btnsave = $("#hdfmode").val();
               
                if (validateForm()) {
                    e.stopImmediatePropagation();
                    var strqry = "";

                    var item_stock_id = $("#hdf-itemstock-id").val();
                    if (item_stock_id == 0) {
                        strqry = $("#frm-stock-details").serialize();
                        strqry = strqry + "&fun=Insert_Item_Stock_Details";
                    }
                    else {
                        strqry = $("#frm-stock-details").serialize();
                        strqry = strqry + "&fun=Update_ItemStockDetails";
                    }

                    To_Display('none', 'btn-scope-update');
                    To_Display('block', 'btn-scope-save');

                    $.easyAjax({
                        url: "H_tbl_Item.ashx",
                        data: strqry,
                        type: "POST",
                        success: function (response) {
                            if (response.status == "success") {
                                $.easyBlockUI("body");
                                reloadtable();
                                $.unblockUI();
                                ResetFields();
                                $("#hdf-itemstock-id").val("");
                                $('#rwscope-add').slideUp();
                                $("#rwscope-add").addClass("hide");
                                $("#rwscopeplus").removeClass("hide");
                            }
                        }
                    });
                }
            }
        });



        //Bind Stock Item Datatable here
        itemsStocklist_table = $('#tbl_itemStockDetails').DataTable({
            dom: 'Bfrtip',
            destroy: true,
            "pageLength": 5,
            "processing": true,
            "serverSide": true,
            "aaSorting": [[1, "desc"]],
            'lengthChange': true,
            'searching': false,
            'ordering': true,
            'info': true,
            'autoWidth': false,
            "ajax": {
                "url": "H_tbl_Item.ashx",
                "type": "POST",
                "data": {
                    "fun": "View_ItemStockDetails",
                    "item_id": itemId
                }
            },
            "fnDrawCallback": function (oSettings) {
                $("body").tooltip({
                    selector: '[data-toggle="tooltip"]'
                });
            },
            "columns":
            [
                { "data": "Warehouse_Name" },
                { "data": "Min_Balance_Quantity" },
                { "data": "ReOrder_Quantity" },
                {

                    "data": null,
                    "render": function (data, type, row) {


                        var straction = '<div class="btn-group">';
                        straction += '          <button data-toggle="dropdown" class="btn btn-outline btn-default dropdown-toggle" aria-expanded="true">';
                        straction += '                           <span><i class="ti-settings"></i></span>';
                        straction += '                        </button>';
                        if (detailsId == 'no') {
                            straction += '                       <ul class="dropdown-menu dropdown-menu-right">';
                            straction += '                              <li><a href="#" data-id="' + data.Item_Min_Stock_Id + '" class="dropdown-item lnkitemstockedit"><i class="fa fa-pencil"></i>Edit</a></li>';
                            straction += '                             <li class="dropdown-divider"></li>';
                            straction += '                              <li><a href="#" data-id="' + data.Item_Min_Stock_Id + '" class="dropdown-item lnkitemdel"><i class="fa fa-trash"></i>Delete</a></li>';

                            straction += '                   </ul>';
                        }
                        straction += '                  </div>';

                        return straction;

                    }
                }
            ],
            buttons: []
        });



        //Edit Stock Details
        $(document).on("click", ".lnkitemstockedit", function (e) {
            var itemstockId = $(this).attr("data-id");
            var strqry = "item_Stock_id=" + itemstockId + "&fun=Edit_ItemStockDetails";
            $('#rwscope-add').slideDown();
            $("#rwscope-add").removeClass("hide");
            $("#rwscope-add").addClass("mt-20");
            $("#rwscopeplus").addClass("hide");

            $('#btn-scope-update').attr("disabled");
            To_Display('none', "btn-scope-save");
            To_Display('block', "btn-scope-update");

            $.easyAjax({
                url: "H_tbl_Item.ashx",
                data: strqry,
                type: "POST",
                success: function (response) {
                    
                    $.easyBlockUI("body");
                    var itemstocklist = response.itemstockvalue.split("|");
                    $('#hdf-itemstock-id').val(itemstocklist[0]);
                   
                    populate_ddl_warehouse(base_url, itemstocklist[1], itemstocklist[2]);
                    $('#txt_Minimum_Balance_Qty').val(itemstocklist[3]);
                    $('#txt_Re-Order_Quantity').val(itemstocklist[4]);
                    $.unblockUI();
                }
            });

        });


        //Deactivate Stock Details
        $(document).on("click", ".lnkitemdel", function (e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            var item_stockid = $(this).attr("data-id");
            var strqry = "";

            strqry = "item_stock_id=" + item_stockid + "&fun=Deactivate_ItemStock";
            swal({
                title: "Are you sure?",
                text: "You will not be able to recover this item stock",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "btn-danger",
                confirmButtonText: "Yes, delete it!",
                closeOnConfirm: true
            }, function (isConfirm) {
                // swal("Deleted!", "Your imaginary file has been deleted.", "success");
                if (isConfirm) {
                    $.easyAjax({
                        url: "H_tbl_Item.ashx",
                        data: strqry,
                        type: "POST",
                        success: function (response) {
                            if (response.status == "success") {
                               
                                swal("Deleted!", "Your Item stock has been deleted.", "success");
                                $.unblockUI();
                                reloadtable();
                            }

                        }
                    });
                }
            });

        });


        //Tabs functions
        $("#lnk-general").bind("click", function (e) {
            var itemid = $("#hdf-item-id").val();
            tabgeneral(base_url, itemid);
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


        //Stock functions goes here. 
        $("#btn-scope-add").on('click', function () {
            $('#rwscope-add').slideDown();
            $("#rwscope-add").removeClass("hide");
            $("#rwscope-add").addClass("mt-20");
            $("#rwscopeplus").addClass("hide");

            $.easyAjax({
                url: "H_tbl_Item.ashx",
                type: "POST",
                redirect: true,
                data: { 'fun': 'ddl_Warehouse', 'item_id': itemId },
                success: function (data) {
                    if (data.status == "success") {
                        
                        $("#ddl_warehouse_id").html("");
                        $("#ddl_warehouse_id").append(data.html);
                        $('.select2').select2();
                    }
                    To_Display('none', 'btn-scope-update');
                    To_Display('block', 'btn-scope-save');
                    ResetFields();
                }
            });

        });

        $("#btn-scope-close").on('click', function () {
            $('#rwscope-add').slideUp();
            $("#rwscope-add").addClass("hide");
            $("#rwscopeplus").removeClass("hide");
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
    //    if ($('#ddl_warehouse_id').val() == "0" || $('#txt_Minimum_Balance_Qty').val() == "") {
    //        calltoast("Please fill the mandatory information.", "error");
    //    }
    //}


    function readOnlyControls(detailsId) {
        if (detailsId == "yes") {
            toHide("btn-scope-add");
        }
        else {

        }
    }

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

    function ResetFields() {
        $('#frm-stock-details')[0].reset();

    }

    function reloadtable() {
        $('#tbl_itemStockDetails').DataTable().ajax.reload();
    }

    function populate_ddl_warehouse(base_url, itemstock_id, wharehouse_id) {
        // $("#ddl_warehouse_id").html("");
        $.easyAjax({
            url: "H_tbl_Item.ashx",
            type: "POST",
            redirect: true,
            data: { 'fun': 'ddl_Warehouse', 'item_id': itemstock_id, 'wharehouse_id': wharehouse_id },
            success: function (data) {
                if (data.status == "success") {
                    $("#ddl_warehouse_id").html("");
                    //$("#ddl_warehouse_id").append(data.html.replace("selected", ""));
                    $("#ddl_warehouse_id").append(data.html);
                }
            }
        });
    }

    function To_Display(Style_Display, NameObjsInArrayByComma) {
        var spltObjs = "";
        if (NameObjsInArrayByComma.indexOf(",") == -1) {
            spltObjs = NameObjsInArrayByComma
            document.getElementById(spltObjs).style.display = Style_Display;
        }
        else {
            spltObjs = NameObjsInArrayByComma.split(",");

            for (var i = 0; i < spltObjs.length; i++) {
                document.getElementById(obj2).style.display = Style_Display;
            }
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


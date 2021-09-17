<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add-external.aspx.cs" Inherits="Modules_Item_add_external" %>

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
        <a class="nav-link" id="lnk-stock" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-stock" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">Stock Details</span></a> </li>
    <li class="nav-item">
        <a class="nav-link" id="lnk-attach" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-attach" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">Attachments</span></a> </li>
    <li class="nav-item">
        <a class="nav-link active" id="lnk-external" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-external" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">External Details</span></a> </li>
    <li class="nav-item">
        <a class="nav-link" id="lnk-price" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-price" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">Prices</span></a> </li>
</ul>

<div class="tab-content">

    <!-- General Tab starts here -->
    <div class="tab-pane " id="tab-general" role="tabpanel">
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

        <div class="tab-pane" id="tab-price" role="tabpanel">
    </div>

    <!-- External Details Tab starts here -->
    <div class="tab-pane active pt-10" id="tab-external" role="tabpanel">
        <div class="row" id="rwaddplus">
            <div class="col-md-12">
                <div class="">
                    <div class="box-controls pull-right">
                        <div class="box-header-actions">
                            <button class="btn btn-success" data-toggle="tooltip" data-original-title="Add External Details" id="btn-address-add"><i class="mdi mdi-plus plusicon"></i>Add External</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

            <form class="form-horizontal ajax-form" id="frm-external-details">
                <input type="hidden" name="hdf-item-id" id="hdf-item-id" value="<%Response.Write(Request.QueryString["itemid"].ToString()); %>">
                <input type="hidden" name="hdf-itemexternal-id" id="hdf-itemexternal-id" value="">
                
        <div class="row hide" id="rwaddress-add">
                <div class="col-md-12">
                    <div class="">
                       <%--  <h5 class="modal-title">Add External Details</h5>
                        <div class="box-tools pull-right">
                            <ul class="box-controls">
                                <li>
                                                <button type="button" id="btn-address-close" class="close" style="font-size: 17px; color: #455A64;" aria-hidden="true">×</button>
                                            </li>
                            </ul>
                        </div>--%>
                    
                    <div class="">
                        <div class="row">
                            <div class="col-md-12 col-12">
                                <div class="form-group">
                                    <label>Party Type <span class="text-danger">*</span></label>
                                    <div class="demo-radio-button">
                                        <input name="partyType" type="radio" id="partyType_Customer" value="Customer" class="rbext">
                                        <label for="partyType_Customer">Customer</label>
                                        <input name="partyType" type="radio" id="partyType_Supplier" value="Supplier" class="rbext">
                                        <label for="partyType_Supplier">Supplier</label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-12">
                                <div class="form-group">
                                    <label>Party Name <span class="text-danger">*</span></label>
                                    <select class="form-control enq-txtbx-pd select2" data-required="true" name="ddl_Party_Name_Id" id="ddl_Party_Name_Id" aria-invalid="true" onblur="return ValidateOne(this);">
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-6 col-12">
                                <div class="form-group">
                                    <label>Product Code <span class="text-danger">*</span></label>
                                    <input type="text" name="txtProduct_Code" id="txtProduct_Code" class="form-control  enq-txtbx-pd" maxlength="50" onblur="return ValidateOne(this);">
                                </div>
                            </div>

                            <div class="col-md-12 col-12">
                                <div class="form-group">
                                    <label class="fnt16">Product Description </label>
                                    <div class="controls">
                                        <textarea name="txtProduct_Description" id="txtProduct_Description" class="form-control" aria-invalid="false" maxlength="200" rows="2"></textarea>
                                        <div class="help-block"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="">
                            <button type="button" class="btn btn-dark" id="btn-address-close"><i class="fa fa-trash"></i>Cancel</button>
                            <button type="button" class="btn btn-success right" id="btn-external-save" disabled onclick="newExternal_Details()">
                                <i class="ti-save-alt"></i>&nbsp;Save
                            </button>
                            <button type="button" class="btn btn-success right mr-5" id="btn-external-update" disabled onclick="newExternal_Details()">
                                <i class="ti-save-alt"></i>&nbsp;Update
                            </button>
                        </div>
                    </div>
                        </div>
                </div>
            </div>
            </form>
       
        <div class="row form-group mt-0">
            <table id="tbl_exteral" class="table table-hover table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Party Type</th>
                        <th>Party Name</th>
                        <th>Product Code</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>





<!-- Form validator JavaScript -->
<script src="../../assets/js/pages/validation.js"></script>
<script src="../../assets/js/pages/form-validation.js"></script>


<script>
    $(document).ready(function () {
        var base_url = $("#baseurl").val(); //alert(base_url);
        var itemId = $("#hdf-item-id").val();
        var itemsExternallist_table;

        //this is used for hide buttons & disable controls on details view mode;
        var detailsId = $("#detailsId").val();
        readOnlyControls(detailsId);
        //End function for hide buttons & disable controls on details view mode;


        // Bind ddl Party By Party Type Id on radio button click

        $(document).on("click", ".rbext", function (e) {
            var partyType_id = $("input[name='partyType']:checked").val();
            $("#ddl_Party_Name_Id").html("");
            // alert(partyType_id)
            $.easyAjax({
                url: "H_tbl_Item.ashx",
                type: "POST",
                redirect: true,
                data: { 'fun': 'ddl_Party_id', 'partyType_id': partyType_id, 'item_id': itemId, 'party_id': 0 },
                success: function (data) {
                    if (data.status == "success") {
                        $("#ddl_Party_Name_Id").html("");
                        $("#ddl_Party_Name_Id").append(data.html);
                        $('.select2').select2();
                    }
                }
            });


        });



        //Insert Stock Details goes here. 
        $('#frm-external-details').submit(function (e) {
            if (setBorderColor_Validation("ddl_Party_Name_Id,txtProduct_Code") == "0") {
                calltoast("Please fill the mandatory infromaton.", "error");
            }
            else {
                e.preventDefault();
                if (validateForm()) {
                    e.stopImmediatePropagation();
                    var strqry = "";

                    var itemexternal_id = $("#hdf-itemexternal-id").val();
                    if (itemexternal_id == 0) {

                        strqry = $("#frm-external-details").serialize();
                        strqry = strqry + "&fun=Insert_Item_External_Details";
                    }
                    else {
                        strqry = $("#frm-external-details").serialize();
                        strqry = strqry + "&fun=Update_External_Details";
                    }



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

                                $("#hdf-itemexternal-id").val("");
                                $('#partyType_Customer').attr("checked", false);
                                $('#partyType_Supplier').attr("checked", false);
                                $('#rwaddress-add').slideUp();
                                $("#rwaddplus").removeClass("hide");

                                toHide('btn-external-update');
                                toShow('btn-external-save');

                            }

                        }
                    });
                }
            }

        });


        //Bind Stock Item Datatable here
        itemsExternallist_table = $('#tbl_exteral').DataTable({
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
                    "fun": "fill_ItemExternalDatatable",
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
                { "data": "Party_Type" },
                {
                    "data": null,
                    "render": function (data, type, row) {
                        
                        var strtype = ""
                        if (data.Party_Type == "Supplier") {
                            strtype = data.Supplier_Name;
                        }
                        else {
                            strtype = data.Cus_Company_Name;
                        }
                        
                        return strtype;
                    }

                },
                { "data": "Product_Code" },
                {
                    "data": null,
                    "render": function (data, type, row) {

                        var straction = '<div class="btn-group">';
                        straction += '          <button data-toggle="dropdown" class="btn btn-outline btn-default dropdown-toggle" aria-expanded="true">';
                        straction += '                           <span><i class="ti-settings"></i></span>';
                        straction += '                        </button>';
                        if (detailsId == 'no') {
                            straction += '                       <ul class="dropdown-menu dropdown-menu-right">';
                            straction += '                              <li><a href="#" data-id="' + data.External_Detail_Id + '" class="dropdown-item lnkexternaledit"><i class="fa fa-pencil"></i>Edit</a></li>';
                            straction += '                             <li class="dropdown-divider"></li>';
                            straction += '                              <li><a href="#" data-id="' + data.External_Detail_Id + '" class="dropdown-item lnkitemexternaldelete"><i class="fa fa-trash"></i>Delete</a></li>';
                            straction += '                   </ul>';
                        }
                        straction += '                  </div>';

                        return straction;
                    }
                }
            ],
            buttons: []
        });


        //Edit External Details
        $(document).on("click", ".lnkexternaledit", function (e) {
            var item_externalid = $(this).attr("data-id");
            var strqry = "item_external_id=" + item_externalid + "&fun=Edit_Item_External_Details";
            $('#rwaddress-add').slideDown();
            $("#rwaddress-add").removeClass("hide");
            $("#rwaddress-add").addClass("mt-20");
            $("#rwaddplus").addClass("hide");

            toShow("btn-external-update");
            toHide("btn-external-save");

            $.easyAjax({
                url: "H_tbl_Item.ashx",
                data: strqry,
                type: "POST",
                success: function (response) {
                    $.easyBlockUI("body");
                    var itemexternallist = response.itemexternalvalue.split("|");
                    $('#hdf-itemexternal-id').val(itemexternallist[0]);
                    // $('partyType').val(itemexternallist[1]);
                    if (itemexternallist[1] == 'Customer') {
                        $('#partyType_Customer').attr("checked", true);
                        $('#partyType_Supplier').attr("checked", false);
                    }
                    else {
                        $('#partyType_Supplier').attr("checked", true);
                        $('#partyType_Customer').attr("checked", false);
                    }
                    populate_external_dropdown(base_url, itemexternallist[1], itemId, itemexternallist[2]);
                    $('#txtProduct_Code').val(itemexternallist[3]);
                    $('#txtProduct_Description').val(itemexternallist[4]);
                    $.unblockUI();
                }
            });

        });


        //delete External Details
        $(document).on("click", ".lnkitemexternaldelete", function (e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            var item_externalid = $(this).attr("data-id");
            var strqry = "";

            strqry = "item_external_id=" + item_externalid + "&fun=Deactivate_External_Detail";
            swal({
                title: "Are you sure?",
                text: "You will not be able to recover this external details",
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
                            if (response.status == "success") {
                                $.unblockUI();
                                reloadtable();
                                swal("Deleted!", "Your external details has been deleted.", "success");
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

        $("input,select,textarea").on("click", function (e) {
            $('#btn-external-save').removeAttr("disabled");
            $('#btn-external-update').removeAttr("disabled");
        });
        $("input,select,textarea").keypress(function (e) {
            $('#btn-external-save').removeAttr("disabled");
            $('#btn-external-update').removeAttr("disabled");
        });


        //External Details functions goes here.
        $("#btn-address-add").on('click', function () {
            $('#rwaddress-add').slideDown();
            $("#rwaddress-add").removeClass("hide");
            $("#rwaddress-add").addClass("mt-20");
            $("#rwaddplus").addClass("hide");
            toHide("btn-external-update");
            toShow("btn-external-save");
            $('#partyType_Customer').attr("checked", false);
            $('#partyType_Supplier').attr("checked", false);
            ResetFields();
        });

        $("#btn-address-close").on('click', function () {
            $('#rwaddress-add').slideUp();
            $("#rwaddress-add").addClass("hide");
            $("#rwaddplus").removeClass("hide");
        });

        $("#btn-address-save").on('click', function () {
            $('#rwaddress-add').slideUp();
            $("#rwaddplus").removeClass("hide");
        });

    });


    function fillitemsDetailsValidation() {
        if ($('input[name="partyType"]').is(":checked") == false || $('#ddl_Party_Name_Id').val() == "" || $('#txtProduct_Code').val() == "") {
            calltoast("Please fill the mandatory infromaton.", "error");
        }
    }

    //Insert Stock Details goes here. 
    function newExternal_Details() {
        if ($('input[name="partyType"]').is(":checked") == false) {
            calltoast("Please select party type.", "error");
            if (setBorderColor_Validation("ddl_Party_Name_Id,txtProduct_Code") == "0") {
            }
        }
        else if (setBorderColor_Validation("ddl_Party_Name_Id,txtProduct_Code") == "0") {
            calltoast("Please fill the mandatory infromaton.", "error");
        }
        else {
            var base_url = $("#baseurl").val();
            // e.preventDefault();
            if (validateForm()) {
                //  e.stopImmediatePropagation();
                var strqry = "";

                var itemexternal_id = $("#hdf-itemexternal-id").val();
                if (itemexternal_id == 0) {

                    strqry = $("#frm-external-details").serialize();
                    strqry = strqry + "&fun=Insert_Item_External_Details";
                }
                else {
                    strqry = $("#frm-external-details").serialize();
                    strqry = strqry + "&fun=Update_External_Details";
                }



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

                            $("#hdf-itemexternal-id").val("");
                            $('#partyType_Customer').attr("checked", false);
                            $('#partyType_Supplier').attr("checked", false);
                            $('#rwaddress-add').slideUp();
                            $("#rwaddplus").removeClass("hide");

                            toHide('btn-external-update');
                            toShow('btn-external-save');

                        }

                    }
                });
            }
        }
    }

    function readOnlyControls(detailsId) {
        if (detailsId == "yes") {
            toHide("btn-address-add");
        }
        else {

        }
    }


    function toShow(NameObjsInArrayByCommaOrOne) {
        var spltObjs;
        if (NameObjsInArrayByCommaOrOne.indexOf(",") == -1) {
            document.getElementById(NameObjsInArrayByCommaOrOne).style.display = 'block';
        }
        else {
            spltObjs = NameObjsInArrayByCommaOrOne.split(",");
            for (var i = 0; i < spltObjs.length; i++) {
                document.getElementById(spltObjs[i]).style.display = 'block';
            }
        }
    }

    function toHide(NameObjsInArrayByCommaOrOne) {
        var spltObjs;
        if (NameObjsInArrayByCommaOrOne.indexOf(",") == -1) {
            document.getElementById(NameObjsInArrayByCommaOrOne).style.display = 'none';
        }
        else {
            spltObjs = NameObjsInArrayByCommaOrOne.split(",");
            for (var i = 0; i < spltObjs.length; i++) {
                document.getElementById(spltObjs[i]).style.display = 'none';
            }
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


    function ResetFields() {
        $('#frm-external-details')[0].reset();
        $("#ddl_Party_Name_Id").html("");
    }

    function reloadtable() {
        $('#tbl_exteral').DataTable().ajax.reload();
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
    //////////////// Code for Cancel Button ////////////
    $("#btn-external-close").on('click', function () {
        $('#rwaddress-add').slideUp();
        $("rwaddress-add").addClass("hide");
        $("#rwaddplus").removeClass("hide");
    });

    function populate_external_dropdown(base_url, partyType, itemid, party_id) {

        $("#ddl_Party_Name_Id").html("");
        $.easyAjax({
            url: "H_tbl_Item.ashx",
            type: "POST",
            redirect: true,
            data: { 'fun': 'ddl_Party_id', 'partyType_id': partyType, 'item_id': itemid, 'party_id': party_id },
            success: function (data) {
                if (data.status == "success") {
                    $("#ddl_Party_Name_Id").html("");
                    $("#ddl_Party_Name_Id").append(data.html);
                }
            }
        });
    }


</script>



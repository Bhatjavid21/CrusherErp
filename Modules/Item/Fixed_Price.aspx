<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fixed_Price.aspx.cs" Inherits="fixed_Price" %>

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
        <a class="nav-link" id="lnk-external" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-external" role="tab">
            <span class="hidden-sm-up"><i class="ion-email"></i></span>
            <span class="hidden-xs-down">External Details</span></a> </li>
   
     <li class="nav-item">
        <a class="nav-link active" id="lnk-price" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-price" role="tab">
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

     <!-- Stock Details Tab starts here -->
    <div class="tab-pane" id="tab-external" role="tabpanel">
    </div>
    <!-- Scope Tab ends here -->
        
    
    

    <!-- price Details Tab starts here -->
    <div class="tab-pane active pt-10" id="tab-price" role="tabpanel">
        <div class="row" id="rwaddplus">
            <div class="col-md-12">
                <div class="">
                    <div class="box-controls pull-right">
                        <div class="box-header-actions">
                            <button class="btn btn-success" data-toggle="tooltip" data-original-title="Price Details" id="btn-address-add"><i class="mdi mdi-plus plusicon"></i>Add Fixed Price</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

            <form class="form-horizontal ajax-form" id="frm-price-details">
                <input type="hidden" name="hdf-item-id" id="hdf-item-id" value="<%Response.Write(Request.QueryString["itemid"].ToString()); %>">
                <input type="hidden" name="hdf-itemprice-id" id="hdf-itemprice-id" value="">
                
        <div class="row hide" id="rwaddress-add">
                <div class="col-md-12">
                    <div class="">
                       
                    
                    <div class="">
                        <div class="row">
                            <div class="col-md-12 col-12">
                                <div class="form-group">
                                    <label>Party Type <span class="text-danger">*</span></label>
                                    <div class="demo-radio-button">
                                        <input name="partyType" type="radio" id="partyType_Customer" value="Customer" class="rbext">
                                        <label for="partyType_Customer">Sales</label>
                                        <input name="partyType" type="radio" id="partyType_Supplier" value="Supplier" class="rbext">
                                        <label for="partyType_Supplier">Purchases</label>
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
                                    <label>Amount<span class="text-danger">*</span></label>
                                    <input type="text" name="txt_Amount" id="txt_Amount" onkeyup="validat()"  class="form-control mb-10 enq-txtbx-pd decimalValidation" maxlength="12" data-v-min="0" onblur="return ValidateOne(this);">
                                </div>
                            </div>

                            <%--<div class="col-md-12 col-12">
                                <div class="form-group">
                                    <label class="fnt16">Product Description </label>
                                    <div class="controls">
                                        <textarea name="txtProduct_Description" id="txtProduct_Description" class="form-control" aria-invalid="false" maxlength="200" rows="2"></textarea>
                                        <div class="help-block"></div>
                                    </div>
                                </div>
                            </div>--%>
                        </div>

                        <div class="">
                            <button type="button" class="btn btn-dark" id="btn-address-close"><i class="fa fa-trash"></i>Cancel</button>
                            <button type="button" class="btn btn-success right" id="btn-price-save" disabled onclick="Insert_Update_Price()">
                                <i class="ti-save-alt"></i>&nbsp;Save
                            </button>
                            <button type="button" class="btn btn-success right mr-5" id="btn-price-update" disabled onclick="Insert_Update_Price()">
                                <i class="ti-save-alt"></i>&nbsp;Update
                            </button>
                        </div>
                    </div>
                        </div>
                </div>
            </div>
            </form>
       
        <div class="row form-group mt-0">
            <table id="tbl_price" class="table table-hover table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Party Type</th>
                        <th>Party Name</th>
                        <th>Amount</th>
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
    function validat()
    {
        if ($("#txt_Amount").val() != "" || $("#txt_Amount").val() != null) {
            $("#btn-price-save").removeAttr("disabled");
            $("#btn-price-update").removeAttr("disabled");
        }
        else {
            $("#btn-price-save").attr("disabled", "disabled");
            $("#btn-price-update").attr("disabled", "disabled");
        }
    }

    $(document).ready(function () {
        var base_url = $("#baseurl").val(); 
        var itemId = $("#hdf-item-id").val();
        var Bind_Fixed_Price_Datatable;
        //Bind_Fixed_Price_Datatable();
        //this is used for hide buttons & disable controls on details view mode;
        var detailsId = $("#detailsId").val();
        readOnlyControls(detailsId);
        //End function for hide buttons & disable controls on details view mode;


        // Bind ddl Party By Party Type Id on radio button click

        $(document).on("click", ".rbext", function (e) {
            var partyType_id = $("input[name='partyType']:checked").val();
            $("#ddl_Party_Name_Id").html("");
             
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



        


        //Bind_Fixed_Price_Datatable
        
            Bind_Fixed_Price_Datatable = $('#tbl_price').DataTable({
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
                        "fun": "Bind_Fixed_Price_Datatable",
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
                    { "data": "Amount" },
                    {
                        "data": null,
                        "render": function (data, type, row) {

                            var straction = '<div class="btn-group">';
                            straction += '          <button data-toggle="dropdown" class="btn btn-outline btn-default dropdown-toggle" aria-expanded="true">';
                            straction += '                           <span><i class="ti-settings"></i></span>';
                            straction += '                        </button>';
                            if (detailsId == 'no') {
                                straction += '                       <ul class="dropdown-menu dropdown-menu-right">';
                                straction += '                              <li><a href="#" data-id="' + data.Fixed_Price_Id + '" class="dropdown-item lnk_Price_Edit"><i class="fa fa-pencil"></i>Edit</a></li>';
                                straction += '                             <li class="dropdown-divider"></li>';
                                straction += '                              <li><a href="#" data-id="' + data.Fixed_Price_Id + '" class="dropdown-item lnk_Price_delete"><i class="fa fa-trash"></i>Delete</a></li>';
                                straction += '                   </ul>';
                            }
                            straction += '                  </div>';

                            return straction;
                        }
                    }
                ],
                buttons: []
            });
        

        //Edit price Details
        $(document).on("click", ".lnk_Price_Edit", function (e) {
            
            var Fixed_Price_Id = $(this).attr("data-id");
            var strqry = "lnk_Price_delete=" + Fixed_Price_Id + "&fun=Edit_Fixed_Price";
            $('#rwaddress-add').slideDown();
            $("#rwaddress-add").removeClass("hide");
            $("#rwaddress-add").addClass("mt-20");
            $("#rwaddplus").addClass("hide");

            toShow("btn-price-update");
            toHide("btn-price-save");

            $.easyAjax({
                url: "H_tbl_Item.ashx",
                data: strqry,
                type: "POST",
                success: function (response) {
                    $.easyBlockUI("body");
                    var output = response.Fixed_Price_Res.split("|");
                    $('#hdf-itemprice-id').val(output[0]);
                    // $('partyType').val(output[1]);
                    
                    if (output[1] == 'Customer') {
                        $('#partyType_Customer').attr("checked", true);
                        $('#partyType_Supplier').attr("checked", false);
                    }
                    else {
                        $('#partyType_Supplier').attr("checked", true);
                        $('#partyType_Customer').attr("checked", false);
                    }
                    populate_price_dropdown(base_url, output[1], itemId, output[2]);
                    $('#txt_Amount').val(output[3]);
                    //$('#txtProduct_Description').val(output[4]);
                    $.unblockUI();
                }
            });

        });


        //Deactivate price Details
        $(document).on("click", ".lnk_Price_delete", function (e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            var Fixed_Price_Id = $(this).attr("data-id");
            var strqry = "";

            strqry = "Fixed_Price_Id=" + Fixed_Price_Id + "&fun=Delete_Fixed_Price";
            swal({
                title: "Are you sure?",
                text: "You will not be able to recover this price details",
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
                                swal("Deleted!", "Your price details has been deleted.", "success");
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

       

        //price Details functions goes here.
        $("#btn-address-add").on('click', function () {
            $('#rwaddress-add').slideDown();
            $("#rwaddress-add").removeClass("hide");
            $("#rwaddress-add").addClass("mt-20");
            $("#rwaddplus").addClass("hide");
            toHide("btn-price-update");
            toShow("btn-price-save");
            $('#partyType_Customer').attr("checked", false);
            $('#partyType_Supplier').attr("checked", false);
            ResetFields();
        });

        $("#btn-address-close").on('click', function () {
            $('#rwaddress-add').slideUp();
            $("#rwaddress-add").addClass("hide");
            $("#rwaddplus").removeClass("hide");
        });

        

    });


        function fillitemsDetailsValidation() {
            if ($('input[name="partyType"]').is(":checked") == false || $('#ddl_Party_Name_Id').val() == "" || $('#txt_Amount').val() == "") {
                calltoast("Please fill the mandatory infromaton.", "error");
            }
        }





        //New - Insert price Details goes here. 
        function Insert_Update_Price() {
            if ($('input[name="partyType"]').is(":checked") == false) {
                calltoast("Please select party type.", "error");
                if (setBorderColor_Validation("ddl_Party_Name_Id,txt_Amount") == "0") {
                }
            }
            else if (setBorderColor_Validation("ddl_Party_Name_Id,txt_Amount") == "0") {
                calltoast("Please fill the mandatory infromaton.", "error");
            }
            else {
                var base_url = $("#baseurl").val();
                // e.preventDefault();
                if (validateForm()) {
                    //  e.stopImmediatePropagation();
                    var strqry = "";

                    var itemexternal_id = $("#hdf-itemprice-id").val();
                    if (itemexternal_id == 0) {

                        strqry = $("#frm-price-details").serialize();
                        strqry = strqry + "&fun=Insert_Fixed_Price";
                    }
                    else {
                        strqry = $("#frm-price-details").serialize();
                        strqry = strqry + "&fun=Update_Fixed_Price";
                    }

                    $.easyAjax({
                        url: "H_tbl_Item.ashx",
                        data: strqry,
                        type: "POST",
                        success: function (response) {
                            if (response.status == "success") {
                                if (response.er == "This record already exists.") {
                                    calltoast(response.er, "error");
                                }
                                else {
                                    //Bind_Fixed_Price_Datatable();
                                    //$.easyBlockUI("body");
                                    $.unblockUI();
                                    reloadtable();

                                    ResetFields();

                                    // $("#btn-price-save").on('click', function () {
                                    $('#rwaddress-add').slideUp();
                                    $("#rwaddplus").removeClass("hide");
                                    //});



                                    //$('#partyType_Customer').attr("checked", false);
                                    //$('#partyType_Supplier').attr("checked", false);
                                    $('#rwaddress-add').slideUp();
                                    $("#rwaddplus").removeClass("hide");

                                    toHide('btn-price-update');
                                    toShow('btn-price-save');
                                }
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

        function tabprice(base_url, itemid) {
            $(".modal-backdrop").remove();
            var url = "fixed_price.aspx?itemid=" + itemid;
            $.easyBlockUI("body");
            $.ajaxModal('.modal', url);
            $.unblockUI();
        }

        function ResetFields() {
            $('#frm-price-details')[0].reset();
            $("#ddl_Party_Name_Id").html("");
        }

        function reloadtable() {
            $('#tbl_price').DataTable().ajax.reload();
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
        $("#btn-price-close").on('click', function () {
            $('#rwaddress-add').slideUp();
            $("rwaddress-add").addClass("hide");
            $("#rwaddplus").removeClass("hide");
        });



        function populate_price_dropdown(base_url, partyType, itemid, party_id) {
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

        //allow only 2 digits after decimal
        $(document).on("input", ".decimalValidation", function () {
            var regExp = new RegExp('(\\.[\\d]{2}).', 'g')
            this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1').replace(regExp, '$1');
        });

</script>



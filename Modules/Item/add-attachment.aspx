<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add-attachment.aspx.cs" Inherits="Modules_Item_add_attachment" %>

<link rel="stylesheet" href="../../assets/vendor_components/fileuploader/jquery.fileuploader.css" />

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
        <a class="nav-link active" id="lnk-attach" data-id="<%Response.Write(Request.QueryString["itemid"].ToString()); %>" data-toggle="tab" href="#tab-attach" role="tab">
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
    <div class="tab-pane active pt-10" id="tab-attach" role="tabpanel">
        <div class="row" id="rwdocplus">
            <div class="col-md-12 ">
                <div class="">
                    <div class="box-controls pull-right">
                        <div class="box-header-actions"><button class="btn btn-success" data-toggle="tooltip" data-original-title="Add Attachments" id="btn-doc-add"> <i class="mdi mdi-plus plusicon" ></i>Add Attachment</button>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row hide" id="rwdoc-add">
            <div class="col-md-12">
            
                        <form class="form-horizontal ajax-form" id="frm-attachment-details">
                            <input type="hidden" name="hdf-item-id" id="hdf-item-id" value="<%Response.Write(Request.QueryString["itemid"].ToString()); %>">
                            <input name="hdf-attachment-id" id="hdf-attachment-id" type="hidden" />
                            <div class="">
                                <div class="">
                                    <div class="row">

                                        <div class="col-md-6 col-12">
                                            <div class="form-group">
                                                <label>Attachment Type <span class="text-danger">*</span></label>
                                                <select class="form-control enq-txtbx-pd mb-10 select2" style="width:100%"  name="attachType" id="attachType"  aria-invalid="true">
                                                    <option value="" >Select</option>
                                                    <option>Image</option>
                                                    <option>MSDS</option>
                                                    <option>Specification</option>
                                                    <option>Manual</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-6 col-12">
                                            <div class="form-group">
                                                <label>Attachment Name <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control enq-txtbx-pd" name="txt_attachment_Name" id="txt_attachment_Name"  maxlength="100">
                                            </div>
                                        </div>


                                        <div class="col-md-6 col-12">
                                            <div class="form-group">
                                                <label>Upload <span class="text-danger">*</span></label>
                                                <div class="controls">
                                                   
                                                    <input type="file" name="itemAttachment" id="itemAttachment" onchange="upload_File('Item/Attachments','0','itemAttachment','spn_loading')" class="form-control">
                                                    <input type='hidden' value="" id='hid_fileName' name="hid_fileName" />
                                                        <span id="spn_loading" style="color:blue;display:none;">Uploading...</span>
                                                        
                                                </div>
                                               
                                            </div>
                                        </div>


                                    </div>
                                <div class="">
                                        
                                            <button  id="btn-doc-close" class="btn btn-dark">&nbsp;Cancel</button>
                                                    <button type="submit" class="btn btn-success right" id="btn-doc-save"  onclick="fillitemsDetailsValidation()">
                                                        <i class="ti-save-alt"></i>&nbsp;Save
                                                    </button>

                                                    <button type="submit" class="btn btn-success right-half mr-5" id="btn-doc-update" disabled  onclick="fillitemsDetailsValidation()">
                                                        <i class="ti-save-alt"></i>&nbsp;Update
                                                    </button>
</div>
                                            </div>
                                    
                            </div>
                        </form>
                    </div>
              
        </div>
        <div class="row">

            <%--<div class="col-sm-12 hide" id="rwdoc-add1">
                <div class="col-md-12">
                </div>
            </div>--%>

                <div class=" form-group table-responsive">
                    <table id="tbl_itemAttachmentDetails" class="table table-hover table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Attachment Type</th>
                                <th>Attachment Name</th>
                                <th>File</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
           
        </div>
    </div>
    <!-- Attachments Tab ends here -->

    <!-- External Details Tab starts here -->
    <div class="tab-pane" id="tab-external" role="tabpanel">
    </div>

    <div class="tab-pane" id="tab-price" role="tabpanel">
    </div>

</div>

<!-- Form validator JavaScript -->
<script src="../../assets/js/pages/validation.js"></script>
<script src="../../assets/js/pages/form-validation.js"></script>
<script src="../../assets/vendor_components/fileuploader/jquery.fileuploader.js"></script>

<%--<script src="<%=G.S%>General/jquery.min.js"></script>--%>
 <script src="<%=G.S%>General/libo.js"></script>

<script>
    $(document).ready(function () {
        // $('[data-mask]').inputmask();
        var base_url = $("#baseurl").val();
        var itemsAttachmentlist_table;
        var itemId = $("#hdf-item-id").val();

        //this is used for hide buttons & disable controls on details view mode;
        var detailsId = $("#detailsId").val();
        readOnlyControls(detailsId);
        //End function for hide buttons & disable controls on details view mode;


        To_Display('none', 'btn-doc-update');
        To_Display('block', 'btn-doc-save');

        $('.select2').select2();

        //var input = $('input[name="itemAttachment"]').fileuploader({
        //    limit: 1,
        //    maxSize: 500,
        //    extensions: ['jpg', 'jpeg', 'png', 'gif', 'doc', 'pdf', 'txt', 'docx', 'xls', 'xlsx', 'csv'],
        //    enableApi: true,
        //    upload: {
        //        url: "H_tbl_Item.ashx",
        //        type: 'POST',
        //        dataType: 'JSON',
        //        enctype: 'multipart/form-data',
        //        data: { fun: 'Item_Attachment_Upload' },
        //        start: true,
        //        synchron: true,
        //        beforeSend: function (item, listEl, parentEl, newInputEl, inputEl) {

        //        },
        //        onSuccess: function (data, item, listEl, parentEl, newInputEl, inputEl, textStatus, jqXHR) {
        //            item.html.find('.column-actions').append(
        //              '<a class="fileuploader-action fileuploader-action-remove fileuploader-action-success" title="Remove"><i></i></a>'
        //            );
        //            setTimeout(function () {
        //                item.html.find('.progress-bar2').fadeOut(400);
        //            }, 400);
        //        },
        //        onError: function (item, listEl, parentEl, newInputEl, inputEl, jqXHR, textStatus, errorThrown) {
        //            var progressBar = item.html.find('.progress-bar2');

        //            if (progressBar.length > 0) {
        //                progressBar.find('span').html(0 + "%");
        //                progressBar.find('.fileuploader-progressbar .bar').width(0 + "%");
        //                item.html.find('.progress-bar2').fadeOut(400);
        //            }

        //            item.upload.status != 'cancelled' && item.html.find('.fileuploader-action-retry').length == 0 ? item.html.find('.column-actions').prepend(
        //              '<a class="fileuploader-action fileuploader-action-retry" title="Retry"><i></i></a>'
        //            ) : null;
        //            $('#perview').addClass('col-md-10');
        //            $('#perview').removeAttr("src");
        //            $('input[name="logo"]').val("");
        //        },
        //        onProgress: function (data, item, listEl, parentEl, newInputEl, inputEl) {
        //            var progressBar = item.html.find('.progress-bar2');

        //            if (progressBar.length > 0) {
        //                progressBar.show();
        //                progressBar.find('span').html(data.percentage + "%");
        //                progressBar.find('.fileuploader-progressbar .bar').width(data.percentage + "%");
        //            }
        //        },
        //        onComplete: function (listEl, parentEl, newInputEl, inputEl, jqXHR, textStatus) {

        //            result = JSON.parse(jqXHR.responseText);
        //            if (result.status == "error") {
        //                toastr.error(result.message);
        //                calltoast(result.message, result.status);
        //            } else {
        //                $('input[name="hdfuploadAttachment"]').val(result.message);
        //            }
        //            //api.reset();
        //        },
        //    },
        //    captions: {
        //        button: function (options) { return 'Upload' + ' ' + (options.limit == 1 ? 'file' : 'files'); },
        //        feedback: function (options) { return 'Upload' + ' ' + (options.limit == 1 ? 'file' : 'files') + ' ' + 'to_upload'; },
        //        feedback2: function (options) { return options.length + ' ' + (options.length > 1 ? 'files_were' : 'file_was') + ' ' + 'chosen'; },
        //        confirm: 'confirm',
        //        cancel: 'cancel',
        //        name: 'filename',
        //        type: 'file_type',
        //        size: 'size',
        //        dimensions: 'dimensions',
        //        duration: 'duration',
        //        crop: 'crop',
        //        rotate: 'rotate',
        //        close: 'close',
        //        download: 'download',
        //        remove: 'remove',
        //        drop: 'drop_file',
        //        paste: '<div class="fileuploader-pending-loader"><div class="left-half" style="animation-duration: ${ms}s"></div><div class="spinner" style="animation-duration: ${ms}s"></div><div class="right-half" style="animation-duration: ${ms}s"></div></div> paste_file',
        //        removeConfirmation: "Are you sure you want to remove this file?",
        //        errors: {
        //            filesLimit: "Only one file is allowed to be uploaded at once. please remove existing image here.",
        //            filesType: "Only %s files are allowed to be uploaded.",
        //            fileSize: "is too large! Please choose a file up to %s MB.",
        //            filesSizeAll: "Files that you choosed are too large! Please upload files up to %s MB.",
        //            fileName: "File with the name %s is already selected.'",
        //            folderUpload: "You are not allowed to upload folders."
        //        }
        //    }
        //});
        //// get API methods
        //api = $.fileuploader.getInstance(input);


        //Insert Item Attachment Details and Update goes here. 
        $('#frm-attachment-details').submit(function (e) {
            e.preventDefault();
            if (setBorderColor_Validation("attachType,txt_attachment_Name,itemAttachment") == "0") {
                calltoast("Please fill the mandatory infromaton.", "error");
            }
            else {
             

                if (validateForm()) {
                    e.stopImmediatePropagation();
                    var strqry = "";

                    var attachment_id = $("#hdf-attachment-id").val();
                    if (attachment_id == 0) {

                        strqry = $("#frm-attachment-details").serialize();
                        strqry = strqry + "&fun=Insert_Item_Attachment";
                    }
                    else {
                        strqry = $("#frm-attachment-details").serialize();
                        strqry = strqry + "&fun=Update_ItemAttachmentDatatable";
                    }

                    To_Display('none', 'btn-doc-update');
                    To_Display('block', 'btn-doc-save');

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

                                $('#rwdoc-add').slideUp();
                                $("#rwdoc-add").addClass("hide");
                                $("#rwdocplus").removeClass("hide");

                            }
                        }
                    });
                }
            }
        });


        //Bind Item Attachment Datatable here
        itemsAttachmentlist_table = $('#tbl_itemAttachmentDetails').DataTable({
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
                    "fun": "view_ItemAttachmentDatatable",
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
                { "data": "Attachment_Type" },
                { "data": "Attachment_Name" },
               // { "data": "Attachment_File" },
                 {
                     "data": null,
                     "render": function (data, type, row) {

                         var straction = '', splt = data.Attachment_File.split('-');
                         straction += '<a href="Attachments/' + data.Attachment_File + '"  target="_blank" style="color:blue">Download Attachment</a>';
                         return straction;
                     }
                 },

                {
                    "data": null,
                    "render": function (data, type, row) {

                        var straction = '<div class="btn-group">';
                        straction += '          <button data-toggle="dropdown" class="btn btn-outline btn-default dropdown-toggle" aria-expanded="true">';
                        straction += '                           <span><i class="ti-settings"></i></span>';
                        straction += '                        </button>';
                        if (detailsId == 'no') {
                            straction += '                       <ul class="dropdown-menu dropdown-menu-right">';
                            straction += '                              <li><a href="#" data-id="' + data.Attachment_Id + '" class="dropdown-item lnkitemattachedit"><i class="fa fa-pencil"></i>Edit</a></li>';
                            straction += '                             <li class="dropdown-divider"></li>';
                            straction += '                              <li><a href="#" data-id="' + data.Attachment_Id + '" class="dropdown-item lnkitemdel"><i class="fa fa-trash"></i>Delete</a></li>';

                            straction += '                   </ul>';
                        }
                        straction += '                  </div>';

                        return straction;
                    }
                }
            ],
            buttons: []
        });

        //Edit Item Attachment Details
        $(document).on("click", ".lnkitemattachedit", function (e) {
            var itemattachmentId = $(this).attr("data-id");
            var strqry = "attachment_Id=" + itemattachmentId + "&fun=Edit_ItemAttachmentDatatable";
            $('#rwdoc-add').slideDown();
            $("#rwdoc-add").removeClass("hide");
            $("#rwdoc-add").addClass("mt-20");
            $("#rwdocplus").addClass("hide");

            $('#btn-doc-update').attr("disabled");
            To_Display('none', "btn-doc-save");
            To_Display('block', "btn-doc-update");

            $.easyAjax({
                url: "H_tbl_Item.ashx",
                data: strqry,
                type: "POST",
                success: function (response) {
                    $.easyBlockUI("body");
                    var itemstocklist = response.itemAttachmentvalue.split("|");
                    $('#hdf-attachment-id').val(itemstocklist[0]);
                    $('#attachType').val(itemstocklist[1]);
                    $('#txt_attachment_Name').val(itemstocklist[3]);
                    $('#hid_fileName').val(itemstocklist[4]);
                    View_Edit_File('spn_loading', 'Item/Attachments', itemstocklist[4]);
                    $.unblockUI();
                }
            });

        });



        //Deactivate Attachments Details
        $(document).on("click", ".lnkitemdel", function (e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            var item_attachid = $(this).attr("data-id");
            var strqry = "";

            strqry = "item_attachment_id=" + item_attachid + "&fun=Deactivate_ItemAttachment";
            swal({
                title: "Are you sure?",
                text: "You will not be able to recover this attachment",
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
                                swal("Deleted!", "Your attachment has been deleted.", "success");
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
            tabprice(base_url, itemid);
        });

        $("input,select,textarea").on("click", function (e) {
            $('#btn-doc-save').removeAttr("disabled");
            $('#btn-doc-update').removeAttr("disabled");
        });
        $("input,select,textarea").keypress(function (e) {
            $('#btn-doc-save').removeAttr("disabled");
            $('#btn-doc-update').removeAttr("disabled");
        });


        //attachments functions goes here. 
        $("#btn-doc-add").on('click', function () {
            $('#rwdoc-add').slideDown();
            $("#rwdoc-add").removeClass("hide");
            $("#rwdoc-add").addClass("mt-20");
            $("#rwdocplus").addClass("hide");

            To_Display('block', "btn-doc-save");
            To_Display('none', "btn-doc-update");

            ResetFields();
        });

        $("#btn-doc-close").on('click', function () {
            $('#rwdoc-add').slideUp();
            $("#rwdoc-add").addClass("hide");
            $("#rwdocplus").removeClass("hide");
        });


    });

    //function fillitemsDetailsValidation() {
    //    if ($('#attachType').val() == "0" || $('#txt_attachment_Name').val() == "" || $('#hid_fileName').val() == "") {//
    //        calltoast("Please fill the mandatory information.", "error");
    //    }
    //}


    function readOnlyControls(detailsId) {
        if (detailsId == "yes") {
            toHide("btn-doc-add");
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
        $('#frm-attachment-details')[0].reset();
        $('#hid_fileName').val("");
        //$('#itemAttachment').val("");
    }
    function reloadtable() {
        $('#tbl_itemAttachmentDetails').DataTable().ajax.reload();
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

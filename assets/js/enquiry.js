$(function () {
    "use strict";
    var base_url = $("#baseurl").val();
    $('.select2').select2();
    var trcount = 0;
    upload_doc(base_url, "ref_doc");
    var strdivisionid, branchid, companyid;
    strdivisionid = $("#hdf_division_id").val();
    branchid = $("#hdf_branch_id").val();
    companyid = $("#hdf_company_id").val();

    bindCustomer(base_url, branchid);
    bindLeadGenerator(base_url, strdivisionid, branchid);
    $(".modal").on("show.bs.modal", function (e) {
        $(".modal .modal-dialog").attr("class", "modal-dialog slideInRight animated");
        ($("body").hasClass("modal-open")) ? $('body .modal-backdrop').last().remove() : "";

    });
    $(".modal").on("hide.bs.modal", function (e) {
        $(".modal .modal-dialog").attr("class", "modal-dialog slideOutRight animated");
    });
    $("select[name='division']").change(function () {
        $("input[name='enquiryno']").val("");
        if ($(this).val() == "") {
            growltoast("Select Division first", "top", "right", "fa fa-bell-o", "error", "animated fadeIn", "animated fadeOut", "error");
        }
        else {
            bindCustomer(base_url, branchid);
            bindLeadGenerator(base_url, $(this).val(), branchid);
        }
    });
    $("select[name='customer']").change(function () {
        var custid = $(this).val();
        if (custid != "") {
            bindContactPerson(base_url, $(this).val());
            bindenquiryno(base_url, custid);
        }
        else {
            growltoast("Select Customer", "top", "right", "fa fa-bell-o", "error", "animated fadeIn", "animated fadeOut", "error");
            $("select[name='cperson']").html("");
            $("input[name='enquiryno']").val("");
        }
    });
    $(document).on("click", "#btnsave", function (a) {
        $(this).closest("form").find("#btnsave").attr("data-send", true)
        $(this).closest("form").find("#btncontinue").attr("data-send", false)
    });
    $(document).on("click", "#btncontinue", function (a) {
        if ($("select[name='customer']").val() == "") {
            growltoast("Select Customer", "top", "right", "fa fa-bell-o", "error", "animated fadeIn", "animated fadeOut", "error");
        }
        $(this).closest("form").find("#btnsave").attr("data-send", false);
        $(this).closest("form").find("#btncontinue").attr("data-send", true)
    });
    $(document).on("click", "#btn-cancel", function () {
        window.location.href = "enquiry.aspx";
    });

    $(document).on("focusout", ".item_desc", function (a) {
        ($(this).val() == "") ? $(this).parent().parent().parent().find("div").addClass("error") : $(this).parent().parent().parent().find("div").removeClass("error");
    });
    $(document).on("focusout", ".item_unit", function (a) {
        ($(this).val() == "") ? $(this).parent().parent().find("div").addClass("error") : $(this).parent().parent().find("div").removeClass("error");
    });
    $(document).on("focusout", ".item_qty", function (a) {
        ($(this).val() == "") ? $(this).parent().parent().parent().find("div").addClass("error") : $(this).parent().parent().parent().find("div").removeClass("error");
    });


    $(document).on("click", ".enq_delete", function () {
        var enquiryid = $(this).attr("data-id");
        swal({
            title: "Are you sure?",
            text: "You will not be able to recover this enquiry!",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "btn-danger",
            confirmButtonText: "Yes, delete it!",
            closeOnConfirm: false
        }, function (isConfirm) {
            if (isConfirm) {
                $.easyAjax({
                    url: "" + base_url + "Modules_Handler/sales/H_Enquiry.ashx",
                    data: {'fun':'del_enquiry', 'enquiryid': enquiryid},
                    type: "POST",
                    success: function (data) {
                        if (data.status == "success") {
                            $('#dtenquiry').DataTable().ajax.reload();
                            swal("Deleted!", "Your Enquiry has been deleted successfully", "success");
                            
                        }
                    }
                });
            }
        });
    });
    $(document).on("click", ".lnk-refresh", function () {
        $('#dtenquiry').DataTable().ajax.reload();
    });
    $(document).on("click", ".ajaxmodal", function (e) {
        var url = $(this).attr("data-src");
        var title = $(this).attr("data-title");
        $.ajaxModal('.modal', url);
        $(".modal .modal-title").text(title);
    });
    $('#frm-add-enquiry').submit(function (e) {
        e.preventDefault();
        var frmstatus = "";
        if ($("#btnsave").attr("data-send") == "true") {
            frmstatus = "save";
        }
        if ($("#btncontinue").attr("data-send") == "true") {
            frmstatus = "continue";
        }

        var strqry = "";
        var myval = "";
        $('#frm-add-enquiry input, #frm-add-enquiry select, #frm-add-enquiry textarea').each(
            function (index) {
                var input = $(this);
                //alert("value is " + input.hasClass("item_desc").val());
                if (input.attr('type') == "checkbox") {
                    if ($('#chk-' + input.attr('name')).is(':checked')) {
                        myval = "chk-" + input.attr('name') + "=yes";
                    }
                    else {
                        myval = "chk-" + input.attr('name') + "=no";
                    }
                    strqry = strqry + '&' + myval;
                }
                if (input.hasClass("item_desc")) {
                    var strdesc = $(this).val().replace(',', "|");
                    strdesc = strdesc.replace(' , ', "|");
                    strdesc = strdesc.replace(' ,', "|");
                    strdesc = strdesc.replace(', ', "|");
                    strdesc = strdesc.replace(',', "|");
                    myval = "chg_" + input.attr('name') + "=" + strdesc;
                    strqry = strqry + '&' + myval;
                }

                
                if (input.hasClass("item_desc")) {
                    ($(this).val() == "") ? $(this).parent().parent().parent().find("div").addClass("error") : "";
                }
                if (input.hasClass("item_unit")) {
                    ($(this).val() == "") ? $(this).parent().parent().find("div").addClass("error") : "";
                }
                if (input.hasClass("item_qty")) {
                    ($(this).val() == "") ? $(this).parent().parent().parent().find("div").addClass("error") : "";
                }
            }
        );
        strqry = $("#frm-add-enquiry").serialize() + strqry;
        strqry = strqry + "&fun=Insert&mode=insert";
        $.easyAjax({
            url: "" + base_url + "Modules_Handler/sales/H_Enquiry.ashx",
            data: strqry,
            type: "POST",
            success: function (data) {
                if (data.status == "success") {
                    ResetFields();
                    $('input[name="enquiry_item[li]"]').val("1");
                    if (frmstatus == "save") {
                        window.location.href = "enquiry.aspx";
                    }
                }
            }
        });
    });

    $('#dtenquiry').DataTable({
        dom: 'Bfrtip',
        destroy: true,
        "processing": true,
        "serverSide": true,
        "aaSorting": [[0, "desc"]],
        'paging': true,
        "pageLength": 50,
        'lengthChange': true,
        'searching': true,
        'ordering': true,
        'info': true,
        'autoWidth': false,
        "ajax": {
            "url": "" + base_url + "Modules_Handler/sales/H_Enquiry.ashx",
            "type": "POST",
            "data": {
                "fun": "populate_datatable"
            }
        },
        "aoColumnDefs": [{
            "bVisible": false,
            "aTargets": [0],
        }],
        "fnDrawCallback": function (oSettings) {
            $("body").tooltip({
                selector: '[data-toggle="tooltip"]'
            });
        },
        "columns":
        [
            { "data": "enquiry_id" },
            { "data": "enquiry_no" },
            { "data": "edivision" },
            { "data": "ecustomer" },
            { "data": "etype" },
            { "data": "edate" },
            { "data": "eclosing_date" },
            { "data": "eleadgenerator" },
            { "data": "eleadcloser" },
            {
                "data": null,
                "render": function (data, type, row) {
                    var strstatus = '';
                    switch (data.estatus) {
                        case "Estimated":
                            strstatus = '<span class="badge badge-success fnt11">Estimated</span>';
                            break;
                        case "New":
                            strstatus = '<span class="badge badge-info fnt11">New</span>';
                            break;
                        case "Quoted":
                            strstatus = '<span class="badge badge-warning fnt11">Quoted</span>';
                            break;
                        case "Converted":
                            strstatus = '<span class="badge badge-default fnt11">Converted</span>';
                            break;
                    }
                    return strstatus;

                }
            },
            {
                "data": null,
                "render": function (data, type, row) {
                    var strstage = '';
                    switch (data.estatus) {
                        case "Estimated":
                            strstage = '<span class="badge badge-success fnt11">Estimated</span>';
                            break;
                        case "New":
                            strstage = '<span class="badge badge-info fnt11">New</span>';
                            break;
                        case "Quoted":
                            strstage = '<span class="badge badge-warning fnt11">Quoted</span>';
                            break;
                        case "Converted":
                            strstage = '<span class="badge badge-default fnt11">Converted</span>';
                            break;
                    }
                    return strstage;
                }

            },
            {
                "data": null,
                "render": function (data, type, row) {
                    var straction = '<div class="btn-group">' +
                    '                       <button data-toggle="dropdown" class="btn btn-outline btn-default dropdown-toggle" aria-expanded="true">' +
                    '                          <span><i class="ti-settings"></i></span>' +
                    '                      </button>' +
                    '                      <ul class="dropdown-menu dropdown-menu-right">' +
                    '                          <li><a href="javascript:void(0);" class="dropdown-item ajaxmodal" data-src="Modules_Screen/enquiry/enquiry_analysis.aspx?enquiryid=' + data.enquiry_id + '" data-title="Enquiry Analysis ( ' + data.enquiry_no + ' )"><i class="fa fa-calendar-check-o"></i>Enquiry Analysis</a></li>' +
                    '                         <li class="dropdown-divider"></li>' +
                    '                         <li><a href="javascript:void(0);" class="dropdown-item ajaxmodal" data-src="Modules_Screen/enquiry/follow_up.aspx?enquiryid=' + data.enquiry_id + '&branchid=' + data.branch_Id + '&divisionid=' + data.division_Id + '" data-title="Follow Up ( ' + data.enquiry_no + ' )"><i class="fa fa-id-card-o"></i>Follow Ups</a></li>' +
                    '                          <li class="dropdown-divider"></li>' +
                    '                         <li><a href="#" class="dropdown-item"><i class="fa fa-eye"></i>View</a></li>' +
                    '                         <li class="dropdown-divider"></li>' +
                    '                         <li><a href="edit-enquiry.aspx?enquiryid=' + data.enquiry_id + '" class="dropdown-item"><i class="fa fa-pencil"></i>Edit</a></li>' +
                    '                         <li class="dropdown-divider"></li>' +
                    '                         <li><a href="javascript:void(0);" data-id=\"' + data.enquiry_id + '\" class="dropdown-item enq_delete"><i class="fa fa-trash"></i>Delete</a></li>' +
                    '                         <li class="dropdown-divider"></li>' +
                    '                     </ul>' +
                    '                 </div>';
                    return straction;
                }
            }
        ],
        buttons: []
    });
    //create items on click
    $.items = {
        /* CREATE ITEM */
        create: function () {
            var self = this;
            //description = str_replace("<br>", "\n", description);
            trcount = trcount + 1;

            var item = $('<tr class="item"></tr>');
            // li
            $('<td class="td-input">' +
                '<input type="hidden" value="0" name="enquiry_item[id]" class="form-control item_id enq-txtbx-pd fnt12 mb-0" />' +
                '<input type="hidden" value="" name="enquiry_item[subcatid]" class="form-control item_subcatid enq-txtbx-pd fnt12 mb-0" />' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="item_name form-control text-xs-left enq-txtbx-pd fnt12 mb-0" name="enquiry_item[li]" value="" required data-validation-required-message="LI is required" autocomplete="on" />' +
                '</div>' +
            '</td>').appendTo(item);
            // description
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<textarea rows="1" class="form-control item_desc enq-textarea fnt12 mb-0" name="enquiry_item[description]" placeholder="Description"></textarea>' +
                '</div>' +
            '</td>').appendTo(item);
            // part no
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" value="" name="enquiry_item[partno]" class="form-control item_partno enq-txtbx-pd fnt12 mb-0" />' +
                '</div>' +
            '</td>').appendTo(item);

            // manufacturer
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" value="" name="enquiry_item[manuf]" class="form-control item_manuf enq-txtbx-pd fnt12 mb-0" />' +
                '</div>' +
            '</td>').appendTo(item);


            // oem
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" value="" name="enquiry_item[oem]" class="form-control item_oem enq-txtbx-pd fnt12 mb-0" />' +
                '</div>' +
            '</td>').appendTo(item);

            // Image
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="file" name="enquiry_item[image]" data-id=\"\" class="form-control item-upl item_image enq-txtbx-pd fnt12 mb-0"/>' +
                    '<input type="hidden" id="hdf-item-image-' + trcount + '" name="hdf-enquiry_item[image]" class="form-control item-upl enq-txtbx-pd fnt12 mb-0"/>' +
                '</div>' +
            '</td>').appendTo(item);

            // unit
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                '<input type="text" name="enquiry_item[unit]" class="form-control enq-txtbx-pd fnt12 mb-0 item_unit" value="" required/>' +
                '</div>' +
            '</td>').appendTo(item);

            // quantity
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                '<input type="text" name="enquiry_item[quantity]" class="form-control enq-txtbx-pd fnt12 mb-0 item_qty" value="" required/>' +
                '</div>' +
            '</td>').appendTo(item);

            // delete item
            $('<td class="td-input">' +
                '<div class="form-group input-group">' +
                    '<button type="button" class="btn btn-link text-danger item_delete tip" title="Delete"><i class="fa fa-trash"></i></button>' +
                '</div>' +
            '</td>').appendTo(item);

            $("#items tbody").append(item);

            $(item).find(".item_name").focus(function () {
                self.set_items_count();
            });
            $(item).find(".item_desc").focus(function () {
                if ($("select[name='customer']").val() == "") {
                    growltoast("To get Part Number, Select customer first", "top", "right", "fa fa-bell-o", "error", "animated fadeIn", "animated fadeOut", "error");
                    return false;
                }
            });

            $(item).find(".item_delete").click(function () {
                self.delete(item);
                return false;
            });

            $(item).find('.item_desc').easyAutocomplete({
                url: function (phrase) { return base_url + "Modules_Handler/sales/H_Enquiry.ashx?fun=desc_autocomp&term=" + phrase; },
                ajaxSettings: { fun: 'desc_autocomp' },
                getValue: "item_desc",
                placeholder: "Description",
                minCharNumber: 0,
                use_on_focus: true,
                list: {
                    maxNumberOfElements: 10,
                    hideOnEmptyPhrase: false,
                    onSelectItemEvent: function () {
                        var result;
                        var data = $(item).find('.item_desc').getSelectedItemData();
                        $(item).find('.item_id').val(data.item_Id).trigger("change");
                        $(item).find('.item_subcatid').val(data.icat_subcat_Id).trigger("change");
                        $(item).find('.item_manuf').val(data.imanufacturer).trigger("change");
                        $(item).find('.item_oem').val(data.ioem_reference).trigger("change");
                        $.ajax({
                            "url": '' + base_url + 'Modules_Handler/sales/H_Enquiry.ashx',
                            "type": "POST",
                            "data": { 'fun': 'geteitem_partno', 'item_id': data.item_Id, 'customerid': $("select[name='customer']").val() },
                            success: function (data_pn) {
                                result = JSON.parse(data_pn);
                                $(item).find('.item_partno').val(result.message);
                            }
                        });
                        ($(item).find('.item_desc').val() == "") ? $(item).find('.item_desc').parent().parent().parent().find("div").addClass("error") : $(item).find('.item_desc').parent().parent().parent().find("div").removeClass("error");
                        $('.easy-autocomplete').css("width", "inherit");
                    },
                    onLoadEvent: function () {
                        $(item).find('.item_id').val("0").trigger("change");
                        $(item).find('.item_subcatid').val("0").trigger("change");
                        $(item).find('.item_manuf').val("0").trigger("change");
                        $(item).find('.item_oem').val("0").trigger("change");
                    }
                }
            });
            this.reset_count();
        },
        /* DELETE ITEM */
        delete: function (item) {
            trcount = trcount -= 1;
            $(item).remove();
        },
        reset_count: function () {
            $.each($("#items tbody tr.item"), function (index, item) {
                $(item).find(".item_name").val(index + 1);
                $(item).find(".item_image").attr("data-id", index);
            });
            this.set_items_count();
        },
        set_items_count: function () {
            var count = 0;
            $.each($("#items tbody tr.item"), function (index, item) {
                if ($(item).find(".item_name").val() != "") {
                    count++;
                }
            });
            upload_doc(base_url, "item_doc", count);
            $('input[name=items_count]').val(count);
        }
    }
    $('.add_row').click(function () {
        $.items.create();
    });
    $.items.create();

});

getAdId = function () {
    var match = location.pathname.match(/[0-9]+$/);
    if (match) {
        return match[0];
    }
},
bindenquiryno = function (base_url, customerid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/sales/H_Enquiry.ashx',
        type: "POST",
        data: { 'fun': 'enquiryno', 'customerid': customerid },
        success: function (data) {
            $("#txt_enquiry_no").val(data.enquiryno);
        },
        error: function (xhr) {
            alert(xhr.responseText);
        }
    });

},
bindCustomer = function (base_url, branchid) {
    $("select[name='cperson']").html("");
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/sales/H_Enquiry.ashx',
        type: "POST",
        data: { 'fun': 'pop_customer', 'branchid': branchid },
        success: function (data) {
            $("select[name='customer']").html(data.html);
        },
        error: function (xhr) {
            alert(xhr.responseText);
        }
    });

},
bindContactPerson = function (base_url, custid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/sales/H_Enquiry.ashx',
        type: "POST",
        data: { 'fun': 'pop_contact_person', 'customerid': custid },
        success: function (data) {
            $("select[name='cperson']").html(data.html);
        },
        error: function (xhr) {
            alert(xhr.responseText);
        }
    });

},
bindLeadGenerator = function (base_url, divisionid, branchid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/sales/H_Enquiry.ashx',
        type: "POST",
        data: { 'fun': 'pop_leadgenerator', 'divisionid': divisionid, 'branchid': branchid },
        success: function (data) {
            $("select[name='leadgenerator']").html(data.html);
            $("select[name='leadcloser']").html(data.html);

        },
        error: function (xhr) {
            alert(xhr.responseText);
        }
    });

},

ResetFields = function () {
    $('select[name="customer"]').html("<option value=\"\" selected>Select</option>");
    $('select[name="cperson"]').html("");
    $('#frm-add-enquiry')[0].reset();
},
growltoast = function (msg, from, align, icon, type, animIn, animOut, status) {
    $.growl({
        icon: icon,
        title: ' ',
        message: msg,
        url: ''
    }, {
        element: 'body',
        type: type,
        allow_dismiss: true,
        placement: {
            from: from,
            align: align
        },
        offset: {
            x: 30,
            y: 30
        },
        spacing: 10,
        z_index: 999999,
        delay: 5000,
        timer: 1000,
        url_target: '_blank',
        mouse_over: false,
        animate: {
            enter: animIn,
            exit: animOut
        },
        icon_type: 'class',
        template: '<div data-growl="container" class="alert" role="alert">' +
        ' <button type="button" class="close" data-growl="dismiss">' +
        ' <span aria-hidden="true">&times;</span>' +
        ' <span class="sr-only">Close</span>' +
        '</button>' +
        '<span data-growl="icon"></span>' +
        '<span data-growl="title"></span>' +
        '<span data-growl="message" style="margin-right:5px;"></span>' +
        '<a href="#" data-growl="url"></a>' +
        '</div>'
    });
},
upload_doc = (function (base_url, frmmode, trcount) {
    var input = $('input[name="refdoc"], input[name="enquiry_item[image]"]').fileuploader({
        limit: 10,
        maxSize: 500,
        extensions: ['jpg', 'jpeg', 'png', 'gif', 'doc', 'pdf', 'txt', 'msg', 'docx', 'xls', 'xlsx', 'csv'],
        enableApi: true,
        upload: {
            url: "" + base_url + "Modules_Handler/sales/H_Enquiry.ashx",
            type: 'POST',
            dataType: 'JSON',
            enctype: 'multipart/form-data',
            data: { fun: 'upl_ref_doc' },
            start: true,
            synchron: true,
            beforeSend: function (item, listEl, parentEl, newInputEl, inputEl) {

            },
            onSuccess: function (data, item, listEl, parentEl, newInputEl, inputEl, textStatus, jqXHR) {
                item.html.find('.column-actions').append(
                  '<a class="fileuploader-action fileuploader-action-remove fileuploader-action-success" title="Remove"><i></i></a>'
                );
                setTimeout(function () {
                    item.html.find('.progress-bar2').fadeOut(400);
                }, 400);
            },
            onError: function (item, listEl, parentEl, newInputEl, inputEl, jqXHR, textStatus, errorThrown) {
                var progressBar = item.html.find('.progress-bar2');

                if (progressBar.length > 0) {
                    progressBar.find('span').html(0 + "%");
                    progressBar.find('.fileuploader-progressbar .bar').width(0 + "%");
                    item.html.find('.progress-bar2').fadeOut(400);
                }

                item.upload.status != 'cancelled' && item.html.find('.fileuploader-action-retry').length == 0 ? item.html.find('.column-actions').prepend(
                  '<a class="fileuploader-action fileuploader-action-retry" title="Retry"><i></i></a>'
                ) : null;
            },
            onProgress: function (data, item, listEl, parentEl, newInputEl, inputEl) {
                var progressBar = item.html.find('.progress-bar2');

                if (progressBar.length > 0) {
                    progressBar.show();
                    progressBar.find('span').html(data.percentage + "%");
                    progressBar.find('.fileuploader-progressbar .bar').width(data.percentage + "%");
                }
            },
            onComplete: function (listEl, parentEl, newInputEl, inputEl, jqXHR, textStatus) {
                result = JSON.parse(jqXHR.responseText);
                if (result.status == "error") {
                    growltoast(result.message, "top", "right", "fa fa-bell-o", result.status, "animated fadeIn", "animated fadeOut", result.status);
                } else {
                    (frmmode == "ref_doc") ? $('input[name="hdf-refdoc"]').val(result.message) : $('input[id="hdf-item-image-' + trcount + '"]').val(result.message);
                }
                //api.reset();
            },
        },
        captions: {
            button: function (options) { return 'Upload' + ' ' + (options.limit == 1 ? 'file' : 'files'); },
            feedback: function (options) { return 'Upload' + ' ' + (options.limit == 1 ? 'file' : 'files') + ' ' + 'to_upload'; },
            feedback2: function (options) { return options.length + ' ' + (options.length > 1 ? 'files_were' : 'file_was') + ' ' + 'chosen'; },
            confirm: 'confirm',
            cancel: 'cancel',
            name: 'filename',
            type: 'file_type',
            size: 'size',
            dimensions: 'dimensions',
            duration: 'duration',
            crop: 'crop',
            rotate: 'rotate',
            close: 'close',
            download: 'download',
            remove: 'remove',
            drop: 'drop_file',
            paste: '<div class="fileuploader-pending-loader"><div class="left-half" style="animation-duration: ${ms}s"></div><div class="spinner" style="animation-duration: ${ms}s"></div><div class="right-half" style="animation-duration: ${ms}s"></div></div> paste_file',
            removeConfirmation: "Are you sure you want to remove this file?",
            errors: {
                filesLimit: "Only %s files are allowed to be uploaded.",
                filesType: "Only %s files are allowed to be uploaded.",
                fileSize: "is too large! Please choose a file up to %s MB.",
                filesSizeAll: "Files that you choosed are too large! Please upload files up to %s MB.",
                fileName: "File with the name %s is already selected.'",
                folderUpload: "You are not allowed to upload folders."
            }
        }
    });
    // get API methods
    api = $.fileuploader.getInstance(input);
})

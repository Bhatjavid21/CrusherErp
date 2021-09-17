$(function () {
    "use strict";
    var base_url = $("#baseurl").val();
    $('.select2').select2();
    var trcount = 0;

    $("body").tooltip({
        selector: '[data-toggle="tooltip"]'
    });

    upload_doc(base_url, "ref_doc");
    $('#datepicker, #bidclosing').datepicker({
        "todayHighlight": true
    });

    
    var enquiryid = $("#hdf-enquiryid").val();
    var strdivisionid, branchid, companyid;
    strdivisionid = $("#hdf_division_id").val();
    branchid = $("#hdf_branch_id").val();
    companyid = $("#hdf_company_id").val();

    bindCustomer(base_url, branchid);
    bindLeadGenerator(base_url, strdivisionid, branchid);


    $("select[name='division']").change(function () {
        $("input[name='enquiryno']").val("");
        if ($(this).val() == "") {
            growltoast("Select Division first", "bottom", "center", "fa fa-bell-o", "error", "animated fadeIn", "animated fadeOut", "error");
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
            growltoast("Select Customer", "bottom", "center", "fa fa-bell-o", "error", "animated fadeIn", "animated fadeOut", "error");
            $("select[name='cperson']").html("");
            $("input[name='enquiryno']").val("");
        }
    });
    $(document).on("click", "#btnsave", function (a) {
        if ($("select[name='customer']").val() == "") {
            growltoast("Select customer first", "bottom", "center", "fa fa-bell-o", "error", "animated fadeIn", "animated fadeOut", "error");
        }
    });

    $(document).on("click", ".fileuploader-action-remove", function (a) {
        alert("value is " + $(this).parent().parent().find(".column-title").text())
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

    $('#frm-edit-enquiry').submit(function (e) {
        e.preventDefault();
        var strqry = "";
        var myval = "";

        $('#frm-edit-enquiry input, #frm-edit-enquiry select, #frm-edit-enquiry textarea').each(
            function (index) {
                var input = $(this);

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
                    ($(this).val() == "") ? $(this).parent().parent().parent().find("div").addClass("error") : "";
                }
                if (input.hasClass("item_unit")) {
                    ($(this).val() == "") ? $(this).parent().parent().find("div").addClass("error") : "";
                }
                if (input.hasClass("item_qty"))
                {
                    ($(this).val() == "") ? $(this).parent().parent().parent().find("div").addClass("error") : "";
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
            }
        );
        strqry = $("#frm-edit-enquiry").serialize() + strqry;
        strqry = strqry + "&fun=Insert&mode=update";
        $.easyAjax({
            url: "" + base_url + "Modules_Handler/Sales/H_Enquiry.ashx",
            data: strqry,
            type: "POST",
            success: function (data) {
                if (data.status == "success") {
                    //ResetFields();
                    //$('input[name="enquiry_item[li]"]').val("1");
                    //window.location.href = "enquiry.aspx";
                }
            }
        });
    });

    bindenquiry(base_url, enquiryid);
    bindenquiryitems(base_url, enquiryid);


    //create items on click
    $.items = {
        /* CREATE ITEM */
        create: function (itemid, itemli, icat_subcat_Id, itemdesc, partno, imanufacturer, ioemref, iunit, iquantity, item_img) {
            var self = this;
            itemdesc = str_replace("<br>", "\n", itemdesc);
            trcount = trcount + 1;

            var item = $('<tr class="item"></tr>');
            // li
            $('<td class="td-input">' +
                '<input type="hidden" name="enquiry_item[id]" class="form-control enq-txtbx-pd fnt12 mb-0" value="' + itemid + '"/>' +
                '<input type="hidden" name="enquiry_item[subcatid]" class="form-control item_subcatid enq-txtbx-pd fnt12 mb-0" value="' + icat_subcat_Id + '" />' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="item_name form-control text-xs-left enq-txtbx-pd fnt12 mb-0" name="enquiry_item[li]" value="' + itemli + '" required autocomplete="on" />' +
                '</div>' +
            '</td>').appendTo(item);
            // description
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<textarea rows="1" class="form-control item_desc enq-textarea fnt12 mb-0" name="enquiry_item[description]" placeholder="Description">' + itemdesc + '</textarea>' +
                '</div>' +
            '</td>').appendTo(item);
            // part no
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" value="' + partno + '" name="enquiry_item[partno]" class="form-control item_partno enq-txtbx-pd fnt12 mb-0" />' +
                '</div>' +
            '</td>').appendTo(item);

            // manufacturer
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" value="' + imanufacturer + '" name="enquiry_item[manuf]" class="form-control item_manuf enq-txtbx-pd fnt12 mb-0" />' +
                '</div>' +
            '</td>').appendTo(item);


            // oem
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" value="' + ioemref + '" name="enquiry_item[oem]" class="form-control item_oem enq-txtbx-pd fnt12 mb-0" />' +
                '</div>' +
            '</td>').appendTo(item);

            // Image
            var strimg = item_img;
            strimg = strimg.substring(strimg.search('|'), (strimg.length - 1));
            
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="file" name="enquiry_item[image]" data-id=\"\" class="form-control item-upl item_image enq-txtbx-pd fnt12 mb-0"/>' +
                    '<input type="hidden" id="hdf-item-image-' + trcount + '" name="hdf-enquiry_item[image]" class="form-control item-upl enq-txtbx-pd fnt12 mb-0" value="' + strimg + '"/>' +
                '</div>' +
            '</td>').appendTo(item);

            // image download
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<div class="input-group-addon einput-group-addon">' +
                        '<a href="javascript:void(0);" class="btn btn-secondary ebtn-secondary tip"><i class="fa fa-upload" data-toggle="tooltip" data-original-title="See Uploaded Documents"></i></a>' +
                     '</div>' +
                '</div>' +
            '</td>').appendTo(item);

            // unit
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                '<input type="text" name="enquiry_item[unit]" class="form-control enq-txtbx-pd item_unit fnt12 mb-0" value="' + iunit + '" required/>' +
                '</div>' +
            '</td>').appendTo(item);

            // quantity
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<div class="col-md-12 controls eq-col-md-12">'+
                        '<input type="text" name="enquiry_item[quantity]" class="form-control item_qty enq-txtbx-pd fnt12 mb-0" value="' + iquantity + '" required/>' +
                    '</div>' +
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
                    growltoast("To get Part Number, Select customer first", "bottom", "center", "fa fa-bell-o", "error", "animated fadeIn", "animated fadeOut", "error");
                    return false;
                }
            });

            $(item).find(".item_delete").click(function () {
                self.delete(item);
                return false;
            });

            $(item).find('.item_desc').easyAutocomplete({
                url: function (phrase) { return base_url + "Modules_Handler/Sales/H_Enquiry.ashx?fun=desc_autocomp&term=" + phrase; },
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
                            "url": '' + base_url + 'Modules_Handler/Sales/H_Enquiry.ashx',
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
        $.items.create(0, "", "", "", "", "", "", "", "","");
    });
    
});
bindenquiryno = function (base_url, customerid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/Sales/H_Enquiry.ashx',
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
        url: '' + base_url + 'Modules_Handler/Sales/H_Enquiry.ashx',
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
bindLeadGenerator = function (base_url, divisionid, branchid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/Sales/H_Enquiry.ashx',
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
bindContactPerson = function (base_url, custid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/Sales/H_Enquiry.ashx',
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
    var strdoc = "";
    var input = $('input[name="refdoc"], input[name="enquiry_item[image]"]').fileuploader({
        limit: 10,
        maxSize: 500,
        extensions: ['jpg', 'jpeg', 'png', 'gif', 'doc', 'pdf', 'txt', 'msg', 'docx', 'xls', 'xlsx', 'csv'],
        enableApi: true,
        upload: {
            url: "" + base_url + "Modules_Handler/Sales/H_Enquiry.ashx",
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
                    strdoc += result.message + "|";
                    (frmmode == "ref_doc") ? $('input[name="hdf-refdoc"]').val(strdoc) : $('input[id="hdf-item-image-' + trcount + '"]').val(strdoc);
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
                filesLimit: "Only 10 files are allowed to be uploaded.",
                filesType: "Only jpg, jpeg, png, gif, doc, pdf, txt, msg, docx, xls, xlsx, csv files are allowed to be uploaded.",
                fileSize: "is too large! Please choose a file up to 10 MB.",
                filesSizeAll: "Files that you choosed are too large! Please upload files up to 100 MB.",
                fileName: "File with the name %s is already selected.'",
                folderUpload: "You are not allowed to upload folders."
            }
        }
    });
    // get API methods
    api = $.fileuploader.getInstance(input);
}),
str_replace = function (_search, _replace, _subject) {
    if (_subject.search(_search) != -1) {
        return str_replace(_search, _replace, _subject.replace(_search, _replace));
    } else {
        return _subject;
    }
},
bindenquiry = function (base_url, enquiryid)
{
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/Sales/H_Enquiry.ashx',
        type: "POST",
        data: { 'fun': 'getenquiry', 'enquiryid': enquiryid },
        success: function (data) {
            $("#txt_enquiry_no").val(data.enquiryno);
            $.each($("select[name='division']").find('option'), function (key, value) {
                ($(this).val() == data.divisionid)? $(this).prop("selected", "true"): "";
            });
            $.each($("select[name='etype']").find('option'), function (key, value) {
                ($(this).text() == data.etype) ? $(this).prop("selected", "true") : "";
            });

            $.each($("select[name='esource']").find('option'), function (key, value) {
                ($(this).val() == data.esource) ? $(this).prop("selected", "true") : "";
            });

            $.each($("select[name='customer']").find('option'), function (key, value) {
                if ($(this).val() == data.ecustomerid) {
                    $(this).prop("selected", "true");
                    $(".select2-selection__rendered").attr("title", data.ecustomername);
                    $(".select2-selection__rendered").text(data.ecustomername);
                }
            });
            bindContactPerson(base_url, data.ecustomerid)
            $.each($("select[name='cperson']").find('option'), function (key, value) {
                ($(this).val() == data.cpersonid) ? $(this).prop("selected", "true") : "";
            });
            $("input[name='cref']").val(data.custref);

            /* Reference document */
            var strimg = data.refdoc;
            strimg = strimg.substring(strimg.search('|'), (strimg.length - 1));            
            $("input[name='hdf-refdoc']").val(strimg);
            var arr_refdoc = strimg.split('|');     
            
            //if ($(".fileuploader").find("input[name='refdoc[]']").hasClass("refdoc")) {
            //    var item = $('<ul class="fileuploader-items-list"></ul>');
            //    $.each(arr_refdoc, function (key, value) {
            //        if (value.search("jpg") > 0) {
            //            $('<li class="fileuploader-item">' +
            //                '<div class="columns">' +
            //                    '<div class="column-thumbnail">' +
            //                    '<div class="fileuploader-item-image"><img src="/traderserp/upload/enquiry/' + value + '" height="36" width="36"/></div>' +
            //                    '</div>' +
            //                    '<div class="column-title">' +
            //                        '<div title="' + value + '">' + value + '</div>' +
            //                        '<span>&nbsp;</span>' +
            //                    '</div>' +
            //                    '<div class="column-actions">' +
            //                        '<a class="fileuploader-action fileuploader-action-remove" title="Remove"><i></i></a>' +
            //                    '</div>' +
            //                '</div>' +
            //                '<div class="progress-bar2"><span>&nbsp;</span></div>' +
            //            '</li>').appendTo(item);
            //        }
            //        else {
            //            var file_ext = value.split('.');
            //            $('<li class="fileuploader-item">' +
            //                '<div class="columns">' +
            //                    '<div class="column-thumbnail">' +
            //                    '<div class="fileuploader-item-image fileupload-no-thumbnail"><div style="background-color: #709c27" class="fileuploader-item-icon"><i>' + file_ext + '</i></div></div>' +
            //                    '</div>' +
            //                    '<div class="column-title">' +
            //                        '<div title="' + value + '">' + value + '</div>' +
            //                        '<span>&nbsp;</span>' +
            //                    '</div>' +
            //                    '<div class="column-actions">' +
            //                        '<a class="fileuploader-action fileuploader-action-remove" title="Remove"><i></i></a>' +
            //                    '</div>' +
            //                '</div>' +
            //                '<div class="progress-bar2"><span>&nbsp;</span></div>' +
            //            '</li>').appendTo(item);
            //        }
            //    });
            //    $(".fileuploader .fileuploader-items").append(item);
            //}


            $("input[name='edate']").val(data.edate);
            $("input[name='bidcldate']").val(data.eclosingdate);
            $.each($("select[name='leadgenerator']").find('option'), function (key, value) {
                ($(this).val() == data.eleadgenerator) ? $(this).prop("selected", "true") : "";
            });
            $.each($("select[name='leadcloser']").find('option'), function (key, value) {
                ($(this).val() == data.eleadcloser) ? $(this).prop("selected", "true") : "";
            });

            ($.trim(data.partenquiry) == "yes") ? $("input[name='penquiry']").prop("checked", "true") : "";

            $("textarea[name='add-details']").val(data.addtdetails);

        },
        error: function (xhr) {
            alert(xhr.responseText);
        }
    });

},
bindenquiryitems = function (base_url, enquiryid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/Sales/H_Enquiry.ashx',
        type: "POST",
        data: { 'fun': 'getenquiryitems', 'enquiryid': enquiryid },
        success: function (data) {
            $.each(data, function (key, edata) {
                $.items.create(edata.item_Id, edata.item_li, edata.icat_subcat_Id, edata.item_desc, edata.partno, edata.imanufacturer, edata.ioem_reference, edata.iunit, edata.iquantity, edata.item_img);
            });

        },
        error: function (xhr) {
            alert(xhr.responseText);
        }
    });

}
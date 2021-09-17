$(function () {
    "use strict";
    tinymce.remove(".email_content");
    tinymce.init({
        selector: 'textarea.email_content',
        branding: false,
        height: 100,
        menubar: false,
        plugins: [
          'lists, paste'
        ],
        formats: {
            bold: { inline: 'b' },
            italic: { inline: 'i' }
        },
        toolbar: 'undo redo | styleselect | bold italic | alignleft aligncenter alignright | bullist'
    });
    $('.select2').select2();
    
    var base_url = $("#baseurl").val();
    var divisionid, branchid, companyid, empid;
    divisionid = $("#hdf_division_id").val();
    branchid = $("#hdf_branch_id").val();
    companyid = $("#hdf_company_id").val();
    empid = $("#hdf_emp_id").val();


    bindDivision(base_url, branchid, divisionid);
    bindEnquiryno(base_url, branchid, divisionid);
    bindEstimatedby(base_url, empid, branchid, divisionid);

    $(document).on("click", ".ajaxmodal", function (e) {
        var url = $(this).attr("data-src");
        var title = $(this).attr("data-title");
        var dataid = $(this).attr("data-id");
        $(".modal").attr("id", dataid);
        $.ajaxModal('.modal', url);
        $(".modal .modal-title").text(title);

    });

    $(document).on("click", ".btn-item-code", function () {
        var dataid = $(this).attr("data-id")
        var stropty = false, stroptn = true;
        $("select[name='itemcode']").find("option").each(function () {
            ($(this).text() == dataid) ? stropty = true:stroptn = false;
        });
        (stropty == false && stroptn == false) ? $("select[name='itemcode']").append('<option>' + $(this).attr("data-id") + '</option>') : growltoast("Item Code already added.", "top", "right", "fa fa-bell-o", "error", "animated fadeIn", "animated fadeOut", "error");;

    });

    $("select[name='division']").change(function () {
        $("select[name='enquiryno']").html("");
        $("select[name='estimatedby']").html("");
        bindEnquiryno(base_url, branchid, $(this).val());
        bindEstimatedby(base_url, empid, branchid, $(this).val());
    });

    $("select[name='enquiryno']").change(function () {
        var enquiryid = $("select[name='enquiryno'] option:selected").val();
        $('.cls-enq-details').attr("data-id", enquiryid);
        $('.cls-enq-details').attr("data-src", "Modules_Screen/Estimation/enq-details.aspx?enquiryid=" + enquiryid);
        //getitems(base_url, dataid);
    });

    $(document).on("click", ".cls-enq-details", function () {
        var url = $(this).attr("data-src");
        $('.control-sidebar').load(url);
    });

    $(document).on('shown.bs.modal', function () {
        if ($("#nsi-supp-pso, #md-item-code, #md-stock-item-list").hasClass("show")) {
            $('.modal-backdrop').remove();
        }
    });

    $(".slc-supplier").on('change', function () {
        var supid = $("#nsi-sup1 option:selected").val();
        $.items.create(supid, $(".slc-supplier option:selected").text());
    });

    $.items = {
        /* CREATE ITEM */
        create: function (supid, supp_name) {
            var self = this;
            //description = str_replace("<br>", "\n", description);

            var item = $('<tr class="item"></tr>');

            // checkbox
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<div class="checkbox text-xs-left enq-txtbx-pd fnt12 mb-0">' +
                        ' <input type="checkbox" id="chk_nsi2"><label for="chk_nsi2" class="p-0"></label>' +
                    '</div>' +
                '</div>' +
            '</td>').appendTo(item);


            // li
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // item code
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // supplier
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value="' + supp_name + '"  />' +
                '</div>' +
            '</td>').appendTo(item);

            // unit
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // quantity
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // rate
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // duties
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // taxes
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // freight
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // total
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // rate
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // rate
            $('<td class="td-input">' +
                '<div class="form-group input-group mb-0">' +
                    '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value=""  />' +
                '</div>' +
            '</td>').appendTo(item);

            // delete item
            $('<td class="td-input">' +
                '<div class="form-group input-group">' +
                    '<button type="button" class="btn btn-link text-danger item_delete tip" title="Delete"><i class="fa fa-trash"></i></button>' +
                '</div>' +
            '</td>').appendTo(item);

            $("#tbl_est_nsi_items tbody").append(item);

            $(item).find(".item_delete").click(function () {
                self.delete(item);
                return false;
            });
        },
        /* DELETE ITEM */
        delete: function (item) {
            $(item).remove();
        }
    }



});


bindEnquiryno = function (base_url, branchid, divisionid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/sales/H_Estimation.ashx',
        type: "POST",
        data: { 'fun': 'getnequiryno', 'divisionid': divisionid, 'branchid': branchid },
        success: function (data) {
            $("select[name='enquiryno']").html(data.html);
            $('.cls-enq-details').attr("data-id", $("select[name='enquiryno'] option:selected").val());
            $('.cls-enq-details').attr("data-src", "Modules_Screen/Estimation/enq-details.aspx?enquiryid=" + $("select[name='enquiryno'] option:selected").val());
        },
        error: function (xhr) {
            alert(xhr.responseText);
        }
    });

},
bindDivision = function (base_url, branchid, divisionid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/sales/H_Estimation.ashx',
        type: "POST",
        data: { 'fun': 'getdivision', 'divisionid': divisionid, 'branchid': branchid },
        success: function (data) {
            $("select[name='division']").html(data.html);
        },
        error: function (xhr) {
            alert(xhr.responseText);
        }
    });

},
bindEstimatedby = function (base_url, empid, branchid, divisionid) {
    $.easyAjax({
        url: '' + base_url + 'Modules_Handler/sales/H_Estimation.ashx',
        type: "POST",
        data: { 'fun': 'getestby', 'empid': empid, 'branchid': branchid, 'divisionid': divisionid },
        success: function (data) {
            $("select[name='estimatedby']").html(data.html);
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
str_replace = function (_search, _replace, _subject) {
    if (_subject.search(_search) != -1) {
        return str_replace(_search, _replace, _subject.replace(_search, _replace));
    } else {
        return _subject;
    }
}
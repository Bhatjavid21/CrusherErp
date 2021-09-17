$(function () {
    "use strict";

    $('.chat-left-inner > .chatonline').slimScroll({
        height: '100%',
        position: 'right',
        size: "0px",
        color: '#dcdcdc',

    });
    $('.chat-left-inner').css({
        'height': (($(window).height()) - 240) + 'px'
    });
    $('.chat-list').css({ 'height': (($(window).height()) - 420) + 'px' });

    $('[data-mask]').inputmask();
    var base_url = $("#baseurl").val();
    var currency_table;

    $(".modal").on("show.bs.modal", function (e) {
        $(".modal .modal-dialog").attr("class", "modal-dialog slideInRight animated");
        ($("body").hasClass("modal-open")) ? $('body .modal-backdrop').last().remove() : "";

    });
    $(".modal").on("hide.bs.modal", function (e) {
        $(".modal .modal-dialog").attr("class", "modal-dialog slideOutRight animated");
    });

    $(document).on("click", ".mdconversion", function (e) {
        var currencyid = $("#hdf-conv-currency-id").val();
        var url = "" + base_url + "Modules_Screen/currency/currency-conversion.html";
        $(".mdconversion").attr("data-src", url);
    });
    $(document).on("click", ".mdcuradd", function (e) {
        var currencyid = $("#hdf-conv-currency-id").val();
        var url = "" + base_url + "Modules_Screen/Currency/currency-add.html";
        $(".mdcuradd").attr("data-src", url);
    });

    $(document).on("click", ".ajaxmodal", function (e) {
        var url = $(this).attr("data-src");
        var title = $(this).attr("data-title");
        $.ajaxModal('.modal', url);
        $(".modal .modal-title").text(title);
    });

    

    $(document).on("click", ".spn-curr-edit", function (e) {
        var currencyid = $(this).attr("data-currency-id");
        currencyid = str_replace("spn-edit-", "", currencyid);
        var strqry = "currency_id=" + currencyid + "&fun=Edit";

        $.easyAjax({
            url: "" + base_url + "Modules_Handler/Currency/H_tbl_Currency.ashx",
            data: strqry,
            type: "POST",
            success: function (response) {
                $.easyBlockUI("body");
                var curresp = response.currvalue.split("|");
                $('#hdf_currency_id').val(currencyid);
                $('#txt_currency_name').val(curresp[1]);
                $('#txt_currency_code').val(curresp[0]);
                $('#txt_currency_name').val(curresp[1]);
                $('#btn-currency-save').addClass("hide");
                $('#btn-currency-update').removeClass("hide");
                $.unblockUI();
            }
        });
    });

    $(document).on("click", ".spn-currency", function (e) {
        $('.spn-currency').each(function () {
            //$(this).removeClass("badge badge-pill badge-gray");
            $(this).removeClass("active");
        });

        var currencyid = $(this).attr("data-currency-id");
        $('#hdf-conv-currency-id').val(currencyid);
        //$('.right-block .box').removeClass("right-block-max-height");
        //$('.right-block .box-header').removeClass("hide");
        //$('.right-block .box-body').removeClass("hide");
        //$(this).addClass("badge badge-pill badge-gray");

        $(this).addClass("active");
        currency_table = $('#dtcurrency').DataTable({
            dom: 'Bfrtip',
            destroy: true,
            "pageLength": 25,
            "processing": true,
            "serverSide": true,
            "aaSorting": [[0, "desc"]],
            'lengthChange': true,
            'searching': false,
            'ordering': true,
            'info': true,
            'autoWidth': false,
            "ajax": {
                "url": "" + base_url + "Modules_Handler/Currency/H_tbl_Currency.ashx",
                "type": "POST",
                "data": {
                    "fun": "datatable",
                    "currency_id": currencyid
                }
            },
            "fnDrawCallback": function (oSettings) {
                $("body").tooltip({
                    selector: '[data-toggle="tooltip"]'
                });
            },
            "columns":
            [
                { "data": "currfrom" },
                { "data": "currto" },
                { "data": "conversionrate" },
                { "data": "currfromdate" },
                { "data": "currtodate" }
            ],
            buttons: []
        });
    });

});
function str_replace(_search, _replace, _subject) {
    if (_subject.search(_search) != -1) {
        return str_replace(_search, _replace, _subject.replace(_search, _replace));
    } else {
        return _subject;
    }
}
function reloadtable() {
    $('#dtcurrency').DataTable().ajax.reload();
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
function hideModal() {
    $(".modal").removeClass("show");
    $(".modal").removeAttr("style");
    $('body').removeClass('modal-open');
    $('body').removeAttr('style');
    $('.modal-backdrop').remove();
    $(".modal").modal().hide();
}

Bindlist = function (base_url) {
    $('#Td_View_Currency').find('li').each(function () {
        if ($(this).hasClass("active")) {
            var currencyid = $(this).attr("data-currency-id");
            $('#hdf-conv-currency-id').val(currencyid);
            currency_table = $('#dtcurrency').DataTable({
                dom: 'Bfrtip',
                destroy: true,
                "pageLength": 25,
                "processing": true,
                "serverSide": true,
                "aaSorting": [[0, "desc"]],
                'lengthChange': true,
                'searching': false,
                'ordering': true,
                'info': true,
                'autoWidth': false,
                "ajax": {
                    "url": "" + base_url + "Modules_Handler/Currency/H_tbl_Currency.ashx",
                    "type": "POST",
                    "data": {
                        "fun": "datatable",
                        "currency_id": currencyid
                    }
                },
                "fnDrawCallback": function (oSettings) {
                    $("body").tooltip({
                        selector: '[data-toggle="tooltip"]'
                    });
                },
                "columns":
                [
                    { "data": "currfrom" },
                    { "data": "currto" },
                    { "data": "conversionrate" },
                    { "data": "currfromdate" },
                    { "data": "currtodate" }
                ],
                buttons: []
            });
        }
    });
}
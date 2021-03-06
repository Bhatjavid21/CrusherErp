$(function () {
    "use strict";
    $(".select2").select2();

    $('#tbl-quotation').DataTable({
        'paging': false, "pageLength": 50, 'lengthChange': false, 'searching': false, 'ordering': true, 'info': false, 'autoWidth': false,
    });
    
    $('#tbl-quotation').editableTableWidget().numericInputExample().find('td:first').focus();

    $(document).on('shown.bs.modal', function () {
        if ($("#quotation-item").hasClass("show")) {
            $('.modal-backdrop').remove();
        }
    });

    $(".slcquotation").select2({
        dropdownParent: $("#quotation-item")
    });
    $(".select2-container").addClass("sales-qt-dropdown");

    $('.check').each(function () {
        var rd = $(this).attr('data-radio') ? $(this).attr('data-radio') : 'iradio_minimal-red';
        if (rd.indexOf('_line') > -1) {
            $(this).iCheck({
                radioClass: rd,
                //insert: '<div class="icheck_line-icon"></div>' + $(this).attr("data-label")
                insert: $(this).attr("data-label")
            });
        } else {
            $(this).iCheck({
                checkboxClass: ck,
                radioClass: rd
            });
        }
    });

    var radcount = 0;
    $('.grp2').each(function (index) {
        if ((index % 2) == 0) {
            $(this).addClass("leave-left-border");
        } else if ((index % 2) == 1) {
            $(this).addClass("leave-right-border");
        }
        radcount += 1;
    });

    
    
});

leavepopulatedate = function (self) {
    var dataid = self.attr("data-label");
    if (dataid == "Search Item Master") {
        $(".mailbox-controls .row").removeClass("hide");
        $(".rowquotation").addClass("hide");
    }
    else {
        $(".mailbox-controls .row").addClass("hide");
        $(".rowquotation").removeClass("hide");
    }



}
$(function () {
    "use strict";

    var inccount = 0;
    $('.select2').select2();
    $("body").tooltip({
        selector: '[data-toggle="tooltip"]'
    });

    $('#datepicker-inline').datepicker({
        todayHighlight: true,
        showWeekDays: false,
    });


    var trcount = 0;
    $('.tblattendance tbody tr').each(function (index) {
        if (trcount == 0) {
            var tr = $(this);
            $(tr.find('td')).each(function () {
                var td = $(this);
                if (td.find('input:text')) {
                    var strinput = $(this).find('input:text');
                    strinput.attr("disabled", "disabled");
                }
                if (td.find('select')) {
                    var strselect = $(this).find('select');
                    strselect.attr("disabled", "disabled");
                }
            });
        }
        trcount += 1;
    });

















});
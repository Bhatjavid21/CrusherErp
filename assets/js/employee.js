$(function () {
    "use strict";
    var trcount = 0;
    $('#tbl-employee').DataTable({
        'paging': true,
        "pageLength": 50,
        'lengthChange': false,
        'searching': false,
        'ordering': true,
        'info': false,
        'autoWidth': false,
    });

    $('#datepicker-inline').datepicker({
        todayHighlight: true,
        showWeekDays: false,
    });

    $('#dtemgcnt,#tbldependent').DataTable({
        'paging': false,
        "pageLength": 50,
        'lengthChange': false,
        'searching': false,
        'ordering': true,
        'info': true,
        'autoWidth': false,
    });
    



    //Address functions goes here.
    $("#btn-emgcnt-add").on('click', function () {
        $('#emgcnt-add').slideDown();
        $("#emgcnt-add").removeClass("hide");
        $("#rwemgcntplus").addClass("hide");
    });

    $("#btn-dpd-add").on('click', function () {
        $('#dpd-add').slideDown();
        $("#dpd-add").removeClass("hide");
        $("#rwdpdplus").addClass("hide");
    });



    $("#btn-dpd-close").on('click', function () {
        $('#dpd-add').slideUp();
        $("#dpd-add").addClass("hide");
        $("#rwdpdplus").removeClass("hide");
    });
    $("#btn-emgcnt-close").on('click', function () {
        $('#emgcnt-add').slideUp();
        $("#emgcnt-add").addClass("hide");
        $("#rwemgcntplus").removeClass("hide");
    });

   
});

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
}


callsalarydate = function (strdate) {
    alert("I am in employee js callsalarydate function " + strdate);
}
$(function () {
    "use strict";
    $(".select2").select2();
    //$(".modal").on("show.bs.modal", function (e) {
    //    $(".modal .modal-dialog").addClass("slideInRight animated");
    //    ($("body").hasClass("modal-open")) ? $('body .modal-backdrop').last().remove() : "";

    //});
    //$(".modal").on("hide.bs.modal", function (e) {
    //    $(".modal .modal-dialog").removeClass("slideOutRight animated");
    //});


    
    $("#ddl_Employee").select2({
        dropdownParent: $('#myModal')
    });

    $('.tblusers').DataTable({
        "pageLength": 50,
        'lengthChange': false,
        'searching': true,
        'ordering': true,
        'info': true,
        'autoWidth': false,
        'placeholder': "Search",
    });


});
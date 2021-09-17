$(function () {
    "use strict";
    var inccount = 0;
    $('.select2').select2();
    $('.timepicker').timepicker({
        showInputs: false
    });

    $("body").tooltip({
        selector: '[data-toggle="tooltip"]'
    });

    $(document).on("click", ".btn-add-weekends", function (e) {
        inccount += 1;
        $.weekends.create(inccount);

    });

    $(document).on("click", ".btn-add-holidays", function (e) {
        inccount += 1;
        $.holidays.create(inccount);

    });
    $(document).on("click", ".btn-add-shifts", function (e) {
        inccount += 1;
        $.shifts.create(inccount);
    });
    $(document).on("click", ".btn-add-leaves", function (e) {
        inccount += 1;
        $.leaves.create(inccount);
    });
    $(document).on("click", ".btn-add-wbs", function (e) {
        inccount += 1;
        $.wbs.create(inccount);
    });
    $(document).on("click", ".btn-add-doc", function (e) {
        inccount += 1;
        $.doc.create(inccount);
    });

    $(document).on("click", ".btn-carry", function (e) {
        ($(this).attr("aria-pressed") == "true") ? $("input[name='cfldays']").removeClass("hide") : $("input[name='cfldays']").addClass("hide");
        
    });
    $(document).on("click", ".btn-payoff", function (e) {
        ($(this).attr("aria-pressed") == "true") ? $("input[name='poldays']").removeClass("hide") : $("input[name='poldays']").addClass("hide");

    });
    $(document).on("click", ".btn-alloc", function (e) {
        ($(this).attr("aria-pressed") == "true") ? $("select[name='allocdays']").removeClass("hide") : $("select[name='allocdays']").addClass("hide");

    });

    $.weekends.create(inccount);
    $.holidays.create(inccount);
    $.shifts.create(inccount);
    $.leaves.create(inccount);
    $.wbs.create(inccount);
    $.doc.create(inccount);

});



$.weekends = {
    create: function (inccount) {
        var self = this;
        //description = str_replace("<br>", "\n", description);

        var weekends = $('<div class="row"></div>');

        //Monday
        $('<div class="col-d2">' +
            '<div class="media dp-weekdays  hr-selected">' +
                '<div class="media-left">Monday</div>' +
                '<div class="media-body m-0">' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_m_Full_' + inccount + '">' +
                        '<label for="chk_m_Full_' + inccount + '" data-toggle="tooltip" data-original-title="Half Day"></label>' +
                    '</label>' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_m_alternate_' + inccount + '">' +
                        '<label for="chk_m_alternate_' + inccount + '" data-toggle="tooltip" data-original-title="Alternate Holiday"></label>' +
                    '</label>' +
                ' </div>' +
            ' </div>' +
        '</div>').appendTo(weekends);

        //Tuesday
        $('<div class="col-d2">' +
            '<div class="media dp-weekdays">' +
                '<div class="media-left">Tuesday</div>' +
                '<div class="media-body m-0">' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_t_Full_' + inccount + '">' +
                        '<label for="chk_t_Full_' + inccount + '" data-toggle="tooltip" data-original-title="Half Day"></label>' +
                    '</label>' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_t_alternate_' + inccount + '">' +
                        '<label for="chk_t_alternate_' + inccount + '" data-toggle="tooltip" data-original-title="Alternate Holiday"></label>' +
                    '</label>' +
                ' </div>' +
            ' </div>' +
        '</div>').appendTo(weekends);

        //Wednesday
        $('<div class="col-d2">' +
            '<div class="media dp-weekdays">' +
                '<div class="media-left">Wednesday</div>' +
                '<div class="media-body m-0">' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_w_Full_' + inccount + '">' +
                        '<label for="chk_w_Full_' + inccount + '" data-toggle="tooltip" data-original-title="Half Day"></label>' +
                    '</label>' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_w_alternate_' + inccount + '">' +
                        '<label for="chk_w_alternate_' + inccount + '" data-toggle="tooltip" data-original-title="Alternate Holiday"></label>' +
                    '</label>' +
                ' </div>' +
            ' </div>' +
        '</div>').appendTo(weekends);

        //Thursday
        $('<div class="col-d2">' +
            '<div class="media dp-weekdays">' +
                '<div class="media-left">Thursday</div>' +
                '<div class="media-body m-0">' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_th_Full_' + inccount + '">' +
                        '<label for="chk_th_Full_' + inccount + '" data-toggle="tooltip" data-original-title="Half Day"></label>' +
                    '</label>' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_th_alternate_' + inccount + '">' +
                        '<label for="chk_th_alternate_' + inccount + '" data-toggle="tooltip" data-original-title="Alternate Holiday"></label>' +
                    '</label>' +
                ' </div>' +
            ' </div>' +
        '</div>').appendTo(weekends);

        //Friday
        $('<div class="col-d2">' +
            '<div class="media dp-weekdays">' +
                '<div class="media-left">Friday</div>' +
                '<div class="media-body m-0">' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_f_Full_' + inccount + '">' +
                        '<label for="chk_f_Full_' + inccount + '" data-toggle="tooltip" data-original-title="Half Day"></label>' +
                    '</label>' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_f_alternate_' + inccount + '">' +
                        '<label for="chk_f_alternate_' + inccount + '" data-toggle="tooltip" data-original-title="Alternate Holiday"></label>' +
                    '</label>' +
                ' </div>' +
            ' </div>' +
        '</div>').appendTo(weekends);

        //Saturday
        $('<div class="col-d2">' +
            '<div class="media dp-weekdays">' +
                '<div class="media-left">Saturday</div>' +
                '<div class="media-body m-0">' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_sa_Full_' + inccount + '">' +
                        '<label for="chk_sa_Full_' + inccount + '" data-toggle="tooltip" data-original-title="Half Day"></label>' +
                    '</label>' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_sa_alternate_' + inccount + '">' +
                        '<label for="chk_sa_alternate_' + inccount + '" data-toggle="tooltip" data-original-title="Alternate Holiday"></label>' +
                    '</label>' +
                ' </div>' +
            ' </div>' +
        '</div>').appendTo(weekends);

        //Sunday
        $('<div class="col-d2">' +
            '<div class="media dp-weekdays">' +
                '<div class="media-left">Sunday</div>' +
                '<div class="media-body m-0">' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_su_Full_' + inccount + '">' +
                        '<label for="chk_su_Full_' + inccount + '" data-toggle="tooltip" data-original-title="Half Day"></label>' +
                    '</label>' +
                    '<label class="custom-control custom-checkbox">' +
                        '<input type="checkbox" id="chk_su_alternate_' + inccount + '">' +
                        '<label for="chk_su_alternate_' + inccount + '" data-toggle="tooltip" data-original-title="Alternate Holiday"></label>' +
                    '</label>' +
                ' </div>' +
            ' </div>' +
        '</div>').appendTo(weekends);


        $('<div class="col-grp">' +
            '<div class="media dp-weekdays-grp">' +
                '<div class="media-body m-0">' +
                    '<select class="form-control enq-txtbx-pd fnt12 select2 mb-7 enq-dropdown" multiple>' +
                        '<option>Group 1</option>' +
                        '<option>Group 2</option>' +
                        '<option>Group 3</option>' +
                    '</select>' +
                '</div>' +
            '</div>' +
        '</div>').appendTo(weekends);


        $('<div class="col-del">' +
            '<div class="media dp-weekdays-del">' +
                '<div class="media-body m-0">' +
                    '<a href="javascript:void(0);" class="btn btn-default btn-xs item_delete">' +
                        '<i class="fa fa-trash"></i>' +
                    '</a>' +
                '</div>' +
            '</div>' +
        '</div>').appendTo(weekends);

        $(".rw-weekend").append(weekends);
        $('.select2').select2();

        $(weekends).find(".item_delete").click(function () {
            self.delete(weekends);
            return false;
        });
    },
    delete: function (weekends) {
        $(weekends).remove();
    }
}

$.holidays = {
    create: function (inccount) {
        var self = this;
        var holidays = $('<tr class="item"></tr>');


        $('<td>' +
            '<div class="form-group input-group mb-0 ml-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mt-5 txtplaceholder" value="" placeholder="Holiday Name" />' +
            '</div>' +
        '</td>').appendTo(holidays);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
               ' <input type="date" class="form-control text-xs-left enq-txtbx-pd fnt12 mt-5 txtplaceholder" value="" />' +
            '</div>' +
       ' </td>').appendTo(holidays);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="date" class="form-control text-xs-left enq-txtbx-pd fnt12 mt-5 txtplaceholder" value="" />' +
            '</div>' +
        '</td>').appendTo(holidays);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<select class="form-control enq-txtbx-pd fnt12 enq-dropdown mt-5">' +
                    '<option>Mandatory</option>' +
                    '<option>Optional</option>' +
                '</select>' +
            '</div>' +
        '</td>').appendTo(holidays);


        $('<td>' +
            '<div class="form-group input-group mb-0 pt-5">' +
                '<select class="form-control enq-txtbx-pd fnt12 enq-dropdown select2 holiday-grp" multiple>' +
                    '<option>Employee 1</option>' +
                   ' <option>Employee 2</option>' +
                    '<option>Employee 1</option>' +
                    '<option>Employee 2</option>' +
                   ' <option>Employee 1</option>' +
                    '<option>Employee 2</option>' +
                '</select>' +
            '</div>' +
        '</td>').appendTo(holidays);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<div class="checkbox text-xs-left enq-txtbx-pd fnt12 mb-0">' +
                 '   <input type="checkbox" id="chk_si1_' + inccount + '">' +
                 '   <label for="chk_si1_' + inccount + '" class="p-0"></label>' +
               ' </div>' +
           ' </div>' +
       ' </td>').appendTo(holidays);


        $('<td>' +
            '<div class="col-del pl-5">' +
                '<div class="form-group input-group mb-0">' +
                    '<a href="javascript:void(0);" class="btn btn-default btn-xs item_delete">' +
                        '<i class="fa fa-trash"></i>' +
                    '</a>' +
                '</div>' +
            '</div>' +
           '</td>').appendTo(holidays);



        $(".tablewk tbody").append(holidays);
        $('.select2').select2();

        $(holidays).find(".item_delete").click(function () {
            self.delete(holidays);
            return false;
        });
    },
    delete: function (holidays) {
        $(holidays).remove();
    }
}

$.shifts = {
    create: function (inccount) {
        var self = this;
        var shifts = $('<tr class="item"></tr>');


        $('<td>' +
            '<div class="bootstrap-timepicker">' +
                '<div class="input-daterange input-group">' +
                    '<input type="text" class="form-control timepicker enq-txtbx-pd fnt10 mt-5" name="start" value="9:00 AM">' +
                    '<span class="input-group-addon bg-primary text-white enq-txtbx-pd fnt10 mt-5">to</span>' +
                    '<input type="text" class="form-control timepicker enq-txtbx-pd fnt10 mt-5" name="end" value="5:00 PM">' +
                '</div>' +
            '</div>' +
        '</td>').appendTo(shifts);


        $('<td>' +
            '<div class="bootstrap-timepicker">' +
                '<div class="input-daterange input-group">' +
                    '<input type="text" class="form-control timepicker enq-txtbx-pd fnt10 mt-5" name="start" value="5:01 PM">' +
                    '<span class="input-group-addon bg-primary text-white enq-txtbx-pd fnt10 mt-5">to</span>' +
                    '<input type="text" class="form-control timepicker enq-txtbx-pd fnt10 mt-5" name="end" value="9:00 PM">' +
                '</div>' +
            '</div>' +
        '</td>').appendTo(shifts);

        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(shifts);


        $('<td>' +
            '<div class="bootstrap-timepicker">' +
                '<div class="input-daterange input-group">' +
                    '<input type="text" class="form-control timepicker enq-txtbx-pd fnt10 mt-5" name="start" value="9:01 PM">' +
                    '<span class="input-group-addon bg-primary text-white enq-txtbx-pd fnt10 mt-5">to</span>' +
                    '<input type="text" class="form-control timepicker enq-txtbx-pd fnt10 mt-5" name="end" value="12:00 AM">' +
                '</div>' +
            '</div>' +
        '</td>').appendTo(shifts);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(shifts);


        $('<td>' +
            '<div class="bootstrap-timepicker">' +
                '<div class="input-daterange input-group">' +
                    '<input type="text" class="form-control timepicker enq-txtbx-pd fnt10 mt-5" name="start" value="12:01 AM">' +
                    '<span class="input-group-addon bg-primary text-white enq-txtbx-pd fnt10 mt-5">to</span>' +
                    '<input type="text" class="form-control timepicker enq-txtbx-pd fnt10 mt-5" name="end" value="8:59 AM">' +
                '</div>' +
            '</div>' +
        '</td>').appendTo(shifts);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(shifts);

        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<select class="form-control enq-txtbx-pd fnt12 select2 mb-0 enq-dropdown mt-5 shift-grp" multiple>' +
                    '<option>Group 1</option>' +
                    '<option>Group 2</option>' +
                    '<option>Group 3</option>' +
                    '<option>Group 1</option>' +
                    '<option>Group 2</option>' +
                    '<option>Group 3</option>' +
                '</select>' +
            '</div>' +
        '</td>').appendTo(shifts);

        $('<td>' +
            '<div class="col-del pl-5">' +
                '<div class="form-group input-group mb-0">' +
                    '<a href="javascript:void(0);" class="btn btn-default btn-xs item_delete">' +
                        '<i class="fa fa-trash"></i>' +
                    '</a>' +
                '</div>' +
            '</div>' +
           '</td>').appendTo(shifts);



        $(".tableshf tbody").append(shifts);
        $('.select2').select2();
        //$('.timepicker').timepicker({
        //    showInputs: false
        //});

        $(shifts).find(".item_delete").click(function () {
            self.delete(shifts);
            return false;
        });
    },
    delete: function (shifts) {
        $(shifts).remove();
    }
}

$.leaves = {
    create: function (inccount) {
        var self = this;
        var leaves = $('<tr class="item"></tr>');


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(leaves);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(leaves);

        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(leaves);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(leaves);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(leaves);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(leaves);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(leaves);

        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(leaves);

        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<select class="form-control enq-txtbx-pd fnt12 select2 mb-0 enq-dropdown mt-5 shift-grp" multiple>' +
                    '<option>Group 1</option>' +
                    '<option>Group 2</option>' +
                    '<option>Group 3</option>' +
                    '<option>Group 1</option>' +
                    '<option>Group 2</option>' +
                    '<option>Group 3</option>' +
                '</select>' +
            '</div>' +
        '</td>').appendTo(leaves);

        $('<td>' +
            '<div class="col-del pl-5">' +
                '<div class="form-group input-group mb-0">' +
                    '<a href="javascript:void(0);" class="btn btn-default btn-xs item_delete">' +
                        '<i class="fa fa-trash"></i>' +
                    '</a>' +
                '</div>' +
            '</div>' +
           '</td>').appendTo(leaves);



        $(".tablelvs tbody").append(leaves);
        $('.select2').select2();
        if (inccount == 0) {
            $('.timepicker').timepicker({
                showInputs: false
            });
        }


        $(leaves).find(".item_delete").click(function () {
            self.delete(leaves);
            return false;
        });
    },
    delete: function (leaves) {
        $(leaves).remove();
    }
}

$.wbs = {
    create: function (inccount) {
        var self = this;
        var wbs = $('<tr class="item"></tr>');


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(wbs);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt10 mb-0 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(wbs);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<select class="form-control enq-txtbx-pd fnt12 select2 mb-0 enq-dropdown mt-5 holiday-grp" multiple>' +
                    '<option>Group 1</option>' +
                    '<option>Group 2</option>' +
                    '<option>Group 3</option>' +
                    '<option>Group 1</option>' +
                    '<option>Group 2</option>' +
                    '<option>Group 3</option>' +
                '</select>' +
            '</div>' +
        '</td>').appendTo(wbs);

        $('<td>' +
            '<div class="col-del pl-5">' +
                '<div class="form-group input-group mb-0">' +
                    '<a href="javascript:void(0);" class="btn btn-default btn-xs item_delete">' +
                        '<i class="fa fa-trash"></i>' +
                    '</a>' +
                '</div>' +
            '</div>' +
           '</td>').appendTo(wbs);



        $(".tablewbs tbody").append(wbs);
        $('.select2').select2();
        $(wbs).find(".item_delete").click(function () {
            self.delete(wbs);
            return false;
        });
    },
    delete: function (wbs) {
        $(wbs).remove();
    }
}

$.doc = {
    create: function (inccount) {
        var self = this;
        var doc = $('<tr class="item"></tr>');


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<select class="form-control enq-txtbx-pd fnt12 mb-0 enq-dropdown mt-5">' +
                    '<option>Employee</option>' +
                    '<option>Vehicle</option>' +
                    '<option>Company</option>' +
                    '<option>Certificates</option>' +
                '</select>' +
            '</div>' +
        '</td>').appendTo(doc);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(doc);


        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<div class="checkbox text-xs-left enq-txtbx-pd fnt12 mb-0">' +
                    '<input type="checkbox" id="chk_si'+inccount+'">' +
                    '<label for="chk_si' + inccount + '" class="p-0"></label>' +
                '</div>' +
            '</div>' +
        '</td>').appendTo(doc);

        $('<td>' +
           ' <div class="form-group input-group mb-0">' +
                '<select class="form-control enq-txtbx-pd fnt12 mb-0 enq-dropdown mt-5">' +
                    '<option>Employee 1</option>' +
                    '<option>Employee 2</option>' +
                    '<option>Employee 3</option>' +
                   ' <option>Employee 1</option>' +
                    '<option>Employee 2</option>' +
                    '<option>Employee 3</option>' +
                '</select>' +
            '</div>' +
       ' </td>').appendTo(doc);

        $('<td>' +
           ' <div class="form-group input-group mb-0">' +
                '<select class="form-control enq-txtbx-pd fnt12 mb-0 enq-dropdown mt-5">' +
                    '<option>Employee 1</option>' +
                    '<option>Employee 2</option>' +
                    '<option>Employee 3</option>' +
                   ' <option>Employee 1</option>' +
                    '<option>Employee 2</option>' +
                    '<option>Employee 3</option>' +
                '</select>' +
            '</div>' +
       ' </td>').appendTo(doc);

        $('<td>' +
           ' <div class="form-group input-group mb-0">' +
                '<select class="form-control enq-txtbx-pd fnt12 mb-0 enq-dropdown mt-5">' +
                    '<option>Employee 1</option>' +
                    '<option>Employee 2</option>' +
                    '<option>Employee 3</option>' +
                   ' <option>Employee 1</option>' +
                    '<option>Employee 2</option>' +
                    '<option>Employee 3</option>' +
                '</select>' +
            '</div>' +
       ' </td>').appendTo(doc);

        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="number" class="form-control text-xs-left enq-txtbx-pd fnt12 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(doc);

        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="number" class="form-control text-xs-left enq-txtbx-pd fnt12 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(doc);

        $('<td>' +
            '<div class="form-group input-group mb-0">' +
                '<input type="number" class="form-control text-xs-left enq-txtbx-pd fnt12 mt-5" value="" />' +
            '</div>' +
        '</td>').appendTo(doc);

        $('<td>' +
            '<div class="col-del pl-5">' +
                '<div class="form-group input-group mb-0">' +
                    '<a href="javascript:void(0);" class="btn btn-default btn-xs item_delete">' +
                        '<i class="fa fa-trash"></i>' +
                    '</a>' +
                '</div>' +
            '</div>' +
           '</td>').appendTo(doc);



        $(".tabledoc tbody").append(doc);
        $('.select2').select2();
        $(doc).find(".item_delete").click(function () {
            self.delete(doc);
            return false;
        });
    },
    delete: function (doc) {
        $(doc).remove();
    }
}


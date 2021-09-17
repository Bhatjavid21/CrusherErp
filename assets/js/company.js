$(function () {
    "use strict";
    var trcount = 0;

    //create doc items on click
    $.dvsitems = {
        /* CREATE ITEM */
        create: function () {
            var self = this;
            trcount = trcount + 1;

            var item = $('<div class="row"></div>');


            $('<div class="col-md-4">' +
                ' <div class="form-group mb-0">' +
                    ' <label class="mb-0" for="exampleInputEmail1">Division Name</label><small class="danger"> *</small>' +
                        ' <input autofocus="" placeholder="" type="text" class="form-control enq-txtbx-pd fnt12 mb-5" value="" autocomplete="off">' +
                '</div>' +
            '</div>').appendTo(item);

            $('<div class="col-md-4">' +
                ' <div class="form-group mb-0">' +
                    ' <label class="mb-0" for="exampleInputEmail1">Document Code</label><small class="danger"> *</small>' +
                        ' <input autofocus="" placeholder="" type="text" class="form-control enq-txtbx-pd fnt12 mb-5" value="" autocomplete="off">' +
                '</div>' +
            '</div>').appendTo(item);

            $('<div class="col-md-3">' +
                ' <div class="form-group mb-0">' +
                    ' <label class="mb-0" for="exampleInputEmail1">Account Code</label><small class="danger"> *</small>' +
                        ' <input type="text" class="form-control fnt12 enq-txtbx-pd mb-5"  placeholder="">' +
                '</div>' +
            '</div>').appendTo(item);


            $('<div class="col-md-1">' +
                ' <div class="form-group mb-0">' +
                    ' <label class="mb-0" for="exampleInputEmail1">&nbsp;</label><br>' +                        
                        ' <a href="javascript:void(0);" class="item_delete"><i class="fa fa-trash text-danger fnt16"></i></a>' +
                '</div>' +
            '</div>').appendTo(item);

            $(".dvsrows1").append(item);

            $(item).find(".item_delete").click(function () {
                self.delete(item);
                return false;
            });

        },
        /* DELETE ITEM */
        delete: function (item) {
            trcount = trcount -= 1;
            $(item).remove();
        },
    }


    //create doc items on click
    $.dvsitems = {
        /* CREATE ITEM */
        create: function (divname) {
            var self = this;
            trcount = trcount + 1;
            var item = $('<div class="row"></div>');

            $('<div class="col-md-4">' +
                ' <div class="form-group mb-0">' +
                    ' <label class="mb-0" for="exampleInputEmail1">Division Name</label><small class="danger"> *</small>' +
                        ' <input autofocus="" placeholder="" type="text" class="form-control enq-txtbx-pd fnt12 mb-5" value="" autocomplete="off">' +
                '</div>' +
            '</div>').appendTo(item);

            $('<div class="col-md-4">' +
                ' <div class="form-group mb-0">' +
                    ' <label class="mb-0" for="exampleInputEmail1">Document Code</label><small class="danger"> *</small>' +
                        ' <input autofocus="" placeholder="" type="text" class="form-control enq-txtbx-pd fnt12 mb-5" value="" autocomplete="off">' +
                '</div>' +
            '</div>').appendTo(item);

            $('<div class="col-md-3">' +
                ' <div class="form-group mb-0">' +
                    ' <label class="mb-0" for="exampleInputEmail1">Account Code</label><small class="danger"> *</small>' +
                        ' <input type="text" class="form-control fnt12 enq-txtbx-pd mb-5"  placeholder="">' +
                '</div>' +
            '</div>').appendTo(item);


            $('<div class="col-md-1">' +
                ' <div class="form-group mb-0">' +
                    ' <label class="mb-0" for="exampleInputEmail1">&nbsp;</label><br>' +                        
                        ' <a href="javascript:void(0);" class="item_delete"><i class="fa fa-trash text-danger fnt16"></i></a>' +
                '</div>' +
            '</div>').appendTo(item);

            $("." + divname).append(item);

            $(item).find(".item_delete").click(function () {
                self.delete(item);
                return false;
            });

        },
        /* DELETE ITEM */
        delete: function (item) {
            trcount = trcount -= 1;
            $(item).remove();
        },
    }

    

    $('.add-dvs1').click(function () {
        $.dvsitems.create("dvsrows1");
    });
    $('.add-dvs2').click(function () {
        $.dvsitems.create("dvsrows2");
    });
    $('.add-dvs3').click(function () {
        $.dvsitems.create("dvsrows3");
    });

    $('#branch1').click(function () {
        ($(this).attr("data-send") == false)?$.dvsitems.create("dvsrows1"):"";
    });
    $('#branch2').click(function () {
        ($(this).attr("data-send") == false) ? $.dvsitems.create("dvsrows2") : "";
    });
    $('#branch3').click(function () {
        ($(this).attr("data-send") == false) ? $.dvsitems.create("dvsrows3") : "";
    });


    $.dvsitems.create("dvsrows1");

});
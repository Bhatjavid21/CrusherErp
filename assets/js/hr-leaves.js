$(function () {
    "use strict";
    var inccount = 0;
    $('.select2').select2();
    $('.dtleave').daterangepicker();

    $("body").tooltip({
        selector: '[data-toggle="tooltip"]'
    });

    $('.clockpicker').clockpicker({
        donetext: 'Done',
    }).find('input').change(function () {
        console.log(this.value);
    });

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


    $(document).on("click", ".rdapp", function (e) {
        var dataid = $(this).attr("data-id");
        var rdapply = $(this).attr("id");
        rdapply = rdapply.replace(dataid, "");
        if (rdapply == "chkoth") {
            ($(".trloth" + dataid).hasClass('hide')) ? $(".trloth" + dataid).removeClass("hide") : "";
            ($(".hidcol2").hasClass('hide')) ? $(".hidcol2" + dataid).addClass("hide") : $(".hidcol2" + dataid).removeClass("hide");
            $(".hidcol1").removeClass("hide");
        }
        else {
            ($(".trloth" + dataid).hasClass('hide')) ? $(".trloth" + dataid).addClass("hide") : $(".trloth" + dataid).removeClass("hide");
            ($(".hidcol2").hasClass('hide')) ? $(".hidcol2" + dataid).addClass("hide") : $(".hidcol2" + dataid).removeClass("hide");
            $(".hidcol1").addClass("hide");
        }

    });

    var radcount = 0;
    $('.grpleave').each(function (index) {
        if (radcount == 0) {
            $(this).addClass("leave-left-border");
        }
        if (radcount == 2) {
            $(this).addClass("leave-right-border");
        }
        radcount += 1;
    });


    var radcount = 0;
    $('.grp2').each(function (index) {
        if ((index % 2)== 0) {
            $(this).addClass("leave-left-border");
        } else if ((index % 2)==1) {
            $(this).addClass("leave-right-border");
        }
        radcount += 1;
    });

    var radcount = 0;
    $('.grp3').each(function (index) {
        if ((index % 3) == 0) {
            $(this).addClass("leave-left-border");
        } else if ((index % 3) == 2) {
            $(this).addClass("leave-right-border");
        }
        radcount += 1;
    });
   
    $(document).on("click", ".btn-add-ldoc", function (e) {
        inccount += 1;
        $.ldoc.create(inccount);
    });
    
    $.ldoc.create(inccount);
});



$.ldoc = {
    create: function (inccount) {
        var self = this;
        var ldoc = $('<tr class="item"></tr>');

        $('<td>' +
            '<div class="form-group input-group mb-0 ml-0">' +
                '<input type="text" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value="" />' +
            '</div>' +
            '</td>').appendTo(ldoc);


        $('<td>' +
            '<div class="form-group input-group mb-0 col-md-6 pl-0">' +
                '<input type="file" class="form-control text-xs-left enq-txtbx-pd fnt12 mb-0" value="" />' +
            '</div>' +
       ' </td>').appendTo(ldoc);



        $('<td class="float-right">' +
            '<div class="col-del pl-5">' +
                '<div class="form-group input-group mb-0">' +
                    '<a href="javascript:void(0);" class="btn btn-default btn-xs item_delete">' +
                        '<i class="fa fa-trash"></i>' +
                    '</a>' +
                '</div>' +
            '</div>' +
           '</td>').appendTo(ldoc);


        $(".tblldoc tbody").append(ldoc);

        $(ldoc).find(".item_delete").click(function () {
            self.delete(ldoc);
            return false;
        });
    },
    delete: function (ldoc) {
        $(ldoc).remove();
    }

}

leavepopulatedate = function (self) {
    var rdleave = self.attr("id");
    var dataid = self.attr("data-id");
    rdleave = rdleave.replace(dataid, "");

    if (rdleave == "rdfull" || rdleave == "rdhalf") {
        $("#dtleave" + dataid).addClass("hide");
        $("#dtfull" + dataid).removeClass("hide");
    }
    if (rdleave == "rdmany") {
        $("#dtleave" + dataid).removeClass("hide");
        $("#dtfull" + dataid).addClass("hide");
    }

    if (self.attr("name") == "grpentry") {
        if (self.attr("data-label") == "Yes") {
            ($(".trloth" + dataid).hasClass('hide')) ? $(".trloth" + dataid).removeClass("hide") : "";
            ($(".hidcol1").hasClass('hide')) ? $(".hidcol1" + dataid).addClass("hide") : $(".hidcol1" + dataid).removeClass("hide");
            $(".hidcol2").removeClass("hide");
        }
        else {
            ($(".trloth" + dataid).hasClass('hide')) ? $(".trloth" + dataid).addClass("hide") : $(".trloth" + dataid).removeClass("hide");
            ($(".hidcol1").hasClass('hide')) ? $(".hidcol1" + dataid).addClass("hide") : $(".hidcol1" + dataid).removeClass("hide");
            $(".hidcol2").addClass("hide");
        }
    }

   

}
'use strict';
$(document).ready(function () {
    var inccount = 0;
    var updateOutput = function (e) {

        var elementid = $(this).attr("id");
        
        var list = e.length ? e : $(e.target), output = list.data('output');
        if (window.JSON) {
            output.val(window.JSON.stringify(list.nestable('serialize')));

            if (inccount != 0) {
                var item = $('<ol class="dd-list"></ol>');
                $.each($.parseJSON(window.JSON.stringify(list.nestable('serialize'))), function (key, value) {
                    if (typeof (value.id) != 'undefined') {
                        //alert("element id is " + elementid);
                        value.mode = "child";
                        //alert("id is " + value.id + " mode is " + value.mode + " value is " + value.id);

                        $('<li class="dd-item dd-item-child" data-id="' + value.id + '" data-mode="child" data-division="' + elementid + '">' +
                            '<div class="lstborder">' +
                                '<div class="dd-handle dd-handle-child float-left">Mohammad Bin Salman Bin Abdullah ' + value.id + '</div>' +
                                '<div class="dd-rt-side float-right">' +
                                    '<select class="form-control enq-txtbx-pd slc-nst float-left mr-15">' +
                                        ' <option>Sales Manager</option>' +
                                        ' <option>Assitant Manager</option>' +
                                        ' <option>HR Admin</option>' +
                                    '</select>' +
                                    '<div class="checkbox text-xs-left enq-txtbx-pd mb-0">' +
                                        ' <input type="checkbox" id="chk_si' + value.id + '" data-toggle="tooltip" data-original-title="Default Division">' +
                                        ' <label for="chk_si' + value.id + '" class="p-0 chk-nst"></label>' +
                                        ' <i class="fa fa-trash text-danger ml-5 fnt16 float-right"></i>' +
                                    ' </div>' +                                
                                '</div>' +
                            '</div>' +
                        '</li>').appendTo(item);
                        $("#" + elementid).html(item);

                    }
                });
            }
            inccount += 1;

        } else {
            output.val('JSON browser support required for this demo.');
        }
    };


    $('#nestable').on('change', function () {
        inccount = 0;
    });
    $('.nestable').on('change', updateOutput);
    updateOutput($('.nestable').data('output', $('.nestable-output')));




    //$('#nestable').nestable({ group: 1 }).on('change', updateOutput);
    //$('#nestable2').nestable({ group: 1 }).on('change', updateOutput);
    //$('#color-nestable').nestable({ group: 1 }).on('change', updateOutput);
    //updateOutput($('#nestable').data('output', $('#nestable-output')));
    //updateOutput($('#nestable2').data('output', $('#nestable2-output')));
    //updateOutput($('#color-nestable').data('output', $('#color-nestable-output')));



    $('#nestable-menu').on('click', function (e) {
        var target = $(e.target), action = target.data('action'); if (action === 'expand-all') { $('.dd').nestable('expandAll'); }
        if (action === 'collapse-all') { $('.dd').nestable('collapseAll'); }
    });
    $('#nestable3').nestable();
});
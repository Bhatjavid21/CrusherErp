$(function () {
    "use strict";
    $('.select2').select2();

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
    
    

    $('#collapsed').jstree({
        'core': { 'themes': { 'responsive': false } },
        'types': {
            'default': { 'icon': 'icofont icofont-folder' },
            'file': { 'icon': 'icofont icofont-file-alt' }
        }, 'plugins': ['types']
    });
    $('#expanded').jstree({
        'core': { 'themes': { 'responsive': false } },
        'types': {
            'default': { 'icon': 'icofont icofont-folder' },
            'file': { 'icon': 'icofont icofont-file-alt' }
        }, 'plugins': ['types']
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
    var rdleave = self.attr("id");
    var dataid = self.attr("data-id");
    rdleave = rdleave.replace(dataid, "");

    if (self.attr("name") == "grptree") {
        if (self.attr("data-label") == "Collapsed") {
            if ($("#collapsed").hasClass('hide') == true)
            {
                $("#expanded").addClass("hide");
                $("#collapsed").removeClass("hide");
            }
        }
        else {
            if ($("#expanded").hasClass('hide') == true) {
                $("#collapsed").addClass("hide");
                $("#expanded").removeClass("hide");
            }
        }
    }

    

}


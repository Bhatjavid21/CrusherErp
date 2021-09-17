function icheckfirstinit() {
    

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

    
};

$(document).ready(function () {
    //icheckfirstinit();
    
});
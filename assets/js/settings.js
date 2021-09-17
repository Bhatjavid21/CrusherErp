$(function () {
    "use strict";


    $('#dtsettings').DataTable( {
    'paging':true,"pageLength": 100,'lengthChange': true,'searching':true,'ordering':true,'info':true,'autoWidth':false, } );

    var open_tab = "settings_general";
    var nav_height = $('.tabbable > .nav-tabs').innerHeight();

    $('.tabbable a.nav-link').on('shown.bs.tab', function (e) {
      var content_height = $('.tabbable > .tab-content').outerHeight();
      var height = $('.tabbable').innerHeight();
      height = Math.max(500, nav_height, content_height);
      $('.tabbable > .nav-tabs').innerHeight(height+15);
      $('.tabbable > .nav-tabs').css("display","table-cell");
      $('.left-block').innerHeight(height+15);
    });

    $('.tabbable a[href="#'+open_tab+'"]').tab('show');


    //Enable iCheck plugin for checkboxes
    //iCheck for checkbox and radio inputs
    $('.media-list input[type="checkbox"]').iCheck({
      checkboxClass: 'icheckbox_flat-blue',
      radioClass: 'iradio_flat-blue'
    });

    //Enable check and uncheck all functionality
    $(".checkbox-toggle").click(function () {
      var clicks = $(this).data('clicks');
      if (clicks) {
      //Uncheck all checkboxes
      $(".media-list input[type='checkbox']").iCheck("uncheck");
      $(".ion", this).removeClass("ion-android-checkbox-outline").addClass('ion-android-checkbox-outline-blank');
      } else {
      //Check all checkboxes
      $(".media-list input[type='checkbox']").iCheck("check");
      $(".ion", this).removeClass("ion-android-checkbox-outline-blank").addClass('ion-android-checkbox-outline');
      }
      $(this).data("clicks", !clicks);
    });
    
    //Handle starring for glyphicon and font awesome
    $(".app-contact-star").click(function (e) {
      e.preventDefault();
      //detect type
      var $this = $(this).find("a > i");
      var glyph = $this.hasClass("glyphicon");
      var fa = $this.hasClass("fa");

      //Switch states
      if (glyph) {
      $this.toggleClass("glyphicon-star");
      $this.toggleClass("glyphicon-star-empty");
      }

      if (fa) {
      $this.toggleClass("fa-star");
      $this.toggleClass("fa-star-o");
      }
    });

   

    
});
function calltoast(msg, msgtype)
{
  $.toast({
    heading: '',
    text: msg,
    position: 'top-right',
    loaderBg: '#ff6849',
    icon: msgtype,
    hideAfter: 3000,
    stack: 6
  }); 
}
$(document).ready(function () {

   // $('.select2').select2();
    var base_url = $("#baseurl").val();
    var itemslist_table;


    //Add Item Modal Popup
    $(document).on("click", ".additemlist", function (e) {
        var url = "add-items.aspx";
        $.easyBlockUI("body");
        $.ajaxModal('.modal', url);
        $(".modal .modal-title").text("Add Item");
        $.unblockUI();
    });
});
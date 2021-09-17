$(document).ready(function () {

    $('#datepicker-inline').datepicker({
        todayHighlight: true,
        showWeekDays: false,
    });

    Bind_Shift_Allocations_List();
});

function Bind_Shift_Allocations_List() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "shift-allocation-report.aspx/Get_Shift_Allocation_Report",
        data: "{'selectedYearAndMonth':'" + $(".datepicker-switch").text().replace(" ", "-") + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    var shiftRows = data.d.split("~");
                    var rowValues = "", html = "";

                    for (var i = 0; i < shiftRows.length - 1; i++) {
                        rowValues = shiftRows[i].split("^");

                        html += "<tr>"
                            + "<td>" + rowValues[0] + "</td>"
                            + "<td>" + rowValues[1] + "</td>"
                            + "<td>" + rowValues[2] + "</td>"
                            + "<td>" + rowValues[3] + "</td>"
                            + "<td>" + rowValues[4] + "</td>"
                            + "</tr>";
                    }
                    $("#tbody_Shift_Allocation").html(html);
                }
            }
            else {
                $("#tbody_Shift_Allocation").html("<tr><td colspan='5' class='text-center'>No record found</td></tr>");
            }
        }
    });
}

function calltoast(msg, msgtype) {
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
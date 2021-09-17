$(document).ready(function () {

    $('.select2').select2();

    $(document).on("change", "#ddl_Employees", function () {
        Bind_Leave_Balance_List();
    });

    $(document).on("keyup", "#txt_Emp_Number", function () {

        var empNo = $("#txt_Emp_Number").val();

        $("#tbody_Leave_Balance_List tr").each(function () {
            var found = 'false';

            $(this).each(function () {
                if ($(this).text().toLocaleLowerCase().indexOf(empNo.toLocaleLowerCase()) >= 0) {
                    found = 'true';
                }
            });

            if (found == 'true') {
                $(this).show();
            }
            else {
                $(this).hide();
            }
        });
    });

    Bind_Leave_Balance_List();
});

function Bind_Leave_Balance_List() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "leave-gratuity-balance-report.aspx/Get_Leave_Balance_List",
        data: "{'employee_id':'" + $("#ddl_Employees").val() + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    var rows = data.d.split("~"), rowValues = "", html = "";

                    for (var i = 0; i < rows.length - 1; i++) {
                        rowValues = rows[i].split("^");

                        html += "<tr>"
                            + "<td>" + rowValues[0] + "</td>"
                            + "<td>" + rowValues[1] + "</td>"
                            + "<td>" + rowValues[2] + "</td>"
                            + "<td>" + rowValues[3] + "</td>"
                            + "<td>" + rowValues[4] + "</td>"
                            + "<td>" + rowValues[5] + "</td>"
                            + "<td>" + rowValues[6] + "</td>"
                            + "<td>" + formatNumberInCurrency(rowValues[7]) + "</td>"
                            + "<td>" + rowValues[8] + "</td>"
                            + "<td>" + rowValues[9] + "</td>"
                            + "<td>" + rowValues[10] + "</td>"
                            + "<td>" + rowValues[11] + "</td>"
                            + "<td>" + rowValues[12] + "</td>"
                            + "<td>" + formatNumberInCurrency(rowValues[13]) + "</td>"
                            + "<td>" + rowValues[14] + "</td>"
                            + "</tr>";
                    }

                    $("#tbody_Leave_Balance_List").html(html);
                }
            }
            else {
                $("#tbody_Leave_Balance_List").html("<tr><td colspan='15' class='text-center'>No record found</td></tr>");
            }
        }
    });
}

function Generate_Leave_Balance_Excel() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "leave-gratuity-balance-report.aspx/generateLeaveBalanceDataIntoExcel",
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    window.open("Leave_Balance_Reports/" + data.d);
                }
            }
            else {
                calltoast("No record found", "error");
            }
        }
    });
}

function formatNumberInCurrency(num) {
    //return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');

    const formatter = new Intl.NumberFormat('en-US', {
        style: 'decimal',
        currency: 'INR',
        // minimumFractionDigits: 2
    });

    //num = num.replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '');

    var FormattedNo = (formatter.format(num));
    return FormattedNo;
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
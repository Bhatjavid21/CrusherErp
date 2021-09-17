$(document).ready(function () {

    $('.dtVoucherDate').daterangepicker();

    $(document).on("click", ".applyBtn", function () {
        Bind_Equipment_Expense_Report();
    });

    $(document).on("keyup", "#txtSearch", function () {

        var searchValue = $("#txtSearch").val();

        $("#tbody_Equipment_Expense_Report tr").each(function () {
            var found = 'false';

            $(this).each(function () {
                if ($(this).text().toLocaleLowerCase().indexOf(searchValue.toLocaleLowerCase()) >= 0) {
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

    Bind_Equipment_Expense_Report();
});

function Bind_Equipment_Expense_Report() {

    var fromDate = $("#txtVoucherDate").val().split(" - ")[0];
    var toDate = $("#txtVoucherDate").val().split(" - ")[1];

    var lnk = 'H_Equipment_Expense.ashx?fun=Get_Equipment_Expense_Report&From_Date=' + fromDate + '&To_Date=' + toDate;
    var xhReq = new XMLHttpRequest();
    xhReq.open('GET', lnk, true);
    xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhReq.send('');
    xhReq.onreadystatechange = function () {

        //readyState 4 means that it is in return value state
        if (xhReq.readyState == 4) {
            var r = xhReq.responseText;
            if (Chk_Res(r) == false) {

                if (r.length > 0) {
                    var rows = r.split("~"), rowValues = "", html = "";

                    for (var i = 0; i < rows.length - 1; i++) {
                        rowValues = rows[i].split("^");

                        html += "<tr>"
                            + "<td>" + rowValues[0] + "</td>"
                            + "<td>" + rowValues[1] + "</td>"
                            + "<td>" + rowValues[2] + "</td>"
                            + "<td>" + rowValues[3] + "</td>"
                            + "<td>" + formatNumberInCurrency(rowValues[4]) + "</td>"
                            + "<td>" + rowValues[5] + "</td>"
                            + "<td>" + rowValues[6] + "</td>"
                            + "<td>" + rowValues[7] + "</td>"
                            + "</tr>";
                    }

                    $("#tbody_Equipment_Expense_Report").html(html);
                }
            }
            else {
                $("#tbody_Equipment_Expense_Report").html("<tr><td colspan='8' class='text-center'>No record found</td></tr>");
            }
        }
    }
}

function Export_To_Excel() {

    var fromDate = $("#txtVoucherDate").val().split(" - ")[0];
    var toDate = $("#txtVoucherDate").val().split(" - ")[1];

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "equipment-expense-report.aspx/generateDataIntoExcel",
        data: "{'From_Date':'" + fromDate + "','To_Date':'" + toDate + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    window.open("Equipment_Expense_Reports/" + data.d);
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
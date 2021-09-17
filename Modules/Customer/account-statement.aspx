<%@ Page Language="C#" AutoEventWireup="true" CodeFile="account-statement.aspx.cs" Inherits="Modules_Account_Statement_account_statement" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="<%=G.B%>assets/images/favicon.ico">
    <title>SUS ERP - Account Statement Print</title>
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">

    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">

    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css">
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
    <link href="<%=G.B%>assets/css/print.css" rel="stylesheet">

    <style>
        .table > tbody > tr > td, .table > tfoot > tr > td {
            padding: 3px 5px !important;
        }

        .table > thead > tr > th {
            padding: 10px 6px !important;
            font-size: 12px !important;
        }

        


    </style>
</head>
<body class="hold-transition skin-info-light fixed sidebar-mini">
    <form runat="server">
        <input type="hidden" id="HtmlContent" value="" runat="server" />
        <input type="hidden" id="FileNameField" runat="server" />
        <div id="wrap_invoice" class="page A4 portrait delnote-mh">
            <%-- <header class="invoice_header etat_header">
                <div class="row model1">--%>
            <table class="" style="width: 100%">
                <tbody >
                    <tr>
                      
                        <td colspan="8"  style="font-size: 16px !important;text-align:center">
                            <b>ACCOUNT STATEMENT</b>
                    </tr>
                    <tr>
                         <td colspan="4"   id="Tdcompny">
                        </td>
                        <td colspan="4"> <b>Date :</b>
                         <label id="lbldatetime"></label><br /> <b>Phone:</b>
                            <label id="lblphone"></label><br /><b>Fax:</b>
                            <label id="lblfax"></label></td>
                    </tr>

                 
                    <tr>
                        <td colspan="4"></td>
                        <td colspan="4">
                             <b>Tax Registration No.:</b>
                            <label id="lblTRNo"></label>
                        </td>
                    </tr>
                   <br />
                    <tr>
                        <td colspan="4" rowspan="5" id="CusAddress">
        
                        </td>
                        <td colspan="4"><b>Customer Account:</b>
                            <label id="lblcustomeraccount"></label>
                        </td>

                    </tr>
                    <tr>
                        <td colspan="4">
                            <b>Terms of Payment:</b>
                            <label id="lbltermsofpayment"> 30 Days</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <b>Currency:</b>
                            <label id="lblcurrency">AED</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <b>From Date:</b>
                            <label id="lblfromdate"></label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <b>To Date:</b>
                            <label id="lbltodate"></label>
                        </td>
                    </tr>



                    <tr>
                        <td colspan="9">[[[<asp:LinkButton ID="btnback" PostBackUrl="~/Modules/Customer/Customer-List.aspx" CssClass="btn btn-success" runat="server" Text="Back" />]]]
                        </td>


                        <td colspan="9">(((<asp:Button ID="BtnGenerate" CssClass="btn btn-success right" runat="server" Text="Generate Pdf" onclick="Button2_Click" />)))

                        </td>
                        <td colspan="9">@@@ <span id="span_excel">
                                    <a href="#" id="btn_Download_Leave" class="btn btn-success right" title="Export To Excel" onclick="Excel_Data()"><i class="fa fa-download"></i></a>
                                </span>$$$

                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
            <br />
            <table class="table table-bordered table-striped" border="1" id="tblAccountStatementpdf" >
                <thead >
                    <tr> 
                        <th bgcolor="#eee" style="text-align:center;">Date</th>
                        <th bgcolor="#eee" style="text-align:center;">Invoice</th>
                       
                        <th bgcolor="#eee" style="text-align:center;">Due</th>
                        <%--<th>Currency</th>--%>
                        <th bgcolor="#eee" style="text-align:center;">Debit</th>
                        <th bgcolor="#eee" style="text-align:center;">Credit</th>
                        <th bgcolor="#eee" style="text-align:center;">Balance</th>

                    </tr>
                </thead>
                <tbody id="tblAccountStatementbody">
                    <tr>
                        <td colspan="3" style="text-align: right; font-size: 11px"><b>Opening </b></td>

                        <td>
                            <label id="lblBCurrency">AED</label>
                        </td>
                        <td>
                            <label id="lblBDebit">0.00</label>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>

               <%-- <tfoot>
                    <tr>
                        <td colspan="2" style="text-align: right; font-size: 11px"><b>Closing </b></td>

                        <td>
                            <label id="lblFCurrency">AED</label>
                        </td>
                        <td>
                            <label id="lblFDebit">1,23,000</label>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>

                </tfoot>--%>
            </table>
            <br/>
            <h4>Age Analysis</h4>
            <table class="table table-bordered table-striped" border="1" id="tblAgingAndAnalysis" style="width: 100%; color: #383838 !important; font-size: 12px !important; font-family: Calibri, 'Nunito Sans', sans-serif !important; border: 1px solid #dee2e6 !important;">
                <thead>
                <tr>
                  <th bgcolor="#eee"></th>

                    <th bgcolor="#eee" style="text-align:center;">Total</th>
                    <th bgcolor="#eee" style="text-align:center;">Current</th>
                    <th bgcolor="#eee" style="text-align:center;">1 month </th>
                    <th bgcolor="#eee" style="text-align:center;">2 months </th>
                    <th bgcolor="#eee" style="text-align:center;">3 months </th>
                    <th bgcolor="#eee" style="text-align:center;">+3 months</th>


                </tr>
                    </thead>
                <tbody id="Ageing"></tbody>
              <tfoot>
                  <tr>
                      <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;'> Amount in Words :</td>
                      <td colspan="6" id="AmountInWords" style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;'>
                       
                    </td>
                     
                </tr>
                 
              </tfoot>
            </table>
           
            <br/>
             <br/> <br/> 
            <table>
                <tr> <td colspan="8" style="align-content:center"> <img src="" id="ImgFooter"  alt="Al-Moherbie"></td></tr>
               
                <tr>
                    <td colspan="8" >
                        
                      
                    </td>
                </tr>
            </table>
            <%--</div>

            </header>--%>
        </div>
    </form>

    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <script src="../General/libo.js"></script>

    <script>
        $(document).ready(function () {
            if (window.location.search.includes('?')) {

                var urlParams = new URLSearchParams(window.location.search);
                CustomeId = urlParams.get('Cus_id');
                var btDate = urlParams.get('Date');
                var DivId = urlParams.get('DivId');

                GetMetaData(CustomeId, btDate, DivId)
              
               
                

            }
        });

        function Excel_Data() {
           

            var urlParams = new URLSearchParams(window.location.search);
            var  CustomerId = urlParams.get('Cus_id');
            var btDate = urlParams.get('Date');
            var DivId = urlParams.get('DivId');
            //alert(CustomeId)
            $.ajax({
                url: 'H_tbl_Customer.ashx',
                type: "POST",
                data: {
                    'fun': 'ExportExcelSOA', 'CustomerId': CustomerId, 'date': btDate
                },
                success: function (data) {
                    if (Chk_Res(data.errorMessage) == false) {
                        if (data.indexOf("!error!") > -1) {
                            alert("Something Went Wrong..\n\n" + data);
                        }
                        else if (data.toString() == 'no recoed found')
                        {
                            alert('No data Found')
                        }
                        else {
                               window.open("AccountStatements/" + data);
                             }
                    }
                }
            });



        }

        function GetMetaData(CustomerId, btDate, division_Id) {
           
            $.ajax({
                url: 'H_tbl_Customer.ashx',
                type: "POST",
                data: {
                    'fun': 'GetMatadataforPdf', 'CustomerId': CustomerId, 'division_Id': division_Id
                },
                success: function (data) {
                    if (Chk_Res(data.errorMessage) == false) {
                        var arr = data.split('|');
                        var imgsrc = "";
                        var CompaneyData = JSON.parse(arr[0]);
                        var CustomerData = "";
                        if (arr[1] != "") {
                            CustomerData = JSON.parse(arr[1]);
                        }
                        if (division_Id == 129) {
                            imgsrc = arr[2] + 'assets/images/Transport.png'
                        }
                        else {
                            imgsrc = arr[2] + 'assets/images/Freight.png'
                        }
                        $('#ImgFooter').attr('src', imgsrc);
                        $.each(CompaneyData, function (i, obj) {

                            SetInnerVal("Tdcompny", " <b> " + obj.Company_Name + "<br />" + obj.Address + "</b >")
                          //  SetInnerVal("tdCompnyAddress", " <b> " + obj.Address + "</b>")
                            
                            $('#lbldatetime').text(SetTodaysDateLabel());
                            $('#lblphone').text(obj.Phone_Number);
                            $('#lblfax').text("");
                            $('#lblTRNo').text(obj.VAT_Number);
                        });

                        $.each(CustomerData, function (i, obj) {

                            SetInnerVal("CusAddress", " <b> " + obj.Cus_Company_Name + " <br /> " + obj.Address + "    </b>");
                            $('#FileNameField').val("Stament Of Account of " + obj.Cus_Company_Name) 
                            $('#lblcustomeraccount').text(obj.Account_Code )
                            $('#lbltermsofpayment').text(obj.Credit_Days +' Days')
                        });
                        var arrdt = btDate.split("-");
                        $('#lblfromdate').text(arrdt[0].toString());
                        $('#lbltodate').text(arrdt[1].toString());
                        GetAccountData(CustomerId, btDate);
                        GetAgingAnalysisData(CustomerId, btDate);
                    }
                }
        });
        }
        function GetAccountData(CustomerId, btDate) {
            $('#tblAccountStatementbody').empty();
            $.ajax({
                url: 'H_tbl_Customer.ashx',
                type: "POST",
                data: {
                    'fun': 'GetAccountData', 'CustomerId': CustomerId, 'date': btDate
                },
                success: function (data) {
                    if (Chk_Res(data.errorMessage) == false) {
                        if (data.toString() != "") {
                            var AccountData = JSON.parse(data);

                            $.each(AccountData, function (i, obj) {
                                if (i==20 ){
                                    $('#tblAccountStatementbody').append($("<tr>  <th bgcolor='#eee' style='text-align:center;'>Date</th> "
                                        + "<th bgcolor ='#eee' style='text-align:center;'> Invoice</th > "
                                        + "<th bgcolor='#eee' style='text-align:center;'>Due</th>"
                                        +"<th bgcolor='#eee' style='text-align:center;'>Debit</th>"
                                        +" <th bgcolor='#eee' style='text-align:center;'>Credit</th>"
                                        +" <th bgcolor='#eee' style='text-align:center;'>Balance</th> </tr >"))
                                
                                }
                                if (i > 20 && (i+12)%32==0) {
                                    $('#tblAccountStatementbody').append($("<tr>  <th bgcolor='#eee' style='text-align:center;'>Date</th> "
                                        + "<th bgcolor ='#eee' style='text-align:center;'> Invoice</th > "
                                        + "<th bgcolor='#eee' style='text-align:center;'>Due</th>"
                                        + "<th bgcolor='#eee' style='text-align:center;'>Debit</th>"
                                        + " <th bgcolor='#eee' style='text-align:center;' >Credit</th>"
                                        + " <th bgcolor='#eee' style='text-align:center;'>Balance</th> </tr >"))

                                }
                                $('#tblAccountStatementbody').append($("<tr>  <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + DateFormat(obj.Invoice_date) + "</td> "
                                    + "<td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'> " + obj.Invoice_Number + "</td > "
                                    + "<td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;' >" + DateFormat(obj.Due_Date) + "</td>"
                                    + " <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + MoneyFormatter(obj.debit) + "</td>"
                                    + " <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + MoneyFormatter(obj.credit) + "</td> "
                                    + "<td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'> " + MoneyFormatter(obj.balance) + "</td>    </tr > "))
                            });
                        } else {
                            $('#tblAccountStatementbody').append($("<tr>  <td colspan='6' style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;'> No Records Found </td>   </tr>"))
                        }
                    }

                }
            });
        }

        function GetAgingAnalysisData(CustomerId, btDate) {
            $('#Ageing').empty();
            $.ajax({
                url: 'H_tbl_Customer.ashx',
                type: "POST",
                data: {
                    'fun': 'GetAgingAnalysisData', 'CustomerId': CustomerId, 'date': btDate
                },
                success: function (data) {
                    if (Chk_Res(data.errorMessage) == false) {
                        if (data.toString() != "") {
                            var AccountData = JSON.parse(data);
                            var TotaloutStanding = 0;
                            var TotalOnAccount = 0;
                            $.each(AccountData, function (i, obj) {

                                if (obj.Trans_Nature.toString().trim() == "Outstanding") {
                                    TotaloutStanding += Number(obj.CLOSING_BALANCE);
                                   
                                }
                                else {
                                    TotalOnAccount += Number(obj.CLOSING_BALANCE);
                                }

                                $('#Ageing').append($("<tr>  <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + obj.Trans_Nature + "</td>"
                                    + "<td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + MoneyFormatter(obj.CLOSING_BALANCE) + "</td> "
                                    + " <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + MoneyFormatter(obj.a) + "</td> "
                                    + " <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + MoneyFormatter(obj.b) + "</td> "
                                    + " <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + MoneyFormatter(obj.c) + "</td> "
                                    + "<td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + MoneyFormatter(obj.d) + "</td> "
                                    + " <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;text-align:right;'>" + MoneyFormatter(obj.ABOVE120) + "</td>    </tr>"))
                            });
                            var ClosingAmount = TotaloutStanding - TotalOnAccount;
                            $('#Ageing').append($("<tr>  <td style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;'>  Closing : </td> "
                                + "<td colspan='6' style='padding: 10px 4px!important; border-right: 1px solid #dee2e6!important; border-bottom: 1px solid #dee2e6!important;'> " + MoneyFormatter(parseFloat(ClosingAmount).toFixed(2)) + "</td>   </tr>"))
                        } else {
                            $('#Ageing').append($("<tr>  <td colspan='6'> No Records Found </td>   </tr>"))
                        }

                        var NetAmountDecimalPart = parseFloat(ClosingAmount).toFixed(2).toString().split('.')[1];
                        //alert(NetAmountDecimalPart)
                      var  Change = " Fills";
                      var  Moneyformat = "Dirham";

                        if (typeof (NetAmountDecimalPart) == "undefined") {
                            // alert(NumInWords(NET_Amount.toFixed(2)) + Moneyformat)
                            SetInnerVal("AmountInWords",NumInWords(ClosingAmount.toFixed(2)) + Moneyformat);  //Setting values Num to Words For Pdf

                        }
                        else if (NetAmountDecimalPart.length == 1) {
                            //NetAmountDecimalPart = NetAmountDecimalPart + 0;
                            SetInnerVal("AmountInWords",NumInWords(ClosingAmount.toFixed(2)) + Moneyformat + " and " + NumInWords(NetAmountDecimalPart.toString().substring(0, 2)) + ' ' + Change);  //Setting values Num to Words For Pdf

                        }
                        else {
                               SetInnerVal("AmountInWords", NumInWords(ClosingAmount.toFixed(2)) + Moneyformat + " and " + NumInWords(NetAmountDecimalPart.toString().substring(0, 2)) + ' ' + Change);  //Setting values Num to Words For Pdf
                             }
                    }
                    var Html = $("#wrap_invoice").html()

                    $("#wrap_invoice").html($("#wrap_invoice").html().replace("[[[", "").replace("]]]", "").replace("(((", "").replace(")))", "").replace("@@@", "").replace("$$$", ""));

                    var part = Html.slice(Html.indexOf("[[["), Html.indexOf("]]]") + 3);

                    Html = Html.replace(part, "");

                    part = Html.slice(Html.indexOf("((("), Html.indexOf(")))") + 3);

                    Html = Html.replace(part, "");

                    var part = Html.slice(Html.indexOf("@@@"), Html.indexOf("$$$") + 3);

                    Html = Html.replace(part, "");
                    SetVal("HtmlContent", Html)
                }
            });
        }
        function NumInWords(number) {
             //alert(number)
            var first = ['', 'One ', 'Two ', 'Three ', 'Four ', 'Five ', 'Six ', 'Seven ', 'Eight ', 'Nine ', 'Ten ', 'Eleven ', 'Twelve ', 'Thirteen ', 'Fourteen ', 'Fifteen ', 'Sixteen ', 'Seventeen ', 'Eighteen ', 'Nineteen '];
            var tens = ['', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty ', 'Ninety '];
            var mad = ['', 'Thousand', 'Million', 'Billion', 'Trillion'];
            var word = '';

            for (var i = 0; i < mad.length; i++) {
                var tempNumber = number % (100 * Math.pow(1000, i));
                if (Math.floor(tempNumber / Math.pow(1000, i)) !== 0) {
                    if (Math.floor(tempNumber / Math.pow(1000, i)) < 20) {
                        word = first[Math.floor(tempNumber / Math.pow(1000, i))] + mad[i] + ' ' + word;
                    } else {
                        word = tens[Math.floor(tempNumber / (10 * Math.pow(1000, i)))] + '' + first[Math.floor(tempNumber / Math.pow(1000, i)) % 10] + mad[i] + ' ' + word;
                    }
                }

                tempNumber = number % (Math.pow(1000, i + 1));
                if (Math.floor(tempNumber / (100 * Math.pow(1000, i))) !== 0) word = first[Math.floor(tempNumber / (100 * Math.pow(1000, i)))] + 'Hundred ' + word;
            }
            return word;
        }

        function MoneyFormatter(Number1) {
            //taking obj.id and  obj.value as Paramater
            // alert('sdds');
            var Number = Number1.toString();
            const formatter = new Intl.NumberFormat('en-US', {
                style: 'decimal',
                currency: 'INR',
                minimumFractionDigits: 2
            })

            Number = Number.replace(',', '').replace(',', '').replace(',', '').replace(',', '').replace(',', '');

            var FormattedNo = (formatter.format(Number))
            return FormattedNo;

        }
        function SetTodaysDateLabel() {
            var date = new Date();
            Date.prototype.setDate = function () {
                var yyyy = this.getFullYear().toString();
                var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
                var dd = this.getDate().toString();
                return (dd[1] ? dd : "0" + dd[0]) + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + yyyy ; // padding
                //return dd + "-" + mm + "-" + yyyy;
            };
            return date.setDate();
        }
        function DateFormat(datestring)
        {
            var date = new Date(datestring);
            var yyyy = date.getFullYear().toString();
            var mm = (date.getMonth() + 1).toString(); // getMonth() is zero-based
            var dd = date.getDate().toString();
            return (dd[1] ? dd : "0" + dd[0]) + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + yyyy; // padding
        }
    </script>  

</body>
</html>

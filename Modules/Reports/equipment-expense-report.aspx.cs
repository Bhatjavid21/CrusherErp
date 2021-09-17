using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClosedXML.Excel;

public partial class Modules_Report_equipment_expense_report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        G.L();
    }

    #region WebMethod generateDataIntoExcel
    [System.Web.Services.WebMethod]
    public static string generateDataIntoExcel(DateTime From_Date, DateTime To_Date)
    {
        string sql = "", fileName = "";

        try
        {
            if (G.HL() == true)
            {
                #region Get_Data
                sql = "select Document_Number, Voucher_Date as Payment_date, b.account_code, Ledger_Account_Name, b.Debit as Amount, replace(b.Remarks,'%20',' ') as Expesne_comments, substring(Sub_Division_Id, 1, 5) as Equipment, Description from tbl_Journal_Voucher a, tbl_Journal_Voucher_Items b, tbl_Equipment c, tbl_Ledger_Account d where b.Account_Code in (4101001,4101002,4101003,4101004,4101005) and a.Journal_Voucher_Id=b.Journal_Voucher_Id and Voucher_Date between '" + From_Date.Date + "' and '" + To_Date.Date + "' and debit>0 and d.Account_Code=b.Account_Code and c.Asset_Code=substring(Sub_Division_Id,1,5) and (Sub_Division_Id not like 'sele%' AND Sub_Division_Id not like '254') order by Document_Number";
                DataTable dt = DB.GetDataTable(sql);
                #endregion

                if (dt.Rows.Count > 0)
                {
                    string AppLocation = HttpContext.Current.Server.MapPath("./Equipment_Expense_Reports/");

                    fileName = "Equipment_Expense_Report_" + DateTime.Now.ToShortDateString().Replace("/", "-") + ".xlsx";

                    AppLocation += fileName;
                    using (XLWorkbook wb = new XLWorkbook())
                    {
                        IXLWorksheet ws = wb.Worksheets.Add();

                        #region Top_Header
                        var table1 = ws.Range("A1:H1");
                        table1.Cell(1, 1).Value = "Equipment Expense Report (" + From_Date.ToString("dd-MMM-yyyy") + " - " + To_Date.ToString("dd-MMM-yyyy") + ")";
                        table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        table1.Cell(1, 1).Style.Font.FontSize = 20;
                        table1.Cell(1, 1).Style.Font.SetBold();
                        table1.Range("A1:H1").Merge();
                        #endregion

                        #region Column_Header
                        var table2 = ws.Range("A2:H2");
                        table2.Cell(1, 1).Value = "Document Number";
                        table2.Cell(1, 2).Value = "Payment Date";
                        table2.Cell(1, 3).Value = "Account Code";
                        table2.Cell(1, 4).Value = "Account Name";
                        table2.Cell(1, 5).Value = "Amount";
                        table2.Cell(1, 6).Value = "Comments";
                        table2.Cell(1, 7).Value = "Equipment";
                        table2.Cell(1, 8).Value = "Description";

                        table2.Cell(1, 1).Style.Font.SetBold();
                        table2.Cell(1, 1).Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table2.Cell(1, 2).Style.Font.SetBold();
                        table2.Cell(1, 2).Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Cell(1, 2).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table2.Cell(1, 3).Style.Font.SetBold();
                        table2.Cell(1, 3).Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Cell(1, 3).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table2.Cell(1, 4).Style.Font.SetBold();
                        table2.Cell(1, 4).Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Cell(1, 4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table2.Cell(1, 5).Style.Font.SetBold();
                        table2.Cell(1, 5).Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Cell(1, 5).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table2.Cell(1, 6).Style.Font.SetBold();
                        table2.Cell(1, 6).Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Cell(1, 6).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table2.Cell(1, 7).Style.Font.SetBold();
                        table2.Cell(1, 7).Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Cell(1, 7).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table2.Cell(1, 8).Style.Font.SetBold();
                        table2.Cell(1, 8).Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Cell(1, 8).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                        ws.Row(1).Height = 30;
                        ws.Row(2).Height = 30;
                        ws.RowHeight = 22;

                        ws.Column("A").Width = 10;
                        ws.Column("B").Width = 10;
                        ws.Column("C").Width = 10;
                        ws.Column("D").Width = 10;
                        ws.Column("E").Width = 10;
                        ws.Column("F").Width = 10;
                        ws.Column("G").Width = 10;
                        ws.Column("H").Width = 10;
                        #endregion

                        #region Table_Rows
                        var table3 = ws.Range("A3:H3");
                        int i = 1;
                        foreach (DataRow dr in dt.Rows)
                        {
                            // table.Cell(i, 1).Style.Font 
                            table3.Cell(i, 1).Value = dr["Document_Number"].ToString();
                            table3.Cell(i, 2).Value = Convert.ToDateTime(dr["Payment_date"].ToString()).ToString("dd-MMM-yyyy");
                            table3.Cell(i, 3).Value = dr["account_code"].ToString();
                            table3.Cell(i, 4).Value = dr["Ledger_Account_Name"].ToString();
                            table3.Cell(i, 5).Value = dr["Amount"].ToString();
                            table3.Cell(i, 6).Value = dr["Expesne_comments"].ToString();
                            table3.Cell(i, 7).Value = dr["Equipment"].ToString();
                            table3.Cell(i, 8).Value = dr["Description"].ToString();

                            i++;
                        }
                        #endregion

                        wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                        wb.Style.Font.Bold = false;
                        wb.SaveAs(AppLocation);
                    }
                }
            }
            else
            {
                fileName = "SessionIsDead";
            }
        }
        catch (Exception x)
        {
            fileName = "!error!" + x.Message + "";
        }

        return fileName;
    }
    #endregion
}
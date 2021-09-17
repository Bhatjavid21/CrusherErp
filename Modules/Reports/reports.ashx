<%@ WebHandler Language="C#" Class="reports" %>

using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.SessionState;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.IO;
using Newtonsoft.Json;
using System.Data;
using System.Configuration;
using System.Net;
using ClosedXML.Excel;

public class reports : IHttpHandler, IRequiresSessionState
{
    HttpContext Context; Int16 DF = 0;
    int BranchId, DivisionId,UserId;

    public void ProcessRequest(HttpContext context)
    {
        Context = context; if (!string.IsNullOrEmpty(Context.Request["fun"]))
        {
            try
            {
                if (G.HL() == true)
                {
                    DF = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[3]);
                    UserId=Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[0]);
                    BranchId = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[1]);
                    DivisionId = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[2]);
                    string abc = Context.Request["fun"].ToString();
                    switch (Context.Request["fun"].ToString())
                    {
                        case "GetUserAccess":GetUserAccess();break;
                        case "BindDdlReportModules": BindDdlReportModules(); break;
                        case "LoadReportList": LoadReportList(context.Request.Form["ReportModule"], Convert.ToInt32(context.Request.Form["Page_No"]), context.Request.Form["TextSearch"]); break;
                        case "ShowSOReport": ShowSOReport(context.Request.Form["SearchString"]); break;
                        case "SOExportToExcel": SOExportToExcel(context.Request.Form["SearchString"]); break;
                        case "ShowPOReport": ShowPOReport(context.Request.Form["SearchString"]); break;
                        case "POExportToExcel": POExportToExcel(context.Request.Form["SearchString"]); break;
                        case "ShowMrnReport": ShowMrnReport(context.Request.Form["SearchString"]); break;
                        case "MRNExportToExcel": MRNExportToExcel(context.Request.Form["SearchString"]); break;
                        case "ShowDNReport": ShowDNReport(context.Request.Form["SearchString"]); break;
                        case "DNExportToExcel": DNExportToExcel(context.Request.Form["SearchString"]); break;
                        case "ShowTrialBalanceReport": ShowTrialBalanceReport(context.Request.Form["date"], context.Request.Form["SearchString"]); break;
                        case "TrialBalanceGenerateExcel":TrialBalanceGenerateExcel(context.Request.Form["date"], context.Request.Form["SearchString"]); break;
                        case "ShowTrackingReport": ShowTrackingReport(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "TrackingReportExportToExcel": TrackingReportExportToExcel(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "CustomerAgingAnalysis": AgingAnalysis(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "AgingAnalysisExportToExcel": AgingAnalysisExportToExcel(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "SupAgingAnalysis": SupplierAgingAnalysis(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "SupAgingAnalysisExportToExcel": SupAgingAnalysisExportToExcel(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "BindDdlAssetCategory": BindDdlAssetCategory(); break;
                        case "ShowAssetRegisterReport": ShowAssetRegisterReport(context.Request.Form["category"], context.Request.Form["fromDate"], context.Request.Form["toDate"], context.Request.Form["asOf"]); break;
                        case "AssetRegisterReportExportToExcel": AssetRegisterReportExportToExcel(context.Request.QueryString["category"], context.Request.QueryString["fromDate"], context.Request.QueryString["toDate"], context.Request.QueryString["asOf"]); break;
                        case "ShowIncomeAccountReport": ShowIncomeAccountReport(context.Request.Form["division_id"], context.Request.Form["Account_code"], context.Request.Form["fromDate"], context.Request.Form["toDate"]); break;
                        case "PandLReportExport": PandLReportExport(context.Request.Form["division_id"], context.Request.Form["Account_code"], context.Request.Form["fromDate"], context.Request.Form["toDate"]); break;
                        case "ShowIncomeAccountReportSubItem": ShowIncomeAccountReportSubItem(context.Request.Form["devesion_id"], context.Request.Form["Account_code"], context.Request.Form["fromDate"], context.Request.Form["toDate"]); break;
                        case "ShowEmployeeAdvances":ShowEmployeeAdvances(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "EmployeeAdvancesExportToExcel":EmployeeAdvancesExportToExcel(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "ShowConsolidatedPl":ShowConsolidatedPl(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "ExportConsolidatedPl":ExportConsolidatedPl(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "ShowJobCosting":ShowJobCosting(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "BindJobCostDetails":BindJobCostDetails(context.Request.Form["id"]);break;
                        case "EportJobCasting":EportJobCasting(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                        case "LeaveGraduity": LeaveGraduity(context.Request.Form["SearchString"]);break;
                        case "EportLeaveGraduity":EportLeaveGraduity(context.Request.Form["date"], context.Request.Form["SearchString"],context.Request.Form["IsDateSearch"]); break;
                    }

                }
                else
                {
                    Raise_Error("SessionIsDead");
                }
            }
            catch (Exception x)
            {
                Raise_Error("!error!" + "\n" + x.Message + "\nError Detail\n" + x.StackTrace);
            }
        }
        Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }



    //=======================Display Income Account Report Function==================//

    public void PandLReportExport(string division_id, string Account_code, string fromDate, string toDate)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                string _SEARCHFILTER = "";
                var lbl = string.Empty;
                if (!string.IsNullOrEmpty(division_id) && division_id != "0")
                {
                    lbl = division_id == "129" ? "TRANSPORT" : "FREIGHT";
                    _SEARCHFILTER = " and d.Division_Id=" + division_id + " ";
                }

                string dateFilter = string.Empty;
                if (!string.IsNullOrEmpty(fromDate))
                {
                    dateFilter += " and (je.Posted_Date>='" + fromDate.Trim() + "' or je.Posted_Date is null)";
                }

                if (!string.IsNullOrEmpty(toDate))
                {
                    dateFilter += " and (je.Posted_Date<='" + toDate.Trim() + "' or je.Posted_Date is null)";
                }

                string JSONString = "";

                var sql1 = "Select a.Account_Code,a.Ledger_Account_Name,COALESCE(sum(je.Credit),0) total_credit, " +
                            "COALESCE(sum(je.Debit),0) total_debit,c.Account_Group_Name,d.Division_Id  " +
                            "from tbl_Ledger_Account a left join tbl_Journal_Entry je on a.Account_Code = je.Account_Code " + dateFilter +
                            "left join tbl_IncomeAccount_Mapper d  on a.Account_Code = d.Account_Code " +
                            "left join tbl_Account_Group c on a.Account_Group_Id = c.Account_Group_Id " +
                            "where 1=1 " + _SEARCHFILTER +
                            "group by a.Account_Code,a.Ledger_Account_Name,c.Account_Group_Name,d.Division_Id order by a.Account_Code";

                DataTable Data = DB.GetDataTable(sql1);

                if (Data.Rows.Count > 0)
                {
                    string AppLocation = HttpContext.Current.Server.MapPath("./Downloaded_Reports/");
                    fileName = "PandLReport_" + DateTime.Now.ToString("dd-MM-yyyy").ToString() + ".xlsx";

                    AppLocation += fileName;

                    using (XLWorkbook wb = new XLWorkbook())
                    {
                        IXLWorksheet ws = wb.Worksheets.Add();

                        var table1 = ws.Range("A1:I1");
                        table1.Cell(1, 1).Value = "P & L Report "+lbl+" - For the period from " + fromDate + " to " + toDate;
                        table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        table1.Cell(1, 1).Style.Font.FontSize = 15;
                        table1.Cell(1, 1).Style.Font.SetBold();
                        table1.Range("A1:C1").Merge();
                        var table2 = ws.Range("A2:C2");
                        //table2.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;
                        table2.Cell(1, 1).Value = "Account Name";
                        table2.Cell(1, 2).Value = "Account Code";
                        table2.Cell(1, 3).Value = "Ending Balance";

                        table2.Style.Font.SetBold();
                        table2.Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                        ws.Row(1).Height = 30;
                        ws.Row(2).Height = 30;
                        ws.RowHeight = 22;

                        ws.Column("A").Width = 20;
                        ws.Column("B").Width = 50;
                        ws.Column("C").Width = 30;

                        var table4 = ws.Range("A3:C3");
                        int i = 1;
                        decimal total = 0;
                        decimal totalRevenueFreight = 0;
                        decimal directCostTotalFreight = 0;
                        decimal contributionMargin = 0;
                        decimal totalIndirectCost = 0;
                        decimal totalAfterDepreciation = 0;
                        decimal totalCost = 0;
                        decimal totalDepreciation = 0;
                        decimal grossMargin = 0;
                        foreach (DataRow dr in Data.Rows)
                        {
                            var balance = Convert.ToDecimal(dr["total_debit"] == DBNull.Value || dr["total_debit"].ToString() == string.Empty ? "0" : dr["total_debit"].ToString())
                                          -Convert.ToDecimal(dr["total_credit"] == DBNull.Value || dr["total_credit"].ToString() == string.Empty ? "0" : dr["total_credit"].ToString());

                            var sql = string.Empty;

                            if ("4001001" == dr["Account_code"].ToString().Trim())
                            {
                                totalRevenueFreight = total;
                                table4.Cell(i, 1).Value = "Total Revenue Freight";
                                table4.Cell(i, 1).Style.Font.Bold = true;
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Style.Font.Bold = true;
                                table4.Cell(i, 3).Value = Math.Abs(total);

                                i++;
                                table4.Cell(i, 1).Value = "--";
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Value = "";
                                i++;

                                total = 0;
                            }

                            if ("4101001" == dr["Account_code"].ToString().Trim() )
                            {
                                totalRevenueFreight = total;
                                table4.Cell(i, 1).Value = "Total Revenue Transport";
                                table4.Cell(i, 1).Style.Font.Bold = true;
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Style.Font.Bold = true;
                                table4.Cell(i, 3).Value = Math.Abs(total);

                                i++;
                                table4.Cell(i, 1).Value = "--";
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Value = "";
                                i++;

                                total = 0;
                            }

                            if ("4301100" == dr["Account_code"].ToString().Trim())
                            {
                                directCostTotalFreight = total;
                                table4.Cell(i, 1).Value = "Direct Cost Total Freight";
                                table4.Cell(i, 1).Style.Font.Bold = true;
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Style.Font.Bold = true;
                                table4.Cell(i, 3).Value = directCostTotalFreight;

                                i++;

                                contributionMargin = Math.Abs(totalRevenueFreight) - directCostTotalFreight;
                                table4.Cell(i, 1).Value = "Contribution Margin";
                                table4.Cell(i, 1).Style.Font.Bold = true;
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Style.Font.Bold = true;
                                table4.Cell(i, 3).Value = contributionMargin;

                                i++;
                                table4.Cell(i, 1).Value = "--";
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Value = "";
                                i++;

                                total = 0;
                            }


                            if ("4401000" == dr["Account_code"].ToString().Trim())
                            {
                                directCostTotalFreight = total;
                                table4.Cell(i, 1).Value = "Direct Cost Total Transport";
                                table4.Cell(i, 1).Style.Font.Bold = true;
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Style.Font.Bold = true;
                                table4.Cell(i, 3).Value = directCostTotalFreight;

                                i++;

                                contributionMargin = Math.Abs(totalRevenueFreight) - directCostTotalFreight;
                                table4.Cell(i, 1).Value = "Contribution Margin";
                                table4.Cell(i, 1).Style.Font.Bold = true;
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Style.Font.Bold = true;
                                table4.Cell(i, 3).Value = contributionMargin;

                                i++;
                                table4.Cell(i, 1).Value = "--";
                                table4.Cell(i, 2).Value = "";
                                table4.Cell(i, 3).Value = "";
                                i++;

                                total = 0;
                            }

                            if (dr["Account_code"].ToString().Trim().StartsWith("310"))
                            {
                                table4.Cell(i, 1).Value = dr["Ledger_Account_Name"].ToString();
                                table4.Cell(i, 2).Value = dr["Account_code"];
                                table4.Cell(i, 3).Value = Math.Abs(balance);

                                total += balance;
                                i++;
                            }

                            if (!dr["Account_code"].ToString().Trim().StartsWith("310")  && !(dr["Account_code"].ToString().Trim().StartsWith("420")))
                            {
                                table4.Cell(i, 1).Value = dr["Ledger_Account_Name"].ToString();
                                table4.Cell(i, 2).Value = dr["Account_code"];
                                table4.Cell(i, 3).Value = balance;

                                total += balance;
                                i++;
                            }

                        }

                        totalIndirectCost = total;
                        table4.Cell(i, 1).Value = "Total Indirect Cost";
                        table4.Cell(i, 1).Style.Font.Bold = true;
                        table4.Cell(i, 2).Value = "";
                        table4.Cell(i, 3).Value = totalIndirectCost;
                        table4.Cell(i, 3).Style.Font.Bold = true;
                        i++;


                        totalCost = directCostTotalFreight + totalIndirectCost;
                        table4.Cell(i, 1).Value = "Total Cost";
                        table4.Cell(i, 1).Style.Font.Bold = true;
                        table4.Cell(i, 2).Value = "";
                        table4.Cell(i, 3).Value = totalCost;
                        table4.Cell(i, 3).Style.Font.Bold = true;
                        i++;

                        grossMargin = Math.Abs(totalRevenueFreight) - totalCost;
                        table4.Cell(i, 1).Value = "NET MARGIN BEFORE Depreciation";
                        table4.Cell(i, 1).Style.Font.Bold = true;
                        table4.Cell(i, 2).Value = "";
                        table4.Cell(i, 3).Value = grossMargin;
                        table4.Cell(i, 3).Style.Font.Bold = true;

                        i = i + 3;
                        if (division_id == "129")
                        {
                            foreach (DataRow dr in Data.Rows)
                            {
                                //var balance = Math.Abs(
                                // Convert.ToDecimal(
                                //    dr["total_credit"] == DBNull.Value ||
                                // dr["total_credit"].ToString() == string.Empty
                                //    ? "0"
                                //   : dr["total_credit"].ToString())
                                // - Convert.ToDecimal(
                                //   dr["total_debit"] == DBNull.Value ||
                                //  dr["total_debit"].ToString() == string.Empty
                                //     ? "0"
                                //    : dr["total_debit"].ToString()));
                                var balance = Convert.ToDecimal(
                                    dr["total_debit"] == DBNull.Value ||
                                    dr["total_debit"].ToString() == string.Empty
                                        ? "0"
                                        : dr["total_debit"].ToString())
                                         -Convert.ToDecimal(
                                    dr["total_credit"] == DBNull.Value ||
                                    dr["total_credit"].ToString() == string.Empty
                                        ? "0"
                                        : dr["total_credit"].ToString());



                                if (dr["Account_code"].ToString().Trim().StartsWith("420"))
                                {
                                    table4.Cell(i, 1).Value = dr["Ledger_Account_Name"].ToString();
                                    table4.Cell(i, 2).Value = dr["Account_code"];
                                    table4.Cell(i, 3).Value = balance;
                                    totalDepreciation += balance;
                                    i++;
                                }
                            }

                            table4.Cell(i, 1).Value = "Total Depreciation";
                            table4.Cell(i, 1).Style.Font.Bold = true;
                            table4.Cell(i, 2).Value = "";
                            table4.Cell(i, 3).Style.Font.Bold = true;
                            table4.Cell(i, 3).Value = totalDepreciation;

                            i++;

                            totalAfterDepreciation = grossMargin - totalDepreciation;
                            table4.Cell(i, 1).Value = "NET MARGIN After Depreciation";
                            table4.Cell(i, 1).Style.Font.Bold = true;
                            table4.Cell(i, 2).Value = "";
                            table4.Cell(i, 3).Style.Font.Bold = true;
                            table4.Cell(i, 3).Value = totalAfterDepreciation;

                            i++;
                            table4.Cell(i, 1).Value = "--";
                            table4.Cell(i, 2).Value = "";
                            table4.Cell(i, 3).Value = "";
                            i++;
                        }

                        wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                        wb.Style.Font.Bold = false;
                        wb.SaveAs(AppLocation);
                        //Context.Response.Write(fileName);
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
        Context.Response.Write(fileName);
    }

    public void ShowIncomeAccountReportSubItem(string devesion_id, string Account_code, string fromDate, string toDate)
    {
        string _SEARCHFILTER = "";

        if (!string.IsNullOrEmpty(fromDate))
        {
            _SEARCHFILTER += " and Posted_Date>='" + fromDate.Trim() + "'";
        }

        if (!string.IsNullOrEmpty(toDate))
        {
            _SEARCHFILTER += " and Posted_Date<='" + toDate.Trim() + "'";
        }

        string JSONString = "";

        var sql = "Select d.Ledger_Account_Name,b.Account_Code,isnull(Credit,0.00) as Credit,isnull(Debit,0.00) as Debit,Narration,Entry_Type,FORMAT (Posted_Date, 'dd-MM-yyyy') Posted_Date1 from tbl_Journal_Entry a join tbl_IncomeAccount_Mapper b "
                    + "on a.Account_Code = b.Account_Code join tbl_Company_Division c on c.Division_Id = b.Division_Id left join tbl_Ledger_Account d on b.Account_Code = d.Account_Code where b.Account_code = " + Account_code + _SEARCHFILTER;

        DataTable Dt = DB.GetDataTable(sql);

        JSONString = JsonConvert.SerializeObject(Dt);
        Context.Response.Write(JSONString);
        Dt.Dispose();
    }

    public void ShowIncomeAccountReport(string division_id, string Account_id, string fromDate, string toDate)
    {
        string _SEARCHFILTER = "";
        if (!string.IsNullOrEmpty(division_id) && division_id != "0")
        {
            _SEARCHFILTER = " and d.Division_Id=" + division_id + " ";
        }

        string dateFilter = string.Empty;
        if (!string.IsNullOrEmpty(fromDate))
        {
            dateFilter += " and (je.Posted_Date>='" + fromDate.Trim() + "' or je.Posted_Date is null)";
        }

        if (!string.IsNullOrEmpty(toDate))
        {
            dateFilter += " and (je.Posted_Date<='" + toDate.Trim() + "' or je.Posted_Date is null)";
        }

        string JSONString = "";

        var sql = "Select a.Account_Code,a.Ledger_Account_Name,COALESCE(sum(je.Credit),0) total_credit, " +
                    "COALESCE(sum(je.Debit),0) total_debit,c.Account_Group_Name,d.Division_Id  " +
                    "from tbl_Ledger_Account a left join tbl_Journal_Entry je on a.Account_Code = je.Account_Code " + dateFilter +
                    "left join tbl_IncomeAccount_Mapper d  on a.Account_Code = d.Account_Code " +
                    "left join tbl_Account_Group c on a.Account_Group_Id = c.Account_Group_Id " +
                    "where 1=1 " + _SEARCHFILTER +
                    "group by a.Account_Code,a.Ledger_Account_Name,c.Account_Group_Name,d.Division_Id order by a.Account_Code";

        DataTable Dt = DB.GetDataTable(sql);

        JSONString = JsonConvert.SerializeObject(Dt);
        Context.Response.Write(JSONString);
        Dt.Dispose();
    }


    //=======================Raise Error Function==================//
    void Raise_Error(string error)
    {
        error = error.Replace("\"", "");
        var json = (new { status = "success", errorMessage = error });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }
    //=======================Bind Ddl Report Module on List Page Function==================//
    public void BindDdlReportModules()
    {
        string JSONString = "";
        string sql = "Select distinct(Report_Module)   from Tbl_Reports order By Report_Module";
        DataTable dt = DB.GetDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
            Context.Response.Write(JSONString);
        }

        dt.Dispose();
    }
    //=======================Load Report List  Function==================//
    public void LoadReportList(string ReportModule, int Page_No, string txtSearch)
    {
        string JSONString = "";
        string _MODULEFILTER = "";
        string _SEARCHFILTER = "";
        int TotalRecords = 0, from = 1, to = 10; if (Page_No == 0) { Page_No = 1; };
        from = (((Page_No * 10) - 10) + 1); to = Page_No * 10;
        if (ReportModule == "") { ReportModule = "0"; }

        if (ReportModule != "0")
        {
            _MODULEFILTER = "and Report_Module = '" + ReportModule + "' ";
        }
        else
        {
            _MODULEFILTER = "";
        }


        if (txtSearch != "")
        {
            _SEARCHFILTER = " and (Report_Name like '%" + txtSearch + "%' or Report_Description like '%" + txtSearch + "%');";
        }
        else
        {
            _SEARCHFILTER = "";
        }

        DataTable dt = new DataTable();
        string sql = "with newDataTable as( Select * from tbl_Reports) select * from newDataTable where 1=1  " + _MODULEFILTER + _SEARCHFILTER + "; select count(*) from tbl_Reports  where 1=1 " + _MODULEFILTER + _SEARCHFILTER + "; ";
        DataSet Ds = DB.GetDataSet(sql);
        dt = Ds.Tables[0];
        TotalRecords = int.Parse(Ds.Tables[1].Rows[0][0].ToString());
        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
        }


        JSONString += "|";
        string str_Pagging = "", Paging_Strip = Pagination.PG(TotalRecords, Page_No, 20);

        if (TotalRecords > 1)
        {
            str_Pagging = "<div class='dataTables_info ' id='#' role='status' aria-live='polite'>Showing " + from + " to " +
            to + " of " + TotalRecords + " entries</div>"
            + "<div class='dataTables_paginate paging_simple_numbers right' id='#_paginate'>"
            + "<ul class='pagination'>"
            + Paging_Strip
            + "</ul></div></div>";
        }
        JSONString += str_Pagging;
        Context.Response.Write(JSONString);

        dt.Dispose();

    }
    //=======================Display Sales Order Report Function==================//

    public void ShowSOReport(string txtSearch)
    {
        string _SEARCHFILTER = "";
        if (txtSearch != "")
        {
            _SEARCHFILTER = " where  (division_name like  '%" + txtSearch.Trim() + "%' or Sales_Order_Number  like  '%" + txtSearch.Trim() + "%' or   Cus_Company_Name  like  '%" + txtSearch.Trim() + "%'  or employee_name     like  '%" + txtSearch.Trim() + "%' or item_code like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
        }
        else
        {
            _SEARCHFILTER = "";
        }
        string JSONString = "";
        //DataTable Dt = DB.GetDataTable(" with NewTable as(  select a.so_date,Sales_Order_Number, replace(employee_name ,',' , ' ') as employee_name , c.division_name,Cus_Company_Name,customer_po_ref,po_date,Item_Line_Number,item_code,[Description],Unit,Quantity,Sales_Price_Per_Unit_After_Margin, Quantity*Sales_Price_Per_Unit_After_Margin as total_price, "
        //               + " Currency_Name,b.Delivery_Date,b.Delivery_Status , g.Actual_Delivery_Date , datediff(day,g.Actual_Delivery_Date, getdate()) as  Delaydays ,max(a.revision_number) as revno from tbl_sales_order a,tbl_sales_order_items b ,tbl_Company_Division c,tbl_employee d,tbl_customer e,tbl_Currency f , tbl_Delivery_Note g where a.Sales_Order_Id=b.SO_id  and a.Division_Id=c.division_id  and a.lead_generator=d.employee_id and e.customer_id=a.Customer_Id  "
        //               + " and a.Currency_Id=f.Currency_Id   and  a.Sales_Order_Id = g.Sales_Order_Id group by a.so_date,Sales_Order_Number,  employee_name , c.division_name,Cus_Company_Name,customer_po_ref,po_date,Item_Line_Number,item_code,[Description],Unit,Quantity,Sales_Price_Per_Unit_After_Margin,  Quantity*Sales_Price_Per_Unit_After_Margin,  "
        //              + " Currency_Name,b.Delivery_Date,b.Delivery_Status , g.Actual_Delivery_Date , datediff(day,g.Actual_Delivery_Date, getdate()))  select * from NewTable  " + _SEARCHFILTER + "   order by so_date,Sales_Order_Number,Item_Line_Number; ");

        DataTable Dt = DB.GetDataTable(" with NewTable as(  select a.so_date,Sales_Order_Number, replace(employee_name ,',' , ' ') as employee_name , c.division_name,Cus_Company_Name,customer_po_ref,po_date,Item_Line_Number,item_code,[Description],Unit,Quantity,Sales_Price_Per_Unit_After_Margin, Quantity*Sales_Price_Per_Unit_After_Margin as total_price,    "
                                       + " Currency_Name,b.Delivery_Date,b.Delivery_Status , g.Actual_Delivery_Date , datediff(day,g.Actual_Delivery_Date, getdate()) as  Delaydays ,max(a.revision_number) as revno from tbl_sales_order a left outer join tbl_sales_order_items  b on a.Sales_Order_Id=b.SO_id  left outer join  tbl_Company_Division c on a.Division_Id=c.division_id left outer join  tbl_employee d on a.lead_generator=d.employee_id "
                                       + "  left outer join tbl_customer e on e.customer_id=a.Customer_Id   left outer join tbl_Currency f on a.Currency_Id=f.Currency_Id  left outer join  tbl_Delivery_Note g on  a.Sales_Order_Id = g.Sales_Order_Id "
                                       + "  group by a.so_date,Sales_Order_Number,  employee_name , c.division_name,Cus_Company_Name,customer_po_ref,po_date,Item_Line_Number,item_code,[Description],Unit,Quantity,Sales_Price_Per_Unit_After_Margin,  Quantity*Sales_Price_Per_Unit_After_Margin,   "
                                       + "  Currency_Name,b.Delivery_Date,b.Delivery_Status , g.Actual_Delivery_Date ,  datediff(day,g.Actual_Delivery_Date, getdate()))  "
                                        + " select SO_Date,Sales_Order_Number,employee_name,Division_Name,Cus_Company_Name,Customer_PO_Ref,PO_Date,Item_Line_Number, "
                                        + "  ITEM_CODE,Description,UNIT,Quantity,Sales_Price_Per_Unit_After_Margin,total_price, "
                                         + " Currency_Name,isnull(Delivery_Date,0) as Delivery_Date ,Delivery_Status,isnull(Actual_Delivery_Date,0) AS Actual_Delivery_Date, isnull(datediff(day,Actual_Delivery_Date,getdate()),'') as Delaydays "
                                        + "  from NewTable  " + _SEARCHFILTER + "   order by so_date,Sales_Order_Number,Item_Line_Number; ");



        JSONString = JsonConvert.SerializeObject(Dt);
        Context.Response.Write(JSONString);
        Dt.Dispose();
    }
    //=======================Display Purchase Order Report Function==================//
    public void ShowPOReport(string txtSearch)
    {
        string _SEARCHFILTER = "";
        if (txtSearch != "")
        {
            _SEARCHFILTER = " where  (PO_Number  like  '%" + txtSearch.Trim() + "%' or   supplier_name  like  '%" + txtSearch.Trim() + "%'  or item_code like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
        }
        else
        {
            _SEARCHFILTER = "";
        }
        string JSONString = "";
        DataTable Dt = DB.GetDataTable(" with NewTable as( select PO_Number,convert(date,a.po_date,103) as po_date,  c.supplier_name,CASE when supplier_type=1 then 'LOCAL' else 'OVERSEAS' END as PO_Type,  Line_Item_Number,b.item_code,b.quantity,b.unit_cost,b.Total_Amount ,Currency_Name , convert (date,a.Delivery_Date,103) as Delivery_Date  , supplier_dn_no,  convert(date,MRN_Date,103) as MRN_Date,  "
                                   + "  CASE  WHEN A.PO_Status=0 THEN 'Awaiting Approval' WHEN A.PO_Status=1 THEN 'Awaiting Genaration'   WHEN A.PO_Status=2 THEN 'Pending' WHEN A.PO_Status=3 THEN 'Partially Recieved' WHEN A.PO_Status=4 THEN 'Recieved'   "
                                   + " WHEN A.PO_Status=5 THEN 'Cancelled' END   AS PO_Status, datediff(day,mrn_date,getdate()) as Delay_days,Sales_Order_Number,max(a.REV_NUMBER)   as REV_NUMBER  from tbl_Purchase_Order a,tbl_Purchase_Order_Items b,tbl_supplier c,tbl_Sales_Order d,tbl_Currency e,tbl_material_receipt f "
                                   + "  where a.Purchase_Order_Id=b.Purchase_Order_Id and c.supplier_id=a.Supplier_Id and b.Sales_Order_Id=d.Sales_Order_Id   and e.Currency_Id=a.Currency_Id "
                                   + "  and f.Purchase_Order_Id=b.Purchase_Order_Id group by PO_Number,A.po_date,  c.supplier_name,supplier_type,  Line_Item_Number,b.item_code,b.quantity,b.unit_cost,b.Total_Amount ,Currency_Name ,  "
                                    + "  a.Delivery_Date  , supplier_dn_no,   MRN_Date,    PO_Status,    datediff(day,mrn_date,getdate()),Sales_Order_Number )   select * from NewTable  " + _SEARCHFILTER + ";");
        JSONString = JsonConvert.SerializeObject(Dt);
        Context.Response.Write(JSONString);
        Dt.Dispose();
    }
    //=======================Display Mrn Report Function==================//
    public void ShowMrnReport(string txtSearch)
    {
        string _SEARCHFILTER = "";
        if (txtSearch != "")
        {
            _SEARCHFILTER = " where  (MRN_NO  like  '%" + txtSearch.Trim() + "%' or   SUPPLIER_NAME  like  '%" + txtSearch.Trim() + "%'  or item_code like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
        }
        else
        {
            _SEARCHFILTER = "";
        }
        string JSONString = "";
        DataTable Dt = DB.GetDataTable(" with NewTable as (select distinct MRN_NO,MRN_DATE,C.SUPPLIER_NAME,D.PO_Number,D.PO_Date,b.Item_Description,b.Item_Code,g.unit,MRN_Received_Quantity,supplier_dn_no,supplier_invoice_no,mrn_date as vendor_date,Sales_Order_Number,so_date from tbl_Material_Receipt a,tbl_MRN_Items b,tbl_Supplier c,tbl_Purchase_Order d,tbl_Sales_Order e,tbl_Purchase_Order_Items f, tbl_sales_order_items g  WHERE a.MRN_Id=b.MRN_Id and c.Supplier_Id=a.Supplier_Id and d.Purchase_Order_Id=a.Purchase_Order_Id and f.Sales_Order_Id=e.Sales_Order_Id and f.Purchase_Order_Id=d.Purchase_Order_Id  and f.Sales_Order_Id=g.SO_Id)select * from NewTable  " + _SEARCHFILTER + ";");
        JSONString = JsonConvert.SerializeObject(Dt);
        Context.Response.Write(JSONString);
        Dt.Dispose();
    }
    //=======================Display DN Report Function==================//
    public void ShowDNReport(string txtSearch)
    {
        string _SEARCHFILTER = "";
        if (txtSearch != "")
        {
            _SEARCHFILTER = " where  (delivery_note_number  like  '%" + txtSearch.Trim() + "%' or   customer_name  like  '%" + txtSearch.Trim() + "%'  or driver_name like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
        }
        else
        {
            _SEARCHFILTER = "";
        }
        string JSONString = "";
        DataTable Dt = DB.GetDataTable(" with NewTable as( select a.delivery_note_number, convert(date, a.dn_date,103) as dn_date ,c.Cus_Company_Name as customer_name,PO_Reference, convert(date,Customer_PO_Date,103) as Customer_PO_Date , isnull(Replace(employee_name,',', ' '),' ') as driver_name,    Sales_Order_Number,max(a.Revision_Number)  as Revision_Number  "
                                         +" from  tbl_Delivery_Note a  left outer join tbl_DN_Items b on a.Delivery_Note_Id=b.Delivery_Note_Id left outer join tbl_customer c on a.Customer_Id = c.Customer_Id "
                                         +" left outer join tbl_Sales_Order d on a.Sales_Order_Id=d.Sales_Order_Id left outer join   tbl_Delivery_Schedule f  on f.DN_Id=a.Delivery_Note_Id left outer join tbl_employee g "
                                         +"  on g.Employee_Id=f.Driver_Id where a.Delivery_Note_Id=b.Delivery_Note_Id    and c.Customer_Id=a.Customer_Id  and a.Sales_Order_Id=d.Sales_Order_Id  "
                                        + " group by a.delivery_note_number,a.dn_date,Cus_Company_Name,PO_Reference,Customer_PO_Date,Replace(employee_name,',', ' ') ,Sales_Order_Number ) Select * from NewTable "+_SEARCHFILTER+" order by delivery_note_number,dn_date;");   JSONString = JsonConvert.SerializeObject(Dt);
        Context.Response.Write(JSONString);
        Dt.Dispose();
    }


    //=======================Sales Order Export To Excel  Function==================//
    public void SOExportToExcel(string txtSearch)                // plug in variables that will filter out the data
    {
        string fileName = "";

        try
        {
            if (G.HL() == true)
            {
                string _SEARCHFILTER = "";
                if (txtSearch != "")
                {
                    _SEARCHFILTER = " where  (division_name like  '%" + txtSearch.Trim() + "%' or Sales_Order_Number  like  '%" + txtSearch.Trim() + "%' or   Cus_Company_Name  like  '%" + txtSearch.Trim() + "%'  or employee_name     like  '%" + txtSearch.Trim() + "%' or item_code like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
                }
                else
                {
                    _SEARCHFILTER = "";
                }
                string JSONString = "";
                //DataTable Data = DB.GetDataTable(" with NewTable as(  select a.so_date,Sales_Order_Number, replace(employee_name ,',' , ' ') as employee_name , c.division_name,Cus_Company_Name,customer_po_ref,po_date,Item_Line_Number,item_code,[Description],Unit,Quantity,Sales_Price_Per_Unit_After_Margin, Quantity*Sales_Price_Per_Unit_After_Margin as total_price, "
                //               + " Currency_Name,b.Delivery_Date,b.Delivery_Status , g.Actual_Delivery_Date , datediff(day,g.Actual_Delivery_Date, getdate()) as  Delaydays ,max(a.revision_number) as revno from tbl_sales_order a,tbl_sales_order_items b ,tbl_Company_Division c,tbl_employee d,tbl_customer e,tbl_Currency f , tbl_Delivery_Note g where a.Sales_Order_Id=b.SO_id  and a.Division_Id=c.division_id  and a.lead_generator=d.employee_id and e.customer_id=a.Customer_Id  "
                //               + " and a.Currency_Id=f.Currency_Id   and  a.Sales_Order_Id = g.Sales_Order_Id group by a.so_date,Sales_Order_Number,  employee_name , c.division_name,Cus_Company_Name,customer_po_ref,po_date,Item_Line_Number,item_code,[Description],Unit,Quantity,Sales_Price_Per_Unit_After_Margin,  Quantity*Sales_Price_Per_Unit_After_Margin,  "
                //              + " Currency_Name,b.Delivery_Date,b.Delivery_Status , g.Actual_Delivery_Date , datediff(day,g.Actual_Delivery_Date, getdate()))  select * from NewTable  " + _SEARCHFILTER + "   order by so_date,Sales_Order_Number,Item_Line_Number; ");

                DataTable Data = DB.GetDataTable(" with NewTable as(  select a.so_date,Sales_Order_Number, replace(employee_name ,',' , ' ') as employee_name , c.division_name,Cus_Company_Name,customer_po_ref,po_date,Item_Line_Number,item_code,[Description],Unit,Quantity,Sales_Price_Per_Unit_After_Margin, Quantity*Sales_Price_Per_Unit_After_Margin as total_price,    "
                                      + " Currency_Name,b.Delivery_Date,b.Delivery_Status , g.Actual_Delivery_Date , datediff(day,g.Actual_Delivery_Date, getdate()) as  Delaydays ,max(a.revision_number) as revno from tbl_sales_order a left outer join tbl_sales_order_items  b on a.Sales_Order_Id=b.SO_id  left outer join  tbl_Company_Division c on a.Division_Id=c.division_id left outer join  tbl_employee d on a.lead_generator=d.employee_id "
                                      + "  left outer join tbl_customer e on e.customer_id=a.Customer_Id   left outer join tbl_Currency f on a.Currency_Id=f.Currency_Id  left outer join  tbl_Delivery_Note g on  a.Sales_Order_Id = g.Sales_Order_Id "
                                      + "  group by a.so_date,Sales_Order_Number,  employee_name , c.division_name,Cus_Company_Name,customer_po_ref,po_date,Item_Line_Number,item_code,[Description],Unit,Quantity,Sales_Price_Per_Unit_After_Margin,  Quantity*Sales_Price_Per_Unit_After_Margin,   "
                                      + "  Currency_Name,b.Delivery_Date,b.Delivery_Status , g.Actual_Delivery_Date ,  datediff(day,g.Actual_Delivery_Date, getdate()))  "
                                       + " select SO_Date,Sales_Order_Number,employee_name,Division_Name,Cus_Company_Name,Customer_PO_Ref,PO_Date,Item_Line_Number, "
                                       + "  ITEM_CODE,Description,UNIT,Quantity,Sales_Price_Per_Unit_After_Margin,total_price, "
                                        + " Currency_Name,isnull(Delivery_Date,0) as Delivery_Date ,Delivery_Status,isnull(Actual_Delivery_Date,0) AS Actual_Delivery_Date, isnull(datediff(day,Actual_Delivery_Date,getdate()),'') as Delaydays "
                                       + "  from NewTable  " + _SEARCHFILTER + "   order by so_date,Sales_Order_Number,Item_Line_Number; ");

                if (Data.Rows.Count > 0)
                {
                    fileName = "SalesOrderReport_" + (DateTime.Now.ToShortDateString().Replace("/", "-") + "-" + DateTime.Now.Hour + "-" + DateTime.Now.Minute + "-" + DateTime.Now.Second + "-" + DateTime.Now.Millisecond).ToString() + ".xlsx";
                    System.IO.File.Copy(HttpContext.Current.Server.MapPath("./Templates/SO_Template.xlsx"), HttpContext.Current.Server.MapPath("./Downloaded_Reports/" + fileName + ""), true);
                    string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + HttpContext.Current.Server.MapPath("Downloaded_Reports/" + fileName + "") + ";Extended Properties='Excel 8.0;HDR=NO'";
                    using (System.Data.OleDb.OleDbConnection Connection = new System.Data.OleDb.OleDbConnection(connectionString))
                    {
                        Connection.Open();
                        using (System.Data.OleDb.OleDbCommand command = new System.Data.OleDb.OleDbCommand())
                        {
                            command.Connection = Connection;
                            foreach (DataRow dr in Data.Rows)
                            {
                                string SO_date = DateTime.Parse(dr["so_date"].ToString()).ToString("dd-MM-yyyy");

                                string PO_date = "";
                                if(!(dr["PO_Date"].ToString().Contains("1900")|| dr["PO_Date"].ToString().Contains("-00")))
                                {
                                    PO_date= DateTime.Parse(dr["PO_Date"].ToString()).ToString("dd-MM-yyyy");
                                }


                                string DN_Date = "";
                                if(!(dr["Delivery_Date"].ToString().Contains("1900")|| dr["Delivery_Date"].ToString().Contains("-00") ||dr["Delivery_Date"].ToString().Trim().Equals("0")))
                                {
                                    DN_Date = DateTime.Parse(dr["Delivery_Date"].ToString()).ToString("dd-MM-yyyy");
                                }
                                string Actual_Delivery_Date = "Not Delivered";
                                string abc = dr["Actual_Delivery_Date"].ToString();
                                if(!(dr["Actual_Delivery_Date"].ToString().Contains("1900")|| dr["Actual_Delivery_Date"].ToString().Contains("-00")||dr["Actual_Delivery_Date"].ToString().Trim().Equals("0")))
                                {
                                    Actual_Delivery_Date = DateTime.Parse(dr["Actual_Delivery_Date"].ToString()).ToString("dd-MM-yyyy");
                                }



                                string sql = "INSERT INTO [Sheet1$](F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17, F18) VALUES('" + SO_date + "','" + dr["Sales_Order_Number"].ToString() + "','" + dr["employee_name"].ToString() + "','" + dr["Division_Name"].ToString() + "','" + dr["Cus_Company_Name"].ToString() + "','" + dr["Customer_PO_Ref"].ToString() + "','" + PO_date + "','" + dr["Item_Line_Number"].ToString() + "','" + dr["ITEM_CODE"].ToString() + "','" + dr["UNIT"].ToString() + "','" + dr["Quantity"].ToString() + "','" + dr["Sales_Price_Per_Unit_After_Margin"].ToString() + "','" + dr["total_price"].ToString() + "',  '" + dr["Currency_Name"] + "' ,'" + DN_Date + "','" + Actual_Delivery_Date + "','" + dr["Delivery_Status"].ToString() + "','" + dr["Delaydays"].ToString() + "')";
                                command.CommandText = sql;
                                command.ExecuteNonQuery();
                            }
                            Data.Dispose();
                        }
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
        Context.Response.Write(fileName);

    }
    //=======================Purchase Order Export To Excel  Function==================//
    public void POExportToExcel(string txtSearch)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                string _SEARCHFILTER = "";
                if (txtSearch != "")
                {
                    _SEARCHFILTER = " where  (PO_Number  like  '%" + txtSearch.Trim() + "%' or   supplier_name  like  '%" + txtSearch.Trim() + "%'  or item_code like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
                }
                else
                {
                    _SEARCHFILTER = "";
                }
                DataTable Data = DB.GetDataTable(" with NewTable as( select PO_Number,convert(date,a.po_date,103) as po_date,  c.supplier_name,CASE when supplier_type=1 then 'LOCAL' else 'OVERSEAS' END as PO_Type,  Line_Item_Number,b.item_code,b.quantity,b.unit_cost,b.Total_Amount ,Currency_Name , convert (date,a.Delivery_Date,103) as Delivery_Date  , supplier_dn_no,  convert(date,MRN_Date,103) as MRN_Date,  "
                                           + "  CASE  WHEN A.PO_Status=0 THEN 'Awaiting Approval' WHEN A.PO_Status=1 THEN 'Awaiting Genaration'   WHEN A.PO_Status=2 THEN 'Pending' WHEN A.PO_Status=3 THEN 'Partially Recieved' WHEN A.PO_Status=4 THEN 'Recieved'   "
                                           + " WHEN A.PO_Status=5 THEN 'Cancelled' END   AS PO_Status, datediff(day,mrn_date,getdate()) as Delay_days,Sales_Order_Number,max(a.REV_NUMBER)   as REV_NUMBER  from tbl_Purchase_Order a,tbl_Purchase_Order_Items b,tbl_supplier c,tbl_Sales_Order d,tbl_Currency e,tbl_material_receipt f "
                                           + "  where a.Purchase_Order_Id=b.Purchase_Order_Id and c.supplier_id=a.Supplier_Id and b.Sales_Order_Id=d.Sales_Order_Id   and e.Currency_Id=a.Currency_Id "
                                           + "  and f.Purchase_Order_Id=b.Purchase_Order_Id group by PO_Number,A.po_date,  c.supplier_name,supplier_type,  Line_Item_Number,b.item_code,b.quantity,b.unit_cost,b.Total_Amount ,Currency_Name ,  "
                                            + "  a.Delivery_Date  , supplier_dn_no,   MRN_Date,    PO_Status,    datediff(day,mrn_date,getdate()),Sales_Order_Number )   select * from NewTable  " + _SEARCHFILTER + ";");

                if (Data.Rows.Count > 0)
                {
                    fileName = "PurchaseOrderReport_" + (DateTime.Now.ToShortDateString().Replace("/", "-") + "-" + DateTime.Now.Hour + "-" + DateTime.Now.Minute + "-" + DateTime.Now.Second + "-" + DateTime.Now.Millisecond).ToString() + ".xlsx";
                    System.IO.File.Copy(HttpContext.Current.Server.MapPath("./Templates/PO_Template.xlsx"), HttpContext.Current.Server.MapPath("./Downloaded_Reports/" + fileName + ""), true);
                    string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + HttpContext.Current.Server.MapPath("Downloaded_Reports/" + fileName + "") + ";Extended Properties='Excel 8.0;HDR=NO'";
                    using (System.Data.OleDb.OleDbConnection Connection = new System.Data.OleDb.OleDbConnection(connectionString))
                    {
                        Connection.Open();
                        using (System.Data.OleDb.OleDbCommand command = new System.Data.OleDb.OleDbCommand())
                        {
                            command.Connection = Connection;
                            foreach (DataRow dr in Data.Rows)
                            {
                                string sql = "INSERT INTO [Sheet1$](F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13, F14, F15, F16, F17) VALUES('" + dr["PO_Number"].ToString() + "','" + dr["po_date"].ToString() + "','" + dr["supplier_name"].ToString() + "','" + dr["PO_Type"].ToString() + "','" + dr["Line_Item_Number"].ToString() + "','" + dr["item_code"].ToString() + "','" + dr["quantity"].ToString() + "','" + dr["unit_cost"].ToString() + "','" + dr["Total_Amount"].ToString() + "','" + dr["Currency_Name"].ToString() + "','" + dr["supplier_dn_no"].ToString() + "',' ','" + dr["Delivery_Date"].ToString() + "','" + dr["MRN_Date"].ToString() + "','" + dr["PO_Status"].ToString() + "','" + dr["Delay_days"].ToString() + "','" + dr["Sales_Order_Number"].ToString() + "')";
                                command.CommandText = sql;
                                command.ExecuteNonQuery();
                            }
                            Data.Dispose();
                        }
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
        Context.Response.Write(fileName);
    }
    //=======================MRN  Export To Excel  Function==================//
    public void MRNExportToExcel(string txtSearch)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                string _SEARCHFILTER = "";
                if (txtSearch != "")
                {
                    _SEARCHFILTER = " where  (MRN_NO  like  '%" + txtSearch.Trim() + "%' or   SUPPLIER_NAME  like  '%" + txtSearch.Trim() + "%'  or item_code like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
                }
                else
                {
                    _SEARCHFILTER = "";
                }
                DataTable Data = DB.GetDataTable(" with NewTable as (select distinct MRN_NO,MRN_DATE,C.SUPPLIER_NAME,D.PO_Number,D.PO_Date,b.Item_Description,b.Item_Code,g.unit,MRN_Received_Quantity,supplier_dn_no,supplier_invoice_no,mrn_date as vendor_date,Sales_Order_Number,so_date from tbl_Material_Receipt a,tbl_MRN_Items b,tbl_Supplier c,tbl_Purchase_Order d,tbl_Sales_Order e,tbl_Purchase_Order_Items f, tbl_sales_order_items g  WHERE a.MRN_Id=b.MRN_Id and c.Supplier_Id=a.Supplier_Id and d.Purchase_Order_Id=a.Purchase_Order_Id and f.Sales_Order_Id=e.Sales_Order_Id and f.Purchase_Order_Id=d.Purchase_Order_Id  and f.Sales_Order_Id=g.SO_Id)select * from NewTable  " + _SEARCHFILTER + ";");

                if (Data.Rows.Count > 0)
                {
                    fileName = "MRNReport_" + (DateTime.Now.ToShortDateString().Replace("/", "-") + "-" + DateTime.Now.Hour + "-" + DateTime.Now.Minute + "-" + DateTime.Now.Second + "-" + DateTime.Now.Millisecond).ToString() + ".xlsx";
                    System.IO.File.Copy(HttpContext.Current.Server.MapPath("./Templates/MRN_Template.xlsx"), HttpContext.Current.Server.MapPath("./Downloaded_Reports/" + fileName + ""), true);
                    string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + HttpContext.Current.Server.MapPath("Downloaded_Reports/" + fileName + "") + ";Extended Properties='Excel 8.0;HDR=NO'";
                    using (System.Data.OleDb.OleDbConnection Connection = new System.Data.OleDb.OleDbConnection(connectionString))
                    {
                        Connection.Open();
                        using (System.Data.OleDb.OleDbCommand command = new System.Data.OleDb.OleDbCommand())
                        {
                            command.Connection = Connection;
                            foreach (DataRow dr in Data.Rows)
                            {
                                string sql = "INSERT INTO [Sheet1$](F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, F13) VALUES('" + dr["MRN_NO"].ToString() + "','" + dr["MRN_DATE"].ToString() + "','" + dr["SUPPLIER_NAME"].ToString() + "','" + dr["PO_Number"].ToString() + "','" + dr["PO_Date"].ToString() + "','" + dr["Item_Code"].ToString() + "','" + dr["unit"].ToString() + "','" + dr["MRN_Received_Quantity"].ToString() + "','" + dr["supplier_dn_no"].ToString() + "','" + dr["supplier_invoice_no"].ToString() + "','" + dr["Sales_Order_Number"].ToString() + "',' ','" + dr["so_date"].ToString() + "')";
                                command.CommandText = sql;
                                command.ExecuteNonQuery();
                            }
                            Data.Dispose();
                        }
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
        Context.Response.Write(fileName);
    }
    //========================Delivery Note  Export To Excel  Function==================//
    public void DNExportToExcel(string txtSearch)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                string _SEARCHFILTER = "";
                if (txtSearch != "")
                {
                    _SEARCHFILTER = " where  (delivery_note_number  like  '%" + txtSearch.Trim() + "%' or   customer_name  like  '%" + txtSearch.Trim() + "%'  or driver_name like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
                }
                else
                {
                    _SEARCHFILTER = "";
                }

                DataTable Data = DB.GetDataTable(" with NewTable as( select a.delivery_note_number, convert(date, a.dn_date,103) as dn_date ,c.Cus_Company_Name as customer_name,PO_Reference, convert(date,Customer_PO_Date,103) as Customer_PO_Date , isnull(Replace(employee_name,',', ' '),' ') as driver_name,    Sales_Order_Number,max(a.Revision_Number)  as Revision_Number  "
                                       +" from  tbl_Delivery_Note a  left outer join tbl_DN_Items b on a.Delivery_Note_Id=b.Delivery_Note_Id left outer join tbl_customer c on a.Customer_Id = c.Customer_Id "
                                       +" left outer join tbl_Sales_Order d on a.Sales_Order_Id=d.Sales_Order_Id left outer join   tbl_Delivery_Schedule f  on f.DN_Id=a.Delivery_Note_Id left outer join tbl_employee g "
                                       +"  on g.Employee_Id=f.Driver_Id where a.Delivery_Note_Id=b.Delivery_Note_Id    and c.Customer_Id=a.Customer_Id  and a.Sales_Order_Id=d.Sales_Order_Id  "
                                      + " group by a.delivery_note_number,a.dn_date,Cus_Company_Name,PO_Reference,Customer_PO_Date,Replace(employee_name,',', ' ') ,Sales_Order_Number ) Select * from NewTable "+_SEARCHFILTER+" order by delivery_note_number,dn_date;");

                if (Data.Rows.Count > 0)
                {
                    fileName = "DNReport_" + (DateTime.Now.ToShortDateString().Replace("/", "-") + "-" + DateTime.Now.Hour + "-" + DateTime.Now.Minute + "-" + DateTime.Now.Second + "-" + DateTime.Now.Millisecond).ToString() + ".xlsx";
                    System.IO.File.Copy(HttpContext.Current.Server.MapPath("./Templates/DN_Template.xlsx"), HttpContext.Current.Server.MapPath("./Downloaded_Reports/" + fileName + ""), true);
                    string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + HttpContext.Current.Server.MapPath("Downloaded_Reports/" + fileName + "") + ";Extended Properties='Excel 8.0;HDR=NO'";
                    using (System.Data.OleDb.OleDbConnection Connection = new System.Data.OleDb.OleDbConnection(connectionString))
                    {
                        Connection.Open();
                        using (System.Data.OleDb.OleDbCommand command = new System.Data.OleDb.OleDbCommand())
                        {
                            command.Connection = Connection;
                            foreach (DataRow dr in Data.Rows)
                            {
                                string sql = "INSERT INTO [Sheet1$](F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11) VALUES('" + dr["delivery_note_number"].ToString() + "','" + dr["dn_date"].ToString() + "','" + dr["customer_name"].ToString() + "','" + dr["PO_Reference"].ToString() + "','" + dr["Customer_PO_Date"].ToString() + "' , '" + dr["driver_name"] + "' ,'','','','','" + dr["Sales_Order_Number"].ToString() + "')";
                                command.CommandText = sql;
                                command.ExecuteNonQuery();
                            }
                            Data.Dispose();
                        }
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
        Context.Response.Write(fileName);
    }

    //=========================== Display Trail Balanace Report =====================//

    void ShowTrialBalanceReport(string Date, string SearchText)
    {
        DataTable dt;
        SqlDataAdapter da;

        string FromDate = Date.Substring(0, Date.IndexOf("-"));
        string ToDate = Date.Substring(Date.IndexOf("-") + 1);
        //=============Get Formated Date============================

        string fday = FromDate.Substring(3, 2);
        string fMonth = FromDate.Substring(0, 2);
        string fyear = FromDate.Substring(6);
        string newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
        string Tday = ToDate.Substring(4, 2);
        string TMonth = ToDate.Substring(1, 2);
        string Tyear = ToDate.Substring(7);
        string newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
        {
            SqlCommand cmd = new SqlCommand("[generate_trail_balance]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
            cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;
            cmd.Parameters.Add("@searchtext", SqlDbType.VarChar).Value = SearchText;
            con.Open();
            da = new SqlDataAdapter(cmd);
            DataSet DS = new DataSet();
            da.Fill(DS);
            dt = DS.Tables[0];
        }
        string JSONString = JsonConvert.SerializeObject(dt);
        dt.Dispose();
        Context.Response.Write(JSONString);

    }

    public void TrialBalanceGenerateExcel(string Date, string SearchText)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                DataTable dt;
                SqlDataAdapter da;

                string FromDate = Date.Substring(0, Date.IndexOf("-"));
                string ToDate = Date.Substring(Date.IndexOf("-") + 1);
                //=============Get Formated Date============================

                string fday = FromDate.Substring(3, 2);
                string fMonth = FromDate.Substring(0, 2);
                string fyear = FromDate.Substring(6);
                string newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
                string Tday = ToDate.Substring(4, 2);
                string TMonth = ToDate.Substring(1, 2);
                string Tyear = ToDate.Substring(7);
                string newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
                {
                    SqlCommand cmd = new SqlCommand("[generate_trail_balance]", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
                    cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;
                    cmd.Parameters.Add("@searchtext", SqlDbType.VarChar).Value = SearchText;
                    con.Open();
                    da = new SqlDataAdapter(cmd);
                    DataSet DS = new DataSet();
                    da.Fill(DS);
                    dt = DS.Tables[0];

                    if (dt.Rows.Count > 0)
                    {


                        string AppLocation = HttpContext.Current.Server.MapPath("./Downloaded_Reports/");
                        fileName = "Trial_Balance_" + DateTime.Now.ToString("dd-MM-yyyy").ToString() + ".xlsx";

                        AppLocation += fileName;

                        using (XLWorkbook wb = new XLWorkbook())
                        {
                            IXLWorksheet ws = wb.Worksheets.Add();
                            ws.Name = "Trial Balance";
                            var table1 = ws.Range("A1:G1");
                            table1.Cell(1, 1).Value = "Trial Balance - " + DateTime.Now.ToString("dd-MM-yyyy").ToString();
                            table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                            table1.Cell(1, 1).Style.Font.FontSize = 15;
                            table1.Cell(1, 1).Style.Font.SetBold();
                            table1.Range("A1:G1").Merge();
                            var table2 = ws.Range("A2:G2");
                            //table2.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;
                            table2.Cell(1, 1).Value = "Account Code";
                            table2.Cell(1, 2).Value = "Account Group Name";
                            table2.Cell(1, 3).Value = "Account Name";
                            table2.Cell(1, 4).Value = "Opening Balance";
                            table2.Cell(1, 5).Value = "Debit";
                            table2.Cell(1, 6).Value = "Credit";
                            table2.Cell(1, 7).Value = "Closing Balance";


                            table2.Style.Font.SetBold();
                            table2.Style.Fill.BackgroundColor = XLColor.BlueGray;
                            table2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                            ws.Row(1).Height = 30;
                            ws.Row(2).Height = 30;
                            ws.RowHeight = 22;

                            ws.Column("A").Width = 15;
                            ws.Column("B").Width = 25;
                            ws.Column("C").Width = 45;
                            ws.Column("D").Width = 15;
                            ws.Column("E").Width = 15;
                            ws.Column("F").Width = 15;
                            ws.Column("G").Width = 15;


                            var table4 = ws.Range("A3:G3");
                            int i = 1;
                            foreach (DataRow dr in dt.Rows)
                            {


                                table4.Cell(i, 1).Value = dr["account_code"];

                                table4.Cell(i, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);

                                table4.Cell(i, 2).Value = dr["account_grp_name"];

                                table4.Cell(i, 3).Value = dr["account_name"];

                                table4.Cell(i, 4).Value = dr["opening_bal"];

                                table4.Cell(i, 5).Value = dr["Debits"].ToString();

                                table4.Cell(i, 6).Value = dr["Credits"].ToString(); ;

                                table4.Cell(i, 7).Value = dr["Closing_Balance"].ToString(); ;



                                i++;
                            }

                            //IXLWorksheet ws1 = wb.Worksheets.Add();
                            //ws1.Name = "Trail Balance New";
                            //var WS1table1 = ws1.Range("A1:G1");
                            //WS1table1.Cell(1, 1).Value = "Trail Balance - " + DateTime.Now.ToString("dd-MM-yyyy").ToString();
                            //WS1table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            //WS1table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                            //WS1table1.Cell(1, 1).Style.Font.FontSize = 15;
                            //WS1table1.Cell(1, 1).Style.Font.SetBold();
                            //WS1table1.Range("A1:G1").Merge();

                            wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                            wb.Style.Font.Bold = false;
                            wb.SaveAs(AppLocation);
                            //Context.Response.Write(fileName);


                        }

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
        Context.Response.Write(fileName);
    }

    //=======================Display DN Report Function==================//
    public void ShowTrackingReport(string Date, string txtSearch,string isDateSearch)
    {
        string FromDate = "";
        string ToDate = "";
        string newTdate = "";
        string newFdate = "";
        //=============Get Formated Date============================
        if (isDateSearch.Trim().Equals("1"))
        {   FromDate = Date.Substring(0, Date.IndexOf("-"));
            ToDate = Date.Substring(Date.IndexOf("-") + 1);

            string fday = FromDate.Substring(3, 2);
            string fMonth = FromDate.Substring(0, 2);
            string fyear = FromDate.Substring(6);
            newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
            string Tday = ToDate.Substring(4, 2);
            string TMonth = ToDate.Substring(1, 2);
            string Tyear = ToDate.Substring(7);
            newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
        }
        string _SEARCHFILTER = "";
        if (txtSearch != "")
        {
            _SEARCHFILTER = " where   (a.Sales_Order_Number  like  '%" + txtSearch.Trim() + "%' or   b.Cus_Company_Name  like  '%" + txtSearch.Trim() + "%'  or Employee_Name like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
        }
        else
        {
            _SEARCHFILTER = "";
        }
        string _DateFilter = "";
        if(isDateSearch.Trim().Equals("1"))
        {  if(_SEARCHFILTER=="")
            {
                _DateFilter = " where so_date between '" + newFdate + "' and '" + newTdate+"'";
            }
            else
            {
                _DateFilter = " and so_date between '" + newFdate + "' and '" + newTdate+"'";
            }

        }
        string JSONString = "";
        DataTable Dt = DB.GetDataTable("(select  a.Sales_Order_Number,so_date,c.Division_Name,b.Cus_Company_Name,replace(Employee_Name,',',' ') as salesman,isnull(PO_Number,'') as PO_Number ,isnull(i.PO_Date,'') as PO_Date,isnull(k.Supplier_Name,'')  as Supplier_Name,isnull(MRN_No,'') as MRN_No,isnull(MRN_Date,'') as MRN_Date,Isnull(Delivery_Note_Number,'') as Delivery_Note_Number,isnull(DN_Date,'') as DN_Date  ,isnull(Grn_No,'') as Grn_No ,isnull(Grn_Date,'') as Grn_Date, "
                                       +"isnull( Invoice_Number,'') as Invoice_Number ,isnull(Invoice_Date,'') as Invoice_Date,max(a.Revision_Number) from tbl_sales_order a "
                                        +" left outer join tbl_customer b  on  a.Customer_Id=b.Customer_Id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id "
                                       +" left outer join tbl_employee d on d.Employee_Id=a.Lead_Generator  left outer join tbl_Purchase_Order_Items e on e.Sales_Order_Id=a.Sales_Order_Id "
                                        +"left outer join tbl_Material_Receipt f on e.Purchase_Order_Id = f.Purchase_Order_Id left outer join tbl_Delivery_Note g on g.Sales_Order_Id=a.Sales_Order_Id left outer join tbl_Purchase_Order i on i.Purchase_Order_Id=e.Purchase_Order_Id left outer join tbl_supplier k "
                                        +"on k.supplier_id=i.Supplier_Id left outer join tbl_Sales_Order_Items l  on l.SO_Id=a.Sales_Order_Id left outer join tbl_Invoice_Items m on "
                                       +" m.SO_Item_Id=l.SO_Item_Id left outer join Tbl_Invoice n on n.Invoice_Id=m.Invoice_Id  "+_SEARCHFILTER+_DateFilter+" "
                                       +" group by  a.Sales_Order_Number,so_date,b.Cus_Company_Name,replace(Employee_Name,',',' '),PO_Number,i.PO_Date,k.Supplier_Name,MRN_No,MRN_Date,Delivery_Note_Number,DN_Date  ,grn_no,grn_date,Invoice_Number,Invoice_Date, c.Division_Name "
                                       +" having max(a.Revision_Number)=  (select max(o.Revision_Number) from tbl_Sales_Order o where o.Sales_Order_Number=a.Sales_Order_Number))   order by so_date");

        JSONString = JsonConvert.SerializeObject(Dt);
        Context.Response.Write(JSONString);
        Dt.Dispose();
    }
    //========================Tracking Report Export To Excel  Function==================//
    public void TrackingReportExportToExcel(string Date ,string txtSearch,string isDateSearch)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                string FromDate = "";
                string ToDate = "";
                string newTdate = "";
                string newFdate = "";
                //=============Get Formated Date============================
                if (isDateSearch.Trim().Equals("1"))
                {   FromDate = Date.Substring(0, Date.IndexOf("-"));
                    ToDate = Date.Substring(Date.IndexOf("-") + 1);

                    string fday = FromDate.Substring(3, 2);
                    string fMonth = FromDate.Substring(0, 2);
                    string fyear = FromDate.Substring(6);
                    newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
                    string Tday = ToDate.Substring(4, 2);
                    string TMonth = ToDate.Substring(1, 2);
                    string Tyear = ToDate.Substring(7);
                    newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
                }

                string _SEARCHFILTER = "";
                if (txtSearch != "")
                {
                    _SEARCHFILTER = " where   (a.Sales_Order_Number  like  '%" + txtSearch.Trim() + "%' or   b.Cus_Company_Name  like  '%" + txtSearch.Trim() + "%'  or Employee_Name like  '%" + txtSearch.Trim() + "%'  )";   //Search Builder QUery
                }
                else
                {
                    _SEARCHFILTER = "";
                }
                string _DateFilter = "";
                if(isDateSearch.Trim().Equals("1"))
                {  if(_SEARCHFILTER=="")
                    {
                        _DateFilter = " where so_date between '" + newFdate + "' and '" + newTdate+"'";
                    }
                    else
                    {
                        _DateFilter = " and so_date between '" + newFdate + "' and '" + newTdate+"'";
                    }

                }
                string JSONString = "";
                DataTable Data = DB.GetDataTable("(select  a.Sales_Order_Number, so_date ,c.Division_Name,b.Cus_Company_Name,replace(Employee_Name,',',' ') as salesman,isnull(PO_Number,'') as PO_Number ,isnull(i.PO_Date,'') as PO_Date,isnull(k.Supplier_Name,'')  as Supplier_Name,isnull(MRN_No,'') as MRN_No,isnull(MRN_Date,'') as MRN_Date,Isnull(Delivery_Note_Number,'') as Delivery_Note_Number,isnull(DN_Date,'') as DN_Date  ,isnull(Grn_No,'') as Grn_No ,isnull(Grn_Date,'') as Grn_Date, "
                                               +"isnull( Invoice_Number,'') as Invoice_Number ,isnull(Invoice_Date,'') as Invoice_Date,max(a.Revision_Number) from tbl_sales_order a "
                                                +" left outer join tbl_customer b  on  a.Customer_Id=b.Customer_Id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id "
                                               +" left outer join tbl_employee d on d.Employee_Id=a.Lead_Generator  left outer join tbl_Purchase_Order_Items e on e.Sales_Order_Id=a.Sales_Order_Id "
                                                +"left outer join tbl_Material_Receipt f on e.Purchase_Order_Id = f.Purchase_Order_Id left outer join tbl_Delivery_Note g on g.Sales_Order_Id=a.Sales_Order_Id left outer join tbl_Purchase_Order i on i.Purchase_Order_Id=e.Purchase_Order_Id left outer join tbl_supplier k "
                                                +"on k.supplier_id=i.Supplier_Id left outer join tbl_Sales_Order_Items l  on l.SO_Id=a.Sales_Order_Id left outer join tbl_Invoice_Items m on "
                                               +" m.SO_Item_Id=l.SO_Item_Id left outer join Tbl_Invoice n on n.Invoice_Id=m.Invoice_Id  "+_SEARCHFILTER+_DateFilter+" "
                                               +" group by  a.Sales_Order_Number,so_date,b.Cus_Company_Name,replace(Employee_Name,',',' '),PO_Number,i.PO_Date,k.Supplier_Name,MRN_No,MRN_Date,Delivery_Note_Number,DN_Date  ,grn_no,grn_date,Invoice_Number,Invoice_Date, c.Division_Name "
                                               +" having max(a.Revision_Number)=  (select max(o.Revision_Number) from tbl_Sales_Order o where o.Sales_Order_Number=a.Sales_Order_Number))   order by so_date");

                if (Data.Rows.Count > 0)
                {
                    fileName = "TrackingReport_" + (DateTime.Now.ToShortDateString().Replace("/", "-") + "-" + DateTime.Now.Hour + "-" + DateTime.Now.Minute + "-" + DateTime.Now.Second + "-" + DateTime.Now.Millisecond).ToString() + ".xlsx";
                    System.IO.File.Copy(HttpContext.Current.Server.MapPath("./Templates/Critical-Tracking.xlsx"), HttpContext.Current.Server.MapPath("./Downloaded_Reports/" + fileName + ""), true);
                    string connectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + HttpContext.Current.Server.MapPath("Downloaded_Reports/" + fileName + "") + ";Extended Properties='Excel 8.0;HDR=NO'";
                    using (System.Data.OleDb.OleDbConnection Connection = new System.Data.OleDb.OleDbConnection(connectionString))
                    {
                        Connection.Open();
                        using (System.Data.OleDb.OleDbCommand command = new System.Data.OleDb.OleDbCommand())
                        {
                            command.Connection = Connection;
                            foreach (DataRow dr in Data.Rows)
                            {
                                string SO_date = DateTime.Parse(dr["so_date"].ToString()).ToString("dd-MM-yyyy");

                                string PO_date = "";
                                if(!(dr["PO_Date"].ToString().Contains("1900")||dr["PO_Date"].ToString().Contains("-00")))
                                {
                                    PO_date= DateTime.Parse(dr["PO_Date"].ToString()).ToString("dd-MM-yyyy");
                                }

                                string MRN_Date = "";
                                if(!(dr["MRN_Date"].ToString().Contains("1900")||dr["MRN_Date"].ToString().Contains("-00")))
                                {
                                    MRN_Date = DateTime.Parse(dr["MRN_Date"].ToString()).ToString("dd-MM-yyyy");
                                }
                                string DN_Date = "";
                                if(!(dr["DN_Date"].ToString().Contains("1900")||dr["DN_Date"].ToString().Contains("-00")))
                                {
                                    DN_Date = DateTime.Parse(dr["DN_Date"].ToString()).ToString("dd-MM-yyyy");
                                }
                                string Grn_Date = "";
                                if(!(dr["Grn_Date"].ToString().Contains("1900")||dr["Grn_Date"].ToString().Contains("-00")))
                                {
                                    Grn_Date = DateTime.Parse(dr["Grn_Date"].ToString()).ToString("dd-MM-yyyy");
                                }
                                string Invoice_Date = "";
                                if(!(dr["Invoice_Date"].ToString().Contains("1900")||dr["Invoice_Date"].ToString().Contains("-00")))
                                {
                                    Invoice_Date = DateTime.Parse(dr["Invoice_Date"].ToString()).ToString("dd-MM-yyyy");
                                }
                                string sql = "INSERT INTO [Sheet1$](F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11,F12,F13,F14,F15,F16) VALUES('" + dr["Sales_Order_Number"].ToString() + "','" +SO_date + "','"+dr["Cus_Company_Name"]+"','" + dr["Division_Name"].ToString() + "','" + dr["salesman"].ToString() + "','" + dr["PO_Number"].ToString() + "' , '" + PO_date + "' ,'"+dr["Supplier_Name"]+"','"+dr["MRN_No"]+"','"+MRN_Date+"','"+dr["Delivery_Note_Number"]+"','" + DN_Date.ToString() + "','"+dr["Grn_No"]+"','"+Grn_Date+"','"+dr["Invoice_Number"]+"','"+Invoice_Date+"')";
                                command.CommandText = sql;
                                command.ExecuteNonQuery();
                            }
                            Data.Dispose();
                        }
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
        Context.Response.Write(fileName);
    }


    //===============================================Aging Analysis Report======================================
    public void AgingAnalysis(string Date ,string txtSearch,string isDateSearch)
    {

        DataTable dt;
        SqlDataAdapter da;
        string FromDate = "";
        string ToDate = "";
        string fday = "";
        string fMonth = "";
        string fyear = "";
        string newFdate = "";
        string Tday = "";
        string TMonth = "";
        string Tyear ="";
        string newTdate = "";
        if (Date != "")
        {
            FromDate = Date.Substring(0, Date.IndexOf("-"));
            ToDate = Date.Substring(Date.IndexOf("-") + 1);
            //=============Get Formated Date============================

            fday = FromDate.Substring(3, 2);
            fMonth = FromDate.Substring(0, 2);
            fyear = FromDate.Substring(6);
            newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
            Tday = ToDate.Substring(4, 2);
            TMonth = ToDate.Substring(1, 2);
            Tyear = ToDate.Substring(7);
            newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
        }
        else
        {
            newFdate = "2020-01-01";
            newTdate = "2021-12-12";
        }
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
        {
            SqlCommand cmd = new SqlCommand("[aging_analysis_report]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
            cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;
            cmd.Parameters.Add("@searchtext", SqlDbType.VarChar).Value = txtSearch;
            con.Open();
            da = new SqlDataAdapter(cmd);
            DataSet DS = new DataSet();
            da.Fill(DS);
            dt = DS.Tables[0];
        }
        string JSONString = JsonConvert.SerializeObject(dt);
        dt.Dispose();
        Context.Response.Write(JSONString);


    }
    //===============================================Aging Analysis Report======================================
    public void SupplierAgingAnalysis(string Date ,string txtSearch,string isDateSearch)
    {

        DataTable dt;
        SqlDataAdapter da;
        string FromDate = "";
        string ToDate = "";
        string fday = "";
        string fMonth = "";
        string fyear = "";
        string newFdate = "";
        string Tday = "";
        string TMonth = "";
        string Tyear ="";
        string newTdate = "";
        if (Date != "")
        {
            FromDate = Date.Substring(0, Date.IndexOf("-"));
            ToDate = Date.Substring(Date.IndexOf("-") + 1);
            //=============Get Formated Date============================

            fday = FromDate.Substring(3, 2);
            fMonth = FromDate.Substring(0, 2);
            fyear = FromDate.Substring(6);
            newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
            Tday = ToDate.Substring(4, 2);
            TMonth = ToDate.Substring(1, 2);
            Tyear = ToDate.Substring(7);
            newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
        }
        else
        {
            newFdate = "2020-01-01";
            newTdate = "2021-12-12";
        }
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
        {
            SqlCommand cmd = new SqlCommand("[aging_analysis_report_supplier]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
            cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;
            cmd.Parameters.Add("@searchtext", SqlDbType.VarChar).Value = txtSearch;
            con.Open();
            da = new SqlDataAdapter(cmd);
            DataSet DS = new DataSet();
            da.Fill(DS);
            dt = DS.Tables[0];
        }
        string JSONString = JsonConvert.SerializeObject(dt);
        dt.Dispose();
        Context.Response.Write(JSONString);


    }
    //========================Delivery Note  Export To Excel  Function==================//
    public void AgingAnalysisExportToExcel(string Date ,string txtSearch,string isDateSearch)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                DataTable Dt;
                SqlDataAdapter da;
                string FromDate = "";
                string ToDate = "";
                string fday = "";
                string fMonth = "";
                string fyear = "";
                string newFdate = "";
                string Tday = "";
                string TMonth = "";
                string Tyear ="";
                string newTdate = "";
                if (Date != "")
                {
                    FromDate = Date.Substring(0, Date.IndexOf("-"));
                    ToDate = Date.Substring(Date.IndexOf("-") + 1);
                    //=============Get Formated Date============================

                    fday = FromDate.Substring(3, 2);
                    fMonth = FromDate.Substring(0, 2);
                    fyear = FromDate.Substring(6);
                    newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
                    Tday = ToDate.Substring(4, 2);
                    TMonth = ToDate.Substring(1, 2);
                    Tyear = ToDate.Substring(7);
                    newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
                }
                else
                {
                    //newFdate = "2020-01-01";
                    //newTdate = "2021-12-12";
                }
                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
                {
                    SqlCommand cmd = new SqlCommand("[aging_analysis_report]", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
                    cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;
                    cmd.Parameters.Add("@searchtext", SqlDbType.VarChar).Value = txtSearch;
                    con.Open();
                    da = new SqlDataAdapter(cmd);
                    DataSet DS = new DataSet();
                    da.Fill(DS);
                    Dt = DS.Tables[0];
                }

                if (Dt.Rows.Count > 0)
                {
                    string AppLocation = HttpContext.Current.Server.MapPath("./Downloaded_Reports/");
                    fileName = "Customer_Aging_Analysis_" + DateTime.Now.ToString("dd-MM-yyyy").ToString() + ".xlsx";

                    AppLocation += fileName;
                    decimal closingBalance = 0;
                    decimal a = 0;
                    decimal b = 0;
                    decimal c = 0;
                    decimal d = 0;
                    decimal e = 0;
                    decimal above180 = 0;
                    using (XLWorkbook wb = new XLWorkbook())
                    {
                        IXLWorksheet ws = wb.Worksheets.Add();

                        var table1 = ws.Range("A1:I1");
                        table1.Cell(1, 1).Value = "Customer Aging Analysis - " + DateTime.Now.ToString("dd-MM-yyyy").ToString();
                        table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        table1.Cell(1, 1).Style.Font.FontSize = 15;
                        table1.Cell(1, 1).Style.Font.SetBold();
                        table1.Range("A1:I1").Merge();
                        var table2 = ws.Range("A2:I2");
                        //table2.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;
                        table2.Cell(1, 1).Value = "Account Code";
                        table2.Cell(1, 2).Value = "Customer Name";
                        table2.Cell(1, 3).Value = "Closing Balance";
                        table2.Cell(1, 4).Value = "[0-30]";
                        table2.Cell(1, 5).Value = "[31-60]";
                        table2.Cell(1, 6).Value = "[61-90]";
                        table2.Cell(1, 7).Value = "[91-120]";
                        table2.Cell(1, 8).Value = "[121-180]";
                        table2.Cell(1, 9).Value = "[Above-180]";

                        table2.Style.Font.SetBold();
                        table2.Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                        ws.Row(1).Height = 30;
                        ws.Row(2).Height = 30;
                        ws.RowHeight = 22;

                        ws.Column("A").Width = 20;
                        ws.Column("B").Width = 50;
                        ws.Column("C").Width = 30;
                        ws.Column("D").Width = 15;
                        ws.Column("E").Width = 15;
                        ws.Column("F").Width = 15;
                        ws.Column("G").Width = 15;
                        ws.Column("H").Width = 15;
                        ws.Column("I").Width = 15;


                        var table4 = ws.Range("A3:I3");
                        int i = 1;
                        foreach (DataRow dr in Dt.Rows)
                        {
                            closingBalance += decimal.Parse(dr["CLOSING_BALANCE"].ToString());
                            a += decimal.Parse(dr["a"].ToString());
                            b += decimal.Parse(dr["b"].ToString());
                            c += decimal.Parse(dr["c"].ToString());
                            d += decimal.Parse(dr["d"].ToString());
                            e += decimal.Parse(dr["e"].ToString());
                            above180 += decimal.Parse(dr["above180"].ToString());
                            // table.Cell(i, 1).Style.Font 
                            table4.Cell(i, 1).Value = dr["Account_Code"];
                            table4.Cell(i, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                            table4.Cell(i, 2).Value = dr["Cus_Company_Name"];
                            table4.Cell(i, 3).Value = dr["CLOSING_BALANCE"];
                            //table4.Cell(i, 3).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 4).Value = dr["a"];
                            //table4.Cell(i, 4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 5).Value = dr["b"].ToString();
                            // table4.Cell(i, 5).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 6).Value = dr["c"].ToString(); ;
                            // table4.Cell(i, 6).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 7).Value = dr["d"].ToString(); ;
                            // table4.Cell(i, 7).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 8).Value = dr["e"].ToString(); ;
                            // table4.Cell(i, 8).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 9).Value = dr["ABOVE180"].ToString(); ;
                            //  table4.Cell(i, 9).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                            i++;
                        }
                        //string a = i.ToString();
                        var table5 = ws.Range("A" + (i + 3) + ":I" + (i + 3));
                        table5.Cell(1, 1).Value = "Grand Total";
                        table5.Style.Font.SetBold();
                        table5.Style.Fill.BackgroundColor = XLColor.Gray;

                        table5.Cell(1, 2).Value = "-";
                        table5.Cell(1, 3).Value = closingBalance;
                        table5.Cell(1, 4).Value = a;
                        table5.Cell(1, 5).Value = b;
                        table5.Cell(1, 6).Value = c;
                        table5.Cell(1, 7).Value = d;
                        table5.Cell(1, 8).Value = e;
                        table5.Cell(1, 9).Value = above180;


                        wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                        wb.Style.Font.Bold = false;
                        wb.SaveAs(AppLocation);
                        //Context.Response.Write(fileName);
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
        Context.Response.Write(fileName);
    }

    //========================SupAgingAnalysisExportToExcel Function==================//
    public void SupAgingAnalysisExportToExcel(string Date ,string txtSearch,string isDateSearch)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                DataTable Dt;
                SqlDataAdapter da;
                string FromDate = "";
                string ToDate = "";
                string fday = "";
                string fMonth = "";
                string fyear = "";
                string newFdate = "";
                string Tday = "";
                string TMonth = "";
                string Tyear = "";
                string newTdate = "";
                if (Date != "")
                {
                    FromDate = Date.Substring(0, Date.IndexOf("-"));
                    ToDate = Date.Substring(Date.IndexOf("-") + 1);
                    //=============Get Formated Date============================

                    fday = FromDate.Substring(3, 2);
                    fMonth = FromDate.Substring(0, 2);
                    fyear = FromDate.Substring(6);
                    newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
                    Tday = ToDate.Substring(4, 2);
                    TMonth = ToDate.Substring(1, 2);
                    Tyear = ToDate.Substring(7);
                    newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
                }
                else
                {
                    //newFdate = "2020-01-01";
                    //newTdate = "2021-12-12";
                }
                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
                {
                    SqlCommand cmd = new SqlCommand("[aging_analysis_report_supplier]", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
                    cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;
                    cmd.Parameters.Add("@searchtext", SqlDbType.VarChar).Value = txtSearch;
                    con.Open();
                    da = new SqlDataAdapter(cmd);
                    DataSet DS = new DataSet();
                    da.Fill(DS);
                    Dt = DS.Tables[0];
                }

                if (Dt.Rows.Count > 0)
                {
                    string AppLocation = HttpContext.Current.Server.MapPath("./Downloaded_Reports/");
                    fileName = "Supplier_Aging_Analysis_" +  DateTime.Now.ToString("dd-MM-yyyy").ToString() + ".xlsx";

                    AppLocation += fileName;
                    decimal closingBalance = 0;
                    decimal a = 0;
                    decimal b = 0;
                    decimal c = 0;
                    decimal d = 0;
                    decimal e = 0;
                    decimal above180 = 0;
                    using (XLWorkbook wb = new XLWorkbook())
                    {
                        IXLWorksheet ws = wb.Worksheets.Add();

                        var table1 = ws.Range("A1:I1");
                        table1.Cell(1, 1).Value = "Supplier Aging Analysis - " + DateTime.Now.ToString("dd-MM-yyyy").ToString();
                        table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        table1.Cell(1, 1).Style.Font.FontSize = 15;
                        table1.Cell(1, 1).Style.Font.SetBold();
                        table1.Range("A1:I1").Merge();
                        var table2 = ws.Range("A2:I2");
                        //table2.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;
                        table2.Cell(1, 1).Value = "Account Code";
                        table2.Cell(1, 2).Value = "Supplier Name";
                        table2.Cell(1, 3).Value = "Closing Balance";
                        table2.Cell(1, 4).Value = "[0-30]";
                        table2.Cell(1, 5).Value = "[31-60]";
                        table2.Cell(1, 6).Value = "[61-90]";
                        table2.Cell(1, 7).Value = "[69-120]";
                        table2.Cell(1, 8).Value = "[121-180]";
                        table2.Cell(1, 9).Value = "[Above-180]";

                        table2.Style.Font.SetBold();
                        table2.Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                        ws.Row(1).Height = 30;
                        ws.Row(2).Height = 30;
                        ws.RowHeight = 22;

                        ws.Column("A").Width = 20;
                        ws.Column("B").Width = 50;
                        ws.Column("C").Width = 30;
                        ws.Column("D").Width = 15;
                        ws.Column("E").Width = 15;
                        ws.Column("F").Width = 15;
                        ws.Column("G").Width = 15;
                        ws.Column("H").Width = 15;
                        ws.Column("I").Width = 15;


                        var table4 = ws.Range("A3:I3");
                        int i = 1;
                        foreach (DataRow dr in Dt.Rows)
                        {
                            closingBalance += decimal.Parse(dr["CLOSING_BALANCE"].ToString());
                            a += decimal.Parse(dr["a"].ToString());
                            b += decimal.Parse(dr["b"].ToString());
                            c += decimal.Parse(dr["c"].ToString());
                            d += decimal.Parse(dr["d"].ToString());
                            e += decimal.Parse(dr["e"].ToString());
                            above180 += decimal.Parse(dr["above180"].ToString());
                            // table.Cell(i, 1).Style.Font 
                            table4.Cell(i, 1).Value = dr["Account_Code"];
                            table4.Cell(i, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                            table4.Cell(i, 2).Value = dr["Supplier_Name"];
                            table4.Cell(i, 3).Value = dr["CLOSING_BALANCE"];
                            //table4.Cell(i, 3).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 4).Value = dr["a"];
                            //table4.Cell(i, 4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 5).Value = dr["b"].ToString();
                            // table4.Cell(i, 5).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 6).Value = dr["c"].ToString(); ;
                            // table4.Cell(i, 6).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 7).Value = dr["d"].ToString(); ;
                            // table4.Cell(i, 7).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 8).Value = dr["e"].ToString(); ;
                            // table4.Cell(i, 8).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 9).Value = dr["ABOVE180"].ToString(); ;
                            //  table4.Cell(i, 9).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                            i++;
                        }
                        //string a = i.ToString();
                        var table5 = ws.Range("A"+(i+3)+":I"+(i+3));
                        table5.Cell(1, 1).Value = "Grand Total";
                        table5.Style.Font.SetBold();
                        table5.Style.Fill.BackgroundColor = XLColor.Gray;

                        table5.Cell(1, 2).Value = "-";
                        table5.Cell(1, 3).Value = closingBalance;
                        table5.Cell(1, 4).Value = a;
                        table5.Cell(1, 5).Value = b;
                        table5.Cell(1, 6).Value = c;
                        table5.Cell(1, 7).Value = d;
                        table5.Cell(1, 8).Value = e;
                        table5.Cell(1, 9).Value = above180;


                        wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                        wb.Style.Font.Bold = false;
                        wb.SaveAs(AppLocation);
                        //Context.Response.Write(fileName);
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
        Context.Response.Write(fileName);
    }

    void BindDdlAssetCategory()
    {
        string JSONString = "";
        string sql = "Select Name from tbl_EquipmentCategory";
        DataTable dt = DB.GetDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
            Context.Response.Write(JSONString);
        }

        dt.Dispose();
    }

    //=======================Display Asset Register Report Function==================//

    public void ShowAssetRegisterReport(string category, string fromDate, string toDate, string asOfDate)
    {
        string _SEARCHFILTER = "";
        if (!string.IsNullOrEmpty(category) && category != "0")
        {
            _SEARCHFILTER = "@category='" + category + "'";
        }



        if (!string.IsNullOrEmpty(fromDate))
        {
            if (!string.IsNullOrEmpty(_SEARCHFILTER))
                _SEARCHFILTER = _SEARCHFILTER + ',';

            _SEARCHFILTER += " @fromPurchaseDate='" + fromDate.Trim() + "'";
        }

        if (!string.IsNullOrEmpty(toDate))
        {
            if (!string.IsNullOrEmpty(_SEARCHFILTER))
                _SEARCHFILTER = _SEARCHFILTER + ',';

            _SEARCHFILTER += " @toPurchaseDate='" + toDate.Trim() + "'";
        }

        if (!string.IsNullOrEmpty(asOfDate))
        {
            if (!string.IsNullOrEmpty(_SEARCHFILTER))
                _SEARCHFILTER = _SEARCHFILTER + ',';

            _SEARCHFILTER += " @asOf='" + asOfDate.Trim() + "'";
        }

        string JSONString = "";


        DataTable Dt = DB.GetDataTable("execute [dbo].[get_asset_register]" + _SEARCHFILTER);

        JSONString = JsonConvert.SerializeObject(Dt);
        Context.Response.Write(JSONString);
        Dt.Dispose();
    }

    public void AssetRegisterReportExportToExcel(string category, string fromDate, string toDate, string asOfDate)
    {
        string _SEARCHFILTER = "";
        if (!string.IsNullOrEmpty(category) && category != "0")
        {
            _SEARCHFILTER = "@category='" + category + "'";
        }



        if (!string.IsNullOrEmpty(fromDate))
        {
            if (!string.IsNullOrEmpty(_SEARCHFILTER))
                _SEARCHFILTER = _SEARCHFILTER + ',';

            _SEARCHFILTER += " @fromPurchaseDate='" + fromDate.Trim() + "'";
        }

        if (!string.IsNullOrEmpty(toDate))
        {
            if (!string.IsNullOrEmpty(_SEARCHFILTER))
                _SEARCHFILTER = _SEARCHFILTER + ',';

            _SEARCHFILTER += " @toPurchaseDate='" + toDate.Trim() + "'";
        }

        if (!string.IsNullOrEmpty(asOfDate))
        {
            if (!string.IsNullOrEmpty(_SEARCHFILTER))
                _SEARCHFILTER = _SEARCHFILTER + ',';

            _SEARCHFILTER += " @asOf='" + asOfDate.Trim() + "'";
        }

        string JSONString = "";

        var filename = "Asset Register Report-" + (DateTime.Now.ToShortDateString().Replace("/", "-") + "-" + DateTime.Now.Hour + "-" + DateTime.Now.Minute + "-" + DateTime.Now.Second + "-" + DateTime.Now.Millisecond).ToString() + ".xlsx";
        DataTable Dt = DB.GetDataTable("execute [dbo].[get_asset_register]" + _SEARCHFILTER);

        if (Dt.Rows.Count > 0)
        {
            string writer = null;
            using (XLWorkbook wb = new XLWorkbook())
            {

                wb.Worksheets.Add(Dt, "Asset Register Report");

                using (MemoryStream stream = new MemoryStream())
                {
                    wb.SaveAs(stream);
                    //Context.Response.AddHeader("content-disposition", "attachment; filename=FileName.xls");
                    Context.Response.Clear();
                    Context.Response.Buffer = true;
                    Context.Response.AddHeader("content-disposition", "attachment; filename=" + Context.Server.UrlEncode(filename));
                    Context.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Context.Response.BinaryWrite(stream.ToArray());
                }
            }

        }
    }

    public void ShowEmployeeAdvances(string Date, string txtSearch,string isDateSearch)
    {
        string FromDate = "";
        string ToDate = "";
        string newTdate = "";
        string newFdate = "";
        DataTable Dt=new DataTable();
        SqlDataAdapter da=new SqlDataAdapter();
        //=============Get Formated Date============================
        if (isDateSearch.Trim().Equals("1"))
        {   FromDate = Date.Substring(0, Date.IndexOf("-"));
            ToDate = Date.Substring(Date.IndexOf("-") + 1);

            string fday = FromDate.Substring(3, 2);
            string fMonth = FromDate.Substring(0, 2);
            string fyear = FromDate.Substring(6);
            newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
            string Tday = ToDate.Substring(4, 2);
            string TMonth = ToDate.Substring(1, 2);
            string Tyear = ToDate.Substring(7);
            newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
        }
        else
        {
            newFdate = "2020-01-01";
            string Todaysdate = DateTime.Now.ToString("yyyy-MM-dd").ToString();
            newTdate = Todaysdate.ToString();
        }

        string JSONString = "";
        //DataTable Dt = 

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
        {
            SqlCommand cmd = new SqlCommand("[get_employee_balances]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
            cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;
            cmd.Parameters.Add("@searchtext", SqlDbType.VarChar).Value = txtSearch;
            con.Open();
            da = new SqlDataAdapter(cmd);
            DataSet DS = new DataSet();
            da.Fill(DS);
            Dt = DS.Tables[0];
        }

        JSONString = JsonConvert.SerializeObject(Dt);
        Context.Response.Write(JSONString);
        Dt.Dispose();
    }

    public void EmployeeAdvancesExportToExcel(string Date, string txtSearch, string isDateSearch)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                DataTable Dt;
                SqlDataAdapter da;
                string FromDate = "";
                string ToDate = "";
                string fday = "";
                string fMonth = "";
                string fyear = "";
                string newFdate = "";
                string Tday = "";
                string TMonth = "";
                string Tyear = "";
                string newTdate = "";
                if (isDateSearch.Trim().Equals("1"))
                {
                    FromDate = Date.Substring(0, Date.IndexOf("-"));
                    ToDate = Date.Substring(Date.IndexOf("-") + 1);
                    //=============Get Formated Date============================

                    fday = FromDate.Substring(3, 2);
                    fMonth = FromDate.Substring(0, 2);
                    fyear = FromDate.Substring(6);
                    newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
                    Tday = ToDate.Substring(4, 2);
                    TMonth = ToDate.Substring(1, 2);
                    Tyear = ToDate.Substring(7);
                    newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
                }
                else
                {
                    newFdate = "2020-01-01";
                    string Todaysdate = DateTime.Now.ToString("yyyy-MM-dd").ToString();
                    newTdate = Todaysdate.ToString();
                }
                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
                {
                    SqlCommand cmd = new SqlCommand("[get_employee_balances]", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
                    cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;
                    cmd.Parameters.Add("@searchtext", SqlDbType.VarChar).Value = txtSearch;
                    con.Open();
                    da = new SqlDataAdapter(cmd);
                    DataSet DS = new DataSet();
                    da.Fill(DS);
                    Dt = DS.Tables[0];
                }

                if (Dt.Rows.Count > 0)
                {
                    string AppLocation = HttpContext.Current.Server.MapPath("./Downloaded_Reports/");
                    fileName = "Employee_Advances_" + DateTime.Now.ToString("dd-MM-yyyy").ToString() + ".xlsx";

                    AppLocation += fileName;

                    using (XLWorkbook wb = new XLWorkbook())
                    {
                        IXLWorksheet ws = wb.Worksheets.Add();

                        var table1 = ws.Range("A1:F1");
                        table1.Cell(1, 1).Value = "Employee Advances  - " + DateTime.Now.ToString("dd-MM-yyyy").ToString();
                        table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        table1.Cell(1, 1).Style.Font.FontSize = 15;
                        table1.Cell(1, 1).Style.Font.SetBold();
                        table1.Range("A1:F1").Merge();
                        var table2 = ws.Range("A2:F2");
                        //table2.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;
                        table2.Cell(1, 1).Value = "Account Code";
                        table2.Cell(1, 2).Value = "Employee Name";
                        table2.Cell(1, 3).Value = "Debit";
                        table2.Cell(1, 4).Value = "Credit";
                        table2.Cell(1, 5).Value = "Balance";
                        table2.Cell(1, 6).Value = "Narration";


                        table2.Style.Font.SetBold();
                        table2.Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                        ws.Row(1).Height = 30;
                        ws.Row(2).Height = 30;
                        ws.RowHeight = 22;

                        ws.Column("A").Width = 20;
                        ws.Column("B").Width = 50;
                        ws.Column("C").Width = 30;
                        ws.Column("D").Width = 15;
                        ws.Column("E").Width = 15;
                        ws.Column("F").Width = 60;



                        var table4 = ws.Range("A3:I3");
                        int i = 1;
                        foreach (DataRow dr in Dt.Rows)
                        {

                            // table.Cell(i, 1).Style.Font 
                            table4.Cell(i, 1).Value = dr["account_code"];
                            table4.Cell(i, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                            table4.Cell(i, 2).Value = dr["account_name"];
                            table4.Cell(i, 3).Value = dr["debit"];
                            //table4.Cell(i, 3).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 4).Value = dr["credit"];
                            //table4.Cell(i, 4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 5).Value = (decimal.Parse(dr["debit"].ToString()) - decimal.Parse(dr["credit"].ToString())).ToString();
                            // table4.Cell(i, 5).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            table4.Cell(i, 6).Value = dr["narration"].ToString();
                            // table4.Cell(i, 6).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                            i++;
                        }



                        wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                        wb.Style.Font.Bold = false;
                        wb.SaveAs(AppLocation);
                        //Context.Response.Write(fileName);
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
        Context.Response.Write(fileName);
    }
    void ShowConsolidatedPl(string Date, string txtSearch,string isDateSearch)
    {
        string FromDate = "";
        string ToDate = "";
        string newTdate = "";
        string newFdate = "";
        DataTable Dt=new DataTable();
        SqlDataAdapter da=new SqlDataAdapter();
        string OutPut = "";
        //=============Get Formated Date============================
        if (isDateSearch.Trim().Equals("1"))
        {
            FromDate = Date.Substring(0, Date.IndexOf("-"));
            ToDate = Date.Substring(Date.IndexOf("-") + 1);

            string fday = FromDate.Substring(3, 2);
            string fMonth = FromDate.Substring(0, 2);
            string fyear = FromDate.Substring(6);
            newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
            string Tday = ToDate.Substring(4, 2);
            string TMonth = ToDate.Substring(1, 2);
            string Tyear = ToDate.Substring(7);
            newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
            //}
            //else
            //{
            //    newFdate = "2020-01-01";
            //    string Todaysdate = DateTime.Now.ToString("yyyy-MM-dd").ToString();
            //    newTdate = Todaysdate.ToString();
            //}


            //DataTable Dt = 

            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
            {
                SqlCommand cmd = new SqlCommand("[generate_consolidated_pl_report]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
                cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;

                con.Open();
                da = new SqlDataAdapter(cmd);
                DataSet DS = new DataSet();
                da.Fill(DS);
                // Dt = DB.GetDataTable("[dbo].[generate_consolidated_pl_report]  @fr_date = N'"+newFdate+"',@to_date = N'"+newTdate+"'");
                Dt = DS.Tables[0];
            }
            int i = 0;
            DataTable dtnew = Dt.Copy();
            foreach(DataColumn DC in Dt.Columns)
            {
                if(i>(Convert.ToInt32(TMonth)+1) && i<14)
                {
                    string abc = DC.ToString();
                    dtnew.Columns.Remove(abc);
                }
                i++;
            }
            dtnew.AcceptChanges();
            OutPut+= "<thead><tr>";
            foreach (DataColumn DC in dtnew.Columns)
            {
                if(DC.ToString()=="ord_id")
                {
                    OutPut += "<th>S.No.</th>";
                }
                else if(DC.ToString()=="pl_desc")
                {
                    OutPut += "<th>PL Descroption</th>";
                }
                else
                {
                    string Header = DC.ToString().ToUpper();
                    OutPut += "<th>"+Header+"</th>";
                }


            }
            OutPut += "</tr></thead>";
            OutPut += "<tbody id='tbodyConsolidatedPl'>";
            int k = 0;
            string ColHeader = "";
            foreach(DataRow Dr in dtnew.Rows)
            {
                OutPut += "<tr>";
                foreach (DataColumn DC in dtnew.Columns)
                { ColHeader = DC.ToString();
                    OutPut += "<td>"+dtnew.Rows[k][ColHeader]+"</td>";
                }
                OutPut += "</tr>";
                k++;
            }
            OutPut += "</tbody></table>";
            dtnew.Dispose();
        }

        Dt.Dispose();
        Context.Response.Write(OutPut);

    }
    public void ExportConsolidatedPl(string Date, string txtSearch, string isDateSearch)
    {
        string fileName = "";
        try
        {
            if (G.HL() == true)
            {
                DataTable Dt;
                SqlDataAdapter da;
                string FromDate = "";
                string ToDate = "";
                string fday = "";
                string fMonth = "";
                string fyear = "";
                string newFdate = "";
                string Tday = "";
                string TMonth = "";
                string Tyear = "";
                string newTdate = "";
                string PrintFrom = "";
                string PrintTO = "";
                if (isDateSearch.Trim().Equals("1"))
                {
                    FromDate = Date.Substring(0, Date.IndexOf("-"));
                    ToDate = Date.Substring(Date.IndexOf("-") + 1);
                    //=============Get Formated Date============================

                    fday = FromDate.Substring(3, 2);
                    fMonth = FromDate.Substring(0, 2);
                    fyear = FromDate.Substring(6);
                    newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
                    PrintFrom= fday.Trim() + "-" + fMonth.Trim() + "-" + fyear.Trim();

                    Tday = ToDate.Substring(4, 2);
                    TMonth = ToDate.Substring(1, 2);
                    Tyear = ToDate.Substring(7);
                    newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
                    PrintTO = Tday.Trim() + "-" + TMonth.Trim()  + "-"+ Tyear.Trim();
                }

                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
                {
                    SqlCommand cmd = new SqlCommand("[generate_consolidated_pl_report]", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
                    cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;

                    con.Open();
                    da = new SqlDataAdapter(cmd);
                    DataSet DS = new DataSet();
                    da.Fill(DS);
                    // Dt = DB.GetDataTable("[dbo].[generate_consolidated_pl_report]  @fr_date = N'"+newFdate+"',@to_date = N'"+newTdate+"'");
                    Dt = DS.Tables[0];
                }
                int i = 0;
                DataTable dtnew = Dt.Copy();
                foreach(DataColumn DC in Dt.Columns)
                {
                    if(i>(Convert.ToInt32(TMonth)+1) && i<14)
                    {
                        string abc = DC.ToString();
                        dtnew.Columns.Remove(abc);
                    }
                    i++;
                }
                string ToRange = "";
                switch (TMonth)
                {
                    case "01":ToRange = "D"; break;
                    case "02":ToRange = "E"; break;
                    case "03":ToRange = "F"; break;
                    case "04":ToRange = "G"; break;
                    case "05":ToRange = "H"; break;
                    case "06":ToRange = "I"; break;
                    case "07":ToRange = "J"; break;
                    case "08":ToRange = "K"; break;
                    case "09":ToRange = "L"; break;
                    case "10":ToRange = "M"; break;
                    case "11":ToRange = "N"; break;
                    case "12":ToRange = "O"; break;

                }
                dtnew.AcceptChanges();

                if (dtnew.Rows.Count > 0)
                {
                    string AppLocation = HttpContext.Current.Server.MapPath("./Downloaded_Reports/");
                    fileName = "Consolidated_Pl_Report_" + DateTime.Now.ToString("dd-MM-yyyy").ToString() + ".xlsx";

                    AppLocation += fileName;

                    using (XLWorkbook wb = new XLWorkbook())
                    {
                        IXLWorksheet ws = wb.Worksheets.Add();
                        var table0=ws.Range("A1:"+ToRange.Trim()+"1");
                        table0.Cell(1, 1).Value = "Current Date " + DateTime.Now.ToString("dd-MM-yyyy").ToString();
                        table0.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                        table0.Range("A1:"+ToRange.Trim()+"1").Merge();
                        ws.Row(1).Height = 15;

                        var table1 = ws.Range("A2:"+ToRange.Trim()+"2");
                        table1.Cell(1, 1).Value = "Consolidated Pl Report - (" + PrintFrom + " To " + PrintTO+")";//DateTime.Now.ToString("dd-MM-yyyy").ToString();
                        table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                        table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        table1.Cell(1, 1).Style.Font.FontSize = 15;
                        table1.Cell(1, 1).Style.Font.SetBold();
                        table1.Range("A2:"+ToRange.Trim()+"2").Merge();
                        var table2 = ws.Range("A3:"+ToRange.Trim()+"3");;
                        //table2.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;
                        int J = 1;
                        foreach (DataColumn DC in dtnew.Columns)
                        {
                            if(DC.ToString()=="ord_id")
                            {
                                table2.Cell(1, J).Value = "S.No.";
                                ws.Column("A").Width = 10;
                            }
                            else if(DC.ToString()=="pl_desc")
                            {

                                table2.Cell(1, J).Value = "PL Description";
                                ws.Column("B").Width = 30;
                            }
                            else
                            {
                                string Header = DC.ToString().ToUpper();
                                table2.Cell(1, J).Value = Header;
                                ws.Column(J).Width = 15;
                            }

                            J++;

                        }




                        table2.Style.Font.SetBold();
                        table2.Style.Fill.BackgroundColor = XLColor.BlueGray;
                        table2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                        ws.Row(2).Height = 30;
                        ws.Row(3).Height = 25;
                        ws.RowHeight = 20;





                        var table4 = ws.Range("A4:"+ToRange.Trim()+"4");
                        int K = 0;
                        J = 1;
                        string ColHeader = "";
                        foreach (DataRow dr in Dt.Rows)
                        {

                            foreach (DataColumn DC in dtnew.Columns)
                            { ColHeader = DC.ToString();

                                table4.Cell(K+1, J).Value = dtnew.Rows[K][ColHeader];
                                table4.Cell(K+1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                                J++;
                            }
                            J = 1;
                            K++;
                        }



                        wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                        wb.Style.Font.Bold = false;
                        wb.SaveAs(AppLocation);
                        //Context.Response.Write(fileName);
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
        Context.Response.Write(fileName);
    }

    void ShowJobCosting(string Date, string txtSearch,string isDateSearch)
    {
        string FromDate = "";
        string ToDate = "";
        string newTdate = "";
        string newFdate = "";
        string datefilter = "";
        string SearchFilter = "";
        SqlDataAdapter da=new SqlDataAdapter();
        string OutPut = "";
        //=============Get Formated Date============================
        if (isDateSearch.Trim().Equals("1"))
        {
            FromDate = Date.Substring(0, Date.IndexOf("-"));
            ToDate = Date.Substring(Date.IndexOf("-") + 1);

            string fday = FromDate.Substring(3, 2);
            string fMonth = FromDate.Substring(0, 2);
            string fyear = FromDate.Substring(6);
            newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
            string Tday = ToDate.Substring(4, 2);
            string TMonth = ToDate.Substring(1, 2);
            string Tyear = ToDate.Substring(7);
            newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();

            datefilter = " and posted_date between '" + newFdate + "' and '" + newTdate + "'";
        }
        else
        {
            //newFdate = "2020-01-01";
            //string Todaysdate = DateTime.Now.ToString("yyyy-MM-dd").ToString();
            //newTdate = Todaysdate.ToString();
        }

        if(txtSearch!="")
        {
            SearchFilter=" and Job_Number like '%"+txtSearch+"%'";
        }

        DataTable Dt = DB.GetDataTable("select  Job_Number,sum(credit) Revenue  "
                                       + " from tbl_ledger_extension a,tbl_Journal_Entry  b, tbl_Ledger_Account c where a.journal_entry_id=b.Journal_Entry_Id"
                                       + datefilter+SearchFilter +"  and  b.Account_Code=c.Account_Code and entry_type LIKE 'FREIGHTINVOICE%' and c.Account_Code like '31%' "
                                       + " and job_number is not null and job_number !='0' group by Job_Number");



        int i = 0;
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow Dr in Dt.Rows)
            {
                OutPut += " <li id='" + Dr["Job_Number"] + "' onclick=BindJobCostDetails('"+Dr["Job_Number"]+"',"+i+") class='treeview'><a href='#'><div class='row'><span class='col-md-8 colmd8'>Job No.("+Dr["Job_Number"]+")</span>  <span class='col-md-2 colmd2'><label id='Rev_"+i+"'> Revenue: " + Dr["Revenue"] + "</label></span><span class='col-md-2 colmd2'><label id='Pro_"+i+"'>Profit</label><span class='pull-right-container'><i class='fa fa-angle-right pull-right fat '></i></span></span></div></a> " +
                     "<ul class='treeview-menu'>" +
                     "<li> " +
                         "<table class='table table-bordered '> <tbody id='tblInnJobCost_" + i+ "'>    </tbody></table>" +
                        "</li> " +

                        "</ul>" +
                   "</li>";
                i++;
            }
        }
        else
        {
            OutPut = "No Records Found";
        }





        Dt.Dispose();
        Context.Response.Write(OutPut);

    }

    void BindJobCostDetails(string Id)
    {
        DataTable dt = DB.GetDataTable("select posted_date,job_number,Paid_To_Account_Code Expense_Code,Ledger_Account_Name  Account_Name ,sum(b.Payment_Amount) as job_Cost " +
                                         " from tbl_payments a,tbl_payment_items b,tbl_ledger_account c where a.Payment_Id=b.Payment_Id " +
                                      " and c.Account_Code=b.Paid_To_Account_Code and Paid_To_Account_Code like '4%'and Job_Number like '"+Id+"' group by job_number,Paid_To_Account_Code,Ledger_Account_Name,posted_date order by Job_Number");
        decimal TotalCost = 0;
        string output = "";
        if (dt.Rows.Count > 0)
        { foreach (DataRow Dr in dt.Rows)
            {
                output += "<tr> " +
                                       "<td width='10%'> " + Convert.ToDateTime(Dr["posted_date"].ToString()).ToString("dd-MM-yyyy") + " </td>" +
                                      " <td width='30%'>" + Dr["Account_Name"] + " </td>" +
                                      " <td width='28%'>" + Dr["Expense_Code"] + "</td>" +
                                      " <td width='15%'> " + Dr["job_number"] + " </td>" +
                                      " <td width='15%'>" + Dr["job_Cost"] +" </td>" +
                             "</tr>";
                TotalCost = TotalCost + decimal.Parse(Dr["job_Cost"].ToString());

            }
        }
        else
        {
            output += "<tr> " +
                                  "<td width='10%' colspan='5'> No Record Found </td>" +

                        "</tr>";
        }
        Context.Response.Write(output+"|"+TotalCost);
    }

    void EportJobCasting(string Date, string txtSearch,string isDateSearch)
    {
        string fileName = "";

        if (G.HL() == true)
        {
            DataTable Dt;
            SqlDataAdapter da;
            string FromDate = "";
            string ToDate = "";
            string fday = "";
            string fMonth = "";
            string fyear = "";
            string newFdate = "";
            string Tday = "";
            string TMonth = "";
            string Tyear = "";
            string newTdate = "";

            string datefilter = "";
            string SearchFilter = "";
            if (isDateSearch.Trim().Equals("1"))
            {
                FromDate = Date.Substring(0, Date.IndexOf("-"));
                ToDate = Date.Substring(Date.IndexOf("-") + 1);

                fday = FromDate.Substring(3, 2);
                fMonth = FromDate.Substring(0, 2);
                fyear = FromDate.Substring(6);
                newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
                Tday = ToDate.Substring(4, 2);
                TMonth = ToDate.Substring(1, 2);
                Tyear = ToDate.Substring(7);
                newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();

                datefilter = " and posted_date between '" + newFdate + "' and '" + newTdate + "'";
            }
            else
            {
                //newFdate = "2020-01-01";
                //string Todaysdate = DateTime.Now.ToString("yyyy-MM-dd").ToString();
                //newTdate = Todaysdate.ToString();
            }

            if(txtSearch!="")
            {
                SearchFilter=" and Job_Number like '%"+txtSearch+"%'";
            }

            DataTable dt = DB.GetDataTable("select  Job_Number,sum(credit) Revenue  "
                                           + " from tbl_ledger_extension a,tbl_Journal_Entry  b, tbl_Ledger_Account c where a.journal_entry_id=b.Journal_Entry_Id"
                                           + datefilter+SearchFilter +"  and  b.Account_Code=c.Account_Code and entry_type LIKE 'FREIGHTINVOICE%' and c.Account_Code like '31%' "
                                           + " and job_number is not null and job_number !='0' group by Job_Number");


            DataRow Dr = dt.NewRow();

            if (dt.Rows.Count > 0)
            {
                string AppLocation = HttpContext.Current.Server.MapPath("./Downloaded_Reports/");
                fileName = "Job_Costing _Report" + DateTime.Now.ToString("dd-MM-yyyy").ToString() + ".xlsx";

                AppLocation += fileName;

                using (XLWorkbook wb = new XLWorkbook())
                {
                    IXLWorksheet ws = wb.Worksheets.Add();

                    var table1 = ws.Range("A1:E1");
                    table1.Cell(1, 1).Value = "Job Costing  Report  - " + DateTime.Now.ToString("dd-MM-yyyy").ToString();
                    table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                    table1.Cell(1, 1).Style.Font.FontSize = 15;
                    table1.Cell(1, 1).Style.Font.SetBold();
                    table1.Range("A1:E1").Merge();
                    var table2 = ws.Range("A2:E2");
                    //table2.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;
                    table2.Cell(1, 1).Value = "Post Date";
                    table2.Cell(1, 2).Value = "Account Name";
                    table2.Cell(1, 3).Value = "Expense Code";
                    table2.Cell(1, 4).Value = "Job Number ";
                    table2.Cell(1, 5).Value = "Job Cost";



                    table2.Style.Font.SetBold();
                    table2.Style.Fill.BackgroundColor = XLColor.BlueGray;
                    table2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                    ws.Row(1).Height = 30;
                    ws.Row(2).Height = 30;
                    ws.RowHeight = 22;

                    ws.Column("A").Width = 15;
                    ws.Column("B").Width = 20;
                    ws.Column("C").Width = 15;
                    ws.Column("D").Width = 40;
                    ws.Column("E").Width = 15;



                    var table4 = ws.Range("A3:E3");
                    int i = 1;
                    int j = 1;
                    int jobnum = 0;
                    foreach (DataRow dr in dt.Rows)
                    { decimal TotalJobCost = 0;


                        table4.Cell(i, 1).Value = "Job Number ("+dr["Job_Number"]+")";
                        table4.Cell(i, 1).Style.Fill.BackgroundColor = XLColor.LightGray;
                        table4.Cell(i, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                        table4.Cell(i, 2).Value = "";
                        table4.Cell(i, 2).Style.Fill.BackgroundColor = XLColor.LightGray;
                        table4.Cell(i, 3).Value = "";
                        table4.Cell(i, 3).Style.Fill.BackgroundColor = XLColor.LightGray;
                        table4.Cell(i, 4).Value = "";
                        table4.Cell(i, 4).Style.Fill.BackgroundColor = XLColor.LightGray;
                        table4.Cell(i, 5).Value = "";
                        table4.Cell(i, 5).Style.Fill.BackgroundColor = XLColor.LightGray;
                        i++;
                        DataTable dtnew = DB.GetDataTable("select posted_date,job_number,Paid_To_Account_Code Expense_Code,Ledger_Account_Name  Account_Name ,sum(b.Payment_Amount) as job_Cost " +
                                    " from tbl_payments a,tbl_payment_items b,tbl_ledger_account c where a.Payment_Id=b.Payment_Id " +
                                " and c.Account_Code=b.Paid_To_Account_Code and Paid_To_Account_Code like '4%'and Job_Number like '"+dr["Job_Number"]+"' group by job_number,Paid_To_Account_Code,Ledger_Account_Name,posted_date order by Job_Number");
                        if (dtnew.Rows.Count > 0)
                        {
                            foreach (DataRow DR1 in dtnew.Rows)
                            {
                                table4.Cell(i, 1).Value = Convert.ToDateTime(DR1["posted_date"].ToString()).ToString("dd-MM-yyyy");
                                table4.Cell(i, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                                table4.Cell(i, 2).Value = DR1["Account_Name"];
                                table4.Cell(i, 3).Value = DR1["Expense_Code"];

                                table4.Cell(i, 4).Value = DR1["job_number"];

                                table4.Cell(i, 5).Value = DR1["job_Cost"];
                                TotalJobCost = TotalJobCost + decimal.Parse(DR1["job_Cost"].ToString());
                                //j++;
                                i++;
                            }
                            table4.Cell(i, 1).Value = "";

                            table4.Cell(i, 2).Value = "";
                            table4.Cell(i, 3).Value ="";
                            table4.Cell(i, 4).Value ="Revenue :  "+dr["Revenue"];

                            table4.Cell(i, 5).Value = "Profit :  "+ (decimal.Parse(dr["Revenue"].ToString())-TotalJobCost).ToString();

                            i++;
                        }
                        else
                        {
                            table4.Cell(i, 1).Value = "No record found";
                            i++;
                        }



                    }






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
        Context.Response.Write(fileName);
    }

    void LeaveGraduity(string txtSearch)
    {

        DataTable Dt = new DataTable();

        string output = "";
        //=============Get Formated Date============================

        if (txtSearch != "")
        {
            Dt = DB.GetDataTable("exec generate_leave_gratuity_statement '" + txtSearch + "'");
        }
        else
        {
            Dt = DB.GetDataTable("exec generate_leave_gratuity_statement");
        }




        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow Dr in Dt.Rows)
            {
                output += "<tr> " +
                                   "<td>" + Dr["Employee_number"] + " </td>" +
                                   "<td>" + Dr["Employee_Name"] + " </td>" +
                                   "<td> " + Convert.ToDateTime(Dr["DOJ"].ToString()).ToString("dd-MM-yyyy") + " </td>" +
                                   "<td>" + Dr["prev_lve_start"] + " </td>" +
                                   "<td>" + Dr["basic_salary"] + " </td>" +
                                   "<td>" + Dr["others"] + " </td>" +
                                   "<td>" + Dr["lve_open_bal"] + " </td>" +
                                   "<td>" + Dr["accrued_leaves"] + " </td>" +
                                   "<td>" + Dr["leave_salary"] + " </td>" +
                                   "<td>" + Dr["leave_bal"] + " </td>" +
                                   "<td>" + Dr["leave_bal_days"] + " </td>" +



                                   "<td>" + Dr["gratuity_open_bal"] + " </td>" +
                                   "<td>" + Dr["accrued_gratuity"] + " </td>" +
                                   "<td>" + Dr["gratuity_encash"] + " </td>" +
                                   "<td>" + Dr["gratuity_bal"] + " </td>" +
                                   "<td>" + Dr["gratuity_bal_days"] + " </td>" +
                         "</tr>";
            }
        }
        else
        {
            output += "<tr> " +
                             "<td width='10%' colspan='5'> No Record Found </td>" +

                   "</tr>";
        }

        Dt.Dispose();


        Dt.Dispose();
        Context.Response.Write(output);

    }

    void EportLeaveGraduity(string Date, string txtSearch,string isDateSearch)
    {
        string fileName = "";

        if (G.HL() == true)
        {
            DataTable Dt;
            SqlDataAdapter da;
            string FromDate = "";
            string ToDate = "";
            string fday = "";
            string fMonth = "";
            string fyear = "";
            string newFdate = "";
            string Tday = "";
            string TMonth = "";
            string Tyear = "";
            string newTdate = "";

            string datefilter = "";
            string SearchFilter = "";
            if (isDateSearch.Trim().Equals("1"))
            {
                FromDate = Date.Substring(0, Date.IndexOf("-"));
                ToDate = Date.Substring(Date.IndexOf("-") + 1);

                fday = FromDate.Substring(3, 2);
                fMonth = FromDate.Substring(0, 2);
                fyear = FromDate.Substring(6);
                newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
                Tday = ToDate.Substring(4, 2);
                TMonth = ToDate.Substring(1, 2);
                Tyear = ToDate.Substring(7);
                newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();


            }
            else
            {

            }

            if (txtSearch != "")
            {
                Dt = DB.GetDataTable("exec generate_leave_gratuity_statement '" + txtSearch + "'");
            }
            else
            {
                Dt = DB.GetDataTable("exec generate_leave_gratuity_statement");

            }



            DataRow Dr = Dt.NewRow();

            if (Dt.Rows.Count > 0)
            {
                string AppLocation = HttpContext.Current.Server.MapPath("./Downloaded_Reports/");
                fileName = "Leave_Gratuity_Report" + DateTime.Now.ToString("dd-MM-yyyy").ToString() + ".xlsx";

                AppLocation += fileName;

                using (XLWorkbook wb = new XLWorkbook())
                {
                    IXLWorksheet ws = wb.Worksheets.Add();

                    var table1 = ws.Range("A1:P1");
                    table1.Cell(1, 1).Value = "Leave Gratuity Report  - " + DateTime.Now.ToString("dd-MM-yyyy").ToString();
                    table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                    table1.Cell(1, 1).Style.Font.FontSize = 15;
                    table1.Cell(1, 1).Style.Font.SetBold();
                    table1.Range("A1:P1").Merge();
                    var table2 = ws.Range("A2:P2");
                    //table2.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;
                    table2.Cell(1, 1).Value = "Employee No";
                    table2.Cell(1, 2).Value = "Employee Name";
                    table2.Cell(1, 3).Value = "Date Of Joining";
                    table2.Cell(1, 4).Value = "Prev Leave Start";
                    table2.Cell(1, 5).Value =  "Basic Salary";

                    table2.Cell(1, 6).Value = "Others";
                    table2.Cell(1, 7).Value = "Opening Bal "+DateTime.Today.Year.ToString();
                    table2.Cell(1, 8).Value = "Accrued For the";
                    table2.Cell(1, 9).Value = "Leave Payment";
                    table2.Cell(1, 10).Value = "Leave Bal";

                    table2.Cell(1, 11).Value = "Leave Bal Days";
                    table2.Cell(1, 12).Value = "Opening Bal "+DateTime.Today.Year.ToString();
                    table2.Cell(1, 13).Value = "Accrued For the";
                    table2.Cell(1, 14).Value = "Gratuity Payment";
                    table2.Cell(1, 15).Value = "Gratuity Bal";
                    table2.Cell(1, 16).Value = "Gratuity Bal Days";

                    table2.Style.Font.SetBold();
                    table2.Style.Fill.BackgroundColor = XLColor.BlueGray;
                    table2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    table2.Range("G2:K2").Style.Fill.BackgroundColor = XLColor.Green;
                    table2.Range("G2:K2").Style.Font.FontColor = XLColor.White;
                    table2.Range("L2:P2").Style.Fill.BackgroundColor = XLColor.Red;
                    table2.Range("L2:P2").Style.Font.FontColor = XLColor.White;
                    ws.Row(1).Height = 30;
                    ws.Row(2).Height = 30;
                    ws.RowHeight = 22;

                    ws.Column("A").Width = 15;
                    ws.Column("B").Width = 20;
                    ws.Column("C").Width = 15;
                    ws.Column("D").Width = 15;
                    ws.Column("E").Width = 15;
                    ws.Column("F").Width = 15;
                    ws.Column("G").Width = 15;
                    ws.Column("H").Width = 15;
                    ws.Column("I").Width = 15;
                    ws.Column("J").Width = 15;
                    ws.Column("K").Width = 15;

                    ws.Column("L").Width = 15;
                    ws.Column("N").Width = 15;
                    ws.Column("M").Width = 15;
                    ws.Column("O").Width = 15;
                    ws.Column("P").Width = 15;



                    var table4 = ws.Range("A3:P3");
                    int i = 1;
                    //int j = 1;
                    //int jobnum = 0



                    if (Dt.Rows.Count > 0)
                    {
                        foreach (DataRow DR1 in Dt.Rows)
                        {
                            table4.Cell(i, 1).Value =  DR1["Employee_number"];
                            table4.Cell(i, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                            table4.Cell(i, 2).Value = DR1["Employee_Name"];
                            table4.Cell(i, 3).Value = Convert.ToDateTime(DR1["DOJ"].ToString()).ToString("dd-MM-yyyy");
                            table4.Cell(i, 4).Value = DR1["prev_lve_start"];
                            table4.Cell(i, 5).Value = DR1["basic_salary"];
                            table4.Cell(i, 6).Value = DR1["others"];

                            table4.Cell(i, 7).Value = DR1["lve_open_bal"];
                            table4.Cell(i, 8).Value = DR1["accrued_leaves"];
                            table4.Cell(i, 9).Value = DR1["leave_salary"];
                            table4.Cell(i, 10).Value = DR1["leave_bal"];

                            table4.Cell(i, 11).Value = DR1["leave_bal_days"];

                            table4.Cell(i, 12).Value = DR1["gratuity_open_bal"];
                            table4.Cell(i, 13).Value = DR1["accrued_gratuity"];
                            table4.Cell(i, 14).Value = DR1["gratuity_encash"];
                            table4.Cell(i, 15).Value = DR1["gratuity_bal"];
                            table4.Cell(i, 16).Value = DR1["gratuity_bal_days"];


                            //j++;
                            i++;
                        }

                    }
                    else
                    {
                        table4.Cell(i, 1).Value = "No record found";
                        i++;
                    }










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
        Context.Response.Write(fileName);
    }
    void GetUserAccess()
    {
        string PostEditAccess = "false";
        DataTable Dt= DB.GetDataTable("select a.Role_Id from tbl_Employee_Division_Mapping a inner join tbl_Role b on a.Role_Id=b.Role_Id where a.Employee_Id=" + UserId + " and b.Role_Name='Finance Super User' ");
        if(Dt.Rows.Count>0)
        {
            PostEditAccess = "true";
        }

        Context.Response.Write(PostEditAccess);
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
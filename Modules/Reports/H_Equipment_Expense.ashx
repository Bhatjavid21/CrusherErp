<%@ WebHandler Language="C#" Class="H_Equipment_Expense" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;
using System.IO;
using System.Web.SessionState;
using System.Globalization;

public class H_Equipment_Expense : IHttpHandler, IRequiresSessionState
{
    HttpContext Context; Int16 DF = 0;
    public void ProcessRequest(HttpContext context)
    {
        Context = context;
        if (!string.IsNullOrEmpty(Context.Request["fun"]))
        {
            try
            {
                if (G.HL() == true)
                {
                    DF = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[3]);
                    switch (Context.Request["fun"].ToString())
                    {
                        case "Get_Equipment_Expense_Report":
                            Get_Equipment_Expense_Report(DateTime.ParseExact(Context.Request.QueryString["From_Date"].ToString(), "MM/dd/yyyy", null), DateTime.ParseExact(Context.Request.QueryString["To_Date"].ToString(), "MM/dd/yyyy", null));
                            break;
                    }
                }
                else
                {
                    Raise_Error("SessionIsDead");
                }
            }
            catch (Exception x)
            {
                Raise_Error("!error!" + x.Message + "");
            }
        }
        Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }

    void Raise_Error(string error)
    {
        error = error.Replace("\"", "");
        var json = (new { status = "success", errorMessage = error });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }

    void Get_Equipment_Expense_Report(DateTime From_Date, DateTime To_Date)
    {
        string output = "", sql = "";

        sql = "select Document_Number, Voucher_Date as Payment_date, b.account_code, Ledger_Account_Name, b.Debit as Amount, replace(b.Remarks,'%20',' ') as Expesne_comments, substring(Sub_Division_Id, 1, 5) as Equipment, Description from tbl_Journal_Voucher a, tbl_Journal_Voucher_Items b, tbl_Equipment c, tbl_Ledger_Account d where b.Account_Code in (4101001,4101002,4101003,4101004,4101005) and a.Journal_Voucher_Id=b.Journal_Voucher_Id and Voucher_Date between '" + From_Date.Date + "' and '" + To_Date.Date + "' and debit>0 and d.Account_Code=b.Account_Code and c.Asset_Code=substring(Sub_Division_Id,1,5) and (Sub_Division_Id not like 'sele%' AND Sub_Division_Id not like '254') union " +
            "select a.Payment_Number as Document_Number,Payment_Date as Voucher_Date,b.Paid_To_Account_Code as account_code,Ledger_Account_Name, b.Payment_Amount as Amount, replace(b.Remarks,'%20',' '), Sub_Division_Id as Equipment,Description "+
            " from tbl_Payments a,tbl_payment_items b,tbl_Equipment c, tbl_Ledger_Account d where b.Paid_To_Account_Code "+
             " in (4101001,4101002,4101003,4101004,4101005) and a.Payment_Id=b.Payment_Id and Payment_Amount>0 and payment_date between '" + From_Date.Date + "' and '" + To_Date.Date + "' "+
             "and d.Account_Code=b.Paid_To_Account_Code and c.Asset_Code=Job_Number "+
             "and (Sub_Division_Id not like 'sele%' AND Sub_Division_Id not like '254') " +
              "order by Document_Number";
        SqlDataReader dr = DB.Get_temp(sql);

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                output += dr["Document_Number"].ToString() + "^" + Convert.ToDateTime(dr["Payment_date"].ToString()).ToString("dd-MMM-yyyy") + "^" + dr["account_code"].ToString() + "^" + dr["Ledger_Account_Name"].ToString() + "^" + dr["Amount"].ToString() + "^" + dr["Expesne_comments"].ToString() + "^" + dr["Equipment"].ToString() + "^" + dr["Description"].ToString() + "~";
            }
            dr.Dispose();
            dr.Close();
        }

        Context.Response.Clear();
        Context.Response.Write(output);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
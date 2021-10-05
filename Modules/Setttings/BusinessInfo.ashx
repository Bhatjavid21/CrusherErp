<%@ WebHandler Language="C#" Class="H_tbl_Supplier" %>
using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.Sql;
using System.Web.SessionState;
using Newtonsoft.Json;
using System.Configuration;
using ClosedXML.Excel;
using System.Text;

public class H_tbl_Supplier : IHttpHandler, IRequiresSessionState
{
    HttpContext Context; Int16 DF = 0;
    public void ProcessRequest(HttpContext context)
    {
        Context = context; if (!string.IsNullOrEmpty(Context.Request["fun"]))
        {
            try
            {
                /// if (G.HL() == true)
                // {
                // DF = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[3]);

                switch (Context.Request["fun"].ToString())
                {
                    case "Save_BusinessInfo":
                        Save_BusinessInfo(context.Request.Form["InsertArray"]);
                        break;
                    case "GetBusinessInfo":
                        GetBusinessInfo();
                        break;
                }
            }
            catch (Exception x) { Context.Response.Write("!error!" + x.Message); }
        }
        Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    //*********************************View*********************************View******************************************View***********************************************************

    void Save_BusinessInfo(string InsertArray)
    {
        int Ret;
        string[] Data = InsertArray.Split('|');
        string qry = "select count(1) from MyBusinessInfo";
        string sql;
        int count = DB.Get_ScalerInt(qry);
        if (count < 1)
        {
            sql = "INSERT INTO [dbo].[MyBusinessInfo] ([BizName],[BizAddress],[Mobile],[Email],[Website],[Tagline],[GSTIN],[CGST],[SGST],[IGST],[AccountNo],[BankName],[Branch],[IFSC],[CreatedOn]) VALUES" +
                "('" + Data[0] + "','" + Data[1] + "','" + Data[2] + "','" + Data[3] + "','" + Data[4] + "','" + Data[5] + "','" + Data[6] + "','" + Data[7] + "','" + Data[8] + "','" + Data[9] + "','" + Data[10] + "','" + Data[11] + "','" + Data[12] + "','" + Data[13] + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "')";
        }
        else
        {
            sql = "UPDATE [dbo].[MyBusinessInfo] SET [BizName] = '" + Data[0] + "',[BizAddress] = '" + Data[1] + "',[Mobile] = '" + Data[2] + "',[Email] = '" + Data[3] + "',[Website] = '" + Data[4] + "'," +
                "[Tagline] = '" + Data[5] + "',[GSTIN] = '" + Data[6] + "',[CGST] = '" + Data[7] + "',[SGST] = '" + Data[8] + ",[IGST] = '" + Data[9] + "',[AccountNo] = '" + Data[10] + "'," +
                "[BankName] = '" + Data[11] + "',[Branch] = '" + Data[12] + "',[IFSC] = '" + Data[13] + "',[UpdatedOn] = '" + DateTime.Now.ToString("yyyy-MM-dd") + "' WHERE [BizName] = '" + Data[0] + "'";
        }
        Ret = DB.Get_ScalerInt(sql);
        if (Ret > -1)
        {
            Context.Response.Write("Success");
        }
        else
        {
            Context.Response.Write("Something Went Wrong");
        }

    }
    void GetBusinessInfo()
    {
        string jasonString1 = "";
        DataTable Dt = DB.GetDataTable("select * from MyBusinessInfo");
        if (Dt.Rows.Count > 0)
        {
            jasonString1 = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(jasonString1);
    }

    public bool IsReusable { get { return false; } }
}
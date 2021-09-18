<%@ WebHandler Language="C#" Class="H_tbl_Customer" %>
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

public class H_tbl_Customer : IHttpHandler, IRequiresSessionState
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

                    case "Save_Customer":

                        Save_Customer(context.Request.Form["InsertArray"]);

                        break;
                }
                //  }
                //  else { Context.Response.Write("SessionIsDead"); }
            }
            catch (Exception x) { Context.Response.Write("!error!" + x.Message); }
        }
        Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    //*********************************View*********************************View******************************************View***********************************************************

    void Save_Customer(string InsertArray)
    {
        int Ret=-9;
        string[] Data = InsertArray.Split('|');

        string sql = "Insert into tbl_Customer_Supplier values('" + Data[1] + "','" + Data[0] + "','" + Data[3] + "',0.00,'" + Data[4] + "','" + DateTime.Now.ToString("yyyy-MM-dd")+ "',null,1,1,'" + Data[2] + "')";
        Ret = DB.Get_ScalerInt(sql);
        if(Ret>-1)
        {
            Context.Response.Write("Success");
        }
        else
        {
                 Context.Response.Write("Something Went Wrong");
        }

    }

    public bool IsReusable { get { return false; } }
}
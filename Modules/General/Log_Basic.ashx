<%@ WebHandler Language="C#" Class="Log_Basic" %>
using System;
using System.Data.SqlClient;
using System.Web;

public class Log_Basic : IHttpHandler { HttpContext Context; public void ProcessRequest (HttpContext context) { Context = context; if (!string.IsNullOrEmpty(Context.Request["fun"]))
        {
            switch (Context.Request["fun"].ToString())
            {
                case "GetLog": GetLog(Convert.ToDateTime(Context.Request.QueryString["operation_Date"])); break;
            }
            Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }
    }




    void GetLog(DateTime Operation_Date)
    {
        string output = "<table cellpadding='5' cellspacing='5'><tr><th>Table Name</th><th>Table Primary Id</th><th>Operation By</th><th>Operation Type</th><th>Operation Date</th></tr>";
        try
        {
           // DateTime dt = Convert.ToDateTime(Operation_Date.Year + "-" + Operation_Date.Day+ "-" + Operation_Date.Month);
            SqlDataReader DR = Log.Get_temp(Operation_Date);
            for (int i = 0; DR.Read(); i++)
            {
                output += "<tr><td>" + DR["Table_Name"] + "</td><td>" + DR["Table_Id"] + "</td><td>" + DR["Operation_By"] + "</td><td>"+DR["Operation_Type"]+"</td><td>"+DR["Operation_Date"]+"</td></tr>";
            }
            DR.Close();
            output += "</table>";
        }
        catch (Exception x) { output = "--- Error: <br>" + x.Message + " - " + x.StackTrace; }

        Context.Response.Write(output);
    }





    //

    public bool IsReusable {
        get {
            return false;
        }
    }

}
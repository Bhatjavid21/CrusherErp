<%@ WebHandler Language="C#" Class="Remove_HandlerCS" %>
using System;
using System.IO;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;

public class Remove_HandlerCS : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        
            try
            {
                string file_path = context.Server.MapPath("~/Modules/" + context.Request.QueryString["file_path"]);
                if (file_path != "")
                {
                    File.Delete(file_path);
                   context.Response.Write(context.Response.StatusCode = (int)HttpStatusCode.OK);
                    context.Response.ContentType = "text/json";
                }
            }
            catch (Exception x) { string a = x.Message; }
        
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
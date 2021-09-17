<%@ WebHandler Language="C#" Class="HandlerCS" %>

using System;
using System.IO;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;

public class HandlerCS : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        //Check if Request is to Upload the File.
        if (context.Request.Files.Count > 0)
        {
            try
            {
                //Fetch the Uploaded File.
                HttpPostedFile postedFile = context.Request.Files[0];

                var LocalfolderPath = context.Request.QueryString["path"];
                //Set the Folder Path.
                // string folderPath = context.Server.MapPath("~/Uploads/");
                string folderPath1 = context.Server.MapPath("~/Modules/");
                string folderPath = context.Server.MapPath("~/Modules/" + LocalfolderPath + "/");//G.S+(

                //Set the File Name.
                string fileName = Path.GetFileName(postedFile.FileName);

                if (fileName != "")
                {
                    fileName = fileName.Replace("'", "").Replace(" ", "-").Replace(" ", "-").Replace("`", "-").Replace("~", "-").Replace("@", "-").Replace("#", "-").Replace("$", "-").Replace("%", "-").Replace("^", "-").Replace("&", "-").Replace("*", "-").Replace("(", "-").Replace(")", "-").Replace("]", "-").Replace("[", "-").Replace("{", "-").Replace("}", "-").Replace("\\", "-").Replace("/", "-").Replace("|", "-").Replace("\"", "-").Replace(":", "-").Replace(";", "-").Replace("?", "-").Replace(">", "-").Replace("<", "-").Replace("+", "-").Replace("=", "-").Replace("!", "-").Replace("_", "-").Replace("--", "-");

                    var Extension = Path.GetExtension(fileName);

                    if (fileName.Length > 50)
                    {
                        fileName = fileName.Remove(49);
                    }

                    fileName = fileName.Replace(Extension, "") + "-" + DateTime.Now.ToString().Replace("/", "").Replace(" ", "").Replace(":", "") + Extension;
                    fileName = fileName.ToLower();


                    //Save the File in Folder.
                    postedFile.SaveAs(folderPath + fileName.ToUpper());

                    //Send File details in a JSON Response.
                    string json = new JavaScriptSerializer().Serialize(
                        new
                        {
                            name = fileName
                        });

                    context.Response.StatusCode = (int)HttpStatusCode.OK;
                    context.Response.ContentType = "text/json";
                    context.Response.Write(json);
                    //context.Response.End();
                }
            }
            catch (Exception x) { string a = x.Message; }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for DB
/// </summary>
public class G
{
    public static string B = ConfigurationManager.AppSettings["base_url"];
     //public static string B = ConfigurationManager.AppSettings["Live_url"];


    #region Login Session Check
    public static bool L()
    {
        if (HttpContext.Current.Session["session_ids"] == null)
        {
            GetRef();
             HttpContext.Current.Response.Redirect(G.B, true); 
            return false;
        }
        else
        {
            return true;
        }
    }
    #endregion

    #region Is Session OK or gone for handler check
    public static bool HL()
    {
        try
        {
            if (HttpContext.Current.Session["session_ids"] == null)
            {
                GetRef();
                return false;
            }
            else
            {
                return true;
            }
        }
        catch { return false; }
    }
    #endregion

    public static string S = B + "Modules/";

    public static string Generate_Sequence(int ProcessNumber , int UserId)
    {
        string GeneratedNumber = "";
        GeneratedNumber = DB.Get_Scaler("DECLARE @nextnumber varchar(20) exec[dbo].[Get_next_no] @process_no = " + ProcessNumber + " , @nextnumber = @nextnumber OUTPUT,  @optype = 'process' ,@User_Id = "+UserId+" SELECT  @nextnumber as '@nextnumber'");
        return GeneratedNumber;
    }

    public static string Generate_Sequence_Finance(int ProcessNumber)
    {
        string GeneratedNumber = "";
        GeneratedNumber = DB.Get_Scaler("DECLARE @nextnumber varchar(20) exec[dbo].[Get_next_no_finance] @process_no = " + ProcessNumber + " , @nextnumber = @nextnumber OUTPUT,  @optype = 'process'  SELECT  @nextnumber as '@nextnumber'");
        return GeneratedNumber; 
    }



    public static string set_Topmenu(string top_menu_name)
    {
        string session_top_menu = HttpContext.Current.Session["top_menu"].ToString();
        if (session_top_menu == top_menu_name)
        {
            return "active menu-open";
        }
        return "";
    }

    public static string set_Submenu(string sub_menu_name)
    {
        string session_sub_menu = HttpContext.Current.Session["sub_menu"].ToString();
        if (session_sub_menu == sub_menu_name)
        {
            return "active";
        }
        return "";
    }

    public static string Division_Access_Level_Ids(string Module, string Screen, string Operation)
    {
        int Branch_Id = 0, Emp_Id = Convert.ToInt32(HttpContext.Current.Session["session_ids"].ToString().Split(',')[0]);
        string sql = "select d.Access_Level_Name, f.Division_Id,f.Role_Id,c.Operation_Id from tbl_Access_Modules a, "
             + " tbl_Access_Screens b,tbl_Access_Operations c, tbl_Access_Levels d, tbl_Access_Privileges e "
             + " inner join tbl_Employee_Division_Mapping f on e.Role_Id= f.role_id where a.Module_Name='"+Module+"' and "
             + " B.Screen_Name='" + Screen + "' and c.Operation_Name='" + Operation + "' and a.Module_Id=b.Module_Id and b.Screen_Id=c.Screen_Id "
             + " and c.Operation_Id=d.Operation_Id and e.Access_Level_Id=d.Access_Level_Id and f.Employee_Id=" + Emp_Id + " order by division_id ";

        SqlDataReader DR = DB.Get_temp(sql); string MappedDivision_Ids="", output="", Company="", Self_Access_Division_Ids="";
      
        if (DR.HasRows)
        {
            while (DR.Read())
            {

                if (DR["Access_Level_Name"].ToString() == "Company")
                {
                    Company = "Yes";
                }
                else if (DR["Access_Level_Name"].ToString() == "Branch")
                {
                    //Branch = "Yes";
                    Branch_Id = Convert.ToInt32(HttpContext.Current.Session["session_ids"].ToString().Split(',')[1]);
                }
                else if (DR["Access_Level_Name"].ToString() == "Division")
                {
                    //collect all division ids here // take out division id from mappeddivisons ids if this div id is with any self, in that case write where userid=... and divisionid=...
                    MappedDivision_Ids += " "+DR["Division_Id"].ToString() + ",";
                }
                else if (DR["Access_Level_Name"].ToString() == "Self") 
                {
                    Self_Access_Division_Ids += DR["Division_Id"].ToString() + ",";
                }

                string[] Division_Ids_Splt;

                if (MappedDivision_Ids.Contains(","))
                {
                    Division_Ids_Splt = MappedDivision_Ids.Split(',');

                    for (int i = 0; i < Division_Ids_Splt.Length; i++)
                    {
                        if (Self_Access_Division_Ids.Contains(" " + Division_Ids_Splt[i] + ",") == true)
                        {
                            Self_Access_Division_Ids = Self_Access_Division_Ids.Replace(" " + Division_Ids_Splt[i] + ",", "");
                        }
                    }
                
                }
                
                output = Company + "|" + Branch_Id + "|" + MappedDivision_Ids + "|" + Self_Access_Division_Ids + "|" + Emp_Id;
            }
        }
        else
        {
            output = "Access is Restricted.";
        }

        DR.Close(); DR.Dispose();

        return output;
    }
     
    public static bool IsValidEmail(string email)
    {
        string pattern = @"^(?!\.)(""([^""\r\\]|\\[""\r\\])*""|" + @"([-a-z0-9!#$%&'*+/=?^_`{|}~]|(?<!\.)\.)*)(?<!\.)" + @"@[a-z0-9][\w\.-]*[a-z0-9]\.[a-z][a-z\.]*[a-z]$";
        var regex = new System.Text.RegularExpressions.Regex(pattern, System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        return regex.IsMatch(email);
    }

    public static void GetRef()
    { 
        HttpContext.Current.Session["RefUrl"] = null;
        HttpContext.Current.Session.RemoveAll();
        string url = "";
        if (HttpContext.Current.Request.UrlReferrer!=null)
        {
            url = HttpContext.Current.Request.UrlReferrer.ToString();
        }
        else
        {
            url = HttpContext.Current.Request.Url.ToString();
        }
        HttpContext.Current.Session["RefUrl"] = url;
    }

    public static string Sp_Chr(string input)
    {
        string res = input.ToString().Replace("\n", "").Replace("\r", "").Replace("''", "").Replace("'", "").Replace("\"", "").Trim();
        return res;
    }
}
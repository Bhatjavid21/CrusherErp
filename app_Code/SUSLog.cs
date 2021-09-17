using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data.SqlClient;

/// <summary>
/// Summary description for SUSLog
/// </summary>
public class SUSLog
{
    public SUSLog()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static SqlDataReader Get_temp(DateTime Operation_Date)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]); con.Close(); con.Open(); string sql = "Select * from tbl_log where Operation_Date=CONVERT(date,'" + Operation_Date + "')";
        SqlCommand command = new SqlCommand(sql, con);
        SqlDataReader DR = command.ExecuteReader();
        return DR;
    }

    public static void Set_temp(string table_Name, string table_Row_Id, string operation_Type)
    {
        string session_sub_menu = Convert.ToString(HttpContext.Current.Session["sub_menu"].ToString());
        string abc = HttpContext.Current.Session["session_ids"].ToString();

        //string hh = DB.User_id;

        SqlConnection con; SqlCommand command; SqlDataReader DR; int User_Id = Convert.ToInt32(HttpContext.Current.Session["session_ids"].ToString().Split(',')[0]); string sql = "";

        //if (operation_Type.ToLower() == "Insert".ToLower())
        //{
        //    con = new SqlConnection(ConfigurationManager.AppSettings["con"]); con.Close(); con.Open();
        //    command = new SqlCommand("select top 1 " + table_Id + " from " + table_Name + " order by " + table_Id + " desc", con);
        //    DR = command.ExecuteReader();
        //    while (DR.Read()) { last_Id = Convert.ToInt32(DR[table_Id]); }

        //    con = new SqlConnection(ConfigurationManager.AppSettings["Con"]); con.Close(); con.Open();
        //    sql = "insert into tbl_log (Table_Name, Table_Id, Operation_By, Operation_Date, Operation_Type)values('" + table_Name + "'," + last_Id + "," + User_Id + ", CONVERT(varchar(10),getdate(),101),'Insert')";
        //    command = new SqlCommand(sql, con);
        //    command.ExecuteNonQuery();
        //}
        //else
        //{
        sql = "insert into tbl_log (Table_Name, table_Row_Id, Operation_By, Operation_Date, Operation_Type)values('" + table_Name + "'," + table_Row_Id + "," + User_Id + ",  CONVERT(varchar(10),getdate(),101),'" + operation_Type + "')";
        con = new SqlConnection(ConfigurationManager.AppSettings["Con"]); con.Close(); con.Open();
        command = new SqlCommand(sql, con);
        command.ExecuteNonQuery();
        //}
    }
}
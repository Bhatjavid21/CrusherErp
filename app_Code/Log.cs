using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data.SqlClient;

/// <summary>
/// Summary description for DB
/// </summary>
public class Log
{
    public static SqlDataReader Get_temp(DateTime Operation_Date)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]); con.Close(); con.Open(); string sql = "Select * from tbl_log where Operation_Date=CONVERT(date,'" + Operation_Date + "')";
        SqlCommand command = new SqlCommand(sql, con);
        SqlDataReader DR = command.ExecuteReader();
        return DR;
    }

    public static void Set_temp(string table_Name, string table_Row_Id, string operation_Type)
    {
        SqlConnection con; SqlCommand command;  string sql = "";
        int User_Id = Convert.ToInt32(HttpContext.Current.Session["session_ids"].ToString().Split(',')[0]);
       
        sql = "insert into tbl_log (Table_Name, table_Row_Id, Operation_By, Operation_Date, Operation_Type)values('" + table_Name + "'," + table_Row_Id + "," + User_Id + ",getdate(),'" + operation_Type + "')";
        con = new SqlConnection(ConfigurationManager.AppSettings["Con"]); con.Close(); con.Open();
        command = new SqlCommand(sql, con);
        command.ExecuteNonQuery();
      
    }
}
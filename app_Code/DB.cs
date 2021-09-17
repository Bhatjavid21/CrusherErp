using Microsoft.ApplicationBlocks.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
//using System.Web.SessionState;

/// <summary>
/// Summary description for DB
/// </summary>

public class DB
{
    public static string Get_Scaler(string query)
    {
        return Convert.ToString(SqlHelper.ExecuteScalar(ConfigurationManager.AppSettings["Con"], CommandType.Text, query));
    }

    public static int Get_ScalerInt(string query)
    {
        return Convert.ToInt32(SqlHelper.ExecuteScalar(ConfigurationManager.AppSettings["Con"], CommandType.Text, query));
    }

    public static SqlDataReader Get_temp(string query)
    {

        SqlDataReader DataReader = SqlHelper.ExecuteReader(ConfigurationManager.AppSettings["Con"], CommandType.Text, query);

        return DataReader;
    }

    public static string Set_temp(string query)
    {
        //SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]);
        //if (con.State == ConnectionState.Open) { con.Close(); } else { con.Open(); }

        //SqlCommand command = new SqlCommand(query, con);
        //command.ExecuteNonQuery();

        SqlHelper.ExecuteNonQuery(ConfigurationManager.AppSettings["Con"], CommandType.Text, query);


        return "";
    }


    public static DataSet GetDataSet_Simple(string sql)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]);
        try
        {
            if (con.State == ConnectionState.Open) { con.Close(); }// else { con.Open(); }

            //SqlCommand command = new SqlCommand(query, con);
            //command.ExecuteNonQuery();

            return SqlHelper.ExecuteDataset(con, CommandType.Text, sql);
        }
        finally { con.Close(); }
    }


    public static decimal Get_ScalerDecimal(string query)
    {
        return Convert.ToDecimal(SqlHelper.ExecuteScalar(ConfigurationManager.AppSettings["Con"], CommandType.Text, query));
    }

    public string ExecuteScalar(string procedureName, List<string> parameterNames, params object[] parameters)
    {
        string ret;
        string cs = ConfigurationManager.AppSettings["Con"];

        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand(procedureName, con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlParameter[] procedureParams = new SqlParameter[parameters.Length];
            for (int i = 0; i < parameters.Length; i++)
            {
                procedureParams[i] = new SqlParameter(parameterNames[i], parameters[i]);
                cmd.Parameters.Add(procedureParams[i]);
            }
            cmd.CommandTimeout = 2000;
            ret = cmd.ExecuteScalar().ToString();
            con.Close();
        }
        return ret;
    }

    public static DataTable GetDataTable(string sql)
    {
        return SqlHelper.ExecuteDataset(ConfigurationManager.AppSettings["Con"], CommandType.Text, sql).Tables[0];
    }


    public static string GetDataTable_Test(int QID)
    {
        string sql = "SELECT Item_Line_Number as LI,count(Item_Line_Number)as [Count] FROM tbl_Quotation_Items "
            + "where Quotation_Id=" + QID + " GROUP BY Item_Line_Number HAVING COUNT(Item_Line_Number) > 1; "
            + "SELECT Item_Line_Number as LI,count(Item_Line_Number)as [Count] FROM tbl_Quotation_Items where "
            + "Quotation_Id=" + QID + " GROUP BY Item_Line_Number having COUNT(Item_Line_Number)=1";

        DataSet ds = SqlHelper.ExecuteDataset(ConfigurationManager.AppSettings["Con"], CommandType.Text, sql);
        DataTable DT = ds.Tables[0]; DataTable DT2 = ds.Tables[1];

        string LIs_Count = "", Chars = "", Singal_LIs = "", Line_Name = "";

        for (int i = 0; i < DT.Rows.Count; i++)
        {
            LIs_Count += DT.Rows[i]["Count"].ToString() + ",";

            Chars += ((char)(97 + (i))) + ",";

            Line_Name += DT.Rows[i]["LI"].ToString() + ",";
        }


        for (int i = 0; i < DT2.Rows.Count; i++)// Single Line
        {
            Singal_LIs += DT2.Rows[i]["LI"].ToString() + ",";
        }




        if (LIs_Count.Contains(","))
        {
            LIs_Count = LIs_Count.Remove(LIs_Count.LastIndexOf(","));
        }

        if (Chars.Contains(","))
        {
            Chars = Chars.Remove(Chars.LastIndexOf(","));
        }

        if (Line_Name.Contains(","))
        {
            Line_Name = Line_Name.Remove(Line_Name.LastIndexOf(","));
        }

        if (Singal_LIs.Contains(","))// Single Line
        {
            Singal_LIs = Singal_LIs.Remove(Singal_LIs.LastIndexOf(","));
        }

        return LIs_Count + "|" + Chars + "|" + Line_Name + "|" + Singal_LIs;
    }

    public static DataSet GetDataSet(string sql)
    {
        DataSet myDataSet = new DataSet();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(myDataSet);
            }
            conn.Close();
        }
        return myDataSet;
    }

    #region "Currency & Item Methods here Created By Arif"
    public static DataSet Get_Curr_DataTable(int pagesize, int pagenumber, int currencyid, int sortcolumn, string sortorder)
    {
        DataSet myDataSet = new DataSet();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            string spname = "usp_Mudasir_FE_currencydatalist";
            using (SqlCommand cmd = new SqlCommand(spname, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageSize", pagesize);
                cmd.Parameters.AddWithValue("@PageNumber", pagenumber);
                cmd.Parameters.AddWithValue("@currency_id", currencyid);
                cmd.Parameters.AddWithValue("@sortcolumn", sortcolumn);
                cmd.Parameters.AddWithValue("@sortorder", sortorder);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(myDataSet);
            }
            conn.Close();
        }
        return myDataSet;
    }

    public static DataTable GetItemsListByBranchId(string itemType, string SearchTerm, int pagesize, int pagenumber, string branchid, int sortcolumn, string sortorder)
    {
        DataTable DT = new DataTable(); string sql = "", str_like = "", str_itemType = "";
        string branch = "";
        if (branchid != "All Branches") { branch = " and B.Branch_Id=" + branchid + " "; }

        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            if (SearchTerm.Trim() != "" & SearchTerm.Trim() != "0")
            {
                str_like = " where (b.Item_Description like '" + @SearchTerm + "%' or   b.Item_Description like '%" + @SearchTerm + "%'  or B.Item_Code "
                    + " like '" + @SearchTerm + "%' or B.Item_Code like '%" + @SearchTerm + "%' or c.Item_Category_Name like '" + @SearchTerm + "%' or "
                    + " c.Item_Category_Name like '%" + @SearchTerm + "%'  or a.Item_SubCategory_Name like '" + @SearchTerm + "%' or a.Item_SubCategory_Name "
                    + " like '%" + @SearchTerm + "%' or d.Product_Description like '" + @SearchTerm + "%' or d.Product_Description like "
                    + " '%" + @SearchTerm + "%' or d.Product_Code like '" + @SearchTerm + "%' or d.Product_Code like "
                    + " '%" + @SearchTerm + "%' or b.OEM_Reference like '" + @SearchTerm + "%' or b.OEM_Reference like "
                    + " '%" + @SearchTerm + "%') ";
            }

            if (itemType == "1" || itemType == "2" || itemType == "3")
            {
                if (itemType == "1")
                {
                    str_itemType = " and B.Item_Type=1 ";
                }
                else if (itemType == "2")
                {
                    str_itemType = " and B.Item_Type=2 ";
                }
                else { str_itemType = " and B.Item_Type=3 "; }
            }

            //sql = "select B.Item_Id, B.Item_Type, (C.Item_Category_Name + ' - ' + A.Item_SubCategory_Name) as Item_SubCategory_Name, " 
            //    +" B.Item_Code, B.Item_Description,1 as RowNumber  From tbl_Item B,  tbl_Item_SubCategory A, tbl_Item_Category C, "
            //    +" tbl_Item_External_Detail D where A.Item_SubCategory_Id = B.Cat_SubCat_Id and  A.Item_Category_Id = C.Item_Category_Id "
            //    + " and   B.Item_Id = d.Item_Id " + str_itemType + " " + str_like + "  and B.Branch_Id=" + branchid + " and B.[Status]='true'  order by b.item_id desc  ";


            sql = "select  distinct top 8 B.Item_Id, B.Item_Type, (C.Item_Category_Name + ' - ' + A.Item_SubCategory_Name) "
                + " as Item_SubCategory_Name,  B.Item_Code, B.Item_Description,1 as RowNumber  "
                + " From tbl_Item B inner join tbl_Item_SubCategory A on A.Item_SubCategory_Id = B.Cat_SubCat_Id "
                + " inner join tbl_Item_Category c on A.Item_Category_Id = C.Item_Category_Id " + str_itemType + " and B.[Status]='true' " + branch + " "
                 + " left outer join  tbl_Item_External_Detail D on  B.Item_Id = d.Item_Id  " + str_like + "   order by b.item_id desc  ";

            DT = DB.GetDataTable(sql);

            conn.Close();
        }
        return DT;
    }

    public static DataSet GetItemsStockDetailsbyItemId(int pagesize, int pagenumber, int itemId, int sortcolumn, string sortorder)
    {
        DataSet myDataSet = new DataSet();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            string spname = "usp_GetItemsStockDetailsbyItemId";
            using (SqlCommand cmd = new SqlCommand(spname, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageSize", pagesize);
                cmd.Parameters.AddWithValue("@PageNumber", pagenumber);
                cmd.Parameters.AddWithValue("@item_id", itemId);
                cmd.Parameters.AddWithValue("@sortcolumn", sortcolumn);
                cmd.Parameters.AddWithValue("@sortorder", sortorder);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(myDataSet);
            }
            conn.Close();
        }
        return myDataSet;
    }

    public static DataSet GetItemAttachmentsbyItemId(int pagesize, int pagenumber, int itemId, int sortcolumn, string sortorder)
    {
        DataSet myDataSet = new DataSet();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            string spname = "usp_GetItemAttachmentsbyItemId";
            using (SqlCommand cmd = new SqlCommand(spname, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageSize", pagesize);
                cmd.Parameters.AddWithValue("@PageNumber", pagenumber);
                cmd.Parameters.AddWithValue("@item_id", itemId);
                cmd.Parameters.AddWithValue("@sortcolumn", sortcolumn);
                cmd.Parameters.AddWithValue("@sortorder", sortorder);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(myDataSet);
            }
            conn.Close();
        }
        return myDataSet;
    }

    public static DataSet GetItemExternalDetailsbyItemId(int pagesize, int pagenumber, int itemId, int sortcolumn, string sortorder)
    {
        DataSet myDataSet = new DataSet();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            string spname = "usp_Arif_GetItemExternalDetailsbyItemId";
            using (SqlCommand cmd = new SqlCommand(spname, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageSize", pagesize);
                cmd.Parameters.AddWithValue("@PageNumber", pagenumber);
                cmd.Parameters.AddWithValue("@item_id", itemId);
                cmd.Parameters.AddWithValue("@sortcolumn", sortcolumn);
                cmd.Parameters.AddWithValue("@sortorder", sortorder);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(myDataSet);
            }
            conn.Close();
        }
        return myDataSet;
    }


    #endregion
}
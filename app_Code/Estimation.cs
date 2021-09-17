using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Microsoft.ApplicationBlocks.Data;

public class Estimation
{
    public static DataSet getds_branch_division(int branchid, int divisionid, string spname)
    {
        DataSet myDataSet = new DataSet();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            using (SqlCommand cmd = new SqlCommand(spname, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@branchid", branchid);
                cmd.Parameters.AddWithValue("@divisionid", divisionid);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(myDataSet);
            }
            conn.Close();
        }
        return myDataSet;
    }

    public static DataSet getds_Divisions(int branchid, string spname)
    {
        DataSet myDataSet = new DataSet();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            using (SqlCommand cmd = new SqlCommand(spname, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@branchid", branchid);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(myDataSet);
            }
            conn.Close();
        }
        return myDataSet;
    }

    public static DataSet getds_enquirydetails(int enquiryid, string spname)
    {
        DataSet myDataSet = new DataSet();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            using (SqlCommand cmd = new SqlCommand(spname, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@enquiryid", enquiryid);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(myDataSet);
            }
            conn.Close();
        }
        return myDataSet;
    }

    public static DataSet getitemsdt(int pagesize, int pagenumber, int sortcolumn, string sortorder, string itemcode, 
        string itemdesc, string itemmanuf, string itemoemref, string Part_No, string sub_cat_id)
    {
        string Declare_Para, Item_Description="", Item_Code="", Manufacturer="", OEM_Reference="", Cat_SubCat_Id="", SortColumn="";
        Declare_Para = "DECLARE	@FirstRow INT, @LastRow INT, @RecordCount Int, @PageSize int, @PageNumber int;";
        if (sortcolumn == 0) { SortColumn = " Item_Code"; } else if (sortcolumn == 1) { SortColumn = " Item_Description"; } else if (sortcolumn == 2) { SortColumn = " Manufacturer"; } else if (sortcolumn == 3) { SortColumn = " OEM_Reference"; }
        if (itemcode != "")
        {
           Item_Code = " AND (Item_Code='" + itemcode + "') ";
        }

        if (itemdesc != "")
        {
           Item_Description = "AND (Item_Description like '%" + itemdesc + "%')" ;
        }

        // WHY MANU AND OEM IS COMMENTED
        // because manu and oem comes from tbl_enquiry when these are not found in item table
        // and our below whole query is based on item table

        if (itemmanuf != "")
        {
            Manufacturer = "AND (Manufacturer like '%" + itemmanuf + "%') " ;
        }

        if (itemoemref != "")
        {
            OEM_Reference = "AND (OEM_Reference like '%" + itemoemref + "%')";
        }

        if (Part_No != "")
        {
            Part_No = " and item_id in (select item_id from tbl_Item_External_Detail where Party_Type='Customer' and Product_code='" + Part_No + "')";
        }

        if (sub_cat_id != "0" & sub_cat_id != "")
        {
            Cat_SubCat_Id = "AND (Cat_SubCat_Id =" + sub_cat_id + ")";
        }

        string sql, sql_Page_Size = "SELECT	@PageSize = " + pagesize + ", @PageNumber = "+pagenumber+","
        + " @RecordCount = (Select Count(Item_Id) from tbl_Item where Status = 'True' " + Item_Code + " "
        + " " + Item_Description + " " + Manufacturer + " " + OEM_Reference + " " + Cat_SubCat_Id + ")";
				 
string sql_Row="SELECT @FirstRow = (@PageNumber - 0) * @PageSize + 1, @LastRow = (@PageNumber - 0) * @PageSize + @PageSize ;";
	
		string sql_with="WITH tbl_pg_item AS"
						+"( "
                        + "	Select Item_Id, Item_Code, Item_Description, Manufacturer, OEM_Reference,Unit,"
						+"	ROW_NUMBER() OVER (ORDER BY Item_Id desc) AS 'RowNumber',"
						+"	(@RecordCount)as RecCount"
						+"	from tbl_Item where Status='True' "
						+"	"+Item_Code+" "
						+"	"+Item_Description+" "
						+"	"+Manufacturer+" "
						+"	"+OEM_Reference+" "
                        +"	"+Cat_SubCat_Id+" "
                        +"	" + Part_No + " "
					    +")";

        string sql_select = "SELECT Item_Id, Item_Code, Item_Description, Manufacturer, OEM_Reference, Unit, RecCount "
            + " FROM tbl_pg_item "
            + " WHERE RowNumber Between @FirstRow AND @LastRow "
            + " ORDER BY "+SortColumn+" " + sortorder + "";

        sql = Declare_Para + sql_Page_Size + sql_Row   + sql_with + sql_select;
        
        return SqlHelper.ExecuteDataset(ConfigurationManager.AppSettings["con"],CommandType.Text, sql);
    }








    public static DataSet Bind_Supplier_Search_Popup(int pagesize, int pagenumber, int sortcolumn, string sortorder, string Supplier_Name, string Supplier_Short_Name, string Contact_Person_Name)
    {
        bool f = false;
        string Declare_Para, SortColumn="",Sup_Name="",sql_Supplier="",Sup_Short_name="",Cont_Person_Name="";
      
        if(Supplier_Name!="")
        {
            Sup_Name = " a.supplier_name like '%" + Supplier_Name + "%'"; f = true;
        }
        if(Supplier_Short_Name!="")
        {
            Sup_Short_name = " and a.Supplier_Short_Name like '%" + Supplier_Short_Name + "%'"; f = true;
        }
       
        if (Contact_Person_Name != "")
        {
            Cont_Person_Name = " and c.Name like '%" + Contact_Person_Name + "%' "; f = true;
        }

        if (f == true)
        {
            sql_Supplier += " where(";

            sql_Supplier += Sup_Name + Sup_Short_name + Cont_Person_Name;
            sql_Supplier = sql_Supplier.Trim().Replace("where( and ", "where( ");
            sql_Supplier = sql_Supplier + ")";

        }

        
        Declare_Para = "DECLARE	@FirstRow INT, @LastRow INT, @RecordCount Int, @PageSize int, @PageNumber int;";
        if (sortcolumn == 0) { SortColumn = " a.Supplier_name"; } else if (sortcolumn == 1) { SortColumn = " a.Supplier_Short_Name"; } else if (sortcolumn == 2) { SortColumn = " a.account_code"; }


        string sql, sql_Page_Size = "SELECT	@PageSize = " + pagesize + ", @PageNumber = " + pagenumber + ","
        + " @RecordCount = (Select Count(a.supplier_id) from tbl_supplier a   left outer join tbl_ledger_account b on a.[Account_Code]=b.Ledger_Account_Id left outer join [tbl_Contact_Person] c on c.Entity_Type='Supplier' and c.Entity_Id=a.Supplier_Id "
                        + " " + sql_Supplier + ")";
                        //+ "	" + Sup_Short_name + " "
                        //+ "	" + Cont_Person_Name + ")";

        string sql_Row = "SELECT @FirstRow = (@PageNumber - 0) * @PageSize + 1, @LastRow = (@PageNumber - 0) * @PageSize + @PageSize ;";

        string sql_with = "WITH tbl_pg_sup AS"
                        + "( "
                        + "	select a.supplier_id, a.Supplier_name, a.Supplier_Short_Name, b.account_code, "
                        + "	ROW_NUMBER() OVER (ORDER BY " + SortColumn + " " + sortorder + ") AS 'RowNumber',"
                        + "	(@RecordCount)as RecCount"
                        + "	from tbl_supplier a   left outer join tbl_ledger_account b on a.[Account_Code]=b.Ledger_Account_Id left outer join [tbl_Contact_Person] c on c.Entity_Type='Supplier' and c.Entity_Id=a.Supplier_Id "
                        + "	" + sql_Supplier + ")";
                        //+ "	" + Sup_Short_name + " "
                        //+ "	" + Cont_Person_Name + " "
                        //+ ")";

        string sql_select = "SELECT distinct supplier_id,Supplier_name, Supplier_Short_Name, account_code, RecCount "
            + " FROM tbl_pg_sup WHERE RowNumber Between @FirstRow AND @LastRow ";
           

        sql = Declare_Para + sql_Page_Size + sql_Row + sql_with + sql_select;

        return SqlHelper.ExecuteDataset(ConfigurationManager.AppSettings["con"], CommandType.Text, sql);
    }



    public Estimation()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}
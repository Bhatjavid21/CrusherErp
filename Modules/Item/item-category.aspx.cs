using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

public partial class item_category : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        G.L();
        if (!IsPostBack)
        {
            try
            {
                Bind_DDL_Branches();
                Bind_ddlSubDivision();
                tbody_Item_Category_List_View.InnerHtml = Bind_Item_category_To_List_View(ddl_Branch.Value);
                tbody_Item_Sub_Category_List_View.InnerHtml = Bind_Item_Sub_Category_To_List_View(-1, ddl_Branch.Value);
            }
            catch (Exception x)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert()", "alert(" + x.Message + ")", true);
            }
        }
    }

    #region Bind_DDL_Branches
    private void Bind_DDL_Branches()
    {
        string sql = "select Branch_Id, Branch_Name from tbl_Company_Branch Order By Branch_Name ASC";
        DataSet ds = DB.GetDataSet(sql);

        if (ds.Tables[0].Rows.Count > 0)
        {
            ddl_popup_Branch.DataTextField = ddl_Branch.DataTextField = "Branch_Name";
            ddl_popup_Branch.DataValueField = ddl_Branch.DataValueField = "Branch_Id";
            ddl_popup_Branch.DataSource = ddl_Branch.DataSource = ds;
            ddl_Branch.DataBind();
            ddl_popup_Branch.DataBind();
            ddl_Branch.Value = Session["session_ids"].ToString()
                                               .Split(',')[1];

        }
    }
    #endregion



    #region Bind_DDL_SubDivision
    public void Bind_ddlSubDivision()
    {
        string sql = "";

        if (G.HL() == true)
        {
             sql = "select Division_Id,Division_Name from tbl_Company_Division where  Parent_Division_Id!=0 and  Branch_Id =" + Session["session_ids"].ToString().Split(',')[1] + " and Is_Primary=1";

            DataTable DT = DB.GetDataTable(sql);
            ddlSubDivision.DataSource = DT;
            ddlSubDivision.DataTextField = "Division_Name";
            ddlSubDivision.DataValueField = "Division_Id";
            ddlSubDivision.DataBind();

            ddlSubDivision.Items.Insert(0, "Select");
            ddlSubDivision.Items.FindByText("Select").Value = "0";

        }

    }
    #endregion
    #region Bind Item Category to Table
    [System.Web.Services.WebMethod]
    public static string Bind_Item_category_To_List_View(string Branch_Id)
    {
        StringBuilder sb_Item_Category_List_View = new StringBuilder();
        try
        {
            if (G.HL() == true)
            {
                string sql_Get_Item_Category = "select Item_Category_Id, Item_Category_Name , Item_Type , Item_Category_Code from tbl_Item_Category where Branch_ID='" + Branch_Id + "'";
                SqlDataReader reader = DB.Get_temp(sql_Get_Item_Category);
                bool firstTime = true;
                string Item_Type = "";

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        if (reader.GetInt32(2) == 1)
                        { Item_Type = "Stock"; }
                        else if (reader.GetInt32(2) == 2) { Item_Type = " Non Stock"; }
                        else { Item_Type = " Service"; }

                        if (firstTime)
                        {
                            sb_Item_Category_List_View.Append("<tr onclick='Populate_SubCategoryList(" + reader["Item_Category_Id"] + ")'><td>" + Item_Type + "</td><td>" + reader.GetString(1) 
                                + "</td><td>" + reader.GetString(3) + "</td><td>");
                            firstTime = false;
                        }
                        else
                        {
                            sb_Item_Category_List_View.Append("<tr onclick='Populate_SubCategoryList(" + reader["Item_Category_Id"] + ")'><td>" + Item_Type + "</td><td>" + reader.GetString(1)
                                + "</td><td>" + reader.GetString(3) + "</td><td>");
                        }
                        sb_Item_Category_List_View.Append("<span class='btn' data-toggle='modal' data-target='#mdpopup-category' onclick='Set_CategoryModalFields_For_Edit(" + reader.GetInt32(0) + ");'><i class='fa fa-pencil' data-src='' data-title='Edit Account Group'></i></span>" +
                            "<input type='hidden' id='hdnitemcatId' name='itemcatId' value='" + reader.GetInt32(0) + "'>");
                        sb_Item_Category_List_View.Append("</td><tr>");

                    }
                }
                else
                {
                    sb_Item_Category_List_View.Append("<tr><td colspan=4>No data in records </td></tr>");
                }

                reader.Close();
            }
            else
            {
                sb_Item_Category_List_View.Append("SessionIsDead");
            }
        }
        catch (Exception x)
        {
            sb_Item_Category_List_View.Append("!error!" + x.Message + "");
        }
        return sb_Item_Category_List_View.ToString();
    }
    #endregion

    [System.Web.Services.WebMethod]
    public string Get_Category()
    {
        string q = Request.QueryString["id"];
        return "kjuhkh";
    }

    #region Bind  Item Sub Category
    [System.Web.Services.WebMethod]
    public static string Bind_Item_Sub_Category_To_List_View(int itemCategoryId, string branchId)
    {   
        StringBuilder sb_Item_Sub_Category_List_View = new StringBuilder();
        string sql_Get_Item_Sub_Category;
        try
        {
            if (G.HL() == true)
            {
                if (itemCategoryId == -1)
                {

                    sql_Get_Item_Sub_Category = "select Item_SubCategory_Id, Item_SubCategory_Name, Item_Code_Prefix from tbl_Item_SubCategory " +
                      "where Item_Category_Id = (select TOP 1 Item_Category_Id from tbl_Item_Category where Branch_ID='" + branchId + "')";
                }
                else
                {
                    sql_Get_Item_Sub_Category = "select Item_SubCategory_Id, Item_SubCategory_Name, Item_Code_Prefix from tbl_Item_SubCategory " +
                      "where Item_Category_Id = " + itemCategoryId;
                }
                SqlDataReader reader = DB.Get_temp(sql_Get_Item_Sub_Category);

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        sb_Item_Sub_Category_List_View.Append("<tr><td>" + reader.GetString(1) + "</td><td>" + reader.GetString(2) 
                            + "</td><td>");
                        sb_Item_Sub_Category_List_View.Append("<span class='btn' data-toggle='modal' data-target='#mdpopup-subcategory' onclick='Set_SubCategoryModalFields_For_Edit("+ reader.GetInt32(0) +");'><i class='fa fa-pencil' data-src='' data-title='Edit Account Group'></i></span>");
                        sb_Item_Sub_Category_List_View.Append("</td><tr>");
                    }
                }
                else
                {
                    sb_Item_Sub_Category_List_View.Append("<tr><td colspan='3'>No Item Sub Category Found</td></tr>");
                }

                reader.Close();
            }
            else
            {
                sb_Item_Sub_Category_List_View.Append("SessionIsDead");
            }
        }
        catch (Exception x)
        {
            sb_Item_Sub_Category_List_View.Append("!error!" + x.Message + "");
        }
        return sb_Item_Sub_Category_List_View.ToString();
    }
    #endregion

    [System.Web.Services.WebMethod]
    public static string Save_Category(string Branch_Id, string Item_Category_Name, string Item_Category_Code, string Item_Type)
    {
        StringBuilder output = new StringBuilder();
        string sql_Insert = "";
        string Category_Id = "0";
        try
        {
            if (G.HL() == true)
            {
                sql_Insert = "insert into tbl_Item_Category(Branch_Id, Item_Type, Item_Category_Code, Item_Category_Name,Item_Category_Detail)" +
                    " values ('" + Branch_Id + "', '" + Item_Type + "','" + Item_Category_Code + "','" + Item_Category_Name + "','" + Item_Category_Code + "'); select @@identity";

               Category_Id =  DB.Get_Scaler(sql_Insert);
                //Category_Id = DB.Get_Scaler(sql_Insert);
                // Log.Set_temp("tbl_Item_Category", Category_Id, "Insert");
                output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Attachment Added Successfully\",\"url\":\"\"}");
             //   output=""
            }
            else
            {
                output.Append("SessionIsDead");
            }
        }
        catch (Exception x)
        {
            output.Append("!error!" + x.Message + "");
        }
        return Category_Id;
        //Context.Response.Write(output.ToString());
    }

    [System.Web.Services.WebMethod]
    public static string Save_SubCategory(int Item_Sub_Category_Id, string Item_Sub_Category_Name, string Item_Sub_Category_Code, string Item_Sub_Category_Detail, string Item_Sub_Category_Prefix, int Item_Category_Id, string SubDiv)
    {
        StringBuilder output = new StringBuilder();
        string sql_Insert = "";
        string Sub_Category_Id;
        try
        {
            if (G.HL() == true)
            {
                sql_Insert = "insert into tbl_Item_SubCategory(Item_Category_Id, Item_SubCategory_Code, Item_SubCategory_Name,Item_SubCategory_Detail,Item_Code_Prefix,SubDivision_Id)" +
                    " values (" + Item_Category_Id + ", '" + Item_Sub_Category_Code + "','" + Item_Sub_Category_Name + "','" + Item_Sub_Category_Detail + "','" + Item_Sub_Category_Prefix + "','" + SubDiv + "')";
                SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["con"]);
                if (con.State == ConnectionState.Open) { con.Close(); } else { con.Open(); }

                SqlCommand command = new SqlCommand(sql_Insert, con);

                int rowsReturned = command.ExecuteNonQuery();
               
                output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"SubCategory Added Successfully\",\"url\":\"\"}");
            }
            else
            {
                output.Append("SessionIsDead");
            }
        }
        catch (Exception x)
        {
            output.Append("!error!" + x.Message + "");
        }
        return output.ToString();
        //Context.Response.Write(output.ToString());
    }

//==========================================Code Added By Javid ===================================================================================
 


    [System.Web.Services.WebMethod]
    public static string[] Edit_BindBack_Category(int Item_Category_Id)
    {
       // StringBuilder output = new StringBuilder();
       // string output = "";
        SqlDataReader DR;
        string sql = "";
        string Sub_Category_Id; 
        string []output = new string[10];
        try
        {
            if (G.HL() == true)
            {
                sql = "select * from tbl_Item_Category where Item_Category_Id="+Item_Category_Id;
               
                // Sub_Category_Id = DB.Get_Scaler(sql_Insert);
                //Log.Set_temp("tbl_Item_SubCategory", Sub_Category_Id, "Insert");

                //output[]

                DR = DB.Get_temp(sql);
                for (int i = 0; DR.Read(); i++)
                {

                   
                    output[0] = DR["Branch_Id"].ToString();
                    output[1] = DR["Item_Category_Code"].ToString();
                    output[2] = DR["Item_Category_Name"].ToString();
                    output[3] = DR["Item_Category_Detail"].ToString();
                    output[4] = DR["Item_Type"].ToString();

                }
               
  
            }
            else
            {
              //  output="SessionIsDead";
               // return output;
            }
        }
        catch (Exception x)
        {
            //output[0]("!error!" + x.Message + "");
        }
        return output;
      //  Context.Response.Write(output.ToString());
    }


    [System.Web.Services.WebMethod]
    public static string[] Edit_BindBack_SubCategory(string Item_SubCategory_Id)
    {
        // StringBuilder output = new StringBuilder();
        // string output = "";
        SqlDataReader DR;
        string sql = "";
        string Sub_Category_Id;
        string[] output = new string[10];
        try
        {
            if (G.HL() == true)
            {
                sql = "select * from tbl_Item_SubCategory where Item_SubCategory_Id=" + Item_SubCategory_Id;

                // Sub_Category_Id = DB.Get_Scaler(sql_Insert);
                //Log.Set_temp("tbl_Item_SubCategory", Sub_Category_Id, "Insert");

                //output[]

                DR = DB.Get_temp(sql);
                for (int i = 0; DR.Read(); i++)
                {

                    
                    output[0] = DR["Item_Category_Id"].ToString();
                    output[1] = DR["Item_SubCategory_Code"].ToString();
                    output[2] = DR["Item_SubCategory_Name"].ToString();
                    output[3] = DR["Item_SubCategory_Detail"].ToString();
                    output[4] = DR["Item_Code_Prefix"].ToString();
                    output[5] = DR["SubDivision_Id"].ToString();
                }


            }
            else
            {
                //  output="SessionIsDead";
                // return output;
            }
        }
        catch (Exception x)
        {
            //output[0]("!error!" + x.Message + "");
        }
        return output;
        //  Context.Response.Write(output.ToString());
    }




    [System.Web.Services.WebMethod]
    public static string Update_Category(string Branch_Id, string Item_Category_Name, string Item_Category_Code, string Category_Details, string Item_Type,string ItemCat_Id)
    {
        StringBuilder output = new StringBuilder();
        string Update_Cat = "";
        string Category_Id = "";
        try
        {
            if (G.HL() == true)
            {
                Update_Cat = "Update tbl_Item_Category set Branch_Id=" + Branch_Id + ", Item_Type=" + Item_Type + ", Item_Category_Code='" + Item_Category_Code + "', Item_Category_Name='" + Item_Category_Name + "',Item_Category_Detail='" + Category_Details +"' where Item_Category_Id="+ItemCat_Id;
                int rowsReturned = DB.Get_ScalerInt(Update_Cat);

               // = command.ExecuteNonQuery();
                //Category_Id = DB.Get_Scaler(sql_Insert);
                // Log.Set_temp("tbl_Item_Category", Category_Id, "Insert");
                output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Attachment Added Successfully\",\"url\":\"\"}");
                //   output=""
            }
            else
            {
                output.Append("SessionIsDead");
            }
        }
        catch (Exception x)
        {
            output.Append("!error!" + x.Message + "");
        }
        return output.ToString();
        //Context.Response.Write(output.ToString());
    }


    [System.Web.Services.WebMethod]
    public static string Update_Sub_Category(string Item_Category_Id, string Item_SubCategory_Name, string Item_SubCategory_Code, string Item_SubCategory_Detail, string Item_Code_Prefix, string Item_SubCat_Id,string SubDiv)
    {
        StringBuilder output = new StringBuilder();
        string Update_Cat = "";
        string Category_Id = "";
        try
        {
            if (G.HL() == true)
            {
                Update_Cat = "Update tbl_Item_SubCategory set Item_Category_Id=" + Item_Category_Id + ",Item_SubCategory_Name='" + Item_SubCategory_Name + "', Item_SubCategory_Code='" + Item_SubCategory_Code + "', Item_SubCategory_Detail='" + Item_SubCategory_Detail + "', Item_Code_Prefix='" + Item_Code_Prefix + "',SubDivision_Id = '"+ SubDiv + "' where Item_SubCategory_Id=" + Item_SubCat_Id;
                int rowsReturned = DB.Get_ScalerInt(Update_Cat);

                // = command.ExecuteNonQuery();
                //Category_Id = DB.Get_Scaler(sql_Insert);
                // Log.Set_temp("tbl_Item_Category", Category_Id, "Insert");
               // output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Attachment Added Successfully\",\"url\":\"\"}");
                output.Append("Success");
            }
            else
            {
                output.Append("SessionIsDead"); 
            }
        }
        catch (Exception x)
        {
            output.Append("!error!" + x.Message + "");
        }
        return output.ToString();
        //Context.Response.Write(output.ToString());
    }





    [System.Web.Services.WebMethod]
    public static string Search_Category(string SearchPreFix, string Branch_Id)
    {
       
      string output = "";
        string sql_Get_Item_Category;
        string Item_Type;
        //string Update_Cat = "";
        //string Category_Id = "";
        try
        {
            if (G.HL() == true)
            {

                if(!SearchPreFix.Trim().Equals(""))
                {
                 sql_Get_Item_Category = "select Item_Category_Id, Item_Category_Name , Item_Type , Item_Category_Code from tbl_Item_Category where (Item_Category_Name like '%"+SearchPreFix+"%' or Item_Category_Code like '%"+SearchPreFix+"%' or Item_Type like '%"+SearchPreFix+"%') and Branch_ID='"+Branch_Id+"'";
                }
                else
                {
                  sql_Get_Item_Category = "select Item_Category_Id, Item_Category_Name , Item_Type , Item_Category_Code from tbl_Item_Category where  Branch_ID='"+Branch_Id+"'";

                }
                SqlDataReader reader = DB.Get_temp(sql_Get_Item_Category);
                bool firstTime = true;
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        if (reader.GetInt32(2) == 1)
                        { Item_Type = "Stock"; }
                        else if (reader.GetInt32(2) == 2) { Item_Type = " Non Stock"; }
                        else { Item_Type = " Service"; }

                        if (firstTime)
                        {
                            output += ("<tr onclick='Populate_SubCategoryList(" + reader["Item_Category_Id"] + ")'><td>" + Item_Type + "</td><td>" + reader.GetString(1)
                                + "</td><td>" + reader.GetString(3) + "</td><td>");
                            firstTime = false;
                        }
                        else
                        {
                            output += ("<tr onclick='Populate_SubCategoryList(" + reader["Item_Category_Id"] + ")'><td>" + Item_Type + "</td><td>" + reader.GetString(1)
                                + "</td><td>" + reader.GetString(3) + "</td><td>");
                        }
                       
                        output += ("<span class='btn' data-toggle='modal' data-target='#mdpopup-category' onclick='Set_CategoryModalFields_For_Edit(" + reader.GetInt32(0) + ");'><i class='fa fa-pencil' data-src='' data-title='Edit Account Group'></i></span>" +
                           "<input type='hidden' id='hdnitemcatId' name='itemcatId' value='" + reader.GetInt32(0) + "'>");
                        output += ("</td><tr>");



                    }
                }
                else
                {
                    output+=("<tr><td colspan=4>No data in records </td></tr>");
                }

                reader.Close();
            }
            else
            {
                output+=("SessionIsDead");
            }
        }
        catch (Exception x)
        {
            output+=("!error!" + x.Message + "");
        }
        return output;
        //Context.Response.Write(output.ToString());
    }
}
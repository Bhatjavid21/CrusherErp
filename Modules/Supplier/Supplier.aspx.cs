using System;
using System.Web;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Supplier_Main : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        G.L();
        try
        {
            hdf_branch_id.Value = Session["session_ids"].ToString().Split(',')[1].ToString();
            Bind_Branch_DDL(hdf_branch_id.Value);
        }
        catch (Exception x)
        {
            lbl_h4.InnerText = x.Message;
        }
    }

    void Bind_Branch_DDL(string branch)
    {
        string sql = "select Branch_Id, Branch_Name from tbl_Company_Branch Order By Branch_Name ASC";

        DataTable DT = DB.GetDataTable(sql);
        if (DT.Rows.Count > 0)
        {
            DDL_Branch.DataSource = DT;
            DDL_Branch.DataTextField = "Branch_Name";
            DDL_Branch.DataValueField = "Branch_Id";
            DDL_Branch.DataBind();

            string Access_Level = G.Division_Access_Level_Ids("Supplier", "Supplier List", "View");

            string[] AccessString_splt = Access_Level.Split('|');

            if (AccessString_splt[0] == "Access is Restricted.")
            {
                DDL_Branch.Items.Insert(0, "All Branches");
                DDL_Branch.Disabled = true;
            }
            else
            {
                if (AccessString_splt[0] == "Yes")//Company Level Access
                {
                    DDL_Branch.Items.Insert(0, "All Branches");
                }
                else if (AccessString_splt[1] != "0") // Branch Leve
                {
                    DDL_Branch.Value = AccessString_splt[1];
                    DDL_Branch.Disabled = true;
                }
                else // Division Level
                {
                    // DDL_Branch.Items.Insert(0, "All Branches");
                    DDL_Branch.Disabled = true;
                    //DDL_Branch.Visible = false;
                    DDL_Branch.Value = branch;
                }
            }
        }
    }

    #region WebMethod Generate_Account_Code
    [System.Web.Services.WebMethod]
    public static string Generate_Account_Code(string SupplierId)
    {
        string output = "", sql = "";

        //concatenating ^1 means account code textbox should be disabled and ^0 means account code textbox should not be disabled
        sql = "select case when sup.Account_Code is not null then (select Account_Code+'^1' from tbl_Ledger_Account where Ledger_Account_Id=sup.Account_Code) when sup.Account_Code is null then CONVERT(varchar,(ISNULL(agg.Account_Code_Prefix,'')))+CONVERT(varchar,(select top(1)ISNULL((replace(la.Account_Code,ag.Account_Code_Prefix,'')),0)+1 from tbl_Account_Group ag left join tbl_Ledger_Account la on la.Account_Group_Id=ag.Account_Group_Id and ag.Account_Group_Name='ACCOUNTS PAYABLE' order by Ledger_Account_Id desc))+'^0' end as accountCode from tbl_Supplier sup left join tbl_Account_Group agg on agg.Account_Group_Name='ACCOUNTS PAYABLE' where sup.Supplier_Id='" + SupplierId + "'";
        SqlDataReader dr = DB.Get_temp(sql);

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                output = dr["accountCode"].ToString();
            }
            dr.Dispose();
            dr.Close();
        }
        return output;
    }
    #endregion

    #region Save_Supplier_Scope
    [System.Web.Services.WebMethod]
    public static string Save_Supplier_Scope(string Item_Sub_Cat_Id, string Supplier_Id, string Description, string Supplier_Scope_Id)
    {
        Description = Description.Replace("~", "'").Replace("'", "''");
        string res = "", sql = "";
        try
        {
            if (G.HL() == true)
            {
                if (Supplier_Scope_Id == "0")
                {
                    int Sup_Id = Convert.ToInt32(DB.Get_ScalerInt("select Supplier_Id from tbl_Supplier_Scope where Supplier_Id=" + Supplier_Id + " and Item_SubCategory_Id=" + Item_Sub_Cat_Id + ""));
                    if (Sup_Id > 0)
                    {
                        res = "already exists";
                    }
                    else
                    {
                        sql = "insert into tbl_Supplier_Scope (Supplier_Id, Item_SubCategory_Id, Details) values ('" + Supplier_Id + "','" + Item_Sub_Cat_Id + "','" + Description + "'); select @@IDENTITY";
                        Supplier_Scope_Id = DB.Get_Scaler(sql);

                        Log.Set_temp("tbl_Supplier", Supplier_Scope_Id, "Insert");
                        res = "saved";
                    }
                }
                else
                {
                    sql = "update tbl_Supplier_Scope set Item_SubCategory_Id='" + Item_Sub_Cat_Id + "', Details='" + Description + "' where Supplier_Scope_Id='" + Supplier_Scope_Id + "'";
                    DB.Set_temp(sql);

                    Log.Set_temp("tbl_Supplier", Supplier_Scope_Id, "Update");
                    res = "updated";
                }
            }
            else
            {
                res = "SessionIsDead";
            }
        }
        catch (Exception x)
        {
            res = "!error!" + x.Message + "";
        }
        return res;
    }
    #endregion

    #region Get_Items - Bind Dropdown Categories
    [System.Web.Services.WebMethod]
    public static string Get_Items(string item_Type, string branch_Id, string Selected_Item)
    {
        string output = "", sql = "";
        try
        {
            if (G.HL() == true)
            {
                sql = "Select distinct B.Item_SubCategory_Id, B.Item_Code_Prefix, (A.Item_Category_Name + ' > ' + B.Item_SubCategory_Name) as CatSubCatName From tbl_Item_SubCategory as B inner join tbl_Item_Category as A on A.Item_Category_Id = B.Item_Category_Id Where a.branch_id='" + branch_Id + "' and A.Item_Type='" + item_Type + "' order by  CatSubCatName ";
                DataTable dt = DB.GetDataTable(sql);

                if (dt.Rows.Count > 0)
                {
                    if (Selected_Item == "0")
                    {
                        output += "<option value='0' selected>Select</option>";
                    }
                    else
                    {
                        output += "<option value='0'>Select</option>";
                    }

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (Selected_Item == dr["Item_SubCategory_Id"].ToString())
                        {
                            output += "<option selected value = " + dr["Item_SubCategory_Id"] + ">" + dr["CatSubCatName"] + "</option>";
                        }
                        else
                        {
                            output += "<option value = " + dr["Item_SubCategory_Id"] + ">" + dr["CatSubCatName"] + "</option>";
                        }
                    }
                }
                else
                {
                    output += "<option value='0' selected>Select</option>";
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x)
        {
            output = "!error!" + x.Message + "";
        }
        return output;
    }
    #endregion

    #region Get_Scope_Of_Supply
    [System.Web.Services.WebMethod]
    public static string Get_Scope_Of_Supply(string supplier_Id)
    {
        string output = "", sql = "", item_Type = "";
        try
        {
            if (G.HL() == true)
            {
                sql = "select ss.Supplier_Scope_Id,ic.Item_Type,ss.Item_SubCategory_Id,isc.Item_SubCategory_Name,ss.Details from tbl_Supplier_Scope ss inner join tbl_Item_SubCategory isc on isc.Item_SubCategory_Id=ss.Item_SubCategory_Id inner join tbl_Item_Category ic on ic.Item_Category_Id=isc.Item_Category_Id where ss.Supplier_Id='" + supplier_Id + "' order by Supplier_Scope_Id desc";
                DataTable dt_Scope = DB.GetDataTable(sql);

                if (dt_Scope.Rows.Count > 0)
                {
                    for (int i = 0; i < dt_Scope.Rows.Count; i++)
                    {
                        if (dt_Scope.Rows[i]["Item_Type"].ToString() == "1")
                        {
                            item_Type = "Stock";
                        }
                        else if (dt_Scope.Rows[i]["Item_Type"].ToString() == "2")
                        {
                            item_Type = "Non-Stock";
                        }
                        output += "<tr>";
                        output += "<td>" + item_Type + "</td>";
                        output += "<td>" + dt_Scope.Rows[i]["Item_SubCategory_Name"] + "</td>";
                        output += "<td>" + dt_Scope.Rows[i]["Details"] + "</td>";

                        output += "<td class='text-center'>"
                                    + "<div class='btn-group'>"
                                    + " <button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>"
                                    + "<span><i class='ti-settings'></i></span></button>"
                                    + "<ul class='dropdown-menu dropdown-menu-right'>";

                        //output += "<li onclick='View_Supplier_Scope(" + dt_Scope.Rows[i]["Supplier_Scope_Id"] + ");'><a href='#' class='dropdown-item'><i class='fa fa-eye'></i> Details</a></li>";

                        output += "<li onclick='View_Supplier_Scope(" + dt_Scope.Rows[i]["Supplier_Scope_Id"] + ");'><a href='#' class='dropdown-item'><i class='fa fa-pencil'></i> Edit</a></li>";

                        output += "<li class='dropdown-divider'></li>";
                        output += "<li onclick='Delete_Supplier_Scope(" + dt_Scope.Rows[i]["Supplier_Scope_Id"] + ");'><a href='#' class='dropdown-item'><i class='fa fa-stop-circle'></i> Delete</a></li>";

                        output += "</ul></div></td>";
                        output += "</tr>";
                    }
                }
                else
                {
                    output = "<tr><td colspan='12' class='text-center'>No record found</td></tr>";
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x)
        {
            output = "!error!" + x.Message + "";
        }
        return output;
    }
    #endregion

    #region Bind_Supplier_Scope_Details
    [System.Web.Services.WebMethod]
    public static string Bind_Supplier_Scope_Details(string supplier_Scope_Id)
    {
        string output = "", sql = "", Sub_Cat_Id = "0", Des = "", item_Type = "";

        try
        {
            if (G.HL() == true)
            {
                sql = "select ss.Supplier_Scope_Id,ic.Item_Type,ss.Item_SubCategory_Id,ss.Details from tbl_Supplier_Scope ss inner join tbl_Item_SubCategory isc on isc.Item_SubCategory_Id=ss.Item_SubCategory_Id inner join tbl_Item_Category ic on ic.Item_Category_Id=isc.Item_Category_Id where ss.Supplier_Scope_Id='" + supplier_Scope_Id + "'";
                DataTable dt_Scope = DB.GetDataTable(sql);

                if (dt_Scope.Rows.Count > 0)
                {
                    item_Type = dt_Scope.Rows[0]["Item_Type"].ToString();
                    Sub_Cat_Id = dt_Scope.Rows[0]["Item_SubCategory_Id"].ToString();
                    Des = dt_Scope.Rows[0]["Details"].ToString();

                    output = item_Type + "^" + Sub_Cat_Id + "^" + Des;
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x)
        {
            output = "!error!" + x.Message + "";
        }
        return output;
    }
    #endregion

    #region Delete_Scope_of_Supply
    [System.Web.Services.WebMethod]
    public static string Delete_Scope_of_Supply(string supplier_Scope_Id)
    {
        string output = "";
        try
        {
            string sql = "delete from tbl_Supplier_Scope where Supplier_Scope_Id='" + supplier_Scope_Id + "'";
            DB.Set_temp(sql);
            output = "ok";
        }
        catch (Exception x)
        {
            output = "!error!" + x.Message;
        }

        return output;
    }
    #endregion
}
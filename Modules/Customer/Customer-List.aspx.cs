using System;
using System.Web;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.Sql;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Customer_Main : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        G.L();
        try
        {
            if (!string.IsNullOrEmpty(Request.QueryString["enq"]))
            {
                hid_Open_From_Enquiry_Page.Value = Request.QueryString["enq"];
            }
            else
            {
                hid_Open_From_Enquiry_Page.Value = "";
            }

            if (Session["session_ids"] != null)
            {
                hdf_branch_id.Value = Session["session_ids"].ToString().Split(',')[1].ToString();
                Bind_Branch_DDL(hdf_branch_id.Value);
            }
            else
            {
                Response.Redirect(G.B);
            }

        }
        catch (Exception x)
        {
            lbl_error.InnerText = x.Message;
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

            string Access_Level = G.Division_Access_Level_Ids("Customer", "Customer List", "View");

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
    public static string Generate_Account_Code(string CustomerID)
    {
        string output = "", sql = "";

        //concatenating ^1 means account code textbox should be disabled and ^0 means account code textbox should not be disabled
        sql = "select case when cs.Account_Code is not null then (select Account_Code+'^1' from tbl_Ledger_Account where Ledger_Account_Id=cs.Account_Code) when cs.Account_Code is null then CONVERT(varchar,(ISNULL(agg.Account_Code_Prefix,'')))+CONVERT(varchar,(select top(1)ISNULL((replace(la.Account_Code,ag.Account_Code_Prefix,'')),0)+1 from tbl_Account_Group ag left join tbl_Ledger_Account la on la.Account_Group_Id=ag.Account_Group_Id and ag.Account_Group_Name='ACCOUNTS RECEIVABLES' order by Ledger_Account_Id desc))+'^0' end as accountCode from tbl_Customer cs left join tbl_Account_Group agg on agg.Account_Group_Name='ACCOUNTS RECEIVABLES' where cs.Customer_Id='" + CustomerID + "'";
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
}
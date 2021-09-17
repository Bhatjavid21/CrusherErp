using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class items : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        G.L();
        try
        {
            //if (!string.IsNullOrEmpty(Request.QueryString["enq"]))
            //{
            //    hid_Open_From_Enquiry_Page.Value = Request.QueryString["enq"];
            //}
            //else
            //{
            //    hid_Open_From_Enquiry_Page.Value = "";
            //}

            Log.Set_temp("tbl_Item", "67", "Insert");

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
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert()", "alert(" + x.Message + ")", true);
        }
    }


    void Bind_Branch_DDL(string branch)
    {
        string sql = "";

        sql = "select Branch_Id, Branch_Name from tbl_Company_Branch Order By Branch_Name ASC";

        DataTable DT = DB.GetDataTable(sql);
        if (DT.Rows.Count > 0)
        {
            DDL_Branch.DataSource = DT;
            DDL_Branch.DataTextField = "Branch_Name";
            DDL_Branch.DataValueField = "Branch_Id";
            DDL_Branch.DataBind();

            DDL_Branch.Items.Insert(0, "All Branches");
            DDL_Branch.Items.FindByText("All Branches").Value = "0";
            DDL_Branch.Items.FindByText("All Branches").Selected = true;

            // DDL_Branch.Items.FindByValue(hdf_branch_id.Value).Selected = true;
        }
    }
}

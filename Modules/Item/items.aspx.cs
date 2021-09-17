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

            if (Session["session_ids"] != null)
            {
                hdf_branch_id.Value = Session["session_ids"].ToString().Split(',')[1].ToString();

                Bind_Branch_DDL(hdf_branch_id.Value);
            }

            //else
            //{
            //    Response.Redirect(G.B);
            //}

        }
        catch (Exception x)
        {
        }

    }


    void Bind_Branch_DDL(string branch)
    {
        string sql = "";
        try
        {
            sql = "select Branch_Id, Branch_Name from tbl_Company_Branch Order By Branch_Name ASC";

            DataTable DT = DB.GetDataTable(sql);
            if (DT.Rows.Count > 0)
            {
                DDL_Branch.DataSource = DT;
                DDL_Branch.DataTextField = "Branch_Name";
                DDL_Branch.DataValueField = "Branch_Id";
                DDL_Branch.DataBind();

                DDL_Branch.Items.Insert(0,new ListItem("All Branches","0"));

                //DDL_Branch.Items.FindByValue(hdf_branch_id.Value).Selected = true;
            }

            Category_BindDropDown();
        }
        catch (Exception x)
        {
            Response.Write(x.Message + "- " + x.StackTrace);
        }


    }


    void Category_BindDropDown()
    {
        string sql;

        sql = "select DISTINCT b.[Item_SubCategory_Id], a.[Item_Category_Name], b.[Item_SubCategory_Name] from [tbl_Item_Category] a, [tbl_Item_SubCategory] b, tbl_Item C where a.[Item_Category_Id]=b.[Item_Category_Id] AND  b.[Item_SubCategory_Id]=C.Cat_SubCat_Id and a.Branch_Id='" + Session["session_ids"].ToString().Split(',')[1].ToString() + "'";

        DataTable DT_Cat = DB.GetDataTable(sql);

        ListItem resw = new ListItem("Select Category", "0");
        ddl_item_category.Items.Add(resw);

        if (DT_Cat.Rows.Count > 0)
        {
            for (int i = 0; i < DT_Cat.Rows.Count; i++)
            {

                resw = new ListItem(DT_Cat.Rows[i]["Item_Category_Name"].ToString() + ">" + DT_Cat.Rows[i]["Item_SubCategory_Name"].ToString(), DT_Cat.Rows[i]["Item_SubCategory_Id"].ToString());

                ddl_item_category.Items.Add(resw);
            }

            ddl_item_category.Items.FindByValue("0").Selected = true;
        }
    }
}

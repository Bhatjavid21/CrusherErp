using System;

public partial class addItem : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        G.L();

        //if (Session["session_ids"] != null)
        //{
            hdf_branch_id.Value = Session["session_ids"].ToString().Split(',')[1].ToString();
        //}
        
    }
}
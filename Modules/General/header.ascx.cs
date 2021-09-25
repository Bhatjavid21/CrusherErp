using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class user_controls_header : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindEmployeeDetails();
        }
    }

    private void BindEmployeeDetails()
    {
        if (Session["session_ids"] != null)
        {
            string employeeId = Session["session_ids"].ToString().Split(',')[0].ToString();
            string empOtherDetails = Session["session_ids"].ToString().Split(',')[4].ToString();

            imgEmployeeHeaderImage.Src = "../../Modules/Employee/Employee_Images/" + empOtherDetails.Split('|')[0] + "";
            imgEmployeePopupImage.Src = "../../Modules/Employee/Employee_Images/" + empOtherDetails.Split('|')[0] + "";

            spnEmployeeName.InnerText = empOtherDetails.Split('|')[1];
            spnEmployeeEmail.InnerText = empOtherDetails.Split('|')[2];

            btnViewProfile.HRef = "../../Modules/Employee/profile.aspx?empid=" + employeeId + "&v=1";
        }
    }

    protected void lnkBtnSignOut_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Response.Redirect("../../Default.aspx", true);
    }
}
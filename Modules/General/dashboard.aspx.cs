using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
public partial class dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetDashboardCount();
        }
    }


    private void GetDashboardCount()
    {
        StringBuilder str = new StringBuilder();
        str.Append("select count(1) as customers from tbl_Customer_Supplier where IsActive=1 and IsSupplier=0");
        str.Append(" select count(1) as products from tbl_Product");
        str.Append(" select count(1) as suppliers from tbl_Customer_Supplier where IsActive = 1 and IsSupplier = 1");
        str.Append(" select count(1) as purchases from tbl_Purchase");
        str.Append(" select count(1) as sales from tbl_sales");
        str.Append(" select count(1) as invoices from Tbl_Invoice");

        DataSet Dt = DB.GetDataSet(str.ToString());
        ltrCustomers.Text = Dt.Tables[0].Rows[0]["customers"] + "";
        ltrProducts.Text = Dt.Tables[1].Rows[0]["products"] + "";
        ltrSuppliers.Text = Dt.Tables[2].Rows[0]["suppliers"] + "";
        ltsPurchases.Text = Dt.Tables[3].Rows[0]["purchases"] + "";
        ltrSales.Text = Dt.Tables[4].Rows[0]["sales"] + "";
        ltrInvoices.Text = Dt.Tables[5].Rows[0]["invoices"] + "";


    }
}
<%@ WebHandler Language="C#" Class="H_tbl_Sales" %>
using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.Sql;
using System.Web.SessionState;
using Newtonsoft.Json;
using System.Configuration;
using ClosedXML.Excel;
using System.Text;

public class H_tbl_Sales : IHttpHandler, IRequiresSessionState
{
    HttpContext Context; Int16 DF = 0;
    public void ProcessRequest(HttpContext context)
    {
        Context = context; if (!string.IsNullOrEmpty(Context.Request["fun"]))
        {
            try
            {
                /// if (G.HL() == true)
                // {
                // DF = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[3]);

                switch (Context.Request["fun"].ToString())
                {

                    case "Save_Sales":

                        Save_Sales(context.Request.Form["InsertArray"]);

                        break;
                    case "ListAllSales":

                        ListAllSales(context.Request.Form["SearchString"],Convert.ToInt32(context.Request.Form["Page_No"]),context.Request.Form["customer"]);

                        break;
                    case "bindddls":
                        bindddls();
                        break;
                    case "GetRate":
                        GetRate(context.Request.Form["Product_Id"]);
                        break;
                    case "Edit":
                        Edit(context.Request.Form["Sales_Id"]);
                        break;
                    case "Update_Sales":
                        Update_Sales(context.Request.Form["InsertArray"], context.Request.Form["Sales_Id"]);
                        break;
                    case "SaveVoucher":
                        SaveVoucher(context.Request.Form["Sales_id"],context.Request.Form["Vouchers"]);
                        break;
                }
                //  }
                //  else { Context.Response.Write("SessionIsDead"); }
            }
            catch (Exception x) { Context.Response.Write("!error!" + x.Message); }
        }
        Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    void Edit(string Sales_Id)
    {
        string jasonString1 = "";
        DataTable Dt = DB.GetDataTable("select * from tbl_Sales where Id="+Sales_Id);
        if (Dt.Rows.Count > 0)
        {
            jasonString1 = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(jasonString1);
    }
    void bindddls()
    {
        string jasonString1 = ""; string jasnString2 = "";
        int Max_Number = 0;
        DataTable Dt = DB.GetDataTable("select Id,Name from tbl_Customer_Supplier where IsSupplier=0");
        if (Dt.Rows.Count > 0)
        {
            jasonString1 = JsonConvert.SerializeObject(Dt);
        }
        else
        {
            jasonString1 = "";
        }
        DataTable dt2 = DB.GetDataTable("select Id,Product_Name from tbl_Product");
        if (dt2.Rows.Count > 0)
        {
            jasnString2 = JsonConvert.SerializeObject(dt2);
        }
        else
        {
            jasnString2 = "";
        }
        Max_Number = DB.Get_ScalerInt("if exists (select id from tbl_Sales)  select Max(id) as Max_Id from tbl_Sales else select 0 as Max_Id")+1;
        Context.Response.Write(jasonString1 + "|" + jasnString2+"|"+Max_Number.ToString());
    }
    void GetRate(string Product_id)
    {
        string Rate = DB.Get_Scaler("Select Rate from tbl_Product where Id=" + Product_id);
        Context.Response.Write(Rate);
    }
    //*********************************View*********************************View******************************************View***********************************************************
    void ListAllSales(string SearchString,int Page_No,string customer)
    {
        string EditAccess = "True";
        string ApproveAccess = "True";
        string output="";
        int TotalRecords = 0, from = 1, to = 20; if (Page_No == 0) { Page_No = 1; };
        // StringBuilder output = new StringBuilder();
        from = (((Page_No * 20) - 20) + 1); to = Page_No * 20;
        string CustomerFilter="";
        if (!customer.Equals("0"))
        {
            CustomerFilter = " and a.Customer_Id='" + customer + "' ";
        }

        //string StatusFilter="";
        //if(!status.Equals(""))
        //{
        //    StatusFilter=" and a.Approval_Status="+status;
        //}
        string SearchFilter ="";
        if(!SearchString.Equals(""))
        {
            SearchFilter="and  ( a.Sale_Order_No like '%"+SearchString+"%' or  b.Name like '%"+SearchString+"%' )";
        }

        string  sql = "With NewTable as( select a.*,b.Id as CusId,c.Id as ProdId, b.Name,c.Product_Name,ROW_NUMBER() over (order by a.Id desc) as RowNum from tbl_Sales a left outer join tbl_Customer_Supplier b on a.Customer_Id=b.Id "+
                      " left outer join tbl_product c on a.Product_Id=c.Id where 1=1 "+SearchFilter+CustomerFilter+") select * from NewTable where RowNum between "+from+" And "+to;

        DataTable dt=DB.GetDataTable(sql);
        TotalRecords=DB.Get_ScalerInt("select count(a.Id) from tbl_Sales a left outer join tbl_Customer_Supplier b on a.Customer_Id=b.Id left outer join tbl_product c on a.Product_Id=c.Id where 1=1  "+SearchFilter+CustomerFilter);

        if(dt.Rows.Count>0)
        {
            foreach(DataRow dr in dt.Rows)
            {

                output += "<tr>" +
                       "<td>" + Convert.ToDateTime(dr["Sale_Date"]).ToString("dd-MM-yyyy") + "</td>" +
                       "<td>" + dr["Name"] + "</td>" +
                       "<td>" + dr["Product_Name"] + "</td>" +
                       "<td>" + dr["Sale_Order_No"] + "</td>" +
                        "<td> " + dr["Quantity"] + " </td>" +
                        "<td> " + dr["Rate"] + " </td>" +
                        "<td> " + dr["Sales_Price"] + " </td>" +
                        "<td> " + dr["Discount_Amount"] + " </td>" +
                        "<td> " + dr["Fuel_Price"] + " </td>" +
                         "<td style='word-wrap:break-word'> " + dr["Voucher_Numbers"] + " </td>" +
                        "<td> " + dr["Total_Cost"] + " </td>";


                output +=  "<td> "+
                  "<div class='btn-group'>" +
                                            "<button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>" +
                                                "<span><i class='ti-settings'></i></span>" +
                                            "</button>" +
                                            "<ul class='dropdown-menu dropdown-menu-right'>";
                output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#Popup' onclick='Edit(this.id,1)'><i class='fa fa-eye'></i>View</a></li>" +
                   "<li class='dropdown-divider'></li>";
                output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#Popup' onclick='Edit(this.id,0)'><i class='fa fa-edit'></i>Edit</a></li>" +
                  "<li class='dropdown-divider'></li>";
                output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#Popupvocher' onclick=AddVoucher(this.id,'"+dr["Voucher_Numbers"]+"')><i class='fa fa-doc'></i>Add/View Voucher</a></li>" +
                 "<li class='dropdown-divider'></li>";
                output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal'  deletesale(this.id)'><i class='fa fa-delete'></i>Delete Sale</a></li>" +
                 "<li class='dropdown-divider'></li>";

                //if(EditAccess.Equals("True"))
                //{
                //    output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#Popup' onclick='Getdata(this.id,0)'><i class='fa fa-edit'></i>Edit</a></li>" +
                //"<li class='dropdown-divider'></li>";
                //}
                //if(ApproveAccess.Equals("True"))
                //{
                //    output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#AprovePopup' onclick='GetEstimatedAmnt(this.id)'><i class='fa fa-edit'></i>Approve</a></li>" +
                //      "<li class='dropdown-divider'></li>";
                //}


                output+="</div> </td></tr>";
            }
        }
        else
        {
            output+="<tr><td colspan='8'> No Records Found  </td></tr>";
        }
        string str_Pagging = "", Paging_Strip = Pagination.PG(TotalRecords, Page_No, 20);

        if (TotalRecords > 1)
        {
            str_Pagging = "<div class='dataTables_info ' id='#' role='status' aria-live='polite'>Showing " + from + " to " +
                to + " of " + TotalRecords + " entries</div>"
                  + "<div class='dataTables_paginate paging_simple_numbers right' id='#_paginate'>"
                  + "<ul class='pagination'>"
                  + Paging_Strip

                  + "</ul></div></div>";
        }
        Context.Response.Write(output+"|"+str_Pagging);
    }
    void Save_Sales(string InsertArray)
    {
        int Ret=-9;
        StringBuilder str = new StringBuilder();
        string[] Data = InsertArray.Split('|');
        string Sale_Order_No = GetSONumber(Data[0], Data[12]);
        // string sql = "Insert into tbl_Sales values('" + Data[0] + "','" + Sale_Order_No + "','"+Convert.ToDateTime(Data[13]).ToString("yyyy-MM-dd")+"','" + Data[1] + "','" + Data[2] + "','" + Data[3] + "','" + Data[4] + "','" + Data[5] + "','" + Data[6] + "','" + Data[7] + "','" + Data[8] + "','" + Data[9] + "','" + Data[10] + "','" + Data[11] + "')";
        str.Append("INSERT INTO [dbo].[tbl_Sales]([Customer_Id],[Sale_Order_No],[Sale_Date],[Product_Id],[Quantity],[Rate],[Trips],[Site],[Sales_Price],[Fuel_Price],[Discount_Amount],[Total_Cost],[Vehicle_No],[Remarks])VALUES ");
        str.Append("('" + Data[0] + "','" + Sale_Order_No + "','" + Convert.ToDateTime(Data[13]).ToString("yyyy-MM-dd") + "','" + Data[1] + "','" + Data[2] + "','" + Data[3] + "','" + Data[4] + "','" + Data[5] + "','" + Data[6] + "','" + Data[7] + "','" + Data[8] + "','" + Data[9] + "','" + Data[10] + "','" + Data[11] + "')");
        Ret = DB.Get_ScalerInt(str.ToString());
        if(Ret>-1)
        {
            DB.Get_ScalerInt("Update tbl_Customer_Supplier set Balance=Balance+" + Data[9] + " where Id=" + Data[0]);
            Context.Response.Write("Success");
        }
        else
        {
            Context.Response.Write("Something Went Wrong");
        }

    }


    void Update_Sales(string InsertArray,string Sales_Id)
    {
        int Ret=-9;
        decimal OldTotalcost = decimal.Parse(DB.Get_Scaler("Select Total_Cost from tbl_Sales where Id=" + Sales_Id));
        string[] Data = InsertArray.Split('|');
        decimal NewTotalCost = decimal.Parse(Data[9]);
        decimal Difrence =NewTotalCost- OldTotalcost  ;

        string sql = "Update  tbl_Sales Set Quantity='" + Data[2] + "',Rate='" + Data[3] + "',Trips='" + Data[4] + "',Site='" + Data[5] + "',Sales_Price='"+Data[6]+"',Fuel_Price='" + Data[7] + "',Discount_Amount='" + Data[8] + "',Total_Cost='"+Data[9]+"',Vehicle_No='" + Data[10] + "',Remarks='" + Data[11] +"',Sale_Date='"+Convert.ToDateTime(Data[13]).ToString("yyyy-MM-dd")+"' where Id="+Sales_Id;
        Ret = DB.Get_ScalerInt(sql);
        if(Ret>-1)
        {
            DB.Get_ScalerInt("Update tbl_Customer_Supplier set Balance=Balance+" + Difrence + " where Id=" + Data[0]);
            Context.Response.Write("Success");
        }
        else
        {
            Context.Response.Write("Something Went Wrong");
        }

    }

    string GetSONumber(string customer_id,string Max_Num)
    {
        string SONUM = "";
        string CustomerBusName = DB.Get_Scaler("select Business_Id from tbl_Customer_Supplier where Id=" + customer_id);
        SONUM = CustomerBusName + "-" + DateTime.Now.Year.ToString() + "-" + Max_Num;
        return SONUM;
    }

    void SaveVoucher(string sales_id,string Vouchers)
    {   int Ret = -9;
        Ret = DB.Get_ScalerInt("Update  tbl_Sales Set Voucher_Numbers='" + Vouchers + "' where Id="+sales_id);
        if(Ret>-1)
        {

            Context.Response.Write("Success");
        }
        else
        {
            Context.Response.Write("");
        }
    }

    public bool IsReusable { get { return false; } }
}
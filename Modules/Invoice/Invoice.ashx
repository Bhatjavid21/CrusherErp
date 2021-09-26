<%@ WebHandler Language="C#" Class="H_tbl_Invoice" %>
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

public class H_tbl_Invoice : IHttpHandler, IRequiresSessionState
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

                    case "Save_Invoice":

                        Save_Invoice(context.Request.Form["MainArray"],context.Request.Form["TableData"]);

                        break;
                    case "ListAllInvoice":

                        ListAllInvoice(context.Request.Form["SearchString"],Convert.ToInt32(context.Request.Form["Page_No"]));

                        break;
                    case "bindddls":
                        bindddls();
                        break;
                    case "GetRate":
                        GetRate(context.Request.Form["Product_Id"]);
                        break;
                    case "Edit":
                        Edit(context.Request.Form["Invoice_Id"]);
                        break;
                    case "Update_Invoice":
                        Update_Invoice(context.Request.Form["InsertArray"], context.Request.Form["Invoice_Id"]);
                        break;
                    case "GetSalesItems":
                        GetSalesItems(context.Request.Form["Cus_Id"],context.Request.Form["Frmdate"],context.Request.Form["Todate"]);
                        break;
                }
                //  }
                //  else { Context.Response.Write("SessionIsDead"); }
            }
            catch (Exception x) { Context.Response.Write("!error!" + x.Message); }
        }
        Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    void Edit(string Invoice_Id)
    {
        string jasonString1 = "";
        DataTable Dt = DB.GetDataTable("select * from tbl_Invoice where Id="+Invoice_Id);
        if (Dt.Rows.Count > 0)
        {
            jasonString1 = JsonConvert.SerializeObject(Dt);
        }
        string jasonString2 = "";
        DataTable Dt1 = DB.GetDataTable("select * from tbl_Invoice_Items where Invoice_Id="+Invoice_Id);
        if (Dt.Rows.Count > 0)
        {
            jasonString2 = JsonConvert.SerializeObject(Dt1);
        }

        Context.Response.Write(jasonString1+"|"+jasonString2);
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


        Context.Response.Write(jasonString1);
    }
    void GetSalesItems(string Customer_id,string Fromdate,string Todate )
    {
        string jasonString1 = "";

        DataTable Dt = DB.GetDataTable("select a.id,a.Sale_order_no,a.Sale_Date,b.product_name,a.quantity,a.trips,a.fuel_price,a.total_cost from tbl_Sales a left outer join tbl_Product b on a.product_id=b.id where Customer_id="+Customer_id +" and a.Sale_Date between '"+Fromdate+"' and  '"+Todate+"'");
        if (Dt.Rows.Count > 0)
        {
            jasonString1 = JsonConvert.SerializeObject(Dt);
        }
        else
        {
            jasonString1 = "";
        }


        Context.Response.Write(jasonString1);
    }
    void GetRate(string Product_id)
    {
        string Rate = DB.Get_Scaler("Select Rate from tbl_Product where Id=" + Product_id);
        Context.Response.Write(Rate);
    }
    //*********************************View*********************************View******************************************View***********************************************************
    void ListAllInvoice(string SearchString,int Page_No)
    {
        string EditAccess = "True";
        string ApproveAccess = "True";
        string output="";
        int TotalRecords = 0, from = 1, to = 20; if (Page_No == 0) { Page_No = 1; };
        // StringBuilder output = new StringBuilder();
        from = (((Page_No * 20) - 20) + 1); to = Page_No * 20;
        string SourceTypeFilter="";
        //if(!SourceType.Equals("Select"))
        //{
        //    SourceTypeFilter=" and a.Source_Type='"+SourceType+"' ";
        //}

        //string StatusFilter="";
        //if(!status.Equals(""))
        //{
        //    StatusFilter=" and a.Approval_Status="+status;
        //}
        string SearchFilter="";
        if(!SearchString.Equals(""))
        {
            SearchFilter="and  ( a.Invoice_No like '%"+SearchString+"%' or  b.Name like '%"+SearchString+"%' )";
        }

        string  sql = "with newtable as ( select  a.Id,a.Invoice_No,Invoice_Date,b.Name,a.From_Date,a.To_Date,a.Invoice_Amount,ROW_NUMBER() over (order by a.Id desc) as RowNum from Tbl_Invoice a left outer join tbl_Customer_Supplier b on a.Customer_Id=b.Id where 1=1 "+SearchFilter+") select * from newtable where RowNum between "+from+" And "+to;

        DataTable dt=DB.GetDataTable(sql);
        TotalRecords=DB.Get_ScalerInt("select count(a.Id) from tbl_Invoice a left outer join tbl_Customer_Supplier b on a.Customer_Id=b.Id  where 1=1  "+SearchFilter);

        if(dt.Rows.Count>0)
        {
            foreach(DataRow dr in dt.Rows)
            {
                string NoofSales = DB.Get_Scaler(" select count(Item_Id) from Tbl_Invoice_Items where Invoice_Id= " + dr["Id"]);
                output += "<tr>" +

                       "<td>" + Convert.ToDateTime(dr["Invoice_Date"]).ToString("dd-MM-yyyy")+ "</td>" +
                       "<td>" + dr["Name"] + "</td>" +
                        "<td> " +Convert.ToDateTime(dr["From_Date"]).ToString("dd-MM-yyyy")+ " </td>" +
                        "<td> " +Convert.ToDateTime(dr["To_Date"]).ToString("dd-MM-yyyy")+ " </td>" +
                        "<td> " + NoofSales + " </td>" +
                        "<td> " + dr["Invoice_Amount"] + " </td>";


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
    void Save_Invoice(string MainArray,string TableData)
    {
        int Ret=-9;

        string[] MainData = MainArray.Split('|');
        string[] Sales_Ids=TableData.Split('|');
        string Invoice_No = GetInvoiceNumber(MainData[0]);
        string  sql = "insert into Tbl_Invoice values " +
          "('" + Invoice_No + "','"+DateTime.Now.ToString("yyyy-MM-dd")+"','" + MainData[0] + "','" + MainData[3] + "','" + MainData[1] + "','" + MainData[2] + "',0);select @@IDENTITY;";

        Ret = DB.Get_ScalerInt(sql);
        if(Ret>-1)
        {  sql="";
            for (int i = 0; i < Sales_Ids.Length; i++)
            {   if (Sales_Ids[i].Trim() != "0")
                {
                    sql += "Insert into Tbl_Invoice_Items values (" + Ret + "," + Sales_Ids[i] + ");";
                }
            }
            Ret = DB.Get_ScalerInt(sql);
            Context.Response.Write("Success");
        }
        else
        {
            Context.Response.Write("Something Went Wrong");
        }

    }


    void Update_Invoice(string InsertArray,string Invoice_Id)
    {
        int Ret=-9;
        decimal OldTotalcost = decimal.Parse(DB.Get_Scaler("Select Total_Cost from tbl_Invoice where Id=" + Invoice_Id));
        string[] Data = InsertArray.Split('|');
        decimal NewTotalCost = decimal.Parse(Data[9]);
        decimal Difrence =NewTotalCost- OldTotalcost  ;
        string sql = "Update  tbl_Invoice Set Quantity='" + Data[2] + "',Rate='" + Data[3] + "',Trips='" + Data[4] + "',Site='" + Data[5] + "',Invoice_Price='"+Data[6]+"',Fuel_Price='" + Data[7] + "',Discount_Amount='" + Data[8] + "',Total_Cost='"+Data[9]+"',Vehicle_No='" + Data[10] + "',Remarks='" + Data[11] +"' where Id="+Invoice_Id;
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
    string GetInvoiceNumber(string customer_id)
    {   string Max_Num =DB.Get_Scaler("if exists (select id from tbl_Invoice) select Max(Id)+1 from tbl_Invoice else select 1");
        string InvoiceNUM = "";
        string CustomerBusName = DB.Get_Scaler("select Business_Id from tbl_Customer_Supplier where Id=" + customer_id);
        InvoiceNUM = "Inv-"+CustomerBusName + "-" + DateTime.Now.Year.ToString() + "-" + Max_Num;
        return InvoiceNUM;
    }

    public bool IsReusable { get { return false; } }
}
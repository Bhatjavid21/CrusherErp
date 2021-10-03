<%@ WebHandler Language="C#" Class="H_tbl_Supplier" %>
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

public class H_tbl_Supplier : IHttpHandler, IRequiresSessionState
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

                    case "Save_Supplier":
                        Save_Supplier(context.Request.Form["InsertArray"]);
                        break;
                    case "ListAllSupplier":
                        ListAllSupplier(context.Request.Form["SearchString"], Convert.ToInt32(context.Request.Form["Page_No"]));
                        break;
                    case "Edit":
                        Edit(context.Request.Form["CustomerId"]);
                        break;
                    case "Update_Supplier":
                        Update_Supplier(context.Request.Form["InsertArray"], context.Request.Form["CustomerId"]);
                        break;
                }
                //  }
                //  else { Context.Response.Write("SessionIsDead"); }
            }
            catch (Exception x) { Context.Response.Write("!error!" + x.Message); }
        }
        Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    //*********************************View*********************************View******************************************View***********************************************************
    void ListAllSupplier(string SearchString, int Page_No)
    {
        string EditAccess = "True";
        string ApproveAccess = "True";
        string output = "";
        int TotalRecords = 0, from = 1, to = 20; if (Page_No == 0) { Page_No = 1; };
        // StringBuilder output = new StringBuilder();
        from = (((Page_No * 20) - 20) + 1); to = Page_No * 20;
        string SourceTypeFilter = "";
        //if(!SourceType.Equals("Select"))
        //{
        //    SourceTypeFilter=" and a.Source_Type='"+SourceType+"' ";
        //}

        //string StatusFilter="";
        //if(!status.Equals(""))
        //{
        //    StatusFilter=" and a.Approval_Status="+status;
        //}
        string SearchFilter = "";
        if (!SearchString.Equals(""))
        {
            SearchFilter = "and  ( a.Name like '%" + SearchString + "%' or  a.Business_Id like '%" + SearchString + "%' )";
        }

        string sql = "with NewTable as (select a.*,ROW_NUMBER() over (order by Id desc) as RowNum from tbl_Customer_Supplier a " +
               "  where IsSupplier=1 " + SearchFilter + ") select * from NewTable where RowNum between " + from + " And " + to;

        DataTable dt = DB.GetDataTable(sql);
        TotalRecords = DB.Get_ScalerInt("select count(a.Id) from tbl_Customer_Supplier a where IsSupplier=1  " + SearchFilter);

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {

                output += "<tr>" +
                       "<td>" + dr["Name"] + "</td>" +
                       "<td>" + dr["Business_Id"] + "</td>" +
                       "<td>" + dr["Address"] + "</td>" +
                        "<td> " + dr["Phone_no"] + " </td>" +
                       "<td>" + dr["Balance"] + "</td>";


                if (dr["IsActive"].ToString().Equals("True"))
                {
                    output += "<td><span class='badge badge-success1'>Active</span></td>";
                }
                else
                {
                    output += "<td><span class='badge badge-danger'>Inactive</span></td>";
                }
                output += "<td> " +
                  "<div class='btn-group'>" +
                                            "<button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>" +
                                                "<span><i class='ti-settings'></i></span>" +
                                            "</button>" +
                                            "<ul class='dropdown-menu dropdown-menu-right'>";
                output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#Popup' onclick='View(this.id)'><i class='fa fa-edit'></i>View</a></li>" +
                   "<li class='dropdown-divider'></li>";


                if (EditAccess.Equals("True"))
                {
                    output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#Popup' onclick='Edit(this.id)'><i class='fa fa-edit'></i>Edit</a></li>" +
                "<li class='dropdown-divider'></li>";
                }
                if (ApproveAccess.Equals("True"))
                {
                    output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#AprovePopup' onclick='GetEstimatedAmnt(this.id)'><i class='fa fa-edit'></i>Approve</a></li>" +
                      "<li class='dropdown-divider'></li>";
                }


                output += "</div> </td></tr>";
            }
        }
        else
        {
            output += "<tr><td colspan='8'> No Records Found  </td></tr>";
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
        Context.Response.Write(output + "|" + str_Pagging);
    }
    void Save_Supplier(string InsertArray)
    {
        int Ret = -9;
        string[] Data = InsertArray.Split('|');
        decimal openingBal = Convert.ToDecimal(Data[6]);
        decimal totalBal = openingBal + 0;
        //string sql = "Insert into tbl_Customer_Supplier values('" + Data[1] + "','" + Data[0] + "','" + Data[3] + "',0.00,'" + Data[4] + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "',null,1,1,'" + Data[2] + "','" + Data[5] + "')";
        string sql = "Insert into tbl_Customer_Supplier (Name,Business_Id,Phone_No,Address,Remarks,TripRate,OpeningBalance,Balance,IsActive,IsSupplier,Created_Date) values('" + Data[0] + "','" + Data[1] + "','" + Data[2] + "','" + Data[3] + "','" + Data[4] + "','" + Data[5] + "','" + openingBal + "','" + totalBal + "',1,1,'" + DateTime.Now.ToString("yyyy-MM-dd") + "')";
        Ret = DB.Get_ScalerInt(sql);
        if (Ret > -1)
        {
            Context.Response.Write("Success");
        }
        else
        {
            Context.Response.Write("Something Went Wrong");
        }

    }
    void Edit(string CustomerId)
    {
        string jasonString1 = "";
        DataTable Dt = DB.GetDataTable("select * from tbl_Customer_Supplier where Id=" + CustomerId);
        if (Dt.Rows.Count > 0)
        {
            jasonString1 = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(jasonString1);
    }
    void Update_Supplier(string InsertArray, string CustomerId)
    {
        StringBuilder sql = new StringBuilder();
        int Ret = -9;
        string[] Data = InsertArray.Split('|');
        decimal openingBal = Convert.ToDecimal(Data[3]);

        sql.Append("update tbl_Customer_Supplier set Business_Id='" + Data[1] + "',Name='" + Data[0] + "',Address='" + Data[4] + "',OpeningBalance='" + openingBal + "',");
        if (openingBal < 1)
            sql.Append("Balance=Balance+" + openingBal + ",");
        sql.Append("Remarks = '" + Data[5] + "', Updated_Date = '" + DateTime.Now.ToString("yyyy-MM-dd") + "', IsActive = 1, IsSupplier = 1, Phone_No = '" + Data[2] + "' where id='" + CustomerId + "'");
        Ret = DB.Get_ScalerInt(sql + "");
        if (Ret > -1)
        {
            Context.Response.Write("Success");
        }
        else
        {
            Context.Response.Write("Something Went Wrong");
        }
    }
    public bool IsReusable { get { return false; } }
}
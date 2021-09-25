<%@ WebHandler Language="C#" Class="H_tbl_Customer" %>
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

public class H_tbl_Customer : IHttpHandler, IRequiresSessionState
{
    HttpContext Context; Int16 DF = 0;
    public void ProcessRequest(HttpContext context)
    {
        Context = context;
        if (!string.IsNullOrEmpty(Context.Request["fun"]))
        {
            try
            {
                /// if (G.HL() == true)
                // {
                // DF = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[3]);

                switch (Context.Request["fun"].ToString())
                {

                    case "Save_Customer":

                        Save_Customer(context.Request.Form["InsertArray"]);

                        break;
                    case "ListAllCustomer":

                        ListAllCustomer(context.Request.Form["SearchString"], Convert.ToInt32(context.Request.Form["Page_No"]));

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
    void ListAllCustomer(string SearchString, int Page_No)
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

        string sql = "with NewTable as (select a.*,ROW_NUMBER() over (order by Id desc) as RowNum from tbl_customer_supplier a " +
               "  where IsSupplier=0 " + SearchFilter + ") select * from NewTable where RowNum between " + from + " And " + to;

        DataTable dt = DB.GetDataTable(sql);
        TotalRecords = DB.Get_ScalerInt("select count(a.Id) from tbl_customer_supplier a  where IsSupplier=0  " + SearchFilter);

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
                output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#Popup' onclick='View(this.id)'><i class='fa fa-eye'></i>View</a></li>" +
                   "<li class='dropdown-divider'></li>";


                if (EditAccess.Equals("True"))
                {
                    output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#Popup' onclick='Getdata(this.id,0)'><i class='fa fa-edit'></i>Edit</a></li>" +
                "<li class='dropdown-divider'></li>";
                }
                if (ApproveAccess.Equals("True"))
                {
                    //output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#AprovePopup' onclick='GetEstimatedAmnt(this.id)'><i class='fa fa-approve'></i>Approve</a></li>" +
                    //  "<li class='dropdown-divider'></li>";
                }

                output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#AddSitePopup' onclick='AddSite(this.id)'><i class='fa fa-home'></i>Add Site</a></li>" +
                   "<li class='dropdown-divider'></li>";
                output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#AddPaymentPopup' onclick='AddPayment(this.id)'><i class='fa fa-money'></i>Add Payment</a></li>" +
               "<li class='dropdown-divider'></li>";
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
    void Save_Customer(string InsertArray)
    {
        int Ret = -9;
        string[] Data = InsertArray.Split('|');

        string sql = "Insert into tbl_Customer_Supplier values('" + Data[1] + "','" + Data[0] + "','" + Data[3] + "',0.00,'" + Data[4] + "','" + DateTime.Now.ToString("yyyy-MM-dd") + "',null,1,0,'" + Data[2] + "')";
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

    public bool IsReusable { get { return false; } }
}
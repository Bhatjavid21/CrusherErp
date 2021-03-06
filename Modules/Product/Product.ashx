<%@ WebHandler Language="C#" Class="H_tbl_Product" %>
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

public class H_tbl_Product : IHttpHandler, IRequiresSessionState
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

                    case "Save_Product":

                        Save_Product(context.Request.Form["InsertArray"]);

                        break;
                    case "ListAllProduct":

                        ListAllProduct(context.Request.Form["SearchString"],Convert.ToInt32(context.Request.Form["Page_No"]));

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
    void ListAllProduct(string SearchString,int Page_No)
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
            SearchFilter="and  ( a.Name like '%"+SearchString+"%' or  a.Business_Id like '%"+SearchString+"%' )";
        }

        string  sql = "with NewTable as (select a.*,ROW_NUMBER() over (order by Id desc) as RowNum from tbl_Product a " +
               "  where 1=1 "+SearchFilter+") select * from NewTable where RowNum between "+from+" And "+to;

        DataTable dt=DB.GetDataTable(sql);
        TotalRecords=DB.Get_ScalerInt("select count(a.Id) from tbl_Product a where 1=1  "+SearchFilter);

        if(dt.Rows.Count>0)
        {
            foreach(DataRow dr in dt.Rows)
            {

                output += "<tr>" +
                       "<td>" + dr["Product_Name"] + "</td>" +
                       "<td>" + dr["Quantity"] + " ft.</td>" +
                       "<td>" + dr["Rate"] + "</td>" +
                        "<td> " + Convert.ToDateTime(dr["Created_Date"]).ToString("dd-MM-yyyy") + " </td>" +
                       "<td>" + dr["Descreption"] + "</td>";



                output +=  "<td> "+
                  "<div class='btn-group'>" +
                                            "<button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>" +
                                                "<span><i class='ti-settings'></i></span>" +
                                            "</button>" +
                                            "<ul class='dropdown-menu dropdown-menu-right'>";
                output += "<li><a id='" + dr["Id"] + "' href='javascript:void(0);' class='dropdown-item' data-toggle='modal' data-target='#Popup' onclick='Edit(this.id)'><i class='fa fa-edit'></i>Edit</a></li>" +
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
    void Save_Product(string InsertArray)
    {
        int Ret=-9;
        string[] Data = InsertArray.Split('|');

        string sql = "Insert into tbl_Product values('" + Data[0] + "','" + Data[1] + "','" + Data[3] + "','" + DateTime.Now.ToString("yyyy-MM-dd")+ "','" + Data[2] + "',null)";
        Ret = DB.Get_ScalerInt(sql);
        if(Ret>-1)
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
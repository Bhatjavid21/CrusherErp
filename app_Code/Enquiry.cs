using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;


/// <summary>
/// Summary description for Enquiry
/// </summary>
public class Enquiry
{
    //public static string Bind_Enquiry_List(string search_Text, string Sort_By_Field, string filter, string branch_id, string division_id, int Page_No, string Qt_No)
    //{
    //    //================================================Access============================
    //    //int branch_id = Convert.ToInt16(HttpContext.Current.Session["session_ids"].ToString().Split(',')[1]); 
    //   // int DivisionId = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[2]);

    //    string Access_Level = G.Division_Access_Level_Ids("Sales", "Enquiry List", "View");
    //    Access_Level = Access_Regional(Access_Level, branch_id.ToString());

    //    string Access_Level_Edit = G.Division_Access_Level_Ids("Sales", "Enquiry List", "Edit");
    //    Access_Level_Edit = Access_Regional(Access_Level_Edit, branch_id.ToString());
    //    if (Access_Level_Edit != "Access is Restricted.") { Access_Level_Edit = "Access OK"; }

    //    //====================================================================================
    //    string sql_Search = "", chck_Enquiry_In_Estimation = "0", sql_Main = "", sql_Total_Records = "", sql_Data = "",
    //        condition = "", Quot_Ids="", LG="", LC="", Res="";
    //    int TotalRecords = 0, from = 1, to = 20; if (Page_No == 0) { Page_No = 1; };
    //     StringBuilder output = new StringBuilder();

    //    from = (((Page_No * 20)-20)+1); to = Page_No * 20;

    //    filter = filter.Trim().Replace("N,", "enq.[Enquiry_Status]='New' or ").Replace("E,", "enq.[Enquiry_Status]='Estimated' or ")
    //        .Replace("Q,", "enq.[Enquiry_Status]='Quoted' or ").Replace("R,", "enq.[Enquiry_Status]='Regretted' or ")
    //        .Replace("L,", "enq.[Enquiry_Status]='Lost' or ").Replace("C,", "enq.[Enquiry_Status]='Converted' or ")
    //        .Replace("P,", "enq.[Enquiry_Status]='Partially Converted' or "); 

    //    if (filter.Contains(" or ")) { filter = filter.Remove(filter.LastIndexOf(" or ")); }  if (filter.Contains(",")) { filter = ""; }
    //    if (division_id != "0" & division_id != "") { condition = " and enq.Division_Id = " + division_id + " "; }
        

    //    DataTable dt_Chck_In_Estimation = new DataTable();

    //    if (Access_Level != "Access is Restricted.")
    //    {
    //        if (!string.IsNullOrEmpty(filter)) { filter = " and (" + filter + ") "; } else { filter = ""; }
    //        if (Qt_No != "0" & Qt_No != "") { Quot_Ids = Quo(Qt_No); }

    //        if (!string.IsNullOrEmpty(search_Text))
    //        {
    //            sql_Search = " and (Enquiry_Number like '%'+'" + search_Text + "'+'%' or Division_Name like '%'+'" + search_Text + "'+'%' "
    //                +"or Cus_Company_Name like '%'+'" + search_Text + "'+'%' or Enquiry_Status like '%'+'" + search_Text + "'+'%')";
    //        }

    //            sql_Main = " WITH tbl_Whole AS(select ROW_NUMBER() OVER (" + Sort_By_Field.Replace("-",".") + ") AS 'RowNumber', "
    //                       +"enq.Enquiry_Id, enq.Company_Id,enq.Branch_Id,enq.Division_Id, enq.Enquiry_Number, div.Division_Name, "
    //                       +"cs.Cus_Company_Name,  enq.Enquiry_Date, enq.Bid_Closing_Date, enq.Lead_Generator,"
    //                       +"enq.Lead_Closer, enq.Enquiry_Status, enq.Enquiry_Stage from tbl_Enquiry as enq "
    //                       +"join tbl_Company_Division as div on div.Division_Id = enq.Division_Id "
    //                       +"inner join tbl_Customer cs on cs.Customer_Id = enq.Customer_Id " + Access_Level + " and cs.Status!=5 "
    //                       +"where enq.isdeleted = 'False' "
    //                       + Quot_Ids + condition + filter + sql_Search + ") ";

    //            sql_Data = "SELECT * FROM tbl_Whole WHERE RowNumber Between " + from + " AND " + to + " "; //+ Sort_By_Field +";";

    //        sql_Total_Records = " select count(enq.Enquiry_Id )as Total_Records from tbl_Enquiry as enq "
    //                       + "join tbl_Company_Division as div on div.Division_Id = enq.Division_Id "
    //                       + "inner join tbl_Customer cs on cs.Customer_Id = enq.Customer_Id " + Access_Level + " and "
    //                       + " cs.Status!=5 where enq.isdeleted = 'False' "
    //                       + Quot_Ids + condition + filter + sql_Search + "";


    //         string Sql_All = sql_Main + sql_Data + sql_Total_Records;

    //        DataSet DS = DB.GetDataSet(Sql_All);

    //        DataTable dt = DS.Tables[0];

    //        TotalRecords = Convert.ToInt32(DS.Tables[1].Rows[0]["Total_Records"]);

    //        if (dt.Rows.Count > 0)
    //        {
    //            for (int i = 0; i < dt.Rows.Count; i++)
    //            {
    //                //sql_Main = "select Estimation_Id from tbl_Estimation where Enquiry_Id='" + dt.Rows[i]["Enquiry_Id"] + "'";
    //                //dt_Chck_In_Estimation = DB.GetDataTable(sql_Main);

    //                //if (dt_Chck_In_Estimation.Rows.Count > 0)
    //                //{
    //                //    chck_Enquiry_In_Estimation = "1";
    //                //}
    //                string Branch_Id = dt.Rows[i]["Branch_Id"].ToString();
    //                string Division_Id = dt.Rows[i]["Division_Id"].ToString();
    //                string Enquiry_Id = dt.Rows[i]["Enquiry_Id"].ToString();
    //                string Enquiry_Number = dt.Rows[i]["Enquiry_Number"].ToString();
    //                string Enquiry_Status = dt.Rows[i]["Enquiry_Status"].ToString();
    //                string Enquiry_Stage = dt.Rows[i]["Enquiry_Stage"].ToString();
    //                DateTime Enquiry_Date = Convert.ToDateTime(dt.Rows[i]["Enquiry_Date"].ToString());
    //                DateTime Closing_Date = Convert.ToDateTime(dt.Rows[i]["Bid_Closing_Date"].ToString());

    //                output.Append("<tr role='row' class='odd'>");

    //                output.Append("<td>" + Enquiry_Number + "</td>");
    //                output.Append("<td>" + dt.Rows[i]["Division_Name"].ToString() + "</td>");
    //                output.Append("<td>" + dt.Rows[i]["Cus_Company_Name"].ToString() + "</td>");
    //                //output.Append("<td>" + dt.Rows[i]["Enquiry_Type"].ToString() + "</td>");
    //                output.Append("<td>" + Convert.ToDateTime(Enquiry_Date).ToString("dd-MM-yyyy") + "</td>");
    //                output.Append("<td>" + Convert.ToDateTime(Closing_Date).ToString("dd-MM-yyyy") + "</td>");

    //                //LG += dt.Rows[i]["Lead_Generator"].ToString()+",";
    //                //LC += dt.Rows[i]["Lead_Closer"].ToString()+",";

    //                output.Append("<td>" + dt.Rows[i]["Lead_Generator"].ToString() + "</td>");
    //                output.Append("<td>" + dt.Rows[i]["Lead_Closer"].ToString() + "</td>");

    //                //output.Append("<td>LG_" + dt.Rows[i]["Lead_Generator"].ToString() + "_</td>");
    //                //output.Append("<td>LC_" + dt.Rows[i]["Lead_Closer"].ToString() + "_</td>");

    //                //output.Append("<td>" + getEmployeeName(dt.Rows[i]["Lead_Generator"].ToString()) + "</td>");
    //                //output.Append("<td>" + getEmployeeName(dt.Rows[i]["Lead_Closer"].ToString()) + "</td>");

    //                //Create status tds 
    //                switch (Enquiry_Status)
    //                {
    //                    case "Estimated":
    //                        Enquiry_Status = "<span class='badge badge-success fnt11' style='background-color: orange;'>" + Enquiry_Status + "</span>";
    //                        break;
    //                    case "New":
    //                        Enquiry_Status = "<span class='badge badge-info fnt11'>" + Enquiry_Status + "</span>";
    //                        break;
    //                    case "Quoted":
    //                        Enquiry_Status = "<span class='badge badge-warning fnt11' style='background-color: green;'>" + Enquiry_Status + "</span>";
    //                        break;
    //                    case "Converted":
    //                        Enquiry_Status = "<span class='badge badge-default fnt11' style='background-color: green;'>" + Enquiry_Status + "</span>";
    //                        break;
    //                    case "Partially Converted":
    //                        Enquiry_Status = "<span class='badge badge-default fnt11' style='background-color: orange;'>" + Enquiry_Status + "</span>";
    //                        break;
    //                }
    //                output.Append("<td>" + Enquiry_Status + "</td>");

    //                //Create stage tds                    
    //                //switch (Enquiry_Stage)
    //                //{
    //                //    case "Estimated":
    //                //        Enquiry_Stage = "<span class='badge badge-success fnt11'>" + Enquiry_Stage + "</span>";
    //                //        break;
    //                //    case "New":
    //                //        Enquiry_Stage = "<span class='badge badge-info fnt11'>" + Enquiry_Stage + "</span>";
    //                //        break;
    //                //    case "Quoted":
    //                //        Enquiry_Stage = "<span class='badge badge-warning fnt11'>" + Enquiry_Stage + "</span>";
    //                //        break;
    //                //    case "Converted":
    //                //        Enquiry_Stage = "<span class='badge badge-default fnt11'>" + Enquiry_Stage + "</span>";
    //                //        break;
    //                //}
    //                //output.Append("<td>" + Enquiry_Stage + "</td>");

    //                //create action tds

    //                output.Append("<td>");
    //                //output.Append("<div class='btn-group'>");
    //                //output.Append("<button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>");

    //                output.Append("Q1Q_");


                   
    //                output.Append(Enquiry_Id + "Q2Q_" + Enquiry_Number + "Q3Q_");
                    
    //                output.Append(Enquiry_Id + "&branchid=" + Branch_Id + "&divisionid=" + Division_Id + "' Q4Q_" + Enquiry_Number + "Q5Q_");
                    


    //                output.Append("" + Enquiry_Id + "Q6Q_");

    //                if (Access_Level_Edit == "Access OK" & (Enquiry_Status == "New" || Enquiry_Status.Contains(">New<")))
    //                {
    //                    output.Append("Q7Q_");                  //for edit
    //                    output.Append(Enquiry_Id + "Q8Q_");     //for edit
    //                }
                    
    //                output.Append("Q9Q_");

    //                if (Enquiry_Status.Contains("Estimated")==false)
    //                {
    //                    output.Append("Q10Q_" + Enquiry_Id + "Q11Q_"); // for delete
    //                }
                    
    //                //if (chck_Enquiry_In_Estimation == "0")
    //                //{
    //                //    output.Append("Q10Q" + Enquiry_Id + "Q11Q");
    //                //}

    //                output.Append("Q12Q_");
    //            }

               

    //            string Access_Level_Add = G.Division_Access_Level_Ids("Sales", "Enquiry List", "Add");
    //            Access_Level_Add = Access_Regional(Access_Level_Add, branch_id.ToString());
    //            if (Access_Level_Add == "Access is Restricted.")
    //            {
    //                output .Append("Add_Access_Is_Restricted");
    //            }

    //            DS.Dispose();
    //            dt.Dispose();

                
    //        }
    //        else
    //        {
    //            output.Append("<tr><td colspan='12' class='text-center'>No record found</td></tr>");
    //        }
    //    }
    //    else
    //    {
    //        output.Append("<tr><td colspan='11' align='center'>Access is Restricted!</td></tr>");
    //    }

    //    //if (LG != "" & LC != "")
    //    //{
    //    //    Res = Get_LG_LC(LG, LC, Convert.ToString(output));
    //    //}

    //  string str_Pagging="", Paging_Strip =  Pagination.PG(TotalRecords, Page_No);

    //  if (TotalRecords > 1)
    //  {
    //      str_Pagging = "<div class='dataTables_info ' id='#' role='status' aria-live='polite'>Showing " + from + " to " +
    //          to + " of " + TotalRecords + " entries</div>"
    //            + "<div class='dataTables_paginate paging_simple_numbers right' id='#_paginate'>"
    //            + "<ul class='pagination'>"
    //            + Paging_Strip

    //            + "</ul></div></div>";
    //  }


    //  return output + "|" + str_Pagging;

    //}

    public static string getEmployeeName(string EmployeeID)
    {
        string empName = "";

        string sql = "select REPLACE(Employee_Name,',',' ')as Employee_Name from tbl_Employee where Employee_Id='" + EmployeeID + "'";
        empName = DB.Get_Scaler(sql);

        return empName;
    }

    public static DataSet getds_enquiryid(int enquiryid, string spname)
    {
        DataSet myDataSet = new DataSet();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            using (SqlCommand cmd = new SqlCommand(spname, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@enquiryid", enquiryid);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(myDataSet);
            }

            conn.Close();
        }
        return myDataSet;
    }

    public static string insert_followup(int enquiryid, string followupdate, string assignedto, string followupcomments)
    {
        string Latest_Follow_Up_Id = "";
        SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]);
        if (con.State == ConnectionState.Open) { con.Close(); } else { con.Open(); }
        string spname = "usp_Mudasir_addEnquiry_Followup";
        using (SqlCommand cmd = new SqlCommand(spname, con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@enquiryid", enquiryid);
            cmd.Parameters.AddWithValue("@followupdate", Convert.ToDateTime(followupdate).ToString("MM/dd/yyy"));
            cmd.Parameters.AddWithValue("@assignedto", assignedto);
            cmd.Parameters.AddWithValue("@followup_comments", followupcomments);
            Latest_Follow_Up_Id = cmd.ExecuteScalar().ToString();
        }
        return Latest_Follow_Up_Id;
    }

    public static string enquiry_analysis(int enquiryid, string inscope, string stockavailable, string comfeasible, string delfeasible, string estatus, string ecomments)
    {
        string latestIdentity = "";
        SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]);
        if (con.State == ConnectionState.Open) { con.Close(); } else { con.Open(); }
        string spname = "usp_Mudasir_addEnquiry_Analysis";
        using (SqlCommand cmd = new SqlCommand(spname, con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@enquiryid", enquiryid);
            cmd.Parameters.AddWithValue("@inscope", inscope);
            cmd.Parameters.AddWithValue("@stockavailable", stockavailable);
            cmd.Parameters.AddWithValue("@com_feasible", comfeasible);
            cmd.Parameters.AddWithValue("@del_feasible", delfeasible);
            cmd.Parameters.AddWithValue("@status", estatus);
            cmd.Parameters.AddWithValue("@comments", ecomments);
            latestIdentity = cmd.ExecuteScalar().ToString();
        }
        return latestIdentity;
    }

    


 
}
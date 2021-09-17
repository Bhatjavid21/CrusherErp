using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        G.L();
    }

    #region WebMethod Get_Assigned_To_Employees
    [System.Web.Services.WebMethod]
    public static string Get_Assigned_To_Employees(string SelectedEmployees)
    {
        string output = "", sql = "";
        int loopIndex = 0;

        try
        {
            if (G.HL() == true)
            {
                sql = "select Employee_Id, replace(Employee_Name,',',' ') as Employee_Name from tbl_Employee where Branch_Id='" + HttpContext.Current.Session["session_ids"].ToString().Split(',')[1] + "' and Status='1'";

                SqlDataReader dr = DB.Get_temp(sql);

                if (dr.HasRows)
                {
                    if (SelectedEmployees == "")
                    {
                        SelectedEmployees = HttpContext.Current.Session["session_ids"].ToString().Split(',')[0] + ",";
                    }

                    for (int i = 0; dr.Read(); i++)
                    {
                        if (dr["Employee_Id"].ToString() == SelectedEmployees.Split(',')[loopIndex])
                        {
                            output += "<option value='" + dr["Employee_Id"] + "' selected>" + dr["Employee_Name"] + "</option>";
                            loopIndex += 1;
                        }
                        else
                        {
                            output += "<option value='" + dr["Employee_Id"] + "'>" + dr["Employee_Name"] + "</option>";
                        }
                    }
                    dr.Dispose();
                    dr.Close();
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x) { output = "!error!" + x.Message + " ---- " + x.StackTrace + ""; }
        return output;
    }
    #endregion

    #region WebMethod Get_Tasks_And_Bind_To_List
    [System.Web.Services.WebMethod]
    public static string Get_Tasks_And_Bind_To_List(string Task_Type, string Priority, string Status)
    {
        string output = "", sql = "", postSql = "";

        try
        {
            if (G.HL() == true)
            {
                string sessionUserId = HttpContext.Current.Session["session_ids"].ToString().Split(',')[0];

                if (Task_Type == "self")
                {
                    #region Get_My_Tasks
                    if (Priority != "0")
                    {
                        postSql = " Priority='" + Priority + "' and ";
                    }
                    sql = "select tm.Task_Id, Task_Name, Task_Description, case when Priority='1' then 'Low' when Priority='2' then 'Medium' when Priority='3' then 'High' end as Priority, Task_Date, Task_Time, Created_By, Created_Date, case when Status='1' then 'Open' when Status='0' then 'Closed' end as Status from tbl_Task_Main tm inner join tbl_Task_Assignments ta on ta.Task_Id=tm.Task_Id and ta.Assigned_To='" + sessionUserId + "' where " + postSql + " Status='" + Status + "' order by Created_Date desc";

                    #endregion
                }
                else if (Task_Type == "other")
                {
                    #region Get_Other_Tasks
                    if (Priority != "0")
                    {
                        postSql = " Priority='" + Priority + "' and ";
                    }
                    sql = "select distinct(tm.Task_Id), Task_Name, Task_Description, case when Priority='1' then 'Low' when Priority='2' then 'Medium' when Priority='3' then 'High' end as Priority, Task_Date, Task_Time, Created_By, Created_Date, case when Status='1' then 'Open' when Status='0' then 'Closed' end as Status from tbl_Task_Main tm inner join tbl_Task_Assignments ta on ta.Task_Id=tm.Task_Id where " + postSql + " tm.Task_Id not in (select Task_Id from tbl_Task_Assignments where Assigned_To='" + sessionUserId + "') and Created_By='" + sessionUserId + "' and Status='" + Status + "' order by Created_Date desc";
                    #endregion
                }

                SqlDataReader dr = DB.Get_temp(sql);

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        output += dr["Task_Id"].ToString() + "|" + dr["Task_Name"].ToString() + "|" + dr["Task_Description"].ToString() + "|" + dr["Priority"].ToString() + "|" + Convert.ToDateTime(dr["Task_Date"]).ToString("dd-MM-yyyy") + "|" + Convert.ToDateTime(dr["Task_Time"].ToString()).ToString("HH:mm") + "|" + dr["Created_By"].ToString() + "|" + dr["Status"].ToString() + "^";
                    }
                    dr.Dispose();
                    dr.Close();
                }
                else
                {
                    output = "record";
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x) { output = "!error!" + x.Message + " ---- " + x.StackTrace + ""; }

        return output;
    }
    #endregion

    #region WebMethod Insert_Update_Tasks
    [System.Web.Services.WebMethod]
    public static string Insert_Update_Tasks(string Task_Main_Id, string Task_Name, string Task_Description, string Task_Priority, string Task_Date, string End_Date, string Task_Time, string End_Time, string Assigned_To)
    {
        string output = "", sql = "", comment = "";

        try
        {
            if (G.HL() == true)
            {
                string sessionUserId = HttpContext.Current.Session["session_ids"].ToString().Split(',')[0];

                if (Convert.ToDateTime(Task_Date) > Convert.ToDateTime(End_Date))
                {
                    output = "selectedDate";
                }
                else
                {
                    if ((Convert.ToDateTime(Task_Date).Date < DateTime.Now.Date) || (Convert.ToDateTime(End_Date).Date < DateTime.Now.Date))
                    {
                        output = "currentDate";
                    }
                    else
                    {
                        if (Convert.ToDateTime(Task_Time) > Convert.ToDateTime(End_Time))
                        {
                            output = "selectedTime";

                        }
                        else
                        {
                            if (Task_Main_Id == "0")
                            {
                                #region Insert_Task_Main
                                sql = "insert into tbl_Task_Main (Task_Name, Task_Description, Priority, Task_Date, End_Date, Task_Time, End_Time, Created_By, Created_Date, Status, Source_Type) values ('" + Task_Name + "','" + Task_Description + "','" + Task_Priority + "','" + Task_Date + "','" + End_Date + "','" + Task_Time + "','" + End_Time + "','" + sessionUserId + "','" + DateTime.Now + "','1','Dashboard'); select @@IDENTITY;";

                                Task_Main_Id = DB.Get_Scaler(sql);

                                #region Insert_Task_Assignments
                                sql = "";
                                for (int i = 0; i < Assigned_To.Split(',').Length; i++)
                                {
                                    sql += "insert into tbl_Task_Assignments (Task_Id, Assigned_To) values ('" + Task_Main_Id + "','" + Assigned_To.Split(',')[i] + "'); ";
                                }
                                DB.Set_temp(sql);
                                #endregion

                                #region Insert_Task_Comments
                                if (Task_Priority == "1")
                                {
                                    Task_Priority = "Low";
                                }
                                else if (Task_Priority == "2")
                                {
                                    Task_Priority = "Medium";
                                }
                                else if (Task_Priority == "3")
                                {
                                    Task_Priority = "High";
                                }
                                comment = "<b>TASK CREATED</b> <br/> <b>Task Name:</b> " + Task_Name + " <br/> <b>Task Description:</b> " + Task_Description + " <br/> <b>Priority:</b> " + Task_Priority + ", <b>Task Date:</b> " + Convert.ToDateTime(Task_Date).ToString("dd-MM-yyyy") + ", <b>End Date:</b> " + Convert.ToDateTime(End_Date).ToString("dd-MM-yyyy") + ", <b>Task Time:</b> " + Task_Time + ", <b>End Time:</b> " + End_Time + " <br/> <b>Assigned To:</b> " + Assigned_To + "";

                                sql = "insert into tbl_Task_Comments (Task_Id, Comment, Comment_By, Comment_Date) values ('" + Task_Main_Id + "','" + comment + "','" + sessionUserId + "','" + DateTime.Now + "');";
                                DB.Set_temp(sql);
                                #endregion

                                Log.Set_temp("tbl_Task_Main", Task_Main_Id, "Insert");

                                output = Task_Main_Id;
                                #endregion
                            }
                            else
                            {
                                #region Update_Task_Main
                                sql = "delete from tbl_Task_Assignments where Task_Id='" + Task_Main_Id + "'; "
                                    + "update tbl_Task_Main set Task_Name='" + Task_Name + "', Task_Description='" + Task_Description + "', Priority='" + Task_Priority + "', Task_Date='" + Task_Date + "', End_Date='" + End_Date + "', Task_Time='" + Task_Time + "', End_Time='" + End_Time + "', Created_Date='" + DateTime.Now + "' where Task_Id='" + Task_Main_Id + "'; ";

                                DB.Set_temp(sql);

                                #region Insert_Task_Assignments
                                sql = "";
                                for (int i = 0; i < Assigned_To.Split(',').Length; i++)
                                {
                                    sql += "insert into tbl_Task_Assignments (Task_Id, Assigned_To) values ('" + Task_Main_Id + "','" + Assigned_To.Split(',')[i] + "'); ";
                                }
                                DB.Set_temp(sql);
                                #endregion

                                #region Insert_Task_Comments
                                if (Task_Priority == "1")
                                {
                                    Task_Priority = "Low";
                                }
                                else if (Task_Priority == "2")
                                {
                                    Task_Priority = "Medium";
                                }
                                else if (Task_Priority == "3")
                                {
                                    Task_Priority = "High";
                                }
                                comment = "<b>TASK EDITED</b> <br/> <b>Task Name:</b> " + Task_Name + " <br/> <b>Task Description:</b> " + Task_Description + " <br/> <b>Priority:</b> " + Task_Priority + ", <b>Task Date:</b> " + Convert.ToDateTime(Task_Date).ToString("dd-MM-yyyy") + ", <b>End Date:</b> " + Convert.ToDateTime(End_Date).ToString("dd-MM-yyyy") + ", <b>Task Time:</b> " + Task_Time + ", <b>End Time:</b> " + End_Time + " <br/> <b>Assigned To:</b> " + Assigned_To + "";

                                sql = "insert into tbl_Task_Comments (Task_Id, Comment, Comment_By, Comment_Date) values ('" + Task_Main_Id + "','" + comment + "','" + sessionUserId + "','" + DateTime.Now + "');";
                                DB.Set_temp(sql);
                                #endregion

                                Log.Set_temp("tbl_Task_Main", Task_Main_Id, "Update");

                                output = "updated";
                                #endregion
                            }
                        }
                    }
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x) { output = "!error!" + x.Message + " ---- " + x.StackTrace + ""; }

        return output;
    }
    #endregion

    #region WebMethod Get_Task_Comments
    [System.Web.Services.WebMethod]
    public static string Get_Task_Comments(string Task_Id)
    {
        string output = "", sql = "";

        try
        {
            if (G.HL() == true)
            {
                //#region Get_Task_Main
                //sql = "select tm.Task_Name, tm.Task_Description, case when tm.Priority='1' then 'Low' when tm.Priority='2' then 'Medium' when tm.Priority='3' then 'High' end as Priority, tm.Task_Date, tm.Task_Time, REPLACE(em.Employee_Name,',',' ') as Created_By, tm.Created_Date, case when tm.Status='0' then 'Closed' when tm.Status='1' then 'Open' end as Status from tbl_Task_Main tm inner join tbl_Employee em on em.Employee_Id=tm.Created_By where tm.Task_Id='" + Task_Id + "'; ";
                //#endregion

                //#region Get_Task_Assigned
                //sql += "select REPLACE(em.Employee_Name,',',' ') as Assigned_To from tbl_Task_Assignments ta inner join tbl_Employee em on ta.Assigned_To in (em.Employee_Id) where ta.Task_Id='" + Task_Id + "'; ";
                //#endregion

                #region Get_Task_Commments
                sql = "select tc.Comment, REPLACE(em.Employee_Name,',',' ') as Comment_By, tc.Comment_Date from tbl_Task_Comments tc inner join tbl_Employee em on em.Employee_Id=tc.Comment_By where tc.Task_Id='" + Task_Id + "' order by Comment_Id desc; ";
                #endregion

                SqlDataReader dr = DB.Get_temp(sql);

                if (dr.HasRows)
                {
                    #region Task_Comments
                    string assignedToIds = "", assignedToNames = "", comment = "";
                    int subString_Index;

                    output = "<hr/><div class='row'>"
                           + "<div class='col-md-12'>"
                           + "<div class='scroll1'>";

                    while (dr.Read())
                    {
                        //check if task created or task edited exist in comment, if yes, then assigned to will be there
                        if ((dr["Comment"].ToString().IndexOf("TASK CREATED") > -1) || (dr["Comment"].ToString().IndexOf("TASK EDITED") > -1))
                        {
                            #region Get_Actual_Names_Of_Employees_Which_Are_Assigned_To_The_Task
                            if ((dr["Comment"].ToString().IndexOf("Assigned To:") > -1))
                            {
                                subString_Index = dr["Comment"].ToString().LastIndexOf("</b>") + 4;
                                assignedToIds = dr["Comment"].ToString().Substring(subString_Index).Trim();

                                assignedToNames = "";

                                for (int j = 0; j < assignedToIds.Split(',').Length; j++)
                                {
                                    sql = "select REPLACE(Employee_Name,',',' ') as Assigned_To from tbl_Employee where Employee_Id ='" + assignedToIds.Split(',')[j] + "'";
                                    if (j == assignedToIds.Split(',').Length - 1)
                                    {
                                        assignedToNames += DB.Get_Scaler(sql);
                                    }
                                    else
                                    {
                                        assignedToNames += DB.Get_Scaler(sql) + ",";
                                    }
                                }

                                comment = dr["Comment"].ToString().Remove(subString_Index) + " " + assignedToNames;
                            }
                            #endregion
                        }
                        else
                        {
                            comment = dr["Comment"].ToString();
                        }

                        output += "<div class='chat-body clearfix'>"
                               + "<div class='header1'>"
                               + "<i class='fa fa-user'></i> <strong class='primary-font'>" + dr["Comment_By"] + "</strong> <small class='pull-right text-muted'>"
                               + "<span class=''></span>" + dr["Comment_Date"] + "</small>"
                               + "</div>"
                               + "<p>" + comment + "</p>"
                               + "</div>";
                    }

                    dr.Dispose();
                    dr.Close();

                    output += "</div>"
                           + "</div>"
                           + "</div>"
                           + "<div class='row mt-10'>"
                           + "<div class='col-md-12'>"
                           + "<textarea class='form-control' rows='2' maxlength='500' id='txt_Task_Comment' onkeyup='inputDynamicHeight(this);'></textarea>"
                           + "</div>"
                           + "</div>";
                    #endregion
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x) { output = "!error!" + x.Message + " ---- " + x.StackTrace + ""; }

        return output;
    }
    #endregion

    #region WebMethod Save_Task_Comments
    [System.Web.Services.WebMethod]
    public static string Save_Task_Comments(string Task_Id, string Comment)
    {
        string output = "", sql = "";

        try
        {
            if (G.HL() == true)
            {
                string sessionUserId = HttpContext.Current.Session["session_ids"].ToString().Split(',')[0];

                sql = "insert into tbl_Task_Comments (Task_Id, Comment, Comment_By, Comment_Date) values ('" + Task_Id + "','" + Comment + "','" + sessionUserId + "','" + DateTime.Now + "'); select @@IDENTITY;";

                DB.Set_temp(sql);

                output = "saved";
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x) { output = "!error!" + x.Message + " ---- " + x.StackTrace + ""; }
        return output;
    }
    #endregion

    #region WebMethod Get_Task_Main_Details
    [System.Web.Services.WebMethod]
    public static string Get_Task_Main_Details(string Task_Id)
    {
        string output = "", sql = "";

        try
        {
            if (G.HL() == true)
            {
                sql = "select tm.Task_Id, tm.Task_Name, tm.Task_Description, tm.Priority, tm.Task_Date, tm.End_Date, tm.Task_Time, tm.End_Time, tm.Status, ta.Assigned_To from tbl_Task_Main tm inner join tbl_Task_Assignments ta on ta.Task_Id=tm.Task_Id where tm.Task_Id='" + Task_Id + "'";

                DataTable dt = DB.GetDataTable(sql);

                if (dt.Rows.Count > 0)
                {
                    output = dt.Rows[0]["Task_Name"].ToString() + "|" + dt.Rows[0]["Task_Description"].ToString() + "|" + dt.Rows[0]["Priority"].ToString() + "|" + Convert.ToDateTime(dt.Rows[0]["Task_Date"].ToString()).ToString("yyyy-MM-dd") + "|" + Convert.ToDateTime(dt.Rows[0]["End_Date"].ToString()).ToString("yyyy-MM-dd") + "|" + Convert.ToDateTime(dt.Rows[0]["Task_Time"].ToString()).ToString("HH:mm") + "|" + Convert.ToDateTime(dt.Rows[0]["End_Time"].ToString()).ToString("HH:mm") + "|" + dt.Rows[0]["Status"].ToString() + "|";

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        output += dt.Rows[i]["Assigned_To"] + ",";
                    }
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x) { output = "!error!" + x.Message + " ---- " + x.StackTrace + ""; }
        return output;
    }
    #endregion

    #region WebMethod Update_Task_Main_Status
    [System.Web.Services.WebMethod]
    public static string Update_Task_Main_Status(string Task_Id, string Status)
    {
        string output = "", comment = "";

        if (Status == "0")
        {
            comment = "TASK CLOSED";
        }
        else if (Status == "1")
        {
            comment = "TASK OPENED";
        }

        try
        {
            if (G.HL() == true)
            {
                string sessionUserId = HttpContext.Current.Session["session_ids"].ToString().Split(',')[0];

                string sql = "update tbl_Task_Main set status='" + Status + "' where Task_Id='" + Task_Id + "'; insert into tbl_Task_Comments (Task_Id, Comment, Comment_By, Comment_Date) values ('" + Task_Id + "','" + comment + "','" + sessionUserId + "','" + DateTime.Now + "');";

                DB.Set_temp(sql);

                output = "updated";
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x) { output = "!error!" + x.Message + " ---- " + x.StackTrace + ""; }
        return output;
    }
    #endregion

    #region WebMethod Get_Task_And_Bind_To_Calendar
    [System.Web.Services.WebMethod]
    public static string Get_Task_And_Bind_To_Calendar(string Task_Type, string Priority, string Status)
    {
        string output = "", sql = "", postSql = "";

        try
        {
            if (G.HL() == true)
            {
                string sessionUserId = HttpContext.Current.Session["session_ids"].ToString().Split(',')[0];

                #region Post_SQL_Query_Part
                if (Priority != "0")
                {
                    postSql = " where Priority='" + Priority + "' ";
                }

                if (Status != "all")
                {
                    if (!string.IsNullOrEmpty(postSql))
                    {
                        postSql += " and Status='" + Status + "' ";
                    }
                    else
                    {
                        postSql = " where Status='" + Status + "' ";
                    }
                }

                if (Task_Type == "other")
                {
                    postSql += " and tm.Task_Id not in (select Task_Id from tbl_Task_Assignments where Assigned_To='" + sessionUserId + "') and Created_By='" + sessionUserId + "' ";
                }

                #endregion

                #region Get_Data
                if (Task_Type == "all")
                {
                    sql = "select distinct(tm.Task_Id), Task_Name, Task_Description, case when Priority='1' then 'Low' when Priority='2' then 'Medium' when Priority='3' then 'High' end as Priority, Task_Date, End_Date, Task_Time, End_Time, Created_By, Created_Date, case when Status='1' then 'Open' when Status='0' then 'Closed' end as Status from tbl_Task_Main tm inner join tbl_Task_Assignments ta on ta.Task_Id=tm.Task_Id and Assigned_To='" + sessionUserId + "' " + postSql + "";

                    sql += " union ";

                    sql += "select distinct(tm.Task_Id), Task_Name, Task_Description, case when Priority='1' then 'Low' when Priority='2' then 'Medium' when Priority='3' then 'High' end as Priority, Task_Date, End_Date, Task_Time, End_Time, Created_By, Created_Date, case when Status='1' then 'Open' when Status='0' then 'Closed' end as Status from tbl_Task_Main tm inner join tbl_Task_Assignments ta on ta.Task_Id=tm.Task_Id and Created_By='41' and ta.Assigned_To!='" + sessionUserId + "' " + postSql + "";
                }
                else if (Task_Type == "self")
                {
                    sql = "select distinct(tm.Task_Id), Task_Name, Task_Description, case when Priority='1' then 'Low' when Priority='2' then 'Medium' when Priority='3' then 'High' end as Priority, Task_Date, End_Date, Task_Time, End_Time, Created_By, Created_Date, case when Status='1' then 'Open' when Status='0' then 'Closed' end as Status from tbl_Task_Main tm inner join tbl_Task_Assignments ta on ta.Task_Id=tm.Task_Id and ta.Assigned_To='" + sessionUserId + "' " + postSql + " order by Created_Date desc";
                }
                else if (Task_Type == "other")
                {
                    sql = "select distinct(tm.Task_Id), Task_Name, Task_Description, case when Priority='1' then 'Low' when Priority='2' then 'Medium' when Priority='3' then 'High' end as Priority, Task_Date, End_Date, Task_Time, End_Time, Created_By, Created_Date, case when Status='1' then 'Open' when Status='0' then 'Closed' end as Status from tbl_Task_Main tm inner join tbl_Task_Assignments ta on ta.Task_Id=tm.Task_Id " + postSql + " order by Created_Date desc";
                }
                #endregion

                SqlDataReader dr = DB.Get_temp(sql);

                List<object> myList = new List<object>();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        myList.Add(new Calendar_Tasks(dr["Task_Id"].ToString(), dr["Task_Name"].ToString(), dr["Priority"].ToString(), Convert.ToDateTime(dr["Task_Date"].ToString()).ToString("yyyy-MM-dd") + " " + Convert.ToDateTime(dr["Task_Time"].ToString()).ToString("HH:mm"), Convert.ToDateTime(dr["End_Date"].ToString()).ToString("yyyy-MM-dd") + " " + Convert.ToDateTime(dr["End_Time"].ToString()).ToString("HH:mm"), dr["Status"].ToString()));
                    }

                    output = (new JavaScriptSerializer()).Serialize(myList);

                    dr.Dispose();
                    dr.Close();
                }
            }
            else
            {
                output = "SessionIsDead";
            }
        }
        catch (Exception x) { output = "!error!" + x.Message + " ---- " + x.StackTrace + ""; }

        return output;
    }
    #endregion

    public class Calendar_Tasks
    {
        public String Task_Id { get; set; }
        public String Task_Name { get; set; }
        public String Priority { get; set; }
        public String Task_Date { get; set; }
        public String End_Date { get; set; }
        public String Assigned_To { get; set; }
        public String Status { get; set; }

        public Calendar_Tasks(String id, String name, String prty, string date, string endDate, string status)
        {
            this.Task_Id = id;
            this.Task_Name = name;
            this.Priority = prty;
            this.Task_Date = date;
            this.End_Date = endDate;
            this.Status = status;
        }
    }
}
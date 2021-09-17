<%@ WebHandler Language="C#" Class="H_tbl_Supplier" %>
//using Npgsql;
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

public class H_tbl_Supplier : IHttpHandler, IRequiresSessionState
{
    HttpContext Context; Int16 DF = 0;
    public void ProcessRequest(HttpContext context)
    {
        Context = context; if (!string.IsNullOrEmpty(Context.Request["fun"]))
        {
            try
            {
                if (G.HL() == true)
                {
                    DF = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[3]);

                    switch (Context.Request["fun"].ToString())
                    {
                        case "View":
                            View(Context.Request.QueryString["Status"], Context.Request.QueryString["branch_id"], Context.Request.QueryString["searchTerm"], Convert.ToInt32(Context.Request.QueryString["RO"]), Context.Request.QueryString["SortBy"], Context.Request.QueryString["Limit"], Convert.ToInt32(Context.Request.QueryString["Page_No"]));
                            break;
                        case "Insert_General":
                            Insert_General(Context.Request.QueryString["Branch_Id"], Context.Request.QueryString["txt_Supplier_Name"], Context.Request.QueryString["txt_Supplier_Short_Name"], Context.Request.QueryString["txt_sup_company_branch"], Context.Request.QueryString["txt_email"], HttpUtility.UrlEncode(Context.Request.QueryString["txt_phone_number"]), HttpUtility.UrlEncode(Context.Request.QueryString["txt_fax"]), Context.Request.QueryString["txt_website"], Convert.ToInt32(Context.Request.QueryString["ddl_approver_id"]), Context.Request.QueryString["supplier_Type"]);
                            break;
                        case "Update_General":
                            Update_General(Convert.ToInt32(Context.Request.QueryString["supplier_id"]), Context.Request.QueryString["txt_Supplier_Name"], Context.Request.QueryString["txt_Supplier_Short_Name"], Context.Request.QueryString["txt_sup_company_branch"], Context.Request.QueryString["txt_email"], HttpUtility.UrlEncode(Context.Request.QueryString["txt_phone_number"]), HttpUtility.UrlEncode(Context.Request.QueryString["txt_fax"]), Context.Request.QueryString["txt_website"], Convert.ToInt32(Context.Request.QueryString["ddl_approver_id"]), Context.Request.QueryString["supplier_Type"]);
                            break;
                        case "Edit_SupplierInfo":
                            Edit_SupplierInfo(Convert.ToInt32(Context.Request.QueryString["supplier_id"]));
                            break;
                        case "Update_Account_Info":
                            Update_Account_Info(Convert.ToInt32(Context.Request.QueryString["supplier_id"]), Context.Request.QueryString["txt_account_code"], Convert.ToInt32(Context.Request.QueryString["ddl_parent_account_id"]), Context.Request.QueryString["txt_cr_number"], Context.Request.QueryString["txt_vat_number"], Convert.ToInt32(Context.Request.QueryString["ddl_currency_id"]), Context.Request.QueryString["txt_bank_name"], Context.Request.QueryString["txt_bank_branch_name"], Context.Request.QueryString["txt_account_holder_name"], Context.Request.QueryString["txt_account_number"], Convert.ToBoolean(Context.Request.QueryString["chk_credit"]), Context.Request.QueryString["txt_credit_days"], Context.Request.QueryString["txt_credit_amount"], Context.Request.QueryString["txt_iban_number"], Context.Request.QueryString["txt_swift_code"], Convert.ToBoolean(Context.Request.QueryString["chk_blacklisted"]), Context.Request.QueryString["txt_blacklisted_reason"], Context.Request.QueryString["hid_Status"], Context.Request.QueryString["opening_Balance"], Context.Request.QueryString["opening_Balance_Type"], Context.Request.QueryString["supplierName"]);
                            break;

                        case "Bind_All_DDLs_For_Cust_General":
                            Bind_All_DDLs_For_Cust_General();
                            break;
                        case "DDL_Get_Parent_Account":
                            DDL_Get_Parent_Account(Convert.ToInt32(Context.Request.QueryString["supplier_id"]), true);
                            break;



                        case "View_Contact_Person":
                            View_Contact_Person(Convert.ToInt32(Context.Request.QueryString["supplier_id"]), Convert.ToInt32(Context.Request.QueryString["RO"]));
                            break;
                        case "Insert_Contact_Person":
                            Insert_Contact_Person(Convert.ToInt32(Context.Request.QueryString["ddl_entity_id"]), Context.Request.QueryString["txt_name"], Context.Request.QueryString["txt_department"], Context.Request.QueryString["txt_designation"], Context.Request.QueryString["txt_branch"], HttpUtility.UrlEncode(Context.Request.QueryString["txt_phone_number_CP"]), HttpUtility.UrlEncode(Context.Request.QueryString["txt_mobile"]), Context.Request.QueryString["txt_email_id"], HttpUtility.UrlEncode(Context.Request.QueryString["txt_fax_CP"]));
                            break;
                        case "Update_Contact_Person":
                            Update_Contact_Person(Convert.ToInt32(Context.Request.QueryString["person_id"]), Context.Request.QueryString["txt_name"], Context.Request.QueryString["txt_department"], Context.Request.QueryString["txt_designation"], Context.Request.QueryString["txt_branch"], HttpUtility.UrlEncode(Context.Request.QueryString["txt_phone_number_CP"]), HttpUtility.UrlEncode(Context.Request.QueryString["txt_mobile"]), Context.Request.QueryString["txt_email_id"], HttpUtility.UrlEncode(Context.Request.QueryString["txt_fax_CP"]));
                            break;
                        case "Edit_Contact_Person":
                            Edit_Contact_Person(Convert.ToInt32(Context.Request.QueryString["person_id"]));
                            break;
                        case "Delete_Contact_Person":
                            Delete_Contact_Person(Convert.ToInt32(Context.Request.QueryString["person_id"]));
                            break;


                        case "ddl_external_party_country":
                            Bind_ddl_external_party_country("0", false);
                            break;
                        case "ddl_external_party_state":
                            Bind_ddl_external_party_state("0", Context.Request.QueryString["country"].ToString(), false);
                            break;
                        case "ddl_external_party_city":
                            Bind_ddl_external_party_city("0", Context.Request.QueryString["state"], false);
                            break;


                        case "View_external_party":
                            View_External_Party_Address(Convert.ToInt32(Context.Request.QueryString["supplier_id"]), Convert.ToInt32(Context.Request.QueryString["RO"]));
                            break;
                        case "Insert_External_Party_Address":
                            Insert_External_Party_Address(Convert.ToInt32(Context.Request.QueryString["External_Party_Id"]), Context.Request.QueryString["txt_external_party_address"], Context.Request.QueryString["txt_external_party_post_office"], Context.Request.QueryString["ddl_external_party_country"], Context.Request.QueryString["ddl_external_party_state"], Context.Request.QueryString["ddl_external_party_city"], Context.Request.QueryString["txt_external_party_zip"]);
                            break;
                        case "Update_External_Party_Address":
                            Update_External_Party_Address(Convert.ToInt32(Context.Request.QueryString["Address_Id"]), Context.Request.QueryString["txt_external_party_address"], Context.Request.QueryString["txt_external_party_post_office"], Context.Request.QueryString["ddl_external_party_country"], Context.Request.QueryString["ddl_external_party_state"], Context.Request.QueryString["ddl_external_party_city"], Context.Request.QueryString["txt_external_party_zip"]);
                            break;
                        case "Edit_External_Party_Address":
                            Edit_External_Party_Address(Convert.ToInt32(Context.Request.QueryString["Address_Id"]));
                            break;
                        case "Delete_External_Party_Address":
                            Delete_External_Party_Address(Convert.ToInt32(Context.Request.QueryString["Address_Id"]));
                            break;



                        case "Bind_All_DDLs_For_Document":
                            Bind_All_DDLs_For_Document();
                            break;


                        case "View_Doc":
                            View_Doc(Convert.ToInt32(Context.Request.QueryString["supplier_id"]), Convert.ToInt32(Context.Request.QueryString["RO"]));
                            break;
                        case "Insert_Doc":
                            Insert_Doc(Convert.ToInt32(Context.Request.QueryString["Document_Type_Id"]), Convert.ToInt32(Context.Request.QueryString["External_Party_Id"]), Context.Request.QueryString["Issuing_Athourity"], Context.Request.QueryString["Document_Number"], Context.Request.QueryString["File_Name"], Context.Request.QueryString["Expiry_Date"], Convert.ToInt32(Context.Request.QueryString["Assigned_To"]));
                            break;
                        case "Update_Doc":
                            Update_Doc(Convert.ToInt32(Context.Request.QueryString["Document_Id"]), Convert.ToInt32(Context.Request.QueryString["Document_Type_Id"]), Context.Request.QueryString["Issuing_Athourity"], Context.Request.QueryString["Document_Number"], Context.Request.QueryString["File_Name"], Context.Request.QueryString["Expiry_Date"], Convert.ToInt32(Context.Request.QueryString["Assigned_To"]));
                            break;
                        case "Edit_Doc":
                            Edit_Doc(Convert.ToInt32(Context.Request.QueryString["Document_Id"]));
                            break;
                        case "Delete_Doc":
                            Delete_Doc(Convert.ToInt32(Context.Request.QueryString["Document_Id"]));
                            break;
                        //
                        //case "searchauto":
                        //   searchauto(Context.Request.QueryString["txt"]);
                        //   break;

                        //
                        case "Send_for_Approval":
                            Send_for_Approval(Convert.ToInt32(Context.Request.QueryString["supplier_id"]));
                            break;

                        case "Click_To_Approve":
                            Click_To_Approve(Convert.ToInt32(Context.Request.QueryString["supplier_id"]));
                            break;

                        case "Suspen_Supplier":
                            Suspen_Supplier(Convert.ToInt32(Context.Request.QueryString["supplier_id"]));
                            break;
                        //
                        case "Make_Balcklist":
                            Make_Balcklist(Convert.ToInt32(Context.Request.QueryString["supplier_id"]), Context.Request.QueryString["reason"]);
                            break;

                        case "Make_Whitelist":
                            Make_Whitelist(Convert.ToInt32(Context.Request.QueryString["supplier_id"]));
                            break;

                        case "excel":
                            excel(Context.Request.QueryString["branch_id"]);
                            break;
                        //---Added Add Balances in Action... Related js funtions are below------//
                        //----------------Added by BhatJavi-------------------------------------//
                        case "Save_Balances":
                            Save_Balances(context.Request["InsertArray"].ToString());
                            break;
                        case "Update_Balance":
                            Update_Balance(context.Request["InsertArray"].ToString());
                            break;
                        case "fetchBalancesOpen":
                            fetchBalances(context.Request["Customer_id"].ToString());
                            break;
                         case "fetchBalancesClosed":
                            fetchBalancesClosed(context.Request["Customer_id"].ToString());
                            break;
                        case "GetBalDetails":
                            GetBalDetails(context.Request["Cust_Bal_Id"].ToString());
                            break;
                        case "MarkClosedBal":
                            MarkClosedBal(context.Request["Cust_Bal_Id"].ToString());
                            break;
                        case "GetMatadataforPdf":
                            GetMatadataforPdf(Convert.ToInt32(context.Request["SupplierId"].ToString()), Convert.ToInt32(context.Request["division_Id"].ToString()));
                            break;
                        case "GetAccountData":
                            GetAccountData(Convert.ToInt32(context.Request["SupplierId"].ToString()), context.Request.Form["date"]);
                            break;
                        case "GetAgingAnalysisData":
                            GetAgingAnalysisData(Convert.ToInt32(context.Request["SupplierId"].ToString()), context.Request.Form["date"]);
                            break;
                        case "Getddldiv":
                            Getddldiv();
                            break;
                        case "ExportExcelSOA":
                            ExportExcelSOA(Convert.ToInt32(context.Request["SupplierId"].ToString()), context.Request.Form["date"]);
                            break;
                        case "GetVat":
                            GetVat(context.Request["Customer_Id"].ToString());
                            break;
                         case "GetBudgetData":
                            GetBudgetData(context.Request["Supplier_id"].ToString());
                            break;
                        case "Save_Budget":
                            Save_Budget(context.Request["InsertArray"].ToString());
                            break;
                        case "Update_Budget":
                            Update_Budget(context.Request["InsertArray"].ToString(),context.Request["Budget_Id"].ToString());
                            break;
                            //---------------------------------------------------------------------------//
                    }
                }
                else { Context.Response.Write("SessionIsDead"); }
            }
            catch (Exception x) { Context.Response.Write("!error!" + x.Message); }
        }
        //Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }
    //*********************************View*********************************View******************************************View***********************************************************


    void View(string Status_Input, string DDL_Branch, string searchTerm, int IsReadOnly, string SortBy, string Limit, int Page_No)
    {
        string sql = "", output = "", Status = "New", Credit_Facility = "Credit", Account_Code = "", Supplier_Name = "", Phone_Number = "", Status_Condition = "", sql_Chck_Approver = "";
        DataTable dt_Approver = new DataTable(); bool IsFinanceCheck = false; int int_Finance = 0;

        string Access_Level = G.Division_Access_Level_Ids("Supplier", "Supplier List", "View"); Access_Level = Access_Regional(Access_Level, DDL_Branch);

        int number = 0; number = getNumber(Limit);
        int TotalRecords = 0, from = 1, to = 50;

        if (Page_No == 0)
        {
            Page_No = 1;
        }

        from = (((Page_No * 50) - 50) + 1);
        to = Page_No * 50;

        //if (DDL_Branch != "All Branches") { DDL_Branch = " a.branch_id=" + DDL_Branch + " and "; } else { DDL_Branch = ""; }
        if (Access_Level != "Access is Restricted.")
        {
            if (Status_Input == "1")
            {
                Status_Condition = "  (a.Status=1 or a.Status=3) and "; //"New & UnderProcess
            }
            else if (Status_Input != "" & Status_Input != "0") { Status_Condition = "  a.Status=" + Status_Input + " and "; } //else { customer_type = ""; }

            //if (searchTerm.Trim() != "")// By autoSuggest search
            //{

            //    sql = " select distinct top " + number + " a.supplier_id, a.Supplier_Name, la.Account_Code, a.Status, a.phone_number, "
            //        + " a.Credit_Facility  from tbl_Supplier a left join tbl_Ledger_Account la on la.Ledger_Account_Id=a.Account_Code where  " + Access_Level + " " + Status_Condition + " a.supplier_id in "
            //        + "("
            //        + " select distinct a.supplier_id from tbl_Supplier a where " + Access_Level + " " + Status_Condition + " (a.Supplier_Name like '" + searchTerm + "%' or a.Supplier_Name like '% " + searchTerm + "%' or la.Account_Code like '" + searchTerm + "%' or a.Supplier_Short_Name like '" + searchTerm + "%') "
            //        + " union "
            //        + " select distinct Entity_Id  from tbl_Contact_Person where  Entity_Type='supplier' and (Name like '" + searchTerm + "%' or Name like '% " + searchTerm + "%') "
            //        + " ) " + SortBy + "";
            //}
            //else
            //{
            //    sql = " select top " + number + " a.supplier_id, a.Supplier_Name, la.Account_Code, a.Status, a.phone_number, a.Credit_Facility from tbl_Supplier a left join tbl_Ledger_Account la on la.Ledger_Account_Id=a.Account_Code where " + Access_Level + Status_Condition + " 1=1 " + SortBy + "";
            //}

            if (number > 50)
            {
                if (Page_No == 1)
                {
                    to = from + number - 1;
                    from = to - number + 1;
                }
                else
                {
                    from = to + 1;
                    to = to + number;
                }
            }

            //GET TOTAL COUNT
            sql = "select count(*) from (select a.supplier_id from tbl_Supplier a inner join tbl_Ledger_Account la on la.Ledger_Account_Id=a.Account_Code where " + Access_Level + " " + Status_Condition + " (a.Supplier_Name like '" + searchTerm + "%' or a.Supplier_Name like '% " + searchTerm + "%' or la.Account_Code like '" + searchTerm + "%' or a.Supplier_Name like '%" + searchTerm + "%'))ss ";
            TotalRecords = DB.Get_ScalerInt(sql);

            sql = "with NewTable as (select a.supplier_id, ROW_NUMBER() OVER (" + SortBy + ") AS RowNumber, a.Supplier_Name, a.VAT_Number, la.Account_Code, a.Status, a.phone_number, a.Credit_Facility, Isnull(a.Budget_Id,0) as Budget_Id from tbl_Supplier a left join tbl_Ledger_Account la on la.Ledger_Account_Id=a.Account_Code where " + Access_Level + " " + Status_Condition + " (a.Supplier_Name like '" + searchTerm + "%' or a.Supplier_Name like '% " + searchTerm + "%' or a.VAT_Number like '" + searchTerm + "%' or a.VAT_Number like '%" + searchTerm + "%' or la.Account_Code like '" + searchTerm + "%' or a.Supplier_Short_Name like '%" + searchTerm + "%')) select top(" + number + ") * from NewTable where RowNumber between " + from + " and " + to;

            SqlDataReader DR = DB.Get_temp(sql);

            if (DR.HasRows)
            {
                for (int i = 0; DR.Read(); i++)
                {
                    if (!string.IsNullOrEmpty(DR["Status"].ToString()))//0 for all, 1 for "New, 2 for Approved, 3 for UnderProcess, 4 for Blacklisted, 5 for Suspended
                    {
                        if (Convert.ToInt16(DR["Status"]) == 1) { Status = "New"; }
                        else if (Convert.ToInt16(DR["Status"]) == 2) { Status = "Approved"; }
                        else if (Convert.ToInt16(DR["Status"]) == 3) { Status = "Pending"; }
                        else if (Convert.ToInt16(DR["Status"]) == 4) { Status = "Blacklisted"; }
                        else if (Convert.ToInt16(DR["Status"]) == 5) { Status = "Suspended"; }
                    }

                    if (!string.IsNullOrEmpty(DR["Credit_Facility"].ToString()))
                    {
                        if (Convert.ToBoolean(DR["Credit_Facility"]) == false) { Credit_Facility = "Cash"; } else { Credit_Facility = "Credit"; }
                    }

                    if (!string.IsNullOrEmpty(DR["Supplier_Name"].ToString()))
                    {
                        Supplier_Name = DR["Supplier_Name"].ToString();
                    }
                    else { Supplier_Name = ""; }
                    if (!string.IsNullOrEmpty(DR["Account_Code"].ToString()))
                    {
                        Account_Code = DR["Account_Code"].ToString();
                    }
                    else { Account_Code = ""; }
                    if (!string.IsNullOrEmpty(DR["Phone_Number"].ToString()))
                    {
                        Phone_Number = DR["Phone_Number"].ToString();
                    }
                    else { Phone_Number = ""; }

                    //if (!string.IsNullOrEmpty(DR["Employee_Name"].ToString()))
                    //{
                    //    Sales_Man = DR["Employee_Name"].ToString();
                    //}
                    //else
                    //{
                    //    Sales_Man = "";
                    //}

                    output += "<tr>"
                    + "<td>" + Account_Code + "</td>"
                    + "<td>" + Supplier_Name + "</td>"
                    + "<td>" + DR["VAT_Number"].ToString() + "</td>"
                    + "<td>" + Status + "</td>"
                    + "<td>" + Phone_Number + "</td>"
                    + "<td>" + Credit_Facility + "</td>"

        + "<td class=\"text-right\">"
          + "<div class=\"btn-group\">"
            + "  <button data-toggle=\"dropdown\" class=\"btn btn-outline btn-default dropdown-toggle\" aria-expanded=\"true\">"
              + "<span><i class=\"ti-settings\"></i></span></button>"
              + "<ul class=\"dropdown-menu dropdown-menu-right\">"
                + "<li onclick='GoForEdit(\"" + DR["Supplier_Id"] + ",details," + Status + "\")' data-toggle=\"modal\" data-target=\"#myModal\"><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-pencil\"></i> Details</a></li>"
                + "<li class=\"dropdown-divider\"></li>"
                + "<li onclick='GoForEdit(\"" + DR["Supplier_Id"] + "\")' data-toggle=\"modal\" data-target=\"#myModal\"><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-pencil\"></i> Edit</a></li>"
                + "<li class=\"dropdown-divider\"></li>";
                    if (DR["Budget_Id"].ToString() =="0")
                    {
                        output += "<li onclick=GetBudgetData(" + DR["supplier_id"] + ",0) data-toggle=\"modal\" data-target=\"#AddBudget\"><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-calculator\"></i>Forecaset / Budget</a></li>"
                          + "<li class=\"dropdown-divider\"></li>";
                    }
                    else
                    {
                        output += "<li onclick=GetBudgetData(" + DR["supplier_id"] + ",1)  data-toggle=\"modal\" data-target=\"#AddBudget\"><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-calculator\"></i> Edit Budget</a></li>"
                      + "<li class=\"dropdown-divider\"></li>";
                    }
                   output += "<li class=\"dropdown-divider\"></li>"
                    + "<li onclick='FetchBalances(\"" + DR["Supplier_Id"] + "\")' data-toggle=\"modal\" data-target=\"#AddBalances\"><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-plus-circle\"></i> Add Balances</a></li>"
                                + "<li class=\"dropdown-divider\"></li>"
                    + "<li onclick='SetSupplierId(\"" + DR["Supplier_Id"] + "\")' data-toggle=\"modal\" data-target=\"#SetDatesForSOA\"><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-plus-circle\"></i> SOA Report</a></li>"
                                + "<li class=\"dropdown-divider\"></li>";
                    if (Convert.ToInt16(DR["Status"]) == 1)//Send for Approval
                    {
                        output += "<li onclick=Send_for_Approval('" + DR["Supplier_Id"].ToString() + "')><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-exclamation-circle\"></i>Send for Approval</a></li>"
                        + "<li class=\"dropdown-divider\"></li>";
                    }

                    //check for approver by Umer
                    //sql_Chck_Approver = "select top(1)f.Employee_Id from tbl_Access_Modules a, tbl_Access_Screens b,tbl_Access_Operations c, tbl_Access_Levels d, tbl_Access_Privileges e inner join tbl_Employee_Division_Mapping f on e.Role_Id= f.role_id where a.Module_Name='Supplier' and B.Screen_Name='Supplier Details' and c.Operation_Name='Approve' and d.Access_Level_Name='Branch' and f.Employee_Id=" + HttpContext.Current.Session["session_ids"].ToString().Split(',')[0].ToString() + "";

                    //check for approver   Written By <<<By Zubair>>>
                    if (IsFinanceCheck == false)
                    {
                        sql_Chck_Approver = "select top(1)f.Employee_Id from tbl_Access_Modules a, tbl_Access_Screens b,tbl_Access_Operations c, tbl_Access_Levels d, tbl_Access_Privileges e inner join tbl_Employee_Division_Mapping f on e.Role_Id= f.role_id where a.Module_Name='Supplier' and B.Screen_Name='Supplier Details' and c.Operation_Name='Finance' and d.Access_Level_Name='Branch' and a.Module_Id=b.Module_Id and b.Screen_Id=c.Screen_Id and c.Operation_Id=d.Operation_Id and e.Access_Level_Id=d.Access_Level_Id and f.Employee_Id='" + HttpContext.Current.Session["session_ids"].ToString().Split(',')[0].ToString() + "'";
                        int_Finance = DB.Get_ScalerInt(sql_Chck_Approver);
                        IsFinanceCheck = true;
                    }

                    if (int_Finance > 0)
                    {

                        //if (dt_Approver.Rows.Count > 0)
                        //{
                        //    if (dt_Approver.Rows[0]["Employee_Id"].ToString() == HttpContext.Current.Session["session_ids"].ToString().Split(',')[0].ToString())
                        //    {
                        if (!string.IsNullOrEmpty(DR["Status"].ToString()))//1 for New, 2 for Supplier, 3 for UnderProcess, 4 for Blacklisted, 5 for suspend
                        {
                            if (Convert.ToInt16(DR["Status"]) == 2)// show Blacklist
                            {
                                output += "<li onclick=Display_Blacklist_Box('" + DR["Supplier_Id"].ToString() + "')><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-exclamation-circle\"></i> Blacklist</a></li>"
                                 + "<li class=\"dropdown-divider\"></li>";
                                //output += "<li id='li_textbox' style='display:none;'><textarea name=\"bkl-reason\" id=\"txt_blacklisted_reason\" onkeyup=\"Only_String(this);\" maxlength=\"300\" class=\"form-control\" required=\"\" placeholder=\"Blacklisted Reason\" style=\"border-color: rgb(210, 214, 222);\" aria-invalid=\"false\"></textarea></li>";
                            }

                            if (output.Contains("accounts_dept_has_accounts_info_tab_access_only") == false) { output += "accounts_dept_has_accounts_info_tab_access_only"; }

                            if (Convert.ToInt16(DR["Status"]) == 3)//Click To Approve
                            {
                                output += "<li onclick=Click_To_Approve('" + DR["Supplier_Id"].ToString() + "')><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-exclamation-circle\"></i>Approve</a></li>";
                            }
                            if (Convert.ToInt16(DR["Status"]) == 2)// Do Suspend
                            {
                                output += "<li onclick=Suspen_Supplier('" + DR["Supplier_Id"].ToString() + "')><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-exclamation-circle\"></i> Suspend</a></li>";
                            }
                            if (Convert.ToInt16(DR["Status"]) == 4)// Make Whitelist
                            {
                                output += "<li onclick=Make_Whitelist('" + DR["Supplier_Id"].ToString() + "')><a href=\"#\" class=\"dropdown-item\"><i class=\"fa fa-exclamation-circle\"></i> Whitelist</a></li>";
                            }

                            //    }
                        }
                    }

                    output += "</ul>";
                    output += "</div></td></tr>";

                }
                DR.Close(); DR.Dispose();
            }
            else
            {
                output += "<tr><td colspan='7' align='center'>No Record Found!</td></tr>";
            }
        }
        else
        {
            output += "<tr><td colspan='7' align='center'>Access is Restricted!</td></tr>";
        }

        output += "</table>";

        string str_Pagging = "", Paging_Strip = Pagination.PG(TotalRecords, Page_No, number);

        str_Pagging = "<div class='dataTables_info ' id='#' role='status' aria-live='polite'>Showing " + from + " to " +
            to + " of " + TotalRecords + " entries</div>"
              + "<div class='dataTables_paginate paging_simple_numbers right' id='#_paginate'>"
              + "<ul class='pagination'>"
              + Paging_Strip

              + "</ul></div></div>";

        Context.Response.Write(output + "~" + str_Pagging);
    }
    //*********************************Insert*********************************Insert******************************************Insert***********************************************************

    void Insert_General(string Branch_Id, string txt_Supplier_Name, string txt_Supplier_Short_Name, string txt_sup_company_branch, string txt_email, string txt_phone_number, string txt_fax, string txt_website, Int32 ddl_approver_id, string Supplier_Type)
    {
        string output = "", sql = "";
        int Supplier_Id = 0;

        //sql = "select top 1 supplier_id from tbl_Supplier where Supplier_Name='" + txt_Supplier_Name + "' and Phone_Number='" + txt_phone_number + "'";
        //sql = "select top 1 supplier_id from tbl_Supplier where Supplier_Name='" + txt_Supplier_Name.Trim() + "' and Branch_Id='" + Branch_Id + "'";
        //SqlDataReader dt = DB.Get_temp(sql);

        //while (dt.Read())
        //{
        //    Supplier_Id = Convert.ToInt32(dt["supplier_id"]);
        //}
        //dt.Dispose();
        //dt.Close();

        if (Supplier_Id == 0)
        {
            sql = "insert into tbl_Supplier (Branch_Id, Supplier_Name,Supplier_Short_Name, Status, sup_company_branch, email, phone_number, fax, website, approver_id,Supplier_Type) values (" + Branch_Id + ",'" + txt_Supplier_Name + "','" + txt_Supplier_Short_Name + "', '2', '" + txt_sup_company_branch + "', '" + txt_email + "', '" + txt_phone_number + "', '" + txt_fax + "', '" + txt_website + "',  '" + ddl_approver_id + "','" + Supplier_Type + "'); select @@IDENTITY;";
            Supplier_Id = Convert.ToInt32(DB.Get_Scaler(sql));

            output = Supplier_Id.ToString();

            //======================get recent Supplier_Id

            //dt = DB.Get_temp("select top 1 supplier_id from tbl_Supplier order by supplier_id desc");
            //while (dt.Read()) { Top_Supplier_Id = Convert.ToInt32(dt["supplier_id"]); output = Top_Supplier_Id.ToString(); }
            //dt.Close(); dt.Dispose();
            //=======================


            Log.Set_temp("tbl_Supplier", Supplier_Id.ToString(), "Insert");
        }
        //else
        //{
        //    output = "name";
        //}

        Context.Response.Write(output);
    }


    //*********************************Update*********************************Update******************************************Update***********************************************************

    void Update_General(Int32 supplier_id, string txt_Supplier_Name, string txt_Supplier_Short_Name, string txt_sup_company_branch, string txt_email, string txt_phone_number, string txt_fax, string txt_website, Int32 ddl_approver_id, string Supplier_Type)
    {
        string output = "", sql = "", Ledger_Account_Id = "0";
        int chk = 0;

        //sql = "select top 1 supplier_id from tbl_Supplier where Supplier_Name='" + txt_Supplier_Name + "' and Phone_Number='" + txt_phone_number + "' and supplier_id != " + supplier_id + "";
        //sql = "select top 1 supplier_id from tbl_Supplier where Supplier_Name='" + txt_Supplier_Name.Trim() + "' and supplier_id != " + supplier_id + "";
        //SqlDataReader dt = DB.Get_temp(sql);

        //while (dt.Read())
        //{
        //    chk = Convert.ToInt32(dt["supplier_id"]);
        //}

        if (chk == 0)
        {
            DB.Set_temp("update tbl_Supplier set Supplier_Name = '" + txt_Supplier_Name + "',Supplier_Short_Name = '" + txt_Supplier_Short_Name + "', sup_company_branch = '" + txt_sup_company_branch + "', email = '" + txt_email + "', phone_number = '" + txt_phone_number + "', fax = '" + txt_fax + "', website = '" + txt_website + "',  approver_id = '" + ddl_approver_id + "',Supplier_Type='" + Supplier_Type + "' where supplier_id = '" + supplier_id + "'");

            Log.Set_temp("tbl_Supplier", supplier_id.ToString(), "Update");

            //get ledger account id from tbl_supplier
            sql = "select ISNULL(Account_Code,0) as Account_Code from tbl_Supplier where Supplier_Id='" + supplier_id + "'";
            Ledger_Account_Id = DB.Get_Scaler(sql);

            //update ledger account name in ledger account when suplier name is changed
            if (Ledger_Account_Id != "0")
            {
                sql = "update tbl_Ledger_Account set Ledger_Account_Name='" + txt_Supplier_Name + "' where Ledger_Account_Id='" + Ledger_Account_Id + "'";
                DB.Set_temp(sql);
            }

            output = supplier_id.ToString();
        }
        //else
        //{
        //    output = "name";
        //}

        //dt.Close(); dt.Dispose();

        Context.Response.Write(output);
    }



    //Edit_SupplierInfo


    //*********************************Edit*********************************Edit******************************************Edit***********************************************************

    void Edit_SupplierInfo(Int32 supplier_id)
    {
        string output = "", sql = "select Supplier_Type, Supplier_Name, Supplier_Short_Name, sup_company_branch, email, phone_number, fax, website, approver_id, parent_account_id, cr_number,  vat_number, currency_id, bank_name, bank_branch_name, account_holder_name, account_number, credit_facility, credit_days, credit_amount, iban_number, swift_code, Status, blacklisted_reason, ISNULL(sup.account_code,0) as Ledger_Account_Id, la.Account_Code, ISNULL(la.Opening_Balance,'0.00') as Opening_Balance, ISNULL(la.Opening_Balance_Type,0) as Opening_Balance_Type from tbl_Supplier sup left join tbl_Ledger_Account la on la.Ledger_Account_Id=sup.Account_Code where sup.supplier_id = " + supplier_id;
        SqlDataReader DR = DB.Get_temp(sql);

        while (DR.Read())
        {
            output += DR["Supplier_Name"] + "|" + DR["Supplier_Short_Name"] + "|" + DR["sup_company_branch"] + "|" + DR["email"] + "|" + DR["phone_number"] + "|" + DR["fax"] + "|" + DR["website"] + "|" + DDL_Get_Approver(Convert.ToInt32(DR["approver_id"]), true) + "|" + DR["Ledger_Account_Id"] + "|" + DDL_Get_Parent_Account(Convert.ToInt32(DR["parent_account_id"]), true) + "|" + DR["cr_number"] + "|" + DR["vat_number"] + "|" + DDL_Get_Currency(Convert.ToInt32(DR["currency_id"]), true) + "|" + DR["bank_name"] + "|" + DR["bank_branch_name"] + "|" + DR["account_holder_name"] + "|" + DR["account_number"] + "|" + DR["credit_facility"] + "|" + DR["credit_days"] + "|" + DR["credit_amount"] + "|" + DR["iban_number"] + "|" + DR["swift_code"] + "|" + DR["Status"] + "|" + DR["blacklisted_reason"] + "|" + DR["Supplier_Type"] + "|" + DR["Account_Code"] + "|" + DR["Opening_Balance"] + "|" + DR["Opening_Balance_Type"];
            // // output += DDL1(Convert.ToInt32(DR["Branch_Id"]), true) + "|" + DDL2(Convert.ToInt32(DR["Branch_Id"]), true)

        }
        DR.Close(); DR.Dispose();

        Context.Response.Write(output);
    }


    //*********************************Update Account Info*********************************Update Account Info******************************************Insert***********************************************************
    //229
    void Update_Account_Info(Int32 supplier_id, string txt_account_code, Int32 ddl_parent_account_id, string txt_cr_number, string txt_vat_number, Int32 ddl_currency_id, string txt_bank_name, string txt_bank_branch_name, string txt_account_holder_name, string txt_account_number, bool chk_credit, string txt_credit_days, string txt_credit_amount, string txt_iban_number, string txt_swift_code, bool chk_blacklisted, string txt_blacklisted_reason, string hid_Status, string opening_Balance, string opening_Balance_Type, string supplierName)
    {
        string output = "", BlackListing = "", Ledger_Account_Id = "0", Account_Group_Id = "0", supBranch_Id = "0";

        if (chk_blacklisted == true)
        { BlackListing = ", Status = '4', blacklisted_reason = '" + txt_blacklisted_reason + "'"; }
        else if (chk_blacklisted == false & hid_Status == "4")
        { BlackListing = ", Status = '2', blacklisted_reason = ''"; }
        else
        { BlackListing = ", Status = '" + hid_Status + "', blacklisted_reason = ''"; }


        //get ledger account id of a customer
        string sql = "select ISNULL(Account_Code,0) as Account_Code from tbl_Supplier where Supplier_Id='" + supplier_id + "'";
        SqlDataReader dr = DB.Get_temp(sql);

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Ledger_Account_Id = dr["Account_Code"].ToString();
            }
        }

        //get account group id of receivable account group
        sql = "select Account_Group_Id from tbl_Account_Group where Account_Group_Name='Other Current Liabilities'";
        dr = DB.Get_temp(sql);

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                Account_Group_Id = dr["Account_Group_Id"].ToString();
            }
        }

        sql = "select Branch_Id from tbl_Supplier where Supplier_Id='" + supplier_id + "'";
        supBranch_Id = DB.Get_Scaler(sql);

        if (Account_Group_Id == "0")
        {
            output = "account";
        }
        else
        {
            //check if account code already exists in the receivable group
            sql = "select Ledger_Account_Id from tbl_Ledger_Account where Account_Code='" + txt_account_code + "' and Account_Group_Id='" + Account_Group_Id + "' and Ledger_Account_Id!='" + Ledger_Account_Id + "'";
            dr = DB.Get_temp(sql);

            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    output = "code";
                }
            }
            else
            {//check if account name already exists in the receivable group
                //sql = "select Ledger_Account_Id from tbl_Ledger_Account where Ledger_Account_Name='" + supplierName + "' and Account_Group_Id='" + Account_Group_Id + "' and Branch_Id='" + supBranch_Id + "' and Ledger_Account_Id!='" + Ledger_Account_Id + "'";
               // dr = DB.Get_temp(sql);

                //if (dr.HasRows)
                //{
                 //   while (dr.Read())
                 //   {
                       // output = "name";       //--- Skiped on the Request of Chandra Sir on 15-jul-2021 by Javid
                  //  }
               // }
               // else
               // {
                    //insert into ledger account
                    if (Ledger_Account_Id == "0")
                    {
                        sql = "insert into tbl_Ledger_Account (Account_Group_Id, Account_Code, Ledger_Account_Name, Opening_Balance, Opening_Balance_Type, Branch_Id) values('" + Account_Group_Id + "','" + txt_account_code + "','" + supplierName + "','" + opening_Balance + "','" + opening_Balance_Type + "','" + supBranch_Id + "'); select @@IDENTITY;";
                        Ledger_Account_Id = DB.Get_Scaler(sql);
                        Log.Set_temp("tbl_Ledger_Account", Ledger_Account_Id.ToString(), "Insert");
                    }
                    else
                    {
                        //update into ledger account
                        sql = "update tbl_Ledger_Account set Ledger_Account_Name='" + supplierName + "', Opening_Balance='" + opening_Balance + "', Opening_Balance_Type='" + opening_Balance_Type + "', Branch_Id='" + supBranch_Id + "' where Ledger_Account_Id='" + Ledger_Account_Id + "'";
                        DB.Set_temp(sql);
                        Log.Set_temp("tbl_Ledger_Account", Ledger_Account_Id.ToString(), "Update");
                    }

                    sql = "update tbl_Supplier set account_code = '" + Ledger_Account_Id + "', parent_account_id = " + ddl_parent_account_id + ", cr_number = '" + txt_cr_number + "', vat_number = '" + txt_vat_number + "', currency_id = " + ddl_currency_id + ", bank_name = '" + txt_bank_name + "', bank_branch_name = '" + txt_bank_branch_name + "', account_holder_name = '" + txt_account_holder_name + "', account_number = '" + txt_account_number + "', credit_facility = '" + chk_credit + "', credit_days = " + txt_credit_days + ", credit_amount = " + txt_credit_amount + ", iban_number = '" + txt_iban_number + "', swift_code = '" + txt_swift_code + "' " + BlackListing + " where supplier_id = '" + supplier_id + "'";

                    DB.Set_temp(sql);
                    sql = " update tbl_Customer set Parent_Account_id=" + supplier_id + "Where Customer_Id=" + ddl_parent_account_id;
                    DB.Set_temp(sql);
                    Log.Set_temp("tbl_Supplier", supplier_id.ToString(), "Update");

                    output = "updated";
               // }
            }
        }
        dr.Dispose();
        dr.Close();

        Context.Response.Write(output);
    }


    //***************************************Dropdown Lists================================================================================

    //==================================Bind_All_DDLs_For_General_Insert===================================Bind_All_DDLs_For_Cust_General=======================================Bind_All_DDLs_For_Cust_General======================
    //259
    void Bind_All_DDLs_For_Cust_General()
    {
        string output = DDL_Get_Approver(0, false);
        output += " | ";
        output += DDL_Get_Parent_Account(0, false);
        output += " | ";
        output += DDL_Get_Currency(0, false);

        Context.Response.Write(output);
    }



    //============================DDL_Get_Approver==============================DDL_Get_Approver==============================DDL_Get_Approver============================

    string DDL_Get_Approver(int Id, bool isEdit)
    {
        string output = "<select id='DDL_Get_Approver' onblur=\"return ValidateOne(this);\" onclick=\"return ValidateOne(this);\" onchange=\"Make_ReadWrite('btn_general_save'); return ValidateOne(this);\"  class=\"form-control fnt12 select2 h27\" name=\"approver\" aria-invalid=\"false\">"; string sql = "";

        sql = "Select Employee_Id, REPLACE(Employee_Name,',',' ')as Employee_Name from tbl_Employee";
        SqlDataReader DR = DB.Get_temp(sql);
        for (int i = 0; DR.Read(); i++)
        {
            output += "<option value=" + DR["Employee_Id"] + ">" + DR["Employee_Name"] + "</option>";
        }
        output += "</select>";
        DR.Close(); DR.Dispose();
        if (isEdit == true & Id != 0)
        {
            output = output.Replace(" value=" + Id + "", " value=" + Id + " selected='selected'");
            output = output.Replace(" selected='selected' value=0", " value='0'");
        }

        return output;
    }


    //============================DDL_Get_Parent_Account==============================DDL_Get_Parent_Account==============================DDL_Get_Parent_Account============================

    string DDL_Get_Parent_Account(int id, bool isEdit)
    {
        string output = "<select id='DDL_Get_Parent_Account' onchange='GetVat();'  class=\"form-control fnt12 select2 h27\" style='width: 100%;' name=\"parentaccount\" aria-invalid=\"false\"><option selected='selected' value='0'>Select Customer</option>"; string sql = "";

        // sql = "Select distinct customer_Id, Account_Code+'>'+Cus_Company_Name as Parent_Account from tbl_customer where Account_Code is not null and customer_type=2";
        sql="select b.Customer_Id, a.Account_Code+'-'+a.Ledger_Account_Name as Parent_Account from tbl_Ledger_Account a left outer join tbl_Customer b on a.Ledger_Account_Id=b.Account_Code where b.Customer_Type=2;";
        SqlDataReader DR = DB.Get_temp(sql);
        for (int i = 0; DR.Read(); i++)
        {
            output += "<option value='" + DR["customer_id"] + "'>" + DR["Parent_Account"] + "</option>";
        }
        output += "</select>";
        DR.Close(); DR.Dispose();

        if (isEdit == true & id != 0)
        {
            output = output.Replace(" value='" + id + "'", " value='" + id + "' selected='selected'");
            output = output.Replace(" selected='selected' value='0'", " value='0'");
            return output;
        }

        return output;
    }
    //============================DDL_Get_Currency==============================DDL_Get_Currency==============================DDL_Get_Currency============================

    string DDL_Get_Currency(int id, bool isEdit)
    {
        string output = "<select id='ddl_currency_id'  onblur=\"return ValidateOne(this);\"  onchange=\"Make_ReadWrite('btn_txtAccountInfo')\"  class=\"form-control fnt12 select2 h27\" name=\"currency\" aria-invalid=\"false\"><option selected='selected' value=0>Select Currency</option>", sql;

        sql = "Select Currency_Id, Currency_Name from tbl_Currency";// + Context.Session[""] + "";
        SqlDataReader DR = DB.Get_temp(sql);

        for (int i = 0; DR.Read(); i++)
        {
            output += "<option value=" + DR["Currency_Id"] + ">" + DR["Currency_Name"] + "</option>";
        }
        output += "</select>"; DR.Close(); DR.Dispose();

        if (isEdit == true & id != 0)
        {
            output = output.Replace(" value=" + id + "", " value=" + id + " selected='selected'");
            output = output.Replace(" selected='selected' value=0", " value=0");
        }

        return output;
    }


    //========================================================================================================================================================================

    //Contact Person From Here

    //========================================================================================================================================================================

    void View_Contact_Person(Int32 supplier_id, int IsReadOnly)
    {
        string sqlPart = "", output = "";

        // if (supplier_id.ToString().Length < 1) { supplier_id = 0; }

        sqlPart += " where entity_type='Supplier' and entity_id = " + supplier_id;
        string sql = "select person_id, entity_type, entity_id, name, department, designation, branch, phone_number, mobile, email_id, fax from tbl_Contact_Person " + sqlPart + "";
        SqlDataReader DR = DB.Get_temp(sql);
        if (DR.HasRows)
        {
            for (int i = 0; DR.Read(); i++)
            {
                output += "<tr>"
                + "<td>" + DR["name"] + "</td>"
               + "<td>" + DR["mobile"] + "</td>"
               + "<td>" + DR["email_id"] + "</td>"
               + "<td>" + DR["phone_number"] + "</td>"
                + "<td>" + DR["Department"] + "</td>"

                + "<td class='text-right'>"
                + "<div class='btn-group'>"
                + " <button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>"
                + "<span><i class='ti-settings'></i></span></button>"
                + "<ul class='dropdown-menu dropdown-menu-right'>";

                output += "<li onclick='GoForEdit_Contact_Person(\"" + DR["person_id"] + ",details\")'><a href='#' class='dropdown-item'><i class='fa fa-pencil'></i> Details</a></li>";


                if (IsReadOnly == 0)
                {
                    output += "<li class='dropdown-divider'></li>";
                    output += "<li onclick='GoForEdit_Contact_Person(\"" + DR["person_id"] + "\")' id='li_edit_cp_action'><a href='#' class='dropdown-item'><i class='fa fa-pencil'></i> Edit</a></li>";
                    output += "<li class='dropdown-divider'></li>";
                    output += "<li onclick='Delete_Contact_Person(\"" + DR["person_id"] + "\")' id='li_delete_cp_action'><a href='#' class='dropdown-item'><i class='fa fa-stop-circle'></i> Delete</a></li>";
                }

                output += "</ul></div></td></tr>";//
            }
        }
        else
        {
            output += "<tr><td colspan='6' align='center'>No Record Found!</td></tr>";
        }
        DR.Close(); DR.Dispose();
        output += "";
        //}

        Context.Response.Write(output);
    }

    //*********************************Insert*********************************Insert******************************************Insert***********************************************************

    //entity_id=supplier_id

    void Insert_Contact_Person(Int32 entity_id, string txt_name, string txt_department, string txt_designation, string txt_branch, string txt_phone_number_CP, string txt_mobile, string txt_email_id, string txt_fax_CP)
    {
        string output = "Done", sql_Insert = "";

        SqlDataReader dt = DB.Get_temp("select top 1 person_id from tbl_Contact_Person where entity_type='Supplier' and entity_id='" + entity_id + "' and phone_number='" + txt_phone_number_CP + "' and name='" + txt_name + "'");
        int Person_Id = 0;

        while (dt.Read()) { Person_Id = Convert.ToInt32(dt["person_id"]); dt.Close(); }

        if (Person_Id == 0)
        {
            sql_Insert = "insert into tbl_Contact_Person (entity_type, entity_id, name, department, designation, branch, phone_number, mobile, email_id, fax) values ('Supplier', '" + entity_id + "', '" + txt_name + "', '" + txt_department + "', '" + txt_designation + "', '" + txt_branch + "', '" + txt_phone_number_CP + "', '" + txt_mobile + "', '" + txt_email_id + "', '" + txt_fax_CP + "'); select @@IDENTITY";
            Person_Id = Convert.ToInt32(DB.Get_Scaler(sql_Insert));
            Log.Set_temp("tbl_Contact_Person", Person_Id.ToString(), "Insert");
        }
        else
        {
            output = "Error: This Supplier Already Exists";
        }

        dt.Close(); dt.Dispose();

        Context.Response.Write(output);
    }


    //*********************************Update*********************************Update******************************************Update***********************************************************

    void Update_Contact_Person(Int32 person_id, string txt_name, string txt_department, string txt_designation, string txt_branch, string txt_phone_number_CP, string txt_mobile, string txt_email_id, string txt_fax_CP)
    {
        string output = "done";

        DB.Set_temp("update tbl_Contact_Person set  name = '" + txt_name + "', department = '" + txt_department + "', designation = '" + txt_designation + "', branch = '" + txt_branch + "', phone_number = '" + txt_phone_number_CP + "', mobile = '" + txt_mobile + "', email_id = '" + txt_email_id + "', fax = '" + txt_fax_CP + "' where person_id = '" + person_id + "'");

        Log.Set_temp("tbl_Contact_Person", person_id.ToString(), "Update");

        Context.Response.Write(output);
    }



    //*********************************Edit*********************************Edit******************************************Edit***********************************************************

    void Edit_Contact_Person(Int32 person_id)
    {
        string output = "", sql = "select person_id, entity_type, entity_id, name, department, designation, branch, phone_number, mobile, email_id, fax from tbl_Contact_Person where person_id = " + person_id;

        SqlDataReader DR = DB.Get_temp(sql);
        while (DR.Read())
        {
            output += DR["name"] + "|" + DR["department"] + "|" + DR["designation"] + "|" + DR["branch"] + "|" + DR["phone_number"] + "|" + DR["mobile"] + "|" + DR["email_id"] + "|" + DR["fax"];
            // // output += DDL1(Convert.ToInt32(DR["Branch_Id"]), true) + "|" + DDL2(Convert.ToInt32(DR["Branch_Id"]), true)

        }
        DR.Close(); DR.Dispose();

        Context.Response.Write(output);
    }


    //*********************************Edit*********************************Edit******************************************Edit***********************************************************

    void Delete_Contact_Person(Int32 person_id)
    {
        string output = "Done";

        DB.Set_temp("delete from tbl_Contact_Person where person_id=" + person_id + "");
        Log.Set_temp("tbl_Contact_Person", person_id.ToString(), "Delete");

        Context.Response.Write(output);
    }

    //========================================================================================================================================================================

    //External_Party Docs From Here

    //========================================================================================================================================================================

    void View_External_Party_Address(Int32 supplier_id, int IsReadOnly)
    {
        string sqlPart = "", output = "<table cellspacing='5'>";

        if (supplier_id.ToString().Length < 1) { supplier_id = 0; }

        sqlPart += " where External_Party_Id=" + supplier_id + " and external_party_Type='Supplier'";
        string sql = "select Address_Id, Address, PO_Box_Number, City, State, Country, Zip from tbl_External_Party_Address " + sqlPart + "";
        SqlDataReader DR = DB.Get_temp(sql);
        if (DR.HasRows)
        {
            for (int i = 0; DR.Read(); i++)
            {
                output += "<tr>"
                + "<td>" + DR["Address"] + "</td>"
                + "<td>" + DR["Country"] + "</td>"
                + "<td>" + DR["State"] + "</td>"
                + "<td>" + DR["city"] + "</td>"
                + "<td>" + DR["Zip"] + "</td>"

                + "<td class='text-right'>"
                + "<div class='btn-group'>"
                + " <button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>"
                + "<span><i class='ti-settings'></i></span></button>"
                + "<ul class='dropdown-menu dropdown-menu-right'>"

                + "<li onclick='GoForEdit_External_Party_Address(\"" + DR["Address_Id"] + ",details\")'><a href='#' class='dropdown-item'><i class='fa fa-eye'></i> Details</a></li>";

                if (IsReadOnly == 0)
                {
                    output += "<li class='dropdown-divider'></li>";
                    output += "<li onclick='GoForEdit_External_Party_Address(\"" + DR["Address_Id"] + "\")' id='li_edit_address_action_" + i + "'><a href='#' class='dropdown-item'><i class='fa fa-pencil'></i> Edit</a></li>";

                    output += "<li class='dropdown-divider'></li>";
                    output += "<li onclick='Delete_External_Party_Address(\"" + DR["Address_Id"] + "\")'  id='li_delete_address_action_" + i + "'><a href='#' class='dropdown-item'><i class='fa fa-stop-circle'></i> Delete</a></li>";
                }
                output += "</ul></div></td></tr>";
            }
        }
        else
        {
            output += "<tr><td colspan='6' align='center'>No Record Found!</td></tr>";
        }
        DR.Close(); DR.Dispose();
        output += "</table>";

        Context.Response.Write(output);

    }

    //*********************************Insert*********************************Insert******************************************Insert***********************************************************

    //External_Party_Id=supplier_id

    void Insert_External_Party_Address(Int32 External_Party_Id, string txt_external_party_address, string txt_external_party_post_office, string ddl_external_party_country, string ddl_external_party_state, string ddl_external_party_city, string txt_external_party_zip)
    {
        string output = "Done", sql_Insert = "", Address_Id = "";

        SqlDataReader dt = DB.Get_temp("select top 1 Address_Id from tbl_External_Party_Address where External_Party_Type='Supplier' and External_Party_Id=" + External_Party_Id + " and Country='" + ddl_external_party_country + "' and State='" + ddl_external_party_state + "' and city='" + ddl_external_party_city + "' and Address='" + txt_external_party_address + "' and PO_Box_Number='" + txt_external_party_post_office + "'"); int chk = 0;

        while (dt.Read()) { chk = Convert.ToInt32(dt["Address_Id"]); dt.Close(); dt.Dispose(); }

        if (chk == 0)
        {
            sql_Insert = "insert into tbl_External_Party_Address (External_Party_Type, External_Party_Id, Address, PO_Box_Number, Country, State, City, Zip) values ('Supplier', '" + External_Party_Id + "', '" + txt_external_party_address + "', '" + txt_external_party_post_office + "', '" + ddl_external_party_country + "', '" + ddl_external_party_state + "', '" + ddl_external_party_city + "', '" + txt_external_party_zip + "'); select @@IDENTITY";
            Address_Id = DB.Get_Scaler(sql_Insert);
            Log.Set_temp("tbl_External_Party_Address", Address_Id, "Insert");
        }
        else
        {
            output = "Error: This Record Already Exists";
        }

        Context.Response.Write(output);
    }

    //*********************************Update*********************************Update******************************************Update***********************************************************

    void Update_External_Party_Address(Int32 Address_Id, string txt_external_party_address, string txt_external_party_post_office, string ddl_external_party_country, string ddl_external_party_state, string ddl_external_party_city, string txt_external_party_zip)
    {
        string output = "done";

        DB.Set_temp("update tbl_External_Party_Address set  Address = '" + txt_external_party_address + "', PO_Box_Number = '" + txt_external_party_post_office + "', country = '" + ddl_external_party_country + "', State = '" + ddl_external_party_state + "', city = '" + ddl_external_party_city + "', Zip = '" + txt_external_party_zip + "' where Address_Id = '" + Address_Id + "'");

        Log.Set_temp("tbl_External_Party_Address", Address_Id.ToString(), "Update");

        Context.Response.Write(output);
    }


    //*********************************Edit*********************************Edit******************************************Edit***********************************************************

    void Edit_External_Party_Address(Int32 Address_Id)
    {
        string output = "", sql = "select Address, PO_Box_Number, City, State, Country, Zip from tbl_External_Party_Address where Address_Id = " + Address_Id;

        SqlDataReader DR = DB.Get_temp(sql);
        while (DR.Read())
        {
            output += DR["Address"] + "|" + DR["PO_Box_Number"] + "|" + Bind_ddl_external_party_country(DR["Country"].ToString(), true) + "|" + Bind_ddl_external_party_state(DR["State"].ToString(), DR["Country"].ToString(), true) + "|" + Bind_ddl_external_party_city(DR["city"].ToString(), DR["State"].ToString(), true) + "|" + DR["Zip"];
            // // output += DDL1(Convert.ToInt32(DR["State_Id"]), true) + "|" + DDL2(Convert.ToInt32(DR["State_Id"]), true)

        }
        DR.Close(); DR.Dispose();

        Context.Response.Write(output);
    }


    //*********************************Country*********************************Country******************************************Contry***********************************************************
    string Bind_ddl_external_party_country(string country, bool isEdit)//the string entity can be string like country Address or state Address or country id or state id
    {
        string output = "<select id='ddl_external_party_country' onchange='Bind_ddl_external_party_state(0)' onblur=\"return ValidateOne(this);\"  class=\"form-control fnt12 select2 h27\" Address=\"currency\" aria-invalid=\"false\"><option  selected='selected' value=0>Select Country</option>", sql;

        sql = "Select country from tbl_Country";// + Context.Session[""] + "";
        SqlDataReader DR = DB.Get_temp(sql);

        for (int i = 0; DR.Read(); i++)
        {
            output += "<option onclick='ddl_external_party_state(0)' value='" + DR["country"] + "'>" + DR["country"] + "</option>";
        }
        output += "</select>"; DR.Close(); DR.Dispose();

        if (isEdit == true & country != "0")
        {
            output = output.Replace(" value='" + country + "'", " value='" + country + "' selected='selected'");
            output = output.Replace(" selected='selected' value=0", " value=0");
            return output;
        }
        else
        {
            Context.Response.Write(output); output = "";
        }

        return output;
    }


    //*********************************State*********************************State******************************************State***********************************************************
    string Bind_ddl_external_party_state(string State, string country, bool isEdit)//the string state can be string like country Address or state Address or country id or state id
    {
        string output = "<select id='ddl_external_party_state'  onblur=\"return ValidateOne(this);\" onchange=\"Make_ReadWrite('ddl_external_party_city')\"  class=\"form-control fnt12 select2 h27\" Address=\"currency\" aria-invalid=\"false\"><option onclick='ddl_external_party_city(0)' selected='selected' value=0>Select State</option>", sql;

        sql = "Select a.State from tbl_State a, tbl_country b where a.country_id=b.country_id and  b.country='" + country + "'"; ;
        SqlDataReader DR = DB.Get_temp(sql);

        for (int i = 0; DR.Read(); i++)
        {
            output += "<option onclick='ddl_external_party_city(0)' value=\'" + DR["state"] + "\'>" + DR["State"] + "</option>";
        }
        output += "</select>"; DR.Close(); DR.Dispose();

        if (isEdit == true & State != "0")
        {
            output = output.Replace(" value='" + State + "'", " value='" + State + "' selected='selected'");
            output = output.Replace(" selected='selected' value=0", " value=0");
            return output;
        }
        else
        {
            Context.Response.Write(output); output = "";
        }

        return output;
    }

    //*********************************city*********************************city******************************************city***********************************************************
    string Bind_ddl_external_party_city(string city, string state, bool isEdit)//the string entity can be string like country Address or state Address or country id or state id
    {
        string output = "<select id='ddl_external_party_city' onblur=\"return ValidateOne(this);\" onchange=\"Make_ReadWrite('btn_save_External_Party_Address')\"  class=\"form-control fnt12 select2 h27\" Address=\"currency\" aria-invalid=\"false\"><option selected='selected' value=0>Select City</option>", sql;

        sql = "select a.city from tbl_city a, tbl_state b where a.state_id=b.state_id and b.state='" + state + "'";
        SqlDataReader DR = DB.Get_temp(sql);

        for (int i = 0; DR.Read(); i++)
        {
            output += "<option value='" + DR["city"] + "'>" + DR["city"] + "</option>";
        }
        output += "</select>"; DR.Close(); DR.Dispose();

        if (isEdit == true & city != "0")
        {
            output = output.Replace(" value='" + city + "'", " value='" + city + "' selected='selected'");
            output = output.Replace(" selected='selected' value=0", " value=0");
            return output;
        }
        else
        {
            Context.Response.Write(output); output = "";
        }

        return output;
    }


    //*********************************Deactivate*********************************Deactivate******************************************Deactivate***********************************************************

    void Delete_External_Party_Address(int address_id)
    {
        string output = "Done";

        DB.Set_temp("delete from tbl_External_Party_Address where address_id=" + address_id + "");
        Log.Set_temp("tbl_External_Party_Address", address_id.ToString(), "Delete");

        Context.Response.Write(output);
    }


    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Document Code From Here <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<    



    void View_Doc(Int32 supplier_id, int IsReadOnly)
    {
        string output = "<table cellspacing='5'>", expiry_date = ""; if (supplier_id.ToString().Length < 1) { supplier_id = 0; }

        string sql = " select a.Document_Id,a.External_Party_Id, b.Document_Type_Name, a.Document_Number, a.[File_Name],convert(varchar, a.[Expiry_Date]," + DF + ")as Expiry_Date, case when c.Employee_Name IS null then 'Not Assigned Yet' else REPLACE(c.Employee_Name,',',' ') end as Employee_Name "
                    + " from tbl_External_Party_Document a inner join tbl_External_Party_Document_Type b on a.Document_Type_Id=b.Document_Type_Id "
                    + " and  a.External_Party_Id = " + supplier_id + " and a.External_Party_Type='Supplier' left outer join tbl_Employee c    on a.Assigned_To = c.Employee_Id; ";
        SqlDataReader DR = DB.Get_temp(sql);
        if (DR.HasRows)
        {
            for (int i = 0; DR.Read(); i++)
            {
                if (DR["Expiry_Date"].ToString() != "01/01/1900") { expiry_date = DR["Expiry_Date"].ToString(); } else { expiry_date = ""; }

                output += "<tr>"
                + "<td>" + DR["Document_Type_Name"] + "</td>"
                + "<td>" + DR["Document_Number"] + "</td>"
                + "<td>" + expiry_date + "</td>"
                + "<td>" + DR["Employee_Name"] + "</td>"
                + "<td><a style='color:blue;' href='Documents/" + DR["File_Name"] + "' target='_blank'>Download Document</a></td>"

                + "<td class='text-right'>"
                + "<div class='btn-group'>"
                + " <button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>"
                + "<span><i class='ti-settings'></i></span></button>"
                + "<ul class='dropdown-menu dropdown-menu-right'>";

                output += "<li onclick='GoForEdit_Doc(\"" + DR["Document_Id"] + ",details\")'><a href='#' class='dropdown-item'><i class='fa fa-eye'></i> Details</a></li>";

                if (IsReadOnly == 0)
                {
                    output += "<li class='dropdown-divider'></li>";
                    output += "<li onclick='GoForEdit_Doc(\"" + DR["Document_Id"] + "\")' id='li_edit_document_action'><a href='#' class='dropdown-item'><i class='fa fa-pencil'></i> Edit</a></li>";

                    output += "<li class='dropdown-divider'></li>";
                    output += "<li onclick='Delete_Doc(\"" + DR["Document_Id"] + "\")' id='li_delete_document_action'><a href='#' class='dropdown-item'><i class='fa fa-stop-circle'></i> Delete</a></li>";
                }
                output += "</ul></div></td></tr>";//
            }
        }
        else
        {
            output += "<tr><td colspan='7' align='center'>No Record Found!</td></tr>";
        }
        DR.Close(); DR.Dispose();
        output += "</table>";
        //}

        Context.Response.Write(output);
    }


    //*********************************Insert*********************************Insert******************************************Insert***********************************************************

    //External_Party_Id=supplier_id

    void Insert_Doc(Int32 Document_Type_Id, Int32 External_Party_Id, string Issuing_Athourity, string Document_Number, string File_Name, string Expiry_Date, Int32 Assigned_To)
    {
        string output = "Done", sql_Insert = "";

        if (Expiry_Date != "")
        {
            if (Convert.ToDateTime(Expiry_Date) <= DateTime.Now)
            {
                output = "lessdate";
            }
            else
            {
                output = "okdate";
            }

        }
        else { output = "nodate"; Expiry_Date = null; }

        if (output != "lessdate")
        {
            sql_Insert = "insert into tbl_External_Party_Document (Document_Type_Id, External_Party_Type, External_Party_Id, Issuing_Athourity, Document_Number, File_Name, Expiry_Date, Assigned_To) values ('" + Document_Type_Id + "', 'Supplier',  '" + External_Party_Id + "', '" + Issuing_Athourity + "', '" + Document_Number + "', '" + System.IO.Path.GetFileName(File_Name) + "', '" + Expiry_Date + "', '" + Assigned_To + "'); select @@IDENTITY";
            string Document_Id = DB.Get_Scaler(sql_Insert);
            Log.Set_temp("tbl_External_Party_Document", Document_Id, "Insert");
        }

        Context.Response.Write(output);
    }


    //*********************************Update*********************************Update******************************************Update***********************************************************

    void Update_Doc(Int32 Document_Id, Int32 Document_Type_Id, string Issuing_Athourity, string Document_Number, string File_Name, string Expiry_Date, Int32 Assigned_To)
    {
        string output = "done";

        if (Expiry_Date != "")
        {
            if (Convert.ToDateTime(Expiry_Date) <= DateTime.Now)
            {
                output = "lessdate";
            }
            else
            {
                output = "okdate";
            }

        }
        else { output = "nodate"; Expiry_Date = null; }

        if (output != "lessdate")
        {
            string doc = ""; if (File_Name != "") { doc = "File_Name = '" + File_Name + "',"; }

            DB.Set_temp("update tbl_External_Party_Document set  Document_Type_Id = '" + Document_Type_Id + "', Issuing_Athourity = '" + Issuing_Athourity + "', Document_Number = '" + Document_Number + "', " + doc + " Expiry_Date = '" + Expiry_Date + "', Assigned_To = '" + Assigned_To + "' where Document_Id = '" + Document_Id + "'");

            Log.Set_temp("tbl_External_Party_Document", Document_Id.ToString(), "Update");
        }

        Context.Response.Write(output);
    }


    //*********************************Edit*********************************Edit******************************************Edit***********************************************************

    void Edit_Doc(Int32 Document_Id)
    {
        string output = "", strDate = "", sql = "select Document_Type_Id, Document_Number, Issuing_Athourity, convert(varchar,Expiry_Date," + DF + ") as Expiry_Date, Assigned_To, File_Name from tbl_External_Party_Document where Document_Id = " + Document_Id;

        DateTime Expiry_Date;
        System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-GB");

        SqlDataReader DR = DB.Get_temp(sql);
        while (DR.Read())
        {
            Expiry_Date = DateTime.Parse(DR["Expiry_Date"].ToString()); //
            if (Expiry_Date.ToShortDateString().Contains("1900") == false) { strDate = Expiry_Date.ToString("yyyy-MM-dd"); } else { strDate = ""; }

            output += DDL_Document_Type(Convert.ToInt32(DR["Document_Type_Id"]), true) + "|" + DR["Document_Number"].ToString() + "|" + DR["Issuing_Athourity"].ToString() + "|" + strDate + "|" + DDL_Assign_To(Convert.ToInt32(DR["Assigned_To"]), true) + "|" + DR["File_Name"].ToString();
            // // output += DDL1(Convert.ToInt32(DR["State_Id"]), true) + "|" + DDL2(Convert.ToInt32(DR["State_Id"]), true)
            //Document_Type_Id, Document_Number, , Expiry_Date, Assigned_To
        }
        DR.Close(); DR.Dispose();

        Context.Response.Write(output);
    }

    //==================================Bind_All_DDLs_For_Doc===================================Bind_All_DDLs_For_Doc=======================================Bind_All_DDLs_For_Doc======================

    void Bind_All_DDLs_For_Document()
    {
        string output = DDL_Document_Type(0, false);
        output += " | ";
        output += DDL_Assign_To(0, false);

        Context.Response.Write(output);
    }



    //============================DDL_Document_Type==============================DDL_Document_Type==============================DDL_Document_Type============================

    string DDL_Document_Type(int Id, bool isEdit)
    {
        string output = "<select id='Document_Type_Id'  onblur=\"return ValidateOne(this);\" onchange=\"Make_ReadWrite('btn_save_doc')\" class=\"form-control fnt12 select2 h27\" name=\"division\" aria-invalid=\"false\"><option selected='selected' value=0>Select Document Name</option>"; string sql = "";

        sql = "Select Document_Type_Id, Document_Type_Name from tbl_External_Party_Document_Type where Supplier_Document='true'";
        SqlDataReader DR = DB.Get_temp(sql);
        for (int i = 0; DR.Read(); i++)
        {
            output += "<option value=" + DR["Document_Type_Id"] + ">" + DR["Document_Type_Name"] + "</option>";
        }
        output += "</select>";
        DR.Close(); DR.Dispose();
        if (isEdit == true & Id != 0)
        {
            output = output.Replace(" value=" + Id + "", " value=" + Id + " selected='selected'");
            output = output.Replace(" selected='selected' value=0", " value='0'");
        }

        return output;
    }


    //============================DDL_Assign_To==============================DDL_Assign_To==============================DDL_Assign_To============================

    string DDL_Assign_To(int Id, bool isEdit)
    {
        string output = "<select id='Assigned_To' onblur=\"return ValidateOne(this);\"  onchange=\"Make_ReadWrite('Assigned_To')\" class=\"form-control fnt12 select2 h27\" name=\"salesman\" aria-invalid=\"false\"><option selected='selected' value='0'>Select User</option>"; string sql = "";

        sql = "Select Employee_Id, replace(Employee_Name,',',' ')as Employee_Name from tbl_Employee";
        SqlDataReader DR = DB.Get_temp(sql);
        for (int i = 0; DR.Read(); i++)
        {
            output += "<option value=" + DR["Employee_Id"] + ">" + DR["Employee_Name"] + "</option>";
        }
        output += "</select>";
        DR.Close(); DR.Dispose();
        if (isEdit == true & Id != 0)
        {
            output = output.Replace(" value=" + Id + "", " value=" + Id + " selected='selected'");
            output = output.Replace(" selected='selected' value=0", " value='0'");
        }

        return output;
    }


    //*********************************Deactivate*********************************Deactivate******************************************Deactivate***********************************************************

    void Delete_Doc(int Document_Id)
    {
        string output = "Done";

        DB.Set_temp("delete from tbl_External_Party_Document where Document_Id=" + Document_Id + "");
        Log.Set_temp("tbl_External_Party_Document", Document_Id.ToString(), "Delete");

        Context.Response.Write(output);
    }
    //=================================================================END===========================================================



    //void searchauto(string txt)
    //{
    //    string sql = "select distinct Supplier_Name "
    //                + " from tbl_Supplier a where supplier_id in"
    //                + " ("
    //                + " select distinct supplier_id from tbl_Supplier where  Supplier_Name like '" + txt + "%' or Account_Code like '" + txt + "%' "
    //                + "  union"
    //                + " select distinct Entity_Id  from tbl_Contact_Person where  Entity_Type='supplier' and Name like '" + txt + "%'"
    //                + " )";

    //    SqlDataReader dr = DB.Get_temp(sql);


    //    string abc = "<table width='100%'>";
    //    int n=1;
    //    if (dr.HasRows)
    //    {
    //        while (dr.Read())
    //        {
    //            abc += "<tr><td id=\"tr" + n + "\" onmouseover=\"selset(this,1)\" onmouseout=\"selset(this,2)\" onClick=\"fillTxt(this,escape('" + dr["Supplier_Name"]+"'))\">" + dr["Supplier_Name"].ToString() + "</td></tr>";

    //            n +=1;
    //        }
    //    }
    //    //else
    //    //{
    //    //   abc="<span style='color:red'>No Result Found</span>";
    //    //}

    //    dr.Close();
    //    dr.Dispose();

    //    abc += "</table>";

    //    Context.Response.Write(abc);
    //}


    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Send_for_Approval <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    void Send_for_Approval(Int32 Supplier_Id)
    {
        string output = "Please Upload Following Mandatory Documents:", res = "", sql = "select distinct document_type_name from tbl_External_Party_Document_Type where Supplier_Mandatory=1 and document_type_id not in(select document_type_id from tbl_External_Party_Document where External_Party_Type='supplier' and External_Party_id='" + Supplier_Id + "')";

        SqlDataReader DR = DB.Get_temp(sql);
        if (DR.HasRows)
        {
            while (DR.Read())
            {
                res += "<br>" + DR["Document_Type_Name"].ToString() + "";
            }

            output += res;

        }
        else
        {
            output = "Supplier has been sent for Approval";

            sql = "update tbl_supplier set Status='3' where Supplier_Id='" + Supplier_Id + "'";
            DB.Set_temp(sql);

        }
        DR.Close(); DR.Dispose();

        Context.Response.Write(output);
    }


    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Click_To_Approve <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    void Click_To_Approve(Int32 Supplier_Id)
    {
        string output = "", res = "", sql = "SELECT Account_Code,CR_Number,VAT_Number,Currency_Id FROM tbl_Supplier where supplier_id='" + Supplier_Id + "'";

        SqlDataReader DR = DB.Get_temp(sql);
        if (DR.HasRows)
        {
            while (DR.Read())
            {
                if (string.IsNullOrEmpty(DR["Account_Code"].ToString().Trim()) || DR["Account_Code"].ToString() == "0")
                {
                    res += "<br>Account Code";
                }
                if (string.IsNullOrEmpty(DR["CR_Number"].ToString().Trim()) || DR["CR_Number"].ToString() == "0")
                {
                    res += "<br>CR Number";
                }
                if (string.IsNullOrEmpty(DR["VAT_Number"].ToString().Trim()) || DR["VAT_Number"].ToString() == "0")
                {
                    res += "<br>VAT Number";
                }
                if (string.IsNullOrEmpty(DR["Currency_Id"].ToString().Trim()) || DR["Currency_Id"].ToString() == "0")
                {
                    res += "<br>Currency";
                }
            }

            if (string.IsNullOrEmpty(res.Trim()) || res.Trim() == "0")// means supplier has all above table fields filledup already.
            {
                output = "Supplier has been Approved";

                sql = "update tbl_supplier set Status='2', Approved_Date='" + DateTime.Now.ToShortDateString() + "' where Supplier_Id='" + Supplier_Id + "'";
                DB.Set_temp(sql);
                Log.Set_temp("tbl_supplier", Supplier_Id.ToString(), "Approve");
            }
            else
            {
                output = "Following fields are mandatory before approval is done:" + res;
            }
        }
        else { output = "Supplier Not Known, There is Problem."; }
        DR.Close(); DR.Dispose();

        Context.Response.Write(output);
    }


    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Click_To_Approve <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    //5 for suspend, 1 for "New, 2 for Supplier, 3 for UnderProcess, 5 for approved

    void Suspen_Supplier(Int32 Supplier_Id)
    {
        string output = "Done", sql = "Update tbl_Supplier set [Status]=5 where supplier_id='" + Supplier_Id + "'";

        DB.Set_temp(sql);
        Log.Set_temp("tbl_supplier", Supplier_Id.ToString(), "Suspended");

        Context.Response.Write(output);
    }




    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Make_Balcklist <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    //5 for suspend, 1 for "New, 2 for Supplier, 3 for UnderProcess, 4 for Balcklist

    void Make_Balcklist(Int32 Supplier_Id, string reason)
    {
        string output = "Done", sql = "Update tbl_Supplier set [Status]=4, blacklisted_reason='" + reason + "' where supplier_id='" + Supplier_Id + "'";

        DB.Set_temp(sql);
        Log.Set_temp("tbl_supplier", Supplier_Id.ToString(), "Blacklisted");

        Context.Response.Write(output);
    }




    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Whitelist <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    //5 for suspend, 1 for "New, 2 for Supplier, 3 for UnderProcess, 4 for Balcklist

    void Make_Whitelist(Int32 Supplier_Id)
    {
        string output = "Done", sql = "Update tbl_Supplier set [Status]=2 where supplier_id='" + Supplier_Id + "'";

        DB.Set_temp(sql);
        Log.Set_temp("tbl_supplier", Supplier_Id.ToString(), "Whitelisted");

        Context.Response.Write(output);
    }


    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Get Dynamic  Top records <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    int getNumber(string limit)
    {
        int num = 50, DataCount;
        if (limit == "Default") { num = 50; }
        else if (limit == "100 Rows") { num = 100; }
        else if (limit == "1000 Rows") { num = 1000; }
        else
        {
            if (limit == "Half of All Data" || limit == "All Data")
            {
                DataCount = DB.Get_ScalerInt("select count(supplier_id) from tbl_Supplier");
                if (limit == "100 Rows") { num = 100; }


                if (limit == "Half of All Data")
                { num = (DataCount / 2); }
                else if (limit == "All Data") { num = DataCount; }
            }

        }

        return num;


    }






    void excel(string branch_id)
    {
        string sql_UserName = "", filename = "", temp = "", sql_supplier = "", sql_Contact_Person = "", sql_External_Address = "", SQL_Insert = "", Str_ContactPerson = "", Str_ExternaAddress = ""; //" select top "+number+" a.supplier_id, a.Cus_Company_Name, a.Account_Code, a.supplier_Type, a.phone_number,  a.Credit_Facility  from tbl_supplier a";
        sql_UserName = "select email from tbl_Employee where Employee_Id='" + HttpContext.Current.Session["session_ids"].ToString().Split(',')[0].ToString() + "'";
        sql_UserName = DB.Get_Scaler(sql_UserName);

        filename += sql_UserName + "-Supplier-" + (DateTime.Now.ToShortDateString().Replace("/", "-") + "-" + DateTime.Now.Hour + "-" + DateTime.Now.Minute + "-" + DateTime.Now.Second + "-" + DateTime.Now.Millisecond).ToString() + ".xlsx";

        string Access_Level = G.Division_Access_Level_Ids("Supplier", "Supplier List", "View"); Access_Level = Access_Regional(Access_Level, branch_id);

        if (Access_Level != "Access is Restricted.")
        {
            sql_supplier = "select C.Branch_Name, A.supplier_Id, A.Supplier_Name, A.Account_Code, A.Phone_Number,A.email as Email_Id, A.Fax, A.CR_Number, A.VAT_Number, A.Credit_Days, A.Credit_Amount, A.Bank_Name, A.Bank_Branch_Name, A.Account_Number, A.IBAN_Number, A.Swift_Code, replace(replace(B.Employee_Name,',',' '),',,',',') as Approved_By, Approved_Date, "
                         + " case when a.[Status]=1 then 'New' "
                         + " when a.[Status]=2 then 'Approved'"
                         + " when a.[Status]=3 then 'Under Process'"
                         + " when a.[Status]=4 then 'Blacklisted'"
                         + " when a.[Status]=5 then 'Suspended'"
                         + "  end as supplier_Type from tbl_supplier A left outer join tbl_Employee B on A.Approver_Id=B.Employee_Id left outer join tbl_Company_Branch C  on A.Branch_Id=C.Branch_Id where " + Access_Level + " 1=1 ";
            SqlDataReader DR = DB.Get_temp(sql_supplier);

            DataSet DS; DataTable DT_Contact_Person, DT_External_Address;
            if (DR.HasRows)
            {
                System.IO.File.Copy(Context.Server.MapPath("../../Template/Supplier/__Supplier_Data.xlsx"), Context.Server.MapPath("../../Template/Supplier/" + filename + ""), true);

                //for .xls
                // string connectionString = "Provider=Microsoft.Jet.OleDb.4.0; Data Source=" + Context.Server.MapPath("../../Template/" + filename + "") + "; Extended Properties=Excel 8.0;HDR=YES;IMEX=1;"; //HDR = YES;means are headers present there alerady

                //for  .xlsx           
                string connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Context.Server.MapPath("../../Template/Supplier/" + filename + "") + "; Extended Properties='Excel 12.0 Xml;HDR=YES;'";//IMEX=1; //HDR = YES;means are headers present there alerady



                using (System.Data.OleDb.OleDbConnection Connection = new System.Data.OleDb.OleDbConnection(connectionString))
                {
                    Connection.Open();

                    using (System.Data.OleDb.OleDbCommand command = new System.Data.OleDb.OleDbCommand())
                    {

                        command.Connection = Connection;

                        for (int i = 0; DR.Read(); i++)
                        {
                            //sql_Division = "Select distinct A.Division_Name from [tbl_Company_Division] A, tbl_supplier_Division_Mapping B, tbl_supplier C where A.Division_Id=B.Division_Id and B.supplier_Id=C.supplier_Id and C.supplier_Id='" + DR["supplier_Id"].ToString() + "'; ";

                            //sql_SalesMan = "Select distinct replace(replace(A.Employee_Name,',',' '),',,',',') as Sales_Man from tbl_Employee A, tbl_supplier_Salesman_Mapping B, tbl_supplier C where A.Employee_Id=B.Employee_Id and B.supplier_Id=C.supplier_Id and C.supplier_Id='" + DR["supplier_Id"].ToString() + "'; ";

                            sql_Contact_Person = "select  'Name: '+a.Name +'\n'+ 'Bnch: '+a.Branch +'\n'+ 'Phn: '+a.Phone_Number+'\n'+ 'Dept: '+a.Department+'\n'+ 'Desg: '+a.Designation+'\n'+ 'Mob: '+a.Mobile+'\n'+ 'Email: '+a.Email_Id as Contact_Person from tbl_Contact_Person A, tbl_supplier B where a.Entity_Id=b.supplier_Id and A.Entity_Id='" + DR["supplier_Id"].ToString() + "' and A.Entity_Type='supplier'; ";

                            sql_External_Address = "SELECT  'Addrs: '+a.[Address] +'\n'+ 'PO: '+a.[PO_Box_Number]+'\n'+ 'Cnty: '+a.[Country]+'\n'+ + 'State: '+a.[State] +'\n'+ 'City: '+a.City+'\n'+ 'Zip: '+a.Zip as Addresses from TBL_external_party_address A, tbl_supplier B where a.External_Party_Id=b.supplier_Id and External_Party_Id='" + DR["supplier_Id"].ToString() + "' and External_Party_Type='supplier'; ";

                            DS = DB.GetDataSet(sql_Contact_Person + sql_External_Address);//sql_Division + sql_SalesMan +

                            //DT_Division = DS.Tables[0]; DT_SalesMan = DS.Tables[1]; 

                            DT_Contact_Person = DS.Tables[0]; DT_External_Address = DS.Tables[1];

                            //for (int j = 0; j < DT_Division.Rows.Count; j++)
                            //{
                            //    Str_Division += DT_Division.Rows[j]["Division_Name"] +", ";
                            //}
                            //Str_Division = Str_Division.Remove(Str_Division.LastIndexOf(","));
                            //if (Str_Division.Length > 260) { Str_Division = Str_Division.Remove(260);}


                            //for (int j = 0; j < DT_SalesMan.Rows.Count; j++)
                            //{
                            //    Str_Salesman += DT_SalesMan.Rows[j]["Sales_Man"] + ", ";
                            //}
                            //Str_Salesman = Str_Salesman.Remove(Str_Salesman.LastIndexOf(","));
                            //if (Str_Salesman.Length > 260) { Str_Salesman = Str_Salesman.Remove(260); }

                            temp = ""; Str_ContactPerson = "";
                            for (int j = 0; j < DT_Contact_Person.Rows.Count; j++)
                            {
                                temp = DT_Contact_Person.Rows[j]["Contact_Person"].ToString().Trim().Replace("\n\n\n\n", "\n").Replace("\n\n\n", "\n").Replace("\n\n", "\n");
                                Str_ContactPerson += temp + "\n\n";
                            }
                            if (Str_ContactPerson.Length > 200) { Str_ContactPerson = Str_ContactPerson.Remove(199); }


                            temp = ""; Str_ExternaAddress = "";
                            for (int j = 0; j < DT_External_Address.Rows.Count; j++)
                            {
                                temp = DT_External_Address.Rows[j]["Addresses"].ToString().Trim().Replace("\n\n\n\n", "\n").Replace("\n\n\n", "\n").Replace("\n\n", "\n");
                                Str_ExternaAddress += temp + "\n\n";
                            }
                            if (Str_ExternaAddress.Length > 200) { Str_ExternaAddress = Str_ExternaAddress.Remove(199); }


                            SQL_Insert = "INSERT INTO [sheet2$](Branch_Name,Supplier_Name,Account_Code,Phone_Number,Email_Id, Fax, CR_Number, VAT_Number, Credit_Days, Credit_Amount, Bank_Name, Bank_Branch_Name, Account_Number, IBAN_Number, Swift_Code, Approved_By, Approved_Date,Supplier_Type, Contact_Person, Addresses) VALUES('" + DR["Branch_Name"].ToString() + "','" + DR["supplier_Name"].ToString() + "','" + DR["Account_Code"].ToString() + "','" + DR["Phone_Number"].ToString() + "','" + DR["Email_Id"].ToString() + "','" + DR["Fax"].ToString() + "','" + DR["CR_Number"].ToString() + "','" + DR["VAT_Number"].ToString() + "','" + DR["Credit_Days"].ToString() + "','" + DR["Credit_Amount"].ToString() + "','" + DR["Bank_Name"].ToString() + "','" + DR["Bank_Branch_Name"].ToString() + "','" + DR["Account_Number"].ToString() + "','" + DR["IBAN_Number"].ToString() + "','" + DR["Swift_Code"].ToString() + "','" + DR["Approved_By"].ToString() + "','" + DR["Approved_Date"].ToString() + "','" + DR["Supplier_Type"].ToString() + "','" + Str_ContactPerson + "','" + Str_ExternaAddress + "')";//Addresses, 
                            command.CommandText = SQL_Insert;

                            command.ExecuteNonQuery();


                            //Does best
                            //string createCom = "CREATE TABLE [Sheet4] (supplier_Name string,Account_Code string,Phone_Number string,Email_Id string, Fax string, CR_Number string, VAT_Number string, Credit_Days string, Credit_Amount string, Bank_Name string, Branch_Name string, Account_Number string, IBAN_Number string, Swift_Code string, Approved_By string, Approved_Date string,supplier_Type string, Division string, Sales_Man string, Contact_Person Memo, Addresses Memo);";
                            //command.CommandText = createCom;
                            //command.ExecuteNonQuery();
                        }
                    }
                }
            }
        }
        else
        {
            filename = "Access is Restricted.";
        }
        Context.Response.Write(filename);
    }





    public string Access_Regional(string AccessString, string DDL_Branch)
    {
        string Access_Level = "", Self_Access_Division_Ids = ""; string[] AccessString_splt = AccessString.Split('|');

        if (DDL_Branch != "All Branches") { Access_Level = " a.branch_id=" + DDL_Branch + " and "; } else { Access_Level = ""; }

        if (AccessString_splt[0] == "Access is Restricted.")
        {
            Access_Level = "";
            Access_Level = "Access is Restricted.";
        }
        else
        {
            if (AccessString_splt[0] == "Yes")//Company Level Access
            {
                //Access_Level = "";
                return Access_Level;
            }
            else if (AccessString_splt[1] != "0")
            {
                Access_Level = " a.branch_id=" + AccessString_splt[1] + " and "; //// loggged in users branchId


            }
            else if (AccessString_splt[2] != "") // comma seperated Division Ids of others also
            {
                Access_Level = AccessString_splt[2];

                if (Access_Level.Contains(","))
                {
                    Access_Level = Access_Level.Remove(Access_Level.LastIndexOf(","));
                }

                Access_Level = " ( b.Division_Id in (" + Access_Level + ") or C.Employee_Id=" + AccessString_splt[4] + ") and ";
            }
            else if (AccessString_splt[3] != "") //only self divisionIds where users id exists [here salesman id]
            {
                Self_Access_Division_Ids = AccessString_splt[3];

                if (Self_Access_Division_Ids.Contains(","))
                {
                    Self_Access_Division_Ids = Self_Access_Division_Ids.Remove(Self_Access_Division_Ids.LastIndexOf(","));
                }

                Access_Level = " ( C.Employee_Id=" + AccessString_splt[4] + ") and ";
            }
        }

        return Access_Level;
    }

    //---------------------Added Add Balances in Action... Related js funtions are below-------------------------------------------//
    //---------------------Added by BhatJavid-------------------------------------------------------------------------------------//
    void Save_Balances(string InsertArray)
    {
        int ret = -9;
        string[] D = InsertArray.Split('|');
        string SqlQuery = "Insert Into tbl_Supplier_balances values(" + D[0] + ",'" + D[1] + "','" + D[2] + "'," + D[3] + "," + D[4] + "," + D[5] + ",'Open')";
        ret = DB.Get_ScalerInt(SqlQuery);
        if (ret > -9)
        {
            decimal SumofBalances = decimal.Parse(DB.Get_Scaler("select Sum(Balance)from tbl_Supplier_balances where Supplier_Id=" + D[0] + " and Paid_Status='open'"));
            DB.Get_ScalerInt("Update   tbl_ledger_account Set Opening_Balance=" + SumofBalances + " where  Ledger_Account_Id in (select Account_Code from tbl_Supplier where Supplier_Id=" + D[0] + ")");
            Context.Response.Write(ret);
        }
    }
    void Update_Balance(string InsertArray)
    {
        int ret = -9;
        string[] D = InsertArray.Split('|');
        string SqlQuery = "Update tbl_Supplier_balances set  Invoice_Date='" + D[1] + "',Inv_No='" + D[2] + "',Debit=" + D[3] + ",Credit=" + D[4] + ",Balance=" + D[5] + " where Sup_Bal_Id=" + D[0];
        ret = DB.Get_ScalerInt(SqlQuery);
        if (ret > -9)
        {
            decimal SumofBalances = decimal.Parse(DB.Get_Scaler("select Sum(Balance)from tbl_Supplier_balances where Supplier_Id=" + D[6] + " and Paid_Status='open'"));
            DB.Get_ScalerInt("Update   tbl_ledger_account Set Opening_Balance=" + SumofBalances + " where  Ledger_Account_Id in (select Account_Code from tbl_Supplier where Supplier_Id=" + D[6] + ")");
            Context.Response.Write(ret);
        }
    }

    void MarkClosedBal(string Cust_Bal_Id)
    {
        int ret = -9;

        string SqlQuery = "Update tbl_Supplier_balances Set Paid_Status='Closed' where Sup_Bal_Id=" + Cust_Bal_Id;
        ret = DB.Get_ScalerInt(SqlQuery);

        if (ret > -9)
        {
            Context.Response.Write(ret);
        }
    }
    void fetchBalances(string Supplier_Id)
    {
        string output = "";
        DataTable dt = DB.GetDataTable("Select * from tbl_Supplier_balances where Supplier_Id=" + Supplier_Id + " and Paid_Status like 'Open' order by Sup_Bal_Id desc");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow DR in dt.Rows)
            {
                output += "<tr>"
                  + "<td>" + DateTime.Parse(DR["Invoice_Date"].ToString()).ToString("dd-MM-yyyy") + "</td>"
                  + "<td>" + DR["Inv_No"] + "</td>"
                  + "<td>" + DR["Debit"] + "</td>"
                  + "<td>" + DR["Credit"] + "</td>"
                  + "<td>" + DR["Balance"] + "</td>";
                if (DR["Paid_Status"].ToString().Equals("Closed"))
                { output += "<td><span class='badge badge-danger'>Closed</span></td>"; }
                if (DR["Paid_Status"].ToString().Equals("Open"))
                { output += "<td><span class='badge badge-success1'>Open</span></td>"; }

                output += "<td class='text-right'>"
                  + "<div class='btn-group'>"
                  + " <button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>"
                  + "<span><i class='ti-settings'></i></span></button>"
                  + "<ul class='dropdown-menu dropdown-menu-right'>"

                  + "<li onclick=GetBalDetails(" + DR["Sup_Bal_Id"] + ",'View')><a href='#' class='dropdown-item'><i class='fa fa-eye'></i> Details</a></li>"
                   + "<li class='dropdown-divider'></li>";
                if (DR["Paid_Status"].ToString().Equals("Open"))
                {
                    output += "<li onclick=GetBalDetails(" + DR["Sup_Bal_Id"] + ",'Edit')><a href='#' class='dropdown-item'><i class='fa fa-edit'></i> Edit</a></li>"
                    + "<li class='dropdown-divider'></li>";

                    output += "<li onclick='MarkClosedBal(\"" + DR["Sup_Bal_Id"] + "\")'><a href='#' class='dropdown-item'><i class='fa fa-trash'></i> Mark Closed</a></li>"
                    + "<li class='dropdown-divider'></li>";
                    output += "</ul></div></td></tr>";
                }
            }
        }
        else
        {
            output += "<tr><td colspan='5' align='center'>No Record Found!</td></tr>";
        }

        Context.Response.Write(output);
    }
    void fetchBalancesClosed(string Supplier_Id)
    {
        string output = "";
        DataTable dt = DB.GetDataTable("Select * from tbl_Supplier_balances where Supplier_Id=" + Supplier_Id + " and Paid_Status like 'Closed' order by Sup_Bal_Id desc");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow DR in dt.Rows)
            {
                output += "<tr>"
                  + "<td>" + DateTime.Parse(DR["Invoice_Date"].ToString()).ToString("dd-MM-yyyy") + "</td>"
                  + "<td>" + DR["Inv_No"] + "</td>"
                  + "<td>" + DR["Debit"] + "</td>"
                  + "<td>" + DR["Credit"] + "</td>"
                  + "<td>" + DR["Balance"] + "</td>";
                if (DR["Paid_Status"].ToString().Equals("Closed"))
                { output += "<td><span class='badge badge-danger'>Closed</span></td>"; }
                if (DR["Paid_Status"].ToString().Equals("Open"))
                { output += "<td><span class='badge badge-success1'>Open</span></td>"; }

                output += "<td class='text-right'>"
                  + "<div class='btn-group'>"
                  + " <button data-toggle='dropdown' class='btn btn-outline btn-default dropdown-toggle' aria-expanded='true'>"
                  + "<span><i class='ti-settings'></i></span></button>"
                  + "<ul class='dropdown-menu dropdown-menu-right'>"

                  + "<li onclick=GetBalDetails(" + DR["Sup_Bal_Id"] + ",'View')><a href='#' class='dropdown-item'><i class='fa fa-eye'></i> Details</a></li>"
                   + "<li class='dropdown-divider'></li>";
                if (DR["Paid_Status"].ToString().Equals("Open"))
                {
                    output += "<li onclick=GetBalDetails(" + DR["Sup_Bal_Id"] + ",'Edit')><a href='#' class='dropdown-item'><i class='fa fa-edit'></i> Edit</a></li>"
                    + "<li class='dropdown-divider'></li>";

                    output += "<li onclick='MarkClosedBal(\"" + DR["Sup_Bal_Id"] + "\")'><a href='#' class='dropdown-item'><i class='fa fa-trash'></i> Mark Closed</a></li>"
                    + "<li class='dropdown-divider'></li>";
                    output += "</ul></div></td></tr>";
                }
            }
        }
        else
        {
            output += "<tr><td colspan='5' align='center'>No Record Found!</td></tr>";
        }

        Context.Response.Write(output);
    }
        
    void GetBalDetails(string Sup_Bal_Id)
    {
        string output = "";
        DataTable dt = DB.GetDataTable("Select * from tbl_Supplier_balances where Sup_Bal_Id=" + Sup_Bal_Id);
        if (dt.Rows.Count > 0)
        {
            output = DateTime.Parse(dt.Rows[0]["Invoice_Date"].ToString()).ToString("yyyy-MM-dd") + "|" + dt.Rows[0]["Inv_No"] + "|" + dt.Rows[0]["Debit"] + "|" + dt.Rows[0]["Credit"] + "|" + dt.Rows[0]["Balance"];
        }
        Context.Response.Write(output);
    }


    void GetMatadataforPdf(int Supplier_id, int division_Id)
    {
        string JSONStringComp = string.Empty;
        string JSONStringCus = string.Empty;
        string Address = DB.Get_Scaler("select top(1)Address from tbl_Company");
        DataTable CompanyData = DB.GetDataTable("select long_desc as Company_Name ,trn_no as VAT_Number,phone_no as Phone_Number ,'' as Address from tbl_Company_Division where Division_Id=" + division_Id);
        CompanyData.Rows[0][3] = Address;
        CompanyData.AcceptChanges();

        DataTable CustomerData = DB.GetDataTable("select a.*,c.Account_Code,b.Supplier_Name,isnull(Credit_Days,0) as Credit_Days from tbl_External_Party_Address a inner join tbl_Supplier b on a.External_Party_Id=b.Supplier_Id "
                                                 + " inner join tbl_Ledger_Account c on b.Account_Code=c.Ledger_Account_Id where a.External_Party_Type='Supplier' and b.Supplier_Id=" + Supplier_id);

        if (CompanyData.Rows.Count > 0)
        {
            JSONStringComp = JsonConvert.SerializeObject(CompanyData);
        }
        if (CustomerData.Rows.Count > 0)
        {
            JSONStringCus = JsonConvert.SerializeObject(CustomerData);
        }
        string Url = G.B.ToString();
        Context.Response.Write(JSONStringComp + "|" + JSONStringCus + "|" + Url);
    }
    void GetAccountData(int SupplierId, string Date)
    {
        DataTable Dt;
        SqlDataAdapter da;
        string FromDate = "";
        string ToDate = "";
        string fday = "";
        string fMonth = "";
        string fyear = "";
        string newFdate = "";
        string Tday = "";
        string TMonth = "";
        string Tyear = "";
        string newTdate = "";
        if (Date != "")
        {
            FromDate = Date.Substring(0, Date.IndexOf("-"));
            ToDate = Date.Substring(Date.IndexOf("-") + 1);
            //=============Get Formated Date============================

            fday = FromDate.Substring(3, 2);
            fMonth = FromDate.Substring(0, 2);
            fyear = FromDate.Substring(6);
            newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
            Tday = ToDate.Substring(4, 2);
            TMonth = ToDate.Substring(1, 2);
            Tyear = ToDate.Substring(7);
            newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
        }
        //string sql = "with newtable as ( select convert(date,Invoice_Date,105) as Invoice_date,Invoice_Number,dateadd(day,30,invoice_date) as Due_Date, "
        //               + " sum((Unit_Rate*qty)+(Unit_Rate*qty)*(vat/100)) as Debit ,sum(isnull(payment_amount,0))  as Credit , "
        //               + " sum((Unit_Rate*qty)+(Unit_Rate*qty)*(vat/100))-sum(isnull(payment_amount,0)) as balance "
        //                + " from tbl_TripTicket_Invoice a,tbl_TripTicket_Invoice_Item b  left outer join tbl_Receipt_Invoice_Linking c "
        //                + " on c.Invoice_Id=b.invoice_Id where a.id=b.invoice_Id  and a.Invoice_Date >= '"+newFdate+"' and a.Invoice_Date <= '"+newTdate+ "' "
        //                + " and a.Customer_Id = "+customer_id+" group by Invoice_Date,Invoice_Number) "
        //                + " select Invoice_date,Invoice_Number,convert(date,Due_Date,105) as Due_Date,debit,credit,sum(balance)  over (order by Invoice_Number) as balance  from newtable";
        DataTable AccountData = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
        {
            SqlCommand cmd = new SqlCommand("[stmt_of_acct_report_supplier]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@supplier_id", SqlDbType.VarChar).Value = SupplierId;
            cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
            cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;

            con.Open();
            da = new SqlDataAdapter(cmd);
            DataSet DS = new DataSet();
            da.Fill(DS);
            AccountData = DS.Tables[0];
        }
        string JSONString = string.Empty;

        if (AccountData.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(AccountData);
        }
        Context.Response.Write(JSONString);
    }

    void GetAgingAnalysisData(int SupplierId, string Date)
    {
        DataTable dt;
        SqlDataAdapter da;
        string FromDate = "";
        string ToDate = "";
        string fday = "";
        string fMonth = "";
        string fyear = "";
        string newFdate = "";
        string Tday = "";
        string TMonth = "";
        string Tyear = "";
        string newTdate = "";
        if (Date != "")
        {
            FromDate = Date.Substring(0, Date.IndexOf("-"));
            ToDate = Date.Substring(Date.IndexOf("-") + 1);
            //=============Get Formated Date============================

            fday = FromDate.Substring(3, 2);
            fMonth = FromDate.Substring(0, 2);
            fyear = FromDate.Substring(6);
            newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
            Tday = ToDate.Substring(4, 2);
            TMonth = ToDate.Substring(1, 2);
            Tyear = ToDate.Substring(7);
            newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
        }

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
        {
            SqlCommand cmd = new SqlCommand("[stmt_of_acct_report_supplier_2]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@supplier_id", SqlDbType.VarChar).Value = SupplierId;
            cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
            cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;

            con.Open();
            da = new SqlDataAdapter(cmd);
            DataSet DS = new DataSet();
            da.Fill(DS);
            dt = DS.Tables[0];
        }
        string JSONString = JsonConvert.SerializeObject(dt);
        dt.Dispose();
        Context.Response.Write(JSONString);


    }
    void ExportExcelSOA(int Supplier_Id, string Date)
    {
        string SupplierName = DB.Get_Scaler("select Supplier_Name from tbl_supplier where Supplier_Id=" + Supplier_Id);
        DataTable Dt;
        SqlDataAdapter da;
        string FromDate = "";
        string ToDate = "";
        string fday = "";
        string fMonth = "";
        string fyear = "";
        string newFdate = "";
        string Tday = "";
        string TMonth = "";
        string Tyear = "";
        string newTdate = "";
        if (Date != "")
        {
            FromDate = Date.Substring(0, Date.IndexOf("-"));
            ToDate = Date.Substring(Date.IndexOf("-") + 1);
            //=============Get Formated Date============================

            fday = FromDate.Substring(3, 2);
            fMonth = FromDate.Substring(0, 2);
            fyear = FromDate.Substring(6);
            newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
            Tday = ToDate.Substring(4, 2);
            TMonth = ToDate.Substring(1, 2);
            Tyear = ToDate.Substring(7);
            newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
        }

        DataTable AccountData = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
        {
            SqlCommand cmd = new SqlCommand("[stmt_of_acct_report_supplier]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@supplier_id", SqlDbType.VarChar).Value = Supplier_Id;
            cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
            cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;

            con.Open();
            da = new SqlDataAdapter(cmd);
            DataSet DS = new DataSet();
            da.Fill(DS);
            AccountData = DS.Tables[0];
        }
        string JSONString = string.Empty;
        string fileName = "";
        if (AccountData.Rows.Count > 0)
        {
            string AppLocation = HttpContext.Current.Server.MapPath("./AccountStatements/");
            fileName = "SOA_of _" + SupplierName + "_" + DateTime.Now.ToString("dd-MM-yyyy").ToString() + ".xlsx";

            AppLocation += fileName;

            using (XLWorkbook wb = new XLWorkbook())
            {
                IXLWorksheet ws = wb.Worksheets.Add();
                ws.Name = "SuppLier SOA Report";
                var table1 = ws.Range("A1:I1");
                table1.Cell(1, 1).Value = "SOA 0f " + SupplierName + "  - " + DateTime.Now.ToString("dd-MM-yyyy").ToString();
                table1.Cell(1, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                table1.Cell(1, 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                table1.Cell(1, 1).Style.Font.FontSize = 15;
                table1.Cell(1, 1).Style.Font.SetBold();
                table1.Range("A1:F1").Merge();
                var table2 = ws.Range("A2:F2");
                //table2.Style.Border.OutsideBorder = XLBorderStyleValues.Thick;
                table2.Cell(1, 1).Value = "Date";
                table2.Cell(1, 2).Value = "Invoice No";
                table2.Cell(1, 3).Value = "Due Date";
                table2.Cell(1, 4).Value = "Debit";
                table2.Cell(1, 5).Value = "Credit";
                table2.Cell(1, 6).Value = "Balance";


                table2.Style.Font.SetBold();
                table2.Style.Fill.BackgroundColor = XLColor.BlueGray;
                table2.Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);

                ws.Row(1).Height = 30;
                ws.Row(2).Height = 30;
                ws.RowHeight = 22;

                ws.Column("A").Width = 15;
                ws.Column("B").Width = 15;
                ws.Column("C").Width = 15;
                ws.Column("D").Width = 15;
                ws.Column("E").Width = 15;
                ws.Column("F").Width = 15;




                var table3 = ws.Range("A3:F3");
                int i = 1;
                foreach (DataRow dr in AccountData.Rows)
                {
                    table3.Cell(i, 1).Value = dr["Invoice_date"];
                    table3.Cell(i, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                    table3.Cell(i, 2).Value = dr["Invoice_Number"];
                    table3.Cell(i, 3).Value = dr["Due_Date"];
                    table3.Cell(i, 4).Value = dr["debit"];
                    table3.Cell(i, 5).Value = dr["credit"];
                    table3.Cell(i, 6).Value = dr["balance"];
                    i++;
                }
                var table4 = ws.Range("A" + (i + 3) + ":G" + (i + 3));
                table4.Style.Font.SetBold();
                table4.Style.Fill.BackgroundColor = XLColor.BlueGray;

                table4.Cell(1, 1).Value = "";
                table4.Cell(1, 2).Value = "Total";
                table4.Cell(1, 3).Value = "Current";
                table4.Cell(1, 4).Value = "1 Month";
                table4.Cell(1, 5).Value = "2 Month";
                table4.Cell(1, 6).Value = "3 Month";
                table4.Cell(1, 7).Value = "+3 Month";
                var table5 = ws.Range("A" + (i + 4) + ":G" + (i + 4));
                DataTable dt = new DataTable();
                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]))
                {
                    SqlCommand cmd = new SqlCommand("[stmt_of_acct_report_supplier_2]", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@supplier_id", SqlDbType.VarChar).Value = Supplier_Id;
                    cmd.Parameters.Add("@fr_date", SqlDbType.VarChar).Value = newFdate;
                    cmd.Parameters.Add("@to_date", SqlDbType.VarChar).Value = newTdate;

                    con.Open();
                    da = new SqlDataAdapter(cmd);
                    DataSet DS = new DataSet();
                    da.Fill(DS);
                    dt = DS.Tables[0];
                }
                i = 1;
                foreach (DataRow dr in dt.Rows)
                {
                    table5.Cell(i, 1).Value = dr["Trans_Nature"];
                    table5.Cell(i, 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                    table5.Cell(i, 2).Value = dr["CLOSING_BALANCE"];
                    table5.Cell(i, 3).Value = dr["a"];
                    table5.Cell(i, 4).Value = dr["b"];
                    table5.Cell(i, 5).Value = dr["c"];
                    table5.Cell(i, 6).Value = dr["d"];
                    table5.Cell(i, 7).Value = dr["ABOVE120"];
                    i++;
                }

                wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
                wb.Style.Font.Bold = false;

                wb.SaveAs(AppLocation);
                Context.Response.Write(fileName);
            }
        }
        else
        {
            Context.Response.Write("no recoed found");
        }
    }

    void GetVat(string Customer_Id)
    {
        string Vat = DB.Get_Scaler("select VAT_Number from    tbl_Customer where Customer_Id="+Customer_Id);
        Context.Response.Write(Vat);
    }

    void GetBudgetData(string Supplier_id)
    {
        string JSONString1 = "";
        string JSONString2 = "";
        string JSONString3 = "";
        string PryrBudgetAmount = "";
        DataTable dt = DB.GetDataTable("select a.Employee_Id,a.Employee_Name,c.Role_Name from tbl_employee a inner join tbl_Employee_Division_Mapping b on a.Employee_Id=b.Employee_Id "
                                      + "inner join tbl_Role c on b.Role_Id=c.Role_Id where Role_Name='Sales Exective'");
        if (dt.Rows.Count>0)
        {
            JSONString1 = JsonConvert.SerializeObject(dt);
            dt.Dispose();

        }
        DataTable dt1 = DB.GetDataTable("select * from tbl_Supplier_budget where Supplier_id=" + Supplier_id);
        int Prvyr = Convert.ToInt32(DateTime.Now.Year.ToString()) - 1;
        PryrBudgetAmount = DB.Get_Scaler("select Previous_yr_budget from tbl_Supplier_budget where Supplier_id=" + Supplier_id + " and Fin_year like '" + Prvyr + "'");
        if(PryrBudgetAmount=="")
        {
            PryrBudgetAmount = "0.00";
        }
        if (dt1.Rows.Count>0)
        {
            JSONString2 =  dt1.Rows[0]["Budget_Amount"].ToString() + "|" + dt1.Rows[0]["Fin_year"].ToString() + "|" + PryrBudgetAmount + "|" + dt1.Rows[0]["Comments"].ToString()+ "|"
                    + dt1.Rows[0]["Employee_id"].ToString()+ "|" +dt1.Rows[0]["Product"].ToString()+ "|" +dt1.Rows[0]["Budget_Frequency"].ToString()+ "|" +dt1.Rows[0]["Id"].ToString();
            dt1.Dispose();

            foreach (DataRow DR in dt1.Rows)
            {
                JSONString3 += "<tr>"
                  + "<td>" +DR["Fin_year"].ToString() + "</td>"
                  + "<td>" + DR["Budget_Amount"] + "</td>"
                  + "<td>" + DR["Previous_yr_budget"] + "</td>"
                  + "<td>" + DR["Product"] + "</td>"
                  + "<td>" + DR["Budget_Frequency"] + "</td><td>" + DR["Comments"] + "</td> </tr>";



            }
        }
        else
        {
            JSONString3 += "<tr><td colspan='5' align='center'>No Record Found!</td></tr>";
        }


        Context.Response.Write(JSONString1+"|"+JSONString2+"|"+JSONString3);
    }
    void Update_Budget(string InsertArray, string Budget_Id)
    {
        string[] D = InsertArray.Split('|');
        int Ret = -9;
        string sql = "Update tbl_Supplier_budget set Budget_Amount=" + D[1] + ",Previous_yr_budget=" + D[2] + ",Employee_id=" + D[3] +
                    " ,Fin_year='" + D[4] + "',Comments='" + D[5] + "',Product='" + D[6] + "',Budget_Frequency='" + D[7] + "' where Id=" + Budget_Id;
        Ret = DB.Get_ScalerInt(sql);
        if (Ret > -1)
        {
            Context.Response.Write("1");
        }
        else
        {
            Context.Response.Write("0");
        }
    }
    void Save_Budget(string InsertArray)
    {
        int UserId = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[0]);
        string[] D = InsertArray.Split('|');
        int Ret = -9;
        string accountcode = DB.Get_Scaler("select b.Account_Code from tbl_Supplier a inner join tbl_Ledger_Account b on a.Account_Code=b.Ledger_Account_Id where Supplier_id=" + D[0]);
        string Sql = "Insert into tbl_Supplier_budget values ('" + D[0] + "','" + D[3] + "'," + D[1].Replace(",","") + "," + accountcode + ",'"+D[4]+"',"+D[2].Replace(",","")+","+UserId+",'"+DateTime.Now.ToString("yyyy-MM-dd")+"','"+D[5]+"','"+D[6]+"','"+D[7]+"');select @@IDENTITY;";
        Ret = DB.Get_ScalerInt(Sql);
        if(Ret>-1)
        {
            //Update Customer..... set Budget_Id
            DB.Get_ScalerInt("Update tbl_Supplier set  Budget_Id=" + Ret + " where Supplier_id=" + D[0]);
            Context.Response.Write("1");
        }
        else
        {
            Context.Response.Write("0");
        }

    }
    void Getddldiv()
    {
        DataTable dt = DB.GetDataTable("select Division_Name,Division_Id from tbl_Company_Division where Is_Primary=1");
        string JSONString = JsonConvert.SerializeObject(dt);
        dt.Dispose();
        Context.Response.Write(JSONString);
    }

    public bool IsReusable { get { return false; } }
}
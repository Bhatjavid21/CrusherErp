<%@ WebHandler Language="C#" Class="H_tbl_Item" %>
using System;
using System.Web;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using System.Configuration;
using System.Web.SessionState;

public class H_tbl_Item : IHttpHandler, IRequiresSessionState
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
                        case "View_Item":
                            fill_Datatable(Context.Request.Form["itemType"], Context.Request.Form["searchTerm"], Convert.ToInt32(Context.Request.Form["PageNo"]), Context.Request.Form["branchid"], Context.Request.Form["SortByField"], Convert.ToInt32(Context.Request.Form["SubCatId"]));
                            break;
                        case "item_Sub_Category":
                            ddl_item_Sub_Category(Convert.ToInt32(Context.Request.Form["itemtypeid"]), Convert.ToInt32(Context.Request.Form["subcat"]), Convert.ToInt32(Context.Request.Form["Branch_Id"]));
                            break;
                        case "Deactivate_Item":
                            Deactivate_Item(Convert.ToInt32(Context.Request.Form["item_id"]));
                            break;
                        case "Prefix_Code":
                            get_Prefix_Code(Convert.ToInt32(Context.Request.Form["ddl_subcatId"]));
                            break;
                        case "Insert_Item":
                            Insert_Item(Convert.ToInt32(Context.Request.QueryString["Branch_Id"]), Convert.ToInt32(Context.Request.Form["group1"]), Convert.ToInt32(Context.Request.Form["ddl_item_Sub_Category"]), Context.Request.Form["txt_ItemCode"], Context.Request.Form["txt_new_item_code"], Context.Request.Form["txt_brand"], Context.Request.Form["txt_manufacturer"], Context.Request.Form["txt_oem_reference"], Context.Request.Form["txt_capacity"], Context.Request.Form["txt_unit"], Context.Request.Form["txt_Minimum_Margin"], Context.Request.Form["txt_VAT_Percent"], Context.Request.Form["txt_wholesale_quantity"], Context.Request.Form["txt_wholesale_margin"], Context.Request.Form["txt_description"], Context.Request.Form["txt_long_description"], Context.Request.Form["txt_arabic_description"], Context.Request.Form["txt_rate"], Context.Request.Form["txt_Fixed_Sales_Price"], Context.Request.Form["txt_Fixed_Purchase_Price"]);
                            break;
                        case "Edit_Item":
                            Edit_Item(Convert.ToInt32(Context.Request.Form["item_id"]));
                            break;
                        case "Update_Item":

                            Update_Item(Convert.ToInt32(Context.Request.Form["hdf-item-id"]), Convert.ToInt32(Context.Request.Form["group1"]),
                                Convert.ToInt32(Context.Request.Form["ddl_item_Sub_Category"]), Context.Request.Form["txt_ItemCode"],
                                Context.Request.Form["txt_new_item_code"], Context.Request.Form["txt_brand"], Context.Request.Form["txt_manufacturer"],
                                Context.Request.Form["txt_oem_reference"], Context.Request.Form["txt_capacity"], Context.Request.Form["txt_unit"],
                                Context.Request.Form["txt_Minimum_Margin"], Context.Request.Form["txt_VAT_Percent"], Context.Request.Form["txt_wholesale_quantity"],
                                Context.Request.Form["txt_wholesale_margin"], Context.Request.Form["txt_description"],
                                Context.Request.Form["txt_long_description"], Context.Request.Form["txt_arabic_description"], Context.Request.Form["txt_rate"], Context.Request.Form["txt_Fixed_Sales_Price"], Context.Request.Form["txt_Fixed_Purchase_Price"]);
                            break;
                        case "Update_Storage":
                            Update_Storage(Convert.ToInt32(Context.Request.Form["hdf-item-id"]), Context.Request.Form["txt_barcode"],
                                Context.Request.Form["txt_hsecode"], Context.Request.Form["txt_Storage_temprature"], Context.Request.Form["txt_length"],
                                Context.Request.Form["txt_width"], Context.Request.Form["txt_hight"], Context.Request.Form["chk_has_expiry"],
                                Context.Request.Form["chk_has_Warrenty"]);
                            break;
                        case "ddl_Warehouse":
                            ddl_Warehouse(Convert.ToInt32(Context.Request.Form["item_id"]), Convert.ToInt32(Context.Request.Form["wharehouse_id"]));
                            break;
                        case "Insert_Item_Stock_Details":
                            Insert_Item_Stock_Details(Convert.ToInt32(Context.Request.Form["hdf-item-id"]), Convert.ToInt32(Context.Request.Form["ddl_warehouse_id"]),
                                Convert.ToInt32(Context.Request.Form["txt_Minimum_Balance_Qty"]), Context.Request.Form["txt_Re-Order_Quantity"]);
                            break;
                        case "View_ItemStockDetails":
                            fill_ItemStockDatatable(Convert.ToInt32(Context.Request.Form["draw"]), Convert.ToInt32(Context.Request.Form["length"]), Convert.ToInt32(Context.Request.Form["start"]), Convert.ToInt32(Context.Request.Form["item_id"]), Convert.ToInt32(Context.Request.Form["order[0][column]"]), Convert.ToString(Context.Request.Form["order[0][dir]"]));
                            break;
                        case "Edit_ItemStockDetails":
                            Edit_ItemStockDetails(Convert.ToInt32(Context.Request.Form["item_Stock_id"]));
                            break;
                        case "Update_ItemStockDetails":
                            Update_ItemStockDetails(Convert.ToInt32(Context.Request.Form["hdf-itemstock-id"]), Convert.ToInt32(Context.Request.Form["ddl_warehouse_id"]),
                                Convert.ToInt32(Context.Request.Form["txt_Minimum_Balance_Qty"]), Context.Request.Form["txt_Re-Order_Quantity"]);
                            break;
                        case "Deactivate_ItemStock":
                            Deactivate_ItemStock(Convert.ToInt32(Context.Request.Form["item_stock_id"]));
                            break;
                        case "ddl_Party_id":
                            ddl_Party_id(Context.Request.Form["partyType_id"], Convert.ToInt32(Context.Request.Form["item_id"]), Convert.ToInt32(Context.Request.Form["party_id"]));
                            break;
                        case "Insert_Item_External_Details":
                            Insert_Item_External_Details(Convert.ToInt32(Context.Request.Form["hdf-item-id"]), Context.Request.Form["hdf-itemexternal-id"], Context.Request.Form["partyType"],
                                Convert.ToInt32(Context.Request.Form["ddl_Party_Name_Id"]), Context.Request.Form["txtProduct_Code"], Context.Request.Form["txtProduct_Description"]);
                            break;
                        case "fill_ItemExternalDatatable":
                            fill_ItemExternalDatatable(Convert.ToInt32(Context.Request.Form["draw"]), Convert.ToInt32(Context.Request.Form["length"]), Convert.ToInt32(Context.Request.Form["start"]), Convert.ToInt32(Context.Request.Form["item_id"]), Convert.ToInt32(Context.Request.Form["order[0][column]"]), Convert.ToString(Context.Request.Form["order[0][dir]"]));
                            break;
                        case "Edit_Item_External_Details":
                            Edit_Item_External_Details(Convert.ToInt32(Context.Request.Form["item_external_id"]));
                            break;
                        case "Update_External_Details":
                            Update_External_Details(Convert.ToInt32(Context.Request.Form["hdf-itemexternal-id"]), Context.Request.Form["partyType"],
                                Convert.ToInt32(Context.Request.Form["ddl_Party_Name_Id"]), Context.Request.Form["txtProduct_Code"], Context.Request.Form["txtProduct_Description"]);
                            break;
                        case "Deactivate_External_Detail":
                            Deactivate_External_Detail(Convert.ToInt32(Context.Request.Form["item_external_id"]));
                            break;
                        case "Item_Attachment_Upload":
                            upload_ref_doc(context.Request.Files[0]);
                            break;
                        case "Insert_Item_Attachment":
                            Insert_Item_Attachment(Convert.ToInt32(Context.Request.Form["hdf-item-id"]), Context.Request.Form["attachType"],
                                Context.Request.Form["txt_attachment_Name"], Context.Request.Form["hid_fileName"]);
                            break;
                        case "view_ItemAttachmentDatatable":
                            fill_ItemAttachmentDatatable(Convert.ToInt32(Context.Request.Form["draw"]), Convert.ToInt32(Context.Request.Form["length"]), Convert.ToInt32(Context.Request.Form["start"]), Convert.ToInt32(Context.Request.Form["item_id"]), Convert.ToInt32(Context.Request.Form["order[0][column]"]), Convert.ToString(Context.Request.Form["order[0][dir]"]));
                            break;
                        case "Edit_ItemAttachmentDatatable":
                            Edit_ItemAttachmentDatatable(Convert.ToInt32(Context.Request.Form["attachment_Id"]));
                            break;
                        case "Update_ItemAttachmentDatatable":
                            Update_ItemAttachmentDatatable(Convert.ToInt32(Context.Request.Form["hdf-attachment-id"]), Context.Request.Form["attachType"],
                                Context.Request.Form["txt_attachment_Name"], Context.Request.Form["hid_fileName"]);
                            break;
                        case "Deactivate_ItemAttachment":
                            Deactivate_ItemAttachment(Convert.ToInt32(Context.Request.Form["item_attachment_id"]));
                            break;


                        case "Bind_Fixed_Price_Datatable":
                            Bind_Fixed_Price_Datatable(Convert.ToInt32(Context.Request.Form["draw"]), Convert.ToInt32(Context.Request.Form["length"]), Convert.ToInt32(Context.Request.Form["start"]), Convert.ToInt32(Context.Request.Form["item_id"]), Convert.ToInt32(Context.Request.Form["order[0][column]"]), Convert.ToString(Context.Request.Form["order[0][dir]"]));
                            break;
                        case "Delete_Fixed_Price":
                            Delete_Fixed_Price(Convert.ToInt32(Context.Request.Form["Fixed_Price_Id"]));
                            break;

                        case "Insert_Fixed_Price":
                            Insert_Fixed_Price(Convert.ToInt32(Context.Request.Form["hdf-item-id"]), Context.Request.Form["partyType"],
                                Convert.ToInt32(Context.Request.Form["ddl_Party_Name_Id"]), Context.Request.Form["txt_Amount"]);
                            break;

                        case "Update_Fixed_Price":
                            Update_Fixed_Price(Convert.ToInt32(Context.Request.Form["hdf-itemprice-id"]), Context.Request.Form["partyType"],
                                Convert.ToInt32(Context.Request.Form["ddl_Party_Name_Id"]), Context.Request.Form["txt_Amount"]);
                            break;
                        case "Edit_Fixed_Price":
                            Edit_Fixed_Price(Convert.ToInt32(Context.Request.Form["lnk_Price_delete"]));
                            break;
                        case "CheckSession":
                            CheckSession();
                            break;
                    }
                }
                else
                {
                    Raise_Error("SessionIsDead");
                }
            }
            catch (Exception x)
            {
                Raise_Error("!error!" + x.Message + "");
            }
        } Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }


    void Raise_Error(string error) {
        error = error.Replace("\"","");
        var json = (new { status = "success", errorMessage = error });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }
    void CheckSession()
    {
       Context.Response.Write("True");
    }

    void fill_Datatable(string itemType, string SearchTerm, int Page_No, string branchid, string Sort_By_Field, int Sub_Cat_Id)
    {
        string like = "", IT = "", sql_Data, sql_Main, sql_Total_Records, OP = "", PG = "", Paging_Strip,groupBy="",join="", str_Sub_Cat_Id="";

        if (branchid != "0") { branchid = " and B.Branch_Id=" + branchid + " "; } else { branchid="";}

        SearchTerm = SearchTerm.Trim();

        if (SearchTerm.Trim() != "" & SearchTerm.Trim() != "0")
        {
            like = " where (b.Item_Description like '" + @SearchTerm + "%' or   b.Item_Description like '%" + @SearchTerm + "%'  or B.Item_Code "
                + " like '" + @SearchTerm + "%' or B.Item_Code like '%" + @SearchTerm + "%'  "
                + " or c.Item_Category_Name like '" + @SearchTerm + "%' or c.Item_Category_Name like '%" + @SearchTerm + "%'  or a.Item_SubCategory_Name like '" + @SearchTerm + "%' "
                + " or a.Item_SubCategory_Name like '%" + @SearchTerm + "%' or b.OEM_Reference like '" + @SearchTerm + "%' or b.OEM_Reference like'%" + @SearchTerm + "%' "
                + " or d.Product_Description like '" + @SearchTerm + "%' or d.Product_Description like "
                + " '%" + @SearchTerm + "%' or d.Product_Code like '" + @SearchTerm + "%' or d.Product_Code like "
                + " '%" + @SearchTerm + "%') ";

            groupBy = " group by B.Item_Id,B.Item_Type, (C.Item_Category_Name + ' - ' + A.Item_SubCategory_Name),  B.Item_Code, B.Item_Description ";

            join = " left outer join  tbl_Item_External_Detail D on  B.Item_Id = d.Item_Id ";

        }
        if (Sub_Cat_Id != 0) { str_Sub_Cat_Id = " and b.Cat_SubCat_Id=" + Sub_Cat_Id + " "; } else { str_Sub_Cat_Id = ""; }
        if (itemType == "1" || itemType == "2" || itemType == "3") { if (itemType == "1") { IT = " and B.Item_Type=1 "; } else if (itemType == "2") { IT = " and B.Item_Type=2 "; } else { IT = " and B.Item_Type=3 "; } } if (string.IsNullOrEmpty(Sort_By_Field)) { Sort_By_Field = " order by B.Item_Id desc "; }

        int TotalRecords = 0, from = 1, to = 100; if (Page_No == 0) { Page_No = 1; }; from = (((Page_No * 100) - 100) + 1); to = Page_No * 100;

        sql_Main = "WITH tbl_Whole AS(select ROW_NUMBER() OVER (" + Sort_By_Field.Replace("-", ".") + ") AS 'RowNumber',"
            + " B.Item_Id, B.Item_Type, (C.Item_Category_Name + ' - ' + A.Item_SubCategory_Name) "
            + " as Item_SubCategory_Name,  B.Item_Code, B.Item_Description "
            + " From tbl_Item B inner join tbl_Item_SubCategory A on A.Item_SubCategory_Id = B.Cat_SubCat_Id "
            + " inner join tbl_Item_Category c on A.Item_Category_Id = C.Item_Category_Id " + IT + " "
            + " and B.[Status]='true' " + branchid + " " + str_Sub_Cat_Id + " "
            + "   " + join + like + groupBy + ") ";

        sql_Data = "SELECT * FROM tbl_Whole WHERE RowNumber Between " + from + " AND " + to + " "; //+ Sort_By_Field +";";

        sql_Total_Records = " select count(distinct(b.item_id))as Total_Records From tbl_Item B inner join "
            + " tbl_Item_SubCategory A on A.Item_SubCategory_Id = B.Cat_SubCat_Id "
            + " inner join tbl_Item_Category c on A.Item_Category_Id = C.Item_Category_Id " + IT + " "
            + " and B.[Status]='true' " + branchid + " " + str_Sub_Cat_Id + " "
            + " " + join + like + "";


        string Sql_All = sql_Main + sql_Data + sql_Total_Records;

        DataSet DS = DB.GetDataSet_Simple(Sql_All); DataTable DT = DS.Tables[0];

        TotalRecords = Convert.ToInt32(DS.Tables[1].Rows[0]["Total_Records"]);


        if (DT.Rows.Count > 0)
        {
            foreach (DataRow dr in DT.Rows)
            {
                OP += dr["Item_Id"] + "||" + dr["Item_Type"] + "||" + dr["Item_SubCategory_Name"] + "||" + dr["Item_Code"] + "||" + dr["Item_Description"].ToString().Replace("||", "").Replace("~", "") + "~";
            }
        }

        Paging_Strip = Pagination.PG(TotalRecords, Page_No,100);

        if (TotalRecords > 1)
        {
            PG = "<div class='dataTables_info ' id='#' role='status' aria-live='polite'>Showing " + from + " to " +
                to + " of " + TotalRecords + " entries</div>"
                  + "<div class='dataTables_paginate paging_simple_numbers right' id='#_paginate'>"
                  + "<ul class='pagination'>"
                  + Paging_Strip

                  + "</ul></div></div>";
        }

        Context.Response.Clear();
        Context.Response.Write(OP + "^^" + PG);
    }




    void Deactivate_Item(int item_id)
    {
        StringBuilder output = new StringBuilder();

        DB.Set_temp("update tbl_Item set  Status=0  where Item_Id=" + item_id);
        Log.Set_temp("tbl_Item", item_id.ToString(), "Deactivate");

        output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Item Deleted Successfully\",\"url\":\"\"}");



        Context.Response.Write(output.ToString());

    }

    #region "Cheack Box And DDL Methods"

    void ddl_item_Sub_Category(int item_typeId, int sub_catId, int Branch_Id)
    {
        StringBuilder output = new StringBuilder();
        string stroutput = "<option value=0>Select...</option>";

        string sql = "";

        //if(Context.Response.)
        //string ss = HttpContext.Current.Session["session_ids"].ToString();//.Split(',')[1].ToString();

        // string tt = Context.Session["session_ids"].ToString();//.Split(',')[1].ToString();

        sql = "Select  B.Item_SubCategory_Id, B.Item_Code_Prefix, (A.Item_Category_Name + ' > ' + B.Item_SubCategory_Name) as CatSubCatName From tbl_Item_SubCategory as B inner join tbl_Item_Category as A on A.Item_Category_Id = B.Item_Category_Id"; //Where a.branch_id=" + Branch_Id + "";

        SqlDataReader DR = DB.Get_temp(sql);
        if (DR.HasRows)
        {
            for (int i = 0; DR.Read(); i++)
            {
                if (sub_catId == Convert.ToInt32(DR["Item_SubCategory_Id"]))
                {
                    stroutput += "<option value = " + DR["Item_SubCategory_Id"] + " selected>" + DR["CatSubCatName"] + "</option>";
                }
                else
                {
                    stroutput += "<option value = " + DR["Item_SubCategory_Id"] + ">" + DR["CatSubCatName"] + "</option>";
                }

            }
        }
        else
        {
            output.Append("No Sub Category found.");
        }

        DR.Close();


        var json = (new { status = "success", html = stroutput });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);

    }

    void get_Prefix_Code(int sub_cat_Id)
    {
        string sql, Last_ItemCode, PX, New_ItemCode, Z = "", First_ItemCode, sqlPre, Cat_Prefix; Int64 Number_Part = 0; int ln = 0;

        sqlPre = "select top 1 [Item_Code_Prefix] from tbl_Item_SubCategory where Item_SubCategory_Id=" + sub_cat_Id + ""; Cat_Prefix = DB.Get_Scaler(sqlPre);

        sql = "select top 1 item_Code from tbl_item where Cat_SubCat_Id=" + sub_cat_Id + " and item_Code like '" + Cat_Prefix + "%' order by item_id desc"; Last_ItemCode = DB.Get_Scaler(sql);

        if (Last_ItemCode.Length > 1)
        {
            //Prefix = Segregate(Last_ItemCode).Split('|')[0];
            //Number_Part = Convert.ToInt64(Segregate(Last_ItemCode).Split('|')[1]);


            Number_Part = Convert.ToInt64(Last_ItemCode.Replace(Cat_Prefix, ""));

            ln = Convert.ToInt32(Number_Part.ToString().Remove(0, Number_Part.ToString().Length - 1));// ln = last digit

            Number_Part = Number_Part + 1;

            PX = Cat_Prefix;

            // get prefix of the selected subcatid
            // get last itemcode from item table where itemcode like 'CatPrefix%'
            // if it gets, then do as per blow logic if not 
            // does prefix exist in itemCode | if exists, then replace prefix from it and increment the remaining by 1
            //if not exist 

            if (Last_ItemCode.Contains(PX + "00000000")) { if (ln == 9) { Z = "0000000"; } else { Z = "00000000"; } } // 9 will make it 10 means 2 digit
            else if (Last_ItemCode.Contains(PX + "0000000")) { if (ln == 9) { Z = "000000"; } else { Z = "0000000"; } }
            else if (Last_ItemCode.Contains(PX + "000000")) { if (ln == 9) { Z = "00000"; } else { Z = "000000"; } }
            else if (Last_ItemCode.Contains(PX + "00000")) { if (ln == 9) { Z = "0000"; } else { Z = "00000"; } }
            else if (Last_ItemCode.Contains(PX + "0000")) { if (ln == 9) { Z = "000"; } else { Z = "0000"; } }
            else if (Last_ItemCode.Contains(PX + "000")) { if (ln == 9) { Z = "00"; } else { Z = "000"; } }
            else if (Last_ItemCode.Contains(PX + "00")) { if (ln == 9) { Z = "0"; } else { Z = "00"; } }
            else if (Last_ItemCode.Contains(PX + "0")) { if (ln == 9) { Z = ""; } else { Z = "0"; } }

            New_ItemCode = PX + Z + Number_Part;
        }
        else
        {
            New_ItemCode= Cat_Prefix + "000000001";
        }




        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  OLD CODE  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        // StringBuilder output = new StringBuilder();
        // string stroutput = "", sql,itemcode = "0000000", strprefix = "";

        //sql = "Select Top 1 A.Item_Code, B.Item_Code_Prefix from tbl_Item as A right join tbl_Item_SubCategory as B "
        // + " on B.Item_SubCategory_Id = A.Cat_SubCat_Id   Where B.Item_SubCategory_Id=" + sub_cat_Id + " Order By A.Item_Id DESC";




        //SqlDataReader DR = DB.Get_temp(sql);
        //if (DR.HasRows)
        //{

        //    for (int i = 0; DR.Read(); i++)
        //    {
        //        if (!String.IsNullOrEmpty(DR["Item_Code"].ToString()))
        //        {
        //            stroutput += DR["Item_Code_Prefix"] + "|" + DR["Item_Code"];
        //            itemcode = DR["Item_Code"].ToString();
        //            strprefix = DR["Item_Code_Prefix"].ToString();
        //        }
        //        else
        //        {
        //            stroutput += DR["Item_Code"];
        //            strprefix = DR["Item_Code_Prefix"].ToString();
        //        }

        //        string strcode = itemcode.Replace(strprefix, "");
        //        int icode = Convert.ToInt32(strcode.Length);
        //        string strzeros = "";

        //        string strcodelen = Convert.ToString(icode);

        //        switch (strcodelen.Length)
        //        {
        //            case 1:
        //                strzeros = "000000";
        //                if (icode == 9)
        //                {
        //                    strzeros = "00000";
        //                }
        //                break;
        //            case 2:
        //                strzeros = "00000";
        //                if (icode == 99)
        //                {
        //                    strzeros = "0000";
        //                }
        //                break;
        //            case 3:
        //                strzeros = "0000";
        //                if (icode == 999)
        //                {
        //                    strzeros = "000";
        //                }
        //                break;
        //            case 4:
        //                strzeros = "000";
        //                if (icode == 9999)
        //                {
        //                    strzeros = "00";
        //                }
        //                break;
        //            case 5:
        //                strzeros = "00";
        //                if (icode == 99999)
        //                {
        //                    strzeros = "0";
        //                }
        //                break;
        //            case 6:
        //                strzeros = "0";
        //                if (icode == 999999)
        //                {
        //                    strzeros = "";
        //                }
        //                break;

        //        }

        //        itemcode = strprefix + strzeros + (icode + 1);
        //    }
        //}
        //else
        //{
        //    itemcode = "";
        //    output.Append("No item Code found.");
        //}

        //DR.Close();


        //return itemcode;

        var json = (new { status = "success", html = New_ItemCode });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);


    }
    #endregion


    void Insert_Item(int branch_id, Int32 rbtypeid, Int32 ddl_itemSubCatId, string txt_item_code, string txt_new_item_code, string txt_brand,
        string txt_manufacturer, string txt_oem_reference, string txt_capacity, string txt_Unit, string txt_minimum_margin, string txt_vat_percent,
         string txt_wholesale_quantity, string txt_wholesale_margin, string txt_item_description, string txt_long_description, string txt_arabic_description, string rate, string txt_Fixed_Sales_Price, string txt_Fixed_Purchase_Price)
    {
        if (txt_wholesale_quantity.Contains(".00")) { txt_wholesale_quantity = txt_wholesale_quantity.Replace(".00", ""); }
        if (txt_wholesale_margin == "") { txt_wholesale_margin = "0.00"; } if (string.IsNullOrEmpty(rate)) { rate = "0.00"; }

        StringBuilder output = new StringBuilder();
        string sql_Insert = "";

        SqlDataReader dt = DB.Get_temp("select item_id from tbl_Item where Item_Code='" + txt_item_code + "'");
        int chk = 0;

        while (dt.Read())
        {
            chk = Convert.ToInt32(dt["item_id"]);

        }

        if (chk == 0)
        {
            if (txt_minimum_margin == "") { txt_minimum_margin = "0"; }

            sql_Insert = "insert into tbl_Item (branch_id, item_type, cat_subcat_id, item_code, new_item_code,  brand, manufacturer, oem_reference, Capacity, Unit, "
            + "Min_Margin_Percent, VAT_Percent, Min_Wholesale_Quantity, Min_wholesale_Margin, item_description, long_description, Arabic_Description, Rate, [Sales_Fixed_Price],[Purchase_Fixed_Price]) values (" + branch_id + ", " + rbtypeid + ", " + ddl_itemSubCatId + ", '" + txt_item_code + "', '"
            + txt_new_item_code + "', '" + txt_brand + "', '" + txt_manufacturer + "', '" + txt_oem_reference + "', '" + txt_capacity + "', '"
            + txt_Unit + "', '" + txt_minimum_margin.Replace("_", "") + "', '" + txt_vat_percent.Replace("_", "") + "', '" + txt_wholesale_quantity.Replace("_", "") + "', '" + txt_wholesale_margin.Replace("_", "") + "', '" + txt_item_description.Replace("'", "''") + "', '" + txt_long_description.Replace("'", "''") + "', '"
            + txt_arabic_description.Replace("'", "''") + "','" + rate.Replace("_", "") + "','" + txt_Fixed_Sales_Price.Replace("_", "") + "','" + txt_Fixed_Purchase_Price.Replace("_", "") + "'); select @@IDENTITY";



            string Item_Id = DB.Get_Scaler(sql_Insert);
            Log.Set_temp("tbl_Item", Item_Id.ToString(), "Insert");

            //string sql = "SELECT Top 1 item_id from tbl_Item order By item_id Desc";
            //SqlDataReader drid = DB.Get_temp(sql);
            //int itemId = 0;
            //while (drid.Read())
            //{
            //    itemId = Convert.ToInt32(drid["item_id"]);
            //}
            //drid.Close();
            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Item Added Successfully\",\"url\":\"\",\"itemid\":\"" + Item_Id + "\"}");
        }
        else
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"This Item Code Already Exists\",\"url\":\"\"}");
        }
        dt.Close();


        Context.Response.Write(output.ToString());
    }

    //**********************************Update Storage**********************************************************************************

    void Update_Storage(int item_id, string txt_barcode, string txt_hsecode,
        string txt_storage_temprature, string txt_length, string txt_width, string txt_hight, string chk_has_expiry, string chk_has_warrenty)
    {
        StringBuilder output = new StringBuilder();

        DB.Set_temp("update tbl_Item set bar_code = '" + txt_barcode + "', HSE_Code = '" + txt_hsecode + "', storage_temprature = '" + txt_storage_temprature
                 + "', length = '" + txt_length + "', width = '" + txt_width + "', hight = '" + txt_hight + "', Has_Expiry = '" + chk_has_expiry
                 + "', Has_Warrenty = '" + chk_has_warrenty + "' where item_id =" + item_id + "");


        Log.Set_temp("tbl_Item", item_id.ToString(), "Update");

        output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Item Updated Successfully\",\"url\":\"\"}");



        Context.Response.Write(output.ToString());
    }


    //*********************************Update*********************************Update******************************************Update***********************************************************

    void Update_Item(int item_id, int item_type_id, int ddl_subcat_id, string txt_item_code, string txt_new_item_code, string txt_brand, string txt_manufacturer,
        string txt_oem_reference, string txt_capacity, string txt_unit, string txt_min_margin, string txt_vat_percent, string txt_wholesale_quantity,
        string txt_wholesale_margin, string txt_item_description, string txt_long_description, string txt_arabic_description, string rate, string txt_Fixed_Sales_Price, string txt_Fixed_Purchase_Price)
    {


        if (txt_wholesale_margin == "") { txt_wholesale_margin = "0.00"; }
        if (rate == "") { rate = "0.00"; }

        StringBuilder output = new StringBuilder();

        string sql = "update tbl_Item set Item_Type = " + item_type_id + ", Cat_SubCat_Id = " + ddl_subcat_id + ", item_code = '" + txt_item_code
                 + "', New_Item_Code = '" + txt_new_item_code + "', brand = '" + txt_brand + "', manufacturer = '" + txt_manufacturer
                 + "', oem_reference = '" + txt_oem_reference.Replace("_", "") + "', Capacity = '" + txt_capacity.Replace("_", "") + "', Unit = '" + txt_unit.Replace("_", "")
                 + "', Min_Margin_Percent = '" + txt_min_margin.Replace("_", "") + "', VAT_Percent = '" + txt_vat_percent.Replace("_", "") + "', Min_Wholesale_Quantity = '" + txt_wholesale_quantity.Replace("_", "")
                 + "', Min_wholesale_Margin = '" + txt_wholesale_margin.Replace("_", "") + "', item_description = '" + txt_item_description.Replace("'", "''")
                 + "', long_description = '" + txt_long_description.Replace("'", "''") + "', Arabic_Description = '" + txt_arabic_description.Replace("'", "''")
                 + "', rate='" + rate.Replace("_", "").Replace("_0", "") + "', [Sales_Fixed_Price]='" + txt_Fixed_Sales_Price.Replace("_", "").Replace("_0", "") + "', [Purchase_Fixed_Price]='" + txt_Fixed_Purchase_Price.Replace("_", "").Replace("_0", "") + "' where item_id = '" + item_id + "'";

        DB.Set_temp(sql);

        Log.Set_temp("tbl_Item", item_id.ToString(), "Update");
        output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Item Updated Successfully\",\"url\":\"\"}");


        Context.Response.Write(output.ToString());
    }



    //*********************************Edit*********************************Edit******************************************Edit***********************************************************

    void Edit_Item(Int32 item_id)
    {

        StringBuilder output = new StringBuilder();
        string sql = "select Item_Id, Item_Type, Cat_SubCat_Id, Item_Code, New_Item_Code, Brand, Manufacturer, "
        + " OEM_Reference, Capacity, Unit, Min_Margin_Percent, VAT_Percent, Min_Wholesale_Quantity,Min_wholesale_Margin, Item_Description, Long_Description, "
        + " Arabic_Description, Bar_Code, HSE_Code, Storage_Temprature, Length, Width, Hight, Has_Expiry, Has_Warrenty, rate,[Sales_Fixed_Price], [Purchase_Fixed_Price] "
        + " from tbl_Item where item_id = " + item_id;


        SqlDataReader DR = DB.Get_temp(sql);
        while (DR.Read())
        {
            output.Append("{\"status\":\"message\",\"action\":\"\",\"message\":\"\",\"url\":\"\",\"itemvalue\":\"" + DR["Item_Type"] + "|" + DR["Cat_SubCat_Id"] + "|" + DR["Item_Code"] + "|" + DR["New_Item_Code"] + "|" + DR["Brand"] + "|" + DR["Manufacturer"] + "|" + DR["OEM_Reference"] + "|" + DR["Capacity"] + "|" + DR["Unit"] + "|" + DR["Min_Margin_Percent"] + "|" + DR["VAT_Percent"] +"|"
                + StripUnicodeCharactersFromString(DR["Item_Description"].ToString().Replace("\"", "\\\""))//.Replace("\"", "\\\"") 
                + "|"
                + DR["Long_Description"].ToString().Replace("\"", "\\\"") + "|"
                + StripUnicodeCharactersFromString(DR["Arabic_Description"].ToString().Replace("\"", "\\\""))//.Replace("\"", "\\\"") 
                + "|" + DR["Bar_Code"] + "|" + DR["HSE_Code"] + "|" + DR["Storage_Temprature"] + "|" + DR["Length"] + "|" + DR["Width"] + "|" + DR["Hight"] + "|" + DR["Has_Expiry"] + "|" + DR["Has_Warrenty"] + "|" + DR["Min_Wholesale_Quantity"] + "|" + DR["Min_wholesale_Margin"] + "|" + DR["rate"] + "|" + DR["Sales_Fixed_Price"] + "|" + DR["Purchase_Fixed_Price"] + "\"}");


            //" + DR["Long_Description"].ToString().Replace("\"", "\\\"") + "
            //" + DR["Arabic_Description"].ToString().Replace("\"", "\\\"") + "
            //" + DR["Item_Description"].ToString().Replace("\"", "\\\"") + "
        }
        DR.Close();

        Context.Response.Write(output);
    }

    public static String StripUnicodeCharactersFromString(string inputValue)
    {
        return System.Text.RegularExpressions.Regex.Replace(inputValue, @"\s", " ");
        //return Encoding.ASCII.GetString(Encoding.Convert(Encoding.UTF8, Encoding.GetEncoding(Encoding.ASCII.EncodingName, new EncoderReplacementFallback(String.Empty), new DecoderExceptionFallback()), Encoding.UTF8.GetBytes(inputValue)));
    }

    #region "Item Stock Details"
    void ddl_Warehouse(int item_id, int warehouse_id)
    {
        StringBuilder output = new StringBuilder();
        string stroutput="", sele= "<option value='' selected>Select...</option>";

        string sql = "";

        sql = "Select Warehouse_Id, Warehouse_Name from tbl_Warehouse inner join "
        + " tbl_Company_Branch on tbl_Company_Branch.Company_Id = tbl_Warehouse.Company_Id "
        + " inner join tbl_Item on tbl_Company_Branch.Branch_Id = tbl_Item.Branch_Id "
        + " Where tbl_Item.Item_Id=" + item_id;

        SqlDataReader DR = DB.Get_temp(sql);
        if (DR.HasRows)
        {

            for (int i = 0; DR.Read(); i++)
            {
                int val = Convert.ToInt32(DR["Warehouse_Id"]);
                if (warehouse_id == Convert.ToInt32(DR["Warehouse_Id"]))
                {
                    sele = "";
                    stroutput += "<option value = '" + DR["Warehouse_Id"] + "' selected>" + DR["Warehouse_Name"] + "</option>";
                }
                else
                {
                    stroutput += "<option value = '" + DR["Warehouse_Id"] + "'>" + DR["Warehouse_Name"] + "</option>";
                }

            }
        }
        else
        {
            output.Append("No Warehouse found.");
        }

        DR.Close();
        stroutput = sele+stroutput;

        var json = (new { status = "success", html = stroutput });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }

    void Insert_Item_Stock_Details(int Item_Id, int ddl_warehouse_id, int Min_Balance_Quantity, string ReOrder_Quantity)
    {
        StringBuilder output = new StringBuilder();
        string sql_Insert = "", Item_Min_Stock_Id = "";
        try
        {
            sql_Insert = "insert into tbl_Item_Stock (Item_Id, Warehouse_Id, Min_Balance_Quantity, ReOrder_Quantity) values (" + Item_Id + ", " + ddl_warehouse_id + ", " + Min_Balance_Quantity + ",'" + ReOrder_Quantity + "'); select @@IDENTITY";
            Item_Min_Stock_Id = DB.Get_Scaler(sql_Insert);
            Log.Set_temp("tbl_Item_Stock", Item_Min_Stock_Id, "Insert");
            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Stock Added Successfully\",\"url\":\"\"}");
        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }
        Context.Response.Write(output.ToString());
    }


    void fill_ItemStockDatatable(int draw, int pagesize, int pagenumber, int itemId, int sortorder, string sortcolumn)
    {
        List<itemStockDataTable> lstdt = new List<itemStockDataTable>();
        int recordstotal = 0;
        int idraw = draw;
        pagenumber = pagenumber / pagesize;
        var iscolumns = "Item_Min_Stock_Id,Warehouse_Name,Min_Balance_Quantity,ReOrder_Quantity";

        DataSet ds = DB.GetItemsStockDetailsbyItemId(pagesize, pagenumber, itemId, sortorder, sortcolumn);
        if (ds.Tables.Count > 0)
        {
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                lstdt.Add(new itemStockDataTable
                {
                    Item_Min_Stock_Id = dr["Item_Min_Stock_Id"].ToString(),
                    Warehouse_Name = dr["Warehouse_Name"].ToString(),
                    Min_Balance_Quantity = dr["Min_Balance_Quantity"].ToString(),
                    ReOrder_Quantity = dr["ReOrder_Quantity"].ToString()

                });
                recordstotal = Convert.ToInt32(dr["RecCount"].ToString());
            }

        }

        var json = (new { draw = idraw, data = lstdt.ToArray(), sColumns = iscolumns, iTotalRecords = recordstotal, iTotalDisplayRecords = recordstotal });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }

    void Edit_ItemStockDetails(Int32 Item_Min_Stock_Id)
    {

        StringBuilder output = new StringBuilder();
        string sql = "Select Item_Min_Stock_Id, Item_Id, Warehouse_Id, Min_Balance_Quantity, ReOrder_Quantity from tbl_Item_Stock "
            + " Where Item_Min_Stock_Id=" + Item_Min_Stock_Id;


        SqlDataReader DR = DB.Get_temp(sql);
        while (DR.Read())
        {
            output.Append("{\"status\":\"message\",\"action\":\"\",\"message\":\"\",\"url\":\"\",\"itemstockvalue\":\"" + DR["Item_Min_Stock_Id"] + "|" + DR["Item_Id"] + "|" + DR["Warehouse_Id"] + "|" + DR["Min_Balance_Quantity"] + "|" + DR["ReOrder_Quantity"] + "\"}");
        }
        DR.Close();

        Context.Response.Write(output.ToString());

    }

    //**********************************Update Stock**********************************************************************************

    void Update_ItemStockDetails(int Item_Min_Stock_Id, int ddl_warehouse_id, int Min_Balance_Quantity, string ReOrder_Quantity)
    {
        StringBuilder output = new StringBuilder();
        try
        {
            DB.Set_temp("update tbl_Item_Stock set Warehouse_Id = " + ddl_warehouse_id + ", Min_Balance_Quantity = " + Min_Balance_Quantity +
                ", ReOrder_Quantity = '" + ReOrder_Quantity + "' where Item_Min_Stock_Id =" + Item_Min_Stock_Id + "");


            Log.Set_temp("tbl_Item_Stock", Item_Min_Stock_Id.ToString(), "Update");

            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Stock Updated Successfully\",\"url\":\"\"}");

        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }

        Context.Response.Write(output.ToString());
    }

    void Deactivate_ItemStock(int item_Stock_id)
    {
        StringBuilder output = new StringBuilder();
        try
        {
            DB.Set_temp("Delete from tbl_Item_Stock where Item_Min_Stock_Id=" + item_Stock_id);
            Log.Set_temp("tbl_Item_Stock", item_Stock_id.ToString(), "Deactivate");

            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Stock Details Deleted Successfully\",\"url\":\"\"}");

        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }

        Context.Response.Write(output.ToString());

    }

    #endregion

    #region "Item External Details"

    void fill_ItemExternalDatatable(int draw, int pagesize, int pagenumber, int itemId, int sortorder, string sortcolumn)
    {
        List<itemExternalDataTable> lstdt = new List<itemExternalDataTable>();
        int recordstotal = 0;
        int idraw = draw;
        pagenumber = pagenumber / pagesize;
        var iscolumns = "External_Detail_Id,Supplier_Name,Cus_Company_Name,Party_Type,Product_Code";

        DataSet ds = DB.GetItemExternalDetailsbyItemId(pagesize, pagenumber, itemId, sortorder, sortcolumn);
        if (ds.Tables.Count > 0)
        {
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                lstdt.Add(new itemExternalDataTable
                {
                    External_Detail_Id = dr["External_Detail_Id"].ToString(),
                    Supplier_Name = dr["Supplier_Name"].ToString(),
                    Cus_Company_Name  = dr["Cus_Company_Name"].ToString(),
                    Party_Type = dr["Party_Type"].ToString(),
                    Product_Code = dr["Product_Code"].ToString()

                });
                recordstotal = Convert.ToInt32(dr["RecCount"].ToString());
            }

        }

        var json = (new { draw = idraw, data = lstdt.ToArray(), sColumns = iscolumns, iTotalRecords = recordstotal, iTotalDisplayRecords = recordstotal });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }

    void ddl_Party_id(string partyType, int item_id, int party_id)
    {
        StringBuilder output = new StringBuilder();
        string stroutput = "<option value =''>Select...</option>";

        string sql = "";
        try
        {
            if (partyType == "Customer")
            {
                sql = "Select Customer_Id, Cus_Company_Name from tbl_Customer "
                   + " inner join tbl_Item on tbl_Customer.Branch_Id = tbl_Item.Branch_Id  Where tbl_Item.Item_Id=" + item_id;

                SqlDataReader DRC = DB.Get_temp(sql);
                if (DRC.HasRows)
                {

                    for (int i = 0; DRC.Read(); i++)
                    {
                        int val = Convert.ToInt32(DRC["Customer_Id"]);
                        if (party_id == Convert.ToInt32(DRC["Customer_Id"]))
                        {
                            stroutput += "<option value = '" + DRC["Customer_Id"] + "' selected>" + DRC["Cus_Company_Name"] + "</option>";
                        }
                        else
                        {
                            stroutput += "<option value = '" + DRC["Customer_Id"] + "'>" + DRC["Cus_Company_Name"] + "</option>";
                        }

                    }
                }
                else
                {
                    output.Append("No data found.");
                }

                DRC.Close();
            }
            else
            {
                sql = "Select Supplier_Id, Supplier_Name from tbl_Supplier "
                 + " inner join tbl_Item on tbl_Supplier.Branch_Id = tbl_Item.Branch_Id  Where tbl_Item.Item_Id=" + item_id;

                SqlDataReader DRS = DB.Get_temp(sql);
                if (DRS.HasRows)
                {

                    for (int i = 0; DRS.Read(); i++)
                    {
                        int val = Convert.ToInt32(DRS["Supplier_Id"]);
                        if (party_id == Convert.ToInt32(DRS["Supplier_Id"]))
                        {
                            stroutput += "<option value = '" + DRS["Supplier_Id"] + "' selected>" + DRS["Supplier_Name"] + "</option>";
                        }
                        else
                        {
                            stroutput += "<option value = '" + DRS["Supplier_Id"] + "'>" + DRS["Supplier_Name"] + "</option>";
                        }

                    }
                }
                else
                {
                    output.Append("No data found.");
                }

                DRS.Close();
            }


        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }

        var json = (new { status = "success", html = stroutput });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }


    void Insert_Item_External_Details(int Item_Id, string itemexternal, string rbParty_Type, int ddl_Party_Id, string Product_Code, string Product_Description)
    {
        StringBuilder output = new StringBuilder();
        string sql_Insert = "", External_Detail_Id = "";
        try
        {
            sql_Insert = "insert into tbl_Item_External_Detail (Item_Id, Party_Type, Party_Id, Product_Code, Product_Description) values (" + Item_Id + ",'" + rbParty_Type + "', " + ddl_Party_Id + ",'" + Product_Code + "','" + Product_Description.Replace("'","''") + "'); select @@IDENTITY";
            External_Detail_Id = DB.Get_Scaler(sql_Insert);
            Log.Set_temp("tbl_Item_External_Detail", External_Detail_Id, "Insert");
            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"External Details Added Successfully\",\"url\":\"\"}");
        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }
        Context.Response.Write(output.ToString());
    }

    void Deactivate_External_Detail(int ExternalDetail_Id)
    {
        StringBuilder output = new StringBuilder();
        try
        {
            DB.Set_temp("Delete from tbl_Item_External_Detail where External_Detail_Id=" + ExternalDetail_Id);
            Log.Set_temp("tbl_Item_External_Detail", ExternalDetail_Id.ToString(), "Deactivate");

            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"External Details Deleted Successfully\",\"url\":\"\"}");

        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }

        Context.Response.Write(output.ToString());

    }

    void Edit_Item_External_Details(Int32 ExternalDetail_Id)
    {
        StringBuilder output = new StringBuilder();
        string sql = "Select External_Detail_Id, Party_Type, Party_Id, Product_Code, Product_Description from tbl_Item_External_Detail "
            + " Where External_Detail_Id=" + ExternalDetail_Id;
        try
        {
            SqlDataReader DR = DB.Get_temp(sql);
            while (DR.Read())
            {
                output.Append("{\"status\":\"message\",\"action\":\"\",\"message\":\"\",\"url\":\"\",\"itemexternalvalue\":\"" + DR["External_Detail_Id"] + "|" + DR["Party_Type"] + "|" + DR["Party_Id"] + "|" + DR["Product_Code"] + "|" + DR["Product_Description"] + "\"}");
            }
            DR.Close();
        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }
        Context.Response.Write(output.ToString());
    }

    void Update_External_Details(int External_Detail_Id, string rbParty_Type, int ddl_Party_Id, string Product_Code, string Product_Description)
    {
        StringBuilder output = new StringBuilder();
        try
        {
            DB.Set_temp("update tbl_Item_External_Detail set Party_Type = '" + rbParty_Type + "', Party_Id = " + ddl_Party_Id +
                ", Product_Code = '" + Product_Code + "', Product_Description = '" + Product_Description.Replace("'", "''") + "' where External_Detail_Id =" + External_Detail_Id + "");

            Log.Set_temp("tbl_Item_External_Detail", External_Detail_Id.ToString(), "Update");
            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"External Details Updated Successfully\",\"url\":\"\"}");
        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }

        Context.Response.Write(output.ToString());
    }
    #endregion


    #region "Item Attachments"
    void upload_ref_doc(HttpPostedFile file)
    {
        string strstatus, strmessage, output;
        try
        {
            string strguid = Guid.NewGuid().ToString();
            string strnewfile;
            var fileName = Path.GetFileName(file.FileName).Replace("-","_");
            var Extension = Path.GetExtension(file.FileName);
            string varName = fileName.Replace(Extension,"")+"-"+DateTime.Now.ToString().Replace("/", "").Replace(" ", "").Replace(":", "")+Extension;
            strnewfile = varName + "-" + fileName;
            if (strnewfile.Length > 56)
            {
                strstatus = "error";
                strmessage = "File Name is bigger accepts only lesthan 20 Characters";
                output = "{\"status\":\"error\",\"action\":\"\",\"message\":\"" + strmessage + "\",\"url\":\"\"}";
            }
            else
            {
                var path = Path.Combine(Context.Server.MapPath("~/Upload/Item"), varName);
                file.SaveAs(path);
                strstatus = "success";
                strmessage = varName;
                output = "{\"status\":\"success\",\"action\":\"\",\"message\":\"" + strmessage + "\",\"url\":\"\"}";
            }
        }
        catch (Exception ex)
        {
            strstatus = "error";
            strmessage = ex.Message;
            output = "{\"status\":\"" + strstatus + "\",\"action\":\"\",\"message\":\"" + strmessage + "\",\"url\":\"\"}";
        }
        Context.Response.Write(output);
    }

    void Insert_Item_Attachment(int Item_Id, string ddl_Attachment_Type, string Attachment_Name, string upload_Attachment_File)
    {
        StringBuilder output = new StringBuilder();
        string sql_Insert = "", Attachment_Id = "";
        try
        {
            sql_Insert = "insert into tbl_Item_Attachment(Attachment_Type, Item_Id, Attachment_Name, Attachment_File) values ('" + ddl_Attachment_Type + "', " + Item_Id + ",'" + Attachment_Name + "','" + upload_Attachment_File + "'); select @@IDENTITY";
            Attachment_Id = DB.Get_Scaler(sql_Insert);
            Log.Set_temp("tbl_Item_Attachment", Attachment_Id, "Insert");
            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Attachment Added Successfully\",\"url\":\"\"}");
        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }
        Context.Response.Write(output.ToString());
    }

    void fill_ItemAttachmentDatatable(int draw, int pagesize, int pagenumber, int itemId, int sortorder, string sortcolumn)
    {
        List<itemAttachmentDataTable> lstdt = new List<itemAttachmentDataTable>();
        int recordstotal = 0;
        int idraw = draw;
        pagenumber = pagenumber / pagesize;
        var iscolumns = "Attachment_Id,Attachment_Type,Attachment_Name,Attachment_File";

        DataSet ds = DB.GetItemAttachmentsbyItemId(pagesize, pagenumber, itemId, sortorder, sortcolumn);
        if (ds.Tables.Count > 0)
        {
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                lstdt.Add(new itemAttachmentDataTable
                {
                    Attachment_Id = dr["Attachment_Id"].ToString(),
                    Attachment_Type = dr["Attachment_Type"].ToString(),
                    Attachment_Name = dr["Attachment_Name"].ToString(),
                    Attachment_File = dr["Attachment_File"].ToString()

                });
                recordstotal = Convert.ToInt32(dr["RecCount"].ToString());
            }

        }

        var json = (new { draw = idraw, data = lstdt.ToArray(), sColumns = iscolumns, iTotalRecords = recordstotal, iTotalDisplayRecords = recordstotal });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }

    void Edit_ItemAttachmentDatatable(Int32 attachment_Id)
    {

        StringBuilder output = new StringBuilder();
        string sql = "Select Attachment_Id, Attachment_Type, Item_Id, Attachment_Name, Attachment_File from tbl_Item_Attachment"
            + " Where Attachment_Id=" + attachment_Id;

        try
        {
            SqlDataReader DR = DB.Get_temp(sql);
            while (DR.Read())
            {
                output.Append("{\"status\":\"message\",\"action\":\"\",\"message\":\"\",\"url\":\"\",\"itemAttachmentvalue\":\"" + DR["Attachment_Id"] + "|" + DR["Attachment_Type"] + "|" + DR["Item_Id"] + "|" + DR["Attachment_Name"] + "|" + DR["Attachment_File"] + "\"}");
            }
            DR.Close();
        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }
        Context.Response.Write(output.ToString());
    }

    void Update_ItemAttachmentDatatable(int Attachment_Id, string ddl_Attachment_Type, string Attachment_Name, string upload_Attachment_File)
    {
        StringBuilder output = new StringBuilder();
        try
        {
            DB.Set_temp("update tbl_Item_Attachment set Attachment_Type = '" + ddl_Attachment_Type + "', Attachment_Name = '" + Attachment_Name +
                "', Attachment_File = '" + upload_Attachment_File + "' where Attachment_Id =" + Attachment_Id + "");


            Log.Set_temp("tbl_Item_Attachment", Attachment_Id.ToString(), "Update");

            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Attachment Updated Successfully\",\"url\":\"\"}");

        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }

        Context.Response.Write(output.ToString());
    }

    void Deactivate_ItemAttachment(int item_attachment_id)
    {
        StringBuilder output = new StringBuilder();
        try
        {
            DB.Set_temp("Delete from tbl_Item_Attachment where Attachment_Id=" + item_attachment_id);
            Log.Set_temp("tbl_Item_Attachment", item_attachment_id.ToString(), "Deactivate");

            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Attachment Deleted Successfully\",\"url\":\"\"}");

        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }

        Context.Response.Write(output.ToString());

    }

    #endregion




    #region "Price DataTable Bind"

    void Bind_Fixed_Price_Datatable(int draw, int pagesize, int pagenumber, int itemId, int sortorder, string sortcolumn)
    {
        List<Fixed_Price_Datatable> lstdt = new List<Fixed_Price_Datatable>();
        int recordstotal = 0;
        int idraw = draw;
        pagenumber = pagenumber / pagesize;
        var iscolumns = "Fixed_Price_Id,Supplier_Name,Cus_Company_Name,Party_Type,Amount";

        //DataSet ds = DB.GetItemExternalDetailsbyItemId(pagesize, pagenumber, itemId, sortorder, sortcolumn);

        DataTable DT=new DataTable();
        string strconn = ConfigurationManager.AppSettings["Con"];
        using (SqlConnection conn = new SqlConnection(strconn))
        {
            string spname = "[Proc_Bind_Item_Fixed_Price]";
            using (SqlCommand cmd = new SqlCommand(spname, conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageSize", pagesize);
                cmd.Parameters.AddWithValue("@PageNumber", pagenumber);
                cmd.Parameters.AddWithValue("@item_id", itemId);
                cmd.Parameters.AddWithValue("@sortcolumn", sortorder);
                cmd.Parameters.AddWithValue("@sortorder", sortcolumn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(DT);
            }
            conn.Close();
        }



        if (DT.Rows.Count > 0)
        {
            foreach (DataRow dr in DT.Rows)
            {
                lstdt.Add(new Fixed_Price_Datatable
                {
                    Fixed_Price_Id = dr["Fixed_Price_Id"].ToString(),
                    Supplier_Name = dr["Supplier_Name"].ToString(),
                    Cus_Company_Name = dr["Cus_Company_Name"].ToString(),
                    Party_Type = dr["Party_Type"].ToString(),
                    Amount = dr["Amount"].ToString()

                });
                recordstotal = Convert.ToInt32(dr["RecCount"].ToString());
            }

        }

        var json = (new { draw = idraw, data = lstdt.ToArray(), sColumns = iscolumns, iTotalRecords = recordstotal, iTotalDisplayRecords = recordstotal });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }
    #endregion



    void Delete_Fixed_Price(int Fixed_Price_Id)
    {
        StringBuilder output = new StringBuilder();
        try
        {
            DB.Set_temp("Delete from tbl_Item_Fixed_Price where Fixed_Price_Id=" + Fixed_Price_Id);
            Log.Set_temp("tbl_Item_Fixed_Price", Fixed_Price_Id.ToString(), "Deactivate");

            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Fixed Price Detail Deleted Successfully\",\"url\":\"\"}");

        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }

        Context.Response.Write(output.ToString());

    }



    void Insert_Fixed_Price(int Item_Id, string rbParty_Type, int ddl_Party_Id, string Amount)
    {
        StringBuilder output = new StringBuilder();
        string sql_Insert = "",str_Chk="", Fixed_Price_Id = "";
        try
        {
            str_Chk = "select 1 from tbl_Item_Fixed_Price where Party_Type='" + rbParty_Type + "' and Party_Id='" + ddl_Party_Id + "'";
            if (DB.Get_ScalerInt(str_Chk) != 1)
            {
                sql_Insert = "insert into tbl_Item_Fixed_Price (Item_Id, Party_Type, Party_Id, Amount) values (" + Item_Id + ",'" + rbParty_Type + "', " + ddl_Party_Id + ",'" + Amount + "'); select @@IDENTITY";
                Fixed_Price_Id = DB.Get_Scaler(sql_Insert);
                Log.Set_temp("tbl_Item_Fixed_Price", Fixed_Price_Id, "Insert");
                output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Fixed Price Added Successfully\",\"url\":\"\"}");
            }
            else
            {
                output.Append("{\"status\":\"success\",\"action\":\"\",\"er\":\"This record already exists.\",\"url\":\"\"}");
            }
        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }
        Context.Response.Write(output.ToString());
    }



    void Update_Fixed_Price(int Fixed_Price_Id, string rbParty_Type, int ddl_Party_Id, string Amount)
    {
        StringBuilder output = new StringBuilder();
        try
        {
            DB.Set_temp("update [dbo].[tbl_Item_Fixed_Price] set Party_Type = '" + rbParty_Type + "', Party_Id = " + ddl_Party_Id +
                ", Amount= '" + Amount + "' where Fixed_Price_Id =" + Fixed_Price_Id + "");

            Log.Set_temp("tbl_Item_Fixed_Price", Fixed_Price_Id.ToString(), "Update");
            output.Append("{\"status\":\"success\",\"action\":\"\",\"message\":\"Fixed Price Details Updated Successfully\",\"url\":\"\"}");
        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }

        Context.Response.Write(output.ToString());
    }



    void Edit_Fixed_Price(Int32 Fixed_Price_Id)
    {
        StringBuilder output = new StringBuilder();
        string sql = "Select Fixed_Price_Id, Party_Type, Party_Id, Amount from tbl_Item_Fixed_Price "
            + " Where Fixed_Price_Id=" + Fixed_Price_Id;
        try
        {
            SqlDataReader DR = DB.Get_temp(sql);
            while (DR.Read())
            {
                output.Append("{\"status\":\"message\",\"action\":\"\",\"message\":\"\",\"url\":\"\",\"Fixed_Price_Res\":\"" + DR["Fixed_Price_Id"] + "|" + DR["Party_Type"] + "|" + DR["Party_Id"] + "|" + DR["Amount"] + "\"}");
            }
            DR.Close();
        }
        catch (Exception x)
        {
            output.Append("{\"status\":\"error\",\"action\":\"\",\"message\":\"" + x.Message + " - " + x.StackTrace + "\",\"url\":\"\"}");
        }
        Context.Response.Write(output.ToString());
    }



    string Segregate(string cell)
    {
        //string cell = "NSI0018068";
        Int64 row = 0; int a = getIndexofNumber(cell);
        string Numberpart = cell.Substring(a, cell.Length - a).ToString();
        row = Convert.ToInt64(Numberpart);
        string Stringpart = cell.Substring(0, a);

        return Stringpart + "|" + Numberpart;
    }

    int getIndexofNumber(string cell)
    {
        int indexofNum = -1;
        foreach (char c in cell)
        {
            indexofNum++;
            if (Char.IsDigit(c))
            {
                return indexofNum;
            }
        }
        return indexofNum;
    }


    public bool IsReusable {
        get {
            return false;
        }
    }

    #region DataBook
    public class itemDataTable
    {
        string _item_id, _type_id;

        string _subcatname, _itemcode, _description;


        public string itemid
        {
            get { return _item_id; }
            set { _item_id = value; }
        }

        public string type_id
        {
            get { return _type_id; }
            set { _type_id = value; }
        }

        public string subcatname
        {
            get { return _subcatname; }
            set { _subcatname = value; }

        }
        public string itemcode
        {
            get { return _itemcode; }
            set { _itemcode = value; }
        }
        public string description
        {
            get { return _description; }
            set { _description = value; }
        }

    }

    public class itemStockDataTable
    {
        string _Item_Min_Stock_Id, _Warehouse_Name;

        string _Min_Balance_Quantity, _ReOrder_Quantity;


        public string Item_Min_Stock_Id
        {
            get { return _Item_Min_Stock_Id; }
            set { _Item_Min_Stock_Id = value; }
        }

        public string Warehouse_Name
        {
            get { return _Warehouse_Name; }
            set { _Warehouse_Name = value; }
        }

        public string Min_Balance_Quantity
        {
            get { return _Min_Balance_Quantity; }
            set { _Min_Balance_Quantity = value; }

        }
        public string ReOrder_Quantity
        {
            get { return _ReOrder_Quantity; }
            set { _ReOrder_Quantity = value; }
        }

    }

    public class itemAttachmentDataTable
    {
        string _item_id, _Attachment_Id;

        string _Attachment_Type, _Attachment_Name, _Attachment_File;


        public string itemid
        {
            get { return _item_id; }
            set { _item_id = value; }
        }

        public string Attachment_Id
        {
            get { return _Attachment_Id; }
            set { _Attachment_Id = value; }
        }

        public string Attachment_Type
        {
            get { return _Attachment_Type; }
            set { _Attachment_Type = value; }

        }
        public string Attachment_Name
        {
            get { return _Attachment_Name; }
            set { _Attachment_Name = value; }
        }
        public string Attachment_File
        {
            get { return _Attachment_File; }
            set { _Attachment_File = value; }
        }

    }

    public class itemExternalDataTable
    {
        string _External_Detail_Id, _Supplier_Name, _Fixed_Price_Id;

        string _Cus_Company_Name, _Party_Type, _Product_Code;


        public string External_Detail_Id
        {
            get { return _External_Detail_Id; }
            set { _External_Detail_Id = value; }
        }

        public string Fixed_Price_Id
        {
            get { return _Fixed_Price_Id; }
            set { _Fixed_Price_Id = value; }
        }

        public string Supplier_Name
        {
            get { return _Supplier_Name; }
            set { _Supplier_Name = value; }
        }

        public string Cus_Company_Name
        {
            get { return _Cus_Company_Name; }
            set { _Cus_Company_Name = value; }

        }
        public string Party_Type
        {
            get { return _Party_Type; }
            set { _Party_Type = value; }
        }
        public string Product_Code
        {
            get { return _Product_Code; }
            set { _Product_Code = value; }
        }

    }



    public class Fixed_Price_Datatable
    {
        string _Supplier_Name, _Fixed_Price_Id, _Cus_Company_Name, _Party_Type, _Amount;

        public string Fixed_Price_Id
        {
            get { return _Fixed_Price_Id; }
            set { _Fixed_Price_Id = value; }
        }

        public string Supplier_Name
        {
            get { return _Supplier_Name; }
            set { _Supplier_Name = value; }
        }

        public string Cus_Company_Name
        {
            get { return _Cus_Company_Name; }
            set { _Cus_Company_Name = value; }

        }
        public string Party_Type
        {
            get { return _Party_Type; }
            set { _Party_Type = value; }
        }
        public string Amount
        {
            get { return _Amount; }
            set { _Amount = value; }
        }

    }

    #endregion

}
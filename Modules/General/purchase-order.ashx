<%@ WebHandler Language="C#" Class="Purchase_Order" %>
using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.SessionState;
using System.Collections;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.IO;
using Newtonsoft.Json;
using System.Data;
using System.Configuration;
using System.Net;
public class Purchase_Order : IHttpHandler, IRequiresSessionState
{
    HttpContext Context; Int16 DF = 0;
    int BranchId, DivisionId;
    static string EnqIDS = "-1";
    int PoID = -1;

    public void ProcessRequest(HttpContext context)
    {

        Context = context; if (!string.IsNullOrEmpty(Context.Request["fun"]))
        {
            try
            {
                if (G.HL() == true)
                {
                    DF = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[3]);
                    BranchId = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[1]);
                    DivisionId = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[2]);

                    switch (Context.Request["fun"].ToString())
                    {
                        case "BindDdlSupplier":
                            BindDdlSupplier();
                            break;
                        case "Bind_PO_No":
                            Bind_PO_No(Convert.ToInt32(context.Request.Form["SupplierId"].ToString()));
                            break;
                        case "BindPODate":
                            BindPODate();
                            break;
                        case "BindDeliveryDate":
                            BindDeliveryDate();
                            break;

                        case "BindDdlContactPerson":
                            BindDdlContactPerson(Convert.ToInt32(context.Request.Form["SupplierId"].ToString()));
                            break;

                        case "BindDdlDivision":
                            BindDdlDivision();
                            break;

                        case "BindDdlWarehouse":
                            BindDdlWarehouse();
                            break;
                        case "BindContactPersonDetails":

                            BindContactPersonDetails(Convert.ToInt32(context.Request.Form["ContactPersonId"].ToString()));
                            break;

                        case "BindDdlCurrency":
                            BindDdlCurrency();
                            break;

                        case "GetDefaultCurrenyOfSelectedSupplier":
                            GetDefaultCurrenyOfSelectedSupplier(Convert.ToInt32(context.Request.Form["SupplierId"].ToString()));
                            break;

                        case "BindDdlBuyerDetails":
                            BindDdlBuyerDetails(Convert.ToInt32(context.Request.Form["DivisionId"].ToString()));
                            break;

                        case "BindDdlShippingContact":
                            BindDdlShippingContact();
                            break;

                        case "BindDdlTermsandCondition":
                            BindDdlTermsandCondition();
                            break;
                        case "BindDdlPaymentTerms":
                            BindDdlPaymentTerms();
                            break;

                        case "Bind_Terms_and_Conditions_Description":
                            Bind_Terms_and_Conditions_Description(Convert.ToInt32(context.Request.Form["TermsandConditionsId"]));
                            break;

                        case "BindCurrencyRateConversion":
                            BindCurrencyRateConversion(Convert.ToInt32(context.Request.Form["ToCurrencyId"].ToString()));
                            break;


                        case "BindShipToLocation":
                            BindShipToLocation(Convert.ToInt32(context.Request.Form["WarehouseId"].ToString()));
                            break;


                        case "BindPopUpDdlSalesOrder":
                            BindPopUpDdlSalesOrder();
                            break;



                        case "BindSelectedSalesOrder":
                            BindSelectedSalesOrder(context.Request.Form["SalesOrderId"].ToString());
                            break;


                        case "BindBackSelectedSalesOrder":
                            BindBackSelectedSalesOrder(context.Request.Form["SalesOrderId"].ToString());
                            break;
                        case "BindMastertems":
                            BindMastertems(Convert.ToInt32(context.Request.Form["Item_Type"].ToString()), Convert.ToInt32(context.Request.Form["ItemSubCategoryid"].ToString()));
                            break;
                        case "Search_Items":
                            Search_Items(context.Request.Form["SearchString"].ToString(), Convert.ToInt32(context.Request.Form["SearchType"].ToString()));
                            break;
                        case "Show_Selected_Items_From_Item_Master":
                            Show_Selected_Items_From_Item_Master(context.Request.Form["SelectedIds"].ToString());
                            break;

                        case "Display_Items":
                            Display_Items(context.Request.Form["SalesOrderIds"].ToString(), context.Request.Form["FinalIds"].ToString());
                            break;

                        case "Display_Master_Items":
                            Display_Master_Items(context.Request.Form["FinalIds"].ToString() , Convert.ToInt32(context.Request.Form["WarehouseId"].ToString()));
                            break;

                        case "SavePurchaseOrderMetaData":
                            SavePurchaseOrderMetaData(
                            Convert.ToInt32(context.Request.Form["SupplierId"].ToString()),
                            context.Request.Form["PoNo"].ToString(),
                            Convert.ToInt32(context.Request.Form["RevisionNo"].ToString()),
                            DateTime.Parse(context.Request.Form["PoDate"].ToString()),
                            DateTime.Parse(context.Request.Form["DeliveryDate"].ToString()),
                            Convert.ToInt32(context.Request.Form["DivisionId"].ToString()),
                            context.Request.Form["QuotationReference"].ToString(),
                            context.Request.Form["DocumentName"].ToString(),
                            Convert.ToInt32(context.Request.Form["Warehouse"].ToString()),
                            Convert.ToInt32(context.Request.Form["CurrencyId"].ToString()),
                            context.Request.Form["ContactPersonDetails"].ToString(),
                            context.Request.Form["BuyerDetails"].ToString(),
                            context.Request.Form["ShippingContact"].ToString(),
                            context.Request.Form["ShippingMethod"].ToString(),
                            context.Request.Form["PaymentTerms"].ToString(),
                            context.Request.Form["ShipToLocation"].ToString(),
                            Convert.ToDecimal(context.Request.Form["TotalAmount"].ToString()),
                            Convert.ToDecimal(context.Request.Form["CurrencyConversionRate"].ToString()),
                            context.Request.Form["TermsConditions"].ToString(),
                             context.Request.Form["Remarks"].ToString(),
                              context.Request.Form["ExtraNotes"].ToString()
                            );
                            break;

                        case "SavePurchaseOrderItemDetails":
                            SavePurchaseOrderItemDetails(context.Request.Form["PurchaseOrderItems[]"]);
                            break;

                        case "UpdatePurchaseOrderMetaData":
                            UpdatePurchaseOrderMetaData(
                            Convert.ToInt32(context.Request.Form["SupplierId"].ToString()),
                            context.Request.Form["PoNo"].ToString(),
                            Convert.ToInt32(context.Request.Form["RevisionNo"].ToString()),
                            DateTime.Parse(context.Request.Form["PoDate"].ToString()),
                            DateTime.Parse(context.Request.Form["DeliveryDate"].ToString()),
                            Convert.ToInt32(context.Request.Form["DivisionId"].ToString()),
                            context.Request.Form["QuotationReference"].ToString(),
                            context.Request.Form["DocumentName"].ToString(),
                            Convert.ToInt32(context.Request.Form["Warehouse"].ToString()),
                            Convert.ToInt32(context.Request.Form["CurrencyId"].ToString()),
                            context.Request.Form["ContactPersonDetails"].ToString(),
                            context.Request.Form["BuyerDetails"].ToString(),
                            context.Request.Form["ShippingContact"].ToString(),
                            context.Request.Form["ShippingMethod"].ToString(),
                            context.Request.Form["PaymentTerms"].ToString(),
                            context.Request.Form["ShipToLocation"].ToString(),
                            Convert.ToDecimal(context.Request.Form["TotalAmount"].ToString()),
                            Convert.ToDecimal(context.Request.Form["CurrencyConversionRate"].ToString()),
                            context.Request.Form["TermsConditions"].ToString(),
                              context.Request.Form["Remarks"].ToString(),
                              context.Request.Form["ExtraNotes"].ToString(),

                            Convert.ToInt32(Context.Session["PoID"].ToString())
                            );
                            break;


                        case "UpdatePurchaseOrderMetaDataOnEditOperation":
                            UpdatePurchaseOrderMetaData(

                            Convert.ToInt32(context.Request.Form["SupplierId"].ToString()),
                            context.Request.Form["PoNo"].ToString(),
                            Convert.ToInt32(context.Request.Form["RevisionNo"].ToString()),
                            DateTime.Parse(context.Request.Form["PoDate"].ToString()),
                            DateTime.Parse(context.Request.Form["DeliveryDate"].ToString()),
                            Convert.ToInt32(context.Request.Form["DivisionId"].ToString()),
                            context.Request.Form["QuotationReference"].ToString(),
                            context.Request.Form["DocumentName"].ToString(),
                            Convert.ToInt32(context.Request.Form["Warehouse"].ToString()),
                            Convert.ToInt32(context.Request.Form["CurrencyId"].ToString()),
                            context.Request.Form["ContactPersonDetails"].ToString(),
                            context.Request.Form["BuyerDetails"].ToString(),
                            context.Request.Form["ShippingContact"].ToString(),
                            context.Request.Form["ShippingMethod"].ToString(),
                            context.Request.Form["PaymentTerms"].ToString(),
                            context.Request.Form["ShipToLocation"].ToString(),
                            Convert.ToDecimal(context.Request.Form["TotalAmount"].ToString()),
                            Convert.ToDecimal(context.Request.Form["CurrencyConversionRate"].ToString()),
                            context.Request.Form["TermsConditions"].ToString(),
                            context.Request.Form["Remarks"].ToString(),
                            context.Request.Form["ExtraNotes"].ToString(),
                            Convert.ToInt32(Context.Request.Form["PurchaseOrderId"].ToString())

                            );
                            break;


                        case "DeleteExistingPurchaseOrderItemDetails":
                            DeleteExistingPurchaseOrderItemDetails(Convert.ToInt32(Context.Session["PoID"].ToString()));
                            break;


                        case "DeleteExistingPurchaseOrderItemDetailsOnEditOperation":
                            DeleteExistingPurchaseOrderItemDetails(Convert.ToInt32(Context.Request.Form["PurchaseOrderId"].ToString()));
                            break;

                        case "UpdatePurchaseOrderItemDetails":
                            UpdatePurchaseOrderItemDetails(context.Request.Form["PurchaseOrderItems[]"]);
                            break;

                        case "DisplayPurchaseOrderList":
                            DisplayPurchaseOrderList();
                            break;
                        case "FetchSavedPurchaseOrderMetaDataForParticularSalesOrder":
                            FetchSavedPurchaseOrderMetaDataForParticularSalesOrder(Convert.ToInt32(context.Request.Form["PurchaseOrderId"].ToString()));
                            break;

                        case "FetchSavedPurchaseItemOrderDetailsForParticularSalesOrder":
                            FetchSavedPurchaseItemOrderDetailsForParticularSalesOrder(Convert.ToInt32(context.Request.Form["PurchaseOrderId"].ToString()));
                            break;

                        case "SearchPurchaseItemsList":
                            SearchPurchaseItemsList(context.Request.Form["SearchString"]);
                            break;
                        case "GetSalesOrderOfParticularPurchaseOrder":
                            GetSalesOrderOfParticularPurchaseOrder(Convert.ToInt32(context.Request.Form["PurchaseOrderId"].ToString()));
                            break;

                        case "BindPopUpDdlSalesOrderAndSelectSavedOnes":
                            BindPopUpDdlSalesOrderAndSelectSavedOnes(Convert.ToInt32(context.Request.Form["PurchaseOrderId"].ToString()));
                            break;


                        case "GetAllSavedItemIdsOfParticularPurchaseOrder":
                            GetAllSavedItemIdsOfParticularPurchaseOrder(Convert.ToInt32(context.Request.Form["PurchaseOrderId"].ToString()));
                            break;
                        case "GetPurchaseOrderMetaDataForPdf":
                            GetPurchaseOrderMetaDataForPdf(Convert.ToInt32(context.Request.Form["PurchaseOrderId"].ToString()));
                            break;

                        case "GetPurchaseOrderItemDetailsForPdf":
                            GetPurchaseOrderItemDetailsForPdf(Convert.ToInt32(context.Request.Form["PurchaseOrderId"].ToString()));
                            break;


                        case "GetPurchaseOrderItemCalulationsForPdf":
                            GetPurchaseOrderItemCalulationsForPdf(Convert.ToInt32(context.Request.Form["PurchaseOrderId"].ToString()));
                            break;

                        case "GetFileName":
                            GetFileName(Convert.ToInt32(Context.Request.Form["PurchaseOrderId"].ToString()));
                            break;

                        case "GetPurchaseOrderNo":
                            GetPurchaseOrderNo(Convert.ToInt32(Context.Request.Form["PurchaseOrderId"].ToString()));
                            break;
                        case "GetRevisionNo":
                            GetRevisionNo(Context.Request.Form["PurchaseOrderNo"].ToString());
                            break;


                        case "GetPurchaseOrderLinksOnPreviousRevisionPopUp":
                            GetPurchaseOrderLinksOnPreviousRevisionPopUp(Context.Request.Form["PurchaseOrderNo"].ToString());
                            break;

                        case "CheckUserPrivilages":
                            CheckUserPrivilages(Convert.ToInt32(context.Session["session_ids"].ToString().Split(',')[0]));
                            break;
                        case "HidePreviousRevisionsButtonIfNoPoHasBeenGenerated":
                            HidePreviousRevisionsButtonIfNoPoHasBeenGenerated(Context.Request.Form["PurchaseOrderNo"].ToString());
                            break;

                        case "AprroveParticularPurchaseOrder":
                            AprroveParticularPurchaseOrder(Convert.ToInt32(Context.Request.Form["PurchaseOrderId"].ToString()));
                            break;
                        case "CheckPurchaseOrderApprovalStatus":
                            CheckPurchaseOrderApprovalStatus(Convert.ToInt32(Context.Request.Form["PurchaseOrderId"].ToString()));
                            break;
                        case "DownloadPurchaseOrderPdf":
                            DownloadPurchaseOrderPdf(Context.Request.Form["PurchaseOrderNo"].ToString());
                            break;

                        case "BindDdlItemCategory":
                            BindDdlItemCategory(Convert.ToInt32(Context.Request.Form["ItemType"].ToString()));
                            break;

                        case "GetCurrencyCodeForPdf":
                            GetCurrencyCodeForPdf(Convert.ToInt32(Context.Request.Form["PurchaseOrderId"].ToString()));
                            break;

                        case "CheckUserAccess":
                            CheckUserAccess(Convert.ToInt32(context.Session["session_ids"].ToString().Split(',')[0]));
                            break;


                        case "BindDdlBranch":
                            BindDdlBranch();
                            break;

                        case "DisplayPurchaseOrderListByBranches":
                            DisplayPurchaseOrderListByBranches(Convert.ToInt32(context.Request.Form["BranchId"].ToString()), Convert.ToInt32(Context.Request.Form["PageNo"]));
                            break;

                        case "BindLstDdlDivisionByBranch":
                            BindLstDdlDivisionByBranch(context.Request.Form["branchId"]);
                            break;


                        case "DisplayPurchaseOrderListByDivisions":
                            DisplayPurchaseOrderListByDivisions(Convert.ToInt32(context.Request.Form["DivisionId"].ToString()), Convert.ToInt32(Context.Request.Form["PageNo"]));
                            break;

                        case "DisplayPurchaseOrderListByUserDivisions":
                            DisplayPurchaseOrderListByUserDivisions(context.Request.Form["Ids[]"], Convert.ToInt32(Context.Request.Form["PageNo"]));
                            break;
                        case "CancelPo":
                            CancelPo(Context.Request.Form["POId"].ToString(), Context.Request.Form["Reason"].ToString());
                            break;

                        case "SearchItemRecords":
                            SearchItemRecords(Convert.ToInt32(context.Request.Form["Item_Type"].ToString()), context.Request.Form["SearchString"]);
                            break;

                        case "Search_Status_Filter":
                            Search_Status_Filter(Context.Request.Form["PoStatus"],
                            Context.Request.Form["DeliveryStatus"],
                            Context.Request.Form["PoType"],
                            Context.Request.Form["branchid"],
                            Context.Request.Form["divisionid"],
                            Context.Request.Form["Searchtxt"],
                            Context.Request.Form["Id"],
                            Context.Request.Form["Operation"],
                            Convert.ToInt32(Context.Request.Form["PageNo"]),
                            Context.Request.Form["SortFilter"]

                            );
                            break;
                        case "BindAdvanceSearchFilterModalData":
                            BindAdvanceSearchFilterModalData();
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
                Raise_Error("!error!" + "\n" + x.Message + "\nError Detail\n" + x.StackTrace);
            }
        }
        Context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
    }

    void Raise_Error(string error)
    {
        error = error.Replace("\"", "");
        var json = (new { status = "success", errorMessage = error });
        var ijson = new JavaScriptSerializer().Serialize(json);
        Context.Response.Clear();
        Context.Response.ContentType = "application/json; charset=utf-8";
        Context.Response.Write(ijson);
    }


    //============================================================================================Bind DDL Supplier=======================================//
    void BindDdlSupplier()
    {
        string JSONString = string.Empty;
        string sql = "select Supplier_Id,Supplier_Name from tbl_Supplier where Status='2'";
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }
        Context.Response.Write(JSONString);
        Dt.Dispose();

    }



    //=======================================================================================Bind PO Number==============================================//


    public void Bind_PO_No(int Supplier_Id)
    {
        DataSet ds = new DataSet();
        string PoNumber = "";
        try
        {
            string sql_Get = "select a.Short_Name as Br_Short_Name, b.Supplier_Short_Name from tbl_Company_Branch a inner join tbl_Supplier b on a.Branch_Id= b.Branch_Id where b.Supplier_Id=" + Supplier_Id + ";select isnull( Max(CONVERT(int,SUBSTRING(PO_Number,len(PO_Number)-9,5))),0)+1 as PO_Id from tbl_Purchase_order ";

            //string sql_Get = "select a.Short_Name as Br_Short_Name, b.Supplier_Short_Name from tbl_Company_Branch a inner join tbl_Supplier b on a.Branch_Id= b.Branch_Id where b.Supplier_Id=" + Supplier_Id + ";select isnull((MAX(Purchase_Order_Id)),0)+1 as PO_Id from tbl_Purchase_Order ";
            ds = DB.GetDataSet(sql_Get);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string PO_id = ds.Tables[1].Rows[0]["PO_Id"].ToString();

                string Purchase_Order_No_Prefix = ds.Tables[0].Rows[0]["Br_Short_Name"].ToString() + "-" + ds.Tables[0].Rows[0]["Supplier_Short_Name"].ToString() + "-PO";

                if (PO_id.Length == 4)
                {
                    PO_id = "0" + PO_id;
                }
                else if (PO_id.Length == 3)
                {
                    PO_id = "00" + PO_id;
                }
                else if (PO_id.Length == 2)
                {
                    PO_id = "000" + PO_id;
                }
                else if (PO_id.Length == 1)
                {
                    PO_id = "0000" + PO_id;
                }

                //Create PO Number Format
                PoNumber = Purchase_Order_No_Prefix + "-" + PO_id + "-" + DateTime.Now.Year;
            }
            else
            {
                PoNumber = "0";
            }


        }
        catch (Exception x)
        {
            PoNumber = "!error!" + x.Message + "";
        }
        Context.Response.Write(PoNumber);
        ds.Dispose();

    }

    //============================================================================Bind PO Date===============================================================//

    void BindPODate()
    {
        var Date = DateTime.Now;
        string strdate = Convert.ToDateTime(Date).ToString("yyyy-MM-dd");
        Context.Response.Write(strdate);
    }


    //===================================================================Bind Delivery Date ===============================================================//


    void BindDeliveryDate()
    {
        var Date = DateTime.Now;
        Date = Date.AddDays(5); //increment 5 days
        string strdate = Convert.ToDateTime(Date).ToString("yyyy-MM-dd");
        Context.Response.Write(strdate);
    }
    //==========================================================================================Bind Contact Person=======================================//
    void BindDdlContactPerson(int SupplierId)
    {
        string JSONString = string.Empty;
        string sql = "select Person_Id , Name from Tbl_Contact_Person where Entity_Type='Supplier' and Entity_Id=" + SupplierId;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }


    //===============================================================================================Bind Division=======================================//
    void BindDdlDivision()
    {
        string JSONString = string.Empty;
        string sql = "select Division_Id,Division_Name from tbl_Company_Division where Is_Primary=1 and Branch_Id=" + BranchId;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }



    //===============================================================================================Bind Division=======================================//
    void BindDdlWarehouse()
    {
        string JSONString = string.Empty;
        string sql = "select DISTINCT(Warehouse_Id),Warehouse_Name from tbl_Warehouse";
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }
    //====================================================Bind Contact peson Details==================================================//

    void BindContactPersonDetails(int ContactPersonId)
    {
        string ContactPersonDetails = string.Empty;
        string sql = "select Name, Department,Designation,Phone_Number,Mobile,Email_Id,Fax from tbl_Contact_Person where Person_Id=" + ContactPersonId;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            ContactPersonDetails += Dt.Rows[0]["Name"].ToString() + "|";
            ContactPersonDetails += Dt.Rows[0]["Department"].ToString() + "|";
            ContactPersonDetails += Dt.Rows[0]["Designation"].ToString() + "|";
            ContactPersonDetails += Dt.Rows[0]["Phone_Number"].ToString() + "|";
            ContactPersonDetails += Dt.Rows[0]["Mobile"].ToString() + "|";
            ContactPersonDetails += Dt.Rows[0]["Email_Id"].ToString() + "|";
            ContactPersonDetails += Dt.Rows[0]["Fax"].ToString();
        }
        else
        {
            ContactPersonDetails += "No Details Found";
        }

        Context.Response.Write(ContactPersonDetails);
        Dt.Dispose();
    }


    //=========================================================================================Bind DDL Currency =======================================//
    void BindDdlCurrency()
    {
        string JSONString = string.Empty;
        string sql = "select Currency_Id, Currency_Name from tbl_Currency";
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }

    void GetDefaultCurrenyOfSelectedSupplier(int SupplierId)
    {

        string SupplierCurrencyId = string.Empty;
        string sql = "select Currency_Id from tbl_Supplier where Supplier_Id=" + SupplierId;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            SupplierCurrencyId = Dt.Rows[0]["Currency_Id"].ToString();
        }
        if(SupplierCurrencyId.ToString() =="0" )
        {
            Context.Response.Write("false");
            return;

        }

        Context.Response.Write(SupplierCurrencyId);
        Dt.Dispose();

    }


    //==========================================================================Bind Buyers Details =======================================//
    void BindDdlBuyerDetails(int DivisionId)
    {
        string JSONString = string.Empty;
        string sql = "select Employee_Id , REPLACE(Employee_Name,',',' ') as Employee_Name from tbl_Employee where Division_Id=" + DivisionId;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }

    //=========================================================================Bind Shipping Contact =======================================//
    void BindDdlShippingContact()
    {
        string JSONString = string.Empty;
        string sql = "select Employee_Id, Employee_Name from tbl_Employee where Branch_Id=" + BranchId;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }

    //=======================================================================Bind Terms and Conditions==============================================//
    void BindDdlTermsandCondition()
    {
        string JSONString = string.Empty;
        string sql = "select Terms_Conditions_Id ,Terms_Conditions_Name from tbl_Terms_Conditions where Terms_Conditions_Type='Purchase_Order'";
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }

    //==============================================Bind Payment Terms =====================//

    void BindDdlPaymentTerms()
    {
        string JSONString = string.Empty;
        string sql = "select Payment_Terms_Id, Payment_Terms ,Default_Selected from tbl_Payment_Terms where Payment_Terms_Type='PO'";
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }




    //=================================================Bind Terms and Conditions Description========================================//


    void Bind_Terms_and_Conditions_Description(int TermsandConditionsId)
    {
        string TermsAndConditions = "";
        string sql = "";
        sql = "select Terms_and_Conditions from tbl_Terms_Conditions where Terms_Conditions_Id=" + TermsandConditionsId;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {

            TermsAndConditions = Dt.Rows[0]["Terms_and_Conditions"].ToString();
        }

        Context.Response.Write(TermsAndConditions);
        Dt.Dispose();
    }



    //===================================================Bind Currency Rate Conversion==================================================//


    void BindCurrencyRateConversion(int ToCurrencyId)
    {
        string CurrencyRate = "-9";
        string CurrencyId = "";
        DataTable Dt = new DataTable();
        string sql = "";
        string sql1 = "select Currency_Id from tbl_Company_Branch where Branch_Id=" + BranchId;
        Dt = DB.GetDataTable(sql1);
        if (Dt.Rows.Count > 0)
        {
            CurrencyId = Dt.Rows[0]["Currency_Id"].ToString();

            if (CurrencyId.ToString() == ToCurrencyId.ToString()) //checking if both Currency ids Are Equal then return 1
            {
                Context.Response.Write("1");
            }
            else
            {

                sql = "select top 1 Currency_Rate_Id, Conversion_Rate from tbl_Currency_Rate where From_Currency_Id=(select Currency_Id from tbl_Company_Branch where Branch_Id=" + BranchId + ") and To_Currency_Id=" + ToCurrencyId + " order by Currency_Rate_Id desc";
                Dt = DB.GetDataTable(sql);
                if (Dt.Rows.Count > 0)
                {
                    CurrencyRate = Dt.Rows[0]["Conversion_Rate"].ToString();

                }
                else
                {
                    CurrencyRate = "0";
                }

                Context.Response.Write(CurrencyRate);

            }


        }



        Dt.Dispose();

    }




    //==================================================================Bind Shipping To Location==============================================//
    void BindShipToLocation(int WareHouseId)
    {
        string ShippingLocation = string.Empty;
        string sql = "select Warehouse_Name,Address,PO_Box, d.City, c.[State],b.Country, Zip_Code from tbl_Warehouse a "
        + " inner join tbl_Country b on a.Country =b.Country_Id "
        + " inner join tbl_State c on a.[State] = c.State_Id "
        + " inner join tbl_City d on a.City = d.City_Id where Warehouse_Id=" + WareHouseId;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            ShippingLocation = Dt.Rows[0]["Warehouse_Name"].ToString() + " |" + Dt.Rows[0]["Address"].ToString() + "|" + Dt.Rows[0]["PO_Box"].ToString() + "|" + Dt.Rows[0]["City"].ToString() + "|" + Dt.Rows[0]["State"].ToString() + "|" + Dt.Rows[0]["Country"].ToString() + "|" + Dt.Rows[0]["Zip_Code"].ToString();
        }

        Context.Response.Write(ShippingLocation);
        Dt.Dispose();
    }


    void BindPopUpDdlSalesOrder()
    {
        string JSONString = string.Empty;
        // string sql = "select Sales_Order_Id, Sales_Order_Number from tbl_Sales_Order where Sales_Order_Id in (select max(Sales_Order_Id) from  tbl_Sales_Order group by Sales_Order_Number)  order by Sales_Order_Id  DESC";
        string sql = "select distinct( a.Sales_Order_Id) as Sales_Order_Id, a.Sales_Order_Number from tbl_Sales_Order a "
                    + " left outer join tbl_sales_order_items b on a.Sales_Order_Id = b.SO_id "
                    + " left outer join tbl_item c on b.item_id = c.item_id "
                    + " where  b.Po_Status in(0,1) and c.Item_type=2  and Sales_Order_Id in (select max(Sales_Order_Id) from  tbl_Sales_Order group by Sales_Order_Number)  order by Sales_Order_Id  DESC";

        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }


    //============================================================Bind Selected Saled Order Items Details On PopUp====================================//
    void BindSelectedSalesOrder(string SalesOrderId)
    {

        if (!SalesOrderId.Equals(""))
        {
            if (SalesOrderId.Contains(","))
            {
                SalesOrderId = SalesOrderId.Remove(SalesOrderId.Length - 1);
            }
            string JSONString = string.Empty;
            string sql = "Select a.SO_Item_Id as SOItemId, a.Quantity as Ordered_Qty ,a.Po_Quantity as Purchased_Qty, a.SO_Id as SalesOrderId, c.Sales_Order_Number, a.Item_Id, a.Item_Code,a.AEGG_Description  , a.Supplier_Name,b.Manufacturer,b.OEM_Reference from tbl_Sales_Order_items a left outer join tbl_Sales_Order c on a.SO_Id =c.Sales_Order_Id left Outer join tbl_Item b on a.Item_id =b.Item_Id   where SO_Id in(" + SalesOrderId + ") and b.item_type=2 and a.Po_Status !=2 order by a.So_Id;";
            DataTable Dt = DB.GetDataTable(sql);
            if (Dt.Rows.Count > 0)
            {
                JSONString = JsonConvert.SerializeObject(Dt);
            }

            Context.Response.Write(JSONString);
            Dt.Dispose();
        }
    }




    //============================================================Bind Selected Saled Order Items Details On PopUp====================================//
    void BindBackSelectedSalesOrder(string SalesOrderId)
    {

        if (!SalesOrderId.Equals(""))
        {
            if (SalesOrderId.Contains(","))
            {
                SalesOrderId = SalesOrderId.Remove(SalesOrderId.Length - 1);
            }
            string JSONString = string.Empty;
            string sql = "Select a.SO_Item_Id as SOItemId, a.Quantity as Ordered_Qty ,a.Po_Quantity as Purchased_Qty, a.SO_Id as SalesOrderId, c.Sales_Order_Number, a.Item_Id, a.Item_Code,a.AEGG_Description  , a.Supplier_Name,b.Manufacturer,b.OEM_Reference from tbl_Sales_Order_items a left outer join tbl_Sales_Order c on a.SO_Id =c.Sales_Order_Id left Outer join tbl_Item b on a.Item_id =b.Item_Id   where SO_Id in(" + SalesOrderId + ") and b.item_type=2 order by a.So_Id;";
            DataTable Dt = DB.GetDataTable(sql);
            if (Dt.Rows.Count > 0)
            {
                JSONString = JsonConvert.SerializeObject(Dt);
            }

            Context.Response.Write(JSONString);
            Dt.Dispose();
        }
    }
    //===============================================================Bind All Master Items On Pop Up=====================================================//

    void BindMastertems(int Item_Type, int ItemSubCategoryid)
    {

        string sql = "";
        if (Item_Type == 0)
        {
            sql += "select Item_Id, Item_Code ,Item_Description,OEM_Reference,Manufacturer from tbl_Item where Cat_SubCat_Id=" + ItemSubCategoryid;

        }
        else
        {
            sql += "select top 20 Item_Id, Item_Code ,Item_Description,OEM_Reference,Manufacturer from tbl_Item where Item_Type=" + Item_Type + " and Cat_SubCat_Id=" + ItemSubCategoryid;


        }
        string JSONString = string.Empty;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }

    //=========================================================Pop Up Search Functionality====================================================//
    void Search_Items(string SearchString, int SearchType)
    {


        string sql = "";
        if (SearchType == 0)
        {
            sql = "select top 20 Item_Id ,Item_Code ,Item_Description,OEM_Reference,Manufacturer from tbl_Item where Item_Code like '%" + SearchString + "%' or Item_Description like '%" + SearchString + "%' or OEM_Reference like '%" + SearchString + "%' or Manufacturer like '%" + SearchString + "%'";

        }

        else
        {

            sql = "select top 20 Item_Id, Item_Code ,Item_Description,OEM_Reference,Manufacturer from tbl_Item where (Item_Code like '%" + SearchString + "%' or Item_Description like '%" + SearchString + "%' or OEM_Reference like '%" + SearchString + "%' or Manufacturer like '%" + SearchString + "%') and Item_Type=" + SearchType + "";
        }

        string JSONString = string.Empty;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }

    //====================================================Display Selected Master Item(s) on Main Table ==================================================//
    void Display_Master_Items(string ItemIds , int WarehouseId)
    {
        ItemIds = ItemIds.Remove(ItemIds.Length - 1);
        if (!ItemIds.Equals(""))
        {
            // b.Average_Cost Field May be Changed In Future .......
            string sql_Query = "select distinct(a.Item_Id) as Item_Id,a.Item_Code,a.Item_Description, a.Unit, '0'as Quantity , isnull(a.Rate,0.00) as Rate from tbl_Item a where Item_Id in("+ItemIds+")";
            string JSONString = string.Empty;
            DataTable Dt = DB.GetDataTable(sql_Query);

            foreach (DataRow dr in Dt.Rows)
            {
                sql_Query = "if exists (select item_id from tbl_Inventory_Item WHere Item_Id =" + dr["Item_Id"] + " and Warehouse_Id=" + WarehouseId + " ) "
                             + " select  isnull(Average_Cost,0.00) as Average_Cost from tbl_Inventory_Item where Item_Id = " + dr["Item_Id"] + " and Warehouse_Id= " + WarehouseId + "  "
                             + "else select '0.00' as Average_Cost";
                string AverageCost = (DB.Get_Scaler(sql_Query));
                dr["Rate"] = AverageCost;
                Dt.AcceptChanges();
            }

            if (Dt.Rows.Count > 0)
            {
                JSONString = JsonConvert.SerializeObject(Dt);
            }

            Context.Response.Write(JSONString);
            Dt.Dispose();
        }

    }
    //=============================================================Display Sales Order Items On Main Table====================================//
    void Display_Items(string SOids, string FinalIds)
    {

        if (!SOids.Equals("") && !FinalIds.Equals(""))
        {
            FinalIds = FinalIds.Remove(FinalIds.Length - 1);
            SOids = SOids.Remove(SOids.Length - 1);


            string sql_Query = "select SO_Id as SalesOrderId, b.Sales_Order_Number ,Item_Id,Item_Code,AEGG_Description as Item_Description, (Quantity - Po_quantity) as Quantity,Unit, Unit_Cost, ((Quantity - Po_quantity) * Unit_Cost) as Gross from tbl_Sales_Order_Items a "
            + " inner join tbl_Sales_Order b on a.SO_Id =b.Sales_Order_Id where SO_Id in(" + SOids + ") and SO_Item_Id in(" + FinalIds + ")";
            string JSONString = string.Empty;
            DataTable Dt = DB.GetDataTable(sql_Query);
            if (Dt.Rows.Count > 0)
            {
                JSONString = JsonConvert.SerializeObject(Dt);
            }

            Context.Response.Write(JSONString);
            Dt.Dispose();
        }
    }

    //=====================================================================Show User Selected Master Items On Seleted Tab==========================================//
    void Show_Selected_Items_From_Item_Master(string SelectedIds)
    {
        SelectedIds = SelectedIds.Remove(SelectedIds.Length - 1);
        string sql = "";
        sql = "select Item_Id ,Item_Code ,Item_Description,OEM_Reference,Manufacturer from tbl_Item where Item_Id in (" + SelectedIds + " ) ";
        string JSONString = string.Empty;
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }




    //==============================================================Save Purchase Order Meta Data=========================================================================//

    void SavePurchaseOrderMetaData(int SupplierId, string PoNo, int RevisionNo, DateTime PoDate, DateTime DeliveryDate, int DivisionId, string QuotationReference, string DocumentName, int WarehouseId, int CurrencyId, string ContactPersonDetails, string BuyerDetails, string ShippingContact, string ShippingMethod, string PaymentTerms, string ShipToLocation, decimal TotalAmount, decimal CurrencyConversionRate, string TermsConditions ,string Remarks , string ExtraNotes)
    {

        string sql_Query = "";
        sql_Query = "insert into tbl_Purchase_Order values ('"
        + PoNo + "',"
        + RevisionNo + ","
        + SupplierId + ",'"
        + Convert.ToDateTime(PoDate).ToString("yyyy-MM-dd") + "','"
        + Convert.ToDateTime(DeliveryDate).ToString("yyyy-MM-dd") + "','"
        + ContactPersonDetails + "', "
        + DivisionId + " , '"
        + QuotationReference + "', '"
        + DocumentName + "' ,"
        + WarehouseId + " , "
        + CurrencyId + ", '"
        + BuyerDetails + "' , '"
        + ShippingContact + "' , '"
        + ShippingMethod + "' , '"
        + ShipToLocation + "' ,'"
        + TermsConditions + "','"
        + PaymentTerms + "',"
        + TotalAmount + ", "
        + 0 + ", '','" //Po Document Generation Status Bit (0 ,1)
        + 0 + "'," //Po Status varchar (0 =new ,1 = Pending For Approval, 2=Pending Delivery)
        + 0 + "," //Po Approval Status bit (0,1)
        + 0 + ","
        + CurrencyConversionRate + ","
        + "' '" + ",'"
        +  Remarks +  "','"
        +  ExtraNotes+  "' ); select @@IDENTITY;"; // Po Delivery Status bit (0,1)

        PoID = Convert.ToInt32(DB.Get_Scaler(sql_Query));
        Context.Session["PoID"] = PoID; //
        if (PoID > 0)
        {
            Context.Response.Write(PoID);
            Log.Set_temp("tbl_purchase_order", PoID.ToString(), "Insert");
        }
        else
        {
            Context.Response.Write("Something Went Wrong");
        }


    }

    //=====================================================================Save Purchase Order Item Details===========================================================//

    void SavePurchaseOrderItemDetails(string items)
    {
        int res = -9;
        int SalesOrderId = -1;
        int NewLi = 0;
        string[] rows = items.Split('~');
        int s = rows.Length - 1;
        for (int i = 0; i < (rows.Length - 1); i++)
        {
            string Li = rows[i].Split('|')[0].ToString();
            if (Li.Contains(","))
            {
                NewLi = Convert.ToInt32(Li.Replace(",", "").ToString().Trim());
                Li = NewLi.ToString();
            }
            if (rows[i].Split('|')[1].ToString().Trim().Contains("-"))
            {
                SalesOrderId = -1;

            }
            else
            {
                SalesOrderId = Convert.ToInt32(rows[i].Split('|')[1].ToString().Trim());
            }
            int ItemId = Convert.ToInt32(rows[i].Split('|')[2].ToString().Trim());
            string ItemCode = rows[i].Split('|')[3].ToString().Trim();
            string ItemDescription = rows[i].Split('|')[4].ToString().Trim();
            int Quantity = Convert.ToInt32(rows[i].Split('|')[5].ToString().Trim());
            decimal UnitCost = decimal.Parse(rows[i].Split('|')[6].ToString().Trim());
            decimal ForeignRate = decimal.Parse(rows[i].Split('|')[7].ToString().Trim());
            decimal Gross = decimal.Parse(rows[i].Split('|')[8].ToString().Trim());
            decimal GrossForeign = decimal.Parse(rows[i].Split('|')[9].ToString().Trim());
            decimal DiscountAmount = decimal.Parse(rows[i].Split('|')[10].ToString().Trim());
            decimal ForeignDiscountAmount = decimal.Parse(rows[i].Split('|')[11].ToString().Trim());
            decimal AmountAfterDiscount = decimal.Parse(rows[i].Split('|')[12].ToString().Trim());
            decimal ForeignAmountAfterDiscount = decimal.Parse(rows[i].Split('|')[13].ToString().Trim());
            decimal VatAmount = decimal.Parse(rows[i].Split('|')[14].ToString().Trim());
            decimal ForeignVatAmount = decimal.Parse(rows[i].Split('|')[15].ToString().Trim());
            decimal Total = decimal.Parse(rows[i].Split('|')[16].ToString().Trim());
            decimal ForeignTotal = decimal.Parse(rows[i].Split('|')[17].ToString().Trim());
            string DeliveryDate = rows[i].Split('|')[18].ToString().Trim();
            int DeliveryStatus = Convert.ToInt32(rows[i].Split('|')[19].ToString().Trim());
            int RecievedQuantity = Convert.ToInt32(rows[i].Split('|')[20].ToString().Trim());
            string SourceType = rows[i].Split('|')[21].ToString().Trim();
            int SourceId = Convert.ToInt32(rows[i].Split('|')[22].ToString().Trim());


            string sql_Query = "insert into tbl_Purchase_Order_Items values ("
            + Convert.ToInt32(Context.Session["PoID"].ToString()) + ","
            + Li + ","
            + SalesOrderId + ", "
            + ItemId + ",'"
            + ItemCode + "','"
            + ItemDescription + "',"
            + Quantity + " ,"
            + UnitCost + ", "
            + ForeignRate + ","
            + Gross + ", "
            + GrossForeign + " , "
            + DiscountAmount + ", "
            + ForeignDiscountAmount + " , "
            + AmountAfterDiscount + ", "
            + ForeignAmountAfterDiscount + ","
            + VatAmount + " , "
            + ForeignVatAmount + " , "
            + Total + " , "
            + ForeignTotal + ",'"
            + Convert.ToDateTime(DeliveryDate).ToString("yyyy-MM-dd") + "',"

            + DeliveryStatus + ","
            + RecievedQuantity + ",'"
            + SourceType + "',"
            + SourceId +
            "); select @@IDENTITY;";

            res = Convert.ToInt32(DB.Get_Scaler(sql_Query));
            if (res > 0)
            {


                Log.Set_temp("tbl_Purchase_Order_Items", res.ToString(), "Insert");
                Context.Response.Write(res);
            }
            else
            {
                Context.Response.Write("Something Went Wrong");
            }



        }
        PoID = -1; //clearing static Variable

    }
    //==============================================================Update Purchase Order Meta Data=========================================================================//

    void UpdatePurchaseOrderMetaData(int SupplierId, string PoNo, int RevisionNo, DateTime PoDate, DateTime DeliveryDate, int DivisionId, string QuotationReference, string DocumentName, int WarehouseId, int CurrencyId, string ContactPersonDetails, string BuyerDetails, string ShippingContact, string ShippingMethod, string PaymentTerms, string ShipToLocation, decimal TotalAmount, decimal CurrencyConversionRate, string TermsConditions, string Remarks , string ExtraNotes, int PurchaseOrderId)
    {
        var PoID = -9;
        string sql_Query = "";


        sql_Query = " Update tbl_Purchase_Order SET " +
        "PO_Number ='" + PoNo +
        "',Rev_Number = " + RevisionNo +
        ",Supplier_Id = " + SupplierId +
        ", PO_Date ='" + Convert.ToDateTime(PoDate).ToString("yyyy-MM-dd") +

        "', Delivery_Date ='" + Convert.ToDateTime(DeliveryDate).ToString("yyyy-MM-dd") +

        "', Contact_Details ='" + ContactPersonDetails +
        "', Division_Id =" + DivisionId +
        ", Quotation_Reference ='" + QuotationReference + "'" +
        ", Reference_Document ='" + DocumentName +
        "', WareHouse_Id = " + WarehouseId +
        ", Currency_Id = " + CurrencyId + " " +
        ", Buyer_Details_Id ='" + BuyerDetails +
        "', Shipping_Contact_Id = '" + ShippingContact +
        "', Shipping_Method = '" + ShippingMethod +
        "', Shipping_Location ='" + ShipToLocation + "'" +
        ", Terms_And_Conditions = '" + TermsConditions +
        "', Payment_Terms ='" + PaymentTerms +
        "', PO_LI_Amount =" + TotalAmount +
        ",Currency_Conversion_Rate =" + CurrencyConversionRate +

        ",Remarks ='" + Remarks +
        "',Extra_Notes ='" + ExtraNotes +

        "' WHERE Purchase_Order_Id=" + PurchaseOrderId;

        PoID = Convert.ToInt32(DB.Get_ScalerInt(sql_Query));
        if (PoID > -9)
        {
            Context.Response.Write(PoID);
            Log.Set_temp("tbl_purchase_order", PurchaseOrderId.ToString(), "Update");
        }
        else
        {
            Context.Response.Write("Something Went Wrong");
        }
    }



    //====================================================================Delete Existing Purchase Order Items Details=====================================//


    void DeleteExistingPurchaseOrderItemDetails(int PurchaseOrderId)
    {

        string sqlquery = "";
        int Res = -9;
        sqlquery += "Delete From tbl_Purchase_Order_Items where Purchase_Order_Id=" + PurchaseOrderId + "";
        Res = Convert.ToInt32(DB.Get_ScalerInt(sqlquery));
        if (Res > -9)
        {

            Context.Response.Write(Res);
            // Log.Set_temp("tbl_Quotation_Items", Res.ToString(), "Update");
        }
        else
        {
            Context.Response.Write("Something Went Wrong");
        }

    }

    //=====================================================================Update Purchase Order Item Details===========================================================//

    void UpdatePurchaseOrderItemDetails(string items)
    {
        int res = -9;
        int SalesOrderId = -1;
        int NewLi = 0;

        string[] rows = items.Split('~');

        for (int i = 0; i < rows.Length - 1; i++)
        {

            string Li = rows[i].Split('|')[0].ToString();
            if (Li.Contains(","))
            {

                NewLi = Convert.ToInt32(Li.Replace(",", "").ToString().Trim());
                Li = NewLi.ToString();

            }


            if (rows[i].Split('|')[1].ToString().Trim().Contains("-"))
            {
                SalesOrderId = -1;

            }
            else
            {
                SalesOrderId = Convert.ToInt32(rows[i].Split('|')[1].ToString().Trim());


            }
            int ItemId = Convert.ToInt32(rows[i].Split('|')[2].ToString().Trim());
            string ItemCode = rows[i].Split('|')[3].ToString().Trim();
            string ItemDescription = rows[i].Split('|')[4].ToString().Trim();
            int Quantity = Convert.ToInt32(rows[i].Split('|')[5].ToString().Trim());
            decimal UnitCost = decimal.Parse(rows[i].Split('|')[6].ToString().Trim());
            decimal ForeignRate = decimal.Parse(rows[i].Split('|')[7].ToString().Trim());
            decimal Gross = decimal.Parse(rows[i].Split('|')[8].ToString().Trim());
            decimal GrossForeign = decimal.Parse(rows[i].Split('|')[9].ToString().Trim());
            decimal DiscountAmount = decimal.Parse(rows[i].Split('|')[10].ToString().Trim());
            decimal ForeignDiscountAmount = decimal.Parse(rows[i].Split('|')[11].ToString().Trim());
            decimal AmountAfterDiscount = decimal.Parse(rows[i].Split('|')[12].ToString().Trim());
            decimal ForeignAmountAfterDiscount = decimal.Parse(rows[i].Split('|')[13].ToString().Trim());
            decimal VatAmount = decimal.Parse(rows[i].Split('|')[14].ToString().Trim());
            decimal ForeignVatAmount = decimal.Parse(rows[i].Split('|')[15].ToString().Trim());
            decimal Total = decimal.Parse(rows[i].Split('|')[16].ToString().Trim());
            decimal ForeignTotal_ = decimal.Parse(rows[i].Split('|')[17].ToString().Trim());
            DateTime DeliveryDate = DateTime.Parse(rows[i].Split('|')[18].ToString().Trim());
            int DeliveryStatus = Convert.ToInt32(rows[i].Split('|')[19].ToString().Trim());
            int RecievedQuantity = 0;
            string SourceType = rows[i].Split('|')[20].ToString().Trim();
            int SourceId = Convert.ToInt32(rows[i].Split('|')[21].ToString().Trim());
            // int PurchaseOrderId = Convert.ToInt32(rows[i].Split('|')[22].ToString().Trim());

            //  if (PurchaseOrderId == 0)
            //{
            int PurchaseOrderId = Convert.ToInt32(Context.Session["PoID"].ToString());
            // }

            string sql_Query = "";

            sql_Query += "insert into tbl_Purchase_Order_Items values ("
            + PurchaseOrderId + ","
            + Li + ","
            + SalesOrderId + ", "
            + ItemId + ",'"
            + ItemCode + "','"
            + ItemDescription + "',"
            + Quantity + " ,"
            + UnitCost + ", "
            + ForeignRate + ","
            + Gross + ", "
            + GrossForeign + " , "
            + DiscountAmount + ", "
            + ForeignDiscountAmount + " , "
            + AmountAfterDiscount + ", "
            + ForeignAmountAfterDiscount + ","
            + VatAmount + " , "
            + ForeignVatAmount + " , "
            + Total + " , "
            + ForeignTotal_ + ",'" + Convert.ToDateTime(DeliveryDate).ToString("yyyy-MM-dd") + "', "
            + DeliveryStatus + ","
            + RecievedQuantity + ",'"
            + SourceType + "',"
            + SourceId +

            "); select @@IDENTITY;";

            res = Convert.ToInt32(DB.Get_ScalerInt(sql_Query));
            if (res > 0)
            {

                Context.Response.Write(res);
                Log.Set_temp("tbl_Purchase_Order_Items", res.ToString(), "Update");
            }
            else
            {
                Context.Response.Write("Something Went Wrong");
            }



        }
        PoID = -1; //clearing static Variable

    }

    //==========================================Purchase Order List===============================================//

    void DisplayPurchaseOrderList()
    {
        string JSONString = string.Empty;
        string sql = "";
        DataTable dt = new DataTable();
        //DataTable DR = new DataTable();

        sql = "select distinct(a.Purchase_Order_Id),a.Document_Generation_Status, a.PO_Number ,convert(varchar,a.Delivery_Date,103) as Delivery_Date ,convert(varchar, a.PO_Date,103) as PO_Date, a.PO_LI_Amount, Approval_Status ,PO_Status , Delivery_Status, c.Division_Name , e.Supplier_Name,e.Account_Code from tbl_Purchase_Order a inner join "
        + " (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id order by a.Purchase_Order_Id desc";
        dt = DB.GetDataTable(sql);


        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
        }

        Context.Response.Write(JSONString);
        dt.Dispose();
    }




    //===================================================================Getting Saved Purchase Order Meta Data From Data Base For Bind Back (View)==============================================//

    void FetchSavedPurchaseOrderMetaDataForParticularSalesOrder(int PurchaseOrderId)
    {
        string sqlquery = " select PO_Number,Rev_Number,Supplier_Id , convert(date,PO_Date," + DF + ") as PO_Date , convert(date,Delivery_Date," + DF + ") as Delivery_Date "
        + " ,Contact_Details ,Division_Id,Quotation_Reference ,Reference_Document ,WareHouse_Id,Currency_Id,Buyer_Details_Id "
        + " ,Shipping_Contact_Id,Shipping_Method,Shipping_Location,Terms_And_Conditions,Payment_Terms,PO_LI_Amount,Currency_Conversion_Rate , Remarks , Extra_Notes "
        + " from tbl_Purchase_Order where Purchase_Order_Id =" + PurchaseOrderId + " ";
        string JSONString = string.Empty;
        DataTable Dt = DB.GetDataTable(sqlquery);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();

    }



    //===================================================================Getting Saved Purchase Order Items Details From Data Base For Bind Back (View)==============================================//

    void FetchSavedPurchaseItemOrderDetailsForParticularSalesOrder(int PurchaseOrderId)
    {

        string sqlquery = "";

        sqlquery += "select a.* , isnull( c.Sales_Order_Number,'-')as Sales_Order_Number ,((a.Discount_Amount/a.Gross)*100) as DicountPercent , ((a.VAT_Amount/a.Amount_After_Discount)*100) as VatPercent ,b.Unit from tbl_Purchase_Order_Items a left outer join tbl_Item b on a.Item_Id=b.Item_Id "
        + " left outer join tbl_Sales_Order c on a.Sales_Order_Id= c.Sales_Order_Id "
        + " where Purchase_Order_Id=" + PurchaseOrderId + ";";
        string JSONString = string.Empty;
        DataTable Dt = DB.GetDataTable(sqlquery);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();

    }

    //===============================================================================Search Purchase Item Lis=======================================================================//

    void SearchPurchaseItemsList(string SearchString)
    {
        string sqlquery = "";

        sqlquery += "select a.Purchase_Order_Id, a.PO_Number, a.Document_Generation_Status, b.Division_Name , c.Supplier_Name ,c.Account_Code , convert(varchar,a.PO_Date,103) as PO_Date ,convert(varchar,a.Delivery_Date,103) as Delivery_Date , a.PO_LI_Amount,a.Document_Generation_Status,a.Approval_Status from tbl_Purchase_Order a "
        + " inner join tbl_Company_Division b on a.Division_Id=b.Division_Id "
        + " inner join tbl_supplier c on a.Supplier_Id= c.Supplier_Id "
        + " where a.PO_Number like '%" + SearchString + "%' or c.Supplier_Name like '%" + SearchString + "%' ";
        string JSONString = string.Empty;
        DataTable Dt = DB.GetDataTable(sqlquery);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();

    }



    void GetSalesOrderOfParticularPurchaseOrder(int PurchaseOrderId)
    {
        string JSONString = string.Empty;
        string SqlQuery = "select sales_Order_Id, Item_Id , Source_Id from tbl_Purchase_Order_items where Purchase_Order_Id=" + PurchaseOrderId + "";
        DataTable Dt = DB.GetDataTable(SqlQuery);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }
        Context.Response.Write(JSONString);

        Dt.Dispose();

    }

    void BindPopUpDdlSalesOrderAndSelectSavedOnes(int PurchaseOrderId)
    {

        string SqlQuery = "select Distinct(a.Sales_Order_Id) as Sales_Order_Id, a.Sales_Order_Number from tbl_Sales_Order a inner join tbl_Purchase_Order_items b on a.Sales_Order_Id=b.Sales_Order_Id where b.Purchase_Order_Id=" + PurchaseOrderId + "";
        DataTable Dt = DB.GetDataTable(SqlQuery);
        string JSONString = string.Empty;

        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();


    }




    //============================================================================Get saved Item id For bInding Back against particular Purchase Order=====================================//


    void GetAllSavedItemIdsOfParticularPurchaseOrder(int PurchaseOrderId)
    {
        string SqlQuery = "select Item_Id from tbl_Purchase_Order_Items where Purchase_Order_Id in ( " + PurchaseOrderId + ")";
        DataTable Dt = DB.GetDataTable(SqlQuery);
        string JSONString = string.Empty;

        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);

        Dt.Dispose();

    }

    //==============================================================Get Purchase Order MetaData Details For Pdf ==============================================================//

    void GetPurchaseOrderMetaDataForPdf(int PurchaseOrderId)
    {
        string approvedby, preparedby;
        string JSONString = string.Empty;
        int employeeId = Convert.ToInt16(Context.Session["session_ids"].ToString().Split(',')[0]);
        string SqlQuery = "select b.Supplier_Name,a.Contact_Details ,a.Shipping_Location , (ISNULL(e.Employee_Name,'N/A') +'|'+ ISNULL(e.Mobile_Number,'N/A')+'|'+ISNULL(e.Email,'N/A')) as Shipping_Contact, (ISNULL( f.Employee_Name,'N/A') +'|'+ ISNULL(f.Mobile_Number,'N/A')+'|'+ISNULL(f.Email,'N/A')) as Buyer_Details, "
        + " PO_Number, a.Rev_Number, convert(date,a.PO_Date,103) as PO_Date, a.Quotation_Reference , a.Terms_And_Conditions, c.Currency_Name ,g.Payment_Terms, convert(date,a.Delivery_Date,103) as Delivery_Date , "
        + " a.Terms_And_Conditions , a.Extra_Notes ,d.Employee_Name from tbl_Purchase_Order a "
        + " left outer join tbl_Supplier b on a.Supplier_Id=b.Supplier_Id "
        + " left outer join tbl_Currency c on a.Currency_Id = c.Currency_Id "
        + " left Outer join tbl_Employee d on d.Employee_Id = " + employeeId + " "
        + " left outer join tbl_Employee e on e.Employee_Id = a.Shipping_Contact_Id "
        + " left outer join tbl_Employee f on f.Employee_Id = a.Buyer_Details_Id "
        + " left outer join tbl_Payment_Terms g on a.Payment_Terms= g.Payment_Terms_Id "
         + "where a.Purchase_Order_Id =" + PurchaseOrderId;

        SqlQuery += " select top 1 * , REPLACE(b.Employee_Name,',',' ' ) as PreparedBy from tbl_Log a "
                    + " left outer join tbl_Employee b on a.Operation_By = b.Employee_Id "
                      + " where Table_Name='tbl_purchase_order'  and Operation_Type in('insert','update') and Table_Row_Id =" + PurchaseOrderId + " ";

        SqlQuery += "select top 1 a.* , REPLACE(b.Employee_Name,',',' ' ) as ApprovedBy  from tbl_Log a "
                   + " left outer join tbl_Employee b on a.Operation_By = b.Employee_Id "
                     + " where Table_Name='tbl_purchase_order'  and Operation_Type ='Approve' and Table_Row_Id =" + PurchaseOrderId + " ";

        DataSet ds = DB.GetDataSet(SqlQuery);
        DataTable PdfMetadata = ds.Tables[0];
        DataTable PreparedBy = ds.Tables[1];
        if(PreparedBy.Rows.Count>0)
        {
            preparedby = PreparedBy.Rows[0]["PreparedBy"].ToString();
        }
        else
        {
            preparedby = "N/A";
        }
        DataTable PdfApprovedBy = ds.Tables[2];
        if(PdfApprovedBy.Rows.Count>0)
        {
            approvedby = PdfApprovedBy.Rows[0]["ApprovedBy"].ToString();
        }
        else
        {
            approvedby = "N/A";
        }

        JSONString = JsonConvert.SerializeObject(PdfMetadata);
        JSONString += "~" + preparedby + "~" + approvedby +"~";
        Context.Response.Write(JSONString);
        ds.Dispose();

    }


    //==============================================================Get Purchase Order Item Details For Pdf ==============================================================//

    void GetPurchaseOrderItemDetailsForPdf(int PurchaseOrderId)
    {
        string SqlQuery = "select a.Line_Item_Number,a.Item_Code , b.Manufacturer,b.OEM_Reference,b.Unit, a.Item_Description,a.Quantity,a.Unit_Cost_In_Foreign_Currency,a.Discount_Amount_In_Foreign_Currency,Vat_Amount_In_Foreign_Currency, Total_Amount_In_Foreign_Currency from tbl_Purchase_Order_Items a "
        + " inner join tbl_item b on a.Item_Id = b.Item_Id "
        + " where Purchase_Order_Id =" + PurchaseOrderId + "order by a.Line_Item_Number";
        DataTable Dt = DB.GetDataTable(SqlQuery);
        string JSONString = string.Empty;
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();

    }



    //==============================================================Calculations For Pdf ==============================================================//

    void GetPurchaseOrderItemCalulationsForPdf(int PurchaseOrderId)
    {
        string SqlQuery = "select sum(Gross_in_foreign_currency) as Gross_in_foreign_currency , sum(Discount_Amount_In_Foreign_Currency) as Discount_Amount_In_Foreign_Currency , sum(Total_Amount_In_Foreign_Currency) as Total_Amount_In_Foreign_Currency , sum(Vat_Amount_In_Foreign_Currency) as Vat_Amount_In_Foreign_Currency from tbl_Purchase_Order_Items "
        + " where Purchase_Order_Id =" + PurchaseOrderId;
        DataTable Dt = DB.GetDataTable(SqlQuery);
        string JSONString = string.Empty;
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();

    }



    //===========================================================Get PurchaseOrder No for Revisions====================================================================//

    void GetPurchaseOrderNo(int PO_Id)
    {

        string Sql = "select PO_Number from tbl_Purchase_Order where Purchase_Order_Id =" + PO_Id;
        string PurchaseOrderNo = DB.Get_Scaler(Sql);
        Context.Response.Write(PurchaseOrderNo);


    }



    //============================================================Get Purchase Order File Name ======================================================================//

    void GetFileName(int PO_Id)
    {
        string FileName = "";
        string Sql1 = "";

        string sql = "select PO_Number as [FileName] from tbl_Purchase_Order where Purchase_Order_Id =" + PO_Id;
        Sql1 = "select Rev_Number from tbl_Purchase_Order where Purchase_Order_Id=" + PO_Id;
        string Res = DB.Get_Scaler(sql);
        int RevisionNO = DB.Get_ScalerInt(Sql1);
        // RevisionNO = RevisionNO + 1;

        FileName = Res + "_" + RevisionNO;
        Context.Response.Write(FileName + "|" + PO_Id.ToString());



    }



    //===============================================================Get Revision No=============================================================================================//

    void GetRevisionNo(string PurchaseOrderNo)
    {

        string Sql = "select top 1 max(Rev_Number) as Rev_Number from tbl_Purchase_Order where PO_Number='" + PurchaseOrderNo + "' order by Rev_Number desc";
        int RevisionNo = DB.Get_ScalerInt(Sql);
        RevisionNo = RevisionNo + 1;

        Context.Response.Write(RevisionNo);

    }


    //======================================================================Get Purchase Order Links===========================================================================//

    void GetPurchaseOrderLinksOnPreviousRevisionPopUp(string PurchaseOrderNo)
    {
        string baseurl = ConfigurationManager.AppSettings["Base_Url"].ToString();
        string Sql = "select PO_Document from tbl_Purchase_Order where Document_Generation_Status =1 and PO_Number = '" + PurchaseOrderNo + "' ";
        DataTable Dt = DB.GetDataTable(Sql);
        string Links = string.Empty;
        if (Dt.Rows.Count > 0)
        {
            Links = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(Links);
        Dt.Dispose();

    }

    //=================================================================check user Privilages================================================//

    void CheckUserPrivilages(int UserId)
    {
        string PrivalegeAccess = "-9";
        string Sql = "select distinct d.access_level_name from tbl_access_modules a, tbl_access_screens b, tbl_access_operations c, tbl_access_levels d, tbl_access_privileges e"
        + " where a.module_id =b.module_id and b.screen_id=c.screen_id and c.operation_id=d.operation_id and "
        + " d.access_level_id=e.access_level_id and a.module_name='Purchase' and b.screen_name='Purchase Order List' "
        + " and c.operation_name='Approve' and e.role_id in (select role_id from tbl_employee_division_mapping where employee_id=" + UserId + ");select @@IDENTITY;";
        DataTable Dt = DB.GetDataTable(Sql);
        if (Dt.Rows.Count > 0)
        {
            PrivalegeAccess = "true";
        }
        else
        {
            PrivalegeAccess = "false";

        }
        Context.Response.Write(PrivalegeAccess);
        Dt.Dispose();


    }
    //============================================================hide Previous Revision buttons=======================================//

    void HidePreviousRevisionsButtonIfNoPoHasBeenGenerated(string PurchaseOrderNo)
    {

        bool IsPdfGenerated = false;
        string Sql = "select Document_Generation_Status from tbl_purchase_order where PO_Number ='" + PurchaseOrderNo + "'";

        DataTable Dt = DB.GetDataTable(Sql);
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dt in Dt.Rows)
            {
                string res = dt["Document_Generation_Status"].ToString().ToUpper();
                if (res == "TRUE")
                {

                    IsPdfGenerated = true;
                }

            }
        }
        Context.Response.Write(IsPdfGenerated);
        Dt.Dispose();

    }


    //===============================Check ifPoShouldBeApprovedorNot================//

    bool check(int purchaseOrderid)
    {
        bool flag = false;
        string sql = "select a.Source_Id as So_Item_Id , a.Source_Type, a.Quantity as Purchased_Qunatity ,  b.Po_Quantity as SoPoQuantity , b.SO_Item_Id, b.Quantity as Ordered_Qunatity    from tbl_Purchase_Order_Items a "
                      + " inner join tbl_Sales_Order_Items b on a.Source_Id = b.SO_Item_Id "
                      +" where a.Purchase_Order_Id = "+purchaseOrderid+"  order by Source_Id asc";
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {

            foreach (DataRow dr in Dt.Rows)
            {
                if (dr["Source_Type"].ToString().Trim() == "SO")
                {
                    if (Convert.ToInt32(dr["Purchased_Qunatity"]) <= (Convert.ToInt32(dr["Ordered_Qunatity"]) ))
                        flag = true;
                    else
                        flag = false;
                }
                else
                {
                    flag = true;
                }
            }

        }
        else
        {
            flag = true;
        }
        return flag;
    }



    //=================================Approve Particular Purchase Order==========================//

    void AprroveParticularPurchaseOrder(int PurchaseOrderId)
    {
        if (check(PurchaseOrderId))
        {
            int res = -9;
            string Sql = "update tbl_Purchase_Order set Approval_Status=1 , PO_Status=1 where Purchase_Order_Id=" + PurchaseOrderId;
            res = DB.Get_ScalerInt(Sql);
            if (res > -9)
            {
                Log.Set_temp("tbl_purchase_order", PurchaseOrderId.ToString(), "Approve");
                Context.Response.Write(1);


            }
            else
            {
                Context.Response.Write(-9);
            }
        }
        else
        {
            Context.Response.Write("false");
        }

    }


    //=====================================================check Purchase Order Approval Status==========================================//

    void CheckPurchaseOrderApprovalStatus(int PurchaseOrderId)
    {
        DataTable Dt;
        string Sql = "Select Approval_Status , Document_Generation_Status from tbl_Purchase_Order where Purchase_Order_Id=" + PurchaseOrderId;
        Dt = DB.GetDataTable(Sql);
        if (Dt.Rows.Count > 0)
        {
            if (Dt.Rows[0]["Approval_Status"].ToString() == "True" && Dt.Rows[0]["Document_Generation_Status"].ToString() == "False")
            {
                Context.Response.Write(true);
            }
            else
            {
                Context.Response.Write(false);
            }
        }
        Dt.Dispose();


    }

    //========================================================================Download Direct Latest Pdf in List Page======================//

    void DownloadPurchaseOrderPdf(string PurchaseOrderNo)
    {
        string res = "-9";
        string Sql = "select top 1 PO_Document from tbl_Purchase_Order where PO_Number='" + PurchaseOrderNo + "' order by PO_Document desc";
        res = DB.Get_Scaler(Sql);
        if (!res.Equals(""))
        {
            string DownloadUrl = G.B + "Modules/Purchase_Order";
            DownloadUrl += res;

            Context.Response.Write(DownloadUrl);
        }

    }


    //===============================================================Bind PopUp DDl Item Category=======================================================//

    void BindDdlItemCategory(int ItemType)
    {
        DataTable Dt;
        string ItemCategory = string.Empty;
        string sql;
        if (ItemType == 0)
        {
            sql = "select distinct(b.[Item_SubCategory_Id]) as Item_SubCategory_Id, a.[Item_Category_Name]+ ' >> ' + b.[Item_SubCategory_Name] as Cat_SubCat from [tbl_Item_Category] a inner join [tbl_Item_SubCategory] b on a.[Item_Category_Id]=b.[Item_Category_Id] order by Cat_SubCat asc";
        }
        else
        {
            sql = "select distinct(b.[Item_SubCategory_Id]) as Item_SubCategory_Id, a.[Item_Category_Name]+ ' >> ' + b.[Item_SubCategory_Name] as Cat_SubCat from [tbl_Item_Category] a inner join [tbl_Item_SubCategory] b on a.[Item_Category_Id]=b.[Item_Category_Id] where a.Item_Type=" + ItemType + " order by Cat_SubCat asc";
        }
        Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            ItemCategory = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(ItemCategory);
        Dt.Dispose();

    }



    //========================================//Get Currency Code for Po Pdf Amounts============================================================//


    void GetCurrencyCodeForPdf(int PurchaseOrderId)
    {

        string sql = "select Currency_Code from [tbl_Currency] where currency_id in(select currency_id from tbl_Purchase_Order where Purchase_Order_Id= " + PurchaseOrderId + ")";

        Context.Response.Write(DB.Get_Scaler(sql).ToString());

    }


    // ===========================================check User Access Privilages In List Page===============================================//

    void CheckUserAccess(int UserId)
    {
        string PrivalegeAccess = "";
        string DivisionIds = "";
        string AccessDetails = "false";
        string AccessEdit = "false";
        string AccessCancel = "false";
        string Sql = "select a.division_id, c.access_level_name ,d.Operation_Name from tbl_Employee_Division_Mapping a "
        + " inner join tbl_Access_Privileges b on a.role_id=b.Role_Id "
        + "inner join tbl_Access_Levels c on b.Access_Level_Id=c.Access_Level_Id "
        + "inner join tbl_access_operations d on c.Operation_Id=d.Operation_Id "
        + "inner join tbl_Access_Screens e on d.Screen_Id = e.Screen_Id "
        + "inner join tbl_Access_Modules f on e.Module_Id=f.Module_Id where f.module_name='Purchase' and e.screen_name='Purchase Order List' and d.Operation_Name ='view' and a.Employee_Id=" + UserId + ";"


        + " select a.division_id, c.access_level_name ,d.Operation_Name from tbl_Employee_Division_Mapping a "
        + " inner join tbl_Access_Privileges b on a.role_id=b.Role_Id "
        + "inner join tbl_Access_Levels c on b.Access_Level_Id=c.Access_Level_Id "
        + "inner join tbl_access_operations d on c.Operation_Id=d.Operation_Id "
        + "inner join tbl_Access_Screens e on d.Screen_Id = e.Screen_Id "
        + "inner join tbl_Access_Modules f on e.Module_Id=f.Module_Id where f.module_name='Purchase' and e.screen_name='Purchase Order List' and d.Operation_Name ='Add' and a.Employee_Id=" + UserId + ";"

        + " select a.division_id, c.access_level_name ,d.Operation_Name from tbl_Employee_Division_Mapping a "
        + " inner join tbl_Access_Privileges b on a.role_id=b.Role_Id "
        + "inner join tbl_Access_Levels c on b.Access_Level_Id=c.Access_Level_Id "
        + "inner join tbl_access_operations d on c.Operation_Id=d.Operation_Id "
        + "inner join tbl_Access_Screens e on d.Screen_Id = e.Screen_Id "
        + "inner join tbl_Access_Modules f on e.Module_Id=f.Module_Id where f.module_name='Purchase' and e.screen_name='Purchase Order List' and d.Operation_Name ='Edit' and a.Employee_Id=" + UserId + ";"

        + " select a.division_id, c.access_level_name ,d.Operation_Name from tbl_Employee_Division_Mapping a "
        + " inner join tbl_Access_Privileges b on a.role_id=b.Role_Id "
        + "inner join tbl_Access_Levels c on b.Access_Level_Id=c.Access_Level_Id "
        + "inner join tbl_access_operations d on c.Operation_Id=d.Operation_Id "
        + "inner join tbl_Access_Screens e on d.Screen_Id = e.Screen_Id "
        + "inner join tbl_Access_Modules f on e.Module_Id=f.Module_Id where f.module_name='Purchase' and e.screen_name='Purchase Order List' and d.Operation_Name ='Cancel' and a.Employee_Id=" + UserId;

        DataSet Ds = DB.GetDataSet(Sql);
        DataTable Dt = Ds.Tables[0];
        DataTable Dt1 = Ds.Tables[1];
        DataTable Dt2 = Ds.Tables[2];
        DataTable Dt3 = Ds.Tables[3];
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow item in Dt.Rows)
            {
                DivisionIds += item[0].ToString() + "|";
                PrivalegeAccess += item[1].ToString() + "|";

            }

        }
        else
        {
            PrivalegeAccess = "false";

        }
        if (Dt1.Rows.Count > 0)
        {
            AccessDetails = "True";
        }

        if (Dt2.Rows.Count > 0)
        {
            AccessEdit = "True";
        }

        if (Dt3.Rows.Count > 0)
        {
            AccessCancel = "True";
        }

        Context.Response.Write(PrivalegeAccess + "~" + DivisionIds + "~" + AccessDetails + "~" + AccessEdit + "~" + AccessCancel);
        Dt.Dispose();
    }


    //========================================================Bind DDl Branch on list Page====================================================//

    void BindDdlBranch()
    {

        DataTable Dt = new DataTable();
        string Sql = " select Branch_Id,Branch_Name from tbl_Company_Branch order by Branch_Name";
        Dt = DB.GetDataTable(Sql);
        string JSONString = string.Empty;
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }
        JSONString += "|" + BranchId;
        Context.Response.Write(JSONString);
        Dt.Dispose();

    }



    //===============================================Display Po List By Branches============================================//

    void DisplayPurchaseOrderListByBranches(int BranchId, int Page_No)
    {
        int TotalRecords = 0, from = 1, to = 20; if (Page_No == 0) { Page_No = 1; };
        // StringBuilder output = new StringBuilder();
        from = (((Page_No * 20) - 20) + 1); to = Page_No * 20;
        if (BranchId == 0)
        {
            DisplayPurchaseOrderList();
        }
        else
        {
            string JSONString = string.Empty;
            string sql = "";
            DataTable dt = new DataTable();

            sql += " with newtable as (select distinct(a.Purchase_Order_Id), ROW_NUMBER() OVER (ORDER BY a.Purchase_Order_Id desc) AS RowNumber,a.Document_Generation_Status, a.PO_Number ,convert(varchar,a.Delivery_Date,103) as Delivery_Date ,convert(varchar, a.PO_Date,103) as PO_Date, a.PO_LI_Amount, Approval_Status ,PO_Status , Delivery_Status, c.Division_Name , e.Supplier_Name,e.Account_Code from tbl_Purchase_Order a  join (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id where C.Branch_Id= " + BranchId + ") "
            + " Select * from newtable WHERE RowNumber Between '" + from + "' AND '" + to + "' order by Purchase_Order_Id desc "
            + " select count (distinct(a.Purchase_Order_Id)) from tbl_Purchase_Order a left outer join "
            + " (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id where C.Branch_Id=" + BranchId + ";";

            DataSet Ds = DB.GetDataSet(sql);
            dt = Ds.Tables[0];
            TotalRecords = int.Parse(Ds.Tables[1].Rows[0][0].ToString());

            if (dt.Rows.Count > 0)
            {
                JSONString = JsonConvert.SerializeObject(dt);
            }


            JSONString += "|";
            string str_Pagging = "", Paging_Strip = Pagination.PG(TotalRecords, Page_No,20);

            if (TotalRecords > 1)
            {
                str_Pagging = "<div class='dataTables_info ' id='#' role='status' aria-live='polite'>Showing " + from + " to " +
                to + " of " + TotalRecords + " entries</div>"
                + "<div class='dataTables_paginate paging_simple_numbers right' id='#_paginate'>"
                + "<ul class='pagination'>"
                + Paging_Strip
                + "</ul></div></div>";
            }
            JSONString += str_Pagging;
            Context.Response.Write(JSONString);
        }


    }



    //=====================================================Display PO Based On user Division ===============================================//
    void BindLstDdlDivisionByBranch(string SeletedBranchId)
    {

        string JSONString = string.Empty;
        string sql = "select Division_Id, Division_Name from tbl_Company_Division where Branch_Id=" + SeletedBranchId + ";";
        DataTable dt = DB.GetDataTable(sql);

        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
        }

        Context.Response.Write(JSONString);

    }


    //===================================================================Display Po List By Divisions=================================================//

    void DisplayPurchaseOrderListByDivisions(int DivisionId, int Page_No)
    {
        int TotalRecords = 0, from = 1, to = 20; if (Page_No == 0) { Page_No = 1; };
        // StringBuilder output = new StringBuilder();
        from = (((Page_No * 20) - 20) + 1); to = Page_No * 20;

        string JSONString = string.Empty;
        string sql = "";
        DataTable dt = new DataTable();
        if (DivisionId != -1)
        {
            sql += " with newtable as (select distinct(a.Purchase_Order_Id), ROW_NUMBER() OVER (ORDER BY a.Purchase_Order_Id desc) AS RowNumber,a.Document_Generation_Status, a.PO_Number ,convert(varchar,a.Delivery_Date,103) as Delivery_Date ,convert(varchar, a.PO_Date,103) as PO_Date, a.PO_LI_Amount, Approval_Status ,PO_Status , Delivery_Status, c.Division_Name , e.Supplier_Name,e.Account_Code from tbl_Purchase_Order a  join (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id where C.Branch_Id= " + BranchId + ") "
            + " Select * from newtable WHERE RowNumber Between '" + from + "' AND '" + to + "' order by Purchase_Order_Id desc "
            + " select count (distinct(a.Purchase_Order_Id)) from tbl_Purchase_Order a left outer join "
            + " (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id where C.Division_Id=" + DivisionId + ";";
        }
        else
        {
            sql += " with newtable as (select distinct(a.Purchase_Order_Id), ROW_NUMBER() OVER (ORDER BY a.Purchase_Order_Id desc) AS RowNumber,a.Document_Generation_Status, a.PO_Number ,convert(varchar,a.Delivery_Date,103) as Delivery_Date ,convert(varchar, a.PO_Date,103) as PO_Date, a.PO_LI_Amount, Approval_Status ,PO_Status , Delivery_Status, c.Division_Name , e.Supplier_Name,e.Account_Code from tbl_Purchase_Order a  join (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id where C.Branch_Id= " + BranchId + ") "
           + " Select * from newtable WHERE RowNumber Between '" + from + "' AND '" + to + "' order by Purchase_Order_Id desc "
           + " select count (distinct(a.Purchase_Order_Id)) from tbl_Purchase_Order a left outer join "
           + " (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id;";
        }
        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
        }

        DataSet Ds = DB.GetDataSet(sql);
        dt = Ds.Tables[0];
        TotalRecords = int.Parse(Ds.Tables[1].Rows[0][0].ToString());

        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
        }


        JSONString += "|";
        string str_Pagging = "", Paging_Strip = Pagination.PG(TotalRecords, Page_No,20);

        if (TotalRecords > 1)
        {
            str_Pagging = "<div class='dataTables_info ' id='#' role='status' aria-live='polite'>Showing " + from + " to " +
            to + " of " + TotalRecords + " entries</div>"
            + "<div class='dataTables_paginate paging_simple_numbers right' id='#_paginate'>"
            + "<ul class='pagination'>"
            + Paging_Strip
            + "</ul></div></div>";
        }
        JSONString += str_Pagging;
        Context.Response.Write(JSONString);
    }


    //=====================================================Display Po Based On user Division ===============================================//
    void DisplayPurchaseOrderListByUserDivisions(string DivisionIds, int Page_No)
    {
        int TotalRecords = 0, from = 1, to = 20; if (Page_No == 0) { Page_No = 1; };
        // StringBuilder output = new StringBuilder();
        from = (((Page_No * 20) - 20) + 1); to = Page_No * 20;
        DivisionIds = DivisionIds.Remove(DivisionIds.Length - 1);
        string JSONString = string.Empty;
        string sql = "";
        DataTable dt = new DataTable();
        sql += " with newtable as (select distinct(a.Purchase_Order_Id), ROW_NUMBER() OVER (ORDER BY a.Purchase_Order_Id desc) AS RowNumber,a.Document_Generation_Status, a.PO_Number ,convert(varchar,a.Delivery_Date,103) as Delivery_Date ,convert(varchar, a.PO_Date,103) as PO_Date, a.PO_LI_Amount, Approval_Status ,PO_Status , Delivery_Status, c.Division_Name , e.Supplier_Name,e.Account_Code from tbl_Purchase_Order a  join (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id where C.Branch_Id= " + BranchId + ") "
        + " Select * from newtable WHERE RowNumber Between '" + from + "' AND '" + to + "' order by Purchase_Order_Id desc "
        + " select count (distinct(a.Purchase_Order_Id)) from tbl_Purchase_Order a left outer join "
        + " (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id where c.Division_Id in( " + DivisionIds + ");";

        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
        }

        DataSet Ds = DB.GetDataSet(sql);
        dt = Ds.Tables[0];
        TotalRecords = int.Parse(Ds.Tables[1].Rows[0][0].ToString());

        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
        }


        JSONString += "|";
        string str_Pagging = "", Paging_Strip = Pagination.PG(TotalRecords, Page_No,20);

        if (TotalRecords > 1)
        {
            str_Pagging = "<div class='dataTables_info ' id='#' role='status' aria-live='polite'>Showing " + from + " to " +
            to + " of " + TotalRecords + " entries</div>"
            + "<div class='dataTables_paginate paging_simple_numbers right' id='#_paginate'>"
            + "<ul class='pagination'>"
            + Paging_Strip
            + "</ul></div></div>";
        }
        JSONString += str_Pagging;
        Context.Response.Write(JSONString);

    }



    //============================================================Cancel Purchase order========================================//

    void CancelPo(string PO_Id, string Reason)
    {
        int res = -9;

           string sql = "select Quantity  as PreviousPurchasedQty, Source_Id as So_Item_Id    from tbl_Purchase_Order_Items  where Purchase_Order_Id ="+PO_Id+";";
           DataTable dt = DB.GetDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    sql = "update tbl_Sales_Order_Items Set Po_Quantity= Po_Quantity -  " + dr["PreviousPurchasedQty"] + "  where So_Item_id =" + dr["So_Item_Id"] + " ;";
                    res = DB.Get_ScalerInt(sql);
                    sql = "Select convert(varchar, Quantity) + '|' + convert(varchar, Po_Quantity)   from tbl_sales_Order_items where So_item_id  =  " + dr["So_Item_Id"] + " ;";
                    var response=  DB.Get_Scaler(sql);
                    var OrderedQty = response.Split('|')[0].ToString();
                    var  PurchasedQty = response.Split('|')[1].ToString();



                     if (Convert.ToInt32(PurchasedQty) > 0 && Convert.ToInt32(PurchasedQty) < Convert.ToInt32(OrderedQty))
                    {

                        sql = "Update tbl_Sales_Order_Items set Po_Status =1 where  So_Item_Id = " + dr["So_Item_Id"] + "; ";
                        res = DB.Get_ScalerInt(sql);
                    }
                    else if (Convert.ToInt32(PurchasedQty) == Convert.ToInt32(OrderedQty))
                    {
                        sql = "Update tbl_Sales_Order_Items set Po_Status =2 where  So_Item_Id = " + dr["So_Item_Id"] + "; ";
                        res = DB.Get_ScalerInt(sql);
                    }
                    else
                    {
                        sql = "Update tbl_Sales_Order_Items set Po_Status =0 where  So_Item_Id = " + dr["So_Item_Id"] + "; ";
                        res = DB.Get_ScalerInt(sql);
                    }


            }


            }


            sql = "select a.Warehouse_Id, b.Quantity,b.Item_Id from tbl_Purchase_Order a inner join tbl_Purchase_Order_Items b on a.Purchase_Order_Id=b.Purchase_Order_Id where a.Purchase_Order_Id=" + PO_Id;
            dt = DB.GetDataTable(sql);
            foreach (DataRow dr in dt.Rows)
            {
                sql = "update tbl_Inventory_Item set Expected_PO_Quantity = Expected_PO_Quantity-" + dr["Quantity"] + " where Item_Id=" + dr["Item_Id"] + " and Warehouse_Id=" + dr["Warehouse_Id"];
                SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["Con"]);
                if (con.State == ConnectionState.Open) { con.Close(); } else { con.Open(); }
                SqlCommand command = new SqlCommand(sql, con);
                res = command.ExecuteNonQuery();
            }

            if (res > 0)
            {
                string Sql = "Update tbl_Purchase_Order Set Delivery_Status=3,PO_Status=5, Cancel_Reason='" + Reason + "' where Purchase_Order_Id=" + PO_Id;
                string ret = DB.Get_ScalerInt(Sql).ToString();
                Context.Response.Write(ret);
            }

    }

    //===============================Independent Search Without Category==========================================//

    void SearchItemRecords(int Item_Type, string SearchString)
    {
        string sql = "";
        if (Item_Type == 0)
        {
            sql += "select a.Item_Id, b.Item_SubCategory_Name, a.Item_Code ,a.Item_Description, isnull(a.OEM_Reference,'N/A') as OEM_Reference ,isnull( a.Manufacturer,'N/A') as Manufacturer from tbl_Item a "
            + " left outer join tbl_Item_SubCategory b on a.Cat_SubCat_Id=b.Item_SubCategory_Id where b.Item_SubCategory_Name like '%" + SearchString + "%' or a.Item_Code like '%" + SearchString + "%' or a.Item_Description like '%" + SearchString + "%' or a.OEM_Reference like '%" + SearchString + "%' or a.Manufacturer like '%" + SearchString + "%' ";

        }
        else
        {
            sql += "select a.Item_Id, b.Item_SubCategory_Name, a.Item_Code ,a.Item_Description, isnull(a.OEM_Reference,'N/A') as OEM_Reference ,isnull( a.Manufacturer,'N/A') as Manufacturer from tbl_Item a "
            + " left outer join tbl_Item_SubCategory b on a.Cat_SubCat_Id=b.Item_SubCategory_Id where (b.Item_SubCategory_Name like '%" + SearchString + "%' or a.Item_Code like '%" + SearchString + "%' or a.Item_Description like '%" + SearchString + "%' or a.OEM_Reference like '%" + SearchString + "%' or a.Manufacturer like '%" + SearchString + "%' ) and a.Item_Type=" + Item_Type + " ";


        }
        string JSONString = "-9";
        DataTable Dt = DB.GetDataTable(sql);
        if (Dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(Dt);
        }

        Context.Response.Write(JSONString);
        Dt.Dispose();
    }



    //==================================Search Filter Functionality (all Filters)===========================================//

    void Search_Status_Filter(string PoStatus, string DeliveryStatus, string PoType, string _BranchId, string _DivisionId, string Search, string ID, string operation, int Page_No , string SortFilter)

    {
        int TotalRecords = 0, from = 1, to = 20; if (Page_No == 0) { Page_No = 1; };
        // StringBuilder output = new StringBuilder();

        from = (((Page_No * 20) - 20) + 1); to = Page_No * 20;
        string _POFILTER = "";
        string _POTYPEFILTER = "";
        string _BRANCHFILTER = "";
        string _DIVISIONFILTER = "";
        string _SEARCHFILTER = "";
        string _ADVANCESEARCHFILTER = "";
        DataTable dt = new DataTable();
        string sql = "";


        //===========================Po Status Filter=====================================//
        string[] _Postatus = PoStatus.Split('|');
        if (!PoStatus.Equals(""))
        {
            _POFILTER = "AND ( ";
            for (int i = 0; i < _Postatus.Length - 1; i++)
            {
                _POFILTER += "" + _Postatus[i].ToString().Trim() + " OR ";

            }
            _POFILTER = _POFILTER.Substring(0, _POFILTER.Length - 3);
            _POFILTER += ")";
        }

        //===========================Po Type Filter=====================================//


        if (_POFILTER.Equals("") /*&& _DELIVERYFILTER.Equals("")*/)
        {
            string[] _PoType = PoType.Split('|');
            if (!PoType.Equals(""))
            {
                _POTYPEFILTER = "AND( ";
                for (int i = 0; i < _PoType.Length - 1; i++)
                {
                    _POTYPEFILTER += " e.Supplier_Type = " + _PoType[i].ToString().Trim() + " OR ";

                }
                _POTYPEFILTER = _POTYPEFILTER.Substring(0, _POTYPEFILTER.Length - 3);
                _POTYPEFILTER += ")";
            }

        }
        else
        {
            string[] _PoType = PoType.Split('|');
            if (!PoType.Equals(""))
            {
                _POTYPEFILTER = " AND ((";
                for (int i = 0; i < _PoType.Length - 1; i++)
                {
                    _POTYPEFILTER += " e.Supplier_Type = " + _PoType[i].ToString().Trim() + " OR ";

                }
                _POTYPEFILTER = _POTYPEFILTER.Substring(0, _POTYPEFILTER.Length - 3);
                _POTYPEFILTER += "))";
            }

        }


        //===========================Po BRANCH Filter=====================================//


        if (int.Parse(_BranchId.ToString()) > 0)
        {
            _BRANCHFILTER = " AND c.Branch_Id=" + _BranchId + " ";

        }
        else
        {
            _BRANCHFILTER = " AND c.Branch_Id=" + BranchId + " ";


        }

        //===========================Po Division Filter=====================================//

        if (_DivisionId.ToString().Equals("-1") || _DivisionId.ToString().Equals(""))
        {
            //_DIVISIONFILTER = " AND c.Division_Id=" + _DivisionId + " ";
            _DIVISIONFILTER = "";
        }
        else
        {
            _DIVISIONFILTER = " AND c.Division_Id=" + _DivisionId + " ";

        }
        //===========================Po Search Filter=====================================//
        if (!Search.Equals(""))
        {
            _SEARCHFILTER = "AND (a.PO_Number like '%" + Search + "%' or e.Supplier_Name like '%" + Search + "%' )";


        }
        //================================Advanced Search Filter============================================//

        if (operation.Trim().Equals("SO"))
        {
            if (int.Parse(ID.ToString()) > 0)
            {

                string POIDs = "";

                sql += " select purchase_order_id from tbl_Purchase_Order where Purchase_Order_Id in (select Purchase_Order_Id from tbl_Purchase_Order_Items where source_type='SO' and Source_Id in (select SO_Item_Id from tbl_Sales_Order_Items where SO_Id = " + ID + "))";
                dt = DB.GetDataTable(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    POIDs += dr["purchase_order_id"].ToString() + ",";
                }
                if (!POIDs.Equals("")) { POIDs = POIDs.Substring(0, POIDs.Length - 1); }
                _ADVANCESEARCHFILTER = "AND a.Purchase_Order_Id in(" + POIDs + " )";

            }
        }
        else if (operation.Trim().Equals("MRN"))
        {
            string POIDs = "";
            sql += "select purchase_order_id from tbl_Purchase_Order where Purchase_Order_Id in (select Purchase_Order_Id from tbl_Material_Receipt where MRN_Id=" + ID + " );";
            dt = DB.GetDataTable(sql);
            foreach (DataRow dr in dt.Rows)
            {
                POIDs += dr["purchase_order_id"].ToString() + ",";
            }
            if (!POIDs.Equals("")) { POIDs = POIDs.Substring(0, POIDs.Length - 1); }
            _ADVANCESEARCHFILTER = "AND a.Purchase_Order_Id in(" + POIDs + " )";

        }
        else if (operation.Trim().Equals("DD"))
        {
            if (ID.Contains("|"))
            {
                ID = ID.Substring(0, ID.Length - 1);
                string FromDate = ID.Substring(0, ID.IndexOf("-"));
                string ToDate = ID.Substring(ID.IndexOf("-") + 1);
                //=============Get Formated Date============================

                string fday = FromDate.Substring(3, 2);
                string fMonth = FromDate.Substring(0, 2);
                string fyear = FromDate.Substring(6);
                string newFdate = fyear.Trim() + "-" + fMonth.Trim() + "-" + fday.Trim();
                string Tday = ToDate.Substring(4, 2);
                string TMonth = ToDate.Substring(1, 2);
                string Tyear = ToDate.Substring(7);
                string newTdate = Tyear.Trim() + "-" + TMonth.Trim() + "-" + Tday.Trim();
                ID = "Between '" + newFdate + "' And '" + newTdate + "'";

                string POIDs = "";
                sql = "select distinct Purchase_Order_Id from tbl_Purchase_Order_Items where Delivery_Date " + ID + " and Purchase_Order_Id in (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number)";
                dt = DB.GetDataTable(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    POIDs += dr["Purchase_Order_Id"].ToString() + ",";
                }
                if (!POIDs.Equals(""))
                {
                    POIDs = POIDs.Substring(0, POIDs.Length - 1);
                    _ADVANCESEARCHFILTER = " And a.Purchase_Order_Id in (" + POIDs + ")";
                }
                else
                {

                    _ADVANCESEARCHFILTER = " And a.Sales_Order_Id in (0)";
                }



            }
            else
            {
                string POIDs = "";
                sql = "select distinct Purchase_Order_Id from tbl_Purchase_Order_Items where Delivery_Date " + ID + " and Purchase_Order_Id in (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number)";
                dt = DB.GetDataTable(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    POIDs += dr["Purchase_Order_Id"].ToString() + ",";
                }
                if (!POIDs.Equals(""))
                {
                    POIDs = POIDs.Substring(0, POIDs.Length - 1);
                    _ADVANCESEARCHFILTER = " And a.Purchase_Order_Id in (" + POIDs + ")";
                }
                else
                {

                    _ADVANCESEARCHFILTER = " And a.Sales_Order_Id in (0)";
                }
            }


        }
        string JSONString = string.Empty;
        string NewSort = "";
        if (SortFilter.Contains("a."))
        {
            NewSort = SortFilter.Remove(SortFilter.IndexOf("a."), 2);
        }
        else { NewSort = SortFilter; }
        //dt = new DataTable();
        sql = " with newtable as (select distinct(a.Purchase_Order_Id)  ,ROW_NUMBER() OVER ("+SortFilter+") AS RowNumber,a.Document_Generation_Status, a.PO_Number ,convert(varchar,a.Delivery_Date,103) as Delivery_Date ,convert(varchar, a.PO_Date,103) as PO_Date, a.PO_LI_Amount, a.Approval_Status ,PO_Status , a.Delivery_Status, c.Division_Name , c.Branch_Id, e.Supplier_Name,e.Account_Code ,e.Supplier_Type from tbl_Purchase_Order a  join "
        + " (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id where 1=1 " + _BRANCHFILTER + _POFILTER + _POTYPEFILTER + _DIVISIONFILTER + _SEARCHFILTER + _ADVANCESEARCHFILTER + ")" +
        " Select * from newtable WHERE RowNumber Between " + from + " AND " + to + " "+NewSort+" ;" +
        " Select count (distinct(a.Purchase_Order_Id)) from tbl_Purchase_Order a left outer join "
        + " (select max(Purchase_Order_Id) as Purchase_Order_Id from tbl_Purchase_Order group by PO_Number) g on a.purchase_order_id=g.purchase_order_id left outer join tbl_Company_Division c on a.Division_Id=c.Division_Id left outer join tbl_supplier e on a.Supplier_Id =e.Supplier_Id where 1=1 " + _BRANCHFILTER + _POFILTER + _POTYPEFILTER + _DIVISIONFILTER + _SEARCHFILTER + _ADVANCESEARCHFILTER;
        //dt = DB.GetDataTable(sql);
        DataSet Ds = DB.GetDataSet(sql);
        dt = Ds.Tables[0];
        TotalRecords = int.Parse(Ds.Tables[1].Rows[0][0].ToString());
        if (dt.Rows.Count > 0)
        {
            JSONString = JsonConvert.SerializeObject(dt);
        }
        else
        {
            JSONString = "-9";

        }
        JSONString += "|";
        string str_Pagging = "", Paging_Strip = Pagination.PG(TotalRecords, Page_No,20);

        if (TotalRecords > 1)
        {
            str_Pagging = "<div class='dataTables_info ' id='#' role='status' aria-live='polite'>Showing " + from + " to " +
            to + " of " + TotalRecords + " entries</div>"
            + "<div class='dataTables_paginate paging_simple_numbers right' id='#_paginate'>"
            + "<ul class='pagination'>"
            + Paging_Strip
            + "</ul></div></div>";
        }
        JSONString += str_Pagging;
        Context.Response.Write(JSONString);
        dt.Dispose();
    }



    //=============================================Bind SO In Advanced Search Filter Modal=======================================================//

    void BindAdvanceSearchFilterModalData()
    {
        string JSONString = string.Empty;
        DataSet ds = new DataSet();
        string sql = "select sales_order_number, Sales_Order_Id from tbl_Sales_Order where Sales_Order_Id in (select sales_order_id from tbl_Sales_Order_Items where SO_Item_Id in (select Source_Id as SO_Item_Id from tbl_Purchase_Order_Items where source_type='SO')) and sales_order_id in (select max(sales_order_id) from tbl_sales_order group by Sales_Order_Number);" +
        "select MRN_No, MRN_Id from tbl_Material_Receipt ";
        ds = DB.GetDataSet(sql);
        if (ds.Tables.Count > 1)
        {
            JSONString = JsonConvert.SerializeObject(ds.Tables[0]);
        }
        JSONString = JSONString + "|";
        if (ds.Tables.Count > 1)
        {
            JSONString += JsonConvert.SerializeObject(ds.Tables[1]);
        }
        else
        {
            JSONString = "-9";

        }

        Context.Response.Write(JSONString);
        ds.Dispose();


    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
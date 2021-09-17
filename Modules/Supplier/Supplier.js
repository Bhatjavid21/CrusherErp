$(document).ready(function () {
    //    $('#table_supplier_list').DataTable({
    //		'paging'      : false,"pageLength": 100,'lengthChange': false,'searching':false,'ordering':false,'info':false,'autoWidth':false } );

    //	$('#dtcontact').DataTable( {
    //		'paging'      : false,"pageLength": 10,'lengthChange': true,'searching':false,'ordering':true,'info':true,'autoWidth':false } );
    //	
    //	$('#dtaddress').DataTable( {
    //		'paging'      : false,"pageLength": 10,'lengthChange': true,'searching':false,'ordering':true,'info':true,'autoWidth':false } );
    //	
    //	$('#dtdoc').DataTable( {
    //		'paging'      : false,"pageLength": 10,'lengthChange': true,'searching':false,'ordering':true,'info':true,'autoWidth':false } );
    //    

    $("#chk_subaccount").on('click', function () {
        $('#chk_subaccount').is(':checked') ? $("#dp-account").removeClass("hide") : $("#dp-account").addClass("hide");
    });

    $("#chk_credit").on('click', function () {
        $('#chk_credit').is(':checked') ? $("#dp-credit").removeClass("hide") : $("#dp-credit").addClass("hide");
    });

    $("#chk_blacklisted").on('click', function () {
        $('#chk_blacklisted').is(':checked') ? $("#dp-blacklist").removeClass("hide") : $("#dp-blacklist").addClass("hide");
    });

    $("#btn-contact-add").on('click', function () {
        $('#rwcontact-add').slideDown();
        $("#rwcontact-add").removeClass("hide");
        $("#rwcontact-add").addClass("mt-20");
        $("#rwplus").addClass("hide");
    });

    $("#btn-contact-close").on('click', function () {
        $('#rwcontact-add').slideUp();
        $("#rwcontact-add").addClass("hide");
        $("#rwplus").removeClass("hide");
    });

    $("#btn-contact-save").on('click', function () {
        calltoast("Contact saved successfully.", "success");
        $('#rwcontact-add').slideUp();
        $("#rwplus").removeClass("hide");

    });

    //Address functions goes here.
    $("#btn-address-add").on('click', function () {
        $('#rwaddress-add').slideDown();
        $("#rwaddress-add").removeClass("hide");
        $("#rwaddress-add").addClass("mt-20");
        $("#rwaddplus").addClass("hide");
    });

    $("#btn-address-close").on('click', function () {
        $('#rwaddress-add').slideUp();
        $("#rwaddress-add").addClass("hide");
        $("#rwaddplus").removeClass("hide");
    });

    $("#btn-address-save").on('click', function () {
        calltoast("Address saved successfully.", "success");
        $('#rwaddress-add').slideUp();
        $("#rwaddplus").removeClass("hide");
    });

    //Documents functions goes here. 
    $("#btn-doc-add").on('click', function () {
        $('#rwdoc-add').slideDown();
        $("#rwdoc-add").removeClass("hide");
        $("#rwdoc-add").addClass("mt-20");
        $("#rwdocplus").addClass("hide");
    });

    $("#btn-doc-close").on('click', function () {
        $('#rwdoc-add').slideUp();
        $("#rwdoc-add").addClass("hide");
        $("#rwdocplus").removeClass("hide");
    });

    $("#btn-doc-save").on('click', function () {
        calltoast("Documents saved successfully.", "success");
        $('#rwdoc-add').slideUp();
        $("#rwdocplus").removeClass("hide");
    });

    //Scope functions goes here. 
    $("#btn_Scope_Add").on('click', function () {
        $('#rwScopeAdd').slideDown();
        $("#rwScopeAdd").removeClass("hide");
        $("#rwScopeAdd").addClass("mt-0");
        $("#rwScopePlus").addClass("hide");
    });

    $("#btn_Scope_Close").on('click', function () {
        $('#rwScopeAdd').slideUp();
        $("#rwScopeAdd").addClass("hide");
        $("#rwScopePlus").removeClass("hide");
    });

    $(".nav-link").on('click', function () {
        Make_ReadOnly("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");
        cname = $("#Hid_SupplierMain").val();
        if (cname == "" || cname == 0) {
            calltoast("Tab is blocked, Fill General Details first.", "info");
            ($(this).hasClass("active")) ? "" : $(".nav-tabs li a").addClass("disabled");
        }
        else {
            $(".nav-tabs li a").removeClass("disabled");
        }
    });

    $(".plusicon").on('click', function () {

        Make_ReadOnly("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");

        // alert("");
    });

    $(".select2").select2();

    Make_ReadOnly("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");

    $("input").keyup(function () {
        Make_ReadWrite("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");

        //cname = $("#Hid_SupplierMain").val();

        //if (cname != "" & cname != 0) {
        //    Make_ReadOnly("btn_Save_Continue_GenCus");
        //}
    });

    $(".form-control").on('change', function () {
        Make_ReadWrite("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");

        //cname = $("#Hid_SupplierMain").val();
        //if (cname != "" & cname != 0) {
        //    Make_ReadOnly("btn_Save_Continue_GenCus");
        //}
    });

    //allow only 2 digits after decimal
    $(document).on("input", ".isDecimalNumber", function () {
        var regExp = new RegExp('(\\.[\\d]{2}).', 'g')
        this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1').replace(regExp, '$1');
    });
});

function calltoast(msg, msgtype) { $.toast({ heading: '', text: msg, position: 'top-right', loaderBg: '#ff6849', icon: msgtype, hideAfter: 3000, stack: 6 }); }

//=====================================================================> Function Calls & Variables==================================

var pth = "H_tbl_Supplier.ashx?", r, lnk; Status = "0";

//var SortByField = "order by a.supplier_id desc, a.Supplier_Name asc";
var SortByField = "order by a.Supplier_Name asc";

filter("div_all", 0); // this function calls view also

//================================================================================================> View ==============================

function pageNo(pno) {
    SetVal("hid_page", pno);
    View(0);
    //General_call("View", 0);
}

function View(r) {

    SetInnerVal("tbody_Supplier_List", "<tr><td style='text-align: center;' colspan='7'>Loading..</td></tr>");
    //pageNo("0");

    lnk = pth + 'fun=View&Status=' + Status + '&branch_id=' + getVal("DDL_Branch") + '&searchTerm=' + escape(getVal("txtinput")) + '&RO=' + getVal("hid_readOnly") + '&SortBy=' + escape(SortByField) + '&Limit=' + escape(getVal("ddl_limit")) + '&Page_No=' + $("#hid_page").val();

    var xhReq = new XMLHttpRequest(); xhReq.open('GET', lnk, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {//
        if (xhReq.readyState == 4) {
            r = xhReq.responseText;

            if (Chk_Res(r) == false) {

                if (r.indexOf("accounts_dept_has_accounts_info_tab_access_only") > -1) {
                    SetVal("hid_accounts_access", "1"); tabAccInfo();
                }
                else {
                    SetVal("hid_accounts_access", "0"); tabAccInfo();
                }

                r = r.replace("accounts_dept_has_accounts_info_tab_access_only", "");

                SetInnerVal("tbody_Supplier_List", r.split("~")[0]);
                SetInnerVal("Div_Paging", r.split("~")[1]);

                tabAccInfo();

                Make_ReadWrite("txt_Supplier_Name,txt_Supplier_Short_Name,txt_sup_company_branch,txt_email,txt_phone_number,txt_fax,txt_website,DDL_Get_Approver")
                Make_ReadWrite("txt_Opening_Balance,ddl_Opening_Balance_Type,chk_subaccount,DDL_Get_Parent_Account,txt_cr_number,txt_vat_number,ddl_currency_id,txt_bank_name,txt_bank_branch_name,txt_account_holder_name,txt_account_number,chk_credit,txt_credit_days,txt_credit_amount,txt_iban_number,txt_swift_code,chk_blacklisted,txt_blacklisted_reason")

                //$("#cp_tab_lnk").addClass("disabled");
                //$("#address_tab_lnk").addClass("disabled");
                //$("#account_info_tab_lnk").addClass("disabled");
                //$("#doc_tab_lnk").addClass("disabled");
            }
        }
    }
}

function exe(tab) {

    if (tab == "gen") {
        if (ValidateSpace0("Hid_SupplierMain") == "0") {
            bigSave = 1; Insert_Update_General(1, 1);
        }
        else {
            bigSave = 1; Insert_Update_General(1, 2);
        }
    }
    else if (tab == "gen_Stay") {
        if (ValidateSpace0("Hid_SupplierMain") == "0") {
            bigSave = 2;
            Insert_Update_General(1, 1);
        }
        else {
            bigSave = 2;
            Insert_Update_General(1, 2);
        }
    }
    else if (tab == "bigGen") {
        if (ValidateSpace0("Hid_SupplierMain") == "0") {
            bigSave = 3;
            Insert_Update_General(1, 1);
        }
        else {
            bigSave = 3;
            Insert_Update_General(1, 2);
        }
    }
    else if (tab == "contact_person") {
        if (ValidateSpace0("hid_Contact_Person") == "0") {
            Insert_Contact_Person(0);
        }
        else {
            Update_Contact_Person(0);
        }
    }
    else if (tab == "address") {
        if (ValidateSpace0("hid_External_Party_Address") == "0") {
            Insert_External_Party_Address(0);
        }
        else {
            Update_External_Party_Address(0);
        }
    }
    else if (tab == "doc") {
        if (getVal("hid_Doc") == "0") {
            Insert_Doc(0);
        }
        else {
            Update_Doc(0);
        }
    }
}

//        //================================================================================================> Insert

function Insert_Update_General(isBtnClick, type) {

    SetInnerVal("myModalLabel", getVal("txt_Supplier_Name"));

    //1 means Local supplier
    var supplierType = "1";
    if ($("#div_Overseas").hasClass("checked")) {
        //2 means Overseas supplier
        supplierType = "2";
    }

    var supplier_id = getVal("Hid_SupplierMain");

    var txt_Supplier_Name = getVal("txt_Supplier_Name");
    var txt_Supplier_Short_Name = getVal("txt_Supplier_Short_Name");

    var txt_sup_company_branch = getVal("txt_sup_company_branch");
    var txt_email = getVal("txt_email");
    var txt_phone_number = getVal("txt_phone_number");
    var txt_fax = getVal("txt_fax");
    var txt_website = getVal("txt_website");

    var ddl_approver_id = getVal("DDL_Get_Approver");

    if (setBorderColor_Validation("txt_Supplier_Name,txt_Supplier_Short_Name,txt_email,DDL_Get_Approver") == 0) {
        if (isBtnClick == 1) { calltoast('Please Provide the Mandatory Information', 'error'); return false; }
    }
    else if (Validate_Email("txt_email") == false) { return false; }
    else {
        var para = "", res = "";

        if (type == 1) {
            lnk = pth + 'fun=Insert_General&Branch_Id=' + escape(getVal("hdf_branch_id")) + '&txt_Supplier_Name=' + escape(txt_Supplier_Name) + '&txt_Supplier_Short_Name=' + escape(txt_Supplier_Short_Name) + '&txt_sup_company_branch=' + escape(txt_sup_company_branch) + '&txt_email=' + escape(txt_email) + '&txt_phone_number=' + escape(txt_phone_number) + '&txt_fax=' + escape(txt_fax) + '&txt_website=' + escape(txt_website) + '&ddl_approver_id=' + escape(ddl_approver_id) + '&supplier_Type=' + supplierType + '';
        }
        else if (type == 2) {
            if (supplier_id.length < 1 || supplier_id == "" || supplier_id == 0) {
                calltoast('Supplier Id is missing', 'error');
            }
            else {
                lnk = pth + 'fun=Update_General&supplier_id=' + supplier_id + '&txt_Supplier_Name=' + escape(txt_Supplier_Name) + '&txt_Supplier_Short_Name=' + escape(txt_Supplier_Short_Name) + '&txt_sup_company_branch=' + escape(txt_sup_company_branch) + '&txt_email=' + escape(txt_email) + '&txt_phone_number=' + escape(txt_phone_number) + '&txt_fax=' + escape(txt_fax) + '&txt_website=' + escape(txt_website) + '&&ddl_approver_id=' + escape(ddl_approver_id) + '&supplier_Type=' + supplierType + '';
            }
        }

        if (lnk != "") {
            var xhReq = new XMLHttpRequest(); xhReq.open('GET', lnk, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
                if (xhReq.readyState == 4) {
                    r = xhReq.responseText;
                    if (Chk_Res(r) == false) {

                        if (r == "name") {
                            calltoast("Supplier name already exist", 'error');
                        }
                        else {
                            if (type == 1) {
                                calltoast("The Data has been Saved Successfully.", 'success');
                                SetVal("Hid_SupplierMain", r);
                            }
                            else if (type == 2) {
                                calltoast("The Data has been Updated Successfully.", 'success');
                                SetVal("Hid_SupplierMain", r);
                            }
                            else {
                                calltoast("The Operation Failed For Insert/Update of General Tab", "error");
                            }

                            View(0);

                            Generate_Account_Code();

                            if (bigSave == 1) {
                                getObj("btn_Cancel_sup_Gen").click();
                            }
                            if (bigSave == 2) {
                                //stay on this tab and dont do anything, we have to handle this case, if we dont handle this case, then their is an else part in this that will close a popup
                            }
                            else if (bigSave == 3) {
                                $("#cperson").addClass("active");
                                $("#cp_tab_lnk").addClass("active");
                                $("#cp_tab_lnk").removeClass("disabled");

                                $("#general").removeClass("active");
                                $("#gen_tab_lnk").removeClass("active");
                                $("#gen_tab_lnk").removeClass("disabled");

                                $("#addresses").removeClass("active");
                                $("#address_tab_lnk").removeClass("active");
                                $("#address_tab_lnk").removeClass("disabled");

                                $("#account").removeClass("active");
                                $("#account_info_tab_lnk").removeClass("active");
                                $("#account_info_tab_lnk").removeClass("disabled");

                                $("#documents").removeClass("active");
                                $("#doc_tab_lnk").removeClass("active");
                                $("#doc_tab_lnk").removeClass("disabled");

                                $("#Items").removeClass("active");
                                $("#items_tab_link").removeClass("active");
                                $("#items_tab_link").removeClass("disabled");
                            }
                            else { bigSave = 0; getObj("btn_Cancel_sup_Gen").click(); }
                        }
                    }
                }
            }
        }
        else {
            alert("Problem in Insertion or Updation of General Tab");
        }
    }
}

var bigSave = 0;
function GoGenSave() {
    bigSave = 1; Insert_Update_General(1, 1);  //View_Contact_Person(0);
}

//    //1.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Edit>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function GoForEdit(Supplier_id) {

    //Always start from first popup screen even last time closed on any screen shd not again open on that.
    // alert(Supplier_id);
    // alert(getVal("Hid_SupplierMain"));

    //        $("#general").addClass("active show");
    //        $("#gen_tab_lnk").addClass("active");


    //        $("#cperson").removeClass("active show");
    //        $("#cp_tab_lnk").removeClass("active");

    //        $("#addresses").removeClass("active show");
    //        $("#address_tab_lnk").removeClass("active");

    //        $("#documents").removeClass("active show");
    //        $("#account_info_tab_lnk").removeClass("active");

    //        $("#account").removeClass("active show");
    //        $("#doc_tab_lnk").removeClass("active");

    Make_ReadOnly("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");

    $("#general").addClass("active show");
    $("#gen_tab_lnk").addClass("active");

    $("#cperson").removeClass("active show");
    $("#cp_tab_lnk").removeClass("active disabled");

    $("#addresses").removeClass("active show");
    $("#address_tab_lnk").removeClass("active disabled");

    $("#documents").removeClass("active show");
    $("#account_info_tab_lnk").removeClass("active disabled");

    $("#account").removeClass("active show");
    $("#doc_tab_lnk").removeClass("active disabled");

    $("#Items").removeClass("active show");
    $("#items_tab_link").removeClass("active disabled");

    ClearFields_General();
    ClearFields_AccountInfo();

    SetVal("hid_IsEdit", "1");

    if (Supplier_id.indexOf("details") == -1)//edit
    {
        Make_ReadWrite("txt_Supplier_Name,txt_Supplier_Short_Name,txt_sup_company_branch,txt_email,txt_phone_number,txt_fax,txt_website,DDL_Get_Approver")
        Make_ReadWrite("txt_account_code,txt_Opening_Balance,ddl_Opening_Balance_Type,chk_subaccount,DDL_Get_Parent_Account,txt_cr_number,txt_vat_number,ddl_currency_id,txt_bank_name,txt_bank_branch_name,txt_account_holder_name,txt_account_number,chk_credit,txt_credit_days,txt_credit_amount,txt_iban_number,txt_swift_code,chk_blacklisted,txt_blacklisted_reason")

        SetVal("Hid_SupplierMain", Supplier_id);

        //Edit_SupplierInfo(0);

        SetVal("hid_readOnly", "0")
        Make_ReadWrite("txt_Supplier_Name,txt_Supplier_Short_Name,txt_sup_company_branch,txt_email,txt_phone_number,txt_fax,txt_website,DDL_Get_Approver")
        $("#div_Local").removeClass("rbtDisabled");
        $("#div_Overseas").removeClass("rbtDisabled");

        Make_ReadWrite("txt_account_code,txt_Opening_Balance,ddl_Opening_Balance_Type,chk_subaccount,DDL_Get_Parent_Account,txt_cr_number,txt_vat_number,ddl_currency_id,txt_bank_name,txt_bank_branch_name,txt_account_holder_name,txt_account_number,chk_credit,txt_credit_days,txt_credit_amount,txt_iban_number,txt_swift_code,chk_blacklisted,txt_blacklisted_reason")
        Make_ReadWrite("ddl_ItemSubCategory,txt_Item_Des");
        $("#div_Stock").removeClass("disabled");
        $("#div_Non_Stock").removeClass("disabled");
    }
    else {
        var IdAndDet = Supplier_id.split(',')

        Supplier_id = IdAndDet[0]

        SetVal("Hid_SupplierMain", Supplier_id);

        SetVal("hid_readOnly", "1")
        Make_ReadOnly("txt_Supplier_Name,txt_Supplier_Short_Name,txt_sup_company_branch,txt_email,txt_phone_number,txt_fax,txt_website,DDL_Get_Approver");//chk_blacklisted,
        $("#div_Local").addClass("rbtDisabled");
        $("#div_Overseas").addClass("rbtDisabled");

        Make_ReadOnly("txt_account_code,txt_Opening_Balance,ddl_Opening_Balance_Type,chk_subaccount,DDL_Get_Parent_Account,txt_cr_number,txt_vat_number,ddl_currency_id,txt_bank_name,txt_bank_branch_name,txt_account_holder_name,txt_account_number,chk_credit,txt_credit_days,txt_credit_amount,txt_iban_number,txt_swift_code,chk_blacklisted,txt_blacklisted_reason")
        Make_ReadOnly("ddl_ItemSubCategory,txt_Item_Des");
        $("#div_Stock").addClass("disabled");
        $("#div_Non_Stock").addClass("disabled");
    }
    Generate_Account_Code();
    lnk = pth + 'fun=Edit_SupplierInfo&supplier_id=' + getVal("Hid_SupplierMain");

    var xhReq = new XMLHttpRequest(); xhReq.open('GET', lnk, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
        if (xhReq.readyState == 4) {
            r = xhReq.responseText;
            if (Chk_Res(r) == false) {

                //toHide("btn_Save_Continue_GenCus");

                var dt = r.split("|");

                SetVal("txt_Supplier_Name", dt[0]);
                SetVal("txt_Supplier_Short_Name", dt[1]);
                SetVal("txt_sup_company_branch", dt[2]);
                SetVal("txt_email", dt[3]);
                SetVal("txt_phone_number", dt[4]);
                SetVal("txt_fax", dt[5]);
                SetVal("txt_website", dt[6]);


                SetInnerVal("div_DL_Get_Approver", dt[7]);

                if (getVal("hid_readOnly") == "1") {
                    Make_ReadOnly("DDL_Get_Approver");
                }

                SetVal("hid_Ledger_Account_Id", dt[8]);
                //SetVal("txt_account_code", dt[8]);

                SetInnerVal("div_DDL_Get_Parent_Account", dt[9]);


                getObj("chk_subaccount").checked = false;

                if (getVal("DDL_Get_Parent_Account") != 0) {
                    getObj("chk_subaccount").checked = true;

                    $("#dp-account").removeClass("hide"); //$("#dp-account").addClass("hide")
                }
                else {
                    $("#dp-account").addClass("hide");
                }

                SetVal("txt_cr_number", dt[10]);
                SetVal("txt_vat_number", dt[11]);
                SetInnerVal("div_Get_DDL_Currency", dt[12]);
                SetVal("txt_bank_name", dt[13]);
                SetVal("txt_bank_branch_name", dt[14]);
                SetVal("txt_account_holder_name", dt[15]);
                SetVal("txt_account_number", dt[16]);

                getObj("chk_credit").checked = false;

                if (dt[17] == "1" || dt[17] == '"1"' || dt[17] == "True") {
                    getObj("chk_credit").checked = true;

                    $("#dp-credit").removeClass("hide");

                    SetVal("txt_credit_days", dt[18]);
                    SetVal("txt_credit_amount", dt[19]);
                }
                else {
                    $("#dp-credit").addClass("hide");
                }

                SetVal("txt_iban_number", dt[20]);
                SetVal("txt_swift_code", dt[21]);

                getObj("Status").checked = false;


                SetVal("hid_Status", dt[22]);

                if (dt[22] == "2" || dt[22] == "4")//only blacklist those who are confirmed customers and already blacklisted
                {
                    toShow("div_balcklistpart");

                    if (dt[22] == "4") {
                        getObj("chk_blacklisted").checked = true;

                        $("#dp-blacklist").removeClass("hide");

                        SetVal("txt_blacklisted_reason", dt[23]);

                    }
                    else {
                        $("#dp-blacklist").addClass("hide");
                        SetVal("txt_blacklisted_reason", "");
                    }
                }
                else { toHide("div_balcklistpart"); getObj("chk_blacklisted").checked = false; }

                var HeadNm = dt[0];
                if (dt[25] != "") { HeadNm += " - " + dt[25]; }

                SetInnerVal("myModalLabel", HeadNm)

                var supplier_Type = dt[24];

                SetVal("txt_Opening_Balance", dt[26]);
                SetVal("ddl_Opening_Balance_Type", dt[27]);

                if (supplier_Type == "1") {
                    $("#div_Local").addClass("checked");
                    $("#div_Overseas").removeClass("checked");
                }
                else if (supplier_Type == "2") {
                    $("#div_Local").removeClass("checked");
                    $("#div_Overseas").addClass("checked");
                }
                else {
                    $("#div_Local").removeClass("checked");
                    $("#div_Overseas").removeClass("checked");
                }

                if ($("#hid_readOnly").val() == "1") {
                    $("#ddl_currency_id").attr("disabled", "disabled");
                }
                else {
                    $("#ddl_currency_id").removeAttr("disabled");
                }
                $(".select2").select2();
                $(".form-control").on('change', function () {
                    Make_ReadWrite("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");
                });
            }
        }
    }
}

//    //======================================================>All Initial Bind For general Tab Insertion of Data

function tabAccInfo() {
    if (getVal("hid_accounts_access") == 1) {

        //Generate_Account_Code();

        $("#tab_accounts_info").addClass("active"); $("#tab_accounts_info").removeClass("disabled");// alert("ok access");
        toShow("tab_accounts_info");
    }
    else {
        //alert("no access"); 
        $("#tab_accounts_info").addClass("disabled"); $("#tab_accounts_info").removeClass("active");
        toHide("tab_accounts_info");
    }


}

function Bind_All_DDLs_For_Cust_General() {
    toHide("rwcontact-add,rwaddress-add,rwdoc-add");

    $("#div_Local").removeClass("rbtDisabled");
    $("#div_Overseas").removeClass("rbtDisabled");

    Make_ReadOnly("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");

    lnk = pth + 'fun=Bind_All_DDLs_For_Cust_General';
    var xhReq = new XMLHttpRequest(); xhReq.open('GET', lnk, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
        if (xhReq.readyState == 4) {
            r = xhReq.responseText;
            if (Chk_Res(r) == false) {

                ClearFields_General(); ClearFields_AccountInfo();

                SetInnerVal("myModalLabel", "Add Supplier");

                //toShow("btn_Save_Continue_GenCus");

                $("#ddl_external_party_state").on('change', function () { ddl_external_party_city(0); });

                $("#general").addClass("active show");
                $("#gen_tab_lnk").addClass("active");

                $("#cperson").removeClass("active show");
                $("#cp_tab_lnk").removeClass("active");

                $("#addresses").removeClass("active show");
                $("#address_tab_lnk").removeClass("active");

                $("#documents").removeClass("active show");
                $("#account_info_tab_lnk").removeClass("active");

                $("#account").removeClass("active show");
                $("#doc_tab_lnk").removeClass("active");

                $("#Items").removeClass("active show");
                $("#items_tab_link").removeClass("active");

                //$("#AccInfoTab").attr("disabled", "disabled");

                var ddls = r.split('|');

                SetInnerVal("div_DL_Get_Approver", ddls[0]);

                SetInnerVal("div_DDL_Get_Parent_Account", ddls[1]);
                SetInnerVal("div_Get_DDL_Currency", ddls[2]);

                $("#div_Local").addClass("checked");
                $("#div_Overseas").removeClass("checked");

                $(".select2").select2();
                //SetVal("btn_txtAccountInfo", "Save"); //SetInnerVal("myModalLabel", "");

                // SetInnerVal("myModalLabel", "Add Supplier");
            }
        }
    } //api close

}

//    //======================================================Update Account Tab=============================================================

function Update_Account_Info(isBtnClick)// it actually does update, as supplier accounts created at 1st tab.
{
    var mainFlg = 1;

    var supplier_id = getVal("Hid_SupplierMain");

    var txt_account_code = getVal("txt_account_code");
    var ddl_parent_account_id = 0;

    if (getObj("chk_subaccount").checked == true) { ddl_parent_account_id = getVal("DDL_Get_Parent_Account"); }

    var txt_cr_number = getVal("txt_cr_number");
    var txt_vat_number = getVal("txt_vat_number");
    var ddl_currency_id = getVal("ddl_currency_id");
    var txt_bank_name = getVal("txt_bank_name");
    var txt_bank_branch_name = getVal("txt_bank_branch_name");
    var txt_account_holder_name = getVal("txt_account_holder_name");
    var txt_account_number = getVal("txt_account_number");

    var chk_credit = false;
    var txt_credit_days = 0;
    var txt_credit_amount = 0;

    if (getObj("chk_credit").checked == true) {
        chk_credit = true;
        txt_credit_days = getVal("txt_credit_days");
        txt_credit_amount = getVal("txt_credit_amount");
    }

    var txt_iban_number = getVal("txt_iban_number");
    var txt_swift_code = getVal("txt_swift_code");

    var chk_blacklisted = false;
    var txt_blacklisted_reason = getVal("txt_blacklisted_reason");

    if (getObj("chk_blacklisted").checked == true) {
        if (txt_blacklisted_reason == "") {
            chk_blacklisted = true; getObj("txt_blacklisted_reason").focus(); setBordrColor("txt_blacklisted_reason", '#ff9494'); mainFlg = 0;
        }
    }

    if (getVal("txt_account_code").trim() == "") { getObj("txt_account_code").focus(); setBordrColor("txt_account_code", '#ff9494'); mainFlg = 0; }

    if (getVal("txt_Opening_Balance") == "") { getObj("txt_Opening_Balance").focus(); setBordrColor("txt_Opening_Balance", '#ff9494'); mainFlg = 0; }

    if (getVal("ddl_Opening_Balance_Type") == "0") { getObj("ddl_Opening_Balance_Type").focus(); setBordrColor("ddl_Opening_Balance_Type", '#ff9494'); mainFlg = 0; }

    if (getVal("txt_cr_number").trim() == "") { getObj("txt_cr_number").focus(); setBordrColor("txt_cr_number", '#ff9494'); mainFlg = 0; }


    if (getVal("txt_vat_number").trim() == "") {
        getObj("txt_vat_number").focus(); setBordrColor("txt_vat_number", '#ff9494'); mainFlg = 0;
    }

    if (ddl_currency_id == 0) {
        getObj("ddl_currency_id").focus(); setBordrColor("ddl_currency_id", '#ff9494'); mainFlg = 0;
    }

    if (supplier_id.length < 1 || supplier_id == "" || supplier_id == 0)
        //{calltoast('Supplier Id not Found!', 'error'); mainFlg = 0;}

        if (getObj("chk_subaccount").checked == true) {
            if (ddl_parent_account_id == 0) {
                getObj("DDL_Get_Parent_Account").focus(); setBordrColor("DDL_Get_Parent_Account", '#ff9494'); mainFlg = 0;
            }
            else { setBordrColor("DDL_Get_Parent_Account", '#36bea6'); }
        }

    if (getObj("chk_credit").checked == true) {
        if (txt_credit_days == "" || txt_credit_days == "0") {
            getObj("txt_credit_days").focus();
            setBordrColor("txt_credit_days", '#ff9494'); mainFlg = 0;
        }


        if (txt_credit_amount == "" || txt_credit_amount == "0") {
            getObj("txt_credit_amount").focus();
            setBordrColor("txt_credit_amount", '#ff9494'); mainFlg = 0;
        }
    }

    if (mainFlg == 1) {
        lnk = pth + 'fun=Update_Account_Info&supplier_id=' + escape(supplier_id) + '&txt_account_code=' + escape(txt_account_code) + '&ddl_parent_account_id=' + escape(ddl_parent_account_id) + '&txt_cr_number=' + escape(txt_cr_number) + '&txt_vat_number=' + escape(txt_vat_number) + '&ddl_currency_id=' + escape(ddl_currency_id) + '&txt_bank_name=' + escape(txt_bank_name) + '&txt_bank_branch_name=' + escape(txt_bank_branch_name) + '&txt_account_holder_name=' + escape(txt_account_holder_name) + '&txt_account_number=' + escape(txt_account_number) + '&chk_credit=' + escape(chk_credit) + '&txt_credit_days=' + escape(txt_credit_days) + '&txt_credit_amount=' + escape(txt_credit_amount) + '&txt_iban_number=' + escape(txt_iban_number) + '&txt_swift_code=' + escape(txt_swift_code) + '&chk_blacklisted=' + escape(chk_blacklisted) + '&txt_blacklisted_reason=' + escape(txt_blacklisted_reason) + '&hid_Status=' + escape(getVal("hid_Status")) + '&opening_Balance=' + escape(getVal("txt_Opening_Balance")) + '&opening_Balance_Type=' + escape(getVal("ddl_Opening_Balance_Type")) + '&supplierName=' + escape($("#txt_Supplier_Name").val()) + '';

        var xhReq = new XMLHttpRequest();
        xhReq.open('GET', lnk, true);
        xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhReq.send('');
        xhReq.onreadystatechange = function () {

            if (xhReq.readyState == 4) {
                res = xhReq.responseText;
                if (Chk_Res(res) == false) {

                    if (res == "code") {
                        calltoast("Account code already exist", 'error');
                    }
                    else if (res == "name") {
                        calltoast("Account name already exist", 'error');
                    }
                    else if (res == "account") {
                        calltoast("Accounts Payable don't exist", 'error');
                    }
                    else if (res == "updated") {

                        $("#txt_account_code").prop("disabled", "disabled");

                        if ($("#hid_Save_Btn_Values").val() == "exit") {
                            getObj("btn_Cancel_Account_Info").click();
                        }
                        else if ($("#hid_Save_Btn_Values").val() == "continue") {
                            $("#doc_tab_lnk").addClass("active");
                            $("#documents").addClass("active");

                            $("#account_info_tab_lnk").removeClass("active");
                            $("#account").removeClass("active");
                        }

                        calltoast("Account details have been updated successfully", 'success');
                        //getObj("btn_Cancel_Account_Info").click();
                        View();
                    }


                    //if (r == "Done") {
                    //    getObj("btn_Cancel_Account_Info").click();
                    //    calltoast("The Data has been Saved Successfully.", 'success');
                    //    View();
                    //}
                    //else {
                    //    alert("Account Info Updation Failed");
                    //}
                }
            }
        }
    }
    else {
        calltoast('Please Provide the Mandatory Information', 'error');
    }
}

//    //======================================Bind Static Menu left-top-bottom
function Head_Left_Footer(res) { if (res == 0) { General_call("Head_Left_Footer", 0); } else { SplitAndSet(res, "|", "Inner", "div_header,footer") } }
//    //=====================================================================Validate & Param================================================>

//    //============================================For General Tab===================
function Validate_And_Param(fun) {

    var supplier_id = getVal("Hid_SupplierMain");

    if (fun == 'Bind_All_DDLs_For_Cust_General') {
        para = 'H_tbl_Supplier.ashx?fun=Bind_All_DDLs_For_Cust_General';
    }

    else if (fun == 'Insert_External_Party_Address') {
        var para = Validate_InstUpd_External_Party_Address(1, 1);
        return para;
    }
    else if (fun == 'Update_External_Party_Address') {
        var para = Validate_InstUpd_External_Party_Address(1, 0);
        return para;
    }
    else if (fun == 'View_external_party') {
        if (supplier_id.length < 1 || supplier_id == "" || supplier_id == 0) {
            return false;
        }
        else {
            para = 'H_tbl_Supplier.ashx?fun=View_external_party&supplier_id=' + supplier_id + '&RO=' + getVal("hid_readOnly");
            return para;
        }
    }
    else if (fun == 'Edit_External_Party_Address') {
        para = 'H_tbl_Supplier.ashx?fun=Edit_External_Party_Address&Address_Id=' + escape(getVal("hid_External_Party_Address"));

        return para;
    }
    else if (fun == 'Delete_External_Party_Address') {
        para = 'H_tbl_Supplier.ashx?fun=Delete_External_Party_Address&Address_Id=' + getVal("hid_External_Party_Address");
        return para;
    }
    else if (fun == 'ddl_external_party_country') {
        para = 'H_tbl_Supplier.ashx?fun=ddl_external_party_country'; return para;
    }
    else if (fun == 'ddl_external_party_state') {
        para = 'H_tbl_Supplier.ashx?fun=ddl_external_party_state&country=' + escape(getVal("ddl_external_party_country")); return para;
    }
    else if (fun == 'ddl_external_party_city') {
        para = 'H_tbl_Supplier.ashx?fun=ddl_external_party_city&state=' + escape(getVal("ddl_external_party_state")); return para;
    }
    else {
        alert('No action matched.'); para = 0;
    }
    return para;
}

function ClearFields() {
    ClearFields_General('');
    ClearFields_AccountInfo();
}

function ClearFields_General(fun) {
    SetVal("txt_Supplier_Name", '');
    SetVal("txt_Supplier_Short_Name", '');
    SetVal("txt_sup_company_branch", '');
    SetVal("txt_email", '');
    SetVal("txt_phone_number", '');
    SetVal("txt_fax", '');
    SetVal("txt_website", '');
    SetVal("DDL_Get_Approver", 0);

    setBorderColor_Initial("#d2d6de", "txt_Supplier_Name,txt_Supplier_Short_Name,txt_sup_company_branch,txt_email,txt_phone_number,txt_fax,txt_website,DDL_Get_Approver");

    Make_ReadWrite("txt_Supplier_Name,txt_Supplier_Short_Name,txt_sup_company_branch,txt_email,txt_phone_number,txt_fax,txt_website,DDL_Get_Approver");

    Make_ReadWrite("txt_account_code,txt_Opening_Balance,ddl_Opening_Balance_Type,chk_subaccount,DDL_Get_Parent_Account,txt_cr_number,txt_vat_number,ddl_currency_id,txt_bank_name,txt_bank_branch_name,txt_account_holder_name,txt_account_number,chk_credit,txt_credit_days,txt_credit_amount,txt_iban_number,txt_swift_code,chk_blacklisted,txt_blacklisted_reason");

}

function ClearFields_AccountInfo() {
    //SetVal("Hid_SupplierMain",""); 
    SetVal("txt_account_code", '');
    SetVal("txt_Opening_Balance", '0.00');
    SetVal("ddl_Opening_Balance_Type", 0);
    getObj("chk_subaccount").checked = false;
    SetVal("DDL_Get_Parent_Account", 0);
    SetVal("txt_cr_number", '');
    SetVal("txt_vat_number", '');
    SetVal("ddl_currency_id", 0);
    SetVal("txt_bank_name", '');
    SetVal("txt_bank_branch_name", '');
    SetVal("txt_account_holder_name", '');
    SetVal("txt_account_number", '');
    getObj("chk_credit").checked = false;
    SetVal("txt_credit_days", '');
    SetVal("txt_credit_amount", '');
    SetVal("txt_iban_number", '');
    SetVal("txt_swift_code", '');
    getObj("chk_blacklisted").checked = false;
    SetVal("txt_blacklisted_reason", '');

    //SetVal("btn_txtAccountInfo", "Save");
    setBorderColor_Initial("#d2d6de", "txt_account_code,txt_Opening_Balance,ddl_Opening_Balance_Type,chk_subaccount,DDL_Get_Parent_Account,txt_cr_number,txt_vat_number,ddl_currency_id,txt_bank_name,txt_bank_branch_name,txt_account_holder_name,txt_account_number,chk_credit,txt_credit_days,txt_credit_amount,txt_iban_number,txt_swift_code,chk_blacklisted,txt_blacklisted_reason");

    Make_ReadWrite("txt_account_code,txt_Opening_Balance,ddl_Opening_Balance_Type,chk_subaccount,DDL_Get_Parent_Account,txt_cr_number,txt_vat_number,ddl_currency_id,txt_bank_name,txt_bank_branch_name,txt_account_holder_name,txt_account_number,chk_credit,txt_credit_days,txt_credit_amount,txt_iban_number,txt_swift_code,chk_blacklisted,txt_blacklisted_reason")

}

function Generate_Account_Code() {
    if (getVal("Hid_SupplierMain") != "0") {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Supplier.aspx/Generate_Account_Code",
            data: "{'SupplierId':'" + getVal("Hid_SupplierMain") + "'}",
            dataType: "json",
            success: function (data) {
                if (Chk_Res(data.d) == false) {
                    if (data.d.indexOf("!error!") > -1) {
                        alert("There is an Error:----> " + data.d);
                    }
                    else {
                        var res = data.d.split("^");
                        SetVal("txt_account_code", res[0]);

                        if (getVal("hid_readOnly") == "1" || res[1] == "1") {
                            $("#txt_account_code").attr("disabled", "disabled");
                        }
                        else if (res[1] == "0") {
                            $("#txt_account_code").removeAttr("disabled");
                        }
                    }
                }
            }
        });
    }
}

//    //=================================================================== Contact Person From Here============================

function Call_To_Contact_Person(FunName, InputOutput) {
    if (InputOutput == 0) {
        API_Call(VAP_Contact_Person(FunName), FunName);
    }

}

function View_Contact_Person(res) {
    if (res == 0) {
        //SetInnerVal("tbody_List_CP", "Loading.... Please Wait") 

        Call_To_Contact_Person("View_Contact_Person", 0);
    }
    else {
        ClearFields_Contact_Person();

        SetInnerVal("tbody_List_CP", res);

        $('#rwcontact-add').slideUp();
        $("#rwcontact-add").addClass("hide");
        $("#rwplus").removeClass("hide");


        if (getVal("hid_readOnly") == "1") {
            toHide("btn-contact-add");
        }
        else {
            toShow("btn-contact-add"); toShow("Div_Input_Box_Opner_CP");
        }

        // toHide("rwcontact-add");
        //  toShow("Div_Input_Box_Opner_CP");

        SetVal("hid_Contact_Person", "0");
    }
}

function Insert_Contact_Person(res) {
    if (res == 0) {

        Call_To_Contact_Person("Insert_Contact_Person", 0);

    }
    else {
        calltoast("The Data has been Saved Successfully.", 'success');
        getObj("btn-contact-close").click();

        View_Contact_Person(0);
    }
}

//    //===========================================================================================> Update

function Update_Contact_Person(res) {
    if (res == 0) {
        Call_To_Contact_Person("Update_Contact_Person", 0);
    }
    else {
        View_Contact_Person(0);

        getObj("btn-contact-close").click();

        calltoast("The Data has been Updated Successfully.", 'success');

    }
}

//    //===========================================================================================> Call Form Edit Button

function GoForEdit_Contact_Person(Id) {
    // getObj("btn-contact-add").click();

    $('#rwcontact-add').slideDown();
    $("#rwcontact-add").removeClass("hide");
    $("#rwcontact-add").addClass("mt-20");
    $("#rwplus").addClass("hide");

    ClearFields_Contact_Person();

    if (Id.indexOf("details") == -1) {

        SetVal("hid_Contact_Person", Id);

        Edit_Contact_Person(Id, 0);


        Make_ReadWrite("txt_name,txt_department,txt_designation,txt_branch,txt_phone_number_CP,txt_mobile,txt_email_id,txt_fax_CP");

        //toHide("btn-contact-add");alert("show")
    }
    else {
        var IdAndDet = Id.split(',')
        Id = IdAndDet[0]

        SetVal("hid_Contact_Person", Id);

        Edit_Contact_Person(Id, 0);


        Make_ReadOnly("txt_name,txt_department,txt_designation,txt_branch,txt_phone_number_CP,txt_mobile,txt_email_id,txt_fax_CP");

    }

    Make_ReadOnly("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");
}

//    //================================================================================================> Edit
//    //float right for save & update button

function Edit_Contact_Person(id, res) {
    if (res == 0) {

        Call_To_Contact_Person("Edit_Contact_Person", 0);
    }
    else {
        Bind_Edit_Contact_Person(res);
    }
}

//    //================================================================================================> VAP_Contact_Person

function VAP_Contact_Person(fun) {
    //alert(fun);
    var supplier_id = getVal("Hid_SupplierMain"); var para = '0';

    if (supplier_id.length < 1 || supplier_id == "" || supplier_id == 0) { calltoast("Supplier Id Not Found", 'error'); return false; }
    else if (fun == 'Insert_Contact_Person') {
        var para = Validate_InstUpd_Contact_Person(1, 1); return para;
    }
    else if (fun == 'Update_Contact_Person') {
        var para = Validate_InstUpd_Contact_Person(1, 0); return para;
    }
    else if (fun == 'View_Contact_Person') {
        para = 'H_tbl_Supplier.ashx?fun=View_Contact_Person&supplier_id=' + supplier_id + '&RO=' + getVal("hid_readOnly");
        return para;

    }
    else if (fun == 'Edit_Contact_Person') {
        para = 'H_tbl_Supplier.ashx?fun=Edit_Contact_Person&person_id=' + getVal("hid_Contact_Person");
        return para;

    }
    else if (fun == 'Delete_Contact_Person') {
        para = 'H_tbl_Supplier.ashx?fun=Delete_Contact_Person&person_id=' + getVal("hid_Contact_Person"); return para;
    }
    else {
        alert('No action matched.'); para = 0; //
    }
    return para;
}

//    //================================================================================================> Validate_InstUpd_Contact_Person

function Validate_InstUpd_Contact_Person(isBtnClick, IsInsert) {
    setBorderColor_Initial("#d2d6de", "txt_name,txt_phone_number_CP,txt_mobile,txt_email_id,txt_branch,txt_department,txt_designation,txt_fax_CP");
    // if(setBorderColor_Validation("txt_account_code,txt_cr_number,txt_vat_number,ddl_currency_id") == 1)
    var para = true;

    var supplier_id = getVal("Hid_SupplierMain");

    if (supplier_id.length < 1 || supplier_id == "" || supplier_id == 0) {
        calltoast('supplier id is missing', 'error'); para = false;
    }

    if (getVal("txt_name") == "") {
        getObj("txt_name").style = "border-color:#ff9494;";
        getObj("txt_name").focus(); para = false;
    }
    else { getObj("txt_name").style = "border-color:#36bea6;"; }

    if (getVal("txt_phone_number_CP") == "" & getVal("txt_mobile") == "" & getVal("txt_email_id") == "") {
        getObj("txt_phone_number_CP").style = "border-color:#ff9494;";
        getObj("txt_mobile").style = "border-color:#ff9494;";
        getObj("txt_email_id").style = "border-color:#ff9494;";

        calltoast('Please enter Phone Number or Mobile Number or Email.', 'error'); return false;

        para = false;
    }
    else {
        getObj("txt_phone_number_CP").style = "border-color:#36bea6;";
        getObj("txt_mobile").style = "border-color:#36bea6;";
        getObj("txt_email_id").style = "border-color:#36bea6;";
    }

    if (getVal("txt_email_id") != "") {

        if (Validate_Email("txt_email_id") == false) { alert("Invalid Email Address"); return false; }

    }

    if (IsInsert == 1 & para == true) {
        para = 'H_tbl_Supplier.ashx?fun=Insert_Contact_Person&ddl_entity_id=' + supplier_id + '&txt_name=' + escape(getVal("txt_name")) + '&txt_department=' + escape(getVal("txt_department")) + '&txt_designation=' + escape(getVal("txt_designation")) + '&txt_branch=' + escape(getVal("txt_branch")) + '&txt_phone_number_CP=' + escape(getVal("txt_phone_number_CP")) + '&txt_mobile=' + escape(getVal("txt_mobile")) + '&txt_email_id=' + escape(getVal("txt_email_id")) + '&txt_fax_CP=' + escape(getVal("txt_fax_CP")) + '';
        return para;
    }
    else if (IsInsert == 0 & para == true) {
        if (getVal("hid_Contact_Person") == "" || getVal("hid_Contact_Person") == "0") {
            calltoast('Person Id is missing', 'error'); return false;
        }
        else {
            para = 'H_tbl_Supplier.ashx?fun=Update_Contact_Person&person_id=' + getVal("hid_Contact_Person") + '&txt_name=' + escape(getVal("txt_name")) + '&txt_department=' + escape(getVal("txt_department")) + '&txt_designation=' + escape(getVal("txt_designation")) + '&txt_branch=' + escape(getVal("txt_branch")) + '&txt_phone_number_CP=' + escape(getVal("txt_phone_number_CP")) + '&txt_mobile=' + escape(getVal("txt_mobile")) + '&txt_email_id=' + escape(getVal("txt_email_id")) + '&txt_fax_CP=' + escape(getVal("txt_fax_CP")) + '';
            return para;
        }
    }
    else {
        calltoast('Please enter mandatory information.', 'error'); return false;
    }

    return para;
}

//================================================================================================> Bind_Edit_Contact_Person

function Bind_Edit_Contact_Person(t) {
    var dt = t.split('|');
    SetVal("txt_name", dt[0]);
    SetVal("txt_department", dt[1]);
    SetVal("txt_designation", dt[2]);
    SetVal("txt_branch", dt[3]);
    SetVal("txt_phone_number_CP", dt[4]);
    SetVal("txt_mobile", dt[5]);
    SetVal("txt_email_id", dt[6]);
    SetVal("txt_fax_CP", dt[7]);

    //return false;

    if (getVal("hid_readOnly") == "1") {
        Make_ReadOnly("txt_name,txt_department,txt_designation,txt_branch,txt_phone_number_CP,txt_mobile,txt_email_id,txt_fax_CP");
    }
}

//================================================================================================> Delete Contact Person

function Delete_Contact_Person(id) {

    if (id == "Done") {
        calltoast("Deleted Successfully.", 'success');
        View_Contact_Person(0);
    }
    else {
        if (Confirm('', "Are you sure that you want to Delete this customer") == true) {
            SetVal("hid_Contact_Person", id);
            Call_To_Contact_Person("Delete_Contact_Person", 0);
        }
    }
}

//================================================================================================> ClearFields_Contact_Person

function ClearFields_Contact_Person() {
    SetVal("txt_name", '');
    SetVal("txt_department", '');
    SetVal("txt_designation", '');
    SetVal("txt_branch", '');
    SetVal("txt_phone_number_CP", '');
    SetVal("txt_mobile", '');
    SetVal("txt_email_id", '');
    SetVal("txt_fax_CP", '');
    SetVal("hid_Contact_Person", "0");

    Make_ReadWrite("txt_name,txt_department,txt_designation,txt_branch,txt_phone_number_CP,txt_mobile,txt_email_id,txt_fax_CP");
    setBorderColor_Initial("#d2d6de", "txt_name,txt_department,txt_designation,txt_branch,txt_phone_number,txt_mobile,txt_email_id,txt_fax");

}

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^External Party Address From Here^^^^^^^^^^^^^^^^^^^^^^^^

//===========================================================================External Party Address From Here============================

function View_external_party(res) {
    if (res == 0) {

        //SetInnerVal("tbody_List_CP", "Loading.... Please Wait")

        General_call("View_external_party", 0);
    }
    else {
        SetInnerVal("tbody_List_External_Party_Address", res);

        ClearFields_External_Party_Address();

        $('#rwaddress-add').slideUp();
        $("#rwaddress-add").addClass("hide");
        $("#rwaddplus").removeClass("hide");

        if (getVal("hid_readOnly") == "1") {
            toHide("btn-address-add");
        }
        else {
            toShow("btn-address-add")
        }

        SetVal("hid_External_Party_Address", 0);

    }
}

//===========================================================================================> Insert

function Insert_External_Party_Address(res) {
    if (res == 0) {
        General_call("Insert_External_Party_Address", 0);

    }
    else {
        calltoast("The Data has been Saved Successfully.", 'success');
        //getObj("btn_Cancel_sup_Gen").click(); 
        getObj("btn-address-close").click();
        View_external_party(0);
    }
}

//===========================================================================================> Update

function Update_External_Party_Address(res) {
    if (res == 0) {
        General_call("Update_External_Party_Address", 0);
    }
    else {

        getObj("btn-address-close").click();

        calltoast("The Data has been Updated Successfully.", 'success');
        View_external_party(0);
    }
}

var Todisbl = 0;

//===========================================================================================> Call Form Edit Button

function GoForEdit_External_Party_Address(Id) {

    ClearFields_External_Party_Address();


    if (Id.indexOf("details") == -1)//edit
    {

        SetVal("hid_External_Party_Address", Id);

        Edit_External_Party_Address(Id, 0);

        Make_ReadWrite("txt_external_party_address,txt_external_party_post_office,ddl_external_party_country,ddl_external_party_state,ddl_external_party_city,txt_external_party_zip")

    }
    else//disabled view
    {
        var IdAndDet = Id.split(',')
        Id = IdAndDet[0]
        SetVal("hid_External_Party_Address", Id);

        Edit_External_Party_Address(Id, 0);

        Todisbl = 1;
    }


    $('#rwaddress-add').slideDown();
    $("#rwaddress-add").removeClass("hide");
    $("#rwaddress-add").addClass("mt-20");
    $("#rwaddplus").addClass("hide");


}

//==============================================================> Edit_External_Party_Address
//float right for save & update button

function Edit_External_Party_Address(id, res) {
    if (res == 0) {

        General_call("Edit_External_Party_Address", 0);

    }
    else {
        Bind_Edit_External_Party_Address(res);

    }
}

//================================================================================================> Delete_External_Party_Address

function Delete_External_Party_Address(id) {
    if (id == "Done") {
        calltoast("Deleted Successfully.", 'success');
        View_external_party(0);
    }
    else {
        if (Confirm('', "Are you Sure") == true) {
            SetVal("hid_External_Party_Address", id);

            General_call("Delete_External_Party_Address", 0);
        }
    }
}

//================================================================================================> Validate_InstUpd_External_Party_Address

function Validate_InstUpd_External_Party_Address(isBtnClick, IsInsert) {
    setBorderColor_Initial("#d2d6de", "txt_external_party_address,ddl_external_party_country,ddl_external_party_state,ddl_external_party_city,txt_external_party_zip");

    var para = false, supplier_id = getVal("Hid_SupplierMain");

    if (setBorderColor_Validation("txt_external_party_address,ddl_external_party_country,ddl_external_party_state,ddl_external_party_city") == 0) {

        if (supplier_id.length < 1 || supplier_id == "" || supplier_id == 0) {
            calltoast('Please Enter Mandatory Information', 'error'); return false;
        }

        else if (getVal("txt_external_party_address") == '') {
            if (isBtnClick == 1) {
                calltoast('Please Enter Mandatory Information', 'error'); return false;

            }
        }
        else if (getVal("ddl_external_party_country") == '0') {
            if (isBtnClick == 1) {
                calltoast('Please Enter Mandatory Information', 'error'); return false;

            }
        }
        else if (getVal("ddl_external_party_state") == '0') {
            if (isBtnClick == 1) {
                getVal("ddl_external_party_state").focus();
                calltoast('Please Enter Mandatory Information', 'error'); return false;

            }
        }
        else if (getVal("ddl_external_party_city") == '0') {
            if (isBtnClick == 1) {
                calltoast('Please Enter Mandatory Information', 'error'); return false;
            }
        }
    }

    else {
        if (IsInsert == 1) {
            para = 'H_tbl_Supplier.ashx?fun=Insert_External_Party_Address&External_Party_Id=' + supplier_id + '&txt_external_party_address=' + escape(getVal("txt_external_party_address")) + '&txt_external_party_post_office=' + escape(getVal("txt_external_party_post_office")) + '&ddl_external_party_country=' + escape(getVal("ddl_external_party_country")) + '&ddl_external_party_state=' + escape(getVal("ddl_external_party_state")) + '&ddl_external_party_city=' + escape(getVal("ddl_external_party_city")) + '&txt_external_party_zip=' + escape(getVal("txt_external_party_zip")) + '';
            return para;
        }

        else {
            if (getVal("hid_External_Party_Address") == "" || getVal("hid_External_Party_Address") == "0") {
                calltoast('Person Id is missing', 'error'); return false;
            }
            else {
                para = 'H_tbl_Supplier.ashx?fun=Update_External_Party_Address&Address_Id=' + getVal("hid_External_Party_Address") + '&txt_external_party_address=' + escape(getVal("txt_external_party_address")) + '&txt_external_party_post_office=' + escape(getVal("txt_external_party_post_office")) + '&ddl_external_party_country=' + escape(getVal("ddl_external_party_country")) + '&ddl_external_party_state=' + escape(getVal("ddl_external_party_state")) + '&ddl_external_party_city=' + escape(getVal("ddl_external_party_city")) + '&txt_external_party_zip=' + escape(getVal("txt_external_party_zip")) + '';
                return para;
            }
        }

    }
    return para;
}

//================================================================================================> Bind_Edit_External_Party_Address

function Bind_Edit_External_Party_Address(t) {

    var dt = t.split("|");

    //        output += DR["name"] + "|" + DR["department"] + "|" + DR["designation"] + "|" + DR["branch"] + "|" + DR["phone_number"] + "|" + DR["mobile"] + "|" + DR["email_id"] + "|" + DR["fax"];
    SetVal("txt_external_party_address", dt[0]);
    SetVal("txt_external_party_post_office", dt[1]);
    SetInnerVal("div_external_party_country", dt[2]);
    SetInnerVal("div_external_party_state", dt[3]);
    SetInnerVal("div_external_party_city", dt[4]);
    SetVal("txt_external_party_zip", dt[5]);

    $("#ddl_external_party_country").on('change', function () { ddl_external_party_state(0); });
    $("#ddl_external_party_state").on('change', function () { ddl_external_party_city(0); });

    if (Todisbl == 1) {
        Make_ReadOnly("txt_external_party_address,txt_external_party_post_office,ddl_external_party_country,ddl_external_party_state,ddl_external_party_city,txt_external_party_zip")
        Todisbl = 0;
    }
    else {
        Make_ReadWrite("txt_external_party_address,txt_external_party_post_office,ddl_external_party_country,ddl_external_party_state,ddl_external_party_city,txt_external_party_zip")
    }

    Make_ReadOnly("btn_general_save,btn_Save_Continue_GenCus,btn_general_save_stay,btn_save_Contact_Person,btn_save_External_Party_Address,btn_txtAccountInfo,btn_Save_Exit_AccountInfo,btn_Save_Continue_AccountInfo,btn_save_doc");
}

//================================================================================================> ClearFields_External_Party_Address

function ClearFields_External_Party_Address() {

    SetVal("txt_external_party_address", '');
    SetVal("txt_external_party_post_office", '');

    SetVal("ddl_external_party_country", '0');
    SetVal("ddl_external_party_state", '0');
    SetVal("ddl_external_party_city", '0');
    SetVal("txt_external_party_zip", '');
    SetVal("hid_External_Party_Address", 0);

    setBorderColor_Initial("#d2d6de", "txt_external_party_address,txt_external_party_post_office,txt_external_party_zip");

    if (Todisbl == 1) {
        Make_ReadOnly("txt_external_party_address,txt_external_party_post_office,ddl_external_party_country,ddl_external_party_state,ddl_external_party_city,txt_external_party_zip")
        Todisbl = 0;
    }
    else {
        Make_ReadWrite("txt_external_party_address,txt_external_party_post_office,ddl_external_party_country,ddl_external_party_state,ddl_external_party_city,txt_external_party_zip")
    }
}

//================================================================================================>Bind Country DDL

function ddl_external_party_country(t) // bindds on "Address Tab" click
{
    if (t == 0) {
        if (getObj("ddl_external_party_country").innerHTML.indexOf("UAE") == -1) {
            General_call("ddl_external_party_country", 0);
        }
    }
    else {
        SetInnerVal("div_external_party_country", t);
        $("#ddl_external_party_country").on('change', function () { ddl_external_party_state(0); });
    }
    $(".select2").select2();
}

//================================================================================================>Bind state  DDL

function ddl_external_party_state(res) // bindds on "Address Tab" click
{
    if (res == 0) {
        General_call("ddl_external_party_state", 0);
    }
    else {
        SetInnerVal("div_external_party_state", res);
        $("#ddl_external_party_state").on('change', function () { ddl_external_party_city(0); });
    }
    $(".select2").select2();
}

//================================================================================================>Bind city  DDL

function ddl_external_party_city(res) // bindds on "Address Tab" click
{
    if (res == 0) {

        General_call("ddl_external_party_city", 0);
    }

    else {
        SetInnerVal("div_external_party_city", res);
    }
    $(".select2").select2();
}

//====================================DOCUMENT FROM HERE=====================================<<<<<<<<<<<<<<<<<<

function Call_To_Doc(FunName, InputOutput) {
    if (InputOutput == 0) {
        API_Call(VAP_Doc(FunName), FunName);
    }
}

//================================================================================================> VAP_Doc

function VAP_Doc(fun) {
    var para = false;
    var supplier_id = getVal("Hid_SupplierMain");
    if (supplier_id.length < 1 || supplier_id == "" || supplier_id == 0) {
        return false;
    }
    else if (fun == 'Insert_Doc') {
        var para = Validate_InstUpd_Doc(1, 1); return para;
    }
    else if (fun == 'Update_Doc') {
        var para = Validate_InstUpd_Doc(1, 0); return para;
    }
    else if (fun == 'View_Doc') {
        para = 'H_tbl_Supplier.ashx?fun=View_Doc&supplier_id=' + supplier_id + '&RO=' + getVal("hid_readOnly");
        return para;
    }
    else if (fun == 'Edit_Doc') {
        para = 'H_tbl_Supplier.ashx?fun=Edit_Doc&Document_Id=' + getVal("hid_Doc");
        return para;
    }
    else if (fun == 'Delete_Doc') {
        para = 'H_tbl_Supplier.ashx?fun=Delete_Doc&Document_Id=' + getVal("hid_Doc");
        return para;
    }
    else if (fun == 'Bind_All_DDLs_For_Document') {
        para = 'H_tbl_Supplier.ashx?fun=Bind_All_DDLs_For_Document'; return para;
    }

    else {
        alert('No action matched.'); para = 0; return para;
    }
}

//================================================================================================> Validate_InstUpd_Doc
//function Validate_InstUpd_Doc(isBtnClick, IsInsert) {
//    setBorderColor_Initial("#d2d6de", "Document_Type_Id,hid_fileName,Expiry_Date");

//    var para = false; var External_Party_Id = getVal("Hid_SupplierMain");

//    if (setBorderColor_Validation("Document_Type_Id,File_Name") == 0 && IsInsert == 1)//,
//    {
//        if (External_Party_Id.length < 1 || External_Party_Id == "" || External_Party_Id == 0) { calltoast('supplier id is missing', 'error'); return false; }

//        else if (getVal("Document_Type_Id") == '0') //Document Name
//        {
//            if (isBtnClick == 1) {
//                calltoast('Please enter mandatory information', 'error'); return false;
//            }
//        }
//        else if (getVal("File_Name") == 0 && IsInsert == 1) //File_Name //means validate at
//        {
//            if (isBtnClick == 1) {
//                calltoast('Please enter mandatory information', 'error'); return false;
//            }
//        }

//    }
//    else {
//        if (getVal("Expiry_Date") != "" & getVal("Assigned_To") == '0') {
//            if (isBtnClick == 1) {
//                calltoast('Please enter mandatory information', 'error'); return false;
//                getObj("Assigned_To").style = "border-color:#ff9494";
//                return false;
//            }

//        }
//        getObj("Assigned_To").style = "border-color:#d2d6de";

//        if (IsInsert == 1)
//        {
//            if (getVal("hid_fileName") != "") 
//            {
//                para = 'H_tbl_Supplier.ashx?fun=Insert_Doc&Document_Type_Id=' + escape(getVal("Document_Type_Id")) + '&External_Party_Id=' + escape(External_Party_Id) + '&Issuing_Athourity=' + escape(getVal("Issuing_Athourity")) + '&Document_Number=' + escape(getVal("Document_Number")) + '&File_Name=' + escape(getVal("hid_fileName")) + '&Expiry_Date=' + escape(getVal("Expiry_Date")) + '&Assigned_To=' + escape(getVal("Assigned_To")) + '';
//                return para;
//            } else
//            {
//                calltoast('Please enter mandatory information', 'error');
//                getObj("File_Name").style = "border-color:#ff9494";
//                return false;
//            }
//        }

//        else {
//            if (getVal("hid_Doc") == "" || getVal("hid_Doc") == "0") {
//                calltoast('Document Id is missing', 'error'); return false;
//            }
//            else {
//                para = 'H_tbl_Supplier.ashx?fun=Update_Doc&Document_Id=' + getVal("hid_Doc") + '&Document_Type_Id=' + escape(getVal("Document_Type_Id")) + '&Issuing_Athourity=' + escape(getVal("Issuing_Athourity")) + '&Document_Number=' + escape(getVal("Document_Number")) + '&File_Name=' + escape(getVal("hid_fileName")) + '&Expiry_Date=' + escape(getVal("Expiry_Date")) + '&Assigned_To=' + escape(getVal("Assigned_To")) + '';
//                return para;
//            }
//        }
//    }

//    return para;
//}


function Validate_InstUpd_Doc(isBtnClick, IsInsert) {
    setBorderColor_Initial("#d2d6de", "Document_Type_Id,hid_fileName,Expiry_Date");

    //alert(getVal("Expiry_Date"));

    var para = true; var External_Party_Id = getVal("Hid_SupplierMain");

    if (External_Party_Id.length < 1 || External_Party_Id == "" || External_Party_Id == 0) { calltoast('supplier id is missing', 'error'); return false; }
    if (ValidateOne(getObj("Document_Type_Id")) == 0) //Document Name
    {
        para = false;
    }
    //else { getObj("Document_Type_Id").style = "border-color:#d2d6de"; }


    if (getVal("File_Name") == 0 && IsInsert == 1) //File_Name
    {
        getObj("File_Name").style = "border-color:#ff9494";
        para = false;
    }
    else { getObj("File_Name").style = "border-color:#d2d6de"; }


    if (getVal("Expiry_Date") != "") {

        getObj("Expiry_Date").style = "border-color:#d2d6de";

        if (getVal("Assigned_To") == "0") {
            getObj("Assigned_To").style = "border-color:#ff9494";
            para = false;
        }
        else {
            getObj("Assigned_To").style = "border-color:#d2d6de";
        }

    }
    // else {getObj("Assigned_To").style = "border-color:#d2d6de";}

    if (IsInsert == 1 & para == true) {
        if (getVal("hid_fileName") != "") {
            para = 'H_tbl_Supplier.ashx?fun=Insert_Doc&Document_Type_Id=' + escape(getVal("Document_Type_Id")) + '&External_Party_Id=' + escape(External_Party_Id) + '&Issuing_Athourity=' + escape(getVal("Issuing_Athourity")) + '&Document_Number=' + escape(getVal("Document_Number")) + '&File_Name=' + escape(getVal("hid_fileName")) + '&Expiry_Date=' + escape(getVal("Expiry_Date")) + '&Assigned_To=' + escape(getVal("Assigned_To")) + '';

            return para;
        } else {
            calltoast('Please enter mandatory information', 'error');
            getObj("File_Name").style = "border-color:#ff9494";
            return false;
        }
    }
    else if (IsInsert == 0 & para == true) {
        if (getVal("hid_Doc") == "" || getVal("hid_Doc") == "0") {
            calltoast('Document Id is missing', 'error'); return false;
        }
        else {
            para = 'H_tbl_Supplier.ashx?fun=Update_Doc&Document_Id=' + getVal("hid_Doc") + '&Document_Type_Id=' + escape(getVal("Document_Type_Id")) + '&Issuing_Athourity=' + escape(getVal("Issuing_Athourity")) + '&Document_Number=' + escape(getVal("Document_Number")) + '&File_Name=' + escape(getVal("hid_fileName")) + '&Expiry_Date=' + escape(getVal("Expiry_Date")) + '&Assigned_To=' + escape(getVal("Assigned_To")) + '';
            return para;
        }
    }
    else { calltoast('Please Provide the Mandatory Information', 'error'); return false; }

    return para;
}

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^View Document View From Here^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

function View_Doc(res) {
    if (res == 0) {
        //SetInnerVal("tbody_List_Doc", "Loading.... Please Wait");
        Call_To_Doc("View_Doc", 0);
    }
    else {
        SetInnerVal("tbody_List_Doc", res);

        $('#rwdoc-add').slideUp();
        $("#rwdoc-add").addClass("hide");
        $("#rwdocplus").removeClass("hide");

        if (getVal("hid_readOnly") == "1") {
            toHide("btn-doc-add");
            toHide("rwdoc-add");
        }
        else {
            toShow("btn-doc-add")
        }
        SetVal("hid_Doc", 0);
        ClearFields_Doc();

    }
}

//===========================================================================================> Insert

function Insert_Doc(res) {
    if (res == 0) {
        Call_To_Doc("Insert_Doc", 0);

    }
    else if (res.indexOf("lessdate") > -1) {
        calltoast("The document expiry date should not be less than today's date.", 'error');
    }
    else {
        calltoast("The Data has been Saved Successfully.", 'success');
        //getObj("btn_Cancel_sup_Gen").click(); 
        getObj("btn-doc-close").click();
        View_Doc(0);
    }
}

//===========================================================================================> Update

function Update_Doc(res) {
    if (res == 0) {
        Call_To_Doc("Update_Doc", 0);
    }
    else if (res.indexOf("lessdate") > -1) {
        calltoast("The document expiry date should not be less than today's date.", 'error');
    }
    else {

        getObj("btn-doc-close").click();

        calltoast("The Data has been Updated Successfully.", 'success');
        View_Doc(0);
    }
}

//================================================================================================> Edit_Doc
//float right for save & update button

function Edit_Doc(id, res) {
    if (res == 0) {

        Call_To_Doc("Edit_Doc", 0);

    }
    else {
        Bind_Edit_Doc(res);

    }
}

//================================================================================================> Delete_Doc

function Delete_Doc(id) {

    if (id == "Done") {
        calltoast("Deleted Successfully.", 'success');
        View_Doc(0);
    }
    else {
        if (Confirm('', "Are you Sure") == true) {
            SetVal("hid_Doc", id);
            Call_To_Doc("Delete_Doc", 0);
        }
    }
}

//================================================================================================> Bind_Edit_Doc

function Bind_Edit_Doc(t) {

    var dt = t.split("|");
    //alert(dt[5])
    SetInnerVal("div_ddl_doc_type", dt[0]);
    SetVal("Document_Number", dt[1]);
    SetVal("Issuing_Athourity", dt[2]);
    SetVal("Expiry_Date", dt[3]);
    SetInnerVal("div_Assigned_To", dt[4]);
    SetVal("File_Name", dt[5]);
    SetVal("hid_fileName", dt[5]);

    if (Todisbl == 1) {
        Make_ReadOnly("Document_Type_Id,Issuing_Athourity,Document_Number,File_Name,Expiry_Date,Assigned_To")
        Todisbl = 0;
    }
    else {
        Make_ReadWrite("Document_Type_Id,Issuing_Athourity,Document_Number,File_Name,Expiry_Date,Assigned_To")
    }
}

var Todisbl = 0;

//===========================================================================================> Call Form Edit Button

function GoForEdit_Doc(Id) {
    getObj("btn-doc-add").click();

    ClearFields_Doc();


    if (Id.indexOf("details") == -1)//edit
    {

        SetVal("hid_Doc", Id);
        Edit_Doc(Id, 0);

        Make_ReadWrite("Document_Type_Id,Issuing_Athourity,Document_Number,File_Name,Expiry_Date,Assigned_To")

    }
    else//disabled view
    {

        var IdAndDet = Id.split(',')
        Id = IdAndDet[0]
        SetVal("hid_Doc", Id);

        Edit_Doc(Id, 0);

        Todisbl = 1;
    }

    $('#rwdoc-add').slideDown();
    $("#rwdoc-add").removeClass("hide");
    $("#rwdoc-add").addClass("mt-20");
    $("#rwdocplus").addClass("hide");
}

//================================================================================================> ClearFields_Doc

function ClearFields_Doc() {
    SetVal("Expiry_Date", '');
    SetVal("Document_Number", '');
    SetVal("Issuing_Athourity", '');
    SetVal("Document_Type_Id", '0');
    SetVal("Assigned_To", '0');
    SetVal("File_Name", "");
    SetVal("hid_fileName", "");
    SetVal("hid_Doc", 0);

    setBorderColor_Initial("#d2d6de", "Document_Type_Id,Issuing_Athourity,Document_Number,File_Name,Expiry_Date,Assigned_To");

    if (Todisbl == 1) {
        Make_ReadOnly("Document_Type_Id,Issuing_Athourity,Document_Number,File_Name,Expiry_Date,Assigned_To")
        Todisbl = 0;
    }
    else {
        Make_ReadWrite("Document_Type_Id,Issuing_Athourity,Document_Number,File_Name,Expiry_Date,Assigned_To")
    }
}

//=======================>All Initial Bind For general Tab Insertion of Data=====================

function Bind_All_DDLs_For_Document(t) {
    if (t == 0) {
        if (getObj("Issuing_Athourity").innerHTML.indexOf("UAE") == -1) {
            Call_To_Doc("Bind_All_DDLs_For_Document", 0);
        }
    }
    else {
        var ddls = t.split('|');

        SetInnerVal("div_ddl_doc_type", ddls[0]);
        SetInnerVal("div_Assigned_To", ddls[1]);
    }
    $(".select2").select2();
}

//=============================================================Remove Supplier======================

function Remove_Supplier_Id() {
    SetVal("Hid_SupplierMain", "0");
    SetVal("hid_readOnly", "0")

}

//==========================================================Auto Suggestion=========================================

function GetSuggestions(res) {
    if (res == 0) {
        View(0);
    }
}

//====================================================================SelSet=================================

function selset(obj, num) {
    if (num == 1) {
        obj.style = "background-color:#d5d5d5;"
    }
    else {
        obj.style = "background-color:#ebebeb;"
    }
}

//====================================================================Filter Search=================================

function fillTxt(td_Id, Td_Val) {
    Td_Val = Td_Val.replace('%20', ' ').replace('%20', ' ').replace('%20', ' ').replace('%20', ' ').replace('%20', ' ').replace('%20', ' ').replace('%20', ' ').replace('%20', ' ')
    SetVal("txtinput", Td_Val);
    // To_Display('none', "td_resSug");

    View(0); //getVal("txtinput")
}

//====================================================================Send_for_Approval=================================

function Send_for_Approval(supplier_id) {
    if (supplier_id == 'Supplier has been sent for Approval')//it is there 
    {
        calltoast("Supplier has been sent for Approval", 'success');

        View(0);
    }
    else if (supplier_id.indexOf("Please Upload") > -1) {

        calltoast(supplier_id, 'error');
    }
    else if (supplier_id.indexOf("Error:") > -1) {
        calltoast("There is an error in Approval", 'error');
    }
    else //go for checking
    {
        Send_for_Approval_para(supplier_id);
    }
}

function Send_for_Approval_para(supplier_id) {
    para = 'H_tbl_Supplier.ashx?fun=Send_for_Approval&supplier_id=' + escape(supplier_id); //return para;
    var xhReq = new XMLHttpRequest(); xhReq.open('GET', para, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
        if (xhReq.readyState == 4) {
            Result = xhReq.responseText;
            if (Chk_Res(Result) == false) {
                Send_for_Approval(Result);
            }
        }
    }
}

//============================================================Click_To_Approve===========================================================
function Click_To_Approve(supplier_id) {
    if (supplier_id == 'Supplier has been Approved')//it is there 
    {
        calltoast("Supplier has been Approved", 'success');
        View(0);
    }
    else if (supplier_id.indexOf("Following fields") > -1) {
        calltoast(supplier_id, 'error');
    }
    else if (supplier_id.indexOf("Error:") > -1) {
        calltoast("There is an error", 'error');
    }
    else {
        Click_To_ApprovePara(supplier_id);
    }
}

function Click_To_ApprovePara(supplier_id) {
    para = 'H_tbl_Supplier.ashx?fun=Click_To_Approve&supplier_id=' + escape(supplier_id); //return para;
    //alert(para)
    var xhReq = new XMLHttpRequest(); xhReq.open('GET', para, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
        if (xhReq.readyState == 4) {
            Result = xhReq.responseText;
            if (Chk_Res(Result) == false) {
                Click_To_Approve(Result);
            }
        }
    }
}
//============================================================Suspend===========================================================

function Suspen_Supplier(supplier_id) {
    if (supplier_id == 'Done')//it is there 
    {
        calltoast("Supplier has been Suspended", 'success');
        View(0);
    }
    else if (supplier_id.indexOf("Error:") > -1) {
        calltoast("There is an error", 'error');
    }
    else {
        if (Confirm('', "Are you sure that you want to Suspend this supplier") == true) {
            Suspen_Supplier_Para(supplier_id);
        }
    }
}

function Suspen_Supplier_Para(supplier_id) {
    para = 'H_tbl_Supplier.ashx?fun=Suspen_Supplier&supplier_id=' + escape(supplier_id); //return para;
    var xhReq = new XMLHttpRequest(); xhReq.open('GET', para, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
        if (xhReq.readyState == 4) {
            Result = xhReq.responseText;
            if (Chk_Res(Result) == false) {
                Suspen_Supplier(Result);
            }
        }
    }
}

//============================================================BlackList===========================================================

function Display_Blacklist_Box(supplier_id) {
    toShow("blacklistpopup");
    SetVal("hid_blacklist", supplier_id);
}

function Make_Balcklist(res) {
    if (res == 'Done') {
        calltoast("Supplier has been Balcklisted", 'success');
        SetVal("hid_blacklist", "");
        SetVal("txt_black_list_reason", "");
        toHide("blacklistpopup");
        View(0);
    }
    else if (res.indexOf("Error:") > -1) {
        calltoast("There is an error", 'error');
    }
    else {
        if (getVal("hid_blacklist") != "") {
            if (getVal("txt_black_list_reason") != "") {
                Make_Balcklist_Para(getVal("hid_blacklist")); //
            }
            else {
                calltoast("Please enter blacklist reason", "error");
                ValidateOne("txt_black_list_reason");
            }
        }
        else {
            calltoast("Supplier Id not found!, Please repeat the operation.", "error");
        }
    }
}

function Make_Balcklist_Para(supplier_id) {
    para = 'H_tbl_Supplier.ashx?fun=Make_Balcklist&supplier_id=' + escape(supplier_id) + '&reason=' + escape(getVal("txt_black_list_reason")) + ''; //return para;
    var xhReq = new XMLHttpRequest(); xhReq.open('GET', para, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
        if (xhReq.readyState == 4) {
            Result = xhReq.responseText;
            if (Chk_Res(Result) == false) {
                Make_Balcklist(Result);
            }
        }
    }
}

//============================================================Make_Whitelist===========================================================

function Make_Whitelist(supplier_id) {
    if (supplier_id == 'Done')//it is there 
    {
        calltoast("Supplier has been Whitelisted", 'success');
        View(0);
    }
    else if (supplier_id.indexOf("Error:") > -1) {
        calltoast("There is an error", 'error');
    }
    else {
        if (Confirm('', "Are you sure to whitelist the supplier") == true) {
            Make_Whitelist_Para(supplier_id);
        }
    }
}

function Make_Whitelist_Para(supplier_id) {
    para = 'H_tbl_Supplier.ashx?fun=Make_Whitelist&supplier_id=' + escape(supplier_id); //return para;
    var xhReq = new XMLHttpRequest(); xhReq.open('GET', para, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
        if (xhReq.readyState == 4) {
            Result = xhReq.responseText;
            if (Chk_Res(Result) == false) {
                Make_Whitelist(Result);
            }
        }
    }
}

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<# Sorting #>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

function setSort(SortField) {
    var Sort_Id = "#" + getObj(SortField).id;

    var sort_field = getObj(SortField).id;

    if ($(Sort_Id).hasClass("sorting") || $(Sort_Id).hasClass("sorting_desc")) {
        $(Sort_Id).removeClass("sorting");
        $(Sort_Id).removeClass("sorting_desc");
        $(Sort_Id).addClass("sorting_asc")

        SortField = " order by a." + sort_field + " asc ";
    }
    else if ($(Sort_Id).hasClass("sorting_asc") || $(Sort_Id).hasClass("sorting_asc")) {
        $(Sort_Id).removeClass("sorting");
        $(Sort_Id).removeClass("sorting_asc")
        $(Sort_Id).addClass("sorting_desc")

        SortField = " order by a." + sort_field + " desc "
    }

    SortByField = SortField;
    View(0);
}

//===========================================================filter============================================================

function filter(obj, CustomerType) {
    $("#div_all").removeClass("checked")
    $("#div_prospect").removeClass("checked")
    $("#div_customers").removeClass("checked")
    $("#div_blacklisted").removeClass("checked")
    $("#div_suspended").removeClass("checked")

    if ($(obj).hasClass("checked")) {
        $(obj).removeClass("checked");
    }
    else {
        $(obj).addClass("checked");
    }


    if ($("#div_all").hasClass("checked") == false && $("#div_prospect").hasClass("checked") == false && $("#div_customers").hasClass("checked") == false && $("#div_blacklisted").hasClass("checked") == false && $("#div_suspended").hasClass("checked") == false) {
        $("#div_all").addClass("checked"); CustomerType = 0;

    }

    Status = CustomerType;
    View(0);
}

//=========================================================================================================================

function ValidateCreditFacility() {

    if (getObj("chk_credit").checked == true) {
        if (getVal("txt_credit_days") == "" || getVal("txt_credit_days") == "0") {
            setBordrColor("txt_credit_days", '#ff9494');
        }
        else if (getVal("txt_credit_days") != "" & getVal("txt_credit_days") != "0") {
            setBordrColor("txt_credit_days", '#36bea6;');
        }
        else {
            setBordrColor("txt_credit_days", '#36bea6;');
        }


        if (getVal("txt_credit_amount") == "" || getVal("txt_credit_amount") == "0") {
            setBordrColor("txt_credit_amount", '#ff9494');
        }
        else if (getVal("txt_credit_amount") != "" & getVal("txt_credit_amount") != "0") {
            setBordrColor("txt_credit_amount", '#36bea6;');
        }
        else {
            setBordrColor("txt_credit_amount", '#36bea6;');
        }
    }
}

//===========================================================================================> General Call

function General_call(FunName, InputOutput) {
    if (InputOutput == 0) {
        API_Call(Validate_And_Param(FunName), FunName);
    }
    else {

        if (InputOutput.indexOf("Error: ") == -1) {
            if (FunName == "View") { View(InputOutput); } else if (FunName == "Insert_Update_General") { Insert_Update_General(InputOutput); } else if (FunName == "Update_General") { Update_General(InputOutput); } else if (FunName == "Edit_SupplierInfo") { Edit_SupplierInfo(InputOutput); } else if (FunName == "Bind_All_DDLs_For_Cust_General") { Bind_All_DDLs_For_Cust_General(InputOutput); } else if (FunName == "Head_Left_Footer") { Head_Left_Footer(InputOutput); } else if (FunName == "Update_Account_Info") { Update_Account_Info(InputOutput); } else if (FunName == "View_Contact_Person") { View_Contact_Person(InputOutput); }
            else if (FunName == "Insert_Contact_Person") { Insert_Contact_Person(InputOutput); }
            else if (FunName == "Update_Contact_Person") { Update_Contact_Person(InputOutput); }
            else if (FunName == "Edit_Contact_Person") { Edit_Contact_Person(0, InputOutput); }
            else if (FunName == "Delete_Contact_Person") { Delete_Contact_Person(InputOutput); }
            else if (FunName == "Delete_External_Party_Address") { Delete_External_Party_Address(InputOutput); }

            else if (FunName == "View_external_party") { View_external_party(InputOutput); }
            else if (FunName == "Insert_External_Party_Address") { Insert_External_Party_Address(InputOutput); }
            else if (FunName == "Update_External_Party_Address") { Update_External_Party_Address(InputOutput); }
            else if (FunName == "Edit_External_Party_Address") { Edit_External_Party_Address(0, InputOutput); }
            else if (FunName == "ddl_external_party_country") { ddl_external_party_country(InputOutput); }
            else if (FunName == "ddl_external_party_state") { ddl_external_party_state(InputOutput); }
            else if (FunName == "ddl_external_party_city") { ddl_external_party_city(InputOutput); }

            else if (FunName == "Bind_All_DDLs_For_Document") { Bind_All_DDLs_For_Document(InputOutput); }
            else if (FunName == "Delete_Doc") { Delete_Doc(InputOutput); }
            else if (FunName == "Edit_Doc") { Edit_Doc(0, InputOutput); }
            else if (FunName == "Update_Doc") { Update_Doc(InputOutput); }
            else if (FunName == "Insert_Doc") { Insert_Doc(InputOutput); }
            else if (FunName == "View_Doc") { View_Doc(InputOutput); } //

        }
        else {
            calltoast(InputOutput, 'error');
            alert(InputOutput);
        }
    }
}

function Bind_DDL_Items(Item_Type, selected_Item) {

    if (Item_Type == "") {
        Item_Type = "1";
    }
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "Supplier.aspx/Get_Items",
        data: "{'item_Type':'" + Item_Type + "','branch_Id':'" + getVal("hdf_branch_id") + "','Selected_Item':'" + selected_Item + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    SetInnerVal("ddl_ItemSubCategory", data.d);
                }
            }
        }
    });
}

//======================================================================Excel_Data========================

function Excel_Data() {
    para = 'H_tbl_Supplier.ashx?fun=excel&branch_id=' + getVal("DDL_Branch"); //return para;
    var xhReq = new XMLHttpRequest(); xhReq.open('GET', para, true); xhReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhReq.send(''); xhReq.onreadystatechange = function () {
        if (xhReq.readyState == 4) {
            Result = xhReq.responseText;
            if (Chk_Res(Result) == false) {
                if (Result.indexOf("Access is Restricted!") > -1) {
                    SetInnerVal("span_excel", "Access is Restricted!");
                } else {
                    window.open("../../Template/Supplier/" + Result);
                }
            }
        }
    }
}

//==============================================================================================

function Bind_Scope_Of_Supply_Table() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "Supplier.aspx/Get_Scope_Of_Supply",
        data: "{'supplier_Id':'" + getVal("Hid_SupplierMain") + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    $('#rwScopeAdd').slideUp();
                    $("#rwScopeAdd").addClass("hide");
                    $("#rwScopePlus").removeClass("hide");
                    ClearFields_Scope();
                    SetInnerVal("tbody_Supplier_Scopes", data.d);

                    if (getVal("hid_readOnly") == "1") {
                        toHide("rwScopePlus");
                    }
                    else {
                        toShow("rwScopePlus");
                    }
                }
            }
        }
    });
}

function View_Supplier_Scope(supplier_Scope_Id) {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "Supplier.aspx/Bind_Supplier_Scope_Details",
        data: "{'supplier_Scope_Id':'" + supplier_Scope_Id + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else {
                    var res = data.d;
                    var Item_Type = res.split('^')[0];
                    var selectedSubCat = res.split('^')[1];

                    Bind_DDL_Items(Item_Type, selectedSubCat);

                    if (Item_Type == "1") {
                        $("#div_Stock").addClass("checked");
                        $("#div_Non_Stock").removeClass("checked");
                    }
                    else if (Item_Type == "2") {
                        $("#div_Stock").removeClass("checked");
                        $("#div_Non_Stock").addClass("checked");
                    }

                    SetVal("txt_Item_Des", res.split('^')[2]);
                    SetVal("hid_Supplier_Scope_Id", supplier_Scope_Id);

                    $('#rwScopeAdd').slideDown();
                    $("#rwScopeAdd").removeClass("hide");
                    $("#rwScopeAdd").addClass("mt-20");
                    $("#rwScopePlus").addClass("hide");
                }
            }
        }
    });
}

function Delete_Supplier_Scope(supplier_Scope_Id) {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "Supplier.aspx/Delete_Scope_of_Supply",
        data: "{'supplier_Scope_Id':'" + supplier_Scope_Id + "'}",
        dataType: "json",
        success: function (data) {
            if (Chk_Res(data.d) == false) {
                if (data.d.indexOf("!error!") > -1) {
                    alert("There is an Error:----> " + data.d);
                }
                else if (data.d == "ok") {
                    Bind_Scope_Of_Supply_Table();
                    calltoast("Scope of supply deleted successfully", "success");
                }
            }
        }
    });
}

function Save_Scope_Of_Supplier() {

    if ($("#ddl_ItemSubCategory").val() == 0) {
        Mendatry_Msg();
    }
    else {
        var description = getVal("txt_Item_Des").replace("'", "~").replace("'", "~").replace("'", "~").replace("'", "~");
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Supplier.aspx/Save_Supplier_Scope",
            data: "{'Item_Sub_Cat_Id':'" + getVal("ddl_ItemSubCategory") + "','Supplier_Id':'" + getVal("Hid_SupplierMain") + "','Description':'" + description + "','Supplier_Scope_Id':'" + getVal("hid_Supplier_Scope_Id") + "'}",
            dataType: "json",
            success: function (data) {
                if (Chk_Res(data.d) == false) {
                    if (data.d.indexOf("!error!") > -1) {
                        alert("There is an Error:----> " + data.d);
                    }
                    else {
                        if (data.d == "saved") {
                            Bind_Scope_Of_Supply_Table();
                            calltoast("Data saved successfully", "success");
                        }
                        else if (data.d == "updated") {
                            Bind_Scope_Of_Supply_Table();
                            calltoast("Data updated successfully", "success");
                        }
                        else if (data.d == "already exists") {
                            Bind_Scope_Of_Supply_Table();
                            calltoast("This Item Sub Category already exists", "error");
                        }
                        else {
                            calltoast("Some error occurred", "error");
                        }
                        SetVal("hid_Supplier_Scope_Id", "0");
                    }
                }
            }
        });
    }
}

function ClearFields_Scope() {
    Bind_DDL_Items("1", "0");
    SetVal("txt_Item_Des", "");
    $("#div_Stock").addClass("checked");
    $("#div_Non_Stock").removeClass("checked");
    SetVal("hid_Supplier_Scope_Id", "0");
}

function save_Accounts_Info(btnValue) {

    if (ValidateSpace0("Hid_SupplierMain") != "0") {

        if (getVal("txt_Opening_Balance") != "") {
            Update_Account_Info(0);

            $("#hid_Save_Btn_Values").val(btnValue);
        }
        else {
            calltoast("Opening balance can't be empty", 'error');
        }
    }
    else {
        calltoast("Supplier Id Not Found", 'error');
    }
}

function Go_To_Next_Tab(tabNameOnWhichButtonIsClicked) {

    if (tabNameOnWhichButtonIsClicked == "contact") {
        $("#address_tab_lnk").addClass("active");
        $("#addresses").addClass("active");

        $("#cp_tab_lnk").removeClass("active");
        $("#cperson").removeClass("active");
    }
    else if (tabNameOnWhichButtonIsClicked == "address") {
        if (getVal("hid_accounts_access") == "1") {
            $("#account_info_tab_lnk").addClass("active");
            $("#account").addClass("active");
        }
        else {
            $("#doc_tab_lnk").addClass("active");
            $("#documents").addClass("active");
        }

        $("#address_tab_lnk").removeClass("active");
        $("#addresses").removeClass("active");
    }
    else if (tabNameOnWhichButtonIsClicked == "documents") {
        $("#items_tab_link").addClass("active");
        $("#Items").addClass("active");

        $("#doc_tab_lnk").removeClass("active");
        $("#documents").removeClass("active");
    }
    else if (tabNameOnWhichButtonIsClicked == "scope") {
        getObj("btn_Cancel_sup_Gen").click();
    }
}


//---------------------Added Add Balances in Action... Related js funtions are below-------------------------------------------//
//---------------------Added by BhatJavid-------------------------------------------------------------------------------------//
$("#btnSaveBalance").on('click', function () {

    var Caption = document.getElementById('btnSaveBalance').innerHTML;
    var Controls = "txtBalDate,txt_Invoice,txt_Debit,txt_Credit";
    if (setBorderColor_Validation(Controls)) {
        setBorderColor_Default(Controls);
        if (Caption == "Save") {

            Save_Balance()
        }
        else {
            Update_Balance();

        }


    }
    else {

        calltoast("Please fill the mandatory infromaton.", "error");
    }
});

function Save_Balance() {

    var InsertArray = getVal("Hid_SupplierMain") + "|" + getVal("txtBalDate") + "|" + getVal("txt_Invoice") + "|" + getVal("txt_Debit") + "|" + getVal("txt_Credit") + "|" + getVal("txt_Balance")

    $.ajax({
        url: 'H_tbl_Supplier.ashx',
        type: "POST",
        data: {
            'fun': 'Save_Balances', 'InsertArray': InsertArray
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                if (data > -1) {
                    calltoast("Data Saved Sucessfully", "success");
                    FetchBalances(getVal("Hid_SupplierMain"));

                    $('#rwaddbalance-add').slideUp();
                    $("#rwaddbalance-add").addClass("hide");
                    $("#rwarwaddbalanceplusddplus").removeClass("hide");
                    $("#btn-add").removeClass("hide");
                }


                // document.getElementById('btn_Save').innerHTML = 'Update';


            }
        }

    });


}

function Update_Balance() {
    //alert()
    var InsertArray = getVal("Sup_Bal_Id") + "|" + getVal("txtBalDate") + "|" + getVal("txt_Invoice") + "|" + getVal("txt_Debit") + "|" + getVal("txt_Credit") + "|" + getVal("txt_Balance") + "|" + getVal("Hid_SupplierMain")

    $.ajax({
        url: 'H_tbl_Supplier.ashx',
        type: "POST",
        data: {
            'fun': 'Update_Balance', 'InsertArray': InsertArray
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                if (data > -1) {
                    calltoast("Data Updated Sucessfully", "success");
                    FetchBalances(getVal("Hid_SupplierMain"));
                    $('#rwaddbalance-add').slideUp();
                    $("#rwaddbalance-add").addClass("hide");
                    $("#rwarwaddbalanceplusddplus").removeClass("hide");
                    $("#btn-add").removeClass("hide");
                }


                // document.getElementById('btn_Save').innerHTML = 'Update';


            }
        }

    });

}
function MarkClosedBal(Cust_Bal_Id) {
    $('#rwaddbalance-add').slideUp();
    $("#rwaddbalance-add").addClass("hide");
    $("#rwarwaddbalanceplusddplus").removeClass("hide");
    $("#btn-add").removeClass("hide");
    $.ajax({
        url: 'H_tbl_Supplier.ashx',
        type: "POST",
        data: {
            'fun': 'MarkClosedBal', 'Cust_Bal_Id': Cust_Bal_Id
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                calltoast("Maked Closed Sucessfully", "success");
                FetchBalances(getVal("Hid_SupplierMain"));
            }
        }
    });
}
function GetBalDetails(Cust_Bal_Id, operation) {
    SetVal("Sup_Bal_Id", Cust_Bal_Id)
    $.ajax({
        url: 'H_tbl_Supplier.ashx',
        type: "POST",
        data: {
            'fun': 'GetBalDetails', 'Cust_Bal_Id': Cust_Bal_Id
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                var arr = data.split('|');

                $('#txtBalDate').val(arr[0]);
                SetVal("txt_Invoice", arr[1]);
                SetVal("txt_Debit", arr[2]);
                SetVal("txt_Credit", arr[3]);
                SetVal("txt_Balance", arr[4])

                $('#rwaddbalance-add').slideDown();
                $("#rwaddbalance-add").removeClass("hide");
                $("#rwaddbalance-add").addClass("mt-20");
                $("#rwarwaddbalanceplusddplus").addClass("hide");
                $("#btn-add").addClass("hide");
                document.getElementById('btnSaveBalance').innerHTML = 'Update';
                if (operation.toString().trim() == "View") {
                    $('#txtBalDate').prop("disabled", true)
                    $('#txt_Invoice').prop("disabled", true)
                    $('#txt_Debit').prop("disabled", true)
                    $('#txt_Credit').prop("disabled", true)
                    $('#btnSaveBalance').prop("disabled", true)

                }
                else {
                    $('#txtBalDate').prop("disabled", false)
                    $('#txt_Invoice').prop("disabled", false)
                    $('#txt_Debit').prop("disabled", false)
                    $('#txt_Credit').prop("disabled", false)
                    $('#btnSaveBalance').prop("disabled", false)
                }
            }
        }

    });

}


function FetchBalances(Customer_id) {
    SetTodaysDate('#txtBalDate')
    SetVal("Hid_SupplierMain", Customer_id);
    //alert($('#Hid_CustomerMain').val())
    $('#rwaddbalance-add').slideUp();
    $("#rwaddbalance-add").addClass("hide");
    $("#rwarwaddbalanceplusddplus").removeClass("hide");
    $("#btn-add").removeClass("hide");
    $.ajax({
        url: 'H_tbl_Supplier.ashx',
        type: "POST",
        data: {
            'fun': 'fetchBalances', 'Customer_id': Customer_id
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {

                SetInnerVal("tbody_tblAddbalance", data);

            }
        }

    });
}

function calculateBal() {
    var Debit = getVal("txt_Debit")
    var credit = getVal("txt_Credit")
    var Balance = +Debit - credit

    SetVal("txt_Balance", Balance);
}
function SetTodaysDate(obj) {
    var date = new Date();
    Date.prototype.setDate = function () {
        var yyyy = this.getFullYear().toString();
        var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
        var dd = this.getDate().toString();
        return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]); // padding
    };
    $(obj).val(date.setDate());
}
function resetbalcontrols() {
    SetVal("txt_Invoice", "");
    SetVal("txt_Debit", "0.00");
    SetVal("txt_Credit", "0.00");
    SetVal("txt_Balance", "0.00")
    $('#txtBalDate').prop("disabled", false)
    $('#txt_Invoice').prop("disabled", false)
    $('#txt_Debit').prop("disabled", false)
    $('#txt_Credit').prop("disabled", false)
    $('#btnSaveBalance').prop("disabled", false)
    SetTodaysDate('#txtBalDate')
}

$("#btn-add").on('click', function () {
    resetbalcontrols();
    document.getElementById('btnSaveBalance').innerHTML = 'Save';
    $('#rwaddbalance-add').slideDown();
    $("#rwaddbalance-add").removeClass("hide");
    $("#rwaddbalance-add").addClass("mt-20");
    $("#rwarwaddbalanceplusddplus").addClass("hide");
    $("#btn-add").addClass("hide");
});

$("#btn-addbalance-close").on('click', function () {
    $('#rwaddbalance-add').slideUp();
    $("#rwaddbalance-add").addClass("hide");
    $("#rwarwaddbalanceplusddplus").removeClass("hide");
    $("#btn-add").removeClass("hide");
});



function SetSupplierId(SupplierId) {
    $('#Hid_SupplierMain').val(SupplierId);
    $('#ddlDivision').empty()
    $.ajax({
        url: 'H_tbl_Supplier.ashx',
        type: "POST",
        data: {
            'fun': 'Getddldiv'
        },
        success: function (data) {

            if (Chk_Res(data.errorMessage) == false) {
                var ddlData = JSON.parse(data)

                $.each(ddlData, function (i, obj) {
                    $('#ddlDivision').append($('<option>').text(obj.Division_Name).attr('value', obj.Division_Id));
                });
            }
        }
    });
}
function RedirectToSOA() {
    var Supplierid = $('#Hid_SupplierMain').val()
    var date = $('#txtDateFrom').val();
    var divId = $('#ddlDivision').val();
    window.location = "account-statement.aspx?Sup_id=" + Supplierid + "&Date=" + date + "&DivId=" + divId
}

//-------------------------------------------------------------------------------------------------------------------------//
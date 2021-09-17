<%@ Page Language="C#" AutoEventWireup="true" CodeFile="item-category.aspx.cs" Inherits="item_category" %>

<%@ Register Src="~/Modules/General/header.ascx" TagName="uch" TagPrefix="uc1" %>
<%@ Register Src="~/Modules/General/sidebar.ascx" TagName="ucs" TagPrefix="uc2" %>
<%@ Register Src="~/Modules/General/footer.ascx" TagName="ucf" TagPrefix="uc3" %>
<% 
    Session["top_menu"] = "items";
    Session["sub_menu"] = "item-category";
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="<%=G.B%>assets/images/favicon.ico">

    <title>SUS ERP - Item Category</title>
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/icon/icofont/css/icofont.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/jstree/css/style.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/treeview/treeview.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/icheck/skins/all.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">
    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet">
    <style>
    tr {
        cursor:pointer;
    }

</style>
</head>

<body class="hold-transition fixed skin-info-light sidebar-mini">
    <div class="wrapper">

        <uc1:uch ID="uch1" runat="server" />
        <uc2:ucs ID="ucs1" runat="server" />


        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content ">
                <div class="box">
                    <div class="box-body">



                        <div class="row">
                            <div class="col-lg-7">

                                <div class="row">
                                    <div class="col-lg-6">
                                        <h5>Item category</h5>
                                    </div>

                                    <div class="col-lg-6">
                                        <span class="btn btn-success right"  onclick="Set_CategoryModalFields_For_Add();"><i class="mdi mdi-plus plusicon" data-src="" data-title="Add Account Group"></i></span>
                                    </div>
                                </div>
                                <div class="row mt-10">
                                    <div class="col-lg-6 ">
                                        <select class="form-control select2  enq-dropdown" runat="server" id="ddl_Branch" onchange="Bind_Category_grid();">
                                        </select>
                                    </div>

                                    <div class="col-lg-6 ">
                                        <div class="">
                                            <div class="input-group">
                                                <input type="text" class="form-control  txtplaceholder" id="txt_Search_Account_Groups" placeholder="Search Items" onkeyup="Search_Cat();">
                                                <span class="search-btn"><i class="ti-search"></i></span>
                                            </div>
                                        </div>
                                    </div>


                                </div>
                                <hr />
                                <div class="row">


                                    <div class="col-lg-12 pr-5">
                                        <div class="tab-pane active" id="itemlistview" role="tabpanel">
                                            <div class="row">
                                                <div class="col-md-12">
                                                <%--    <div class="" style="height: 330px; overflow: auto"--%>
                                                        <div class="tableFixHead">
                                                        <table class="table table-hovertable-striped table-responsive table-bordered tblaccgrplv" id="tbl_Item_category">
                                                            <thead>
                                                                <tr>
                                                                    <th style="width:14%">Item  Type</th>
                                                                    <th>Category Name</th>

                                                                    <th>Category Code</th>
                                                                    <th>Action</th>

                                                                </tr>
                                                            </thead>
                                                            <tbody runat="server" id="tbody_Item_Category_List_View">
                                                            </tbody>
                                                        </table>
                                                            </div>
                                                <%--    </div>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <%--<div class="form-material mb-15">--%>

                                <%-- Table for Items STARTS --%>

                                <%-- Table for Items ENDS --%>
                            </div>
                            <div class="col-lg-5">

                                <div class="row">
                                    <div class="col-lg-6">

                                        <h5>Item Sub-category</h5>
                                    </div>

                                    <div class="col-lg-6">

                                        <span class="btn btn-success right"  onclick="Set_SubCategoryModalFields_For_Add();"><i class="mdi mdi-plus plusicon" data-src="" data-title="Add Sub Category"></i></span>
                                    </div>
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="listview" role="tabpanel">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="table-responsive">
                                                            <table class="table table-stripedtable-bordered tblaccgrplv">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Sub-Category Name</th>
                                                                        <%--                                                                            <th>Sub-Category Code</th>
                                                                            <th>Sub-Category Details</th>--%>
                                                                        <th>Sub-Category Prefix</th>
                                                                        <th>Action</th>

                                                                    </tr>
                                                                </thead>
                                                                <tbody runat="server" id="tbody_Item_Sub_Category_List_View">
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!-- /.box-body -->
                        </div>
                        <div class="box-footer mb-40 mt-10"></div>
                    </div>

                </div>
            </section>
        </div>
        <!-- /.content-wrapper -->

        <%--<uc3:ucf ID="ucf1" runat="server" />--%>

        <%-- Modal  Pop up for Category STARTS--%>
        <div class="modal fade  bs-example-modal-lg" id="mdpopup-category" data-backdrop="static">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><strong>Add Item Category</strong></h4>
                    </div>
                    <div class="modal-body">
                        <form novalidate class="ajax-form" id="frm-category-item">
                            <input type="hidden" id="hdf-item-id" value="">
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="col-md-12">Item Type</label>
                                    <div class="col-md-12">

                                        <div class="demo-radio-button" id='Item_Type'>
                                            <input name="group1"  type="radio" id="radio_1" value="1" class="clsType">
                                            <label for="radio_1">Stock</label>
                                            <input name="group1" type="radio" id="radio_2" value="2" class="clsType">
                                            <label for="radio_2">Non Stock</label>
                                           
                                            <input name="group1" type="radio" id="radio_3" value="3" class="clsType">
                                            <label for="radio_3">Service</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 col-lg-6">
                                    <div class="form-group">
                                        <label class="col-md-12">Item Category Name<span class="red-bold">&nbsp;*</span></label>
                                        <div class="col-md-12 controls">
                                            <input type="text" class="form-control " id="txt_Category_Name" tabindex="1" onblur="return ValidateOne(this);" maxlength="40" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12 mt-0">Branch Associated<span class="red-bold">&nbsp;*</span></label>
                                        <div class="col-md-12" id="Div_Branchs">
                                            <select class=" form-control h27select2" onblur="return ValidateOne(this);" tabindex="3 " runat="server" id="ddl_popup_Branch" onchange=""></select>
                                        </div>
                                    </div>



                                </div>
                                <div class="col-sm-12 col-lg-6 ">
                                    <div class="form-group display-none">
                                        <label class="col-md-12">Item Category Detail<span class="red-bold">&nbsp;*</span></label>
                                        <div class="col-md-12">
                                            <input type="text" onblur="return ValidateOne(this);" class="form-control " id="txt_Category_Details" />
                                        </div>
                                    </div>
                                    <div class="form-group ">
                                        <label class="col-md-12">Item Category Code<span class="red-bold">&nbsp;*</span></label>
                                        <div class="col-md-12 controls">
                                            <input type="text" onblur="return ValidateOne(this);" class="form-control " tabindex="2" id="txt_Category_Code" maxlength="20"/>

                                        </div>
                                    </div>

                                </div>

                                <div class="col-sm-12 col-lg-6">
                                </div>


                            </div>
                            <div class="row mt-5">
                                <div class="col-sm-12">
                                    <div class="box-footer">
                                        <div style="float: left;" class="ml-10">
                                            <button type="button" class="btn btn-dark" data-dismiss="modal" id="btn_Cancel_Category_Items">
                                                <i class="ti-trash"></i>Cancel
                                            </button>

                                        </div>
                                        <div class="text-right mr-10">
                                            <button id="btn_Save" type="button" tabindex="4" value="Save" class="btn btn-success">
                                                <i class="ti-save-alt pr-5"></i>Save
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%-- Modal  Pop up for Category  ENDS --%>

        <%-- Modal  Pop up for Sub Category STARTS--%>
        <div class="modal fade  bs-example-modal-lg" id="mdpopup-subcategory" data-backdrop="static">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><strong>Add Item Sub Category</strong></h4>
                    </div>
                    <div class="modal-body">
                        <form novalidate class="ajax-form" id="frm-sub-category-item">
                            <input type="hidden" id="hdf-subcat-id" value="">
                            <div class="row">
                                <div class="col-sm-12 col-lg-6">
                                    <div class="form-group">
                                        <label class="col-md-12">Item Sub Category Name <span class="red-bold">&nbsp;*</span></label>
                                        <div class="col-md-12 controls">
                                            <input type="text" onblur="return ValidateOne(this);" class="form-control " id="txt_Sub_Category_Name" maxlength="40" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12">Item Sub Category Code <span class="red-bold">&nbsp;*</span></label>
                                        <div class="col-md-12 controls">
                                            <input type="text" onblur="return ValidateOne(this);" class="form-control " id="txt_SubCategory_Code" maxlength="20" />

                                        </div>
                                    </div>

                                    <div class="row display-none">
                                        <div class="col-md-12">
                                            <label class="col-md-12">Item Sub Category Detail</label>
                                            <div class="col-md-12">
                                                <input type="text" onblur="return ValidateOne(this);" class="form-control " id="txt_SubCategory_Detail" />
                                            </div>
                                        </div>
                                    </div>
                                      <div class="form-group">
                                        <label class="col-md-12">Sub Division <span class="red-bold">&nbsp;*</span></label>
                                        <div class="col-md-12">
                                            <select class=" form-controlh27 select2" runat="server" onblur="return ValidateOne(this);" id="ddlSubDivision" ></select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-lg-6">
                                    <div class="form-group">
                                        <label class="col-md-12">Item Sub Category Prefix <span class="red-bold">&nbsp;*</span></label>
                                        <div class="col-md-12">
                                            <input type="text" onblur="return ValidateOne(this);" class="form-control " id="txt_SubCategory_Prefix" maxlength="6" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12">Item Category <span class="red-bold">&nbsp;*</span></label>
                                        <div class="col-md-12">
                                            <select class=" form-controlh27 select2"  onblur="return ValidateOne(this);" id="ddl_Item_Category" onchange=""></select>
                                        </div>
                                    </div>
                                  
                                </div>

                                <div class="col-sm-12 col-lg-6">
                                </div>


                            </div>
                            <div class="row mt-5">
                                <div class="col-sm-12">
                                    <div class="box-footer">
                                        <div style="float: left;" class="ml-10">
                                            <button type="button" class="btn btn-dark" data-dismiss="modal" id="btn_Cancel_SubCategory_Items">
                                                <i class="ti-trash"></i>Cancel
                                            </button>

                                        </div>
                                        <div class="text-right mr-10">
                                            <button id="btn_Sub_Save" type="button" class="btn btn-success">
                                                <i class="ti-save-alt pr-5"></i>Save
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%-- Modal  Pop up for Sub Category  ENDS --%>
    </div>




    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-ui/jquery-ui.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.js"></script>
    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>
    <script src="<%=G.B%>assets/vendor_components/icheck/icheck.js"></script>

    <script src="<%=G.B%>assets/vendor_components/jstree/js/jstree.min.js"></script>

    <script src="<%=G.B%>assets/js/template.js"></script>
    <script src="<%=G.B%>assets/js/demo.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
    <script src="../General/libo.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.select2').select2();
        });


        function calltoast(msg, msgtype) {
            $.toast({
                heading: '',
                text: msg,
                position: 'top-right',
                loaderBg: '#ff6849',
                icon: msgtype,
                hideAfter: 3000,
                stack: 6
            });
        }


       

        //Bind_Category_grid 
        //Save_Category
        //Set_CategoryModalFields_For_Add
        //Set_CategoryModalFields_For_Edit
        //Bind_Categories_to_ddl
        //Save_SubCategory
        //Populate_SubCategoryList
        //
        //$('table#tbl_Item_category tr td:not(:last-child)').click(function () {
        //    // $(this).parent().css("background-color", "rgba(0, 0, 0, 0.075)");
        //    //$(this).parent().css("background-color", "rgba(0, 0, 0, 0.075)");
        //    var jdata = "{'itemCategoryId':'" + $(this).parent().find(":hidden").val() + "','branchId':'" + getVal("ddl_Branch") + "'}";
        //    Populate_SubCategoryList(jdata);
        //});

        function Bind_Category_grid() {
            var jdata = "{'Branch_Id':'" + getVal("ddl_Branch") + "'}";
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Bind_Item_category_To_List_View",
                data: jdata,
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        //console.log(data);
                        if (data.d.indexOf("!error!") > -1) {
                            alert("There is an Error:----> " + data.d);
                        }
                        else {
                            $('#tbody_Item_Category_List_View').html(data.d);
                            Populate_SubCategoryList(-1)
                        }
                    }
                }
            });
        }
       




        function Save_Category() {

            var Item_Type = $("input[name='group1']:checked").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Save_Category",
                data: "{'Branch_Id':'" + getVal("ddl_popup_Branch") + "','Item_Category_Name':'" + getVal("txt_Category_Name") + "','Item_Category_Code':'" + getVal("txt_Category_Code") + "','Item_Type':'" + Item_Type + "'}",
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        if (data.d.indexOf("!error!") > -1) {
                            alert("There is an Error:----> " + data.d);
                        }
                        else {

                            $('#txt_Category_Name').prop('value', '');
                            $('#txt_Category_Code').prop('value', '');
                            $('#txt_Category_Details').prop('value', '');

                            $('#ddl_popup_Branch option').removeAttr('selected').filter('[value="291"]').attr('selected', true)
                            calltoast('Saved Successfully', 'success');
                            $("#mdpopup-category").modal("hide");
                            //  window.open("item-category.aspx")
                           
                            //calltoast('Item Category Saved Successfully', 'success');
                            Bind_Category_grid();
                        }
                    }
                }
            });
        }

        function Set_CategoryModalFields_For_Add() {
            $.ajax({
                url: 'H_tbl_Item.ashx',
                type: "POST",
                data: { 'fun': 'CheckSession' },
                success: function (data) {
                    if (Chk_Res(data.errorMessage) == false) {
                        $('#mdpopup-category h4').text("Add Item Category");
                        $('#txt_Category_Name').prop('value', '');
                        $('#txt_Category_Code').prop('value', '');
                        $('#txt_Category_Details').prop('value', '');
                        var BranchId = $('#ddl_Branch').val();
                        $('#ddl_popup_Branch option').removeAttr('selected').filter('[value=' + BranchId.toString() + ']').attr('selected', true)
                        var abc = document.getElementById('btn_Save').innerHTML;
                        if (abc.includes('Update')) {

                            document.getElementById('btn_Save').innerHTML = '<i class="ti-save-alt pr-5"></i>Save';
                        }
                        $('#mdpopup-category').modal('toggle');
                    }
                }
            });
        }

        function Set_SubCategoryModalFields_For_Add() {
            $.ajax({
                url: 'H_tbl_Item.ashx',
                type: "POST",
                data: { 'fun': 'CheckSession' },
                success: function (data) {

                    if (Chk_Res(data.errorMessage) == false) {
                        $('#mdpopup-subcategory h4').text("Add Item Sub_Category");
                        Bind_Categories_to_ddl();

                        $('#txt_Sub_Category_Name').prop('value', '');
                        $('#txt_SubCategory_Code').prop('value', '');
                        $('#txt_SubCategory_Detail').prop('value', '');
                        $('#txt_SubCategory_Prefix').prop('value', '');
                        $('#ddlSubDivision').val(0)
                        // Bind_Categories_to_ddl();
                        // document.getElementById('btn_Save').innerHTML = '<i class="ti-save-alt pr-5"></i>Save';

                        var abc = document.getElementById('btn_Sub_Save').innerHTML;
                        if (abc.includes('Update')) {

                            document.getElementById('btn_Sub_Save').innerHTML = '<i class="ti-save-alt pr-5"></i>Save';
                        }

                        $('#mdpopup-subcategory').modal('toggle');
                    }
                }
            });

        }


        var ItemCat_Id = "0";
        function Set_CategoryModalFields_For_Edit(Item_Category_Id) {
            // $('#ddl_popup_Branch').val(Item_Category_Id).change();
           
            ItemCat_Id = Item_Category_Id;
            $('#mdpopup-category h4').text("Edit Item Category");
            // $('#ddl_Item_Category').val(292);
            // $.get("item-category.aspx/Edit_BindBack_Category");
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Edit_BindBack_Category",
                data: "{'Item_Category_Id':'" + Item_Category_Id + "'}",
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        if (data.d.indexOf("!error!") > -1) {
                            alert("There is an Error:----> " + data.d);
                        }
                        else {
                            var abc = document.getElementById('btn_Save').innerHTML;
                            if (abc.includes('Save')) {

                                document.getElementById('btn_Save').innerHTML = '<i class="ti-save-alt pr-5"></i>Update';
                            }
                            // $("div.Div_Branchs select").val(data.d[0].toString());
                            // $('#ddl_popup_Branch option[value=294]').prop('selected');

                            $('#ddl_popup_Branch option').removeAttr('selected').filter('[value=' + data.d[0].toString() + ']').attr('selected', true)
                            SetVal('txt_Category_Name', data.d[2].toString());
                            SetVal('txt_Category_Code', data.d[1].toString());
                            SetVal('txt_Category_Details', data.d[3].toString());
                            if (data.d[4].toString() == "1")
                            {
                                $('#radio_1').attr('checked', 'checked');
                                $('#radio_2').removeAttr('checked');
                                $('#radio_3').removeAttr('checked');
                            }
                            else if (data.d[4].toString() == "2") {
                                $('#radio_2').attr('checked', 'checked');
                                $('#radio_1').removeAttr('checked');
                                $('#radio_3').removeAttr('checked');
                            }
                            else {
                                $('#radio_1').removeAttr('checked');
                                $('#radio_2').removeAttr('checked');
                                $('#radio_3').attr('checked', 'checked');

                            }


                        }
                    }
                }
            });
        }


        function Save_Update() {
            var abc = document.getElementById('btn_Save').innerHTML;
            if (abc.includes('Save')) {
                Save_Category();
            }
            else { Update_Category(); }

        }

        function Update_Category() {
            var Item_Type = $("input[name='group1']:checked").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Update_Category",
                data: "{'Branch_Id':'" + getVal("ddl_popup_Branch") + "','Item_Category_Name':'" + getVal("txt_Category_Name") + "','Item_Category_Code':'" + getVal("txt_Category_Code") + "','Category_Details':'" + getVal("txt_Category_Details") + "','Item_Type':'" + Item_Type + "','ItemCat_Id':'" + ItemCat_Id + "'}",
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        if (data.d.indexOf("!error!") > -1) {
                            alert("There is an Error:----> " + data.d);
                        }
                        else {


                            $('#txt_Category_Name').prop('value', '');
                            $('#txt_Category_Code').prop('value', '');
                            $('#txt_Category_Details').prop('value', '');
                            //document.getElementById(''btn_Save).innerHTML = '<i class="ti-save-alt pr-5"></i>Save';
                            $('#ddl_popup_Branch option').removeAttr('selected').filter('[value="291"]').attr('selected', true)
                            var jdata = "{'itemCategoryId':'" + $(this).parent().find(":hidden").val() + "','branchId':'" + getVal("ddl_Branch") + "'}";
                            $("#mdpopup-category").modal("hide");
                            
                            calltoast('Item Category Updated Successfully', 'success');
                            Bind_Category_grid();

                        }
                    }
                }
            });
        }





        function Bind_Categories_to_ddl() {
            
            var mySelect = $('#ddl_Item_Category');
            $('#tbl_Item_category tbody  tr').each(function () {
                var optionsText = $(this).find("td").eq(1).text();
                var optionsValue = $(this).find("input[name='itemcatId']").val();
                mySelect.append(
                    $('<option></option>').val(optionsValue).html(optionsText)
                );
            });


        }

        function Save_SubCategory() {

            var Item_Type = $("input[name='group1']:checked").val();

            var jdata = "{'Item_Sub_Category_Id':'0','Item_Sub_Category_Name':'" + getVal("txt_Sub_Category_Name") + "','Item_Sub_Category_Code':'" + getVal("txt_SubCategory_Code") + "','Item_Sub_Category_Detail':'" + getVal("txt_SubCategory_Detail") + "','Item_Sub_Category_Prefix':'" + getVal("txt_SubCategory_Prefix") + "','Item_Category_Id':'" + $('#ddl_Item_Category').val() + "','Item_Type':'" + Item_Type + "','SubDiv':'" + $('#ddlSubDivision').val() + "'}";
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Save_SubCategory",
                data: jdata,
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        $('#txt_Sub_Category_Name').prop('value', '');
                        $('#txt_SubCategory_Code').prop('value', '');
                        $('#txt_SubCategory_Detail').prop('value', '');
                        $('#txt_SubCategory_Prefix').prop('value', '');
                        Bind_Categories_to_ddl();
                        document.getElementById('btn_Save').innerHTML = '<i class="ti-save-alt pr-5"></i>Save';
                        
                       // ReBind_Category();
                        $("#mdpopup-subcategory").modal("hide");
                        // location.reload();

                        var jdata = "{'itemCategoryId':'" + -1 + "','branchId':'" + getVal("ddl_Branch") + "'}";


                        calltoast('Item Sub Category Saved Successfully', 'success');
                        Populate_SubCategoryList($('#ddl_Item_Category').val());
                       

                    }
                }
            });
        }


        function Populate_SubCategoryList(Item_Category_Id) {
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Bind_Item_Sub_Category_To_List_View",
                data: "{'itemCategoryId':'" + Item_Category_Id + "','branchId':'" + getVal("ddl_Branch") + "'}",
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        if (data.d.indexOf("!error!") > -1) {
                            alert("There is an Error:----> " + data.d);
                        }
                        else {
                            $('#tbody_Item_Sub_Category_List_View').html(data.d);
                        }
                    }
                }
            });
        }

       // function AlphaNumaricOnly()
        // { $("#txt_SubCategory_Prefix").alphaNumericOnly(); }


        $('#txt_SubCategory_Prefix').keyup(function () {
           
            var inputVal = $(this).val().toString();
            var characterReg = /^\s*[a-zA-Z0-9,\s]+\s*$/;
            if (!characterReg.test(inputVal)) {
                var abc = $('#txt_SubCategory_Prefix').val().substring(0, inputVal.length - 1);
                //  $('#txt_SubCategory_Prefix').val = $('#txt_SubCategory_Prefix').val().substring(0, inputVal - 1);
                $('#txt_SubCategory_Prefix').prop('value', abc);
            }
        });




        function Save_Update_SubCat() {
            var abc = document.getElementById('btn_Sub_Save').innerHTML;

            if (abc.includes('Save')) {
                Save_SubCategory();
            }
            else {
                Update_Sub_Category();
            }

        }

        var Item_SubCat_Id = "0";
        function Set_SubCategoryModalFields_For_Edit(Item_SubCategory_Id) {
           
            Item_SubCat_Id = Item_SubCategory_Id;
            $('#mdpopup-subcategory h4').text("Edit Item Sub-Category");
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Edit_BindBack_SubCategory",
                data: "{'Item_SubCategory_Id':'" + Item_SubCategory_Id + "'}",
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        if (data.d.indexOf("!error!") > -1) {
                            alert("There is an Error:----> " + data.d);
                        }
                        else {
                            var abc = document.getElementById('btn_Sub_Save').innerHTML;
                            if (abc.includes('Save')) {

                                document.getElementById('btn_Sub_Save').innerHTML = '<i class="ti-save-alt pr-5"></i>Update';
                            }
                            // $("div.Div_Branchs select").val(data.d[0].toString());
                            // $('#ddl_popup_Branch option[value=294]').prop('selected');
                            Bind_Categories_to_ddl();
                            $('#ddl_Item_Category option').removeAttr('selected').filter('[value=' + data.d[0].toString() + ']').attr('selected', true)
                            SetVal('txt_Sub_Category_Name', data.d[2].toString());
                            SetVal('txt_SubCategory_Code', data.d[1].toString());
                            SetVal('txt_SubCategory_Prefix', data.d[4].toString());
                            SetVal('txt_SubCategory_Detail', data.d[3].toString());
                            $('#ddlSubDivision option').removeAttr('selected').filter('[value=' + data.d[5].toString() + ']').attr('selected', true)
                            $('.select2').select2();
                            //alert(data.d[5])
                           // location.reload();


                        }
                    }

                }
            });
        }

        function Update_Sub_Category() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Update_Sub_Category",
                data: "{'Item_Category_Id':'" + getVal("ddl_Item_Category") + "','Item_SubCategory_Name':'" + getVal("txt_Sub_Category_Name") + "','Item_SubCategory_Code':'" + getVal("txt_SubCategory_Code") + "','Item_SubCategory_Detail':'" + getVal("txt_SubCategory_Detail") + "','Item_Code_Prefix':'" + getVal("txt_SubCategory_Prefix") + "','Item_SubCat_Id':'" + Item_SubCat_Id + "','SubDiv':'" + getVal("ddlSubDivision") + "'}",
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        $('#txt_Sub_Category_Name').prop('value', '');
                        $('#txt_SubCategory_Code').prop('value', '');
                        $('#txt_SubCategory_Detail').prop('value', '');
                        $('#txt_SubCategory_Prefix').prop('value', '');
                      //  Bind_Categories_to_ddl();
                        document.getElementById('btn_Save').innerHTML = '<i class="ti-save-alt pr-5"></i>Save';
                       // ReBind_Category();
                        $("#mdpopup-subcategory").modal("hide");
                        // location.reload();
                        var jdata = "{'itemCategoryId':'" + -1 + "','branchId':'" + getVal("ddl_Branch") + "'}";
                    
                       
                        calltoast('Item Sub Category Updated Successfully', 'success');
                        Populate_SubCategoryList($('#ddl_Item_Category').val());
                        //Populate_SubCategoryList(jdata);

                        //$('#tbody_Item_Category_List_View tr td').click(function () {
                        //    // $(this).parent().css("background-color", "rgba(0, 0, 0, 0.075)");
                        //    //$(this).parent().css("background-color", "rgba(0, 0, 0, 0.075)");
                        //    var jdata = "{'itemCategoryId':'" + $(this).parent().find(":hidden").val() + "','branchId':'" + getVal("ddl_Branch") + "'}";
                        //    Populate_SubCategoryList(jdata);
                        //});

                        
                       


                    }
                }
            });
        }

        $('#btn_Save').on('click', function () {
            var Controls = "txt_Category_Name,txt_Category_Code,ddl_popup_Branch";
            if (setBorderColor_Validation(Controls)) {
                Save_Update();
            } else { calltoast("Please fill the mandatory infromaton.", "error"); }

        });


        $('#btn_Sub_Save').on('click', function () {
            var Controls = "txt_Sub_Category_Name,txt_SubCategory_Code,txt_SubCategory_Prefix,ddl_Item_Category";
            if (setBorderColor_Validation(Controls)) {
                
                Save_Update_SubCat();
            } else { calltoast("Please fill the mandatory infromaton.", "error"); }

        });

        function Search_Cat() {
            SearchPreFix = $('#txt_Search_Account_Groups').val();

            Search_Category(SearchPreFix);



        }



        function Search_Category(SearchPreFix) {
            var Branch_Id = $('#ddl_Branch').val();
            //var SearchPreFix = $('#txt_Search_Account_Groups').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Search_Category",
                data: "{'SearchPreFix':'" + SearchPreFix + "','Branch_Id':'" + Branch_Id + "'}",
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        //  document.getElementById('txt_Search_Account_Groups').innerHTML = data.d;
                        SetInnerVal('tbody_Item_Category_List_View', data.d);

                    }
                }
            });
        }


        function ReBind_Category() {
            var Branch_Id = $('#ddl_Branch').val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "item-category.aspx/Bind_Item_category_To_List_View",
                data: "{'Branch_Id':'" + Branch_Id + "'}",
                dataType: "json",
                success: function (data) {
                    if (Chk_Res(data.d) == false) {
                        SetInnerVal('tbody_Item_Category_List_View', data.d);

                    }
                }
            });
        }
        $('.select2').select2();

    </script>
    <script>

$(document).ready(function(){
    $('#ddl_Item_Category').blur(function () { $('#btn_Sub_Save').focus(); });

});

</script>
</body>



</html>

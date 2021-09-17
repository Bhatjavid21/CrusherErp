<%@ Page Language="C#" AutoEventWireup="true" CodeFile="items.aspx.cs" Inherits="items" %>


<%@ Register Src="../General/header.ascx" TagName="header" TagPrefix="uc1" %>

<%@ Register Src="../General/sidebar.ascx" TagName="sidebar" TagPrefix="uc2" %>

<%@ Register Src="../General/footer.ascx" TagName="footer" TagPrefix="uc3" %>

<% 
    Session["top_menu"] = "items";
    Session["sub_menu"] = "item";
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../assets/images/favicon.ico">
    <title>Items - Trading ERP</title>
    <!-- Bootstrap 4.0-->
    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/bootstrap/dist/css/bootstrap.css">
    <style>.clk {cursor:pointer;}</style>
    <!-- Data Table-->
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/vendor_components/datatable/datatables.min.css" />

    <!-- Bootstrap extend-->
    <link rel="stylesheet" href="<%=G.B%>assets/css/bootstrap-extend.css">

    <link href="<%=G.B%>assets/vendor_components/select2/dist/css/select2.min.css" rel="stylesheet" />

    <!-- toast CSS -->
    <link rel="stylesheet" type="text/css" href="<%=G.B%>assets/js/froiden-helper/helper.css">

    <link href="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.css" rel="stylesheet">

    <!-- theme style -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/master_style.css">

    <!-- Al Manal skins -->
    <link rel="stylesheet" href="<%=G.B%>assets/css/skins/_all-skins.css">




    <link href="<%=G.B%>assets/vendor_components/sweetalert/sweetalert.css" rel="stylesheet" type="text/css">


    <link rel="stylesheet" href="<%=G.B%>assets/vendor_components/icheck/skins/all.css">
    <style>
        .fntbld {
            font-weight: bold !important;
        }
        .table>thead>tr>th{
            white-space:nowrap;
        }
    </style>

</head>

<body class="hold-transition skin-info-light fixed sidebar-mini">
    <input type="hidden" id="baseurl" name="baseurl" value="<%=G.B %>" />


    <div class="wrapper">

        <!-- Header Start -->
        <uc1:header ID="header1" runat="server" />
        <!-- Header end -->

        <!-- Sidebar Start -->
        <!-- Left side column. contains the logo and sidebar -->
        <uc2:sidebar ID="sidebar1" runat="server" />
        <!-- Sidebar End -->

        <input type="hidden" name="hdf_branch_id" id="hdf_branch_id" runat="server">
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Main content -->
            <section class="content mt-20">

                <div class="box">

                    <div class="box-header display-none">
                        <div class="row m-10">
                            <div class="col-10">

                                <h4 class="page-title">Item List</h4>
                            </div>
                            <%-- <div class="right-title col-md-2 text-right">
                                        <i class="mdi mdi-plus plusicon additemlist"></i>
                                    </div>--%>
                        </div>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-lg-2">
                                <div class="form-group  validate">
                                    <%-- <label class="" for="exampleInputEmail1">Branch</label>--%>
                                    <select onchange="Bind_From_First();" runat="server"  id="DDL_Branch" class="form-control enq-txtbx-pd fnt12 mb-5 enq-dropdown select2" aria-invalid="false"></select>
                                </div>
                            </div>
                         

                            
                            <div class="col-md-2">
                                <div class="form-group input-group ">
                                    <select name="ddl_item_category" id="ddl_item_category"  runat="server" onchange="Bind_From_First();" class="form-control enq-txtbx-pd fnt12 mb-5 enq-dropdown select2" aria-invalid="false">
                                        </select>
                                </div>

                            </div>
                               <div class="col-lg-3">
                                <div class="form-group mb-15">
                                    <%-- <label class="" for="exampleInputEmail1">Search Item</label>--%>
                                    <div class="input-group">
                                        <input type="text" id="txtinput" onkeyup="Javascript: if (event.keyCode == 13 || event.keyCode == 8 || event.keyCode == 46){SetVal('hid_page', '1'); Bind_Item_grid_N();}" placeholder="Search" class="form-control enq-txtbx-pd fnt12 " title="This search brings all relevant results from Item Category, Item Sub-Category, Item Code, OEM Reference, Item Description, Customer Item Code and Customer Item Description fields.">
                                        <span class="search-btn"><i class="ti-search"></i></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3">
                                <div class="form-group mb-15">
                                    <%--   <label class="" for="exampleInputEmail1">Item Type</label>--%>
                                    <div class="input-group">

                                        <table>
                                            <tr>
                                                <td>
                                                    <div class="form-group input-group  ml-0">
                                                        <div class="checkbox text-xs-left  fnt12 ">
                                                            <ul class="icheck-list">

                                                                <li>
                                                                    <div class="iradio_line-red grp2 checked leave-left-border checked" id="div_all" onclick="filter(this, '0')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="All" id="btn_all" data-id="0" />
                                                                        All<ins class="iCheck-helper"></ins>
                                                                    </div>
                                                                </li>

                                                                <li>
                                                                    <div class="iradio_line-red grp2" id="div_stock" onclick="filter(this, '1')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Prospects" id="btn_prospect" data-id="0" style="position: absolute; opacity: 0;" />
                                                                        Stock <ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; border: 0px none; opacity: 0;"></ins>
                                                                    </div>
                                                                </li>


                                                                <li style="padding-left: 1px;">
                                                                    <div class="iradio_line-red grp2" id="div_non_stock" onclick="filter(this, '2')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Blacklisted" id="btn_blacklisted" data-id="0" style="position: absolute; opacity: 0;" />
                                                                        Non Stock <ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; border: 0px none; opacity: 0;"></ins>
                                                                    </div>
                                                                </li>


                                                                <li style="padding-left: 1px;">
                                                                    <div class="iradio_line-red grp2 leave-right-border" id="div_service" onclick="filter(this, '3')">
                                                                        <input type="radio" class="check" name="grpfor" data-radio="iradio_line-red grp2" data-label="Service" id="rb_service" data-id="0" style="position: absolute; opacity: 0;" />
                                                                        Service <ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; border: 0px none; opacity: 0;"></ins>
                                                                    </div>
                                                                </li>
                                                                <li><i class="mdi mdi-information-outline" title="Clicking on any of the tiles' filters the listed Items based on their Type"></i></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>

                                        </table>


                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1 ">
                                <span id="span_excel">
                                    <a href="#" id="btn_Download_Item" target="_blank" class="btn btn-success" title="Download Item Checklist"><i class="fa fa-download"></i></a>
                                </span>

                                

                            </div>
                            <div class="col-md-1 ">
                                <div class="form-group  right">
                                    <button class="btn btn-success  additemlist"><i class="mdi mdi-plus plusicon "></i>Add</button>
                                </div>
                            </div>

                        </div>
                        <hr />
                        <div class="row mb-40">
                            <div class="col-md-12 pr-0 tableFixHead " >
                                <table id="tbl_itemlist" class="table table-bordered table-striped table-responsive" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th class="sorting fntbld clk" id="b-item_type">Item Type</th>
                                            <th class="sorting fntbld clk" id="a-Item_SubCategory_Name">Item Sub Category</th>
                                            <th class="sorting fntbld clk" id="b-item_code">Item Code</th>
                                            <th class="sorting fntbld clk" id="b-Item_Description">Description</th>
                                            <th class="sorting fntbld">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbody_itemTable">
                                    </tbody>
                                </table>
                                <div class="row mt-10">
                                        
                                    </div>
                                    <div class="box-footer mb-40">

                                        

                                    </div>
                            </div>
                        </div>
                        <!-- /.box-body -->
                        <div class="col-md-12" id="div_pagging" runat="server"></div>
                        <!-- /.box -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Popup Model Plase Here -->
        <div class="modal fade  bs-example-modal-lg" tabindex="" role="dialog" modal-backdrop="static">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel"></h4>
                        <input type="hidden" id="detailsId" name="detailsId" value="" />
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    </div>
                    <div class="modal-body">
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /Popup Model Plase Here -->



        <!-- /Popup Model Plase Here -->

        <!--footer Start -->
        <%--<uc3:footer ID="footer1" runat="server" />--%>
        <!-- footer end -->

    </div>
    <!-- ./wrapper -->
        <input type="hidden" id="hid_page" value="0" />
    <input type="hidden" id="hid_SortField" value="order by B.Item_Id desc" />


    <script>
        //  filter("div_all", 0);
    </script>

    <!-- jQuery 3 -->
    <script src="<%=G.B%>assets/vendor_components/jquery-3.3.1/jquery-3.3.1.js"></script>

    <!-- popper -->
    <script src="<%=G.B%>assets/vendor_components/popper/dist/popper.min.js"></script>

    <!-- Bootstrap 4.0-->
    <script src="<%=G.B%>assets/vendor_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- SlimScroll -->
    <script src="<%=G.B%>assets/vendor_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>


    <!-- FastClick -->
    <script src="<%=G.B%>assets/vendor_components/fastclick/lib/fastclick.js"></script>



    <!-- This is data table -->
    <script src="<%=G.B%>assets/vendor_components/datatable/datatables.min.js"></script>

    <!-- Form validator JavaScript -->
    <script src="<%=G.B%>assets/js/pages/validation.js"></script>
    <script src="<%=G.B%>assets/js/pages/form-validation.js"></script>

    <!-- toast -->
    <script src="<%=G.B%>assets/js/bootstrap-growl.min.js"></script>
    <script src="<%=G.B%>assets/js/froiden-helper/helper.js"></script>
    <script src="<%=G.B%>assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>

    <!-- Al Manal App -->
    <script src="<%=G.B%>assets/js/template.js"></script>

    <!-- Al Manal for demo purposes -->
    <script src="<%=G.B%>assets/js/demo.js"></script>

    <script src="<%=G.B%>assets/vendor_components/select2/dist/js/select2.full.js"></script>

    <script src="<%=G.B%>assets/vendor_components/sweetalert/sweetalert.min.js"></script>

    <script src="../General/libo.js"></script>

    <script src="item.js"></script>


    <script>

        

        function Bind_Item_grid_N() {
            var res = "Data not found.", Branch_Id = $("#DDL_Branch").val(),SortByField = getVal("hid_SortField"), page_no=getVal("hid_page").trim(), searchTerm=$("#txtinput").val(), subcatid=getVal("ddl_item_category");
            
            $.ajax({
                url: "H_tbl_Item.ashx",
                type: "POST",
                data: { 'fun': 'View_Item', "itemType": item_type, "searchTerm": searchTerm, 'PageNo': page_no, "branchid": Branch_Id, "SortByField": SortByField, 'SubCatId': subcatid },

                success: function (data) {
                    if (Chk_Res(data.errorMessage) == false) {
                        var M_splt = data.split('^^'), rw, r, pagging_html,cel = ""; res = "";
                        r = M_splt[0];
                        pagging_html = M_splt[1];
                        rw = r.split('~');

                        for (var i = 0; i <= rw.length-2; i++) {
                            cel = rw[i].split('||'); 
                            res += "<tr><td>" + IT(cel[1]) + "</td><td>" + cel[2] + "</td><td>" + cel[3] + "</td><td>" + cel[4] + "</td><td>" + AC(cel[0]) + "</td></tr>";
                        }
                        SetInnerVal("tbody_itemTable", res);
                        SetInnerVal("div_pagging", pagging_html.replace("|", ""));
                    }
                }

            });
        }

        
        

        //// SEARCH TextBOX Keypress
        //getObj("txtinput").addEventListener('keyup', function (e) {
            
           
        //        SetVal("hid_page", "1");
                
        //        alert(e.keyCode)
            
        //});


        function AC(itemid) {
            var straction = '<div class="btn-group">';
            straction += '          <button data-toggle="dropdown" class="btn btn-outline btn-default dropdown-toggle" aria-expanded="true">';
            straction += '                           <span><i class="ti-settings"></i></span>';
            straction += '                        </button>';
            straction += '                       <ul class="dropdown-menu dropdown-menu-right">';
            straction += '                            <li><a href="javascript:void(0)" data-id="' + itemid + '" class="dropdown-item lnkitemdetails"><i class="fa fa-eye"></i>Details</a></li>';
            straction += '                              <li class="dropdown-divider"></li>';
            straction += '                              <li><a href="javascript:void(0)" data-id="' + itemid + '"  class="dropdown-item lnkitemedit"><i class="fa fa-pencil"></i>Edit</a></li>';
            straction += '                             <li class="dropdown-divider"></li>';
            straction += '                              <li><a href="javascript:void(0)" data-id="' + itemid + '" class="dropdown-item lnkitemdelete"><i class="fa fa-trash"></i>Delete</a></li>';
            straction += '                   </ul></div>'; return straction;
        }



        function IT(type) { var strtype = ""; if (type == 1) { strtype = "Stock"; } else if (type == 2) { strtype = "Non Stock"; } else { strtype = "Service"; } return strtype; }


        function pageNo(pno) {
            
            SetVal("hid_page", pno);
            
            setTimeout(function () { Bind_Item_grid_N() }, 400);
        }



        function Header_Sort(field) {

            var SortByField = "", column = "#" + getObj(field).id

            if ($(column).hasClass("sorting") || $(column).hasClass("sorting_desc")) {

                $(column).removeClass("sorting");
                $(column).removeClass("sorting_desc");
                $(column).addClass("sorting_asc")
                SortByField = " order by " + field + " asc ";
                SetVal("hid_SortField", SortByField);
            }
            else if ($(column).hasClass("sorting_asc") || $(column).hasClass("sorting_asc")) {
                $(column).removeClass("sorting");
                $(column).removeClass("sorting_asc")
                $(column).addClass("sorting_desc")
                SortByField = " order by " + field + " desc "
                SetVal("hid_SortField", SortByField);
            }
            else { alert("no match"); }

            SetVal("hid_page", "1");
            setTimeout(function () { Bind_Item_grid_N() }, 1000);
        }


        $('.clk').click(function () { Header_Sort(this.id) });


        $(document).ready(function () {

            //Edit Modal Popup
            $(document).on("click", ".lnkitemedit", function (e) {
                var itemId = $(this).attr("data-id");
                var url = "edit-item.aspx?itemid=" + itemId;

                $.easyBlockUI("body");
                $.ajaxModal('.modal', url);
                $(".modal .modal-title").text("Edit Item");
                $.unblockUI();


                $('#detailsId').val("no");

                var strqry = "item_id=" + itemId + "&fun=Edit_Item";

                $.easyAjax({
                    url: "H_tbl_Item.ashx",
                    data: strqry,
                    type: "POST",
                    success: function (response) {
                        $.easyBlockUI("body");
                        var itemlist = response.itemvalue.split("|");
                        $('#hdf-item-id').val(itemId);
                        $('group1').val(itemlist[0]);
                        if (itemlist[0] == 1) {
                            $('#radio_1').attr("checked", true);
                        }
                        else if (itemlist[0] == 2) {
                            $('#radio_2').attr("checked", true);
                        }
                        else if (itemlist[0] == 3) {
                            $('#radio_3').attr("checked", true);
                        }

                        populate_dropdown(url, itemlist[0], itemlist[1], $("#hdf_branch_id").val());


                        $('#ddl_item_Sub_Category').val(itemlist[1]);

                        $('#txt_ItemCode').val(itemlist[2]);
                        $('#txt_new_item_code').val(itemlist[3]);
                        $('#txt_brand').val(itemlist[4]);
                        $('#txt_manufacturer').val(itemlist[5]);
                        $('#txt_oem_reference').val(itemlist[6]);
                        $('#txt_capacity').val(itemlist[7]);
                        $('#txt_unit').val(itemlist[8]);
                        $('#txt_Minimum_Margin').val(itemlist[9]);
                        $('#txt_VAT_Percent').val(itemlist[10]);
                        $('#txt_description').val(itemlist[11]);
                        $('#txt_long_description').val(itemlist[12]);
                        $('#txt_arabic_description').val(itemlist[13]);
                        $('#txt_barcode').val(itemlist[14]);
                        $('#txt_hsecode').val(itemlist[15]);
                        $('#txt_Storage_temprature').val(itemlist[16]);
                        $('#txt_Lenght').val(itemlist[17]);
                        $('#txt_Width').val(itemlist[18]);
                        $('#txt_Height').val(itemlist[19]);
                        $('#chk_has_expiry').val(itemlist[20]);
                        $('#chk_has_Warrenty').val(itemlist[21]);
                        $('#txt_wholesale_quantity').val(itemlist[22]);
                        $('#txt_wholesale_margin').val(itemlist[23]);

                        $.unblockUI();
                    }
                });

            });

            //Details Modal Popup
            $(document).on("click", ".lnkitemdetails", function (e) {
                var itemId = $(this).attr("data-id");
                var url = "edit-item.aspx?itemid=" + itemId;
                $.easyBlockUI("body");
                $.ajaxModal('.modal', url);
                $(".modal .modal-title").text("Edit Item");
                $.unblockUI();
                var itemId = $(this).attr("data-id");

                $('#detailsId').val("yes");
                var strqry = "item_id=" + itemId + "&fun=Edit_Item";

                $.easyAjax({
                    url: "H_tbl_Item.ashx",
                    data: strqry,
                    type: "POST",
                    success: function (response) {
                        $.easyBlockUI("body");
                        var itemlist = response.itemvalue.split("|");
                        $('#hdf-item-id').val(itemId);
                        $('group1').val(itemlist[0]);
                        if (itemlist[0] == 1) {
                            $('#radio_1').attr("checked", true);
                        }
                        else if (itemlist[0] == 2) {
                            $('#radio_2').attr("checked", true);
                        }
                        else {
                            $('#radio_3').attr("checked", true);
                        }
                        //$('#ddl_item_Sub_Category').val(itemlist[1]);
                        populate_dropdown(url, itemlist[0], itemlist[1], $("#hdf_branch_id").val());
                        $('#txt_ItemCode').val(itemlist[2]);
                        $('#txt_new_item_code').val(itemlist[3]);
                        $('#txt_brand').val(itemlist[4]);
                        $('#txt_manufacturer').val(itemlist[5]);
                        $('#txt_oem_reference').val(itemlist[6]);
                        $('#txt_capacity').val(itemlist[7]);
                        $('#txt_unit').val(itemlist[8]);
                        $('#txt_Minimum_Margin').val(itemlist[9]);
                        $('#txt_VAT_Percent').val(itemlist[10]);
                        $('#txt_description').val(itemlist[11]);
                        $('#txt_long_description').val(itemlist[12]);
                        $('#txt_arabic_description').val(itemlist[13]);
                        $('#txt_barcode').val(itemlist[14]);
                        $('#txt_hsecode').val(itemlist[15]);
                        $('#txt_Storage_temprature').val(itemlist[16]);
                        $('#txt_Lenght').val(itemlist[17]);
                        $('#txt_Width').val(itemlist[18]);
                        $('#txt_Height').val(itemlist[19]);
                        $('#chk_has_expiry').val(itemlist[20]);
                        $('#chk_has_Warrenty').val(itemlist[21]);
                        $('#txt_wholesale_quantity').val(itemlist[22]);
                        $('#txt_wholesale_margin').val(itemlist[23]);

                        $.unblockUI();
                    }
                });

            });


            $(document).on("click", ".lnkitemdelete", function (e) {
                //e.preventDefault();
                //e.stopImmediatePropagation();
                var itemid = $(this).attr("data-id");
                var strqry = "";

                strqry = "item_id=" + itemid + "&fun=Deactivate_Item";
                swal({
                    title: "Are you sure?",
                    text: "You will not be able to recover this item",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "btn-danger",
                    confirmButtonText: "Yes, delete it!",
                    closeOnConfirm: false
                }, function (isConfirm) {
                    // swal("Deleted!", "Your imaginary file has been deleted.", "success");
                    if (isConfirm) {
                        $.easyAjax({
                            url: "H_tbl_Item.ashx",
                            data: strqry,
                            type: "POST",
                            success: function (response) {
                                if (response.status == "success") {
                                    $.unblockUI();
                                    //reloadtable();
                                    Bind_Item_grid_N();
                                    swal("Deleted!", "Your Item has been deleted.", "success");
                                }

                            }
                        });
                    }
                });

            });
        });


        function reloadtable() {
            $('#tbl_itemlist').DataTable().ajax.reload();
            document.getElementById("tbl_itemlist_paginate").innerHTML = "";
        }




        function populate_dropdown(base_url, itemid, subcatid, branch_Id) {

            $("#ddl_item_Sub_Category").html("");
            $("input[name='txt_ItemCode']").val("");

            $.easyAjax({
                url: "H_tbl_Item.ashx",
                type: "POST",
                redirect: true,
                data: { 'fun': 'item_Sub_Category', 'itemtypeid': itemid, 'subcat': subcatid, 'Branch_Id': branch_Id },
                success: function (data) {
                    if (data.status == "success") {
                        $("#ddl_item_Sub_Category").html("");
                        $("#ddl_item_Sub_Category").append(data.html);
                    }
                }
            });
        }


        //===========================================================filter============================================================
        var item_type = "0"; filter("div_all", 0);

        function filter(obj, ItemType) {
            $("#div_all").removeClass("checked")
            $("#div_stock").removeClass("checked")
            $("#div_non_stock").removeClass("checked")
            $("#div_service").removeClass("checked")

            if ($(obj).hasClass("checked")) {
                $(obj).removeClass("checked");
            }
            else {
                $(obj).addClass("checked");
            }


            if ($("#div_all").hasClass("checked") == false && $("#div_stock").hasClass("checked") == false && $("#div_non_stock").hasClass("checked") == false && $("#div_service").hasClass("checked") == false) {
                $("#div_all").addClass("checked"); ItemType = 0;
            }
            item_type = ItemType;
            SetVal("hid_page", "1");
            Bind_Item_grid_N();
        }

        //=========================================================================================================================
        function Bind_From_First() {

            SetVal("hid_page", "1");
            Bind_Item_grid_N();
        }

    </script>


</body>
</html>



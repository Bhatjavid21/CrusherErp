F<%@ Control Language="C#" AutoEventWireup="true" CodeFile="sidebar.ascx.cs" Inherits="user_controls_sidebar" %>
<input type="hidden" id="baseurl" name="baseurl" value="<%=G.S%>" />
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
    <!-- sidebar-->
    <section class="sidebar">
        <!-- sidebar menu-->
        <ul class="sidebar-menu" data-widget="tree">
            
            <li class="<%Response.Write(G.set_Submenu("dashboard"));%>">

                <a href="<%=G.S%>general/Dashboard.aspx">
                    <i class="mdi mdi-view-dashboard"></i>
                    <span>Dashboard</span>
                </a>
            </li>

          <li >
                <a href="<%=G.S%>Sales/Sales_Master.aspx">
                    <i class="mdi mdi-sale"></i><span>Sales</span>
                </a>
            </li>
            
        
            <li>
                <a href="<%=G.S%>Purchase/Purchase_Master.aspx">
                    <i class="mdi mdi-shopping"></i><span>Purchase</span>
                </a>
            </li>

            <li class="<%Response.Write(G.set_Submenu("customer"));%>">
                <a href="<%=G.S%>Customer/Customer_Master.aspx">
                    <i class="mdi mdi-face"></i><span>Customer</span>
                </a>
            </li>

            <li class="<%Response.Write(G.set_Submenu("supplier"));%>">
                <a href="<%=G.S%>Supplier/Supplier_Master.aspx">
                    <i class="mdi mdi-face"></i><span>Supplier</span>
                </a>
            </li>

            <li class="<%Response.Write(G.set_Submenu("report"));%>">
                <a href="<%=G.S%>Reports/report-list.aspx">
                    <i class="mdi mdi-mailbox"></i><span>Reports</span>
                </a>
            </li>

            <li class="treeview <%Response.Write(G.set_Topmenu("items"));%>">
                <a href="#">
                    <i class="mdi mdi-apps"></i><span>Item</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-right pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li class="<%Response.Write(G.set_Submenu("item-category"));%>"><a href="<%=G.S%>Item/item-category.aspx"><i class="mdi mdi-toggle-switch-off"></i>Item Category</a></li>
                    <li class="<%Response.Write(G.set_Submenu("item"));%>"><a href="<%=G.S%>Item/items.aspx"><i class="mdi mdi-toggle-switch-off"></i>Item List</a></li>

                </ul>
            </li>
        

            <li class="treeview <%Response.Write(G.set_Topmenu("settings"));%>">
                <a href="#">
                    <i class="mdi mdi-settings"></i>
                    <span>Settings</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-right pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a><i class="mdi mdi-toggle-switch-off"></i>General</a></li>
                    <li><a><i class="mdi mdi-toggle-switch-off"></i>Configuration</a></li>
                    <%--<li><a href=""><i class="mdi mdi-toggle-switch-off"></i>Currency</a></li>--%>
                    <%--<li class="<%Response.Write(G.set_Submenu("user"));%>"><a href="<%=G.S%>User/user.aspx"><i class="mdi mdi-toggle-switch-off"></i>Users</a></li>--%>
                    <%--<li class="<%Response.Write(G.set_Submenu("roles"));%>"><a href="<%=G.S%>Settings/roles.aspx"><i class="mdi mdi-toggle-switch-off"></i>Roles</a></li>--%>
                </ul>
            </li>






        </ul>
    </section>
</aside>
   <script>
       function myFunctionHR() {
           window.open("<%=G.S%>HR/hr-dashboard.aspx");
       }
   </script>
<!-- Sidebar End -->

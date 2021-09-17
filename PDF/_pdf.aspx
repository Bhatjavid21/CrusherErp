<%@ Page Language="C#" AutoEventWireup="true" CodeFile="_pdf.aspx.cs" Inherits="pdf" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <style type="text/css">

 .styleClass
	{
	font-size:18px;
	color:red;
	font-family:"Calibri","sans-serif";
	border:1px solid red;
	}
        .grand {
            color:blue;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
   <p runat="server" id="para1" class="styleClass">Bismillah Hirahmani Raheem</p> 
    
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" />
   
    </form>
    
</body>
</html>

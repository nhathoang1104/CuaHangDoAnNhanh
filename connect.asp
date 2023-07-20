<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=LAPTOP-V8ITE7OS\SQLEXPRESS;Database=QLDoAnNhanh;User Id=sa;Password=123456"
connDB.ConnectionString = strConnection
%>

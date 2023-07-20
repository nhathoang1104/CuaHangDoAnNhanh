<!-- #include file="connect.asp" -->
<%
id = Request.QueryString("id")

 Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM Admin WHERE ID=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("ID",3,1, ,id)
    cmdPrep.execute
    connDB.Close()
    Session("Success") = "Deleted"  
    Response.Redirect("QLNS.asp")
%>

<!-- #include file="connect.asp" -->

<%
If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        ID = Request.QueryString("ID")
        If (isnull(ID) OR trim(ID) = "") then 
            ID=0 
        End if
        If (cint(id)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Admin WHERE ID=?"            
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                username=Result("Username")
                password=Result("Password")
                name=Result("Name")
                address=Result("Address")
                email=Result("Email")
                phone=Result("Phone")
            End If
            Result.Close()
        End If
Else
        ID=Request.QueryString("ID")
        username=Request.form("username")
        password=Request.form("password")
        name=Request.form("name")
        address=Request.form("address")
        email=Request.form("email")
        phone=Request.form("phone")
if (isnull (ID) OR trim(ID) = "") then ID=0 end if

if(cint(ID=0)) then
   if(NOT isnull(username) and username<>"" and NOT isnull(password) and password<>"" and NOT isnull(name) and name<>"" and NOT isnull(address) and address<>"" and NOT isnull(email) and email<>"" and NOT isnull(phone) and phone<>"")then
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "INSERT INTO Admin(UserName,Password,Name,Address,Email,Phone) VALUES(?,?,?,?,?,?)"
        cmdPrep.parameters.Append cmdPrep.createParameter("username",202,1,255,username)
        cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,255,password)
        cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
        cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,255,address)
        cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,255,email)
        cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,255,phone)
        cmdPrep.execute
        Session("Success") = "Thêm tài khoản nhân viên thành công"
        Response.redirect("QLNS.asp")
    Else
        Session("Error") = "Bạn cần điền đầy đủ các trường thông tin"
    End if
else
    if(NOT isnull(username) and username<>"" and NOT isnull(password) and password<>"" and NOT isnull(name) and name<>"" and NOT isnull(address) and address<>"" and NOT isnull(email) and email<>"" and NOT isnull(phone) and phone<>"")then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Admin SET UserName=?,Password=?,Name=?,Address=?,Email=?,Phone=?  WHERE ID=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("username",202,1,255,username)
                cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,255,password)
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,name)
                cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,255,address)
                cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,255,email)
                cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,255,phone)
                cmdPrep.parameters.Append cmdPrep.createParameter("ID",3,1, ,ID)
                cmdPrep.execute
                Session("Success") = "Sửa tài khoản nhân viên thành công"
                Response.redirect("QLNS.asp")
    Else
        Session("Error") = "Bạn cần điền đầy đủ các trường thông tin"
    End if
End If
End if
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin nhân viên</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/custom.css">  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <!-- #include file="header.asp" -->
    <div class="container py-3">
            <form method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="<%=username%>">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" value="<%=password%>">
                </div> 
                <div class="mb-3">
                    <label for="name" class="form-label">Họ tên</label>
                    <input type="text" class="form-control" name="name" value="<%=name%>">
                </div> 
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" name="address" value="<%=address%>">
                </div> 
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%=email%>">
                </div> 
                <div class="mb-3">
                    <label for="phone" class="form-label">SĐT</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="<%=phone%>">
                </div> 
                <button type="submit" class="btn btn-primary">
                    <%
                        if (ID=0) then
                            Response.write("Thêm sinh viên")
                        else
                            Response.write("Sửa thông tin sinh viên")
                        end if
                    %>
                </button>
                <a href="QLNS.asp" class="btn btn-info">Quay lại</a>           
            </form>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
          <!--#include file="footer.asp"-->
  </body>
</html>
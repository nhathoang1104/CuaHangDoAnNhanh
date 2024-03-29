<!--#include file="connect.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
    Dim fullname, email, numberphone, username, password, idkh, address
    idkh = Request.querystring("MaKH")
    fullname = Request.Form("fullname")
    email = Request.Form("email")
    numberphone = Request.Form("numberphone")
    username = Request.Form("username")
    password = Request.Form("password") 
    address = Request.Form("address")
    'Kiem tra xem nguoi dung da nhap du thong tin chua
    If (isnull(fullname) OR isnull(email) OR  isnull(numberphone) OR isnull(address) OR  isnull(username) OR  isnull(password) OR TRIM(fullname)="" OR TRIM(email)="" OR TRIM(numberphone)="" OR TRIM(address)="" OR TRIM(username)="" OR TRIM(password)="") Then
        'Nếu rỗng, đưa ra thông báo
        Response.Write("<script>alert('Vui lòng nhập đủ thông tin đăng ký');</script>")
        'Kiem tra tai khoan da ton tai chua
    Else
        ' Kiểm tra username đã tồn tại hay chưa
        Dim sql
        sql = "SELECT count(TaiKhoan) AS DEM FROM NguoiDung WHERE TaiKhoan='" & username & "'"
        Dim cmdPrep
        connDB.Open
        set cmdPrep = Server.CreateObject("ADODB.Command")
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        Dim rs
        set rs = cmdPrep.execute
        ' Session("idkh") = rs("MaKH")
        ' Nếu username đã tồn tại, thông báo
        if (rs("DEM")=1) Then
            Response.Write("<script>alert('Tài khoản đã tồn tại trước đó');</script>")
        Else
            ' Kiểm tra email đã tồn tại chưa
            cmdPrep.CommandText = "SELECT count(Email) AS DEM FROM NguoiDung WHERE Email='" & email & "'"
            Set rs = cmdPrep.execute
            ' Nếu email đã tồn tại, thông báo
            If (rs("DEM")=1) Then
                Response.Write("<script>alert('Email đã tồn tại');</script>")
            Else 
                ' Kiểm tra số điện thoại đã tồn tại chưa
                cmdPrep.CommandText = "SELECT count(DienThoai) AS DEM FROM NguoiDung WHERE DienThoai='" & numberphone & "'"
                Set rs = cmdPrep.execute
                ' Nếu số điện thoại đã tồn tại, thông báo
                If (rs("DEM")=1) Then
                    Response.Write("<script>alert('Số điện thoại đã tồn tại);</script>")
                Else 
                    'Thỏa mãn điều kiện thì thêm thông tin khách hàng
                    cmdPrep.CommandText = "Insert into NguoiDung(HoTen, Email, DienThoai, DiaChi, TaiKhoan, MatKhau) values(?, '"& email &"', '"& numberphone &"', ?, '"& username &"', '"& password &"')"
                    cmdPrep.parameters.Append cmdPrep.createParameter("fullname",202,1,255,fullname)
                    cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,255,address)

                    cmdPrep.execute
                    
                    ' Thong bao tao tai khoan thanh cong
                    Response.Write("<script>alert('Tạo tài khoản thành công');</script>")

                    ' Redirect den trang login.asp
                    Response.Redirect ("./login.asp")

                    ' Dong ket noi
                    connDB.Close
                    rs.Close
                End If
            End If
        End If
    End If
End If
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./assest/css/register.css">
    <title>Đăng Ký</title>
</head>

<body>
    <div class="header">
        <div class="logo">
            <img src="./assest/img/DHDs.png" alt="Logo" onclick="location.href='./home.asp'">
        </div>
        <div class="list_header">
            <ul>
                <li>Combo 1 Người</li>
                <li>Combo Nhóm</li>
                <li>Thức Ăn Nhẹ</li>
                <li>Đồ Uống & Tráng Miệng</li>
            </ul>
        </div>
    </div>
    <div class="container">
        <div class="img_ads">
            <img src="./assest/img/SALAD-HAT.jpg" alt="Salad" onclick="location.href='dangky.asp'">
        </div>
        <div class="register_fm">
            <form action="register.asp" id="register_form" method="post">
                <div class="register_title">Đăng ký</div>
                <label for="fullname">Họ Và Tên</label>
                <input type="text" name="fullname" id="fullname">
                <label for="email">Email</label>
                <input type="email" name="email" id="email">
                <label for="numberphone">Số Điện Thoại</label>
                <input type="number" name="numberphone" id="numberphone" placeholder="123-45-678" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}">
                <label for="address">Địa chỉ</label>
                <input type="text" name="address" id="address">
                <label for="username">Tên Đăng Nhập</label>
                <input type="text" name="username" id="username">
                <label for="password">Mật Khẩu</label>
                <input type="password" name="password" id="password">
                <div class="cbox">
                    <input type="checkbox" name="checkbox" id="checkbox">
                    <label for="checkbox" style="font-size: 12px;">Bạn đồng ý với điều khoản Của <a href="login.asp">DHD</a></label>
                </div>
                <input type="submit" value="Đăng Ký" id="register">
                <div class="text_or" style="font-size: 12px;">Hoặc</div>
                <input type="button" value="Đăng Nhập" id="login" onclick="location.href='./login.asp'">
            </form>
        </div>
    </div>
    <div class="footer">

    </div>
</body>
</html>
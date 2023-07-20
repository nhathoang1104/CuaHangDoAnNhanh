<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/custom.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <section class="Header " style="background-color: antiquewhite;">
        <div class="container" >
            <div class="row">
                <div class="col-md-2 py-3 " > 
                    <img src="./assest/img/DHDs.png" class="img-fluid" alt="logo" style="height: 100px;">
                </div>
                <div class="col-md-4 py-5" ><strong>HỆ THỐNG QUẢN LÝ CỬA HÀNG</strong></div>
                <div class="col-md-3 py-5">
                    
                </div>
                <div class="col-md-3 py-5">
                    <div class="row">
                        <div class="col-md ">
                             <div class="row">
                                <div class="col-md-3 py-1 "><i class="fa-solid fa-people-roof"></i></div>
                                <div class="col-md-8"><strong>Xin chào</strong><br><%=Session("nameAdmin")%></div>
                             </div>
                        </div>
                        <div class="col-md">
                                 <div class="row">
                                <div class="col-md-3 py-1 "><i class="fa-solid fa-right-from-bracket"></i></div>
                                <div class="col-md-9"><a class="nav-link active" href="loginManager.asp"><strong>Đăng xuất</strong></a></div>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
   
    <section class="MyMainMemu bg-success">
        <div class="container">
     <div class="row">
        <div class="col-md-3 text-white py-3">
            <div class="row">
                <div class="col-md-1 py-1 "><i class="fa-solid fa-toolbox"></i></div>
                <div class="col-md-11"><strong>Công cụ quản lý</strong></div>
             </div>
        </div>
        <div class="col-md-9">
            <nav class="navbar navbar-expand-lg ">
                <div class="container-fluid">
                  <a class="navbar-brand d-none" href="#">Navbar</a>
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                      <li class="nav-item">
                        <a class="nav-link text-white active" aria-current="page" href="home.asp">Trang chủ</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link text-white" href="QLNS.asp">Quản lý nhân sự</a>
                      </li>
                      <li class="nav-item ">
                        <a class="nav-link text-white" href="QLSP.asp">
                          Quản lý sản phẩm
                        </a>
                      </li>
                        <li class="nav-item ">
                        <a class="nav-link text-white" href="bill.asp">
                          Quản lý đơn hàng
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link text-white " href="statistic.asp">Thống kê</a>
                      </li>
                    </ul>
                  </div>
                </div>
              </nav>
        </div>
     </div>
    </div>
    </section>
    <div class="container">
    <%
        If (NOT isnull(Session("Success"))) AND (TRIM(Session("Success"))<>"") Then
    %>
            <div class="alert alert-success" role="alert"id="successMessage">
                <%=Session("Success")%>
            </div>
    <%
            Session.Contents.Remove("Success")
        End If
    %>
    <%
    ' Kiểm tra lỗi
        If (NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
    %>
            <div class="alert alert-danger" role="alert" id="errorMessage">
                <%=Session("Error")%>
            </div>
    <%
            Session.Contents.Remove("Error")
        End If
    %>
    <script>

    setTimeout(function() {
        var successMessage = document.getElementById('successMessage');
        if (successMessage) {
            successMessage.style.display = 'none';
        }
    }, 5000);

 
    setTimeout(function() {
        var errorMessage = document.getElementById('errorMessage');
        if (errorMessage) {
            errorMessage.style.display = 'none';
        }
    }, 5000);
</script>
</div>
</body>
</html>
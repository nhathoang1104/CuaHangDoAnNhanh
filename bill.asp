<!--#include file="connect.asp"-->
<%
' ham lam tron so nguyen
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
' trang hien tai
    page = Request.QueryString("page")
    limit = 5

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(MaDH) AS count FROM DonHang"
    connDB.Open()
    Set CountResult = connDB.execute(strSQL)
    totalRows = CLng(CountResult("count"))
    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)
    'gioi han tong so trang la 5
    Dim range
    If (pages<=5) Then
        range = pages
    Else
        range = 5
    End if
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý đơn hàng</title>

        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" href="./assest/font/font-awesome-4.7.0/css/font-awesome.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">

        <style>
            #bill_detail{
                color: green;
                background-color: white;
            }
            #bill_detail:hover{
                color: white;
                background-color: green;
            }
            .input-group{
                margin-top: 10px;
                display: flex;    
                justify-content: center;
            }
            .form-outline{
                display: flex;
            }
            #keyword{
                width: 600px;
                margin-right: 5px;
            }
        </style>
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
                                <div class="col-md-3 py "><i class="fa-solid fa-people-roof"></i></div>
                                <div class="col-md-8"><strong>Xin chào</strong><br><%=Session("nameAdmin")%></div>
                             </div>
                        </div>
                        <div class="col-md">
                                 <div class="row">
                                <div class="col-md-3 py "><i class="fa-solid fa-right-from-bracket"></i></div>
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
                <div class="col-md-1 py "><i class="fa-solid fa-toolbox"></i></div>
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
        <div class="search_bar">
            <div class="input-group">
                <form class="form-outline" method="post">
                    <input type="search" id="keyword" class="form-control" placeholder="Vui lòng nhập mã đơn hàng" name="keyword">
                    <input type="submit" class="btn btn-primary" value="Tìm Kiếm">
                </form>
            </div>
        </div>
        <div class="container">
            <div class="d-flex bd-highlight mb-3">
                <div class="me-auto p-2 bd-highlight"><h2>Danh Sách Hóa Đơn</h2></div>
            </div>
            <div class="table_responsive">
                <table class="table table-striped table-bordered">
                    <thead>
                      <tr class="table-secondary">
                        <th scope="col">Mã Hóa Đơn</th>
                        <th scope="col">Trạng Thái</th>
                        <th scope="col">Thời Gian</th>
                        <th scope="col">Tên Khách Hàng</th>
                        <th scope="col">Số Điện Thoại</th>
                        <th scope="col">Địa Chỉ</th>
                        <th scope="col">Tổng Tiền</th>
                        <th scope="col">Chi Tiết</th>
                      </tr>
                    </thead>
                    <tbody>
                        <%                                
                            Dim sqlSearch
                            Dim rsSearch
                        %>
                        <%
                            'Lay o tim kiem
                            Dim keyword      
                            If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
                                keyword = Request.Form("keyword")
                            End If
                            'Kiem tra o tim kiem co trong hay khong
                            If (NOT isnull(keyword) AND TRIM(keyword)<>"") Then
                                sqlSearch = "select * from DonHang where MaDH = " &keyword& " "
                            Else
                                sqlSearch = "SELECT * FROM DonHang ORDER BY MaDH OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY"    
                            End If              
                        %>
                        <%
                            Set rsSearch = connDB.Execute(sqlSearch)                           
                            do while not rsSearch.EOF
                        %>
                            <tr>
                                <td><%=rsSearch("MaDH")%></td>
                                <td>
                                    <%  
                                        If rsSearch("DaThanhToan") = true Then
                                            Response.Write "Đã Thanh Toán"
                                        Else
                                            Response.Write "Chưa Thanh Toán"
                                        End If
                                    %>
                                </td>
                                <td><%=rsSearch("ThoiGianDat")%></td>
                                <td><%=rsSearch("NguoiNhan")%></td>
                                <td><%=rsSearch("SoDT")%></td>
                                <td><%=rsSearch("DiaChi")%></td>
                                <td><%=rsSearch("TongTien")%></td>
                                <td>
                                    <a href="bill_detail.asp?MaDH=<%=rsSearch("MaDH")%>" class="btn btn-secondary" id="bill_detail">Chi Tiết</a>
                                </td>
                            </tr>
                        <%
                            rsSearch.MoveNext
                            loop                   
                        %>     
                    </tbody>
                </table>               
            </div>
            <nav aria-label="Page Navigation">
                <ul class="pagination pagination-sm justify-content-center my-5">
                    <% if (pages>1) then
                    'kiem tra trang hien tai co >=2
                        if(Clng(page)>=2) then
                    %>
                        <li class="page-item"><a class="page-link" href="bill.asp?page=<%=Clng(page)-1%>"><-</a></li>
                    <%    
                        end if 
                        for i= 1 to range
                    %>
                            <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="bill.asp?page=<%=i%>"><%=i%></a></li>
                    <%
                        next
                        if (Clng(page)<pages) then

                    %>
                        <li class="page-item"><a class="page-link" href="bill.asp?page=<%=Clng(page)+1%>">-></a></li>
                    <%
                        end if    
                    end if
                    %>
                </ul>
            </nav>
        </div>
        <!--#include file="footer.asp"-->
    </body>
</html>
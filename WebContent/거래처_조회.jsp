<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!DOCTYPE html>

<!-- 데이터베이스 커넥터 -->
<%
   Connection conn=null;
   Statement CTstmt = null;
   Statement EMPstmt = null;
   Statement CUstmt = null;
   Statement SLstmt = null;
   // 조인 stmt
   Statement JOINstmt = null;
   
   ResultSet CTrs = null;
   ResultSet EMPrs = null;
   ResultSet CUrs=null;
   ResultSet SLrs = null;
   // 조인 rs
   ResultSet JOINrs = null;
   
   // 드라이버 및 데이터베이스 설정
   String driver="com.mysql.jdbc.Driver";
   String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
   // 거래처 테이블 선택
   String customerQuery="select * from customer order by customer_first_registration";
   String employeeQuery="select * from employee";
   String customerNameQuery="select customer_name from customer";
   String sellingQuery = "select selling.customer_name, IFNULL(item_unit_price,''), IFNULL(selling_count,''), SUM(item_unit_price*selling_count) as Total_transaction_amount from selling,customer WHERE customer.customer_name=selling.customer_name AND selling.selling_chit_code is not null GROUP BY selling.customer_name";
   // 조인 테이블
   /*String joinQuery = "SELECT c.customer_wheter_new, c.customer_name, c.customer_code, c.customer_type, c.customer_item_code, c.customer_businessman_name, c.customer_business_code, c.customer_business_man_phone, c.customer_address, c.part_employee_name, c.part_employee_code, c.part_employee_phone, c.customer_memo, c.customer_sales_category, c.customer_business_status, c.customer_first_registration, SUM(item_unit_price*selling_count) as Total_transaction_amount " 
		    + "FROM selling as s INNER JOIN customer as c "
		    + "ON s.customer_code=c.customer_code " 
		    + "GROUP BY customer_name HAVING Total_transaction_amount is not null "
		    + "ORDER BY customer_first_registration ASC";*/
   String joinQuery = "SELECT c.customer_wheter_new, c.customer_name, c.customer_code, c.customer_type, c.customer_item_code, c.customer_businessman_name, c.customer_business_code, c.customer_business_man_phone, c.customer_address, c.part_employee_name, c.part_employee_code, c.part_employee_phone, c.customer_memo, c.customer_sales_category, c.customer_business_status, c.customer_first_registration, SUM(item_unit_price*selling_count) as Total_transaction_amount "
		   + "FROM selling as s RIGHT JOIN customer as c "
		   + "ON s.customer_code=c.customer_code "
		   + "GROUP BY customer_name "
		   + "ORDER BY customer_first_registration ASC";
   
		    
		    
   
   
   
   Boolean connect=false;

%>


<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>GLASS 長 - 거래처 조회</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    
    <!-- 테이블 제작 위한 소스 -->
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <!--===============================================================================================-->
   <link rel="icon" type="image/png" href="images/icons/favicon.ico" />
   <!--===============================================================================================-->
   <link rel="stylesheet" type="text/css"
      href="vendor/bootstrap/css/bootstrap.min.css">
   <!--===============================================================================================-->
   <link rel="stylesheet" type="text/css"
      href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
   <!--===============================================================================================-->
   <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
   <!--===============================================================================================-->
   <link rel="stylesheet" type="text/css"
      href="vendor/select2/select2.min.css">
   <!--===============================================================================================-->
   <link rel="stylesheet" type="text/css"
      href="vendor/perfect-scrollbar/perfect-scrollbar.css">
   <!--===============================================================================================-->
   <link rel="stylesheet" type="text/css" href="css/util.css">
   <link rel="stylesheet" type="text/css" href="css/main.css">

</head>

<!-- 로그아웃 후 뒤로가기 방지 코드 -->
<script>
   window.history.forward(); 
   function noBack(){ 
      window.history.forward(); 
   }
</script>


<body id="page-top" onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="business_info.jsp">
                <div class="sidebar-brand-icon rotate-n-15">
                </div>
                <div class="sidebar-brand-text mx-3"> GLASS 長 </div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="business_info.jsp">
                <div></div>
                   <img id="Enterprise_logo" alt="" src="img/기업소개.png" width="15.31" height="14">
                    <span id="Enterprise_text">기업 소개</span></a>
            </li>


            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->

            <div class="sidebar-heading">
               관리 기능
            </div>

            
            <!-- Nav Item - 거래처 관리  Menu -->
         <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages_1"
                    aria-expanded="true" aria-controls="collapsePages_1">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>거래처</span>
                </a>
                <div id="collapsePages_1" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="거래처_등록.jsp">거래처 등록</a>
                        <a class="collapse-item" href="거래처_조회.jsp">거래처 조회</a>
                    </div>
                </div>
            </li>

         <!-- Nav Item - 수주 관리  Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages_2"
                    aria-expanded="true" aria-controls="collapsePages_2">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>수주</span>
                </a>
                <div id="collapsePages_2" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                       <a class="collapse-item" href="수주_등록.jsp">수주 등록</a>
                        <a class="collapse-item" href="수주_현황.jsp">수주 현황</a>
                        <a class="collapse-item" href="수주_거래처별.jsp">거래처별 수주 현황</a>
                        <a class="collapse-item" href="수주_품목별.jsp">품목별 수주 현황</a>
                        <a class="collapse-item" href="수주_영업사원별.jsp">영업사원별 수주 현황</a>
                    </div>
                </div>
            </li>

         <!-- Nav Item - 재고 관리  Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages_3"
                    aria-expanded="true" aria-controls="collapsePages_3">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>재고</span>
                </a>
                <div id="collapsePages_3" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="재고_품목등록.jsp">품목 등록</a>
                        <a class="collapse-item" href="재고_불량.jsp">불량 재고 관리</a>
                        <a class="collapse-item" href="재고_관리.jsp">재고 관리</a>
                    </div>
                </div>
            </li>

         <!-- Nav Item - 매출 관리  Menu -->
         <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages_4"
                    aria-expanded="true" aria-controls="collapsePages_4">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>매출</span>
                </a>
                <div id="collapsePages_4" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="매출_등록.jsp">매출 등록</a>
                        <a class="collapse-item" href="매출_집계.jsp">매출 집계 현황</a>
                        <a class="collapse-item" href="매출_거래처별.jsp">거래처별 매출 현황</a>
                        <a class="collapse-item" href="매출_품목별.jsp">품목별 매출 현황</a>
                        <a class="collapse-item" href="매출_영업사원별.jsp">영업사원별 매출 현황</a>
                    </div>
                </div>
            </li>   
            

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

            
        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>



                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>


                  <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">반갑습니다</span>
                                <img class="img-profile rounded-circle"
                                    src="img/undraw_profile_3.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
               <nav class="navbar navbar-dark bg-primary">
                  <div class="container-fluid">
                     <a class="navbar-brand mb-0 h1" href="#">거래처 조회</a>
                  </div>
               </nav>
                    
                <!-- /.container-fluid -->
                <!-- 검색구역 -->
                <form action="거래처_조회.jsp" method="POST">
                <div class="row mt-3 ml-1">
                <div class="col-lg-4">
                   <div class="input-group">
                     <span class="mt-2" style="width:100px">판매 구분</span>
                      <div class="input-group-btn">
                        <select class="form-control ml-2" name="sales_category_search" id="sales_category_search" style="width:170px" >
                           <option selected value="0">전체</option>
                           <option value="매출처">매출처</option>
                           <option value="매입처">매입처</option>
                        </select>
                        <input type="hidden" name="sales_category_search_hidden" value="">
                     </div>
                   </div><!-- /input-group -->
               </div><!-- /.col-lg-4 -->
               <div class="col-lg-4">
                   <div class="input-group">
                     <span class="mt-2"style="width:120px">분류</span>
                      <div class="input-group-btn">
                       <select class="form-control ml-2" name="category_search" style="width:170px">
                       	   <option selected value="0">전체</option>
                           <option value="기존">기존</option>
                           <option value="신규">신규</option>
                     </select>
                     </div>
                   </div><!-- /input-group -->
               </div><!-- /.col-lg-4 -->
               <div class="col-lg-4">
                   <div class="input-group">
                     <span class="mt-2"style="width:105px">사용여부</span>
                     <div class="input-group-btn">
                       <select class="form-control" name="busienss_status_search" style="width:170px">
                       		<option selected value="0">전체</option>
                            <option value="사용">사용</option>
                           	<option value="미사용">미사용</option>
                     </select>
                     </div>
                   </div><!-- /input-group -->
               </div><!-- /.col-lg-4 -->
                </div>
                
                <!-- 두번째 줄 -->
                <div class="row ml-1" style="margin-top:5px">
                <div class="col-lg-4">
                   <div class="input-group">
                     <span class="mt-2"style="width:100px">거래처명</span>
                     <div class="input-group-btn">
                      <select class="form-control ml-2" name="customer_name_search" style="width:170px">
                           <option selected value="0">전체</option>
                           <% 
                        try{
                           Class.forName(driver);
                           conn=DriverManager.getConnection(url,"java","java");
                           
                           connect=true;
   
                           // statement 생성
                     
                           CUstmt = (Statement)conn.createStatement();
                           // 쿼리실행하고 결과를 담기
                           CUrs = CUstmt.executeQuery(customerNameQuery);
                           
                           
                           
                           // ACrs.next() && EMPrs.next()
                           
                           int i=0;
                                  while(CUrs.next()){ 
                              i++;
                              
                           %>
                              <option value="<%=CUrs.getString(1) %>"><%=CUrs.getString(1) %></option>
                              
                        <%   }
                        }catch(SQLException ex){
                           out.println(ex.getMessage());
                           ex.printStackTrace();
                        }finally{ // 연결 해제
                           // ResultSet 해제
                           if(CUrs!=null)try{
                              CUrs.close();
                           }catch(SQLException ex){}
                           
                           // Statement 해제
                           if(CUstmt!=null)try{
                              CUstmt.close();
                           } catch(SQLException ex){}
                           
                           if(conn!=null)try{
                              conn.close();
                           }catch(SQLException ex){}
                        }// finally_end
                     %>
                     </select>
                     </div><!-- /btn-group -->
                   </div><!-- /input-group -->
               </div><!-- /.col-lg-4 -->
               <div class="col-lg-4">
                   <div class="input-group">
                     <span class="mt-2"style="width:120px">사업자등록번호</span>

                     <div class="input-group-btn mt-1">
                       <input type="text" id="businessCode_search" name="businessCode_search" value="" style="width:170px" class="form-control-sm ml-2" aria-describedby="basic-addon2">
                     </div><!-- /btn-group -->
                   </div><!-- /input-group -->
               </div><!-- /.col-lg-4 -->
               <div class="col-lg-4">
                   <div class="input-group">
                     <span class="mt-2"style="width:100px">담당사원명</span>
                     <div class="input-group-btn mt-1">
                       <input type="text" id="employeeName_search" name="employeeName_search" value=""  style="width:170px" class="form-control-sm ml-1" aria-describedby="basic-addon2">
                     </div><!-- /btn-group -->
                   </div><!-- /input-group -->
               </div><!-- /.col-lg-4 -->
                </div>
                
                <!-- 세번째 줄 -->
                <div class="row ml-1" style="margin-top:5px">
                <div class="col-lg-4">
                   <div class="input-group">
                     <span class="mt-2"style="width:100px">사원번호</span>
                     <div class="input-group-btn mt-1">
                         <input type="text" id="employeeCode_search" name="employeeCode_search" value="" style="width:170px" class="form-control-sm ml-2" aria-describedby="basic-addon2">
                     </div><!-- /btn-group -->
                   </div><!-- /input-group -->
               </div><!-- /.col-lg-4 -->

               <div class="col-lg-7">
                   <div class="input-group">
                     <span class="mt-2"style="width:120px">등록일자</span>
                     <div class="form-group mt-1"> 
                        <div class="input-group date mt-1 ml-2"> 
                        <input type="text" name="search_startDate" class="datepicker" style="width:170px; line-height: 28px;" id="store_datepicker_2"> 
                        </div> 
                     </div>
                     <span class="mt-2 ml-1">~</span>
                     <div class="form-group mt-1"> 
                        <div class="input-group date mt-1 ml-2"> 
                        <input type="text" name="search_endDate" class="datepicker" style="width:170px; line-height: 27px;" id="store_datepicker_3"> 
                        </div> 
                     </div>
                   </div><!-- /input-group -->
               </div><!-- /.col-lg-4 -->
               <!-- 확인버튼 -->
               <div class="col-lg-1">
                     <button type="submit"id="store_search_store_lookup_data-submit-button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm" style="margin-left:30px; margin-top:5px;">확인</button>
               </div><!-- /col-lg-4 -->
            </div>
                
             
               </form>
               </div>        
                      
               <!-- 거래처 조회 테이블 -->
            <div class="limiter">
               <div class="container-table100" style="min-height: 0%">
                  <div class="wrap-table100">
                     <div class="table100" style="width:100%; height:450px; overflow:auto">
                        <table>
                           <thead>
                              <tr class="table100-head">
                                 <th class="customer_manage1">No</th>
                                 <th class="customer_manage2">거래처<br>코드</th>
                                 <th class="customer_manage3">최초<br>등록일</th>
                                 <th class="customer_manage4">거래처명</th>
                                 <th class="customer_manage5">판매구분</th>
                                 <th class="customer_manage6">분류</th>					<!-- 분류는 분류코드가 아니고 신규/기존 분류입니다 -->
                                 <th class="customer_manage7">대표자</th>
                                 <th class="customer_manage8">사업자<br>등록번호</th>
                                 <th class="customer_manage9">총거래액</th>
                                 <th class="customer_manage10">담당<br>사원명</th>
                                 <th class="customer_manage11">사원번호</th>
                                 <th class="customer_manage12">사용여부</th>
                                 <th class="customer_manage13">비고</th>
                              </tr>
                           </thead>
                           <tbody>
                                 <% 
                                 request.setCharacterEncoding("utf-8");
                                 
                                 try{
                                    Class.forName(driver);
                                    conn=DriverManager.getConnection(url,"java","java");
                                    
                                    connect=true;

                                    // statement 생성
                                    CTstmt = (Statement)conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    EMPstmt = (Statement)conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    //SLstmt = (Statement)conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                    // 쿼리실행하고 결과를 담기
                                    CTrs = CTstmt.executeQuery(customerQuery);
                                    EMPrs = EMPstmt.executeQuery(employeeQuery);
                                    //SLrs = SLstmt.executeQuery(sellingQuery);
                                    
                                    //조회를 위한 stmt, rs 생성
                                     //Statement Search_EMPstmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                     //ResultSet JOINrs = Search_EMPstmt.executeQuery(customerQuery);
                                     
                                     JOINstmt = (Statement)conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                                     JOINrs = JOINstmt.executeQuery(joinQuery);
                                     
                            		 String customer_code= "";               //거래처코드
                                     String customer_first_registration = "";   //최초거래일
                                     String customer_name = "";               //거래처명
                                     String customer_sales_category = "";      //판매구분
                                     String customer_item_code = "46";         //종목
                                     String customer_wheter_new = "";			//분류 (신규/기존)
                                     String customer_businessman_name = "";      //대표자명
                                     String customer_business_code = "";         //사업자등록번호
                                     String part_employee_name = "";            //담당사원명
                                     String part_employee_code = "";            //사원번호
                                     String customer_business_status = "";      //사용여부
                                     String customer_memo = "";               //메모
				 					 String Total_transaction_amount = "";           
                                     
				 					// 천단위 콤마를 위한 객체 생성
									DecimalFormat df = new DecimalFormat("###,###");
                                         
                                    // ACrs.next() && EMPrs.next()
                                    
                                     try {                                        
                                                //담당사원명, 사원번호, 사업자등록번호 불러오기
                                                String search_EMPName = (String)request.getParameter("employeeName_search");
                                                String search_EMPCode = (String)request.getParameter("employeeCode_search");
                                                String search_CBCode = (String)request.getParameter("businessCode_search");
                                                
                                                //판매구분, 분류, 사용여부, 거래처명 불러오기
                                                                                       
                                                String search_CTMsalescategory = (String)request.getParameter("sales_category_search_hidden");
                                                String search_CTMcategory = (String)request.getParameter("category_search");
                                                String search_CTMbusienss_status = (String)request.getParameter("busienss_status_search");
                                                String search_CTMname = (String)request.getParameter("customer_name_search");
                                                
                                              	//*등록일자 조회를 위한 값 불러오기
                                                String search_startDate = request.getParameter("search_startDate");
                                                String search_endDate = request.getParameter("search_endDate");
                                                
                                                //등록일자 검색조건 필터
                                                int search_startDateFilter = 0;
                                                int search_endDateFilter = 0;
                                                
                                                //테이블 넘버링
                                                int store_no=0;
												
                                                if(search_EMPCode != null/*search_EMPName != null || search_CTMsalescategory != null || search_EMPCode != null || search_CBCode != null || search_CTMcategory != null || search_CTMbusienss_status != null || search_CTMname!= null*/) { //담당사원명, 판매구분, 사원번호, 사업자등록번호, 분류, 사용유무, 거래처명이  null이 아니면
                                                	//System.out.println("실행 되나?");
                                                	//등록일자 int로 바꾸기
                                                    if(search_startDate != "") {
                                                 	   search_startDateFilter = Integer.parseInt(search_startDate.replaceAll("[^0-9]", ""));
                                                    }
                                                    if(search_endDate != "") {
                                                 	   search_endDateFilter = Integer.parseInt(search_endDate.replaceAll("[^0-9]", ""));
                                                    }
                                                    
                                                   //몇 번째 행에 있는지 저장하는 필터 생성
                                                   int filterRow = 0;
                                                   ResultSetMetaData rsmd = JOINrs.getMetaData();
                                                   int rsLength = rsmd.getColumnCount();
                                                   
                                                   //검색 DB 개수
                                                   StringBuffer unitsCountCol = new StringBuffer();   //일의 자리
                                                   StringBuffer tensCountCol = new StringBuffer();    //십의 자리
                                                   StringBuffer totalCountCol = new StringBuffer();    //모든 자리 카운트
                                                   
                                                   //검색 횟수 저장 변수
                                                   int count = 0;    //자릿수가 계산된 Row 개수
                                                   int count2 = 0;   //검색된 Row 개수
                                                   
                                                   System.out.println("============= 거래처 조회 검색 값들 ============");
                                                   System.out.println("매출처 또는 매입처: " + search_CTMsalescategory);
                                                   System.out.println("신규 또는 기존: " + search_CTMcategory);
                                                   System.out.println("사용 또는 미사용: " + search_CTMbusienss_status);
                                                   System.out.println("조회한 거래처명: " + search_CTMname);
                                                   System.out.println("조회한 사업자등록번호: " + search_CBCode);
                                                   System.out.println("조회한 담당사원명: " + search_EMPName);
                                                   System.out.println("조회한 사원번호: " + search_EMPCode);
                                                   
                                                   System.out.println("날짜 확인용 startDate: " + search_startDate);
                                                   System.out.println("날짜 확인용 endDate: " + search_endDate);
                                                   System.out.println("날짜 확인용 startDateFilter: " + search_startDateFilter);
                                                   System.out.println("날짜 확인용 endDateFilter: " + search_endDateFilter);
                                                   System.out.println("-------------------------");
                                                   
                                                   //검색 코드 비교
                                                   while(JOINrs.next()) {
                                                	   //등록일자 비교를 위한 최초등록일
                                                	 int retnDate = changeNum(JOINrs.getString("customer_first_registration"));  
                                                         // 검색 조건 필터
                                            		 int searchFilter=0;
                                                         //**1개만 조건 검색했을 때**
                                                         // 1: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간 X, 끝기간X
                                                          if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 1;
                                                         }
                                                         // 2: 판매 구분 O, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간 X, 끝기간X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 1;
                                                         }
                                                      	// 3: 판매 구분 X, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간X, 끝기간X
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 1;
                                                         }
                                                      	// 4: 판매 구분 X, 분류X, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간X, 끝기간X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 1;
                                                         }
                                                      	// 5: 판매 구분 X, 분류X, 사용여부 X, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간X, 끝기간X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 1;
                                                         }
                                                      	// 6: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 X, 시작기간X, 끝기간X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 1;
                                                         }
                                                      	// 7: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 O, 사원번호 X, 시작기간X, 끝기간X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 1;
                                                         }
                                                      	// 8: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 O, 시작기간X, 끝기간X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 1;
                                                         }
                                                         
                                                         //** default 판매구분 O **
                                                      	// 9: 판매 구분 O, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X
                                                        if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status .equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 10: 판매 구분 O, 분류X, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 11: 판매 구분 O, 분류X, 사용여부 X, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") &&  JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 12: 판매 구분 O, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 13: 판매 구분 O, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 O, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode .equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 14: 판매 구분 O, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 O
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                         
                                                         //** default 사용여부 O **
                                                      	// 15: 판매 구분 X, 분류X, 사용여부 O, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 16: 판매 구분 X, 분류X, 사용여부 O, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 17: 판매 구분 X, 분류X, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 O, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 18: 판매 구분 X, 분류X, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                         
                                                         //** default 거래처명 O ** 
                                                      	// 19: 판매 구분 X, 분류X, 사용여부 X, 거래처명 O, 사업자등록번호 O, 담당사원 X, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 20: 판매 구분 X, 분류X, 사용여부 X, 거래처명 O, 사업자등록번호 X, 담당사원 O, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 21: 판매 구분 X, 분류X, 사용여부 X, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                         
                                                         //** default 사업자등록번호 O **
                                                      	// 22: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 O, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	// 23: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                         
                                                         //** default 담당사원 O **
                                                      	// 24: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 O, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 2;
                                                         }
                                                      	
                                                       	//** default 분류 O ** 
                                                       	// 25: 판매 구분 X, 분류O, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 2;
                                                          }
                                                      	// 26: 판매 구분 X, 분류O, 사용여부 X, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 2;
                                                          }
                                                      	// 27: 판매 구분 X, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 2;
                                                          }
                                                      	// 28: 판매 구분 X, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 O, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 2;
                                                          }
                                                      	// 29: 판매 구분 X, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 2;
                                                          }
                                                          
                                                          //*** 여러 조합 (택 3가지) 했을 때 ***
                                                      	// 30: 판매 구분 O, 분류O, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                            searchFilter = 3;
                                                         }
                                                     	// 31: 판매 구분 O, 분류O, 사용여부 X, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 X 
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 32: 판매 구분 O, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 33: 판매 구분 O, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 O, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 34: 판매 구분 O, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 O
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                          
                                                        // 35: 판매 구분 O, 분류 X, 사용여부 O, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }  
                                                      	// 36: 판매 구분 O, 분류 X, 사용여부 O, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 X  
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 37: 판매 구분 O, 분류 X, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 O, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 38: 판매 구분 O, 분류 X, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 O
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                          
                                                      	// 39: 판매 구분 O, 분류 X, 사용여부 X, 거래처명 O, 사업자등록번호 O, 담당사원 X, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                       	// 40: 판매 구분 O, 분류 X, 사용여부 X, 거래처명 O, 사업자등록번호 X, 담당사원 O, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1&& search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 41: 판매 구분 O, 분류 X, 사용여부 X, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 O
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 42: 판매 구분 O, 분류 X, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 O, 사원번호 X    
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          } 
                                                      	// 43: 판매 구분 O, 분류 X, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 O
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 &&  search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 44: 판매 구분 O, 분류 X, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 O, 사원번호 X
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1  && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          } 
                                                      	// 45: 판매 구분 X, 분류 O, 사용여부 O, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && JOINrs.getString("customer_name").equals(search_CTMname) &&search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 46: 판매 구분 X, 분류 O, 사용여부 O, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 47: 판매 구분 X, 분류 O, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 O, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 48: 판매 구분 X, 분류 O, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                          
                                                      	// 49: 판매 구분 X, 분류 X, 사용여부 O, 거래처명 O, 사업자등록번호 O, 담당사원 X, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && JOINrs.getString("customer_name").equals(search_CTMname) && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 50: 판매 구분 X, 분류 X, 사용여부 O, 거래처명 O, 사업자등록번호 X, 담당사원 O, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          } 
                                                      	
                                                      	// 51: 판매 구분 X, 분류 X, 사용여부 O, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("")&& JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                          
                                                      	// 52: 판매 구분 X, 분류 X, 사용여부 X, 거래처명 O, 사업자등록번호 O, 담당사원 O, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 53: 판매 구분 X, 분류 X, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 O, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1  && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                          
                                                      	// 54: 판매 구분 X, 분류 X, 사용여부 O, 거래처명 X, 사업자등록번호 O, 담당사원 O, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1&& JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 55: 판매 구분 X, 분류 X, 사용여부 O, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1&& search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 56: 판매 구분 X, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 O, 사원번호 X
                                                         if(search_CTMsalescategory.equals("0")&& JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 57: 판매 구분 X, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0")&& JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 58: 판매 구분 X, 분류X, 사용여부 X, 거래처명 O, 사업자등록번호 O, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0")&& search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("")&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                      	// 59: 판매 구분 X, 분류X, 사용여부 X, 거래처명 O, 사업자등록번호 O, 담당사원 X, 사원번호 O
                                                         if(search_CTMsalescategory.equals("0")&& search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 3;
                                                          }
                                                        // 60: *** 전체 조회 *** => 판매 구분 O, 분류 O, 사용여부 O, 거래처명 O, 사업자등록번호 O, 담당사원 O, 사원번호 O
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && JOINrs.getString("customer_name").equals(search_CTMname) && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1&& search_startDateFilter==0 && search_endDateFilter==0){
                                                             searchFilter = 4;
                                                          }
                                                      	// 61: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간 O, 끝기간X
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter<=retnDate && search_endDateFilter==0){
                                                           searchFilter = 5;
                                                        }
                                                      	// 62: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간 X, 끝기간O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter==0 && search_endDateFilter>=retnDate){
                                                           searchFilter = 5;
                                                        } 
                                                      	// 63: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간 O, 끝기간O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter<=retnDate && search_endDateFilter>=retnDate){
                                                           searchFilter = 5;
                                                        }
                                                        
                                                      	// 64: 판매 구분 O, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간 O, 끝기간O
                                                         if(JOINrs.getString("customer_sales_category").equals(search_CTMsalescategory) && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter<=retnDate && search_endDateFilter>=retnDate){
                                                           searchFilter = 5;
                                                        }
                                                      	// 65: 판매 구분 X, 분류O, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간 O, 끝기간O
                                                         if(search_CTMsalescategory.equals("0") && JOINrs.getString("customer_wheter_new").equals(search_CTMcategory) && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter<=retnDate && search_endDateFilter>=retnDate){
                                                           searchFilter = 5;
                                                        }
                                                      	// 66: 판매 구분 X, 분류X, 사용여부 O, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간 O, 끝기간O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && JOINrs.getString("customer_business_status").equals(search_CTMbusienss_status) && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter<=retnDate && search_endDateFilter>=retnDate){
                                                           searchFilter = 5;
                                                        }
                                                      	// 67: 판매 구분 X, 분류X, 사용여부 X, 거래처명 O, 사업자등록번호 X, 담당사원 X, 사원번호 X, 시작기간 O, 끝기간O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && JOINrs.getString("customer_name").equals(search_CTMname) && search_CBCode.equals("") && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter<=retnDate && search_endDateFilter>=retnDate){
                                                           searchFilter = 5;
                                                        }
                                                      	// 68: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 O, 담당사원 X, 사원번호 X, 시작기간 O, 끝기간O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && JOINrs.getString("customer_business_code").indexOf(search_CBCode) != -1 && search_EMPName.equals("") && search_EMPCode.equals("") && search_startDateFilter<=retnDate && search_endDateFilter>=retnDate){
                                                           searchFilter = 5;
                                                        }
                                                      	// 69: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 O, 사원번호 X, 시작기간 O, 끝기간O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && JOINrs.getString("part_employee_name").indexOf(search_EMPName) != -1 && search_EMPCode.equals("") && search_startDateFilter<=retnDate && search_endDateFilter>=retnDate){
                                                           searchFilter = 5;
                                                        }
                                                      	// 70: 판매 구분 X, 분류X, 사용여부 X, 거래처명 X, 사업자등록번호 X, 담당사원 X, 사원번호 O, 시작기간 O, 끝기간O
                                                         if(search_CTMsalescategory.equals("0") && search_CTMcategory.equals("0") && search_CTMbusienss_status.equals("0") && search_CTMname.equals("0") && search_CBCode.equals("") && search_EMPName.equals("") && JOINrs.getString("part_employee_code").indexOf(search_EMPCode) != -1 && search_startDateFilter<=retnDate && search_endDateFilter>=retnDate){
                                                           searchFilter = 5;
                                                        }
                                                        System.out.println("searchFilter -> " + searchFilter);
                                                        
                                                     	//DB Row Data 주입
			                                             switch(searchFilter){
			                                             case 1:
			                                                // 현재 행 위치
			                                                filterRow = JOINrs.getRow();
			                                                // 갯수 및 Row 수치 카운트
			                                                if(filterRow/10 == 0){ // 일의 자리
			                                                   unitsCountCol.append(filterRow);
			                                                } else if(filterRow/10 != 0){ // 십의 자리
			                                                   tensCountCol.append(filterRow);
			                                                }
			                                                totalCountCol.append(filterRow); // 모든 자리
			                                                break;
			                                             case 2:
			                                                // 현재 행 위치
			                                                filterRow = JOINrs.getRow();
			                                                // 갯수 및 Row 수치 카운트
			                                                if(filterRow/10 == 0){ // 일의 자리
			                                                   unitsCountCol.append(filterRow);
			                                                } else if(filterRow/10 != 0){ // 십의 자리
			                                                   tensCountCol.append(filterRow);
			                                                }
			                                                totalCountCol.append(filterRow); // 모든 자리
			                                                break;
			                                             case 3:
			                                                // 현재 행 위치
			                                                filterRow = JOINrs.getRow();
			                                                // 갯수 및 Row 수치 카운트
			                                                if(filterRow/10 == 0){ // 일의 자리
			                                                   unitsCountCol.append(filterRow);
			                                                } else if(filterRow/10 != 0){ // 십의 자리
			                                                   tensCountCol.append(filterRow);
			                                                }
			                                                totalCountCol.append(filterRow); // 모든 자리
			                                                break;
			                                             case 4:
			                                                // 현재 행 위치
			                                                filterRow = JOINrs.getRow();
			                                                // 갯수 및 Row 수치 카운트
			                                                if(filterRow/10 == 0){ // 일의 자리
			                                                   unitsCountCol.append(filterRow);
			                                                } else if(filterRow/10 != 0){ // 십의 자리
			                                                   tensCountCol.append(filterRow);
			                                                }
			                                                totalCountCol.append(filterRow); // 모든 자리
			                                                break;
			                                             case 5:
			                                                 // 현재 행 위치
			                                                 filterRow = JOINrs.getRow();
			                                                 // 갯수 및 Row 수치 카운트
			                                                 if(filterRow/10 == 0){ // 일의 자리
			                                                    unitsCountCol.append(filterRow);
			                                                 } else if(filterRow/10 != 0){ // 십의 자리
			                                                    tensCountCol.append(filterRow);
			                                                 }
			                                                 totalCountCol.append(filterRow); // 모든 자리
			                                                 break;
			                                             }//searchFilter END
                                                   
                                                   } //while END
                                                
                                                   //검색 횟수 저장
                                                   count = unitsCountCol.length() + tensCountCol.length();
                                                   count2 = unitsCountCol.length() + tensCountCol.length()/2;
                                                   
                                                   System.out.println("unitsCountCol : " + unitsCountCol);
                                                   System.out.println("tensCountCol : " + tensCountCol);
                                                   System.out.println("totalCountCol : " + totalCountCol);
                                                   System.out.println("검색된 횟수는 : " + count2 + "번");
                                                   
                                                   //try-catch 
                                                   try {
                                                      //검색된 Row 데이터
                                                      int colData[] = new int[count];
                                                      String buf="";
                                                      
                                                      for(int i = 0; i<count; i++) {
                                                         //일의 자리랑 십의 자리 나누기
                                                         try {
                                                            //일의 자리 O, 십의 자리 x
                                                            if(unitsCountCol.length() >= 1 && tensCountCol.length() <= 1) {
                                                               buf = Character.toString(totalCountCol.charAt(i));
                                                               colData[i] = Integer.parseInt(buf);
                                                               
                                                               System.out.print(colData[i] + " ");
                                                            }
                                                            
                                                            //일의 자리 O, 십의 자리 O
                                                            if(unitsCountCol.length() >= 1 && tensCountCol.length() >= 1) {
                                                               int unitsTendsFilter = unitsCountCol.length();
                                                               if(i < unitsTendsFilter){ //일의 자리
                                                                  buf = Character.toString(totalCountCol.charAt(i));
                                                                  colData[i] = Integer.parseInt(buf);
                                                                  
                                                                  System.out.print(colData[i] + " ");
                                                               }
                                                               if(i >= unitsTendsFilter) { // 십의 자리
                                                                  buf = Character.toString(totalCountCol.charAt(i)) + Character.toString(totalCountCol.charAt(i+1));
                                                                  colData[i] = Integer.parseInt(buf);
                                                                  
                                                                  System.out.print(colData[i] + " ");
                                                                  i++;
                                                               }
                                                            }
                                                            
                                                            //일의 자리 X, 십의 자리 O
                                                            if(unitsCountCol.length()<1 && tensCountCol.length()>=1){ 
                                                               buf = Character.toString(tensCountCol.charAt(i)) + Character.toString(tensCountCol.charAt(i+1));
                                                               colData[i] = Integer.parseInt(buf);
                                                               
                                                               System.out.print(colData[i] + " ");
                                                               i++;
                                                            }
                                                         }catch(Exception e) {
                                                            System.out.println(e);
                                                         } //일의자리랑 십의자리 나누기 try-catch END
                                                         
                                                      }//for문 END
                                                      System.out.println("");
                                                      
                                                      for(int i = 0; i<count; i++) {
                                                         try {
                                                            //십의 자리 배정 시 비어있는 부분 패스
                                                            if(colData[i] == 0) {
                                                               continue;
                                                            }
                                                            JOINrs.absolute(colData[i]);
                                                            store_no++;
                                                            //SLrs.absolute(colData[i]);
                                                            //입력한 값에 맞는 행의 값 가져오기
                                                            //JOINrs.absolute(filterRow);
                                                            
                                                            /*
                                                            customer_code = JOINrs.getString("customer_code");
                                                            customer_first_registration = JOINrs.getString("customer_first_registration");
                                                            customer_name = JOINrs.getString("customer_name");
                                                            customer_sales_category = JOINrs.getString("customer_sales_category");
                                                            customer_wheter_new = JOINrs.getString("customer_wheter_new");
                                                            customer_businessman_name = JOINrs.getString("customer_businessman_name");
                                                            customer_business_code = JOINrs.getString("customer_business_code");
                                                            part_employee_name = JOINrs.getString("part_employee_name");
                                                            part_employee_code = JOINrs.getString("part_employee_code");
                                                            customer_business_status = JOINrs.getString("customer_business_status");
                                                            customer_memo = JOINrs.getString("customer_memo");
                                                           //Total_transaction_amount = SLrs.getString("Total_transaction_amount");
                                                           
                                                           if(customer_name.length() > 3){
                                                        	   customer_name = customer_name.replace(" ","<br>");
                                                           }else{
                                                        	   
                                                           }*/
                                                           
                                                           int buffer = Integer.parseInt(JOINrs.getString("Total_transaction_amount"));
                                                           Total_transaction_amount = df.format(buffer);
                                                           
                                                           customer_name = JOINrs.getString("customer_name");
                                                           if(customer_name.length() > 3)
                                                          	 customer_name = customer_name.replace(" ","<br>");
                                                            %>
                                                            
                                                            <tr>
                                                               <td class="li_customer_manage1"><%=store_no %></td>
                                                               <td class="li_customer_manage2"><%=JOINrs.getString("customer_code")%></td>
                                                               <td class="li_customer_manage3"><%=JOINrs.getString("customer_first_registration")%></td>
                                                               <td class="li_customer_manage4"><%= customer_name %></td>
                                                               <td class="li_customer_manage5"><%=JOINrs.getString("customer_sales_category")%></td>
                                                               <td class="li_customer_manage6"><%=JOINrs.getString("customer_wheter_new")%></td>
                                                               <td class="li_customer_manage7"><%=JOINrs.getString("customer_businessman_name")%></td>
                                                               <td class="li_customer_manage8"><%=JOINrs.getString("customer_business_code")%></td>
                                                               <td class="li_customer_manage9"><%=Total_transaction_amount %>원</td>
                                                               <td class="li_customer_manage10"><%=JOINrs.getString("part_employee_name")%></td>
                                                               <td class="li_customer_manage11"><%=JOINrs.getString("part_employee_code")%></td>
                                                               <td class="li_customer_manage12"><%=JOINrs.getString("customer_business_status")%></td>
                                                               <td class="li_customer_manage13"><%=JOINrs.getString("customer_memo")%></td>
                                                            </tr>
                                                            <%   

                                                         }catch(Exception e) {System.out.println(e);}
                                                      }         
                                                   }catch(Exception e){System.out.println(e);}
                                                                                             
                                                   } else { // null일때
                                                   //customerQuery = "SELECT * FROM customer";
                                                   //customerQuery = "SELECT c.customer_name, c.customer_code, c.customer_type, c.customer_item_code, c.customer_businessman_name, c.customer_business_code, c.customer_business_man_phone, c.customer_address, c.part_employee_name, c.part_employee_code, c.part_employee_phone, c.customer_memo, c.customer_sales_category, c.customer_business_status, c.customer_first_registration, SUM(item_unit_price*selling_count) as Total_transaction_amount FROM selling as s INNER JOIN customer as c ON s.customer_code=c.customer_code GROUP BY customer_name HAVING Total_transaction_amount is not null";
                                                   System.out.println("현재 조회한 값 : null");
                                                                                             
                                                   try {
                                                	  JOINrs.absolute(0);
                                                      int i=0;
                                                      while(JOINrs.next()) {
                                                         i++;
                                                         
                                                         /*
                                                         //테이블 값 가져오기
                                                         customer_code = CTrs.getString("customer_code");
                                                         customer_first_registration = CTrs.getString("customer_first_registration");
                                                         customer_name = CTrs.getString("customer_name");
                                                         customer_sales_category = CTrs.getString("customer_sales_category");
                                                         customer_wheter_new = CTrs.getString("customer_wheter_new");
                                                         customer_businessman_name = CTrs.getString("customer_businessman_name");
                                                         customer_business_code = CTrs.getString("customer_business_code");
                                                         part_employee_name = CTrs.getString("part_employee_name");
                                                         part_employee_code = CTrs.getString("part_employee_code");
                                                         customer_business_status = CTrs.getString("customer_business_status");
                                                         customer_memo = CTrs.getString("customer_memo");
                                                        
                                                         if(customer_name.length() > 3){
                                                      	   customer_name = customer_name.replace(" ","<br>");
                                                         }else{
                                                      	   
                                                         }
                                                         */
                                                         //Total_transaction_amount = SLrs.getString("Total_transaction_amount");
                                                         
                                                         
                                                         int buffer = 0;
                                                         try{
                                                        	 buffer = Integer.parseInt(JOINrs.getString("Total_transaction_amount"));
                                                         } catch(NumberFormatException e){
                                                        	 buffer = 0;
                                                         }
                                                         
                                                         
                                                         Total_transaction_amount = df.format(buffer);
                                                         
                                                         customer_name = JOINrs.getString("customer_name");
                                                         if(customer_name.length() > 3)
                                                        	 customer_name = customer_name.replace(" ","<br>");
                                                         
                                                        
                                                         %>
                                                         <tr id="list<%=i%>">
                                                            <td class="li_customer_manage1"><%=i%><input type="hidden" name="customer_code_form" value="<%=i%>"></td>
                                                            <td class="li_customer_manage2"><%=JOINrs.getString("customer_code")%></td>
                                                            <td class="li_customer_manage3"><%=JOINrs.getString("customer_first_registration")%></td>
                                                            <td class="li_customer_manage4"><%=customer_name%></td>
                                                            <td class="li_customer_manage5"><%=JOINrs.getString("customer_sales_category")%></td>
                                                            <td class="li_customer_manage6"><%=JOINrs.getString("customer_wheter_new")%></td>
                                                            <td class="li_customer_manage7"><%=JOINrs.getString("customer_businessman_name")%></td>
                                                            <td class="li_customer_manage8"><%=JOINrs.getString("customer_business_code")%></td>
                                                            <td class="li_customer_manage9"><%=Total_transaction_amount/*JOINrs.getString("Total_transaction_amount")*/ %>원</td>
                                                            <td class="li_customer_manage10"><%=JOINrs.getString("part_employee_name")%></td>
                                                            <td class="li_customer_manage11"><%=JOINrs.getString("part_employee_code")%></td>
                                                            <td class="li_customer_manage12"><%=JOINrs.getString("customer_business_status")%></td>
                                                            <td class="li_customer_manage13"><%=JOINrs.getString("customer_memo")%></td>
                                                      <%   
                                                         } // while END
                                                      }   //try END   
                                                      catch(Exception e) {System.out.println("while문 오류 >> " + e);}
                                                } //else END                                       
                                             }//검색 try END
                                                catch(SQLException e) {System.out.println(" 오류>> " + e);}
                                          }//테이블 try END                              
                                          finally{ // 연결 해제
                                             // ResultSet 해제
                                             if(CTrs!=null)try{
                                                CTrs.close();
                                             }catch(SQLException ex){}
                                             
                                             if(EMPrs!=null)try{
                                                EMPrs.close();
                                             }catch(SQLException ex){}
                                             
                                             if(CTrs!=null)try{
                                                CTrs.close();
                                             }catch(SQLException ex){}
                                                                                 
                                             // Statement 해제
                                             if(CTstmt!=null)try{
                                                CTstmt.close();
                                             } catch(SQLException ex){}
                                             
                                             if(EMPstmt!=null)try{
                                                EMPstmt.close();
                                             }catch(SQLException ex){}
                                             
                                             if(CTstmt!=null)try{
                                                CTstmt.close();
                                             }catch(SQLException ex){}
                                                                              
                                             if(conn!=null)try{
                                                conn.close();
                                             }catch(SQLException ex){}
                                          }   
                                          %>
                                          <%!
												// 문자열을 숫자로 바꿔주는 메소드
												int changeNum(String buf){
													String str = buf.replaceAll("[^0-9]", "");
													
													return Integer.parseInt(str);
												}
											%>
                                       </tr>
                                    </tbody>
                                 </table>
                              </div>
                           </div>
                        </div>
                     </div>
            
            
            
            
            <!--===============================================================================================-->
            <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
            <!--===============================================================================================-->
            <script src="vendor/bootstrap/js/popper.js"></script>
            <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
            <!--===============================================================================================-->
            <script src="vendor/select2/select2.min.js"></script>
            <!--===============================================================================================-->
            <script src="js/main.js"></script>
            
            
            </div>
            <!-- End of Main Content -->
           

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2021</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">세션 종료를 원하면 Logout 버튼을 클릭하십시오.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="logout.jsp">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="js/demo/chart-area-demo.js"></script>
    <script src="js/demo/chart-pie-demo.js"></script>
    
    <!-- 달력위젯 -->
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
   <link rel="stylesheet" href="/resources/demos/style.css">
   <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
   <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
   <link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
   <link href="css/datepicker.css" rel="stylesheet">
   <script>
        $.datepicker.setDefaults({
        closeText: "닫기",
        prevText: "이전달",
        nextText: "다음달",
        currentText: "오늘",
        monthNames: ["1월", "2월", "3월", "4월", "5월", "6월",
          "7월", "8월", "9월", "10월", "11월", "12월"
        ],
        monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월",
          "7월", "8월", "9월", "10월", "11월", "12월"
        ],
        dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
        dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
        dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
        weekHeader: "주",
        dateFormat: "yy.mm.dd", // 날짜형태 예)yy년 m월 d일
        firstDay: 0,
        isRTL: false,
        showMonthAfterYear: true,
        yearSuffix: "년"
      });
      
     $( function() {
       $( "#store_datepicker_2, #store_datepicker_3" ).datepicker();
     } )
    </script>
    
    

</body>

<script>
        try{
           var optionSelect;
           // 검색 버튼 클릭시 select에 있는 값을 넣음
            $("#store_search_store_lookup_data-submit-button").click(function() {
               // select 된 값
               optionSelect = $("select[name=sales_category_search]").val();
               console.log("select 값 : " + optionSelect);
               
               $("input[name=sales_category_search_hidden]").attr('value', optionSelect);
         })
        }catch (e) {
           console.log("select 코드 오류 발생 -> " + e);
      }
         
</script>


</html>
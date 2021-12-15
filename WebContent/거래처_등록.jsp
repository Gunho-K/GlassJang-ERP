<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db_transaction.*" %>

<!-- 데이터베이스 커넥터 -->
<%
	Connection conn=null;
	Statement CTstmt = null;
	Statement EMPstmt = null;
	
	ResultSet CTrs = null;
	ResultSet EMPrs = null;
	
	// 드라이버 및 데이터베이스 설정
	String driver="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
	// 거래처 테이블 선택
	String customerQuery="select * from customer";
	String customerQuery2="SELECT COUNT(customer_name) as customer_name FROM customer";
	String employeeQuery="select * from employee";
	
	
	Boolean connect=false;

%>
<!DOCTYPE html>
<html>

<head>

	<meta http-equiv="Content-Type" content="text/html">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>GLASS 長 - 거래처 등록</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    
    
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
                
                <!-- 상단바 -->
                <nav class="navbar navbar-dark bg-primary">
					<div class="container-fluid">
						<a class="navbar-brand mb-0 h1" href="#">거래처 등록</a>
					</div>
				</nav>
				
				<!-- 거래처 등록 입력 -->
				<form action="customer_RegistAction.jsp" method="post">
				<!-- 첫줄 -->
				<div class="row m-3">
				    <div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px;height:40px">
							  <span aria-hidden="true"></span>판매 구분
							</button>
					      <div class="input-group-btn">
							       <select class="form-control ml-1" name="customer_sales_category" style="width:170px">
							      	<option value="매출처">매출처</option>
							      	<option value="매입처">매입처</option>
							      </select>
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					
					<div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:120px;height:40px;margin-left:70px">
							  <span aria-hidden="true"></span>주소
							</button>
					      <div class="input-group-btn m-1">
					       	<input type="text" class="form-control-sm" name="customer_address" style="width:170px; border-radius: 0.35rem;" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					
					
					<div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:90px;height:40px;margin-left:90px">
							  <span aria-hidden="true"></span>상호명
							</button>
					      <div class="input-group-btn m-1">
					       	<input type="text" class="form-control-sm" name="customer_name" style="width:170px; border-radius: 0.35rem;" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
                </div>
                
                <!-- 두번째 줄 -->
                <div class="row m-3">
				    <div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px;height:40px;">
							  <span aria-hidden="true"></span>대표자
							</button>
					      <div class="input-group-btn ml-1 mt-1">
					       	<input type="text" class="form-control-sm" name="customer_businessman_name" style="width:170px;border-radius: 0.35rem;" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:120px;height:40px;margin-left:70px">
							  <span aria-hidden="true"></span>사업자등록번호
							</button>
					      <div class="input-group-btn  ml-1 mt-1">
					      	<input type="text" class="form-control-sm" name="customer_business_code" style="width:170px;border-radius: 0.35rem;" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:90px;height:40px;margin-left:90px">
							  <span aria-hidden="true"></span>연락처
							</button>
					      <div class="input-group-btn ml-1 mt-1">
					        <input type="text" class="form-control-sm" name="customer_business_man_phone" style="width:170px;border-radius: 0.35rem;" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
                </div>
                
                 
                <!-- 세번째 줄 -->
                <div class="row m-3">
				    <div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px;height:40px">
							  <span aria-hidden="true"></span>업태
							</button>
					      <div class="input-group-btn ml-1 mt-1 ">
					       	<input type="text" class="form-control-sm" name="customer_type" style="width:170px;border-radius: 0.35rem;" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:120px;height:40px;margin-left:70px">
							  <span aria-hidden="true"></span>최초등록일
							</button>
					      <div class="form-group"> 
						      <div class="input-group date ml-1 mt-1"> 
								<input type="text" class="datepicker" name="customer_first_registration" style="width:170px;border-radius: 0.35rem;line-height: 27px" id="store_first_datepicker_1"> 
						      </div> 
					      </div>
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<!-- <div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
							  <span aria-hidden="true"></span>거래처코드
							</button>
					      <div class="input-group-btn m-1">
					       	<input type="text" class="form-control-sm" name="customer_code" style="width:170px" aria-describedby="basic-addon2">
					      </div> 
					    </div>
					</div> -->
                </div>
                
                <hr>
                <!-- 네번째 줄 -->
                <div class="row m-3">
				    <div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px;height:40px">
							  <span aria-hidden="true"></span>담당사원명
							</button>
					      <div class="input-group-btn m-1">
					       	<input type="text" class="form-control-sm" name="part_employee_name" style="width:170px;border-radius: 0.35rem;" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:120px;height:40px;margin-left:70px">
							  <span aria-hidden="true"></span>사원번호
							</button>
					      <div class="input-group-btn m-1">
					      	<input type="text" class="form-control-sm" name="part_employee_code" style="width:170px;border-radius: 0.35rem;" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
					    <div class="input-group">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:90px;height:40px;margin-left:90px">
							  <span aria-hidden="true"></span>연락처
							</button>
					      <div class="input-group-btn m-1">
					      	<input type="text" class="form-control-sm" name="part_employee_phone" style="width:170px;border-radius: 0.35rem;" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
                </div>
                
                 
                <!-- 메모 -->
                <div class="row ml-3 mb-3" style="width:100%">
				    <div class="col-lg" style="width:100%">
					    <div class="input-group"style="width:100%">
							<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
							  <span aria-hidden="true"></span>메모<br>(비고)
							</button>
					      <div class="m-1" style="width:90%">
					       	<input type="text" class="form-control-lg" name="customer_memo" aria-describedby="basic-addon2"  style="width:1085px; border-radius: 0.35rem;">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
                </div>
                
                <!-- 거래처 코드 만들기 -->
                <%
                request.setCharacterEncoding("utf-8");
                
                try{
					Class.forName(driver);
					conn=DriverManager.getConnection(url,"java","java");
					
					connect=true;

					// statement 생성
					CTstmt = (Statement)conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
					// 쿼리실행하고 결과를 담기
					CTrs = CTstmt.executeQuery(customerQuery2);

        			
        			while(CTrs.next()){ 
        				
                        String cno = CTrs.getString("customer_name");
                        int cno1 = Integer.parseInt(cno);
        				//String customer_cno = (String)request.getParameter("customer_name");
                    %>
                        <input type="hidden" name="customer_code_form" value="<%=cno1+1%>">
        			<% }
	                }catch(SQLException ex){
						out.println(ex.getMessage());
						ex.printStackTrace();
					}finally{ // 연결 해제
						// ResultSet 해제
						if(CTrs!=null)try{
							CTrs.close();
						}catch(SQLException ex){}
						
						
						// Statement 해제
						if(CTstmt!=null)try{
							CTstmt.close();
						} catch(SQLException ex){}
						
						
						if(conn!=null)try{
							conn.close();
						}catch(SQLException ex){}
					}// finally_end
	 
	        			
        			%>
                
                <!-- 등록버튼 -->
                <div class="form-row" style="margin-left:50%">
                	<button type="submit" class="btn btn-primary">등록</button>
                	<!-- <input class="d-none d-sm-inline-block btn btn-primary shadow-sm" type="submit" id="store_lookup_data-submit-button" value="등록" /> -->
	            </div>
	            
                <!-- /.container-fluid -->
                
                </form>

            </div>
            <!-- End of Main Content -->
            </div>

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
	    $( "#store_first_datepicker_1" ).datepicker();
	  } );
	 </script>
<!-- 	<script> -->
// 		$("input[name=customer_code_form]").attr('value',);
<!-- 	</script> -->
    
   
</body>

</html>
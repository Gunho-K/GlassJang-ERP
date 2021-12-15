<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db_transaction.*" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>

<!-- 데이터베이스 커넥터 -->
<%
	Connection conn=null;
	Statement ITEMstmt = null;
	ResultSet ITEMrs = null;
	
	// 드라이버 및 데이터베이스 설정
	String driver="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
	// 거래처 테이블 선택
	String ItemQuery="select * from item";
	
	
	Boolean connect=false;
%>



<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>GLASS 長 - 품목 등록</title>

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
							<a class="navbar-brand mb-0 h1" href="#">품목 등록</a>
						</div>
					</nav>
                </div>
                <!-- /.container-fluid -->
				
				<form action="stock_itemEditAction.jsp" method="post">
				<!-- 재고 품목 등록 테이블 -->
				<div class="limiter">
					<div class="container-table100">
						<div class="wrap-table100">
							<div class="table100" style="width:100%; height:450px; overflow:auto">
								<table>
									<thead>
										<tr class="table100-head">
											<th class="item_regist0"> </th>
											<th class="item_regist1">No</th>
											<th class="item_regist2">품목코드</th>
											<th class="item_regist3">품목명</th>
											<th class="item_regist4">규격</th>
											<th class="item_regist5">단위</th>
											<th class="item_regist6">단가</th>
											<th class="item_regist7">원가</th>
										</tr>	
									</thead>
									<tbody>
										<% 
											try{
												Class.forName(driver);
												conn=DriverManager.getConnection(url,"java","java");
												
												connect=true;

												// statement 생성
												ITEMstmt = (Statement)conn.createStatement();
												// 쿼리실행하고 결과를 담기
												ITEMrs = ITEMstmt.executeQuery(ItemQuery);
												
												
												int i=0;
					       							while(ITEMrs.next()){ 
													i++;
													
													// 값 가져오기
													String item_code = ITEMrs.getString("item_code"); // 품목코드
													String item_name = ITEMrs.getString("item_name"); // 품목명
													String item_standard = ITEMrs.getString("item_standard");
													String item_unit_name = ITEMrs.getString("item_unit_name");
													int item_unit_price = ITEMrs.getInt("item_unit_price");
													int item_original_price = ITEMrs.getInt("item_original_price");
													
													// 천단위 콤마를 위한 객체 생성
													DecimalFormat df = new DecimalFormat("###,###");
													// 천단위 콤마 문자열
													String itemUnitPriceDF = df.format(item_unit_price);
													String item_original_priceDF = df.format(item_original_price);
												%>
													<tr>
													<td class="li_item_regist0"><input type="checkbox" id="checkbox" name="stock_manage_checkbox" value="" onclick="checkOnlyOne(this)"></td>
													<td class="li_item_regist1"><%=i %></td>
													<td class="li_item_regist2"><%=item_code %></td>
													<td class="li_item_regist3"><%=item_name %></td>
													<td class="li_item_regist4"><%=item_standard %></td>
													<td class="li_item_regist5"><%=item_unit_name %></td>
													<td class="li_item_regist6"><% out.print(itemUnitPriceDF + "원");%></td>
													<td class="li_item_regist7"><% out.print(item_original_priceDF + "원");%></td>
													
											<%	}
											}catch(SQLException ex){
												out.println(ex.getMessage());
												ex.printStackTrace();
											}finally{ // 연결 해제
												// ResultSet 해제
												if(ITEMrs!=null)try{
													ITEMrs.close();
												}catch(SQLException ex){}
												
												// Statement 해제
												if(ITEMstmt!=null)try{
													ITEMstmt.close();
												} catch(SQLException ex){}
												
												if(conn!=null)try{
													conn.close();
												}catch(SQLException ex){}
											}// finally_end
											%>
										</tr>
									</tbody>
								</table>
								
							</div>
						</div>
					</div>
				</div>
				
				<!-- 등록 삭제 버튼 -->
                <div class="row">
					<div class="col-md-3" style="margin-left:45%">
	                  <a id="store_lookup_data-submit-button" href="jsp:" class="d-none d-sm-inline-block btn btn-primary shadow-sm" data-toggle="modal" data-target="#itemEnrollModal">등록</a>
	                  <!-- <a id="store_lookup_data-submit-button" href="#" class="d-none d-sm-inline-block btn btn-primary shadow-sm" ><button style="none">수정</button></a> -->
	                  <a id="stock_edit_data-submit-button" href="jsp:" class="d-none d-sm-inline-block btn btn-primary shadow-sm" data-toggle="modal" data-target="#itemEditModal" onclick="checkTest()">수정</a>
	            	</div>
				</div>
				</form>
				
				<!-- 등록 모달 -->
				<div class="modal fade" id="itemEnrollModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 style="color:black" class="modal-title" id="exampleModalLabel">품목 등록</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body" style="width:1000px">
				      	<!-- 품목 등록 입력 폼 -->
				        <form action="stock_itemRegistAction.jsp" method="post">
				        	<!-- 첫줄 -->
							<div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">품목코드</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" id="item_code_form" name="item_code_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" >
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">품목명</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" >
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">규격</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_standard_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" >
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
			                
			                <!-- 두번째 줄 -->
			                <div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">단위</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_unit_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">단가</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_unit_price_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">원가</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_original_price_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
			              <div class="modal-footer">
					      	<button type="submit" class="btn btn-primary">등록</button>
					       	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					      </div>
				        </form>
				      </div>
				      
				    </div>
				  </div>
				</div>
				
				
				<!-- 수정 모달 -->
				<div class="modal fade" id="itemEditModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 style="color:black" class="modal-title" id="exampleModalLabel">품목 등록</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body" style="width:1000px">
				      	<!-- 품목 등록 입력 폼 -->
				        <form action="stock_itemEditAction.jsp" method="post">
				        	<!-- 첫줄 -->
							<div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">품목코드</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" id="item_code_form" name="item_code_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7" readonly >
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">품목명</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" >
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">규격</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_standard_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" >
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
			                
			                <!-- 두번째 줄 -->
			                <div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">단위</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_unit_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">단가</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_unit_price_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">원가</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_original_price_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
			              <div class="modal-footer">
					      	<button type="submit" class="btn btn-primary">등록</button>
					       	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					      </div>
				        </form>
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
    
    
    <script>
		// CheckBox를 한 개만 클릭할 수 있게 해주는 함수
		function checkOnlyOne(element){
			// 체크박스 정보 가져옴
			const checkboxes = document.getElementsByName("stock_manage_checkbox");
			
			checkboxes.forEach((cb) => { // 나머지는 체크 해제
				cb.checked = false;
			})
			
			// 현재 선택된 element만을 선택
			element.checked = true;
		}
		
		// 등록시 체크박스 선택 확인
		function checkTest() {
			// 체크박스 정보 가져옴
			const checkboxes = document.getElementsByName("stock_manage_checkbox");
			var check = 0;
			
			// 한 개도 체크가 안 되어 있다면
			checkboxes.forEach((cb) => {
				if(cb.checked == true){
					//alert('체크가 돼있다!');
					check += 1;
				}
			})
			
			if(check == 0){
				alert('체크박스를 선택해주세요.');
				location.reload(true);
			}
		}
	</script>
	<script>
		$("#stock_edit_data-submit-button").click(function(){ 
			
			var rowData = new Array();
			var colNo = "";
			var colItemCode = "";
			var colItemName = "";
			var colItem_standard = "";
			var colItemUnitName = "";
			var colItemUnitPrice = "";
			var colItemOriginalPrice = "";
			
			var tr;
			var td;
			
			//var testArray = new Array("");
			
			var checkbox = $("input[name=stock_manage_checkbox]:checked");
			
			// 체크된 체크박스 값을 가져온다
			checkbox.each(function(i) {
	
				// Script part 1
				try{
					// checkbox.parent() : checkbox의 부모는 <td>이다.
					// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
					tr = checkbox.parent().parent().eq(i);
					td = tr.children();
					
					// 체크된 row의 모든 값을 배열에 담는다.
					rowData.push(tr.text());
					
					// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
					colNo = td.eq(1).text();
					colItemCode = td.eq(2).text();
					colItemName = td.eq(3).text();
					colItem_standard = td.eq(4).text();
					colItemUnitName = td.eq(5).text();
					colItemUnitPrice = td.eq(6).text();
					colItemOriginalPrice = td.eq(7).text();
				} catch (e) {
					console.log('Script Part 1 Excetion -> ' + e);
				}
			}); // End of checkbox.each 
			
			
			// Script part 2
			try{
				//alert(" * 체크된 Row의 no = "+colNo);
				//alert('colItemConde는 : ' + colItemCode);
				//alert('row = ' + rowData[0]);
				
				console.log('colNo : ' + colNo);
				console.log('colItemCode : ' + colItemCode);
				console.log('colItemName : ' + colItemName);
				console.log('colItem_standard : ' + colItem_standard);
				console.log('colItemUnitName : ' + colItemUnitName);
				console.log('colItemUnitPrice : ' + colItemUnitPrice);
				console.log('colItemOriginalPrice : ' + colItemOriginalPrice);
			}catch (e) {
				console.log('Script Part 2 Exception -> ' + e);
			}
			
			
			//console.log(rowData[0]);
			
			
			// Script part 3
			try{
				//$("input[name=item_code_form]").attr('value', colItemCode);
				// modal input의 값 지정
				$("input[name=no_form]").attr('value', colNo);
				$("input[name=item_code_form]").attr('value', colItemCode);
				$("input[name=item_name_form]").attr('value', colItemName);
				$("input[name=item_standard_form]").attr('value', colItem_standard);
				$("input[name=item_unit_name_form]").attr('value', colItemUnitName);
				$("input[name=item_unit_price_form]").attr('value', colItemUnitPrice);
				$("input[name=item_original_price_form]").attr('value', colItemOriginalPrice);
			} catch (e) {
				console.log('Script Part 3 Exception -> ' + e);
			}
			
		});
	</script>
    

</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db_transaction.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<!-- 데이터베이스 커넥터 -->
<%
	Connection conn=null;
	Statement ORDERSstmt = null;
	Statement CUstmt = null;
	Statement ITEMstmt = null;
	
	ResultSet ORDERSrs = null;
	ResultSet CUrs=null;
	ResultSet ITEMrs=null;
	
	// 드라이버 및 데이터베이스 설정
		String driver="com.mysql.jdbc.Driver";
		String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
		// 수주 테이블 선택
		String OrdersQuery="select * from orders";
		String customerNameQuery="select customer_name, customer_code from customer";
		String ItemQuery="select * from item";
		String ItemNameQuery="select item_name, item_unit_name, item_unit_price, item_code from item";
		
		
		Boolean connect=false;
%>

<html>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>GLASS 長 - 수주 등록</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
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
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a class="sidebar-brand d-flex align-items-center justify-content-center"
				href="business_info.jsp">
				<div class="sidebar-brand-icon rotate-n-15"></div>
				<div class="sidebar-brand-text mx-3">GLASS 長</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item active"><a class="nav-link" href="business_info.jsp">
					<div></div> <img id="Enterprise_logo" alt="" src="img/기업소개.png"
					width="15.31" height="14"> <span id="Enterprise_text">기업
						소개</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->

			<div class="sidebar-heading">관리 기능</div>


			<!-- Nav Item - 거래처 관리  Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages_1"
				aria-expanded="true" aria-controls="collapsePages_1"> <i
					class="fas fa-fw fa-folder"></i> <span>거래처</span>
			</a>
				<div id="collapsePages_1" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="거래처_등록.jsp">거래처 등록</a> <a
							class="collapse-item" href="거래처_조회.jsp">거래처 조회</a>
					</div>
				</div></li>

			<!-- Nav Item - 수주 관리  Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages_2"
				aria-expanded="true" aria-controls="collapsePages_2"> <i
					class="fas fa-fw fa-folder"></i> <span>수주</span>
			</a>
				<div id="collapsePages_2" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                    	<a class="collapse-item" href="수주_등록.jsp">수주 등록</a>
                        <a class="collapse-item" href="수주_현황.jsp">수주 현황</a>
                        <a class="collapse-item" href="수주_거래처별.jsp">거래처별 수주 현황</a>
                        <a class="collapse-item" href="수주_품목별.jsp">품목별 수주 현황</a>
                        <a class="collapse-item" href="수주_영업사원별.jsp">영업사원별 수주 현황</a>
                    </div>
				</div></li>

			<!-- Nav Item - 재고 관리  Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages_3"
				aria-expanded="true" aria-controls="collapsePages_3"> <i
					class="fas fa-fw fa-folder"></i> <span>재고</span>
			</a>
				<div id="collapsePages_3" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="재고_품목등록.jsp">품목 등록</a> <a
							class="collapse-item" href="재고_불량.jsp">불량 재고 관리</a> <a
							class="collapse-item" href="재고_관리.jsp">재고 관리</a>
					</div>
				</div></li>

			<!-- Nav Item - 매출 관리  Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages_4"
				aria-expanded="true" aria-controls="collapsePages_4"> <i
					class="fas fa-fw fa-folder"></i> <span>매출</span>
			</a>
				<div id="collapsePages_4" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="매출_등록.jsp">매출 등록</a> <a
							class="collapse-item" href="매출_집계.jsp">매출 집계 현황</a> <a
							class="collapse-item" href="매출_거래처별.jsp">거래처별 매출 현황</a> <a
							class="collapse-item" href="매출_품목별.jsp">품목별 매출 현황</a> <a
							class="collapse-item" href="매출_영업사원별.jsp">영업사원별 매출 현황</a>
					</div>
				</div></li>


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
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>



					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small">반갑습니다</span>
								<img class="img-profile rounded-circle"
								src="img/undraw_profile_3.svg">
						</a> <!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">

								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									Logout
								</a>
							</div></li>

					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<nav class="navbar navbar-dark bg-primary">
						<div class="container-fluid">
							<a class="navbar-brand mb-0 h1" href="#">수주 등록</a>
						</div>
					</nav>
				</div>
				
				
				<!-- /.container-fluid -->
				
	
				<!-- 수주 등록 테이블 -->
				<form action="order_CancelAction.jsp" method="post" name="orderform">
				<div class="limiter">
					<div class="container-table100">
						<div class="wrap-table100">
						
							<div class="table100" style="width:100%; height:450px; overflow:auto">
								<table>
									<thead>
										<tr class="table100-head">
											<th class="order_regist0" rowspan="2"> </th>
											<th class="order_regist1" rowspan="2">No</th>
											<th class="order_regist2" colspan="2">담당자</th>
											<th class="order_regist3" rowspan="2">거래처<br>코드</th>
											<th class="order_regist4" rowspan="2">거래처명</th>
											<th class="order_regist5" rowspan="2">품목<br>코드</th>
											<th class="order_regist6" rowspan="2">품목명</th>
											<th class="order_regist7" rowspan="2">단위</th>
											<th class="order_regist8" rowspan="2">수량</th>
											<th class="order_regist9" rowspan="2">단가</th>
											<th class="order_regist10" rowspan="2">수주<br>금액</th>
											<th class="order_regist11" rowspan="2">수주일</th>
											<th class="order_regist12" rowspan="2">수주<br>번호</th>
											<th class="order_regist13" rowspan="2">비고</th>
										</tr>
										<tr class="table100-head">
											<th class="order_regist14">사원번호</th>
											<th class="order_regist15">사원명</th>
										</tr>
										
									</thead>
									<tbody>
										<% 
											try{
												Class.forName(driver);
												conn=DriverManager.getConnection(url,"java","java");
												
												connect=true;

												// statement 생성
												ORDERSstmt = (Statement)conn.createStatement();
												ITEMstmt= (Statement)conn.createStatement();
												// 쿼리실행하고 결과를 담기
												ORDERSrs = ORDERSstmt.executeQuery(OrdersQuery);
												ITEMrs = ITEMstmt.executeQuery(ItemQuery);
												
												// ACrs.next() && EMPrs.next()
												
												int i=0;
					       							while(ORDERSrs.next()){ 
													i++;
													
													// 값 가져오기
													String employee_code = ORDERSrs.getString("employee_code"); // 사원번호
													String employee_name = ORDERSrs.getString("employee_name"); // 사원명
													String item_code = ORDERSrs.getString("item_code"); //품목코드
													String item_name = ORDERSrs.getString("item_name"); //품목명
													String customer_code = ORDERSrs.getString("customer_code"); //거래처코드
													String customer_name = ORDERSrs.getString("customer_name"); //거래처명
													String item_unit_name = ORDERSrs.getString("item_unit_name"); //단위
													int order_amount = ORDERSrs.getInt("order_amount"); //수량
													int item_unit_price = ORDERSrs.getInt("item_unit_price"); //단가
													int order_price = order_amount * item_unit_price; // 수주금액 (수량*단가)
													String order_date = ORDERSrs.getString("order_date"); //수주일
													String order_code = ORDERSrs.getString("order_code"); //수주번호
													String order_memo = ORDERSrs.getString("order_memo"); //비고
													
													
													// 천단위 콤마를 위한 객체 생성
													DecimalFormat df = new DecimalFormat("###,###");
													// 천단위 콤마 문자열
													String orderAmountDF = df.format(order_amount); //수량
													String itemUnitPriceDF = df.format(item_unit_price); // 단가
													String order_priceDF = df.format(order_price); // 수주금액
													
													 if(customer_name.length() > 3){
                                                  	   customer_name = customer_name.replace(" ","<br>");
                                                     }else{
                                                  	   
                                                     }
												%>
													<tr>
														<td class="li_order_regist0" onclick="event.cancelBubble=true"><input type="checkbox" id="checkbox" name="chbox" onclick="checkOnlyOne(this)"></td>
														<td class="li_order_regist1"><%=i %></td>
														<td class="li_order_regist14"><%=ORDERSrs.getString("employee_code")%></td>
														<td class="li_order_regist15"><%=ORDERSrs.getString("employee_name")%></td>
														<td class="li_order_regist3"><%=ORDERSrs.getString("customer_code")%></td>
														<td class="li_order_regist4"><%=ORDERSrs.getString("customer_name")%></td>
														<td class="li_order_regist5"><%=ORDERSrs.getString("item_code")%></td>
														<td class="li_order_regist6"><%=ORDERSrs.getString("item_name")%></td>
														<td class="li_order_regist7"><%=ORDERSrs.getString("item_unit_name")%></td>
														<td class="li_order_regist8"><%=ORDERSrs.getString("order_amount")%></td>
														<td class="li_order_regist9"><%=ORDERSrs.getString("item_unit_price")%>원</td>
														<td class="li_order_regist10"><% out.print(order_priceDF + "원"); %></td> <!-- 수주금액 -->
														<td class="li_order_regist11"><%=ORDERSrs.getString("order_date")%></td>
														<td class="li_order_regist12"><%=ORDERSrs.getString("order_code")%><input type="hidden" class="or_code" name="order_code_form" value=""></td>
														<td class="li_order_regist13"><%=ORDERSrs.getString("order_memo")%></td>
													
											<%	}
											}catch(SQLException ex){
												out.println(ex.getMessage());
												ex.printStackTrace();
											}finally{ // 연결 해제
												// ResultSet 해제
												if(ORDERSrs!=null)try{
													ORDERSrs.close();
												}catch(SQLException ex){}
											
												if(ITEMrs!=null)try{
													ORDERSrs.close();
												}catch(SQLException ex){}
												
												if(ORDERSrs!=null)try{
													ORDERSrs.close();
												}catch(SQLException ex){}
												
												// Statement 해제
												if(ORDERSstmt!=null)try{
													ORDERSstmt.close();
												} catch(SQLException ex){}
												
												if(ITEMstmt!=null)try{
													ORDERSstmt.close();
												} catch(SQLException ex){}
												
												if(ORDERSstmt!=null)try{
													ORDERSstmt.close();
												} catch(SQLException ex){}
												
												// 뒤에서 해제
												//if(conn!=null)try{
												//	conn.close();
												//}catch(SQLException ex){}
											}// finally_end
											%>
											
										
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				
				 <!-- 등록 취소 버튼 -->
				 <div class="row">
					<div class="col-md-3" style="margin-left:45%">
				  		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#OrederEnrollModal">등록</button>
				  		<button type="submit" class="btn btn-secondary" id="selectBtn">취소</button>
				  		
		            </div>
				 </div>
				 </form>
				 
			
                <!-- Modal -->
				<div class="modal fade" id="OrederEnrollModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 style="color:black" class="modal-title" id="exampleModalLabel">수주 등록</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body" style="width:1000px">
				      <!-- 수주 등록 입력 폼 -->
				        <form action="order_RegistAction.jsp" method="post">
				        	<!-- 첫줄 -->
							<div class="row m-3">
							   
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>수주일
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" class="datepicker" name="order_date_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" id="store_first_datepicker_1">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>담당<br>사원번호
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="emp_code_form" id="emp_code_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" onkeyup="complete_empName();">
								      </div><!-- /btn-group --><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>담당사원명
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="emp_name_form" id="emp_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
                
			                <!-- 두번째 줄 -->
			                <div class="row m-3">
							     <div class="col-lg-4">
											      <div class="input-group">
											  <button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
											    <span aria-hidden="true"></span>거래처명
											  </button>
											  <select name="customer_name_form" id="customer_name_form" class="form-control ml-1" style="width:170px" onchange="complete_custCode()">
											        	<option>전체</option>
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
										  <option name="거래처명" data-ccode="<%=CUrs.getString(2)%>"><%=CUrs.getString(1) %></option>
										  
										  <%	}
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

									    </select><!-- /btn-group -->
								      <!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>거래처코드
											  </button>
											        	<div class="input-group-btn m-1">
											         	<input type="text" name="customer_code_form" id="customer_code_form"  class="form-control-sm" style="width:170px; border: 1px solid gray;" readonly>
											        </div><!-- /btn-group -->
											      </div><!-- /input-group -->
											  </div><!-- /.col-lg-4 -->
											 <div class="col-lg-4">
										      <div class="input-group">
										  <button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										    <span aria-hidden="true"></span>품목명
										  </button>
										   <select name="item_name_form" id="item_name_form" class="form-control ml-2" style="width: 170px" onchange="complete_itemInfo()">
										        <option>전체</option>
										  <% 
										  try{
										  Class.forName(driver);
												conn=DriverManager.getConnection(url,"java","java");
												
												connect=true;

												// statement 생성
										
												ITEMstmt = (Statement)conn.createStatement();
												// 쿼리실행하고 결과를 담기
												ITEMrs = ITEMstmt.executeQuery(ItemNameQuery);
												
												// ACrs.next() && EMPrs.next()
												
												int i=0;
										           while(ITEMrs.next()){ 
										  i++;
										  
										  %>
										  <option data-uname="<%=ITEMrs.getString(2)%>" data-icode="<%=ITEMrs.getString(4)%>" data-uprice="<%=ITEMrs.getString(3)%>"><%=ITEMrs.getString(1) %></option>
										  
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
										</select><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								
			                </div>
			                
			                 
			                <!-- 세번째 줄 -->
			                <div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>품목코드
										</button>
								    	<div class="input-group-btn m-1">
								      		<input type="text" name="item_code_form" id="item_code_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" readonly>
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
						  <button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
						    <span aria-hidden="true"></span>단위
						  </button>
						  <div class="input-group-btn m-1">
						        	<input type="text" name="item_unit_name_form" id="item_unit_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" readonly>
						        </div><!-- /btn-group -->
						      </div><!-- /input-group -->
						  </div><!-- /.col-lg-4 -->
								 <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>수량
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="order_amount_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
						  </div>
						   <!-- 네번째 줄 -->
			                <div class="row m-3">
							     <div class="col-lg-4">
								    <div class="input-group">
								  <button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
								    <span aria-hidden="true"></span>단가
								  </button>
								        <div class="input-group-btn m-1">
								         	<input type="text" name="item_unit_price_form" id="item_unit_price_form" class="form-control-sm" style="width:170px; border: 1px solid gray;" readonly>
								        </div><!-- /btn-group -->
								      </div><!-- /input-group -->
								  </div><!-- /.col-lg-4 -->
							    
				    
				    </div>
				    <div class="modal-footer">
				      	<button type="submit" class="btn btn-primary">등록</button>
				      	
				       	<button type="submit" class="btn btn-secondary" data-dismiss="modal">취소</button>
				       	</form>
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
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">세션 종료를 원하면 Logout 버튼을 클릭하십시오.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
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
			  //document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);;
	</script>
	<script>
		$("#selectBtn").click(function(){ 
			
			//var rowData = new Array();
			var col1 = "";
			var checkbox = $("input[name=chbox]:checked");
			
			// 체크된 체크박스 값을 가져온다
			checkbox.each(function(i) {
	
				// checkbox.parent() : checkbox의 부모는 <td>이다.
				// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				
				// 체크된 row의 모든 값을 배열에 담는다.
				//rowData.push(tr.text());
				
				// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
				str = td.eq(13).text();
				str2 = td.eq(14).text();
				//col1 = td.eq(14).text();
				//var userid = td.eq(2).text()+", ";
				//var name = td.eq(3).text()+", ";
				//var email = td.eq(4).text()+", ";
				
			});
			if (str2=="취소"){
				alert("이미 취소된 수주입니다. 다시 선택해주세요.");
				//location.reload(true);
			}else if (str2=="출고"){
				alert("이미 출고된 수주입니다. 다시 선택해주세요.");
				//loaction.reload(true);
			}else{
			alert("수주 "+str+"를 취소하시겠습니까?");
			$("input[name=order_code_form]").attr('value',str);
			}
		});
		</script>
		<script>
			//사원번호, 사원명을 담을 자바스크립트 배열 변수
			var emp_info = [];
			<% 
			Statement EMPstmt = null;
			ResultSet EMPrs=null;
			String EmpQuery="select employee_code, employee_name from employee";
			try{
				Class.forName(driver);
				conn=DriverManager.getConnection(url,"java","java");
				
				connect=true;
				
				EMPstmt = (Statement)conn.createStatement();
				EMPrs = EMPstmt.executeQuery(EmpQuery);
				
				int i=0;
				while(EMPrs.next()) { 
					i++;
					String employee_code = EMPrs.getString("employee_code"); // 사원번호
					String employee_name = EMPrs.getString("employee_name");
			%>
				emp_info.push({
					empCode : "<%=employee_code%>",
					empName : "<%=employee_name%>"
				});
			<%
				}
			}catch(SQLException ex){
				out.println(ex.getMessage());
				ex.printStackTrace();
			}finally{ // 연결 해제
				// ResultSet 해제
				if(EMPrs!=null)try{
					EMPrs.close();
				}catch(SQLException ex){}
			
				// Statement 해제
				if(EMPstmt!=null)try{
					EMPstmt.close();
				} catch(SQLException ex){}
				
				if(conn!=null)try{
					conn.close();
				}catch(SQLException ex){}
			}// finally_end
			%>
			
			//이름 자동 생성 함수
			function complete_empName() {
				var codeValue = document.getElementById('emp_code_form').value;
				var isExist = false;
				for (var x in emp_info) {
					if (emp_info[x].empCode == codeValue) {
						document.getElementById('emp_name_form').value = emp_info[x].empName;
						isExist = true;
					}					
				}
				//매칭되는 값이 없으면 이름을 초기화
				  if(!isExist) {
				  document.getElementById('emp_name_form').value = "";
				  }
				  }
				  
				  //거래처 코드 입력
				  function complete_custCode() {
				  var tb_cname = document.getElementById('customer_name_form');
				  var tb_cname_index = tb_cname.options.selectedIndex;
				  var tb_ccode = tb_cname.options[tb_cname_index].getAttribute("data-ccode");
				  
				  document.getElementById('customer_code_form').value = tb_ccode;
				  }
				  
				  //단위, 단가 입력
				  function complete_itemInfo() {
				  var tb_iname = document.getElementById('item_name_form');
				  var tb_iname_index = tb_iname.options.selectedIndex;
				  var tb_uname = tb_iname.options[tb_iname_index].getAttribute("data-uname");
				  var tb_uprice = tb_iname.options[tb_iname_index].getAttribute("data-uprice");
				  var tb_icode = tb_iname.options[tb_iname_index].getAttribute("data-icode");
				  
				  document.getElementById('item_unit_name_form').value = tb_uname;
				  document.getElementById('item_unit_price_form').value = tb_uprice;
				  document.getElementById('item_code_form').value = tb_icode;
				  }
				  
				  
				  </script>
		<script>
		// CheckBox를 한 개만 클릭할 수 있게 해주는 함수
		function checkOnlyOne(element){
			// 체크박스 정보 가져옴
			const checkboxes = document.getElementsByName("chbox");
			
			checkboxes.forEach((cb) => { // 나머지는 체크 해제
				cb.checked = false;
			})
			
			// 현재 선택된 element만을 선택
			element.checked = true;
		}
	</script>
		

</body>

</html>
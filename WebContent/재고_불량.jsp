<%@page import="com.sun.xml.internal.ws.api.streaming.XMLStreamReaderFactory.Default"%>
<%@page import="com.sun.org.apache.xpath.internal.operations.Bool"%>
<%@page import="com.sun.org.apache.bcel.internal.generic.GETSTATIC"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db_transaction.*" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>

<!-- 데이터베이스 커넥터 -->
<%
	Connection conn=null;
	Statement BADSTOCKstmt = null;
	ResultSet BADSTOCKrs = null;
	
	// 드라이버 및 데이터베이스 설정
	String driver="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
	// 거래처 테이블 선택
	String badStockQuery="select * from bad_stock";
	// 재고 이름 리스트 query, st, rs 변수 생성
	String itemListQuery = "select item_name from stock";
	Statement itemListSTMT = null;
	ResultSet itemListRS = null;
	
	
	//Boolean connect=false;
	Class.forName(driver);
	conn=DriverManager.getConnection(url,"java","java");
%>


<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>GLASS 長 - 불량 재고 관리</title>

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
							<a class="navbar-brand mb-0 h1" href="#">불량 재고 관리</a>
						</div>
					</nav>
					
                
                
                	<!-- Page Heading -->
                	
                <!-- 검색구역 -->
                <form>
                <div class="row mt-3 ml-1">
				    <div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2" style="width:100px">품목코드</span>
					       <div class="input-group-btn m-1">
							 <input type="text" name="item_code_search" class="form-control-sm ml-2" aria-describedby="basic-addon2">
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
				    <div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2" style="width:100px">품목명</span>
					       <div class="input-group-btn m-2">
									<select name="item_name_search" class="form-control ml-2" style="width: 150px">
										<option value="전체">전체</option>
										<%
											itemListSTMT = (Statement)conn.createStatement();
											itemListRS = itemListSTMT.executeQuery(itemListQuery);
											
											while(itemListRS.next()){
												%>
												<option value="<%=itemListRS.getString("item_name")%>"><%=itemListRS.getString("item_name")%></option>
										<%	}
										%>
									</select>
									<input type="hidden" name="item_select_hidden" value="">
								</div>
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
						<div class="input-group">
							<span class="mt-2" style="width:100px">창고명</span>
					       	<div class="input-group-btn m-1">
					      	<select class="form-control ml-2" style="width:150px">
					      	<option value="본사 창고">본사 창고</option>
					      	</select>
					      </div>
					    </div><!-- /input-group -->
					    
					</div><!-- /.col-lg-4 -->
                </div>
                <!-- 두번째 줄 -->
                <div class="row mt-2 ml-1">
				    <div class="col-lg-5">
					    <div class="input-group" style="width:635px">
					      <span class="mt-2 mr-1"style="width:100px">기간</span>
					      <div class="form-group mt-1"> 
						      <div class="input-group date mt-1 ml-2"> 
								<input type="text" name="source_datepicker_search" class="datepicker" style="width:175px" id="stock_datepicker_1"> 
						      </div> 
					      </div>
					      <span class="mt-1 ml-2">~</span>
					      <div class="form-group m-1"> 
						      <div class="input-group date mt-1 ml-2"> 
								<input type="text" name="destination_datepicker_search" class="datepicker" style="width:175px" id="stock_datepicker_2"> 
						      </div> 
					      </div>					    
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-5 -->
					<div class="col-lg-6">
					    <div class="input-group ml-1">
					      <div class="row form-group"> 
					      	<div class="input-group-btn">
						      	<select name="year_picker_search" class="form-control ml-3" style="width:85px">
						      	<option value="0">전체</option>
						      	<option value="2018">2018</option>
						      	<option value="2019">2019</option>
						      	<option value="2020">2020</option>
						      	<option value="2021">2021</option>
						      	</select>
					      	</div>
     							<span class="row ml-2 mt-2">년</span>
    						<div class="input-group-btn">
						      	<select name="month_picker_search" class="form-control ml-4" style="width:85px">
						      	<option value="0">전체</option>
						      	<option value="01">01</option>
						      	<option value="02">02</option>
						      	<option value="03">03</option>
						      	<option value="04">04</option>
						      	<option value="05">05</option>
						      	<option value="06">06</option>
						      	<option value="07">07</option>
						      	<option value="08">08</option>
						      	<option value="09">09</option>
						      	<option value="10">10</option>
						      	<option value="11">11</option>
						      	<option value="12">12</option>
					      	</select>
					      	</div>
     							<span class="row ml-2 mt-2">월</span>
					      </div>
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-3 -->
					<div class="col-lg-1">
					     <button type="submit" id="bad_stock_data-submit-button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">확인</button>
					</div><!-- /.col-lg-3 -->
				 </div>
                </div>
                </form>
				<!-- ----------------------------------검색 구역 끝 -------------------------------------- -->
	            
	            <!-- 재고 관리 테이블 -->
					<div class="limiter">
						<div class="container-table100">
							<div class="wrap-table100">
								<div class="table100" style="width:100%; height:450px; overflow:auto">
									<table>
										<thead>
											<tr class="table100-head">
												<th class="inventory_err0"> </th>
												<th class="inventory_err1">No</th>
												<th class="inventory_err2">품목코드</th>
												<th class="inventory_err3">품목명</th>
												<th class="inventory_err4">주문일</th>
												<th class="inventory_err5">창고명</th>
												<th class="inventory_err6">단위</th>
												<th class="inventory_err7">수량</th>
												<th class="inventory_err8">단가</th>
												<th class="inventory_err9">재고금액</th>
												<th class="inventory_err10">반품일</th>
												<th class="inventory_err11">처리결과</th>
												<th class="inventory_err12">비고</th>
											</tr>
										</thead>
										<tbody>
											
											<% 
												try{
													System.out.println("======================== 불량 재고 관리 =======================");
													
													
													Class.forName(driver);
													conn=DriverManager.getConnection(url,"java","java");
													
		
													// statement 생성
													BADSTOCKstmt = (Statement)conn.createStatement();
													// 쿼리실행하고 결과를 담기
													BADSTOCKrs = BADSTOCKstmt.executeQuery(badStockQuery);
													
													//test를 위한 stmt, rs 생성
													Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
													ResultSet rs = stmt.executeQuery(badStockQuery);
													
													// Picker 버퍼 값(int로 바꾸기 전)
													String sourcePicker = (String)request.getParameter("source_datepicker_search");
													String destinationPicker = (String)request.getParameter("destination_datepicker_search");
													String yearPicker = (String)request.getParameter("year_picker_search");
													String monthPicker = (String)request.getParameter("month_picker_search");
													
													// 검색 필터
													String codeFilter = (String)request.getParameter("item_code_search");
													String nameFilter = (String)request.getParameter("item_name_search");
													int sourcePickerFilter = 0;
													int destinationPickerFilter = 0;
													int yearMonthPickerFilter = 0; // 삭제 해야함
													int yearPickerFilter = 0;
													int monthPickerFilter = 0;
													
													String yearMonthPicker = "";
													
													
													// 값 가져오기
													String bad_no = ""; // 넘버링
													String item_code = ""; // 품목코드
													String item_name = ""; // 품목명
													String order_date = ""; // 수주일
													String stock_storage_name = ""; // 창고명
													String item_unit_name = ""; // 단위
													int bad_stock_amount = 0; // 재고수량
													int item_unit_price = 0; // 단가
													int bad_stock_price = 0; // (불량)재고금액 -> 재고수량*단가
													String bad_stock_return_date = ""; // 반품일
													String bad_stock_result = ""; // 처리결과
													String bad_stock_memo = ""; // 비고
													
													// 천단위 콤마를 위한 객체 생성
													DecimalFormat df = new DecimalFormat("###,###");
													// 천단위 콤마 문자열
													String badStockAmountDF; // 재고수량
													String itemUnitPriceDF; // 단가
													String badStockPriceDF; // (불량)재고금액
													
													// Part 0
													try{
														// 첫 번째 로딩이 아니라면
														if(codeFilter != null){
															codeFilter = codeFilter.toUpperCase();
															//System.out.println("첫 번째 로딩 아니다!");
															
															// picker 값들이 null 값이 아니라면 숫자화
															if(sourcePicker != "")
																sourcePickerFilter = Integer.parseInt(sourcePicker.replaceAll("[^0-9]", ""));
															// 2
															if(destinationPicker != "")
																destinationPickerFilter = Integer.parseInt(destinationPicker.replaceAll("[^0-9]", ""));
															// 3
															if(yearPicker != null && monthPicker != null)
																yearMonthPickerFilter = Integer.parseInt((yearPicker + monthPicker).replaceAll("[^0-9]", ""))*100;
															//
															if(yearPicker != null)
																yearPickerFilter = Integer.parseInt(yearPicker);
															if(monthPicker != null)
																monthPickerFilter = Integer.parseInt(monthPicker);
															
															
															// 몇 번째 행에 있는지 저장하는 필터
															int filterRow = 0;
															// DB의 Row 개수
															ResultSetMetaData rsmd = rs.getMetaData();
															int rsLength = rsmd.getColumnCount();
															// 검색된 DB의 개수
															StringBuffer unitsCountCol = new StringBuffer(); // 일의자리 카운트
															StringBuffer tensCountCol = new StringBuffer(); // 십의자리 카운트
															StringBuffer totalCountCol = new StringBuffer(); // 모든자리 카운트
															// 검색된 횟수를 저장하는 변수
															int count=0; // 자릿수가 계산된 Row의 개수
															int count2=0; // 검색된 Row 개수
															
															
															System.out.println("============= 검색 값들 ============");
															//System.out.println("codeFilter 논리 -> " + Boolean.toString(codeFilter == ""));
															//System.out.println("nameFilter 논리 -> " + Boolean.toString(nameFilter.equals("전체")));
															//System.out.println("sourcePickerFilter 논리 -> " + Boolean.toString(sourcePickerFilter == 0));
															//System.out.println("destinationPickerFilter 논리 -> " + Boolean.toString(destinationPickerFilter == 0));
															//System.out.println("yearMonthPickerFilter 논리 -> " + Boolean.toString(yearMonthPickerFilter == 20170100));
															

															//yearmonth도 source와 destination으로 바꾸기
															
															
															// 검색한 코드
															while(rs.next()){
																// 편의상을 위한 변수들
																int retnDate = toInt(rs.getString("bad_stock_return_date"));
																int retnYearDate = toInt(rs.getString("bad_stock_return_date").substring(0, 4));
																int retnMonthDate = toInt(rs.getString("bad_stock_return_date").substring(4, 7));
																
																//System.out.println("retnYearDate -> " + retnYearDate);
																//System.out.println("yearPickerFilter -> " + yearPickerFilter);
																//System.out.println("retnMonthDate -> " + retnMonthDate);
																//System.out.println("monthPickerFilter -> " + monthPickerFilter);
																//System.out.println("========= 논리값 =========");
																//System.out.println("코드x -> " + Boolean.toString(codeFilter == ""));
																//System.out.println("이름x -> " + Boolean.toString(nameFilter.equals("전체")));
																//System.out.println("기간1 -> " + Boolean.toString(sourcePickerFilter <= retnDate));
																//System.out.println("기간2 -> " + Boolean.toString(destinationPickerFilter >= retnDate));
																//System.out.println("기간3 -> " + Boolean.toString(yearPickerFilter == 0));
																//System.out.println("기간4 -> " + Boolean.toString(monthPickerFilter == 0));
																//System.out.println("================");
																
																
																
																// 검색 조건 필터
																int searchFilter = 0;
																// 1: 코드x 이름x 기간1x 기간2x 기간3x 기간4x
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 1;
																}
																// 2: 코드o 이름x 기간1x 기간2x 기간3x 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 2;
																}
																// 3: 코드x 이름o 기간1x 기간2x 기간3x 기간4x
																if(codeFilter == "" &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 3;
																}
																// 4: 코드x 이름x 기간1o 기간2x 기간3x 기간4x
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 4;
																}
																// 5: 코드x 이름x 기간1x 기간2o 기간3x 기간4x
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 5;
																}
																// 6: 코드x 이름x 기간1x 기간2x 기간3o 기간4x
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == retnYearDate &&
																		monthPickerFilter == 0){
																	searchFilter = 6;
																}
																// 7: 코드x 이름x 기간1x 기간2x 기간3x 기간4o
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 7;
																}
																// 8: 코드o 이름o 기간1x 기간2x 기간3x 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 8;
																} 
																// 9: 코드o 이름x 기간1o 기간2x 기간3x 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 9;
																}
																// 10: 코드o 이름x 기간1x 기간2o 기간3x 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 10;
																}
																// 11: 코드o 이름x 기간1x 기간2x 기간3o 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == retnYearDate &&
																		monthPickerFilter == 0){
																	searchFilter = 11;
																}
																// 12: 코드o 이름x 기간1x 기간2x 기간3x 기간4o
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 12;
																}
																// 13: 코드x 이름o 기간1o 기간2x 기간3x 기간4x
																if(codeFilter == "" &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 13;
																}
																// 14: 코드x 이름o 기간1x 기간2o 기간3x 기간4x
																if(codeFilter == "" &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter >= retnDate&&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == 0){
																	searchFilter = 14;
																}
																// 15: 코드x 이름o 기간1x 기간2x 기간3o 기간4x
																if(codeFilter == "" &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == retnYearDate && 
																		monthPickerFilter == 0){
																	searchFilter = 15;
																}
																// 16: 코드x 이름o 기간1x 기간2x 기간3x 기간4o
																if(codeFilter == "" &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 16;
																}
																// 17: 코드x 이름 x 기간1o 기간2o 기간3x 기간4x
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == 0){
																	searchFilter = 17;
																}
																// 18: 코드x 이름x 기간1o 기간2x 기간3o 기간4x
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == retnYearDate &&
																		monthPickerFilter == 0){
																	searchFilter = 18;
																}
																// 19: 코드x 이름x 기간1o 기간2x 기간3x 기간4o
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 19;
																}
																// 20: 코드x 이름x 기간1x 기간2o 기간3o 기간4x
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == retnYearDate &&
																		monthPickerFilter == 0){
																	searchFilter = 20;
																}
																// 21: 코드x 이름x 기간1x 기간2o 기간3x 기간4o
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == 0 &&
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 21;
																}
																// 22: 코드x 이름x 기간1x 기간2x 기간3o 기간4o
																if(codeFilter == "" &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == retnYearDate &&
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 22;
																}
																////
																// 23: 코드o 이름o 기간1o 기간2x 기간3x 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == 0){
																	searchFilter = 23;
																}
																// 24: 코드o 이름o 기간1x 기간2o 기간3x 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == 0){
																	searchFilter = 24;
																}
																// 25: 코드o 이름o 기간1x 기간2x 기간3o 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == retnYearDate && 
																		monthPickerFilter == 0){
																	searchFilter = 25;
																}
																
																// 26: 코드o 이름o 기간1x 기간2x 기간3x 기간4o
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 26;
																}
																// 27: 코드o 이름x 기간1o 기간2o 기간3x 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == 0){
																	searchFilter = 27;
																}
																// 28: 코드o 이름x 기간1o 기간2x 기간3o 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == 0){
																	searchFilter = 28;
																}
																// 29: 코드o 이름x 기간1o 기간2x 기간3x 기간4o
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 29;
																}
																// 30: 코드o 이름x 기간1x 기간2o 기간3o 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == retnYearDate && 
																		monthPickerFilter == 0){
																	searchFilter = 30;
																}
																// 31: 코드o 이름x 기간1x 기간2o 기간3x 기간4o
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 31;
																}
																// 32: 코드o 이름x 기간1x 기간2x 기간3o 기간4o
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		nameFilter.equals("전체") &&
																		sourcePickerFilter == 0 &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == retnYearDate && 
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 32;
																}
																// 33: 코드o 이름o 기간1o 기간2o 기간3x 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter >= retnDate &&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == 0){
																	searchFilter = 33;
																}
																// 34: 코드o 이름o 기간1o 기간2x 기간3o 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == retnYearDate && 
																		monthPickerFilter == 0){
																	searchFilter = 34;
																}
																// 35: 코드o 이름o 기간1o 기간2x 기간3x 기간4o
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter == 0 &&
																		yearPickerFilter == 0 && 
																		monthPickerFilter == retnMonthDate){
																	searchFilter = 35;
																}
																// 36: 코드o 이름o 기간1o 기간2o 기간3o 기간4x
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter >= 0 &&
																		yearPickerFilter == retnYearDate && 
																		monthPickerFilter == 0){
																	searchFilter = 36;
																}
																// 37: 코드o 이름o 기간1o 기간2o 기간3o 기간4o
																if(rs.getString("item_code").indexOf(codeFilter) != -1 &&
																		rs.getString("item_name").indexOf(nameFilter) != -1 &&
																		sourcePickerFilter <= retnDate &&
																		destinationPickerFilter >= 0 &&
																		yearPickerFilter == retnYearDate && 
																		monthPickerFilter == retnYearDate){
																	searchFilter = 37;
																}
																
																// 검색 필터 출력(확인용)
																System.out.println("현재의 searchFilter -> " + searchFilter);
																
																// DB Row Data 주입
																switch(searchFilter){
																case 0:
																	break;
																default:
																	// 현재 행 위치
																	filterRow = rs.getRow();
																	// 갯수 및 Row 수치 카운트
																	if(filterRow/10 == 0){ // 일의 자리
																		unitsCountCol.append(filterRow);
																	} else if(filterRow/10 != 0){ // 십의 자리
																		tensCountCol.append(filterRow);
																	}
																	totalCountCol.append(filterRow); // 모든 자리
																	break;
																}
															}
															// 검색된 횟수를 저장하는 변수
															count = unitsCountCol.length() + tensCountCol.length();
															count2 = unitsCountCol.length() + tensCountCol.length()/2;
															System.out.println("unitsCountCol : " + unitsCountCol);
															System.out.println("tensCountCol : " + tensCountCol);
															System.out.println("totalCountCol : " + totalCountCol);
															System.out.println("검색된 횟수는 : " + count2 + "번");
															
															// Part 1
															try{
																// 검색된 Row의 데이터들
																int colData[] = new int[count];
																String buf="";
																
																System.out.println("================== part 1 ==================");
																System.out.print("colData는 : ");
																
																for(int i=0; i<count; i++){ 
																	
																	
																	// 일의자리와 십의자리 나누기
																	// part 2-1
																	try{
																		// case 1, 일의 자리는 있고 십의자리는 없음
																		if(unitsCountCol.length()>=1 && tensCountCol.length()<=1){
																			buf = Character.toString(totalCountCol.charAt(i));
																			colData[i] = Integer.parseInt(buf);
																			
																			System.out.print(colData[i] + " ");
																		} // End of case 1
																		
																		// case 2, 일의 자리도 있고 십의 자리도 있음
																		if(unitsCountCol.length()>=1 && tensCountCol.length()>=1){
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
																		} // End of case 2
																		
																		// case 3, 일의 자리는 없고 십의 자리만 있음
																		if(unitsCountCol.length()<1 && tensCountCol.length()>=1){ 
																			buf = Character.toString(tensCountCol.charAt(i)) + Character.toString(tensCountCol.charAt(i+1));
																			colData[i] = Integer.parseInt(buf);
																			
																			System.out.print(colData[i] + " ");
																			i++;
																		} // End of case 3
																		
																		
																	} catch (Exception e){
																		System.out.println("Part 2-1 -> " + e);
																	} // End of Part 2-1
																	
																
																} // End of for
																System.out.println(""); // 줄 바꿈
																
																//
																// 
																for(int i=0; i<count; i++){
																	// Part 2-3
																	try{
																		// 십의자리 배정시 비어있는 부분 패스
																		if(colData[i] == 0){
																			continue;
																		} 
																		rs.absolute(colData[i]);
																		
																		//System.out.println("현재 row는 : " + rs.getRow());
																		
																		// 값 가져오기
																		bad_no = rs.getString("bad_no"); // 넘버링
																		item_code = rs.getString("item_code"); // 품목코드
																		item_name = rs.getString("item_name"); // 품목명
																		order_date = rs.getString("order_date"); // 수주일
																		stock_storage_name = rs.getString("stock_storage_name"); // 창고명
																		item_unit_name = rs.getString("item_unit_name"); // 단위
																		bad_stock_amount = rs.getInt("bad_stock_amount"); // 재고수량
																		item_unit_price = rs.getInt("item_unit_price"); // 단가
																		bad_stock_price = bad_stock_amount * item_unit_price; // (불량)재고금액 -> 재고수량*단가
																		bad_stock_return_date = rs.getString("bad_stock_return_date"); // 반품일
																		bad_stock_result = rs.getString("bad_stock_result"); // 처리결과
																		bad_stock_memo = rs.getString("bad_stock_memo"); // 비고
																		
																		// 천단위 콤마 문자열
																		badStockAmountDF = df.format(bad_stock_amount); // 재고수량
																		itemUnitPriceDF = df.format(item_unit_price); // 단가
																		badStockPriceDF = df.format(bad_stock_price); // (불량)재고금액
																		%>
																			<tr>
																				<td class="li_inventory_err0"><input type="checkbox" id="checkbox" name="stock_manage_checkbox" value="" onclick="checkOnlyOne(this)"></td>
																				<td class="li_inventory_err1"><%=bad_no %></td> <!-- 넘버링 -->
																				<td class="li_inventory_err2"><%=item_code %></td> <!-- 품목코드 -->
																				<td class="li_inventory_err3"><%=item_name %></td> <!-- 품목명 -->
																				<td class="li_inventory_err4"><%=order_date %></td> <!-- 수주일 -->
																				<td class="li_inventory_err5"><%=stock_storage_name %></td> <!-- 창고명 -->
																				<td class="li_inventory_err6"><%=item_unit_name %></td> <!-- 단위 -->
																				<td class="li_inventory_err7"><%=badStockAmountDF %></td> <!-- 재고수량 -->
																				<td class="li_inventory_err8"><%=itemUnitPriceDF %>원</td> <!-- 단가 -->
																				<td class="li_inventory_err9"><%=badStockPriceDF %>원</td> <!-- 재고금액 -->
																				<td class="li_inventory_err10"><%=bad_stock_return_date %></td> <!-- 반품일 -->
																				<td class="li_inventory_err11"><%=bad_stock_result %></td> <!-- 처리결과 -->
																				<td class="li_inventory_err12"><%=bad_stock_memo %></td> <!-- 비고 -->
																			</tr>
																		<%
																	} // End of Part 1-2 try
																	catch(Exception e){
																		System.out.println("Part 1-2 Excetion -> " + e);
																	} // End of Part 1-2 catch
																} // End of for
																
																
															} // End of Part 1 try
															catch (Exception e){
																System.out.println("Part 1 Excetion -> " + e);
															}// End of Part 1 catch
														} // End of while(첫 로딩이 아니라면 )
													} // End of Part 0
													catch(Exception e){
														System.out.println("part 0 Exception -> " + e);
													}
													
													int a;
													Integer b=0;
													b.getClass().getName();
													
													//String sourcePickerFilter = (String)request.getParameter("source_datepicker_search").replaceAll("[^0-9]", "");
													
													try{
														//System.out.println("codeFilter -> " + codeFilter);
														//System.out.println("nameFilter -> " + nameFilter);
														//System.out.println("source picker Filter -> " + sourcePickerFilter);
														//System.out.println("destination picker Filter -> " + destinationPickerFilter);
														//System.out.println("yearMonth picker Filter -> " + yearMonthPickerFilter);
														
													} 
													catch(Exception e){
														System.out.println("에러? -> " + e);
													}
													
													// 첫 로딩시
													if(codeFilter == null){
														try{
															int i=0;
															while(BADSTOCKrs.next()){
																i++;
																
																// 값 가져오기
																bad_no = BADSTOCKrs.getString("bad_no"); // 넘버링
																item_code = BADSTOCKrs.getString("item_code"); // 품목코드
																item_name = BADSTOCKrs.getString("item_name"); // 품목명
																order_date = BADSTOCKrs.getString("order_date"); // 수주일
																stock_storage_name = BADSTOCKrs.getString("stock_storage_name"); // 창고명
																item_unit_name = BADSTOCKrs.getString("item_unit_name"); // 단위
																bad_stock_amount = BADSTOCKrs.getInt("bad_stock_amount"); // 재고수량
																item_unit_price = BADSTOCKrs.getInt("item_unit_price"); // 단가
																bad_stock_price = bad_stock_amount * item_unit_price; // (불량)재고금액 -> 재고수량*단가
																bad_stock_return_date = BADSTOCKrs.getString("bad_stock_return_date"); // 반품일
																bad_stock_result = BADSTOCKrs.getString("bad_stock_result"); // 처리결과
																bad_stock_memo = BADSTOCKrs.getString("bad_stock_memo"); // 비고
																
																// 천단위 콤마 문자열
																badStockAmountDF = df.format(bad_stock_amount); // 재고수량
																itemUnitPriceDF = df.format(item_unit_price); // 단가
																badStockPriceDF = df.format(bad_stock_price); // (불량)재고금액
														%>
														<tr>
															<td class="li_inventory_err0"><input type="checkbox" id="checkbox" name="stock_manage_checkbox" value="" onclick="checkOnlyOne(this)"></td>
															<td class="li_inventory_err1"><%=bad_no %></td> <!-- 넘버링 -->
															<td class="li_inventory_err2"><%=item_code %></td> <!-- 품목코드 -->
															<td class="li_inventory_err3"><%=item_name %></td> <!-- 품목명 -->
															<td class="li_inventory_err4"><%=order_date %></td> <!-- 수주일 -->
															<td class="li_inventory_err5"><%=stock_storage_name %></td> <!-- 창고명 -->
															<td class="li_inventory_err6"><%=item_unit_name %></td> <!-- 단위 -->
															<td class="li_inventory_err7"><%=badStockAmountDF %></td> <!-- 재고수량 -->
															<td class="li_inventory_err8"><%=itemUnitPriceDF %>원</td> <!-- 단가 -->
															<td class="li_inventory_err9"><%=badStockPriceDF %>원</td> <!-- 재고금액 -->
															<td class="li_inventory_err10"><%=bad_stock_return_date %></td> <!-- 반품일 -->
															<td class="li_inventory_err11"><%=bad_stock_result %></td> <!-- 처리결과 -->
															<td class="li_inventory_err12"><%=bad_stock_memo %></td> <!-- 비고 -->
											<%
															} // End of while
														} 
														catch(Exception e){
															System.out.println("첫 로딩 오류 -> " + e);
														}
												}
											}catch(SQLException ex){
												System.out.println("데이터 오류" + ex);
											}finally{ // 연결 해제
												// ResultSet 해제
												if(BADSTOCKrs!=null)try{
													BADSTOCKrs.close();
												}catch(SQLException ex){}
												// Statement 해제
												if(BADSTOCKstmt!=null)try{
													BADSTOCKstmt.close();
												} catch(SQLException ex){}
												if(conn!=null)try{
													conn.close();
												}catch(SQLException ex){}
											}
											%>
											
											<%!
												// 문자열을 숫자로 바꿔주는 메소드
												int toInt(String buf){
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
					
					<!-- 등록 버튼 -->
				 <div class="row">
					<div class="col-md-3" style="margin-left:47%">
				  		<a id="bad_stock_enroll_data-submit-button" href="#" class="d-none d-sm-inline-block btn btn-primary shadow-sm" data-toggle="modal" data-target="#badStockEnrollModal" onclick="checkTest()">등록</a>		
		            </div>
				 </div>

				<!-- 등록 모달 -->
				<div class="modal fade" id="badStockEnrollModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 style="color:black" class="modal-title" id="exampleModalLabel">불량 재고 - 처리결과 등록</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body" style="width:1000px">
				      	<!-- 품목 등록 입력 폼 -->
				        <form action="bad_stock_RegistAction.jsp" method="post">
				        	<!-- 첫줄 -->
							<div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">불량재고<br>코드</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="bad_no_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7" readonly>
								       	<input type="hidden" name="bad_no_hidden" value="">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">품목코드</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_code_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7"" readonly>
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">품목명</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7"" readonly>
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
                
			                <!-- 두번째 줄 -->
			                <div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">주문일</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="order_date_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7"" readonly>
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">창고명</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="stock_storage_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7" readonly>
								       	<input type="hidden" name="stock_amount_hidden" value="">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">단위</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_unit_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7"" readonly>
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
			                
			                <!-- 세 번째 줄 -->
			                <div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">수량</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="bad_stock_amount_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7"" readonly>
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">단가</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_unit_price_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7" readonly>
								       	<input type="hidden" name="item_unit_price_hidden" value="">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">재고금액</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="bad_stock_price_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7" readonly>
								       	<input type="hidden" name="stock_price_hidden" value="">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
			                
			                <!-- 네 번째 줄 -->
			                <div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">반품일</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="bad_stock_return_date_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7" readonly>
								       	<input type="hidden" name="bad_stock_return_date_hidden" value="">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">처리결과</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="bad_stock_result_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								       	<input type="hidden" name="bad_stock_result_hidden" value="">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">비고</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="bad_stock_memo_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7" readonly>
								       	<input type="hidden" name="bad_stock_memo_hidden" value="">
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
				<!-- /.container-fluid -->

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
	    $( "#stock_datepicker_1, #stock_datepicker_2" ).datepicker();
	  } );
	 </script>
	 
	 
	 
	 <script>
		// CheckBox를 한 개만 클릭할 수 있게 해주는 함수
		function checkOnlyOne(element){
			try{
				// 체크박스 정보 가져옴
				const checkboxes = document.getElementsByName("stock_manage_checkbox");
				
				// 모두 체크 해제
				checkboxes.forEach((cb) => { // 나머지는 체크 해제
					cb.checked = false;
				})
				
				// 현재 선택된 element만을 선택
				element.checked = true;
			}catch (e) {
				console.log('checkOnlyOne Exception -> ' + e);
			}
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
		$("#bad_stock_enroll_data-submit-button").click(function(){ 
			
			var rowData = new Array();
			// 가져올 값들
			var colNo = "";
			var colItemCode = "";
			var colItemName = "";
			var colOrderDate = "";
			var colStockStorageName = "";
			var colItemUnitName = "";
			var colStockAmount = "";
			var colItemUnitPrice = "";
			var colStockPrice = "";
			var colBadStockReturnData = "";
			var colBadStockResult="";
			var colBadStockMemo = "";
			
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
					colNo = td.eq(1).text(); // 넘버
					colItemCode = td.eq(2).text(); // 품목코드
					colItemName = td.eq(3).text(); // 품목명
					colOrderDate = td.eq(4).text(); // 주문일
					colStockStorageName = td.eq(5).text(); // 창고명
					colItemUnitName = td.eq(6).text(); // 단위
					colStockAmount = td.eq(7).text(); // 수량
					colItemUnitPrice = td.eq(8).text(); // 단가
					colStockPrice = td.eq(9).text(); // 재고금액
					colBadStockReturnData = td.eq(10).text(); // 반품일
					colBadStockResult = td.eq(11).text(); // 처리 결과
					colBadStockMemo = td.eq(12).text(); // 비고
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
				console.log('colOrderDate : ' + colOrderDate);
				console.log('colStockStorageName : ' + colStockStorageName);
				console.log('colItemUnitName : ' + colItemUnitName);
				console.log('colStockAmount : ' + colStockAmount);
				console.log('colItemUnitPrice : ' + colItemUnitPrice);
				console.log('colStockPrice : ' + colStockPrice);
				console.log('colBadStockReturnData : ' + colBadStockReturnData);
				console.log('colBadStockResult : ' + colBadStockResult);
				console.log('colBadStockMemo : ' + colBadStockMemo);
				
			}catch (e) {
				console.log('Script Part 2 Exception -> ' + e);
			}
			
			
			//console.log(rowData[0]);
			
			
			// Script part 3
			try{
				//$("input[name=item_code_form]").attr('value', colItemCode);
				// modal input의 값 지정
				$("input[name=bad_no_form]").attr('value', colNo);
				$("input[name=bad_no_hidden]").attr('value', colNo);
				$("input[name=item_code_form]").attr('value', colItemCode);
				$("input[name=item_name_form]").attr('value', colItemName);
				$("input[name=order_date_form]").attr('value', colOrderDate);
				$("input[name=stock_storage_name_form]").attr('value', colStockStorageName);
				$("input[name=item_unit_name_form]").attr('value', colItemUnitName);
				$("input[name=bad_stock_amount_form]").attr('value', colStockAmount);
				$("input[name=item_unit_price_form]").attr('value', colItemUnitPrice);
				$("input[name=bad_stock_price_form]").attr('value', colStockPrice);
				$("input[name=bad_stock_return_date_form]").attr('value', colBadStockReturnData);
				$("input[name=bad_stock_result_form]").attr('value', colBadStockResult);
				$("input[name=bad_stock_memo_form]").attr('value', colBadStockMemo);
				
			} catch (e) {
				console.log('Script Part 3 Exception -> ' + e);
			}
			
		});
	</script>
	 
	 <script>
  		try{
		var optionSelect;
  		// 검색 버튼 클릭시 select에 있는 값을 넣음
    	$("#bad_stock_data-submit-button").click(function() {
    		// select 된 값
    		optionSelect = $("select[name=item_name_select]").val();
    		console.log("select 값 : " + optionSelect);
    		
    		$("input[name=name_search]").attr('value', optionSelect);
		})
  		}catch (e) {
  			console.log("select 코드 오류 발생 -> " + e);
		}
   		
   	</script>

</body>

</html>
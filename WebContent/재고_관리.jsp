<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>

<!-- 데이터베이스 커넥터 -->
<%
	Connection conn=null;

	// 재고 테이블 query, st, rs 변수 생성
	String stockQuery="select * from stock";
	Statement stockSTMT = null;
	ResultSet stockRS = null;
	// 재고 이름 리스트 query, st, rs 변수 생성
	String itemListQuery = "select item_name from stock";
	Statement itemListSTMT = null;
	ResultSet itemListRS = null;
	// 재고 코드 리스트 query, st, rs 변수 생성
	String itemCodeListQuery = "select item_code from stock";
	Statement itemCodeListSTMT = null;
	ResultSet itemCodeListRS = null;
	
	
	// 드라이버 및 데이터베이스 설정
	String driver="com.mysql.cj.jdbc.Driver";
	String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
	
	
	Class.forName(driver);
	conn=DriverManager.getConnection(url,"java","java");

	
	request.setCharacterEncoding("UTF-8");
%>



<head>
	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	
	<title>GLASS 長 - 재고 관리</title>
	
	<!-- Custom fonts for this template-->
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
		type="text/css">
	<link
		href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
		rel="stylesheet">
	
	<!-- Custom styles for this template-->
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
	<link href="css/재고_관리.css" rel="stylesheet">
	
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
							<a class="navbar-brand mb-0 h1" href="재고_관리.jsp">재고 관리</a>
						</div>
					</nav>

					<!-- Page Heading -->
					
					
					<!-- 검색구역 -->
                <form action="재고_관리.jsp" method="post">
                <div class="row mt-3 ml-1">
				    <div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2" style="width:100px">품목코드</span>
					       <div class="input-group-btn m-1">
							 <input type="text" name="code_search" value="" class="form-control-sm ml-1" aria-describedby="basic-addon2">
							 
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-3 -->
				    <div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2" style="width:100px">품목명</span>
					       <div class="input-group-btn m-1">
									<select name="item_name_select" class="form-control ml-2" style="width: 150px">
										<option id="stock_search-name-select" value="전체">전체</option>
										<%
											itemListSTMT = (Statement)conn.createStatement();
											itemListRS = itemListSTMT.executeQuery(itemListQuery);
											
											while(itemListRS.next()){
												%>
												<option id="stock_search-name-select" value="<%=itemListRS.getString("item_name")%>"><%=itemListRS.getString("item_name")%></option>
										<%	}
										%>
									</select>
									<!-- option 값을 전달하기 위한 input 개체 -->
									<input type="hidden" name="name_search" value="" />
					      </div>
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-3 -->
					<div class="col-lg-4">
						<div class="input-group">
							<span class="mt-2" style="width:100px">창고명</span>
					       	<div class="input-group-btn m-1">
					      	<select class="form-control ml-2" style="width:150px">
					      	<option value="본사 창고">본사 창고</option>
					      	</select>
					      	</div>
					      	<!-- 확인버튼 -->
					      <div class="row" style="margin-left:60px; margin-top:4px; height:20px">
	                  		<!-- <button type="submit" id="stock_search_data-submit-button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">확인</button> -->
	                  		<button id="stock_search_data-submit-button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">확인</button>
	                  		
	            		  </div>
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
                </div>
                </form>
				<!-- ================================================== 검색 구역 끝  ================================================== -->
                
                <form>
					<!-- 재고 관리 테이블 -->
					<div class="limiter">
						<div class="container-table100">
							<div class="wrap-table100">
								<div class="table100" style="width:100%; height:450px; overflow:auto">
									<table>
										<thead>
											<tr class="table100-head">
												<th class="inventory_manage0"> </th>
												<th class="inventory_manage1">No</th>
												<th class="inventory_manage2">품목코드</th>
												<th class="inventory_manage3">품목명</th>
												<th class="inventory_manage4">창고명</th>
												<th class="inventory_manage5">단위</th>
												<th class="inventory_manage6">수량</th>
												<th class="inventory_manage7">단가</th>
												<th class="inventory_manage8">재고금액</th>
												<th class="inventory_manage9">비고</th>
											</tr>
										</thead>
										<tbody>
										
												<%
													try{
														System.out.println("==================== 재고 관리 ========================");
														// statement 생성
														//stockSTMT = (Statement)conn.createStatement();
														stockSTMT = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
														// 쿼리실행하고 결과를 담기
														stockRS = stockSTMT.executeQuery(stockQuery);
														
														//test를 위한 stmt, rs 생성
														Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
														ResultSet rs = stmt.executeQuery(stockQuery);
														
														String item_code = "";
														String item_name = "";
														String stock_storage_name = "";
														String item_unit_name = "";
														int stock_amount = 0;
														int item_unit_price = 0;
														String stock_memo = "";
														int stock_price;
														
														// test 코드
														try{
															// 천단위 콤마를 위한 객체 생성
															DecimalFormat df = new DecimalFormat("###,###");
															// 천단위 콤마 문자열
															String stockAmountDF; //수량
															String itemUnitPriceDF; // 단가
															String stock_priceDF; // 재고금액
															
															// 코드 검색을 위한 필터
															String codeFilter;
															String nameFilter;
															codeFilter = (String)request.getParameter("code_search");
															nameFilter = (String)request.getParameter("name_search");
															
															String sql_test="";
															
															
															if(codeFilter != null){ // null이 아니면
																codeFilter = codeFilter.toUpperCase();
																//System.out.println("현재 품목코드 : " + codeFilter);
															
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
																// 검색한 코드 비교
																while(rs.next()){
																	// 검색 조건 필터
																	int searchFilter=0;
																	// 코드 O, 이름 X
																	if(rs.getString("item_code").indexOf(codeFilter) != -1 && nameFilter.equals("전체"))
																		searchFilter = 1;
																	// 코드 X, 이름 O
																	if(rs.getString("item_name").equals(nameFilter) && codeFilter == "")
																		searchFilter = 2;
																	// 코드 O, 이름 O
																	if(rs.getString("item_name").equals(nameFilter) && rs.getString("item_code").indexOf(codeFilter) != -1)
																		searchFilter = 3;
																	
																	// 검색 필터 출력(확인용)
																	//System.out.println("현재의 searchFilter -> " + searchFilter);
																	
																	// DB Row Data 주입
																	switch(searchFilter){
																	case 1:
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
																	case 2:
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
																	case 3:
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
																//System.out.println("unitsCountCol의 길이는 : " + unitsCountCol.length());
																//System.out.println("tensCountCol 길이는 : " + tensCountCol.length());
																//System.out.println("totalCountCol 길이는 : " + totalCountCol.length());
																
																// Part 2 
																try{ 
																	// 검색된 Row의 데이터들
																	int colData[] = new int[count];
																	String buf="";
																	
																	System.out.println("================== part 2 ==================");
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
																	for(int i=0; i<count; i++){
																		// Part 2-3
																		try{
																			// 십의자리 배정시 비어있는 부분 패스
																			if(colData[i] == 0){
																				continue;
																			} 
																			rs.absolute(colData[i]);
																			
																			//System.out.println("현재 row는 : " + rs.getRow());
																			
																			// 입력한 item_code에 맞는 행의 값을 가져옴
																			item_code = rs.getString("item_code");
																			item_name = rs.getString("item_name");
																			stock_storage_name = rs.getString("stock_storage_name");
																			item_unit_name = rs.getString("item_unit_name");
																			stock_amount = rs.getInt("stock_amount");
																			item_unit_price = rs.getInt("item_unit_price");
																			stock_memo = rs.getString("stock_memo");
																			stock_price = stock_amount * item_unit_price;
																			
																			// 천단위 콤마 문자열
																			stockAmountDF = df.format(stock_amount); //수량
																			itemUnitPriceDF = df.format(item_unit_price); // 단가
																			stock_priceDF = df.format(stock_price); // 재고금액
																	
																
																	%>
																
																	<tr>
																		<td class="li_inventory_manage0"><input type="checkbox" id="checkbox" name="stock_manage_checkbox" value="" onclick="checkOnlyOne(this)"></td>
																		<td class="li_inventory_manage0"><%=i+1 %></td>
																		<td class="li_inventory_manage2"><%=item_code %></td> <!-- 품목코드 -->
																		<td class="li_inventory_manage3"><%=item_name %></td> <!-- 품목명 -->
																		<td class="li_inventory_manage4"><%=stock_storage_name %></td> <!-- 창고명 -->
																		<td class="li_inventory_manage5"><%=item_unit_name %></td> <!-- 단위 -->
																		<td class="li_inventory_manage6"><%=stockAmountDF %></td> <!-- 수량 -->
																		<td class="li_inventory_manage7"><% out.print(itemUnitPriceDF + "원"); %></td> <!-- 단가 -->
																		<td class="li_inventory_manage8"><% out.print(stock_priceDF + "원"); %></td> <!-- 재고금액 -->
																		<td class="li_inventory_manage9"><%=stock_memo %></td> <!-- 비고 -->
																	</tr>
																	
																	<%
																		} // End of Part 2-3 try
																		catch(Exception e){
																			System.out.println("Part 2-3 -> " + e);
																		} // End of Part 2-3 catch
																	} // End of for
																} // End of Part 2 try
																catch(Exception e){
																	System.out.println("Part 2 -> " + e);
																}// End of Part 2 catch
																
															}else {// null이면
																stockQuery = "select * from stock";
																System.out.println("품목코드는 null이야");
																
																try{
																	int i=0;
																	while(stockRS.next()){
																		i++;
																		
																		// 값 가져오기
																		item_code = stockRS.getString("item_code"); // 품목코드
																		item_name = stockRS.getString("item_name"); // 품목명
																		stock_storage_name = stockRS.getString("stock_storage_name"); // 창고명
																		item_unit_name = stockRS.getString("item_unit_name"); // 단위
																		stock_amount = stockRS.getInt("stock_amount"); // 재고수량
																		item_unit_price = stockRS.getInt("item_unit_price"); // 단가
																		stock_memo = stockRS.getString("stock_memo"); // 메모
																		stock_price = stock_amount * item_unit_price; // 재고금액 (수량*단가)
																		
																		// 천단위 콤마 문자열
																		stockAmountDF = df.format(stock_amount); //수량
																		itemUnitPriceDF = df.format(item_unit_price); // 단가
																		stock_priceDF = df.format(stock_price); // 재고금액
															%>
															<!-- <tr onclick="test('<%=item_code%>', '<%=item_name %>', '<%=stock_storage_name %>', '<%=item_unit_name %>', '<%=stockAmountDF %>', <%=item_unit_price %>, '<%=stock_memo %>')"> -->
															<tr id="list<%=i %>">
																<td class="li_inventory_manage0"><input type="checkbox" id="checkbox" name="stock_manage_checkbox" value="" onclick="checkOnlyOne(this)"></td>
																<td class="li_inventory_manage1"><%=i %><input type="hidden" name="no_hidden" value=""></td> <!-- 넘버링 -->
																<td class="li_inventory_manage2"><%=item_code %><input type="hidden" name="item_code_hidden" value=""></td> <!-- 품목코드 -->
																<td class="li_inventory_manage3"><%=item_name %><input type="hidden" name="item_name_hidden" value=""></td> <!-- 품목명 -->
																<td class="li_inventory_manage4"><%=stock_storage_name %><input type="hidden" name="stock_storage_name_hidden" value=""></td> <!-- 창고명 -->
																<td class="li_inventory_manage5"><%=item_unit_name %><input type="hidden" name="item_unit_name_hidden" value=""></td> <!-- 단위 -->
																<td class="li_inventory_manage6"><%=stockAmountDF %><input type="hidden" name="stock_amount_hidden" value=""></td> <!-- 수량 -->
																<td class="li_inventory_manage7"><% out.print(itemUnitPriceDF + "원"); %><input type="hidden" name="item_unit_price_hidden" value=""></td> <!-- 단가 -->
																<td class="li_inventory_manage8"><% out.print(stock_priceDF + "원"); %><input type="hidden" name="stock_price_hidden" value=""></td> <!-- 재고금액 -->
																<td class="li_inventory_manage9"><%=stock_memo %><input type="hidden" name="stock_memo_hidden" value=""></td> <!-- 비고 -->
																
																
																
															<%
																	} // while End
																} // try End
																catch(Exception e){
																	System.out.println("while쪽 오류났어 -> " + e);
																}
															} // else End 
														} // testCode try End
														catch(Exception e){
															System.out.println("testCode -> " + e);
														}
													} // 테이블 try End
													finally{
														// ResultSet 해제
														if(stockRS!=null)try{
															stockRS.close();
														}catch(SQLException ex){}
														// Statement 해제
														if(stockSTMT!=null)try{
															stockSTMT.close();
														} catch(SQLException ex){}
														if(conn!=null)try{
															conn.close();
														}catch(SQLException ex){}
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
					<div class="col-md-3" style="margin-left:50%">
				  		<a id="stock_enroll_data-submit-button" href="jsp:" class="d-none d-sm-inline-block btn btn-primary shadow-sm" data-toggle="modal" data-target="#stockEnrollModal" onclick="checkTest()">등록</a>
				  		<!-- <a id="stock_enroll_data-submit-button" href="#" class="d-none d-sm-inline-block btn btn-primary shadow-sm" data-toggle="modal" data-target="#stockEnrollModal">등록</a>  -->
				  		<!-- <a id="stock_edit-button" href="#" class="d-none d-sm-inline-block btn btn-primary shadow-sm" data-toggle="modal" data-target="#stockEditModal">수정</a>  -->
		            </div>
				 </div>
			 </form>
				 
				<!-- 등록 모달 -->
				<div class="modal fade" id="stockEnrollModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 style="color:black" class="modal-title" id="exampleModalLabel">재고 등록</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body" style="width:1000px">
				      	<!-- 품목 등록 입력 폼 -->
				        <form action="stock_RegistAction.jsp" method="post">
				        	<!-- 첫줄 -->
							<div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">품목코드</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" id="item_code_form" name="item_code_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7" readonly>
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
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">창고명</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="stock_storage_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7"" readonly>
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
								       	<input type="text" name="item_unit_name_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7"" readonly>
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">재고수량</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="stock_amount_form" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								       	<input type="hidden" name="stock_amount_hidden" value="">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">단가</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="item_unit_price_form" class="form-control-sm" style="width:170px; border: 1px solid gray; background:#E7E7E7"" readonly>
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
			                
			                <!-- 세 번째 줄 -->
			                <div class="row m-3">
							    <div class="col-lg-12">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true">메모</span>
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="stock_memo_form" class="form-control-sm" style="width:250px; border: 1px solid gray; background:#E7E7E7" readonly>
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
	<!-- script src="vendor/chart.js/Chart.min.js"></script-->

	<!-- Page level custom scripts -->
	<!-- script src="js/demo/chart-area-demo.js"></script>
	<script src="js/demo/chart-pie-demo.js"></script-->
	
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
		$("#stock_enroll_data-submit-button").click(function(){ 
			
			var rowData = new Array();
			var colNo = "";
			var colItemCode = "";
			var colItemName = "";
			var colStockStorageName = "";
			var colItemUnitName = "";
			var colStockAmount = "";
			var colItemUnitPrice = "";
			var colStockMemo = "";
			
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
					colStockStorageName = td.eq(4).text();
					colItemUnitName = td.eq(5).text();
					colStockAmount = td.eq(6).text();
					colItemUnitPrice = td.eq(7).text();
					colStockMemo = td.eq(9).text(); // 8번은 재고 금액
				} catch (e) {
					console.log('Script Part 1 Excetion -> ' + e);
				}
			}); // End of checkbox.each 
			
			
			// Script part 2
			try{
				//alert(" * 체크된 Row의 no = "+colNo);
				//alert('colItemConde는 : ' + colItemCode);
				//alert('row = ' + rowData[0]);
				
				console.log(colNo);
				console.log(colItemCode);
				console.log(colItemName);
				console.log(colStockStorageName);
				console.log(colItemUnitName);
				console.log(colStockAmount);
				console.log(colItemUnitPrice);
				console.log(colStockMemo);
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
				$("input[name=stock_storage_name_form]").attr('value', colStockStorageName);
				$("input[name=item_unit_name_form]").attr('value', colItemUnitName);
				$("input[name=stock_amount_form]").attr('value', colStockAmount);
				$("input[name=stock_amount_hidden]").attr('value', colStockAmount);
				$("input[name=item_unit_price_form]").attr('value', colItemUnitPrice);
				$("input[name=stock_memo_form]").attr('value', colStockMemo);
			} catch (e) {
				console.log('Script Part 3 Exception -> ' + e);
			}
			
		});
	</script>
	
	
	<script>
  		try{
  			var optionSelect;
  		// 검색 버튼 클릭시 select에 있는 값을 넣음
      		$("#stock_search_data-submit-button").click(function() {
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
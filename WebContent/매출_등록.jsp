<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db_transaction.*" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<!-- 데이터베이스 커넥터 -->
<%
	Connection conn=null;
	Statement ORDERSstmt = null;
	Statement CUstmt = null;
	Statement ITEMstmt = null;
	Statement SEstmt = null;
	
	ResultSet SErs = null;
	ResultSet ORDERSrs = null;
	ResultSet CUrs=null;
	ResultSet ITEMrs=null;
	
	Statement CUMstmt = null;
	ResultSet CUMrs=null;
	
	Statement ITEMNstmt = null;
	ResultSet ITEMNrs = null;
	

	/* String sellingExQuery="select * from selling";
	Statement SEEstmt = null;
	ResultSet SEErs = null; */
	
	
	
	// 드라이버 및 데이터베이스 설정
	String driver="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
	// 매출 테이블 쿼리
	
	String sellingQuery="select * from selling order by selling_tax_bill_code";
	String OrdersQuery="select * from orders";
	String customerNameQuery="select customer_name from customer";
	String ItemNameQuery="select item_name from item";
	String customerQuery="select * from customer";
	String itemQuery="select * from item";
	String temp=";";
	String temp2=";";
	
	
	Boolean connect=false;
%>
<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>GLASS 長 - 매출 등록</title>

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
							<a class="navbar-brand mb-0 h1" href="#">매출 등록</a>
						</div>
					</nav>
					
					<% 
		            request.setCharacterEncoding("UTF-8");
		            
		            String code_search = (String)request.getParameter("em_code_search");
		            String name_search = (String)request.getParameter("em_name_search");
		            
		            String code_search0 = (String)request.getParameter("item_code_search");
		            String code_search1 = (String)request.getParameter("order_code_search");
		            
		            String customer_name = (String)request.getParameter("customer_name_search");
		            String item_name = (String)request.getParameter("item_name_search");  
		            String chit_div = (String)request.getParameter("chit_div_search");
		            
		            String sourcePicker = (String)request.getParameter("source_datepicker_search");
		            String destinationPicker = (String)request.getParameter("destination_datepicker_search");
		            String yearPicker = (String)request.getParameter("year_picker_search");
		            String monthPicker = (String)request.getParameter("month_picker_search");
		            
		            String code_search_value = (code_search==null ? "" : code_search);
		            String name_search_value = (name_search==null ? "" : name_search);
		            
		            String code_search0_value = (code_search0==null ? "" : code_search0);
		            String code_search1_value = (code_search1==null ? "" : code_search1);
		            
		            String sourcePicker_value = (sourcePicker==null ? "" : sourcePicker);
		            String destinationPicker_value = (destinationPicker==null ? "" : destinationPicker);
		            String yearPicker_value = (yearPicker==null ? "" : yearPicker);
		            String monthPicker_value = (monthPicker==null ? "" : monthPicker);
		            
		            %>
					
					<!-- 검색창 시작 -->
					<form action="매출_등록.jsp" method="POST">
					 <div class="row mt-3 ml-1">
					 <div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2"style="width:100px">전표구분</span>
					      <div class="input-group-btn m-1">
							 <select name="chit_div_search" class="form-control ml-2" style="width:180px">
						      	<option value="전체">전체</option>
						      	<option value="처리">처리</option>
						      	<option value="미처리">미처리</option>
					      </select>
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
					    <div class="input-group">
							<span class="mt-2"style="width:120px">사원번호</span>
					       <div class="input-group-btn">
							 <input type="text" name="em_code_search" value="<%=code_search_value %>" class="form-control-sm" aria-describedby="basic-addon2">
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2"style="width:100px">사원명</span>
					      <div class="input-group-btn m-1">
							 <input type="text" name="em_name_search" value="<%=name_search_value%>" class="form-control-sm ml-2" aria-describedby="basic-addon2">
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
                </div>
                
                <!-- 두번째 줄 -->
                <div class="row ml-1" style="margin-top:5px">
				    <div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2" style="width:100px">품목코드</span>
					      <div class="input-group-btn m-1">
							 <input type="text" name="item_code_search" value="<%=code_search0_value %>" class="form-control-sm ml-2" aria-describedby="basic-addon2">
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
				    <div class="input-group">
						<span class="mt-2"style="width:120px">품목명</span>
				       <div class="input-group-btn">
						 		<select name="item_name_search" class="form-control" style="width: 180px">
									<option value="전체">전체</option>
									<% 
											String i_name;
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
													i_name = ITEMrs.getString(1);
			                                         String selected = "";
			                                         if(i_name.equals(item_name)) {
			                                        	 selected = "selected";
			                                         }
													
												%>
													<option value="<%=i_name %>" <%=selected %>><%=i_name %></option>
													
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
									</select>
					 	 </div><!-- /btn-group -->
				    	</div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
				    <div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2"style="width:100px">거래처명</span>

					      <div class="input-group-btn m-1">
							 <select name="customer_name_search" class="form-control ml-1" style="width:180px">
						      	<option value="전체">전체</option>
						      	<% 
						      				String c_name="";
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
													c_name = CUrs.getString(1);
			                                         String selected = "";
			                                         if(c_name.equals(customer_name)) {
			                                        	 selected = "selected";
			                                         }
													
												%>
													<option value="<%=c_name %>" <%=selected %>><%=c_name %></option>
													
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

					      </select>
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
                </div>
                
                
                <!-- 세번째 줄 -->
                <div class="ow mt-2 row ml-1">
				    <div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2"style="width:100px">수주번호</span>

					      <div class="input-group-btn m-1">
					        <input type="text" name="order_code_search" value="<%=code_search1_value %>" class="form-control-sm ml-2" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
				    <div class="col-lg-5">
					    <div class="input-group" style="width:635px">
					      <span class="mt-2 mr-2"style="width:100px">수주일</span>
					      <div class="form-group mt-1"> 
						      <div class="input-group date mt-1 ml-2"> 
								<input type="text" name="source_datepicker_search" value="<%=sourcePicker_value %>" class="datepicker" style="width:180px" id="sales_datepicker_1"> 
						      </div> 
					      </div>
					      <span class="mt-1 ml-3">~</span>
					      <div class="form-group m-1"> 
						      <div class="input-group date mt-1 ml-2"> 
								<input type="text" name="destination_datepicker_search"  value="<%=destinationPicker_value %>" class="datepicker" style="width:180px" id="sales_datepicker_2"> 
						      </div> 
					      </div>
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-5 -->
					<div class="col-lg-3">
					    <div class="input-group">
					      <div class="row form-group"> 
					      	<div class="input-group-btn">
						      	<select name="year_picker_search" class="form-control ml-2" style="width:90px">
						      	<option value="0">전체</option>
						      	<option value="2018" <%if(yearPicker_value.equals("2018")){%>selected<%}%>>2018</option>
						      	<option value="2019" <%if(yearPicker_value.equals("2019")){%>selected<%}%>>2019</option>
						      	<option value="2020" <%if(yearPicker_value.equals("2020")){%>selected<%}%>>2020</option>
						      	<option value="2021" <%if(yearPicker_value.equals("2021")){%>selected<%}%>>2021</option>
						      	</select>
					      	</div>
     							<span class="row ml-2 mt-2">년</span>
    						<div class="input-group-btn">
						      	<select name="month_picker_search" class="form-control ml-4" style="width:85px">
						      	 <option value="0">전체</option>
		                         <option value="01" <%if(monthPicker_value.equals("01")){%>selected<%}%>>01</option>
		                         <option value="02" <%if(monthPicker_value.equals("02")){%>selected<%}%>>02</option>
		                         <option value="03" <%if(monthPicker_value.equals("03")){%>selected<%}%>>03</option>
		                         <option value="04" <%if(monthPicker_value.equals("04")){%>selected<%}%>>04</option>
		                         <option value="05" <%if(monthPicker_value.equals("05")){%>selected<%}%>>05</option>
		                         <option value="06" <%if(monthPicker_value.equals("06")){%>selected<%}%>>06</option>
		                         <option value="07" <%if(monthPicker_value.equals("07")){%>selected<%}%>>07</option>
		                         <option value="08" <%if(monthPicker_value.equals("08")){%>selected<%}%>>08</option>
		                         <option value="09" <%if(monthPicker_value.equals("09")){%>selected<%}%>>09</option>
		                         <option value="10" <%if(monthPicker_value.equals("10")){%>selected<%}%>>10</option>
		                         <option value="11" <%if(monthPicker_value.equals("11")){%>selected<%}%>>11</option>
		                         <option value="12" <%if(monthPicker_value.equals("12")){%>selected<%}%>>12</option>
					      	</select>
					      	</div>
     							<span class="row ml-2 mt-2">월</span>
					      </div>
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-3 -->
                </div>
					
				
               
                <!-- 확인버튼 -->
	            <div class="form-row" style="margin-left:94%">
	                  <button type="submit" id="sale_total_data-submit-button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">확인</button>
	            </div>
	            </form>
	            </div>
	                     
               <!-- 매출 등록 테이블 -->
				<div class="limiter">
					<div class="container-table100">
						<div class="wrap-table100">
						<span style="font-size:10pt;display: inline-block; text-align:left;">'세금계산서'는 해당 항목을 클릭하시면 확인하실 수 있습니다.</span> 
							<form action="selling_RegistAction.jsp" method="post" name="sellingform">
							<div class="table100" style="width:100%; height:450px; overflow:auto">
								<table id=sales-table-1>
									<thead>
										<tr class="table100-head1">
											<th class="sales_regist0" rowspan="2"> </th>
											<th class="sales_regist1" rowspan="2">No</th>
											<th class="sales_regist2" colspan="2">담당자</th>
											<th class="sales_regist3" rowspan="2">거래처<br>코드</th>
											<th class="sales_regist4" rowspan="2">거래처명</th>
											<th class="sales_regist5" rowspan="2">품목<br>코드</th>
											<th class="sales_regist6" rowspan="2">품목명</th>
											<th class="sales_regist7" rowspan="2">단위</th>
											<th class="sales_regist8" rowspan="2">수량</th>
											<th class="sales_regist9" rowspan="2">단가</th>
											<th class="sales_regist10" rowspan="2">수주금액</th>
											<th class="sales_regist11" rowspan="2">수주번호</th>
											<th class="sales_regist12" rowspan="2">수주일</th>
											<th class="sales_regist13" rowspan="2">매출일</th>
											<th class="sales_regist14" rowspan="2">전표<br>번호</th>
											<th class="sales_regist15" rowspan="2">세금<br>계산서<br>번호</th>
											<th class="sales_regist16" rowspan="2">비고</th>
										</tr>
										<tr class="table100-head1">
											<th class="sales_regist17">사원번호</th>
											<th class="sales_regist18">사원명</th>
										</tr>
									</thead>
									<tbody>
										
										<% 
											try{
												Class.forName(driver);
												conn=DriverManager.getConnection(url,"java","java");
												
												connect=true;
												

												 //리스트에 전체 정보를 가지고 있기 위해서 query 재 정의
												  sellingQuery = "select s.*,";
												  sellingQuery += "c.customer_business_code, c.customer_businessman_name, c.customer_address, c.part_employee_name, c.part_employee_phone, i.item_standard ";
												  sellingQuery += "from selling s inner join customer c on s.customer_name = c.customer_name inner join item i on s.item_code = i.item_code ";
														 // + "order by s.order_date";
												  //sellingQuery = "select s.*, c.customer_business_code, c.customer_businessman_name, c.customer_address, c.part_employee_name, c.part_employee_phone, i.item_standard from selling s inner join customer c on s.customer_name = c.customer_name inner join item i on s.item_code = i.item_code order by s.selling_tax_bill_code";
												
												  //sellingQuery += " where 1=1";
												  if(sourcePicker!=null && !sourcePicker.equals("")) {
				                                    	sellingQuery += " and s.order_date >= '" + sourcePicker + "'";
				                                    }
				                                    if(destinationPicker!=null && !destinationPicker.equals("")) {
				                                    	sellingQuery += " and s.order_date <= '" + destinationPicker + "'";
				                                    }
				                                    if(sourcePicker!=null && sourcePicker.equals("") && destinationPicker!=null && destinationPicker.equals("")) {
				                                    	if(!yearPicker.equals("0")) {
				                                    		sellingQuery += " and year(s.order_date) = '" + yearPicker + "'";
				                                    	}
				                                    	if(!monthPicker.equals("0")) {
				                                    		sellingQuery += " and month(s.order_date) = '" + monthPicker + "'";
				                                    	}
				                                    }
				                                    if(code_search!=null && !code_search.equals("")) {
				                                    	sellingQuery += " and s.employee_code = '" + code_search + "'";
				                                    }
				                                    if(name_search!=null && !name_search.equals("")) {
				                                    	sellingQuery += " and s.employee_name = '" + name_search + "'";
				                                    }
				                                    if(code_search0!=null && !code_search0.equals("")) {
				                                    	sellingQuery += " and s.item_code = '" + code_search0 + "'";
				                                    }
				                                    if(code_search1!=null && !code_search1.equals("")) {
				                                    	sellingQuery += " and s.order_code = '" + code_search1 + "'";
				                                    }
				                                    if(customer_name!=null && !customer_name.equals("전체")) {
				                                    	sellingQuery += " and s.customer_name = '" + customer_name + "'";
				                                    }
				                                    if(item_name!=null && !item_name.equals("전체")) {
				                                    	sellingQuery += " and s.item_name = '" + item_name + "'";
				                                    }
				                                    if(chit_div!=null && chit_div.equals("처리")) {
				                                    	sellingQuery += " and s.selling_chit_code is not null";
				                                    }
				                                    if(chit_div!=null && chit_div.equals("미처리")) {
				                                    	sellingQuery += " and s.selling_chit_code is null";
				                                    }
				                                    //sellingQuery += " order by s.selling_code";
				                                    sellingQuery += " order by s.order_date";
													/////////////////////////////////////////////////////////////////////////////
													System.out.println(sellingQuery);
												  
												  // statement 생성
												  SEstmt = (Statement)conn.createStatement();
												  //SEEstmt = (Statement)conn.createStatement();
												  // 쿼리실행하고 결과를 담기
												  
												  //SEErs = SEEstmt.executeQuery(sellingExQuery);
												  SErs=SEstmt.executeQuery(sellingQuery);
													
													// ACrs.next() && EMPrs.next()
													
													int i=0;
						       							while(SErs.next()){ 
														i++;
						       						
						       								
													// 값 가져오기
													String selling_date = SErs.getString("selling_date");
													String selling_chit_code = SErs.getString("selling_chit_code");
													String selling_tax_bill_code = SErs.getString("selling_tax_bill_code");
													String selling_memo = SErs.getString("selling_memo");
													int selling_count = SErs.getInt("selling_count");
													int item_unit_price = SErs.getInt("item_unit_price");
													
													// 천단위 콤마를 위한 객체 생성
													DecimalFormat df = new DecimalFormat("###,###");
													
													// 천단위 콤마 문자열
													String sellingCountDF = df.format(selling_count);
													String itemUnitPriceDF = df.format(item_unit_price);
													String orderPriceDF = df.format(selling_count*item_unit_price);
												
													if (selling_date==null){
														selling_date="";
													}
													if (selling_chit_code==null){
														selling_chit_code="";
													}
													if (selling_tax_bill_code == null){
														selling_tax_bill_code="";
													}
													if (selling_memo == null){
														selling_memo ="";
													}
												%>
													<tr data-toggle="modal" data-target="#salesModal">
													<td class="li_sales_regist0" onclick="event.cancelBubble=true"><input type="checkbox" id="checkbox" name="chbox" onclick="checkOnlyOne(this)"></td>
													<td class="li_sales_regist1" data-bcode='<%=SErs.getString("customer_business_code")%>'><%=i%></td>
													<td class="li_sales_regist2" data-bname='<%=SErs.getString("customer_businessman_name")%>'><%=SErs.getString("employee_code")%></td>
													<td class="li_sales_regist3" data-addr='<%=SErs.getString("customer_address")%>'><%=SErs.getString("employee_name")%></td>
													<td class="li_sales_regist4" data-ename='<%=SErs.getString("part_employee_name")%>'><%=SErs.getString("customer_code")%></td>
													<td class="li_sales_regist4" data-ephone='<%=SErs.getString("part_employee_phone")%>'><%=SErs.getString("customer_name")%></td>
													<td class="li_sales_regist5"><%=SErs.getString("item_code")%><input type="hidden" name="selling_item_code_form" value=""></td>
													<td class="li_sales_regist6" data-istand='<%=SErs.getString("item_standard")%>'><%=SErs.getString("item_name")%></td>
													<td class="li_sales_regist7"><%=SErs.getString("item_unit_name")%></td>
													<td class="li_sales_regist8"><% out.print(sellingCountDF);%><input type="hidden" name="selling_count_form" value=""></td>
													<td class="li_sales_regist9"><% out.print(itemUnitPriceDF);%></td>
													<td class="li_sales_regist10"><% out.print(orderPriceDF);%></td>
													<td class="li_sales_regist11"><%=SErs.getString("order_code")%><input type="hidden" name="selling_order_code_form" value=""></td>
													<td class="li_sales_regist12"><%=SErs.getString("order_date")%></td>
													<td class="li_sales_regist13"><%=selling_date%></td>
													<td class="li_sales_regist14"><%=selling_chit_code%></td>
													<td class="li_sales_regist15"><%=selling_tax_bill_code%></td>
													<td class="li_sales_regist16"><%=selling_memo%></td>	
											<%	}
											}catch(SQLException ex){
												out.println(ex.getMessage());
												ex.printStackTrace();
											}finally{ // 연결 해제
												// ResultSet 해제
												if(SErs!=null)try{
													SErs.close();
												}catch(SQLException ex){}
												/* if(SEErs!=null)try{
													SEErs.close();
												}catch(SQLException ex){} */
												/* if(SErs!=null)try{
													SErs.close();
												}catch(SQLException ex){} */
												
												
												
												// Statement 해제
												if(SEstmt!=null)try{
													SEstmt.close();
												} catch(SQLException ex){}
												/* if(SEEstmt!=null)try{
													SEEstmt.close();
												} catch(SQLException ex){} */
												/* if(SEstmt!=null)try{
													SEstmt.close();
												} catch(SQLException ex){} */
												
												if(conn!=null)try{
													conn.close();
												}catch(SQLException ex){}
											}// finally_end
											%>		
										</tr>
									</tbody>
								</table>
							</div>
							<br>
							<!-- 등록 버튼 -->
							 <div class="row">
              				  <div class="col-md-3" style="margin-left:45%">
	                		  	<button type="submit" class="btn btn-primary" id="selectBtn">등록</button>
<!-- 	                		  	<a id="store_lookup_data-submit-button" onclick="enrollSales()" href="jsp:;" class="d-none d-sm-inline-block btn btn-primary shadow-sm" >등록</a> -->
	           				 	<button type="button" class="btn btn-primary" id="returnBtn" data-toggle="modal" data-target="#ReturnEnrollModal">반품 등록</button>
<!-- 	           				 	<a id="return_enroll_data-submit-button" href="jsp:;" class="d-none d-sm-inline-block btn btn-primary shadow-sm" data-toggle="modal" data-target="#ReturnEnrollModal">반품 등록</a> -->
	           				  </div>
	           				 </div>
	           				 </form>
						</div>
					</div>
				</div>
				
				<!-- 세금계산서  modal -->
				<div id="printThis">
					<div class="modal fade" id="salesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;" role="document">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 style="color:black" class="modal-title" id="exampleModalLabel">세금계산서</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					      
					      <!-- 세금계산서 테이블 -->
						   <div class="limiter" >
							<div class="container-table100" style="width:1000px">
								<div class="wrap-table100">
						        <div class="table100" style="width:1000px">
										<table>
											<tbody>
											<% 
											try{
												Class.forName(driver);
												conn=DriverManager.getConnection(url,"java","java");
												
												connect=true;

												// statement 생성
												CUstmt = (Statement)conn.createStatement();
												
												CUMstmt = (Statement)conn.createStatement();
												CUMrs = CUMstmt.executeQuery(customerNameQuery);
												
												int j=0;
				       							while(CUMrs.next()){ 
				       								temp = CUMrs.getString("customer_name");
												j++;
				       							}
												// ACrs.next() && EMPrs.next()
												
												if(!temp.equals("")){
													customerQuery = customerQuery + " where customer_name = '" + temp + "'"; 
												}

												// 쿼리실행하고 결과를 담기
												CUrs = CUstmt.executeQuery(customerQuery);

												int i=0;
					       							while(CUrs.next()){ 
					       								
													i++;
													
												%>
												<tr style="height:30px">
													<th class="top_tranding0" rowspan=2>No.</th>
													<th class="top_tranding1" rowspan=2 colspan=9><input type="text" name="tax_no" value="" style = "text-align:center; background-color:transparent;" size=30/></th>
													<th class="top_tranding2" rowspan=2 colspan=10>세 금 계 산 서</th>
													<th class="top_tranding3" rowspan=2 colspan=10>공급자 (보 관 용)</th>
												</tr>
												
												<tr style="height:30px">
												</tr>
												<tr style="height:30px">
													<td class="tranding" rowspan=6>공 급 자</td>
													<td class="tranding1" colspan=2>등록번호</td>
													<td class="tranding_mid2" colspan=7 style="color:black;">211-81-71536</td>
													<td class="tranding1" colspan=2>종사업장</td>
													<td class="tranding_mid4" colspan=3></td>
													<td class="tranding" rowspan=6>공 급 받 는 자</td>
													<td class="tranding1" colspan=2>등록번호</td>
													<td class="tranding_mid7" colspan=7><input type="text" name="cu_code" value="" style = "text-align:center;" size=30/></td>
													<td class="tranding1" colspan=2>종사업장</td>
													<td class="tranding_mid9" colspan=3></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding1" colspan=2>상호</td>
													<td class="tranding_mid11" colspan=7 style="color:black;">GLASS長</td>
													<td class="tranding1">성명</td>
													<td class="tranding_mid13" colspan=4 style="color:black;">최보금</td>
													<td class="tranding1" colspan=2>상호</td>
													<td class="tranding_mid15" colspan=7><input type="text" name="bs_name" value="" style = "text-align:center;" size=30/></td>
													<td class="tranding1">성명</td>
													<td class="tranding_mid17" colspan=4><input type="text" name="cu_captin" value="" style = "text-align:center;" size=16/></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding1" colspan=2>주소</td>
													<td class="tranding_mid19" colspan=12 style="color:black;">강남구 테헤란로 11-11</td>
													<td class="tranding1" colspan=2>주소</td>
													<td class="tranding_mid21" colspan=12><input type="text" name="cu_addr" value="" style = "text-align:center;" size=55/></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding1" colspan=2>업태</td>
													<td class="tranding_mid23" colspan=5 style="color:black;">도소매업</td>
													<td class="tranding1">종목</td>
													<td class="tranding_mid25" colspan=6></td>
													<td class="tranding1" colspan=2>업태</td>
													<td class="tranding_mid27" colspan=5 style="color:black;">소매업</td>
													<td class="tranding1">종목</td>
													<td class="tranding_mid29" colspan=6></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding1" colspan=2>담당자</td>
													<td class="tranding_mid31" colspan=5><input type="text" name="em_name" value="" style = "text-align:center;"/></td>
													<td class="tranding1" colspan=2>연락처</td>
													<td class="tranding_mid33" colspan=5 style="color:black;">02-300-0000</td>
													  <td class="tranding1" colspan=2>담당자</td>
													  <td class="tranding_mid35" colspan=5><input type="text" name="cu_captin" value="" style = "text-align:center;" size=20/></td>
													  <td class="tranding1" colspan=2>연락처</td>
													  <td class="tranding_mid37" colspan=5><input type="text" name="cu_tel" value="" style = "text-align:center;" size=20/></td>
													  </tr>
													  <tr style="height:30px">
													  <td class="tranding1" colspan=2>이메일</td>
													  <td class="tranding_mid39" colspan=12 style="color:black;">selladmin@glassj.com</td>
													  <td class="tranding1" colspan=2>이메일</td>
													<td class="tranding_mid41" colspan=12></td>
												</tr>
												<%	}
											}catch(SQLException ex){
												out.println(ex.getMessage());
												ex.printStackTrace();
											}finally{ // 연결 해제
												// ResultSet 해제
												if(CUrs!=null)try{
													CUrs.close();
												}catch(SQLException ex){}
												if(CUMrs!=null)try{
													CUMrs.close();
												}catch(SQLException ex){}
												/* if(CUrs!=null)try{
													CUrs.close();
												}catch(SQLException ex){} */
												
												// Statement 해제
												if(CUstmt!=null)try{
													CUstmt.close();
												} catch(SQLException ex){}
												if(CUMstmt!=null)try{
													CUMstmt.close();
												} catch(SQLException ex){}
												/* if(CUstmt!=null)try{
													CUstmt.close();
												} catch(SQLException ex){} */
												if(conn!=null)try{
													conn.close();
												}catch(SQLException ex){}
											}// finally_end
											
											%>
												<tr style="height:30px">
													<td class="tranding" colspan=4>작성일자</td>
													<td class="tranding" colspan=13>공급가액</td>
													<td class="tranding" colspan=13>세액</td>
												</tr>
												<tr style="height:30px">
													<td class="tranding_mid45" colspan=4><input type="text" name="date" value="" style = "text-align:center;" size=16/></td>
													<td class="tranding_mid46" colspan=13><input type="text" name="sup_price" value="" style = "text-align:center;" size=59/></td>
													<td class="tranding_mid47" colspan=13><input type="text" name="tax_amount" value="" style = "text-align:center;" size=59/></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding" colspan=4>비고1</td>
													<td class="tranding_mid49" colspan=26></td>
												</tr>
												<% 
											try{
												Class.forName(driver);
												conn=DriverManager.getConnection(url,"java","java");
												
												connect=true;

												// statement 생성
												ITEMstmt = (Statement)conn.createStatement();
												
												ITEMNstmt = (Statement)conn.createStatement();
												ITEMNrs = ITEMNstmt.executeQuery(ItemNameQuery);
												
												int j=0;
				       							while(ITEMNrs.next()){ 
				       								temp2 = ITEMNrs.getString("item_name");
												j++;
				       							}
												// ACrs.next() && EMPrs.next()
												
												if(!temp2.equals("")){
													itemQuery = itemQuery + " where item_name = '" + temp2 + "'"; 
												}

												// 쿼리실행하고 결과를 담기
												ITEMrs = ITEMstmt.executeQuery(itemQuery);

												int i=0;
					       							while(ITEMrs.next()){ 
					       								
													i++;
													
												%>
												<tr style="height:30px">
													<td class="tranding">월</td>
													<td class="tranding">일</td>
													<td class="tranding" colspan=7>품목</td>
													<td class="tranding" colspan=3>규격</td>
													<td class="tranding" colspan=3>수량</td>
													<td class="tranding" colspan=3>단가</td>
													<td class="tranding" colspan=4>공급가액</td>
													<td class="tranding" colspan=3>세액</td>
													<td class="tranding" colspan=5>비고</td>
												</tr>
												<tr style="height:30px">
													<td class="tranding_bot9"><input type="text" name="month" value="" style = "text-align:center;" size=1/></td>
													<td class="tranding_bot10"><input type="text" name="day" value="" style = "text-align:center;" size=1/></td>
													<td class="tranding_bot11" colspan=7><input type="text" name="item_name" value="" style = "text-align:center;" size=30/></td>
													<td class="tranding_bot12" colspan=3><input type="text" name="item_standard" value="" style = "text-align:center;" size=11/></td>
													<td class="tranding_bot13" colspan=3><input type="text" name="count" value="" style = "text-align:center;" size=11/></td>
													<td class="tranding_bot14" colspan=3><input type="text" name="price" value="" style = "text-align:center;" size=11/></td>
													<td class="tranding_bot15" colspan=4><input type="text" name="sup_price" value="" style = "text-align:center;" size=16/></td>
													<td class="tranding_bot16" colspan=3><input type="text" name="tax_amount" value="" style = "text-align:center;" size=11/></td>
													<td class="tranding_bot17" colspan=5></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding_bot9"></td>
													<td class="tranding_bot10"></td>
													<td class="tranding_bot11" colspan=7></td>
													<td class="tranding_bot12" colspan=3></td>
													<td class="tranding_bot13" colspan=3></td>
													<td class="tranding_bot14" colspan=3></td>
													<td class="tranding_bot15" colspan=4></td>
													<td class="tranding_bot16" colspan=3></td>
													<td class="tranding_bot17" colspan=5></td>
												</tr>
												<%	}
											}catch(SQLException ex){
												out.println(ex.getMessage());
												ex.printStackTrace();
											}finally{ // 연결 해제
												// ResultSet 해제
												if(ITEMrs!=null)try{
													ITEMrs.close();
												}catch(SQLException ex){}
												if(ITEMNrs!=null)try{
													ITEMNrs.close();
												}catch(SQLException ex){}
												if(ITEMrs!=null)try{
													ITEMrs.close();
												}catch(SQLException ex){}
												
												// Statement 해제
												if(ITEMstmt!=null)try{
													ITEMstmt.close();
												} catch(SQLException ex){}
												if(ITEMNstmt!=null)try{
													ITEMNstmt.close();
												} catch(SQLException ex){}
												if(ITEMstmt!=null)try{
													ITEMstmt.close();
												} catch(SQLException ex){}
												if(conn!=null)try{
													conn.close();
												}catch(SQLException ex){}
											}// finally_end
											
											%>
												<tr style="height:30px">
													<td class="tranding_bot9"></td>
													<td class="tranding_bot10"></td>
													<td class="tranding_bot11" colspan=7></td>
													<td class="tranding_bot12" colspan=3></td>
													<td class="tranding_bot13" colspan=3></td>
													<td class="tranding_bot14" colspan=3></td>
													<td class="tranding_bot15" colspan=4></td>
													<td class="tranding_bot16" colspan=3></td>
													<td class="tranding_bot17" colspan=5></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding" colspan=7>합계금액</td>
													<td class="tranding1" colspan=3>현금</td>
													<td class="tranding1" colspan=3>수표</td>
													<td class="tranding1" colspan=3>어음</td>
													<td class="tranding1" colspan=3>외상미수금</td>
													<td class="tranding_bot23" colspan=11 rowspan=2>이 금액을 <span style="color:#b22222;"> [청구]</span>함</td>
												</tr>
												<tr style="height:30px">
													<td class="tranding_bot24" colspan=7><input type="text" name="total_price" value="" style = "text-align:center;" size=30/></td>
													<td class="tranding_bot25" colspan=3><input type="text" name="cash" value="" style = "text-align:center;" size=11/></td>
													<td class="tranding_bot26" colspan=3></td>
													<td class="tranding_bot27" colspan=3></td>
													<td class="tranding_bot28" colspan=3></td>
												</tr>
											</tbody>
										</table>
									</div>
									
						      </div>
						      </div>
						      </div>
						      </div>
					      <div class="modal-footer">
					      	<button type="button" id="btnPrint" class="btn btn-primary">인쇄</button>
					       	<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
					      </div>
					    </div>
					  </div>
					</div>
				</div>
				
				<!-- 반품 등록 Modal -->
				<div class="modal fade" id="ReturnEnrollModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 style="color:black" class="modal-title" id="exampleModalLabel">반품 등록</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <form action="bad_stock_itemRegistAction.jsp" method="post">
				      <div class="modal-body" style="background-color:#F0F3F7; height:100%; width: 1000px;">
				        	<!-- 첫줄 -->
							<div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>전표번호
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="r1" value="" class="form-control-sm" style="width:170px;" >
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>수주번호
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="r2" value="" class="form-control-sm" style="width:170px;" >
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>수주일
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="r3" value="" class="form-control-sm" style="width:170px;" >
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
                
			                <!-- 두번째 줄 -->
			                <div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>담당<br>사원번호
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="r4" value="" class="form-control-sm" style="width:170px;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>담당사원명
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="r5" value="" class="form-control-sm" style="width:170px;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>거래처명
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="r6" value="" class="form-control-sm" style="width:170px;">
								      </div><!-- /btn-group -->
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
								       	<input type="text" name="r7" value="" class="form-control-sm" style="width:170px;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>품목명
										</button>
								      <div class="input-group-btn m-1">
								       	<input type="text" name="r8" value="" class="form-control-sm" style="width:170px;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>단위
										</button>
										<div class="input-group-btn m-1">
								      	<input type="text" name="r9" value="" class="form-control-sm" style="width:170px;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
			                
			                <hr>
			                
			                <!-- 네번째 줄 -->
			                <div class="row m-3">
							    <div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>반품일
										</button>
								      <div class="input-group-btn m-1">
<!-- 								       	<input type="month"> -->
								      	<input type="text" name="r10" class="form-control-sm" style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>수량
										</button>
								      <div class="input-group-btn m-1">
								      	<input type="text" id="re1" name="r11"class="form-control-sm"  onkeyup='call()' style="width:170px; border: 1px solid gray;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
								<div class="col-lg-4">
								    <div class="input-group">
										<button type="button" class="btn btn-primary btn-sm" disabled="disabled" style="width:100px">
										  <span aria-hidden="true"></span>단가
										</button>
								      <div class="input-group-btn m-1">
								      	<input type="text" id="re2" name="r12" value=""  onkeyup='call()' class="form-control-sm" style="width:170px;">
								      </div><!-- /btn-group -->
								    </div><!-- /input-group -->
								</div><!-- /.col-lg-4 -->
			                </div>
			                <hr>
			                <div style="text-align: center;">
			                	<span style="color:black;">총 반품금액</span>
			                	<input type="text" id="re3" name="r13" value="" class="form-control-sm" style="margin-left:42%; width:170px;">
			                	<input type="hidden" name="r14" value="">
			                	<input type="hidden" name="r15" value="">
			                </div>
				      </div>
				      <div class="modal-footer">
				      	<button type="submit" id="btn_submit" class="btn btn-primary">등록</button>
				       	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				      </div>
				     </form>
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
				
                
                <div class="container-fluid">

                    
                </div>
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
	    $( "#sales_datepicker_1, #sales_datepicker_2" ).datepicker();
	  } );
	 </script>
	 <script>
		$("#selectBtn").click(function(){ 
			
			//var rowData = new Array();
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
				//var no = td.eq(1).text();
				var item_code = td.eq(6).text();
				var count = td.eq(9).text();
				var order_code = td.eq(12).text();
				var chit= td.eq(15).text();
				var memo = td.eq(17).text();
				
				//alert(" * 체크된 Row의 no = "+col2); //값 받아오기 확인용
				
				if(chit!=""){
					alert("이미 매출 등록된 주문입니다.");
					
				}else if(memo=="취소"){
					alert("취소된 주문입니다.");
				}else{
					//$("input[name=selling_code_form]").attr('value',no);
					$("input[name=selling_item_code_form]").attr('value',item_code);
					$("input[name=selling_count_form]").attr('value',count);
					$("input[name=selling_order_code_form]").attr('value',order_code);
				}
			});
		});
	</script>
	<script>
		$("#returnBtn").click(function(){ 
			
			var checkbox = $("input[name=chbox]:checked");
			
			checkbox.each(function(i) {
	

				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();

 				var r1 = td.eq(15).text();
				var r2 = td.eq(12).text();
				var r3 = td.eq(13).text();
				var r4 = td.eq(2).text();
				var r5 = td.eq(3).text();
				var r6 = td.eq(5).text();
				var r7 = td.eq(6).text();
				var r8 = td.eq(7).text();
				var r9 = td.eq(8).text();
				var r12 = td.eq(10).text().replace(/,/g, "");
				var r14 = td.eq(1).text();
				var r15 = td.eq(4).text();
				var memo = td.eq(17).text();
				
				if(r1==""){
					alert("반품 등록을 할 수 없습니다.\n수주 취소 또는 매출 미등록 주문입니다.");
					location.reload(true);
					
				}else if(memo=="반품"){
					alert("반품 등록을 할 수 없습니다.\n이미 반품 등록된 매출입니다.");
					location.reload(true);
				}else{
					var today = new Date();

					var year = today.getFullYear();
					var month = ('0' + (today.getMonth() + 1)).slice(-2);
					var day = ('0' + today.getDate()).slice(-2);

					var dateString = year + '-' + month  + '-' + day;
					
					$("input[name=r1]").attr('value',r1);
					$("input[name=r2]").attr('value',r2);
					$("input[name=r3]").attr('value',r3);
					$("input[name=r4]").attr('value',r4);
					$("input[name=r5]").attr('value',r5);
					$("input[name=r6]").attr('value',r6);
					$("input[name=r7]").attr('value',r7);
					$("input[name=r8]").attr('value',r8);
					$("input[name=r9]").attr('value',r9);
					$("input[name=r10]").attr('value',dateString);
					$("input[name=r12]").attr('value',r12);
					$("input[name=r14]").attr('value',r14);
					$("input[name=r15]").attr('value',r15);
				}

			});

		});
	</script>
	<script>
		$("#sales-table-1 tr").click(function(){ 	
	

			// 현재 클릭된 Row(<tr>)
			var tr = $(this);
			var td = tr.children();
			
			// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
			//console.log("클릭한 Row의 모든 데이터 : "+tr.text());
			
			
			// td.eq(index)를 통해 값을 가져올 수도 있다.
			var em_name = td.eq(3).text();
			var item_name = td.eq(7).text();
			var count = td.eq(9).text();
			var price = td.eq(10).text();
			var date = td.eq(14).text();
			var bs_name = td.eq(5).text();
			var tax_no = td.eq(16).text();
			
			var cb_code = td.eq(1).data("bcode");
			  var cb_name = td.eq(2).data("bname");
			  var c_addr = td.eq(3).data("addr");
			  var pe_addr = td.eq(4).data("ename");
			  var pe_phone = td.eq(5).data("ephone");
			  var i_stand = td.eq(7).data("istand");
			
			var count1 = count.replace(/,/g, ""); // 천단위 콤마 제거
			var price1 = price.replace(/,/g, "")
			var sup_price1 = count1*price1;
			var tax_amount1 = sup_price1*0.1;
			var total_price1 = sup_price1+tax_amount1;
			
			var sup_price = sup_price1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 천단위 콤마 다시 붙이기
			var tax_amount = tax_amount1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			var total_price = total_price1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

			var after_date = date.split('-');
			
			var temp = '<%=temp%>';
			var temp2 ='<%=temp2%>';
			
			//alert(" * 클릭한 Row의 tax_no = "+tax_no);
			//alert("what?"+typeof(sup_price));
			if(tax_no==""){
				alert("세금 계산서가 존재하지 않습니다.");
				location.reload(true);
				
			}else{
				$("input[name=em_name]").attr('value',em_name);
				$("input[name=item_name]").attr('value',item_name);
				$("input[name=count]").attr('value',count);
				$("input[name=price]").attr('value',price);
				$("input[name=sup_price]").attr('value',sup_price); // 공급가액
				$("input[name=tax_amount]").attr('value',tax_amount); // 세액
				$("input[name=date]").attr('value',date);
				$("input[name=total_price]").attr('value',total_price); // 합계 금액
				$("input[name=cash]").attr('value',total_price); // 현금
				$("input[name=bs_name]").attr('value',bs_name);
				$("input[name=month]").attr('value',after_date[1]);
				$("input[name=day]").attr('value',after_date[2]);
				$("input[name=tax_no]").attr('value',tax_no);
				
				$("input[name=cu_code]").attr('value',cb_code);
			    $("input[name=cu_captin]").attr('value',cb_name);
			    $("input[name=cu_addr]").attr('value',c_addr);
			    $("input[name=cu_emp]").attr('value',pe_addr);
			    $("input[name=cu_tel]").attr('value',pe_phone);
			    if(i_stand==null){i_stand="";}
			    $("input[name=item_standard]").attr('value',i_stand);
			}			
		});
	</script>
	<script type="text/javascript"> // 프린트 기능
		document.getElementById("btnPrint").onclick = function () {
		    printElement(document.getElementById("printThis"));
		}
	
		function printElement(elem) {
		    var domClone = elem.cloneNode(true);
		    
		    var $printSection = document.getElementById("printSection");
		    
		    if (!$printSection) {
		        var $printSection = document.createElement("div");
		        $printSection.id = "printSection";
		        document.body.appendChild($printSection);
		    }
		    
		    $printSection.innerHTML = "";
		    $printSection.appendChild(domClone);
		    window.print();
		}
	</script>
	<script  type="text/javascript">
		function call(){
		 if(document.getElementById("re1").value && document.getElementById("re2").value){
		  	document.getElementById('re3').value =parseInt(document.getElementById('re1').value) * parseInt(document.getElementById('re2').value.replace(/,/g, ""));
		 }
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
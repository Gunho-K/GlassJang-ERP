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
	ResultSet ORDERSrs = null;
	
	Statement CUstmt = null;
	ResultSet CUrs=null;
	
	Statement CUMstmt = null;
	ResultSet CUMrs=null;
	
	Statement EMstmt = null;
	ResultSet EMrs = null;
	
	Statement ITEMstmt = null;
	ResultSet ITEMrs = null;
	
	Statement ITEMNstmt = null;
	ResultSet ITEMNrs = null;
	
	Statement ORCstmt = null;
	ResultSet ORCrs = null;
	
	// 드라이버 및 데이터베이스 설정
	String driver="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
	// 수주 테이블 선택
	String OrdersQuery="select * from orders";
	//String OrcanQuery="select * from orders where order_memo!='취소'";
	String customerQuery="select * from customer";
	String customerNameQuery="select customer_name from customer";
	String employeeQuery="select * from employee";
	String itemQuery="select * from item";
	String itemStandardQuery = "select item_standard from item";
	String ItemNameQuery="select item_name from item";
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

    <title>GLASS 長 - 수주 현황</title>

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

<body id="page-top">

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
							<a class="navbar-brand mb-0 h1" href="#">수주 현황</a>
						</div>
					</nav>

                <!-- /.container-fluid -->
                
				 <!-- 검색구역 -->
                
                <% 
	            request.setCharacterEncoding("UTF-8");
	            
	            String item_code = (String)request.getParameter("item_code");
	            String emp_code = (String)request.getParameter("emp_code");
	            String emp_name = (String)request.getParameter("emp_name");
	            
	            String customer_name = (String)request.getParameter("customer_name");
	            String order_code = (String)request.getParameter("order_code");
	            String item_name = (String)request.getParameter("item_name_search"); 
	            
	            String sourcePicker = (String)request.getParameter("source_datepicker_search");
	            String destinationPicker = (String)request.getParameter("destination_datepicker_search");
	            String yearPicker = (String)request.getParameter("year_picker_search");
	            String monthPicker = (String)request.getParameter("month_picker_search");
	            
	            String item_code_value = (item_code==null ? "" : item_code);
	            String emp_code_value = (emp_code==null ? "" : emp_code);
	            String emp_name_value = (emp_name==null ? "" : emp_name);
	            
	            String order_code_value = (order_code==null ? "" : order_code);
	            
	            String sourcePicker_value = (sourcePicker==null ? "" : sourcePicker);
	            String destinationPicker_value = (destinationPicker==null ? "" : destinationPicker);
	            String yearPicker_value = (yearPicker==null ? "" : yearPicker);
	            String monthPicker_value = (monthPicker==null ? "" : monthPicker);
	            
	            %>
                <!-- 검색창 시작 -->
                <form action="수주_현황.jsp" method="POST">
				<div class="row mt-3 ml-1">
					<div class="col-lg-4">
					    <div class="input-group">
							<span class="mt-2"style="width:100px">사원번호</span>
					       <div class="input-group-btn m-1">
							 <input type="text" name="emp_code" value="<%=emp_code_value %>" class="form-control-sm ml-2" aria-describedby="basic-addon2">
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2"style="width:120px">사원명</span>
					      <div class="input-group-btn">
							 <input type="text" name="emp_name" value="<%=emp_name_value %>" class="form-control-sm" aria-describedby="basic-addon2">
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					<div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2" style="width:100px">품목코드</span>
					      <div class="input-group-btn m-1">
							 <input type="text" name="item_code" value="<%=item_code_value %>" class="form-control-sm ml-2" aria-describedby="basic-addon2">
						  </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
                </div>
                
                <!-- 두번째 줄 -->
                <div class="row ml-1" style="margin-top:10px">
                <div class="col-lg-4">
				    <div class="input-group">
						<span class="mt-2"style="width:100px">품목명</span>
				       <div class="input-group-btn m-1">
						 		<select name="item_name_search" class="form-control ml-2" style="width: 180px">
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
					      <span class="mt-2"style="width:120px">거래처명</span>

					      <div class="input-group-btn">
							 <select name="customer_name" class="form-control" style="width:180px">
							 	<option value="전체">전체</option>
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
													String c_name = CUrs.getString(1);
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
					<div class="col-lg-4">
					    <div class="input-group">
					      <span class="mt-2"style="width:100px">수주번호</span>

					      <div class="input-group-btn m-1">
					        <input type="text" name="order_code" value="<%=order_code_value %>" class="form-control-sm ml-2" aria-describedby="basic-addon2">
					      </div><!-- /btn-group -->
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
                </div>
                
                <!-- 세번째 줄 -->
                <div class="row mt-2 ml-1">
				    <div class="col-lg-5">
					    <div class="input-group" style="width:635px">
					      <span class="mt-2"style="width:100px">기간</span>
					      <div class="form-group m-1"> 
						      <div class="input-group date mt-1 ml-2"> 
								<input type="text" name="source_datepicker_search" value="<%=sourcePicker_value %>" class="datepicker" style="width:160px" id="order_datepicker_1"> 
						      </div> 
					      </div>
					      <span class="mt-1 ml-1">~</span>
					      <div class="form-group m-1"> 
						      <div class="input-group date mt-1 ml-2"> 
								<input type="text" name="destination_datepicker_search"  value="<%=destinationPicker_value %>" class="datepicker" style="width:160px" id="order_datepicker_2"> 
						      </div> 
					      </div>
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-5 -->
					<div class="col-lg-6">
					    <div class="input-group">
					      <div class="row form-group"> 
					      	<div class="input-group-btn">
						      	<select name="year_picker_search" class="form-control ml-4" style="width:85px">
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
					</div><!-- /.col-lg-6 -->
					
					<div class="col-lg-1">
						<button type="submit" id="order_state-submit-button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">확인</button>
					</div><!-- /.col-lg-3 -->
					</div> 
	            </form>
	            </div>
	            
	       		
	            <!-- 수주 현황 테이블 -->
				<div class="limiter">
					<div class="container-table100">
						<div class="wrap-table100">
						<div class="row mt-2 ml-1">
						<span style="font-size:10pt;display: inline-block; text-align:left;">'거래명세서'는 해당 항목을 클릭하시면 확인하실 수 있습니다.</span> 

							</div>
				
				<!-- 수주현황 테이블 -->
							<div class="table100" style="width:100%; height:450px; overflow:auto">
								<table id="order-table-1">
									<thead>
										<tr class="table100-head">
											<th class="order_state1" rowspan="2">No</th>
											<th class="order_state2" colspan="2">담당자</th>
											<th class="order_state3" rowspan="2">거래처<br>코드</th>
											<th class="order_state4" rowspan="2">거래처명</th>
											<th class="order_state5" rowspan="2">품목<br>코드</th>
											<th class="order_state6" rowspan="2">품목명</th>
											<th class="order_state7" rowspan="2">단위</th>
											<th class="order_state8" rowspan="2">수량</th>
											<th class="order_state9" rowspan="2">단가</th>
											<th class="order_state10" rowspan="2">수주<br>금액</th>
											<th class="order_state11" rowspan="2">수주일</th>
											<th class="order_state12" rowspan="2">수주<br>번호</th>
											<th class="order_state13" rowspan="2">비고</th>
										</tr>
										<tr class="table100-head">
											<th class="order_state14">사원번호</th>
											<th class="order_state15">사원명</th>
										</tr>
										
									</thead>
									<tbody>
										<% 
											try{
												Class.forName(driver);
												conn=DriverManager.getConnection(url,"java","java");
												
												connect=true;
												OrdersQuery="select o.*,";
												OrdersQuery +=" c.customer_business_code, c.customer_businessman_name, c.customer_address, c.part_employee_name, c.part_employee_phone, i.item_standard ";
												OrdersQuery +=" from orders o inner join customer c on o.customer_name = c.customer_name inner join item i on o.item_code = i.item_code";
												OrdersQuery +=" where o.order_memo !='취소'";
												/////////////////////////////////////////////////////////////////////////////
										        //검색을 반영한 쿼리 적용
										        if(item_code != null && !item_code.equals("")) {
										        	OrdersQuery += " and o.item_code = '" + item_code + "'";
										        }
										        if(item_name!=null && !item_name.equals("전체")) {
			                                    	OrdersQuery += " and o.item_name = '" + item_name + "'";
			                                    }
										        if(emp_code != null && !emp_code.equals("")) {
										        	OrdersQuery += " and o.employee_code = '" + emp_code + "'";
										        }
										        if(emp_name != null && !emp_name.equals("")) {
										        	OrdersQuery += " and o.employee_name = '" + emp_name + "'";
										        }
										        if(customer_name != null && !customer_name.equals("전체")) {
										        	OrdersQuery += " and o.customer_name = '" + customer_name + "'";
										        }
										        if(order_code != null && !order_code.equals("")) {
										        	OrdersQuery += " and o.order_code = '" + order_code + "'";
										        }
										        if(sourcePicker!=null && !sourcePicker.equals("")) {
										        	OrdersQuery += " and o.order_date >= '" + sourcePicker + "'";
										        }
										        if(destinationPicker!=null && !destinationPicker.equals("")) {
										        	OrdersQuery += " and o.order_date <= '" + destinationPicker + "'";
										        }
										        if(sourcePicker!=null && sourcePicker.equals("") && destinationPicker!=null && destinationPicker.equals("")) {
										        	if(!yearPicker.equals("0")) {
										        		OrdersQuery += " and year(o.order_date) = '" + yearPicker + "'";
										        	}
										        	if(!monthPicker.equals("0")) {
										        		OrdersQuery += " and month(o.order_date) = '" + monthPicker + "'";
										        	}
										        }
										        OrdersQuery += " order by o.order_code";
										        /////////////////////////////////////////////////////////////////////////////
										        System.out.println(OrdersQuery);

												// statement 생성
												ORDERSstmt = (Statement)conn.createStatement();
												//ORCstmt=(Statement)conn.createStatement();
												// 쿼리실행하고 결과를 담기
												//ORCrs = ORCstmt.executeQuery(OrcanQuery);
												ORDERSrs = ORDERSstmt.executeQuery(OrdersQuery);
												
												// ACrs.next() && EMPrs.next()
												
												int i=0;
					       							while(ORDERSrs.next()){ 
													i++;
													
													// 값 가져오기
													int order_amount = ORDERSrs.getInt("order_amount"); //수량
													int item_unit_price = ORDERSrs.getInt("item_unit_price"); //단가
													int order_price = order_amount * item_unit_price; // 수주금액 (수량*단가)
											
													
													
													// 천단위 콤마를 위한 객체 생성
													DecimalFormat df = new DecimalFormat("###,###");
													// 천단위 콤마 문자열
													String orderAmountDF = df.format(order_amount); //수량
													String itemUnitPriceDF = df.format(item_unit_price); // 단가
													String orderpriceDF = df.format(order_price); // 수주금액
												%>
													<tr id="trClick" data-toggle="modal" data-target="#OrderTrandingModal">
														<td class="li_order_state1" data-bcode='<%=ORDERSrs.getString("customer_business_code")%>'><%=i %></td>
														<td class="li_order_state14" data-bname='<%=ORDERSrs.getString("customer_businessman_name")%>'><%=ORDERSrs.getString("employee_code")%></td>
														<td class="li_order_state15" data-addr='<%=ORDERSrs.getString("customer_address")%>'><%=ORDERSrs.getString("employee_name")%></td>
														<td class="li_order_state3" data-ename='<%=ORDERSrs.getString("part_employee_name")%>'><%=ORDERSrs.getString("customer_code")%></td>
														<td class="li_order_state4" data-ephone='<%=ORDERSrs.getString("part_employee_phone")%>'><%=ORDERSrs.getString("customer_name")%></td>
														<td class="li_order_state5"><%=ORDERSrs.getString("item_code")%></td>
														<td class="li_order_state6" data-istand='<%=ORDERSrs.getString("item_standard")%>'><%=ORDERSrs.getString("item_name")%></td>
														<td class="li_order_state7"><%=ORDERSrs.getString("item_unit_name")%></td>
														<td class="li_order_state8"><% out.print(orderAmountDF); %></td>
														<td class="li_order_state9"><% out.print(itemUnitPriceDF); %></td>
														<td class="li_order_state10"><% out.print(orderpriceDF); %></td> <!-- 수주금액 -->
														<td class="li_order_state11"><%=ORDERSrs.getString("order_date")%></td>
														<td class="li_order_state12"><%=ORDERSrs.getString("order_code")%></td>
														<td class="li_order_state13"><%=ORDERSrs.getString("order_memo")%></td>
													
											<%	}
											}catch(SQLException ex){
												out.println(ex.getMessage());
												ex.printStackTrace();
											}finally{ // 연결 해제
												// ResultSet 해제
												if(ORDERSrs!=null)try{
													ORDERSrs.close();
												}catch(SQLException ex){}
											
												
												// Statement 해제
												if(ORDERSstmt!=null)try{
													ORDERSstmt.close();
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
				<!-- 거래명세서 -->			
				<!-- Modal -->
				<div id="printThis">
				<div class="modal fade" id="OrderTrandingModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 style="color:black" class="modal-title" id="exampleModalLabel">거래명세서</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
				      
				      <!-- 거래명세서 테이블 -->
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
													
													//System.out.println(customerQuery);
													
												%>
												<tr style="height:30px">
													<th class="top_tranding0" rowspan=2>No.</th>
													<th class="top_tranding1" rowspan=2 colspan=9><input type="text" name="tax_no" value="" style = "text-align:left; background-color:transparent;" size=30/></th>
													<th class="top_tranding2" rowspan=2 colspan=10>거 래 명 세 서</th>
													<th class="top_tranding3" rowspan=2 colspan=10>공급자 (보 관 용)</th>
												</tr>
												<tr style="height:30px">
												</tr>
												
												<tr style="height:30px">
													<td class="tranding" rowspan=6>공 급 자</td>
													<td class="tranding1" colspan=2>등록번호</td>
													<td class="tranding_mid2" colspan=7>211-81-71536</td>
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
													<td class="tranding_mid11" colspan=7>GLASS 長</td>
													<td class="tranding1">성명</td>
													<td class="tranding_mid13" colspan=4>최보금</td>
													<td class="tranding1" colspan=2>상호</td>
													<td class="tranding_mid15" colspan=7><input type="text" name="bs_name" value="" style = "text-align:center;" size=30/></td>
													<td class="tranding1">성명</td>
													<td class="tranding_mid17" colspan=4><input type="text" name="cu_captin" value="" style = "text-align:center;" size=16/></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding1" colspan=2>주소</td>
													<td class="tranding_mid19" colspan=12>강남구 테헤란로 11-11</td>
													<td class="tranding1" colspan=2>주소</td>
													<td class="tranding_mid21" colspan=12><input type="text" name="cu_addr" value="" style = "margin-left:100px" size=30/></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding1" colspan=2>업태</td>
													<td class="tranding_mid23" colspan=5>도소매업</td>
													<td class="tranding1">종목</td>
													<td class="tranding_mid25" colspan=6></td>
													<td class="tranding1" colspan=2>업태</td>
													<td class="tranding_mid27" colspan=5>소매업</td>
													<td class="tranding1">종목</td>
													<td class="tranding_mid29" colspan=6></td>
												</tr>
												<tr style="height:30px">
													<td class="tranding1" colspan=2>담당자</td>
													<td class="tranding_mid31" colspan=5><input type="text" name="em_name" value="" style = "text-align:center;"/></td>
													<td class="tranding1" colspan=2>연락처</td>
													<td class="tranding_mid33" colspan=5>02-300-0000</td>
													  <td class="tranding1" colspan=2>담당자</td>
													  <td class="tranding_mid35" colspan=5><input type="text" name="cu_captin" value="" style = "text-align:center;" size=20/></td>
													  <td class="tranding1" colspan=2>연락처</td>
													  <td class="tranding_mid37" colspan=5><input type="text" name="cu_tel" value="" style = "text-align:center;" size=20/></td>
													  </tr>
													<tr style="height:30px">
													<td class="tranding1" colspan=2>이메일</td>
													<td class="tranding_mid39" colspan=12>selladmin@glassj.com</td>
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
												
												
												// Statement 해제
												if(CUstmt!=null)try{
													CUstmt.close();
												} catch(SQLException ex){}
												if(CUMstmt!=null)try{
													CUMstmt.close();
												} catch(SQLException ex){}
												
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
													<td class="tranding_bot23" colspan=11 rowspan=2>이 금액을 <span style="color:#b22222;"> [영수]</span>함</td>
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
	    $( "#order_datepicker_1, #order_datepicker_2" ).datepicker();
	  } );
	 </script>
	 <script>
		$("#order-table-1 tr").click(function(){ 	
	

			// 현재 클릭된 Row(<tr>)
			var tr = $(this);
			var td = tr.children();
			
			// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
			//console.log("클릭한 Row의 모든 데이터 : "+tr.text());			
			str = td.eq(13).text();
			// td.eq(index)를 통해 값을 가져올 수도 있다.
			var em_name = td.eq(2).text();
			var item_name = td.eq(6).text();
			var count = td.eq(8).text();
			var price = td.eq(9).text();
			var date = td.eq(11).text();
			var bs_name = td.eq(4).text();
			var tax_no = td.eq(12).text();
			
			var cb_code = td.eq(0).data("bcode");
			  var cb_name = td.eq(1).data("bname");
			  var c_addr = td.eq(2).data("addr");
			  var pe_addr = td.eq(3).data("ename");
			  var pe_phone = td.eq(4).data("ephone");
			  var i_stand = td.eq(6).data("istand");
			
			var count1 = count.replace(/,/g, "");
			var price1 = price.replace(/,/g, "");
			var sup_price1 = count1*price1;
			var tax_amount1 = sup_price1*0.1;
			var total_price1 = sup_price1+tax_amount1;
			
			var sup_price = sup_price1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			var tax_amount = tax_amount1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			var total_price = total_price1.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

			var after_date = date.split('.');
			
			
			var temp = '<%=temp%>';
			var temp2 ='<%=temp2%>';
			
			//alert(" * 클릭한 Row의 사원명 = "+em_name+item_name);
			//alert("what?"+typeof(sup_price));
			
			if(str==" "){
				alert("아직 출고되지 않은 수주입니다.");
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
			$("input[name=bs_name]").attr('value',"글래스장 "+bs_name);
			$("input[name=month]").attr('value',after_date[1]);
			$("input[name=day]").attr('value',after_date[2]);
			$("input[name=tax_no]").attr('value',tax_no);
			
			$("input[name=cu_code]").attr('value',cb_code);
			  $("input[name=cu_captin]").attr('value',cb_name);
			  $("input[name=cu_addr]").attr('value',c_addr);
			  $("input[name=cu_emp]").attr('value',pe_addr);
			  $("input[name=cu_tel]").attr('value',pe_phone);
			  $("input[name=item_standard]").attr('value',i_stand);
			}
		});
	</script>
	<script type="text/javascript">
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

</body>

</html>
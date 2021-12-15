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
	
	
	Statement ITEMstmt = null;
	ResultSet ITEMrs=null;
	
	
	// 드라이버 및 데이터베이스 설정
	String driver="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
	// 수주 테이블 선택
	String OrdersQuery="select * from orders";
	String ItemNameQuery="select item_name from item";
	
	
	Boolean connect=false;
%>
<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>GLASS 長 - 품목별 수주 현황</title>

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
                
				<div class="container-fluid">

					<!-- 상단바 -->
					<nav class="navbar navbar-dark bg-primary">
						<div class="container-fluid">
							<a class="navbar-brand mb-0 h1" href="#">품목별 수주 현황</a>
						</div>
					</nav>


			<% 
            request.setCharacterEncoding("UTF-8");
            
            String form_item_code = (String)request.getParameter("item_code");
            String form_item_name = (String)request.getParameter("item_name");
            
            String sourcePicker = (String)request.getParameter("source_datepicker_search");
            String destinationPicker = (String)request.getParameter("destination_datepicker_search");
            String yearPicker = (String)request.getParameter("year_picker_search");
            String monthPicker = (String)request.getParameter("month_picker_search");
            
            String form_item_code_value = (form_item_code==null ? "" : form_item_code);
            
            String sourcePicker_value = (sourcePicker==null ? "" : sourcePicker);
            String destinationPicker_value = (destinationPicker==null ? "" : destinationPicker);
            String yearPicker_value = (yearPicker==null ? "" : yearPicker);
            String monthPicker_value = (monthPicker==null ? "" : monthPicker);
            
            %>
	        <!-- 검색창 -->
	        <form action="수주_품목별.jsp" method="POST">
			<div class="row mt-3 ml-1">
			    <div class="col-lg-4">
				    <div class="input-group">
				      <span class="mt-2" style="width:100px">품목코드</span>
				      <div class="input-group-btn m-1">
						 <input type="text" name="item_code" value="<%=form_item_code_value %>" class="form-control-sm ml-2" aria-describedby="basic-addon2">
					  </div><!-- /btn-group -->
				    </div><!-- /input-group -->
				</div><!-- /.col-lg-4 -->
				<div class="col-lg-4">
				    <div class="input-group">
						<span class="mt-2"style="width:90px">품목명</span>
				       <div class="input-group-btn m-1">
						 <select  name="item_name" class="form-control ml-1" style="width: 150px">
										<option value="전체">전체</option>
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
													String i_name = ITEMrs.getString(1);
													String selected = "";
			                                         if(i_name.equals(form_item_name)) {
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
			</div>
                
                <!-- 두번째 줄 -->
                <div class="row mt-2 ml-1">
				    <div class="col-7">
					    <div class="input-group" style="width:900px">
					      <span class="mt-2"style="width:100px">기간</span>
					      <div class="form-group m-1"> 
						      <div class="input-group date mt-1 ml-2"> 
								<input type="text" name="source_datepicker_search" value="<%=sourcePicker_value %>" class="datepicker" style="width:175px" id="order_datepicker_5"> 
						      </div> 
					      </div>
					      <span class="mt-1 ml-3">~</span>
					      <div class="form-group m-1"> 
						      <div class="input-group date mt-1 ml-2"> 
								<input type="text" name="destination_datepicker_search"  value="<%=destinationPicker_value %>" class="datepicker" style="width:175px" id="order_datepicker_6"> 
						      </div> 
					      </div>
					    </div><!-- /input-group -->
					</div><!-- /.col-lg-4 -->
					
					<div class="col-3">
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
					<!-- 확인 버튼 -->
					<div class="col-2"> 
						<button type="submit" style="margin-left:117px;" id="store_lookup_data-submit-button" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm mt-1">확인</button>
					</div>
                </div>
              </form>
              </div>
				
				<!-- Begin Page Content -->
                <div class="container-fluid">

                    
                </div>
                <!-- /.container-fluid -->
				
				
				<!-- 품목별 매출 테이블 -->
				<div class="limiter">
					<div class="container-table100">
						<div class="wrap-table100">
							<div class="table100" style="width:100%; height:450px; overflow:auto">
								<table>
									<thead>
										<tr class="table100-head">
											<th class="order_item1" rowspan="2">No</th>
											<th class="order_item2" rowspan="2">품목<br>코드</th>
											<th class="order_item3" rowspan="2">품목명</th>
											<th class="order_item4" colspan="2">담당자</th>
											<th class="order_item5" rowspan="2">거래처<br>코드</th>
											<th class="order_item6" rowspan="2">거래처명</th>
											<th class="order_item7" rowspan="2">단위</th>
											<th class="order_item8" rowspan="2">수량</th>
											<th class="order_item9" rowspan="2">단가</th>
											<th class="order_item10" rowspan="2">수주<br>금액</th>
											<th class="order_item11" rowspan="2">수주일</th>
											<th class="order_item12" rowspan="2">수주<br>번호</th>
											<th class="order_item13" rowspan="2">비고</th>
										</tr>
										<tr class="table100-head">
											<th class="order_item14">사원번호</th>
											<th class="order_item15">사원명</th>
										</tr>
										
									</thead>
									<tbody>
										<% 
											try{
												Class.forName(driver);
												conn=DriverManager.getConnection(url,"java","java");
												
												connect=true;
												
												/////////////////////////////////////////////////////////////////////////////
										        //검색을 반영한 쿼리 적용
										        OrdersQuery += " where 1=1 AND order_memo !='취소'";
										        if(form_item_code != null && !form_item_code.equals("")) {
										        	OrdersQuery += " and item_code = '" + form_item_code + "'";
										        }
										        if(form_item_name != null && !form_item_name.equals("전체")) {
										        	OrdersQuery += " and item_name = '" + form_item_name + "'";
										        }
										        if(sourcePicker!=null && !sourcePicker.equals("")) {
										        	OrdersQuery += " and order_date >= '" + sourcePicker + "'";
										        }
										        if(destinationPicker!=null && !destinationPicker.equals("")) {
										        	OrdersQuery += " and order_date <= '" + destinationPicker + "'";
										        }
										        if(sourcePicker!=null && sourcePicker.equals("") && destinationPicker!=null && destinationPicker.equals("")) {
										        	if(!yearPicker.equals("0")) {
										        		OrdersQuery += " and year(order_date) = '" + yearPicker + "'";
										        	}
										        	if(!monthPicker.equals("0")) {
										        		OrdersQuery += " and month(order_date) = '" + monthPicker + "'";
										        	}
										        }
										        /////////////////////////////////////////////////////////////////////////////
										        System.out.println(OrdersQuery);

												// statement 생성
												ORDERSstmt = (Statement)conn.createStatement();
												// 쿼리실행하고 결과를 담기
												ORDERSrs = ORDERSstmt.executeQuery(OrdersQuery);
												
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
													String orderpriceDF = df.format(order_price); // 수주금액
												%>
												<tr>
											<td class="li_order_item1"><%=i %></td>
											<td class="li_order_item2"><%=ORDERSrs.getString("item_code")%></td>
											<td class="li_order_item3"><%=ORDERSrs.getString("item_name")%></td>
											<td class="li_order_item14"><%=ORDERSrs.getString("employee_code")%></td>
											<td class="li_order_item15"><%=ORDERSrs.getString("employee_name")%></td>
											<td class="li_order_item5"><%=ORDERSrs.getString("customer_code")%></td>
											<td class="li_order_item6"><%=ORDERSrs.getString("customer_name")%></td></td>
											<td class="li_order_item7"><%=ORDERSrs.getString("item_unit_name")%></td>
											<td class="li_order_item8"><% out.print(orderAmountDF); %></td>
											<td class="li_order_item9"><% out.print(itemUnitPriceDF + "원"); %></td>
											<td class="li_order_item10"><% out.print(orderpriceDF + "원"); %></td>
											<td class="li_order_item11"><%=ORDERSrs.getString("order_date")%></td>
											<td class="li_order_item12"><%=ORDERSrs.getString("order_code")%></td>
											<td class="li_order_item13"><%=ORDERSrs.getString("order_memo")%></td>
										
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
	    $( "#order_datepicker_5, #order_datepicker_6" ).datepicker();
	  } );
	 </script>

</body>

</html>
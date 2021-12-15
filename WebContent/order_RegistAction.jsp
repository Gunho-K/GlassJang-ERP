<%@page import="sun.font.Script"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db_transaction.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
		//현재 날짜 가져오기
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sf_tax = new SimpleDateFormat("yyyyMMdd");
			
		// javascript 출력을 위한 객체
		PrintWriter script = response.getWriter();
		// 사용자가 보낸 데이터를 한글로 사용할 수 있는 형식으로 변환
		request.setCharacterEncoding("UTF-8");
		
		// 넣을 DB 값들
		String employee_code = "";
		String employee_name = "";
		String item_code = "";
		String item_name = "";
		String customer_code = "";
		String customer_name = "";
		String item_unit_name = "";
		int order_amount = 0;
		int item_unit_price = 0;
		String order_date = sf.format(nowTime);
		String order_code = "";
		
		// 업데이트 개수
		int cnt; 
		
		// null이라면
		if(request.getParameter("emp_code_form") == "" ||
				request.getParameter("emp_name_form") == "" ||
				request.getParameter("item_code_form") == "" ||
				request.getParameter("item_name_form") == "" ||
				request.getParameter("customer_code_form") == "" ||
				request.getParameter("customer_name_form") == "" ||
				request.getParameter("item_unit_name_form") == "" ||
				request.getParameter("order_amount_form") == "" ||
				request.getParameter("item_unit_price_form") == "" ||
				request.getParameter("order_date_form") == ""
				//request.getParameter("order_code_form") == ""
	
				){
			script.println("<script>");
			script.println("alert('빠뜨린 값이 없는지 다시 확인해주세요.');");
			script.println("window.self.location = '수주_등록.jsp';");
			script.println("</script>");
		} else { // 정상적으로 값을 넣었다면
			 	// 수주번호
				// 품목명
			employee_code = (String)request.getParameter("emp_code_form");	// 창고명
			employee_name = (String)request.getParameter("emp_name_form");
			item_code = (String)request.getParameter("item_code_form");
			item_name = (String)request.getParameter("item_name_form"); 
			customer_code = (String)request.getParameter("customer_code_form");
			customer_name = (String)request.getParameter("customer_name_form");
			item_unit_name = (String)request.getParameter("item_unit_name_form"); // 단가
			order_amount = Integer.parseInt(request.getParameter("order_amount_form")); 
			item_unit_price = Integer.parseInt(request.getParameter("item_unit_price_form")); 
			order_date = (String)request.getParameter("order_date_form"); // 재고수량

			
			
			Connection conn=null;
			Statement stmt = null;
			ResultSet rs = null;
			String driver="com.mysql.jdbc.Driver";
			String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
			
			//오늘 날짜 중에서 최대값 코드를 검색
			String sql="select max(right(order_code,3)) as maxCode from orders ";
			sql += " where left(order_code,6) = date_format(NOW(), '%y%m%d');";
			
			String max_code = "";
			
			
			//try{
				Class.forName(driver);
				conn=DriverManager.getConnection(url,"java","java");

				stmt = (Statement)conn.createStatement();
				rs = stmt.executeQuery(sql);
				
				if(rs.next()) {
					max_code = rs.getString(1);
				}
				
			//}catch(SQLException ex){
			//	out.println(ex.getMessage());
			//	ex.printStackTrace();
			//}finally{ // 연결 해제
				if(rs!=null)try{
					rs.close();
				}catch(SQLException ex){}
			
				if(stmt!=null)try{
					stmt.close();
				} catch(SQLException ex){}
				
				if(conn!=null)try{
					conn.close();
				}catch(SQLException ex){}
			//}
			
			Date date = new Date();
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyMMdd");
			String strdate = simpleDate.format(date);
			
			if(max_code == null || max_code == "") {
				order_code = strdate + "-001";
			} else {
				int numberCode = Integer.parseInt(max_code);
				numberCode++;
				if(numberCode < 10) {
					order_code = strdate + "-00" + numberCode;
				} else if (numberCode < 100) {
					order_code = strdate + "-0" + numberCode;
				} else {
					order_code = strdate + "-" + numberCode;
				}
			}
			
			
			// DB에 등록
			OrderDAO orderDAO = new OrderDAO();
			cnt = orderDAO.orderRegist(employee_code, employee_name, item_code, item_name, customer_code, customer_name, item_unit_name, order_amount,  item_unit_price, order_date, order_code);
			System.out.println("cnt 111 >>>" + cnt);
			cnt = orderDAO.sellingRegist(employee_code, employee_name, item_code, item_name, customer_code, customer_name, item_unit_name, order_amount, item_unit_price, order_date, order_code);
			System.out.println("cnt 222 >>>" + cnt);
			
			if(cnt != -1){ // DB에 정상 등록 됐다면
				script.println("<script>");
				script.print("alert('수주 ");
				script.print(order_code);
				script.print("가 입력되었습니다.');");
				script.println("</script>");
			} else { // 오류가 있다면
				script.println("<script>");
				script.println("alert('이미 존재하는 수주번호입니다.');");
				script.println("</script>");
			}
			
			// 기존 페이지로 리다이렉션
			script.println("<script>");
			script.println("window.self.location = '수주_등록.jsp';");
			script.println("</script>");
		}
	%>
</body>
</html>
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
		//Integer selling_code=0;
		Integer count=0;
		String item_code="";
		String order_code="";
		String selling_date = sf.format(nowTime);
		String selling_chit_code = "";
		String selling_tax_bill_code = "";
		// 업데이트 개수
		int cnt; 
		
		// null이라면
		if(request.getParameter("selling_item_code_form") == "" ||
				request.getParameter("selling_count_form") == ""||
				request.getParameter("selling_order_code_form") == ""
				//Integer.parseInt(request.getParameter("selling_code_form")) == 0
				){
			script.println("<script>");
			script.println("alert('빠뜨린 값이 없는지 다시 확인해주세요.');");
			script.println("window.self.location = '매출_등록.jsp';");
			script.println("</script>");
		} else { // 정상적으로 값을 넣었다면
// 			selling_date = (String)request.getParameter("selling_date_form"); 	// 매출일
//			selling_code=Integer.parseInt(request.getParameter("selling_code_form"));
			item_code=(String)request.getParameter("selling_item_code_form");
			count=Integer.parseInt(request.getParameter("selling_count_form"));
			order_code=(String)request.getParameter("selling_order_code_form");
			/* if((int)(Math.log10(selling_code)+1)==1){
				selling_chit_code = "PS000"+selling_code; 	// 전표번호
				selling_tax_bill_code =sf_tax.format(nowTime)+"-42000000"+"-0000000"+selling_code ;		// 계산서번호
			}
			else if((int)(Math.log10(selling_code)+1)>1){
				selling_chit_code = "PS00"+selling_code; 	// 전표번호
				selling_tax_bill_code =sf_tax.format(nowTime)+"-42000000"+"-000000"+selling_code ;		// 계산서번호
			} */
			
			Connection conn=null;
			Statement stmt = null;
			ResultSet rs = null;
			Statement stmt2 = null;
			ResultSet rs2 = null;
			String driver="com.mysql.jdbc.Driver";
			String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
			
			//오늘 날짜 중에서 최대값 코드를 검색
			String sql="select max(right(selling_chit_code,4)) as maxCode from selling;";
			String sql2 = " select max(right(selling_tax_bill_code,8)) as maxCode2 from selling where left(selling_tax_bill_code,8) = date_format(NOW(), '%Y%m%d');";
			
			String max_code = "";
			String max_code2 = "";
			
			Class.forName(driver);
			conn=DriverManager.getConnection(url,"java","java");

			stmt = (Statement)conn.createStatement();
			stmt2 = (Statement)conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs2 = stmt2.executeQuery(sql2);
			
			if(rs.next()) {
				max_code = rs.getString(1);
			}
			if(rs2.next()) {
				max_code2 = rs2.getString(1);
			}
			
			
			if(rs!=null)try{
				rs.close();
			}catch(SQLException ex){}
			if(rs2!=null)try{
				rs2.close();
			}catch(SQLException ex){}
		
			if(stmt!=null)try{
				stmt.close();
			} catch(SQLException ex){}
			if(stmt2!=null)try{
				stmt2.close();
			} catch(SQLException ex){}
			
			if(conn!=null)try{
				conn.close();
			}catch(SQLException ex){}
			
			
			if(max_code == null || max_code == "") {
				selling_chit_code = "PS0001";
			} else {
				int numberCode = Integer.parseInt(max_code);
				numberCode++;
				if(numberCode < 10) {
					selling_chit_code = "PS000"+ numberCode;
				} else if (numberCode < 100) {
					selling_chit_code = "PS00"+ numberCode;
				} else if (numberCode < 1000){
					selling_chit_code = "PS0"+ numberCode;
				} else{
					selling_chit_code = "PS"+ numberCode;
				}
			}
			
			if(max_code2 == null || max_code2 == "") {
				selling_tax_bill_code =sf_tax.format(nowTime)+"-42000000"+"-00000001";
			} else {
				int numberCode = Integer.parseInt(max_code2);
				numberCode++;
				if(numberCode < 10) {
					selling_tax_bill_code = sf_tax.format(nowTime)+"-42000000"+"-0000000" + numberCode;
				} else if (numberCode < 100) {
					selling_tax_bill_code = sf_tax.format(nowTime)+"-42000000"+"-000000" + numberCode;
				} else if (numberCode < 1000){
					selling_tax_bill_code = sf_tax.format(nowTime)+"-42000000"+"-00000" + numberCode;
				} else{
					selling_tax_bill_code = sf_tax.format(nowTime)+"-42000000"+"-0000" + numberCode;
				}
			}
				
			
			// DB에 등록
			SellingDAO sellingDAO = new SellingDAO();
			cnt = sellingDAO.sellingRegist(selling_date, selling_chit_code, selling_tax_bill_code,order_code);
			cnt = sellingDAO.stockCancel(count, item_code);
			cnt = sellingDAO.shipping(order_code);
			
			if(cnt != -1){ // DB에 정상 등록 됐다면
				script.println("<script>");
				script.print("alert('매출이 ");
				//script.print(selling_code);
				script.print("등록되었습니다.');");
				script.println("</script>");
			} else { // 오류가 있다면
				script.println("<script>");
				script.println("alert('DB에 등록이 되지 않았습니다. 입력 값을 다시 확인해보세요.');");
				script.println("</script>");
			}
			
			// 기존 페이지로 리다이렉션
			script.println("<script>");
			script.println("window.self.location = '매출_등록.jsp';");
			script.println("</script>");
		}
	%>
</body>
</html>
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
	
		Date nowTime = new Date();
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
		Integer selling_count = 0;
		String item_unit_name = "";
		Integer item_unit_price = 0;
		String order_date = "";
		String order_code = "";
		String selling_date = "";
		String selling_chit_code = "";
		String selling_tax_bill_code = "";
		String selling_memo = "반품";
		Integer r14 =0 ;
		
		String stock_storage_name = "본사 창고";
		Integer bad_stock_amount = 0;
		String bad_stock_return_date ="";
		String bad_stock_result = "";
		String bad_stock_memo = "";

		// 업데이트 개수
		int cnt;
		
		// null이라면
		if(request.getParameter("r1") == "" ||
				request.getParameter("r2") == "" ||
				request.getParameter("r3") == "" ||
				request.getParameter("r4") == "" ||
				request.getParameter("r5") == "" ||
				request.getParameter("r6") == "" ||
				request.getParameter("r7") == "" ||
				request.getParameter("r8") == "" ||
				request.getParameter("r9") == "" ||
				request.getParameter("r10") == "" ||
				request.getParameter("r11") == "" ||
				request.getParameter("r12") == "" ||
				request.getParameter("r13") == "" ||
				request.getParameter("r14") == "" ||
				request.getParameter("r15") == "" 
				){
			script.println("<script>");
			script.println("alert('빠뜨린 값이 없는지 다시 확인해주세요.');");
			script.println("window.self.location = '매출_등록.jsp';");
			script.println("</script>");
		} else { // 정상적으로 값을 넣었다면
			employee_code = (String)request.getParameter("r4");
			employee_name = (String)request.getParameter("r5");
			item_code = (String)request.getParameter("r7");
			item_name = (String)request.getParameter("r8");
			customer_code = (String)request.getParameter("r15");
			customer_name = (String)request.getParameter("r6");
			selling_count = Integer.parseInt(request.getParameter("r11"));
			item_unit_name = (String)request.getParameter("r9");
			item_unit_price = Integer.parseInt(request.getParameter("r12"));
			order_date = (String)request.getParameter("r3");
			order_code = (String)request.getParameter("r2");
			selling_date = (String)request.getParameter("r10");
			selling_chit_code = (String)request.getParameter("r1");
			r14 = Integer.parseInt(request.getParameter("r14"));
			/* if((int)(Math.log10(r14)+1)==1){
				selling_tax_bill_code =sf_tax.format(nowTime)+"-42000000"+"-1000000"+r14 ;		// 계산서번호
			}
			else if((int)(Math.log10(r14)+1)>1){
				selling_tax_bill_code =sf_tax.format(nowTime)+"-42000000"+"-100000"+r14 ;		// 계산서번호
			} */
			
			bad_stock_amount = Integer.parseInt(request.getParameter("r11"));
			bad_stock_return_date = (String)request.getParameter("r10");
			
			Connection conn=null;
			Statement stmt2 = null;
			ResultSet rs2 = null;
			String driver="com.mysql.jdbc.Driver";
			String url="jdbc:mysql://121.172.132.48:3306/glassjang?autoReconnect=true";
			
			//오늘 날짜 중에서 최대값 코드를 검색
			String sql2 = " select max(right(selling_tax_bill_code,8)) as maxCode2 from selling where left(selling_tax_bill_code,8) = date_format(NOW(), '%Y%m%d');";
			
			String max_code2 = "";
			
			Class.forName(driver);
			conn=DriverManager.getConnection(url,"java","java");

			stmt2 = (Statement)conn.createStatement();
			rs2 = stmt2.executeQuery(sql2);
			

			if(rs2.next()) {
				max_code2 = rs2.getString(1);
			}

			if(rs2!=null)try{
				rs2.close();
			}catch(SQLException ex){}
		
			if(stmt2!=null)try{
				stmt2.close();
			} catch(SQLException ex){}
			
			if(conn!=null)try{
				conn.close();
			}catch(SQLException ex){}
			
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
			cnt = sellingDAO.returnRegist(employee_code,employee_name,item_code,item_name,customer_code,customer_name,selling_count,item_unit_name,item_unit_price,order_date,order_code,selling_date,selling_chit_code,selling_tax_bill_code,selling_memo);
			cnt = sellingDAO.badRegist(item_code, item_name, order_date, stock_storage_name, item_unit_name, bad_stock_amount, item_unit_price, bad_stock_return_date, bad_stock_result, bad_stock_memo);
			
			if(cnt != -1){ // DB에 정상 등록 됐다면
				script.println("<script>");
				script.print("alert(' ");
				script.print(selling_memo);
				script.print("이 등록되었습니다.');");
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
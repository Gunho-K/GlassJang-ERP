<%@page import="sun.font.Script"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db_transaction.*" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		// javascript 출력을 위한 객체
		PrintWriter script = response.getWriter();
		// 사용자가 보낸 데이터를 한글로 사용할 수 있는 형식으로 변환
		request.setCharacterEncoding("UTF-8");
		
		// 넣을 DB 값들
		String order_memo = "";
		String order_code="";
		String selling_memo="";
		// 업데이트 개수
		int cnt; 
		
		// null이라면
		if(request.getParameter("order_memo") == "" ||
		request.getParameter("selling_memo") == "" ||
		request.getParameter("order_code_form") == ""){
	
		script.println("<script>");
		script.println("alert('수주를 선택해주세요.');");
		script.println("window.self.location = '수주_등록.jsp';");
		script.println("</script>");
		
		} else {
			order_code = (String)request.getParameter("order_code_form");
			order_memo = "취소";
			selling_memo="취소";
		}
				
		// DB에 등록
					OrderDAO orderDAO = new OrderDAO();
					cnt = orderDAO.orderCancel(order_memo, order_code);
					System.out.println("cnt 111 >>>" + cnt);
					cnt = orderDAO.sellingCancel(selling_memo, order_code);
					System.out.println("cnt 222 >>>" + cnt);
					
					if(cnt != -1){ // DB에 정상 등록 됐다면
						script.println("<script>");
						script.print("alert('수주 ");
						script.print(order_code);
						script.print("가 취소되었습니다.');");
						script.println("</script>");
					} else { // 오류가 있다면
						script.println("<script>");
						script.println("alert('수주가 취소되지 않았습니다. 다시 한번 시도해보세요.');");
						script.println("</script>");
					}
					
					// 기존 페이지로 리다이렉션
					script.println("<script>");
					script.println("window.self.location = '수주_등록.jsp';");
					script.println("</script>");
				
				%>
</body>
</html>
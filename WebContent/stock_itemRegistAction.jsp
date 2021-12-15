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
		String item_code = "";
		String item_name = "";
		String item_standard = "";
		String item_unit_name = "";
		int item_unit_price = 0;
		int item_original_price = 0;
		// 업데이트 개수
		int cnt; 
		
		// null이라면
		if(request.getParameter("item_code_form") == "" ||
				request.getParameter("item_name_form") == "" ||
				request.getParameter("item_unit_name_form") == "" ||
				request.getParameter("item_unit_price_form") == "" ||
				request.getParameter("item_original_price_form") == ""
				){
			script.println("<script>");
			script.println("alert('빠뜨린 값이 없는지 다시 확인해주세요.');");
			script.println("window.self.location = '재고_품목등록.jsp';");
			script.println("</script>");
		} else { // 정상적으로 값을 넣었다면
			item_code = (String)request.getParameter("item_code_form"); 	// 품목코드
			item_name = (String)request.getParameter("item_name_form"); 	// 품목명
			item_standard = (String)request.getParameter("item_standard_form");		// 규격
			item_unit_name = (String)request.getParameter("item_unit_name_form"); 	// 단위
			item_unit_price = changeNum((String)request.getParameter("item_unit_price_form")); 	// 단가
			item_original_price = changeNum((String)request.getParameter("item_original_price_form")); // 원가
			
			// DB에 등록
			StockDAO stockDAO = new StockDAO();
			cnt = stockDAO.itemRegist(item_code, item_name, item_standard, item_unit_name, item_unit_price, item_original_price);
			
			
			if(cnt != -1){ // DB에 정상 등록 됐다면
				script.println("<script>");
				script.print("alert('품목코드 ");
				script.print(item_code);
				script.print("가 입력되었습니다.');");
				script.println("</script>");
			} else { // 오류가 있다면
				script.println("<script>");
				script.println("alert('DB에 등록이 되지 않았습니다. 입력 값을 다시 확인해보세요.');");
				script.println("</script>");
			}
			
			// 기존 페이지로 리다이렉션
			script.println("<script>");
			script.println("window.self.location = '재고_품목등록.jsp';");
			script.println("</script>");
		}
	%>
	<%!
		// 문자열을 숫자로 바꿔주는 메소드
		int changeNum(String buf){
			String str = buf.replaceAll("[^0-9]", "");
			
			return Integer.parseInt(str);
		}
	%>
</body>
</html>
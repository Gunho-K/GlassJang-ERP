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
		
		// 전달된 값들, e.g. 처리결과, 불량재고코드
		String badStockResult = "";
		int badNo = 0;
		// 알림을 위한 수정 전 처리결과
		String defaultResult="";
		// 업데이트 개수
		int cnt; 
		
		// null이라면
		if(request.getParameter("bad_no_form") == ""){
			script.println("<script>");
			script.println("alert('빠뜨린 값이 없는지 다시 확인해주세요.');");
			script.println("window.self.location = '재고_관리.jsp';");
			script.println("</script>");
		} else { // 정상적으로 값을 넣었다면
			badNo = Integer.parseInt(request.getParameter("bad_no_form")); // 불량 재고 코드
			badStockResult = (String)request.getParameter("bad_stock_result_form"); // 처리 결과
			// 기본 값 알림을 위해 설정
			defaultResult = request.getParameter("bad_stock_result_hidden");
			
			// DB에 등록
			StockDAO stockDAO = new StockDAO();
			cnt = stockDAO.badStockRegist(badNo,badStockResult);
			
			// DB 등록 알림창
			try {
				if(cnt != -1){ // DB에 정상 등록 됐다면
					script.println("<script>");
					script.print("alert('불량재고 코드 ");
					script.print(badNo);
					script.print("의 처리결과가 ");
					script.print(badStockResult);
					script.print("로 등록되었습니다. ");
					script.println("')");
					script.println("</script>");
				} else { // 오류가 있다면
					script.println("<script>");
					script.println("alert('DB에 등록이 되지 않았습니다. 입력 값을 다시 확인해보세요.');");
					script.println("</script>");
				}
			}
			catch(Exception e){
				System.out.println("DB 등록 알림창 예외 발생 -> " + e);
			}
				
			
			
			// 기존 페이지로 리다이렉션
			script.println("<script>");
			script.println("window.self.location = '재고_불량.jsp';");
			script.println("</script>");
		}
	%>
</body>
</html>
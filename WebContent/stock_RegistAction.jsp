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
		
		// 전달된 값들, e.g. 품목코드, 재고수량
		String item_code = "";
		int stock_amount = 0;
		// 알림을 위한 수정 전 재고 수량, 등록된 재고 수
		int defaultAmount=0;
		int updateAmount=0;
		// 업데이트 개수
		int cnt; 
		
		// null이라면
		if(request.getParameter("stock_amount_form") == ""){
			script.println("<script>");
			script.println("alert('빠뜨린 값이 없는지 다시 확인해주세요.');");
			script.println("window.self.location = '재고_관리.jsp';");
			script.println("</script>");
		} else { // 정상적으로 값을 넣었다면
			item_code = (String)request.getParameter("item_code_form"); // 품목코드
			stock_amount = Integer.parseInt(request.getParameter("stock_amount_form")); // 재고수량
			// 기본 값 알림을 위해 설정
			defaultAmount = Integer.parseInt(request.getParameter("stock_amount_hidden"));
			
			
			// DB에 등록
			StockDAO stockDAO = new StockDAO();
			cnt = stockDAO.stockRegist(item_code,stock_amount);
			
			// DB 등록 후 변경된 값 알림
			updateAmount = stock_amount-defaultAmount;
			
			// DB 등록 알림창
			try {
				if(cnt != -1){ // DB에 정상 등록 됐다면
					script.println("<script>");
					//script.println("alert('품목코드 " + item_code + "의 수량이" + defaultAmount + "개에서 " + stock_amount + "개로 " + updateAmount + "개가 등록되었습니다.");
					script.print("alert('품목코드 ");
					script.print(item_code);
					script.print("의 수량이 ");
					script.print(defaultAmount);
					script.print("개에서 ");
					script.print(stock_amount);
					script.print("개로 ");
					script.print(updateAmount);
					script.print("개가 등록되었습니다.");
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
			script.println("window.self.location = '재고_관리.jsp';");
			script.println("</script>");
		}
	%>
</body>
</html>
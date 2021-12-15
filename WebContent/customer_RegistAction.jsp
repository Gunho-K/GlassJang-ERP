<%@page import="sun.font.Script"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db_transaction.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

	<%
			//현재 날짜 가져오기
			Date today = new Date();
	    	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	   		String todayresult = df.format(today);
			
			// javascript 출력을 위한 객체
			PrintWriter script = response.getWriter();
			// 사용자가 보낸 데이터를 한글로 사용할 수 있는 형식으로 변환
			request.setCharacterEncoding("UTF-8");
			
			// 넣을 DB 값들
			String customer_sales_category  = "";
			String customer_address = "";
			String customer_name = "";
			String customer_businessman_name = "";
			String customer_business_code = "";
			String customer_type = "";
			String customer_memo = "";
			String customer_business_man_phone = "";
			
			Integer customer_no = 0;									//Integer selling_code=0;
			String customer_code = "";									//String selling_chit_code = "";
			String customer_first_registration1 = "";					
			
			String customer_wheter_new = "";
			
			
			String part_employee_name = "";
			String part_employee_code = "";
			String part_employee_phone = "";
			
			// 업데이트 개수
			int cnt; 
			
			// null이라면
			if(request.getParameter("customer_sales_category") == "" ||
				request.getParameter("customer_address") == "" ||
				request.getParameter("account_name") == "" ||
				request.getParameter("customer_businessman_name") == "" ||
				request.getParameter("customer_business_code") == "" ||
				request.getParameter("customer_type") == "" ||
				request.getParameter("customer_business_man_phone") == "" ||
				request.getParameter("customer_code") == "" ||
				request.getParameter("customer_wheter_new") == "" ||
				request.getParameter("customer_first_registration") =="" ||
				request.getParameter("part_employee_name") == "" ||
				request.getParameter("part_employee_code") == "" ||
				request.getParameter("customer_code_form") == "" ||
				request.getParameter("part_employee_phone") == "" 
				)
			{
		script.println("<script>");
		script.println("alert('빠뜨린 값이 없는지 다시 확인해주세요.');");
		script.println("window.self.location = '거래처_등록.jsp';");
		script.println("</script>");
			} else { // 정상적으로 값을 넣었다면
				customer_sales_category  = (String)request.getParameter("customer_sales_category"); 	        	// 판매구분
				customer_address = (String)request.getParameter("customer_address"); 								// 주소
				customer_name = (String)request.getParameter("customer_name");										// 상호명
				customer_businessman_name  = (String)request.getParameter("customer_businessman_name"); 			// 대표자
				customer_business_code  = (String)request.getParameter("customer_business_code"); 					// 사업자등록번호
				customer_type  = (String)request.getParameter("customer_type"); 									// 업태
				customer_business_man_phone  = (String)request.getParameter("customer_business_man_phone");			// 거래처 연락처
				customer_memo = (String)request.getParameter("customer_memo"); 										// 비고 
				customer_first_registration1 = (String)request.getParameter("customer_first_registration");			// 최초 등록일
				customer_no = Integer.parseInt(request.getParameter("customer_code_form"));
				
				try{
					
				}catch(Exception e){
					System.out.println("에러메세지:" + e.getMessage()); 
					e.printStackTrace(); //예외정보 출력
				}
				
				String A;
				if(customer_address.contains("서울") ) { A = "A"; } else
					  if(customer_address.contains("인천")) { A = "B"; } else
					  if(customer_address.contains("경기도")) { A = "C"; } else
					  if(customer_address.contains("충청북도")) { A = "D"; } else
					  if(customer_address.contains("충청남도")) { A = "E"; } else
					  if(customer_address.contains("전라북도")) { A = "F"; } else
					  if(customer_address.contains("전라남도")) { A = "G"; } else
					  if(customer_address.contains("경상북도")) { A = "H"; } else
					  if(customer_address.contains("경상남도")) { A = "I"; } else
					  if(customer_address.contains("제주도")) { A = "J"; } else A = "지역오류";
				
				String B = customer_first_registration1.substring(5,7) + customer_first_registration1.substring(8,10); 
				
				if((int)(Math.log10(customer_no)+1)==1){
					customer_code = B + A + "000" + customer_no; 	// 거래처코드
				}
				else if((int)(Math.log10(customer_no)+1)>1){
					customer_code = B + A + "00" + customer_no; 	// 거래처코드
				}												
				
				
				customer_wheter_new = (String)request.getParameter("customer_wheter_new");							// 신규기존 분류
				if(Integer.parseInt(customer_first_registration1.replace(".","")) >= Integer.parseInt(todayresult)){
					customer_wheter_new = "신규";
				}else if(Integer.parseInt(customer_first_registration1.replace(".","")) < Integer.parseInt(todayresult)){
					customer_wheter_new = "기존";
				}else{System.out.print("숫자오류");}
				
				part_employee_name  = (String)request.getParameter("part_employee_name"); 							// 사원명
				part_employee_code = (String)request.getParameter("part_employee_code"); 							// 사원번호
				part_employee_phone = (String)request.getParameter("part_employee_phone"); 							// 사원 연락처 
		
		
		// DB에 등록
		CustomerDAO customerDAO = new CustomerDAO();
		cnt = customerDAO.customerRegist(customer_sales_category, customer_address, customer_name, customer_businessman_name, customer_business_code, customer_type, customer_memo, customer_business_man_phone, customer_code, customer_first_registration1, customer_wheter_new, part_employee_name, part_employee_code, part_employee_phone);
		
		if(cnt != -1){ // DB에 정상 등록 됐다면
			script.println("<script>");
			script.print("alert('거래처 ");
			script.print(customer_name);
			script.print("이 등록되었습니다.');");
			script.println("</script>");
		} else { // 오류가 있다면
			script.println("<script>");
			script.print("alert('입력한 ");
			script.print(customer_name);
			script.println("이 DB에 등록이 되지 않았습니다. 입력 값을 다시 확인해보세요.');");
			script.println("</script>");
		}
		
		script.println("<script>");
		script.println("window.self.location = '거래처_등록.jsp';");
		script.println("</script>");
			}
	%>
</body>
</html>
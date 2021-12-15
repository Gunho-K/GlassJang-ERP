package db_transaction;

import java.io.Console;
import java.sql.*;

public class CustomerDAO {
	Connection conn = ConnectionPool.getConnection();
	
	public int customerRegist(String customer_sales_category, String customer_address, String customer_name, String customer_businessman_name, String customer_business_code, String customer_type, String customer_memo,  String customer_business_man_phone, String customer_code, String customer_first_registration, String customer_wheter_new, String part_employee_name, String part_employee_code, String part_employee_phone ) {
		// 판매구분, 주소, 상호명, 대표자, 사업자등록번호, 업태, 비고, 거래처 연락처
		String SQL = "INSERT INTO customer(customer_sales_category,customer_address,customer_name,customer_businessman_name,customer_business_code,customer_type,customer_memo,customer_business_man_phone,customer_code, customer_first_registration, customer_wheter_new, part_employee_name,part_employee_code,part_employee_phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			// 각각의 데이터를 실제로 넣음
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			
			pstmt.setString(1, customer_sales_category); 				// 판매구분
			pstmt.setString(2, customer_address); 						// 주소
			pstmt.setString(3, customer_name); 							// 상호명
			pstmt.setString(4, customer_businessman_name);				// 대표자
			pstmt.setString(5, customer_business_code); 				// 사업자등록번호
			pstmt.setString(6, customer_type); 							// 업태
			pstmt.setString(7, customer_memo);							// 비고
			pstmt.setString(8, customer_business_man_phone);			// 거래처 연락처
			pstmt.setString(9, customer_code);  									// ★ 거래처 코드
			pstmt.setString(10, customer_first_registration);			// 최초 등록일
			pstmt.setNString(11, customer_wheter_new);
			pstmt.setString(12, part_employee_name);					// 담당사원명
			pstmt.setString(13, part_employee_code);					// 담당사원번호
			pstmt.setString(14, part_employee_phone);					// 담당사원 연락처
			
			
			return pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("customer_sales_category : " + customer_sales_category + "\n");
			System.out.println("customer_address : " + customer_address + "\n");
			System.out.println("customer_name : " + customer_name + "\n");
			System.out.println("customer_businessman_name : " + customer_businessman_name + "\n");
			System.out.println("customer_business_code : " + customer_business_code + "\n");
			System.out.println("customer_type : " + customer_type + "\n");
			System.out.println("customer_memo : " + customer_memo + "\n");
			System.out.println("customer_business_man_phone : " + customer_business_man_phone + "\n");
			System.out.println("customer_first_registration : " + customer_first_registration + "\n");
			System.out.println("customer_wheter_new : " + customer_wheter_new + "\n");
			System.out.println("part_employee_name : " + part_employee_name + "\n");
			System.out.println("part_employee_code : " + part_employee_code + "\n");
			System.out.println("part_employee_phone : " + part_employee_phone + "\n");
			e.printStackTrace();
		}
		
		
	return -1;
	}
	
	
	/*
	 * public int employeeRegist(String employee_name, String employee_code, String
	 * employee_phone) { // 담당사원, 사원번호, 사원 연락처 String SQL2 =
	 * "INSERT INTO employee VALUES (?, ?, ?)"; try { // 각각의 데이터를 실제로 넣음
	 * PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
	 * 
	 * pstmt2.setString(1, employee_name); // 담당자 pstmt2.setString(2,
	 * employee_code); // 사원번호 pstmt2.setString(3, employee_phone); // 사원 연락처
	 * 
	 * 
	 * // 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수 return pstmt2.executeUpdate();
	 * }catch (Exception e) { e.printStackTrace(); }
	 * 
	 * return -1; }
	 */
	 
	
	
}



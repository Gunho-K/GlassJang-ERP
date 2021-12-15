package db_transaction;
import java.sql.*;

public class OrderDAO {
	Connection conn = ConnectionPool.getConnection();
	
	// 수주등록
		public int orderRegist(String employee_code, String employee_name, String item_code, String item_name, String customer_code, String customer_name, String item_unit_name, int order_amount, int item_unit_price, String order_date, String order_code) {
			//conn.setAutoCommit(false);
			
			//conn.commit();
			
			//conn.rollback();

			// 수주번호, 수주일, 담당사원번호, 담당사원명, 거래처코드, 거래처명, 품목코드, 품목명, 수량, 단가
			String SQL = "INSERT INTO orders (employee_code, employee_name, item_code, item_name, customer_code, customer_name, item_unit_name, order_amount, item_unit_price, order_date, order_code) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
			try {
				// 각각의 데이터를 실제로 넣음
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, employee_code); // 수주번호
				pstmt.setString(2, employee_name); // 수주일
				pstmt.setString(3, item_code); // 담당사원번호
				pstmt.setString(4, item_name); // 담당사원명
				pstmt.setString(5, customer_code); // 거래처코드
				pstmt.setString(6, customer_name); // 거래처명
				pstmt.setString(7, item_unit_name); // 품목코드
				pstmt.setInt(8, order_amount); // 품목명
				pstmt.setInt(9, item_unit_price); // 단위
				pstmt.setString(10, order_date); // 수량
				pstmt.setString(11, order_code); // 단가
				//pstmt.setInt(10, order_price); // 수주금액
				
				// 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
				return pstmt.executeUpdate();
			}catch (Exception e) {
				
				System.out.println("employee_code : " + employee_code + "\n");
				System.out.println("employee_name : " + employee_name + "\n");
				System.out.println("item_code : " + item_code + "\n");
				System.out.println("item_name : " + item_name + "\n");
				System.out.println("customer_code : " + customer_code + "\n");
				System.out.println("customer_name : " + customer_name + "\n");
				System.out.println("item_unit_name : " + item_unit_name + "\n");
				System.out.println("order_amount : " + order_amount + "\n");
				System.out.println("item_unit_price : " + item_unit_price + "\n");
				System.out.println("order_date : " + order_date + "\n");
				System.out.println("order_code : " + order_code + "\n");
				e.printStackTrace();
			}
			
			return -1;
		}
		// 매출등록
				public int sellingRegist(String employee_code, String employee_name, String item_code, String item_name, String customer_code, String customer_name, String item_unit_name, int order_amount, int item_unit_price, String order_date, String order_code) {

					// 수주번호, 수주일, 담당사원번호, 담당사원명, 거래처코드, 거래처명, 품목코드, 품목명, 수량, 단가
					String SQL = "INSERT INTO selling ( employee_code, employee_name, item_code, item_name, customer_code, customer_name, selling_count, item_unit_name, item_unit_price, order_date, order_code) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
					try {
						// 각각의 데이터를 실제로 넣음
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						pstmt.setString(1, employee_code); // 수주번호
						pstmt.setString(2, employee_name); // 수주일
						pstmt.setString(3, item_code); // 담당사원번호
						pstmt.setString(4, item_name); // 담당사원명
						pstmt.setString(5, customer_code); // 거래처코드
						pstmt.setString(6, customer_name); // 거래처명
						pstmt.setInt(7, order_amount); // selling_count
						pstmt.setString(8, item_unit_name); // 품목명
						pstmt.setInt(9, item_unit_price); // 단위
						pstmt.setString(10, order_date); // 수량
						pstmt.setString(11, order_code); // 단가
						//pstmt.setInt(10, order_price); // 수주금액
						
						// 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
						return pstmt.executeUpdate();
					}catch (Exception e) {
						
						System.out.println("employee_code : " + employee_code + "\n");
						System.out.println("employee_name : " + employee_name + "\n");
						System.out.println("item_code : " + item_code + "\n");
						System.out.println("item_name : " + item_name + "\n");
						System.out.println("customer_code : " + customer_code + "\n");
						System.out.println("customer_name : " + customer_name + "\n");
						System.out.println("item_unit_name : " + item_unit_name + "\n");
						System.out.println("order_amount : " + order_amount + "\n");
						System.out.println("item_unit_price : " + item_unit_price + "\n");
						System.out.println("order_date : " + order_date + "\n");
						System.out.println("order_code : " + order_code + "\n");
						e.printStackTrace();
					}
					
					return -1;
				}
		
		// 등록취소
				public int orderCancel(String order_memo, String order_code) {

					// 메모
					String SQL = "UPDATE orders SET order_memo=? WHERE order_code=?";
					try {
						// 각각의 데이터를 실제로 넣음
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						
						pstmt.setString(1, order_memo);
						pstmt.setString(2, order_code); // 수주메모
						

						
						// 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
						return pstmt.executeUpdate();
					}catch (Exception e) {
						
						System.out.println("order_memo : " + order_memo + "\n");

						e.printStackTrace();
					}
					
					return -1;
				}
				// 매출취소
				public int sellingCancel(String selling_memo, String order_code) {

					// 메모
					String SQL = "UPDATE selling SET selling_memo=? WHERE order_code=? ";
					try {
						// 각각의 데이터를 실제로 넣음
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						
						pstmt.setString(1, selling_memo);
						pstmt.setString(2, order_code); // 수주메모
						//pstmt.setString(3, order_code_form);
						

						
						// 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
						return pstmt.executeUpdate();
					}catch (Exception e) {
						
						System.out.println("selling_memo : " + selling_memo + "\n");

						e.printStackTrace();
					}
					
					return -1;
				}
				
				

}

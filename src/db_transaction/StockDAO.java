package db_transaction;

import java.sql.*;

public class StockDAO {
	Connection conn = ConnectionPool.getConnection();
	
	// 품목등록
	public int itemRegist(String item_code, String item_name, String item_standard, String item_unit_name, int item_unit_price, int item_original_price) {
		// 품목코드, 품목명, 규격, 단위, 단가, 원가
		
		String SQL = "INSERT INTO item VALUES (?, ?, ?, ?, ?, ?)";
		try {
			// item table에 데이터 등록
			// pstmt 생성
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// 값 지정
			pstmt.setString(1, item_code); // 품목코드
			pstmt.setString(2, item_name); // 품목명
			pstmt.setString(3, item_standard); // 규격
			pstmt.setString(4, item_unit_name); // 단위
			pstmt.setInt(5, item_unit_price); // 단가
			pstmt.setInt(6, item_original_price); // 원가

			
			// stock table에 재고 0개로 등록
			// SQL 문
			String SQL2 = "INSERT INTO stock VALUES (?, ?, ?, ?, ?, ?, ?)";
			// pstmt 생성
			PreparedStatement stockRegistPstmt = conn.prepareStatement(SQL2);
			// 값 지정
			stockRegistPstmt.setString(1, item_code); // item_code
			stockRegistPstmt.setString(2, item_name); // item_name
			stockRegistPstmt.setString(3, "본사 창고"); // stock_storage_name
			stockRegistPstmt.setString(4, item_unit_name); // item_unit_name
			stockRegistPstmt.setInt(5, 0); // stock_amount
			stockRegistPstmt.setInt(6, item_unit_price); // item_unit_price
			stockRegistPstmt.setString(7, ""); // stock_memo
			
			
			// 실행
			pstmt.executeUpdate();
			stockRegistPstmt.executeUpdate();
			
			return 1;
		}catch (Exception e) {
			System.out.println("itemRegist에 예외가 발생했습니다. -> " + e);
			e.printStackTrace();
		}
		
		return -1;
	}
	
	// 품목 수정
	public int itemEdit(String item_code, String item_name, String item_standard, String item_unit_name, int item_unit_price, int item_original_price) {

		// 품목코드, 품목명, 규격, 단위, 단가, 원가
		String SQL = "UPDATE item SET item_name=?, item_standard=?, item_unit_name=?, item_unit_price=?, item_original_price=? where item_code = ?";
		try {
			// item table
			// 각각의 데이터를 실제로 넣음
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// 값 지정
			pstmt.setString(1, item_name); // 품목명
			pstmt.setString(2, item_standard); // 규격
			pstmt.setString(3, item_unit_name); // 단위
			pstmt.setInt(4, item_unit_price); // 단가
			pstmt.setInt(5, item_original_price); // 원가
			pstmt.setString(6, item_code); // 품목코드
			
			
			// stock table 업데이트
			String SQL2 = "UPDATE stock SET item_name=?, item_unit_name=?, item_unit_price=? where item_code = ?";
			// pstmt 생성
			PreparedStatement stockUpdatePstmt = conn.prepareStatement(SQL2);
			// 값 지정
			stockUpdatePstmt.setString(1, item_name);
			stockUpdatePstmt.setString(2, item_unit_name);
			stockUpdatePstmt.setInt(3, item_unit_price);
			stockUpdatePstmt.setString(4, item_code);
			
			
			/*// bad_stock table 업데이트
			SQL = "UPDATE bad_stock SET item_name=?, item_unit_name=?, item_unit_price=? where item_code = ?";
			PreparedStatement badStockUpdatePstmt = conn.prepareStatement(SQL);
			// 값 지정
			badStockUpdatePstmt.setString(1, item_name);
			badStockUpdatePstmt.setString(2, item_unit_name);
			badStockUpdatePstmt.setInt(3, item_unit_price);
			badStockUpdatePstmt.setString(4, item_code);
			// 실행
			badStockUpdatePstmt.executeUpdate();
			
			
			// orders table 업데이트
			SQL = "UPDATE orders SET item_name=?, item_unit_name=?, item_unit_price=? where item_code = ?";
			PreparedStatement ordersUpdatePstmt = conn.prepareStatement(SQL);
			// 값 지정
			ordersUpdatePstmt.setString(1, item_name);
			ordersUpdatePstmt.setString(2, item_unit_name);
			ordersUpdatePstmt.setInt(3, item_unit_price);
			ordersUpdatePstmt.setString(4, item_code);
			// 실행
			ordersUpdatePstmt.executeUpdate();
			
			
			// selling table 업데이트
			SQL = "UPDATE selling SET item_name=? where item_code = ?";
			PreparedStatement sellingUpdatePstmt = conn.prepareStatement(SQL);
			// 값 지정
			sellingUpdatePstmt.setString(1, item_name);
			sellingUpdatePstmt.setString(2, item_code);
			// 실행
			sellingUpdatePstmt.executeUpdate();*/
			
			// 실행
			pstmt.executeUpdate();
			stockUpdatePstmt.executeUpdate();
			
			return 1;
		}catch (Exception e) {
			System.out.println("itemEdit에 예외가 발생했습니다. -> " + e);
			e.printStackTrace();
		}
		
		return -1;
	}
	
	// 재고등록
	public int stockRegist(String item_code, int stock_amount) {
		// item_code, item_name, stock_storage_name, item_unit_name, stock_amount, item_unit_price, stock_memo
		// 품목코드, 품목명, 창고명, 단위, 재고수량, 단가, 메모
		
		// 사용되는 SQL문
		String SQL = "UPDATE stock SET stock_amount=? where item_code=?";
		
		try {
			// 각각의 데이터를 실제로 넣음
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			// 적용
			pstmt.setInt(1, stock_amount); // 재고수량
			pstmt.setString(2, item_code); // 품목코드
			
			// 확인용 출력
			//System.out.println("stock_amount는 : " + stock_amount);
			//System.out.println("item_code는 : " + item_code);
			
			
			// 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
			return pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("stockRegist에 예외가 발생했습니다. -> " + e);
			e.printStackTrace();
		}
		return -1;
	}
	
	// 불량 재고 등록
	public int badStockRegist(int bad_no, String bad_stock_result) {
		
		// 사용되는 SQL문
		String SQL = "UPDATE bad_stock SET bad_stock_result=? where bad_no=?";
		
		try {
			// 각각의 데이터를 실제로 넣음
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			// 파라미터 적용
			pstmt.setString(1, bad_stock_result); // 처리결과
			pstmt.setInt(2, bad_no); // 불량 넘버
			
			// 확인용 출력
			//System.out.println("bad_no는 : " + bad_no);
			//System.out.println("bad_stock_result는 : " + bad_stock_result);
			
			// 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
			return pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("badStockRegist에 예외가 발생했습니다. -> " + e);
			e.printStackTrace();
		}
		return -1;
	}
}

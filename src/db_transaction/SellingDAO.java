package db_transaction;

import java.sql.*;

public class SellingDAO {
   Connection conn = ConnectionPool.getConnection();
   
   // 매출등록
   public int sellingRegist(String selling_date, String selling_chit_code, String selling_tax_bill_code,String order_code) {

      // 매출일,전표번호,계산서번호
      String SQL = "UPDATE selling SET selling_date=?, selling_chit_code=?,selling_tax_bill_code=? WHERE order_code=?";
      try {
         // 각각의 데이터를 실제로 넣음
         PreparedStatement pstmt = conn.prepareStatement(SQL);
         
         pstmt.setString(1, selling_date); // 매출일
         pstmt.setString(2, selling_chit_code); // 전표번호
         pstmt.setString(3, selling_tax_bill_code); // 계산서번호
         pstmt.setString(4,order_code); // 수주번호

         
         // 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
         return pstmt.executeUpdate();
      }catch (Exception e) {
         e.printStackTrace();
      }
      
      return -1;
   }
   
   // 반품등록 - 매출
      public int returnRegist(String employee_code, String employee_name, String item_code,String item_name,String customer_code,String customer_name,Integer selling_count,String item_unit_name,Integer item_unit_price,String order_date,String order_code,String selling_date,String selling_chit_code,String selling_tax_bill_code, String selling_memo) {

         // 
         String SQL = "INSERT INTO selling VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
         try {
            // 각각의 데이터를 실제로 넣음
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            
            pstmt.setString(1, employee_code);
            pstmt.setString(2, employee_name);
            pstmt.setString(3, item_code);
            pstmt.setString(4, item_name);
            pstmt.setString(5, customer_code);
            pstmt.setString(6, customer_name);
            pstmt.setInt(7, selling_count);
            pstmt.setString(8, item_unit_name);
            pstmt.setInt(9, item_unit_price);
            pstmt.setString(10, order_date);
            pstmt.setString(11, order_code);
            pstmt.setString(12, selling_date);
            pstmt.setString(13, selling_chit_code);
            pstmt.setString(14, selling_tax_bill_code);
            pstmt.setString(15, selling_memo);

            
            // 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
            return pstmt.executeUpdate();
         }catch (Exception e) {
            e.printStackTrace();
         }
         
         return -1;
      }
      
      // 반품등록 - 불량 재고
      public int badRegist(String item_code,String item_name, String order_date, String stock_storage_name, String item_unit_name, Integer bad_stock_amount, Integer item_unit_price, String bad_stock_return_date, String bad_stock_result,String bad_stock_memo) {

         // 
         String SQL = "INSERT INTO bad_stock VALUES (null,?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
         try {
            // 각각의 데이터를 실제로 넣음
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            

            pstmt.setString(1, item_code);
            pstmt.setString(2, item_name);
            pstmt.setString(3, order_date);
            pstmt.setString(4, stock_storage_name);
            pstmt.setString(5, item_unit_name);
            pstmt.setInt(6, bad_stock_amount);
            pstmt.setInt(7, item_unit_price);
            pstmt.setString(8, bad_stock_return_date);
            pstmt.setString(9, bad_stock_result);
            pstmt.setString(10, bad_stock_memo);
            
            
            // 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
            return pstmt.executeUpdate();
         }catch (Exception e) {
            e.printStackTrace();
         }
         
         return -1;
      }
      
      // 매출 등록시 재고 수량 마이너스
      public int stockCancel(int count, String item_code) {

         // 메모
         String SQL = "UPDATE stock SET stock_amount=stock_amount-? WHERE item_code=? ";
         try {
            // 각각의 데이터를 실제로 넣음
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            
            pstmt.setInt(1, count);
            pstmt.setString(2, item_code);            

            
            // 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
            return pstmt.executeUpdate();
         }catch (Exception e) {
            

            e.printStackTrace();
         }
         
         return -1;
      }
      
      // 매출 등록시 수주 메모 '출고'
            public int shipping(String order_code) {

               // 메모
               String SQL = "UPDATE orders SET order_memo='출고' WHERE order_code=? ";
               try {
                  // 각각의 데이터를 실제로 넣음
                  PreparedStatement pstmt = conn.prepareStatement(SQL);
                  
                  pstmt.setString(1, order_code);         

                  
                  // 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
                  return pstmt.executeUpdate();
               }catch (Exception e) {
                  

                  e.printStackTrace();
               }
               
               return -1;
            }
   
}
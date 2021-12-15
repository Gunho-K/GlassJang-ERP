<%@ page import="db_login.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String ID = request.getParameter("ID");
	String PW = request.getParameter("PW");
	
	/*데이터베이스 연결*/
	Connection conn = DBUtil.getMySQLConnection();
	
	String sql="select * from user where ID = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, ID);
	ResultSet rs = pstmt.executeQuery();
	String password;
	rs.next();
	password = rs.getString("PW");
	DBUtil.close(rs);	
	DBUtil.close(pstmt);
	DBUtil.close(conn);
	
	if(password.equals(PW)) {
		out.println("<script>");
		session.setAttribute("ID", ID);
		response.sendRedirect("business_info.jsp");
		out.println("</script>");
	}
	else {
		out.println("<script>");
		out.println("alert('로그인에 실패하였습니다.')");
		out.println("location.href='index.jsp'");
		out.println("</script>");
	}
%>
</body>
</html>
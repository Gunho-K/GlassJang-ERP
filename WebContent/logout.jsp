<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<script>
	window.history.forward(); 
	function noBack(){ window.history.forward(); }
	
</script>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
	<%
		session.removeAttribute("ID"); 
		session.invalidate();
		response.sendRedirect("index.jsp");
	%>
</body>
</html>

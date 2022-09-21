<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.*, java.sql.*, org.ai.beans.*" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String nickName = (String)session.getAttribute("nickName");
int userExp = 0;
int userIcon = 1;
String url = "jdbc:mysql://localhost:3306/miniProject1?useSSL=false&allowPublicKeyRetrieval=true";
String sql = null;
String user = "root";
String password = "1234";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ArrayList<Members> mList = new ArrayList<Members>();
%>
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
		sql = "select userExp from members where nickName = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nickName);
		rs = pstmt.executeQuery();
		while(rs.next()){
			userExp = rs.getInt(1);
		}
		sql = "select * from members";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()){
			mList.add(new Members(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6)
					, rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12)
					, rs.getString(13), rs.getString(14), rs.getString(15)));
		}
		request.setAttribute("mList", mList);
	} catch (Exception e){
		e.printStackTrace();
	}
%>
<% conn.close(); %>
</body>
</html>
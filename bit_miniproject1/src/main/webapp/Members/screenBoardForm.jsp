<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.util.*, java.sql.*, org.ai.beans.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 게시판</title>
<style type="text/css">
#screenBoardForm {
	display: inline-block;
	float: right;
	width: 1400px;
	height: 1200px;
	margin-top: 200px;
}
</style>
</head>
<body>
<%
	String userId = (String)session.getAttribute("userId");
	String userPwd = (String)session.getAttribute("userPwd");
	String userJob = (String)session.getAttribute("userJob");
	String path = request.getServletContext().getContextPath()+"/upload/";
	String boardTitle = "screenBoard";
%>
<jsp:include page="./boardInfo.jsp" flush="false">
	<jsp:param value="<%=boardTitle%>" name="boardTitle"/>
</jsp:include>
<%if(session.getAttribute("userId") != null){ %>
<jsp:include page="./header2.jsp"></jsp:include>
<%} 
else {%>
<jsp:include page="./header.jsp"></jsp:include>
<%}%>
<div id="content">
<jsp:include page="./aside.jsp"></jsp:include>
<div id="screenBoardForm">
<h2 style="text-align: center; margin-left: 100px;">전군시 사진게시판</h2> <br>
<a href="./mainForm.do?userId=<%=userId%>&userPwd=<%=userPwd%>&userJob=<%=userJob%>" id="mainFormCheck" style="display: none;"></a>
<input type="button" value="메인 페이지로" style="float: right;margin-right: 20px; margin-bottom: 10px; line-height: 30px; border-radius: 3px; box-sizing: border-box; border: 1px solid #303030;" onclick="document.getElementById('mainFormCheck').click();" />
<!-- 여기다가 boardTitle = screenBoard인 애들 나오게할것 -->
<a href="./boardWrite.jsp?boardTitle=<%=boardTitle%>" id="boardWrite" style="display: none;"></a>
<%if(session.getAttribute("userId") != null){ %>
	<input type="button" value="글쓰기" style="margin-bottom: 10px; float: right; background: #444;
    border: 1px solid #303030;
    color: #fff; border-radius: 3px;
    box-sizing: border-box; transition: .2s; line-height: 30px;
    text-align: center; margin-right:20px; width: 120px" onclick="document.getElementById('boardWrite').click();" />
<%}%> 
<br>
	<hr>
	<br>
<%!int count = 0;%>
<%int lineCount = 0; %>
<c:set var="items" value="${bList}"></c:set>	
<c:set var="items2" value="${cList}"></c:set>
<c:forEach var="item" items="${items}">
	<div style="width: 200px; height: 320px; display: inline-block; margin-left: 70px; border: 1px solid gray; box-sizing: border-box; border-radius: 3px;" >
		<div>
		<a href="./boardView.jsp?number=${item.number}" id="goScreenView" style="display: none;"></a>
		<c:choose>
			<c:when test="${item.imageFileName eq null}">
				<img alt="" src="https://i.ibb.co/58bQ29v/noimage.jpg" width="198px" height="200px" style="border-bottom: 1px solid gray; text-align: center; overflow: hidden" onerror="this.style.display='none'" onclick="document.getElementById('goScreenView').click()"> <br>
			</c:when>
			<c:otherwise>
				<img alt="" src="<%=path%>${item.imageFileName}" width="198px" height="200px" onerror="this.style.display='none'" onclick="document.getElementById('goScreenView').click()" style="border-bottom: 1px solid gray; overflow: hidden"> <br>
			</c:otherwise>
		</c:choose>
		</div>
		<div>
		<ul style="list-style:none; padding-left:0px;">
		<li style="margin-top:12px; margin-left:7px;"><a href="./boardView.jsp?number=${item.number}&boardTitle=<%=boardTitle%>" style="font-family:'Malgun Gothic', '맑은 고딕', helvetica, 'Apple SD Gothic Neo', sans-serif; font-size: 100%; color: black;">${item.title}</a>
		<!-- 2중 for문으로 댓글 숫자 보여줘야함 -->
		<!-- 두 글 번호가 같을경우.. 카운트가 올라가고.. 다를경우에 출력.. -->
		<c:forEach var="item2" items="${items2}">
			<c:if test="${item.number eq item2.number}">
				<%count++;%>
			</c:if>
		</c:forEach>
		<%if(count != 0){ %>
		<a href="./searchCommentProcess.jsp?number=${item.number}&writer=${item.writer}" target="_blank" onClick="window.open(this.href, '', 'width=600, height=400'); return false;" style="text-decoration: none; color: red;">[<%=count%>]</a>
		<%} count = 0; %>
		</li>
		<br>
		<li style="color: gray; margin-left:7px;">${item.writer}</li>
		<li style="float: left; display: inline-block; margin-left:7px;"><img src="https://i.ibb.co/fHKtYnX/image.jpg" width="20px" height="16px" style="margin-bottom:2px; margin-right:2px"/>${item.views} </li><li style="float: right; display: inline-block; color: navy; margin-right: 7px"> <img alt="" src="https://i.ibb.co/2Y2ghNY/image.jpg" width="19px" height="18px"/> ${item.recommends} </li>
		</ul>	
		</div>
	</div>
	<%lineCount++; %>
	<%if(lineCount == 5){
			lineCount = 0; 
		%>	
			<br><br><br>
		<%}%>
</c:forEach>	
</div>
</div>
<jsp:include page="./footer.jsp"></jsp:include>
</body>
</html>
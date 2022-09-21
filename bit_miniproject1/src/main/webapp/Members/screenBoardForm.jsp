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
	margin-top: 150px;
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
	ArrayList<Board> bList = new ArrayList<Board>();
	ArrayList<Board> bList2 = new ArrayList<Board>();
	ArrayList<Comment> cList = new ArrayList<Comment>();
	int pages = Integer.parseInt(request.getParameter("pages"));
%>
<jsp:include page="./boardInfo.jsp" flush="false">
	<jsp:param value="<%=boardTitle%>" name="boardTitle"/>
	<jsp:param value="<%=pages%>" name="pages"/>
</jsp:include>
<jsp:include page="./memberInfo.jsp"></jsp:include>
<%if(session.getAttribute("userId") != null){ %>
<jsp:include page="./header2.jsp"></jsp:include>
<%} 
else {%>
<jsp:include page="./header.jsp"></jsp:include>
<%}%>
<div id="content">
<%if(session.getAttribute("userId") != null){ 
	if("soldier".equals((String)session.getAttribute("userJob"))){ %>
		<jsp:include page="./aside3.jsp"></jsp:include>
	<%} else { %>
		<jsp:include page="./aside2.jsp"></jsp:include>
	<% }
}else {%>
<jsp:include page="./aside.jsp"></jsp:include>
<%}%>
<div id="screenBoardForm">
<h2 style="text-align: center; margin-left: 100px;">ROK ARMY 사진게시판</h2> <br>
<a href="./mainForm.do?userId=<%=userId%>&userPwd=<%=userPwd%>&userJob=<%=userJob%>" id="mainFormCheck" style="display: none;"></a>
<input type="button" value="메인으로" class="goToMain" onclick="document.getElementById('mainFormCheck').click();" />
<!-- 여기다가 boardTitle = screenBoard인 애들 나오게할것 -->
<a href="./boardWrite.jsp?boardTitle=<%=boardTitle%>" id="boardWrite" style="display: none;"></a>
<%if(session.getAttribute("userId") != null){ %> 
	<input type="button" value="글쓰기" class="writeBoard" onclick="document.getElementById('boardWrite').click();" />
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
				<img alt="" src="<%=path%>${item.imageFileName}" width="198px" height="200px" onerror="this.style.display='none'" onclick="document.getElementById('goScreenView').click()" style="border-bottom: 1px solid gray; overflow: hidden; cursor: pointer;"> <br>
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
		<li style="color: gray; margin-left:7px;">
		<c:forEach var="member" items="${mList}">
			<c:if test="${member.nickName eq item.writer}}">
				<c:choose>
					<c:when test="${member.userExp == 0}">
						<img src="https://i.ibb.co/DYQFRjq/image.png" width="18px" height="18px">
					</c:when>
					<c:when test="${member.userExp == 100}">
						<img src="https://i.ibb.co/Hnhvny8/image.png" width="18px" height="18px">
					</c:when>
					<c:when test="${member.userExp == 200}">
						<img src="https://i.ibb.co/NKXW0C9/image.png" width="18px" height="18px">
					</c:when>
					<c:when test="${member.userExp == 300}">
						<img src="https://i.ibb.co/HNzQDJT/image.png" width="18px" height="18px">
					</c:when>
					<c:when test="${member.userExp == 400}">
						<img src="https://i.ibb.co/M6PwMcC/image.png" width="18px" height="18px">
					</c:when>
					<c:when test="${member.userExp == 500}">
						<img src="https://i.ibb.co/QkmbTmL/image.png" width="18px" height="18px">
					</c:when>
					<c:when test="${member.userExp == 600}">
						<img src="https://i.ibb.co/WHGk9tW/image.png" width="18px" height="18px">
					</c:when>
					<c:when test="${member.userExp == 700}">
						<img src="https://i.ibb.co/4PJ9wVk/image.png" width="18px" height="18px">
					</c:when>
					<c:when test="${member.userExp == 800}">
						<img src="https://i.ibb.co/M7SJqZW/image.png" width="18px" height="18px">
					</c:when>
					<c:when test="${member.userExp > 800}">
						<img src="https://i.ibb.co/QrPKh3V/image.jpg" width="18px" height="18px">
					</c:when>
				</c:choose>
			</c:if>
		</c:forEach>
		${item.writer}</li>
		<li style="float: left; display: inline-block; margin-left:7px;"><img src="https://i.ibb.co/fHKtYnX/image.jpg" width="20px" height="16px" style="margin-bottom:2px; margin-right:2px"/>${item.views} </li><li style="float: right; display: inline-block; color: navy; margin-right: 7px"> <img alt="" src="https://i.ibb.co/2Y2ghNY/image.jpg" width="19px" height="18px"/> ${item.recommends} </li>
		</ul>	
		</div>
	</div>
	<%lineCount++; %>
	<%
	if(lineCount == 5){
		lineCount = 0; 
	%>	
			<br><br><br><br><br>
		<%}%>
</c:forEach>	
<%
int size = (int)session.getAttribute("size");
int lastPage = 0;
if(size / 10 > 0) {
	lastPage = (size / 10) + 1;
}
else {
	lastPage = 1;
}%>
<div style="text-align: center">
<%for(int i = 1; i <= lastPage; i++){
	if(i == 1){%>
	
	<a style="text-decoration: none; color: black; text-align: center" href="./screenBoardForm.jsp?pages=<%=i%>"><%=i%></a>
	<% } else if(i > 1){ %>
	<a style="text-decoration: none; color: black; text-align: center" href="./screenBoardForm.jsp?pages=<%=i%>"> | <%=i%></a>
	<% }
}%>
</div>
</div>
</div>
<jsp:include page="./footer.jsp"></jsp:include>
</body>
</html>
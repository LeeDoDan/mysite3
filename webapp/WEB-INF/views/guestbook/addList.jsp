<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">
</head>
<body>
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- //header -->
		<c:import url ="/WEB-INF/views/include/nav.jsp"/>
		<!-- //nav -->
	<div id="aside">
		<h2>방명록</h2>
		<ul>
			<li>일반방명록</li>
			<li>ajax방명록</li>
		</ul>
	</div>
	<!-- //aside -->
	<div id="content">

		<div id="content-head">
			<h3>일반방명록</h3>
			<div id="location">
				<ul>
					<li>홈</li>
					<li>방명록</li>
					<li class="last">일반방명록</li>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
		<!-- //content-head -->
	<form action="${pageContext.request.contextPath}/guestbook/add" method="get">
		<table border="1" width="510px">
			<tr>
				<td>이름</td><td><input type="text" name=""></td>
				<td>비밀번호</td><td><input type="password" name=""></td>
			</tr>
			<tr>
				<td colspan="4"><textarea name="" cols="68" rows="5"></textarea></td>
			</tr>
			<tr>
				<td colspan="4"><button type="submit">등록</button></td>
			</tr>
		</table>
		<input type="hidden" name="" value="">
	</form>
	<br>

	<c:forEach items="${guestList}" var="guestbookVo">
		<table  border="1" width="510px">
			<tr>
				<td>${guestbookVo.no}</td>
				<td>${guestbookVo.name}</td>
				<td>${guestbookVo.regDate}</td>
				<td><a href="${pageContext.request.contextPath}/guestbook/deleteForm?=${guestbookVo.no}">삭제</a></td>
			</tr>
			<tr>
				<td colspan="4">${guestbookVo.content}.</td>
			</tr>
		</table>
	    <br>
	</c:forEach>
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->
</body>
</html>
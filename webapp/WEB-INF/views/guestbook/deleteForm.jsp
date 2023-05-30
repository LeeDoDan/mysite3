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
	<form action="${pageContext.request.contextPath}/guestbook/delete" method="get">
		<table>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="password"></td>
				<td><button type="submit">삭제</button></td>
				<td><a href="/guestbook/addList">메인으로 돌아가기</a></td>
			</tr>
		</table>
		<input type='text' name="no" value="${param.no}"><br>
		<input type='hidden' name="" value=""><br>
	</form>
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	<!-- //footer -->
</body>
</html>
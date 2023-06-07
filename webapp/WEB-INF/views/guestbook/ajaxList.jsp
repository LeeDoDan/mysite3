<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
	<!-- //header -->
	<c:import url="/WEB-INF/views/include/nav.jsp" />
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

<%-- 		<form action="${pageContext.request.contextPath}/guestbook/add"
			method="get"> --%>
			<table border="1" width="510px">
				<tr>
					<td>이름</td>
					<td><input type="text" name=""></td>
					<td>비밀번호</td>
					<td><input type="password" name=""></td>
				</tr>
				<tr>
					<td colspan="4"><textarea name="" cols="68" rows="5"></textarea></td>
				</tr>
				<tr>
					<td colspan="4"><button type="submit" id="btnSubmit">등록</button></td>
				</tr>
			</table>
			<input type="hidden" name="" value="">
	<!-- 	</form> -->
		<br>

		<c:forEach items="${guestbookList}" var="guestbookVo">
			<table border="1" width="510px">
				<tr>
					<td>${guestbookVo.no}</td>
					<td>${guestbookVo.name}</td>
					<td>${guestbookVo.regDate}</td>
					<td><a
						href="${pageContext.request.contextPath}/guestbook/deleteForm?=${guestbookVo.no}">삭제</a></td>
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
<script type="text/javascript">
	//방명록 저장 버튼 클릭할때
	$("#btnSubmit").on("click", function() {
		console.log("버튼클릭");
		//데이터 수집
		var name= $("[name='name']").val();
		var password= $("[name='password']").val();
		var content= $("[name='content']").val();
		
		var guestbookVo = {
			name:name,
			password:password,
			content:content
		};
		
		console.log(name);
		console.log(password);
		console.log(content);
		//ajax통신→ 요청은 같은 기술 응잡 이 테이터만 옴
		
		$.ajax({
			
			url : "${pageContext.request.contextPath }/api/guestbook/add",
			type : "post",
			//contentType : "application/json",	
			//data : {name:name, password:password,content:content}, //위에 var guestbookVo 만들었으니
			data : guestbookVo,
			dataType : "json",	
			success : function(result){
				//성공시 처리해야할 코드
				if(jsonResult.result == "success"){
					//정상처리
					render(jsonResult.data);
					
					
					
					
					
					
					
					
/* 					console.log(jsonResult.name);//데이터 꺼내기
					
		            var str = "";
		            str += '<table class="guestRead">';
		            str += '   <colgroup>';
		            str += '        <col style="width: 10%;">';
		            str += '        <col style="width: 40%;">';
		            str += '        <col style="width: 40%;">';
		            str += '        <col style="width: 10%;">';
		            str += '   </colgroup>';
		            
		            str += '   <tr>';
		            str += '        <td>' + jsonResult.data.no + '</td>';
		            str += '        <td>' + jsonResult.data.name + '</td>';
		            str += '        <td>' + jsonResult.data.regDate + '</td>';
		            str += '        <td><a href="${pageContext.request.contextPath }/guestbook/deleteForm?no=${guestVo.no}">[삭제]</a></td>';
		            str += '   </tr>';
		            
		            str += '   <tr>';
		            str += '        <td colspan=4 class="text-left">'+ jsonResult.data.content + '</td>';
		            str += '   </tr>';
		            str += '</table>';
		             */
					$("#guestbookListArea").prepend(str);
		            
				}else{
					//오류처리
				}
			},

			error : function(XHR, status, error) {
				console.error(status + " : " + error);

			}
		});

	});
</script>
</html>






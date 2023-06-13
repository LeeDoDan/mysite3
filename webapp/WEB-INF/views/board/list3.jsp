<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/board.css" rel="stylesheet" type="text/css">

</head>


<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- //header -->
		<c:import url="/WEB-INF/views/include/nav.jsp" />
		<!-- //nav -->


		<div id="container" class="clearfix">
			<!-- 게시판 aside -->
			<%--  <c:import url="/WEB-INF/views/includes/asideBoard.jsp"></c:import> --%>
			<div id="aside">
				<h2>게시판</h2>
				<ul>
					<li><a href="">일반게시판</a></li>
					<li><a href="">댓글게시판</a></li>
				</ul>
			</div>
			<!-- //aside -->
			<!-- //게시판 aside -->

			<div id="content">

				<div id="content-head">
					<h3>게시판</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>게시판</li>
							<li class="last">일반게시판</li>
						</ul>
					</div>
					<div class="clear"></div>
				</div>
				<!-- //content-head -->

				<div id="board">
					<div id="list">
						<form action="${pageContext.request.contextPath}/board/list" method="get">
							<div class="form-group text-right">
								<input type="text" name="keyword" value="">
								<button type="submit" id=btn_search>검색</button>
							</div>
						</form>
						<table>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>글쓴이</th>
									<th>조회수</th>
									<th>작성일</th>
									<th>관리</th>
								</tr>
							</thead>
							<tbody>
								<!-- Controller의 model.addAttribute("boardList",boardList); -->
								<!-- 5개중하나만 쓸건데 하나담을수있는 이름 list보단.. -->
								<c:forEach items="${requestScope.pMap.boardList}" var="boardVo">
									<tr>
										<td>${boardVo.no}</td>
										<td class="text-left"><a href="${pageContext.request.contextPath }/board/read?no=${boardVo.no}">${boardVo.title}</a></td>
										<td>${boardVo.name}</td>
										<td>${boardVo.hit}</td>
										<td>${boardVo.regDate}/글작성자번호: ${boardVo.userNo} /세션:${sessionScope.authUser.no}</td>
										<td>
											<!-- 글 작성자 번호와 세션의 사용자 번호(로그인한) 같으면 삭제버튼이 보임 --> <c:if test="${boardVo.userNo == sessionScope.authUser.no }">
												<!-- 하나의문법 합쳐서{} 써야함 -->
												<a href="${pageContext.request.contextPath}/board/remove?no=${boardVo.no}">[삭제]</a>
											</c:if>
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>

						<div id="paging">
							<ul>
								<c:if test="${pMap.prev == true}">
									<li><a href="${pageContext.request.contextPath}/board/list3?crtPage=${pMap.startPageBtnNo-1}">◀</a></li>
								</c:if>
								<c:forEach begin="${pMap.startPageBtnNo}" end="${pMap.endPageBtnNo }" step="1" var="page"><!-- page:몇번쨰 페이지? -->
									<li><a href="${pageContext.request.contextPath}/board/list3?crtPage=${page}">${page}</a></li>
								</c:forEach>

								<c:if test="${pMap.next == true}">
									<li><a href="${pageContext.request.contextPath}/board/list3?crtPage=${pMap.endPageBtnNo+1}">▶</a></li>
								</c:if>
							</ul>


							<div class="clear"></div>
						</div>

						<c:if test="${not empty authUser }">
							<a id="btn_write" href="${pageContext.request.contextPath }/board/writeForm">글쓰기</a>
						</c:if>
					</div>
					<!-- //list -->
				</div>
				<!-- //board -->
			</div>
			<!-- //content  -->

		</div>
		<!-- //container  -->


		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->
	</div>
	<!-- //wrap -->

</body>

</html>
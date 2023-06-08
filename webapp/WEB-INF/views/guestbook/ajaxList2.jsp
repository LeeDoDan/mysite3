<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">

<!-- 부트스트랩 css -->
<link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">

<!-- jquery -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>

<!-- 부트스트랩 js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>

</head>

<body>
	<div id="wrap">
        <c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- //header -->

		<c:import url ="/WEB-INF/views/include/nav.jsp"/>
				<!-- //nav -->

		<div id="aside">
			<h2>방명록</h2>
			<ul>
				<li>일반방명록</li>
				<li><a href="${pageContext.request.contextPath}/api/guestbook/addList2">ajax방명록</a></li>
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

			<div id="guestbook">
				<%-- <form action="${pageContext.request.contextPath}/api/guestbook/add" method="get"> --%>
					<table id="guestAdd">
						<colgroup>
							<col style="width: 70px;">
							<col>
							<col style="width: 70px;">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th><label class="form-text" for="input-uname">이름</label></td>
								<td><input id="input-uname" type="text" name="name"></td>
								<th><label class="form-text" for="input-pass">패스워드</label></td>
								<td><input id="input-pass" type="password" name="password"></td>
							</tr>
							<tr>
								<td colspan="4"><textarea name="content" cols="72" rows="5"></textarea></td>
							</tr>
							<tr class="button-area">
								<td colspan="4"><button id="btnSubmit" type="submit">등록</button></td>
							</tr>
						</tbody>
						
					</table>
					<!-- //guestWrite -->
					<input type="hidden" name="action" value="add">
					
				<!-- </form>	 -->
				<div id="guestbookListArea">
				<!-- 방명록 리스트 출력 영역 -->
				<%-- 	<c:forEach items="${guestList}" var="guestbookVo">
						<table class="guestRead">
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 40%;">
								<col style="width: 40%;">
								<col style="width: 10%;">
							</colgroup>
							<tr>
								<td>${guestbookVo.no}</td>
								<td>${guestbookVo.name}</td>
								<td>${guestbookVo.regDate}</td>
								<td>
								    <button type="button" class="btn btn-primary btn-sm btnModal" data-delno="${guestbookVo.no}">삭제</button>
								</td>
							</tr>
							<tr>
								<td colspan=4 class="text-left">${guestbookVo.content}</td>
							</tr>
						</table>
					</c:forEach> --%>
				</div>	
				<!-- //guestRead -->
				
			</div>
			<!-- //guestbook -->
		</div>
		<!-- //content  -->
		<div class="clear"></div>
		
        <c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->

	</div>
	<!-- //wrap -->
	
<!-- 삭제폼 모달창 -------------------------------------------------------->

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">삭제 모달창</h4>
      </div>
      <div class="modal-body">
        <input id="modalPassword" type="password" name=""><br> <!-- 비밀번호 입력 -->
        <input id="modalNo" type="text" name="no">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        <button id="btnDel" type="button" class="btn btn-danger">삭제</button>
      </div>
    </div>
  </div>
</div>

<!-- 삭제폼 끝 -->
</body>

<script type="text/javascript">
	//돔 생성 후 (그리기 전)←하나의 이벤트라고 생각하기
	$(document).ready(function(){
		//전체 리스트 호출해서 가져오기
		fetchList();
	});
	
	//방명록 저장 버튼 클릭할때
	$("#btnSubmit").on("click", function(){
		console.log("버튼클릭");
		
		//데이타 수집
		var name = $("[name='name']").val();
		var password = $("[name='password']").val();
		var content = $("[name='content']").val();
		
		var guestbookVo ={
		    name: name,
		    password: password,
		    content: content
		}; //→json형식으로 컨버트☆
		
		var str = JSON.stringify(guestbookVo);
		console.log(str);
		
		//ajax통신 ->요청은 같은 기술 응답이 데이터만 온다
		$.ajax({
			
			url : "${pageContext.request.contextPath }/api/guestbook/add2",		
			type : "post",
			contentType : "application/json",//☆
			data : JSON.stringify(guestbookVo),

			dataType : "json",
			success : function(jsonResult){
				/*성공시 처리해야될 코드 작성*/
				console.log(jsonResult);
				
				if(jsonResult.result == "success"){
					//정상처리
					
					render(jsonResult.data,"up"); //리스트에 추가
					
					//등록폼 비우기
					$("[name='name']").val("");
					$("[name='password']").val("");
					$("[name='content']").val("");
				}else{
					//오류처리
				}

			},
			error : function(XHR, status, error) { 
				console.error(status + " : " + error);
			}
	    });
	});	
	
	function fetchList(){//function은 정의니까
		$.ajax({
			
			url : "${pageContext.request.contextPath }/api/guestbook/list",		
			type : "post",
		
			
			dataType : "json",
			success : function(jsonResult,dir){
				console.log(jsonResult);
				var guestList =jsonResult.data;
				
				//성공시 처리해야될 코드 작성
				for(var i = 0; i<guestList.length; i++){
					render(guestList[i], "down");	//다 말고 i번쨰 하나만,"방향"
				}
				
			},
			error : function(XHR, status, error) { 
				console.error(status + " : " + error);
			}
	    });
	}
	
	//방명록 리스트 그리기
	function render(guestbookVo, dir){//방향
		
		var str ="";
		str += '<table id="t-'+guestbookVo.no+'" class="guestRead">';
		str += '  <colgroup>';
		str += '	  <col style="width: 10%;">';
		str += '	  <col style="width: 40%;">';
		str += '	  <col style="width: 40%;">';
		str += '	  <col style="width: 10%;">';
		str += '  </colgroup>';
		
		str += '  <tr>';
		str += '      <td>' + guestbookVo.no +'</td>';
		str += '      <td>' + guestbookVo.name + '</td>';
		str += '      <td>' + guestbookVo.regDate + '</td>';
		str += '      <td><button type="button" class="btn btn-primary btn-sm btnModal" data-delno="'+ guestbookVo.no +'">삭제</button></td>';
		str += '  </tr>';

		str += '  <tr>';
		str += '      <td colspan=4 class="text-left">' + guestbookVo.content + '</td>';
		str += '  </tr>';
		str += '</table>';
		
		if(dir == "up"){
			$("#guestbookListArea").prepend(str);
		}else if(dir == "down"){
			$("#guestbookListArea").append(str);
		}else{
			console.log("방향오류");
		}
	}

</script>
</html>







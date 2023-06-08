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
				<li><a href="${pageContext.request.contextPath}/api/guestbook/addList">ajax방명록</a></li>
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
					<c:forEach items="${guestList}" var="guestbookVo">
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
					</c:forEach>
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

//모달창에 있는 삭제 버튼 클릭했을때(진짜 삭제)
$("#btnDel").on("click","", function(){
	console.log("삭제버튼 클릭");
	
	//서버에 데이타보내기
	//password,no --> 모달창에 보내기
	
	//데이타모으기
	var password = $("#modalPassword").val();
	var no = $("#modalNo").val();
	
	//객체로 만들기
	var guestVo = {
	    password: password,
	    no: no
	};
	
	//요청
	$.ajax({
		
		url : "${pageContext.request.contextPath }/api/guestbook/remove",		
		type : "post",
		data : guestVo,

		dataType : "json",
		success : function(jsonResult){
			console.log(jsonResult);
			//성공시 처리해야될 코드 작성
			if(jsonResult.data >0){
				//화면에서 지우기 (db말고)
				$("#t-"+guestVo.no).remove();//data : guestVo, 이거 가져와서 guestbookVo아님
				$('#myModal').modal('hide');
			}else{
				alert("비밀번호가 틀렸음");
			}
		},
		error : function(XHR, status, error) { 
			console.error(status + " : " + error);
		}
    });
	console.log("test임 "+guestVo.no);//ajax요청 부분이 오래걸리든말든 이거먼저뜨게?
	
});




//삭제 모달창 호출 버튼 ->>모달창 뜸
$("#guestbookListArea").on("click",".btnModal",function(){  //새로 추가된 방명록의 삭제를 하기위해 부모 div 아이디에 범위를 주고 클래스 btnModal에 이벤트를 추가
	console.log("모달창 호출버튼 클릭");
	
	//초기화
	$("#modalPassword").val("");
	$("#modalNo").val("");
	
	//방명록 글번호 input창에 가져오기
	//삭제버튼캐그에서 no값 가져오기 data("no")
	var no = $(this).data("delno");
	console.log(no);
	
	//모달창 input태그에 no값 넣기
	$("#modalNo").val(no);
	
	//모달창 호출
	$('#myModal').modal('show');
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
	
	//ajax통신 ->요청은 같은 기술 응답이 데이터만 온다
	$.ajax({
		
		url : "${pageContext.request.contextPath }/api/guestbook/add",		
		type : "post",
		//contentType : "application/json",//☆
		data : guestbookVo,

		dataType : "json",
		success : function(jsonResult){
			/*성공시 처리해야될 코드 작성*/
			console.log(jsonResult);
			
			if(jsonResult.result == "success"){
				//정상처리
				
				render(jsonResult.data); //리스트에 추가
				
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
	
	
	//방명록 리스트 그리기
	function render(guestbookVo){
		
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
		
		$("#guestbookListArea").prepend(str);
	}
	
	
});

</script>
</html>
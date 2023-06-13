<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href=" ${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href=" ${pageContext.request.contextPath}/assets/css/user.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
</head>

<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- //header -->

		<c:import url ="/WEB-INF/views/include/nav.jsp"/>
		<!-- //nav -->

		<div id="aside">
			<h2>회원</h2>
			<ul>
				<li>회원정보</li>
				<li>로그인</li>
				<li>회원가입</li>
			</ul>
		</div>
		<!-- //aside -->

		<div id="content">
			
			<div id="content-head">
            	<h3>회원가입</h3>
            	<div id="location">
            		<ul>
            			<li>홈</li>
            			<li>회원</li>
            			<li class="last">회원가입</li>
            		</ul>
            	</div>
                <div class="clear"></div>
            </div>
            <!-- //content-head -->

			<div id="user">
				<div id="joinForm">
					<form action=" ${pageContext.request.contextPath}/user/join" method="get">

						<!-- 아이디 -->
						<div class="form-group">
							<label class="form-text" for="input-uid">아이디</label> 
							<input type="text" id="input-uid" name="id" value="" placeholder="아이디를 입력하세요">
							<button type="button" id="btnIdCheck">중복체크</button>
							<p id="idCheckMsg"></p>
						</div>

						<!-- 비밀번호 -->
						<div class="form-group">
							<label class="form-text" for="input-pass">패스워드</label> 
							<input type="password" id="input-pass" name="password" value="" placeholder="비밀번호를 입력하세요"	>
						</div>

						<!-- 이메일 -->
						<div class="form-group">
							<label class="form-text" for="input-name">이름</label> 
							<input type="text" id="input-name" name="name" value="" placeholder="이름을 입력하세요">
						</div>

						<!-- //성별 -->
						<div class="form-group">
							<span class="form-text">성별</span> 
							
							<label for="rdo-male">남</label> 
							<input type="radio" id="rdo-male" name="gender" value="male" > 
							
							<label for="rdo-female">여</label> 
							<input type="radio" id="rdo-female" name="gender" value="female" > 

						</div>

						<!-- 약관동의 -->
						<div class="form-group">
							<span class="form-text">약관동의</span> 
							
							<input type="checkbox" id="chk-agree" value="" name="">
							<label for="chk-agree">서비스 약관에 동의합니다.</label> 
						</div>
						
						<!-- 버튼영역 -->
		                <div class="button-area">
		                    <button type="submit" id="btn-submit">회원가입</button>
		                </div>
						
					</form>
				</div>
				<!-- //joinForm -->
			</div>
			<!-- //user -->
		</div>
		<!-- //content  -->
		<div class="clear"></div>
		
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->

	</div>
	<!-- //wrap -->

</body>
	<script type="text/javascript">
	//예제
	//원래의 태그의 기능을 사용하지 않을때
	$("#naver").on("click", function(event){
		event.preventDefault();	// 이벤트의 기본 동작을 취소하는 메서드
	});
	
	//회원가입 버튼을 눌렀을때: 전송 submit은 form에 이벤트
	$("#joinSubmitForm").on("click", function(){
		console.log("전송버튼 클릭");
		
		var id = $("#input-uid").val();
		if(id.length < 1){//입력안했으면
			console.log("아이디없음");
			return false;
		}
		//패스워드 체크
		
		//약관동의 유무
		var agree = $("#chk-agree").is(":checked");
		if(agree == false){
			alert("약관에 동의해 주세요");
			return false;
		}
		
		
		return true;
	});
	
	
		//아이디 중복체크 버튼 클릭했을때
		$("#btnIdCheck").on("click", function(){
			console.log("버튼 클릭");
			//id 추출
			var id= $("[name=id]").val();	//항상 입력한 id→보냈을때 이 id
			console.log(id);
			//통신 ===================================id 뽑아내서 보내서
			$.ajax({
		
				url : "${pageContext.request.contextPath }/user/idcheck",//주소 요청해야할 곳//원래 id?=하고 파라미터 붙이는데
				type : "post",
				//contentType : "application/json",	//보낼때 데이터가 하나가 아니라 왕창일때
				data : {id:id},//{필드명 : 값}
		
				dataType : "json",	//돌아올때 방식
				success : function(jsonResult){
					console.log(jsonResult);
					if(jsonResult.result=='success'){//처리 성공
						//사용가능한지 불가능한지 표현
						if(jsonResult.data == true){
							//사용가능
							$("#idCheckMsg").html("사용가능");
						}else{
							//사용불가능
							$("#idCheckMsg").html("사용중");
						}
					}else{
						//메세지 출력
						var msg = jsonResult.failMsg;
						alert(msg);
					}
				},
				/*success : function(result){
					console.log(result);
					//성공시 처리해야될 코드 작성
					if(result==true){//처리 성고
						//사용가능한지 불가능한지 표현
						$("#idCheckMsg").html("사용가능");
					}else{
						//사용불가능-에러메세지 출력
						$("#idCheckMsg").html("사용불가능");
					}
				},*/
				error : function(XHR, status, error) {
					console.error(status + " : " + error);
					//alert("서버요청실패");

				}
			});

			//응답 ===================================왔어 →불가능이야..?

			//사용불가능
	  		/* 	var userVo = {
				no :1,
				name:"황일영",
				id:"aaa",
				password:"1234",
				gender:"male"
			}; 
			//처리
			var userVo = null;
			
			if(userVo == null){
				//사용가능
				$("#idCheckMsg").html(id +"는 사용 가능 아이디");
			}else{
				//사용불가
				$("#idCheckMsg").html(id+ "는 사용 중인 아이디");
			}  */
		});
	</script>

</html>










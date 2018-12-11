<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="basic/settings.jsp" />
<body>
	<script src="${project}/static/js/checkFunc.js"></script>
	<script src="${project}/static/js/signUpScript.js"></script>
	<%@ include file="basic/top.jsp"%>
	<jsp:include page="basic/aside.jsp" />


	<section>
		<div class="container">
			<form class="signup" name="signUpForm" action="signUpDo" method="post" onsubmit="return inputCheck('insert');">
			<input type="hidden" name="checkId" value="0">
				<h1>회원가입</h1>
				<table style="width: 500px; height: 400px; margin: 0px auto;">
					<tr>
						<td class="label">아이디 <b style="color: red;">*</b></td>
						<td class="table-text">
							<input type="text" name="id" size="25" maxlength="20" required onchange="onChangeId();"> 
							<input class="whiteButton" type="button" name="dupChk" value="중복 확인" onclick="confirmId();">
						</td>
					</tr>

					<tr>
						<td class="label">비밀번호 <b style="color: red;">*</b></td>
						<td><input type="password" name="pw" size="25" maxlength="20" required placeholder="숫자,특수문자를 포함하고 8자이상"></td>
					</tr>

					<tr>
						<td class="label">비밀번호 확인 <b style="color: red;">*</b></td>
						<td><input type="password" name="repw" size="25" required maxlength="20"></td>
					</tr>

					<tr>
						<td class="label">이름 <b style="color: red;">*</b></td>
						<td><input type="text" name="name" size="25" required></td>
					</tr>
					
					<tr>
						<td class="label">우편 번호 <b style="color: red;">*</b></td>
						<td>
						<input type="text" size="5" name="viewZipcode" disabled>  
						<input type="hidden" size="5" name="zipcode">
						<input class="whiteButton" type="button" name="zipCheck" onclick="sample6_execDaumPostcode();" value="우편번호 찾기">
						</td>
					</tr>

					<tr>
						<td class="label" style="vertical-align:top;">주소 <b style="color: red;">*</b></td>
						<td><input type="text" name="viewAddress1" size="35" disabled>
						<input type="hidden" name="address1" size="35"><br>
						<input type="text" size="35" name="address2" placeholder="상세 주소"></td>
					</tr>
					
					<tr>
						<td class="label">주민등록번호 <b style="color: red;">*</b></td>
						<td>
						<input type="text" name="ssn1" size="6" onkeyup="nextSsn1();" required> - 
						<input type="password" name="ssn2" size="7" onkeyup="nextSsn2();" required>
						</td>
					</tr>
					
					<tr>
						<td class="label">전화번호</td>
						<td>
							<input type="text" size="3" name="hp1" maxlength="3" onkeyup="nextHp1();"> - 
							<input type="text" size="4" name="hp2" maxlength="4" onkeyup="nextHp2();"> - 
							<input type="text" size="4" name="hp3" maxlength="4" onkeyup="nextHp3();">
						</td>
					</tr>
					
					<tr>
						<td class="label">이메일 <b style="color: red;">*</b></td>
						
						<td>
							<input type="hidden" name="email">
							<input type="text" name="email1" size="7" required> @ 
							<input type="text" name="email2" size="10" required> 
							
							<select class="input" name="email3" onchange="selectEmailChk();">
								<option value="0">직접 입력</option>
								<option value="naver.com">네이버</option>
								<option value="gmail.com">구글</option>
								<option value="daum.net">다음</option>
							</select>
						</td>
					</tr>
					
				</table>
				<div align="right">
					<input class="myButton" type="submit" value="회원가입">
				</div>
			</form>
		</div>



	</section>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	
	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;
	
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                	document.signUpForm.zipcode.value = data.zonecode;
	                	document.signUpForm.viewZipcode.value = data.zonecode;
	                	document.signUpForm.viewAddress1.value = fullAddr;
	                	document.signUpForm.address1.value = fullAddr;
	                	document.signUpForm.address2.focus();
	                	/* 
	                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('sample6_address').value = fullAddr; */
	
	                /* // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('sample6_address2').focus(); */
	            }
	        }).open();
	    }
	</script>
	<script type="text/javascript">
	    $(function(){
	    	<%@ include file="basic/modalAndSliderScript.jsp"%>
	    });
    </script>
</body>
</html>
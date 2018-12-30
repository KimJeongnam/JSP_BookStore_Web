/**
 * 
 */

var msg_id = "아이디를 입력하세요!";
var msg_pw = "비밀번호를 입력하세요!";
var msg_repw = "비밀번호가 일치하지 않습니다.";
var msg_repwcheck = "비밀번호가 일치하지 않습니다."
var msg_name = "이름을 입력하세요!";
var msg_jumin1 =	"주민번호 앞자리를 입력하세요!";
var msg_jumin2 = 	"주민번호 뒷자리를 입력하세요!";
var msg_email1 = "이메일id를 입력하세요!";
var msg_email2 =	"이메일을 입력하세요!";
var msg_checkId = "아이디 중복체크를 하세요!";

var insertError = "회원가입에 실패했습니다. \n 확인 후 다시 시도하세요.";
var updateError = "회원정보 수정에 실패했습니다. \n 확인 후 다시 시도하세요.";
var deleteError = "화원탈퇴에 실패 하였스빈다. \n 확인 후 다시 시도하세요.";
var pwdError = "입력하신 비밀번호가 일치하지 않습니다. \n 화인 후 다시 시도하세요.";

// 에러 메세지
function errorAlert(errorMsg){
	alert(errorMsg);
	window.history.back();
}

// -------------------- 메인 페이지 -------------
function mainFocus(){
    document.getElementById("id").focus();
}

function mainCheck(){
    if(!document.mainform.id.value){
        alert(msg_id);
        document.signUpForm.id.focus();
        return false;
    }else if(!document.mainform.pwd.value){
        alert(msg_pw);
        document.signUpForm.pwd.focus();
        return false;
    }
}
//-------------------- 회원 가입 -------------

function inputCheck(mode){
	document.signUpForm.email.value = document.signUpForm.email1.value+'@'+document.signUpForm.email2.value;
	
    if(!document.signUpForm.id.value.trim()){
        alert(msg_id);
        document.signUpForm.id.focus();
        return false;
    }else if(checkSpecial(document.signUpForm.id.value)){
    	alert("id에는 특수문자를 포함할 수 없습니다.!!!");
        document.signUpForm.id.focus();
        return false;
    }else if(checkKor(document.signUpForm.id.value)){
    	alert("id에는 한글을 포함할 수 없습니다.!");
        document.signUpForm.id.focus();
        return false;
    }else if(!document.signUpForm.pw.value.trim()){
        alert(msg_pw);
        document.signUpForm.pw.focus();
        return false;
    }else if(!document.signUpForm.repw.value.trim()){
        alert(msg_repw);
        document.signUpForm.repw.focus();
        return false;
    }else if(document.signUpForm.pw.value != document.signUpForm.repw.value){
        alert(msg_repwcheck);
        document.signUpForm.pw.value = "";
        document.signUpForm.repw.value = "";
        document.signUpForm.pw.focus();
        return false;
    }else if(!checkPasswordPattern(document.signUpForm.pw.value)){
        alert("비밀번호는 숫자,특수문자를 포함하고 8자이상 이어야합니다.!");
        document.signUpForm.pw.value = "";
        document.signUpForm.repw.value = "";
        document.signUpForm.pw.focus();
        return false;
    }else if(!document.signUpForm.name.value.trim()){
         alert(msg_name);
        document.signUpForm.name.focus();
        return false;
    }else if(!document.signUpForm.viewZipcode.value.trim()){
         alert("주소를 검색하세요!");
        document.signUpForm.zipCheck.focus();
        return false;
    }else if(!document.signUpForm.ssn1.value.trim()){
        alert(msg_jumin1);
        document.signUpForm.ssn1.focus();
        return false;
    }else if(!document.signUpForm.ssn2.value.trim()){
        alert(msg_jumin2);
        document.signUpForm.ssn2.focus();
        return false;
    }else if(!ssnValidate(document.signUpForm.ssn1, document.signUpForm.ssn2)){
    	alert("올바른 주민번호가 아닙니다.");
    	document.signUpForm.ssn1.value="";
    	document.signUpForm.ssn2.value="";
    	document.signUpForm.ssn1.focus();
    	return false;
    }else if(!document.signUpForm.email1.value.trim()){
        alert(msg_email1);
        document.signUpForm.email1.focus();
        return false;
    }else if(!document.signUpForm.email2.value && document.signUpForm.email3.value==0){
        alert(msg_email2);
        document.signUpForm.email2.focus();
        return false;
    }else if(!emailCheck(document.signUpForm.email.value)){
        alert("이메일 형식이 아닙니다.!");
        document.signUpForm.email1.value="";
        document.signUpForm.email2.value="";
        document.signUpForm.email1.focus();
        return false;
    }else if(document.signUpForm.checkId.value == 0 && mode === 'insert'){
    	alert(msg_checkId)
    	document.signUpForm.dupChk.focus();
       return false;
    }
}

function onChangeId(){
	if(document.signUpForm.checkId.value != 0){
		document.signUpForm.checkId.value = 0;
	}
}


function confirmId(){
	
	// id 값 입력 안했을때.
	if(!document.signUpForm.id.value){
		alert(msg_id);
		document.signUpForm.id.focus();
		return false;
	}
	/*
	 * 새창 열기
	 *  window.open("파일명", "윈도우 명", "창 속성");
	 *  url="주소?속성="+속성값; -- get방식
	 */
	
	var url="checkId?id="+document.signUpForm.id.value;
	window.open(url, "checkId", "menubar=no, width=400, height=300");
	
}

function orderInfo(order_code){
	var url="orderInfo?order_code="+order_code;
	window.open(url, "상세 내역", "menubar=no, width=1100, height=500");
}

function nextSsn1(){
    if(document.signUpForm.ssn1.value.length >= 6){
        document.signUpForm.ssn2.focus();
    }
}

function nextSsn2(){
    if(document.signUpForm.ssn2.value.length >= 7){
        document.signUpForm.hp1.focus();
    }
}

function nextHp1(){
    if(document.signUpForm.hp1.value.length >= 3){
        document.signUpForm.hp2.focus();
    }
}

function nextHp2(){
    if(document.signUpForm.hp2.value.length >= 4){
        document.signUpForm.hp3.focus();
    }
}

function nextHp3(){
    if(document.signUpForm.hp3.value.length >= 4){
        document.signUpForm.email1.focus();
    }
}

function selectEmailChk(){
    var idx = document.signUpForm.email3.selectedIndex;
   var c =  document.signUpForm.email3[idx].value;
   if(c==0){
       document.signUpForm.email2.value = "";
       document.signUpForm.email2.focus();
   }else{
    document.signUpForm.email2.value=c;
   }
}


function confirmIdCheck(){
	if(!document.confirmform.id.value){
		alert(msg_id);
		document.confirmform.id.focus();
		return false;
	}
}

//opener : window 객체의 open() 하여 열린 새창(=중복 확인창)에서, 열어준 부모창으로 접근할때 사용
function setId(id){
	opener.document.signUpForm.checkId.value = 1;
	opener.document.signUpForm.id.value = id;
	// 현재창 닫기
	self.close();
}

function gotoBookInfo(board_id){
	opener.window.location="bookInfo?board_id="+board_id;
}

function passwdCheck(){
	if(!document.passwdform.pwd.value.trim()){
		alert(msg_pw);
		document.passwdform.pwd.focus();
		return false;
	}
}

function check_all(){
	if(document.getElementById("allCheck").checked){
		for(var i=0; i<document.getElementsByName("chkbox").length; i++){
			document.getElementsByName("chkbox")[i].checked = true; 
		}		
	}else{
		for(var i=0; i<document.getElementsByName("chkbox").length; i++){
			document.getElementsByName("chkbox")[i].checked = false;
		}
	}
}


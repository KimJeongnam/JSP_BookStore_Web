// 공백 체크 함수 공백이 있으면 true 반환
function checkSpace(str) {
	var space_Exp = /\s/g;
	if (space_Exp.test(str)) {
		return false;
	} else {
		return true;
	}
}

// 특수문자 포함시 true 미포함시 false
function checkSpecial(str) {
	var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	if (special_pattern.test(str)) {
		return true;
	} else {
		return false;
	}
}
//한글포함시 true 미포함시 false;
function checkKor(str) {
	if (str.match(".*[ㄱ-ㅎㅏ-ㅣ가-힣]+.*")) {
		return true;
	} else {
		return false;
	}
}

// 비밀번호 체크 함수 숫자,특수문자를 포함하고 8자이상이면 true else false
function checkPasswordPattern(str) {
	var pattern1 = /[0-9]/; // 숫자
	var pattern2 = /[a-zA-Z]/; // 문자
	var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
	if (!pattern1.test(str) || !pattern2.test(str) || !pattern3.test(str)
			|| str.length < 8) {
		return false;
	} else {
		return true;
	}
}


// 이메일 마스크
function emailCheck(email) {
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if (email.match(regExp)!=null) {
		return true
	} else {
		return false
	}
}
function str_cmp(str1, str2) {
	if (str1 == str2) {
		return true;
	} else {
		return false;
	}
}

// 숫자 판별 숫자일시 true
function checkphoneNum(num) {
	var cellExp = /^[0-9]+$/;
	if (!cellExp.test(num)) {
		return true
	} else {
		return false
	}
}


function ssnValidate(ssn1, ssn2) {
    var re = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
    var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    // 이메일이 적합한지 검사할 정규식

    var num1 = ssn1;
    var num2 = ssn2;

    var arrNum1 = new Array(); // 주민번호 앞자리숫자 6개를 담을 배열
    var arrNum2 = new Array(); // 주민번호 뒷자리숫자 7개를 담을 배열

    // -------------- 주민번호 -------------

    for (var i=0; i<num1.value.length; i++) {
        arrNum1[i] = num1.value.charAt(i);
    } // 주민번호 앞자리를 배열에 순서대로 담는다.

    for (var i=0; i<num2.value.length; i++) {
        arrNum2[i] = num2.value.charAt(i);
    } // 주민번호 뒷자리를 배열에 순서대로 담는다.

    var tempSum=0;

    for (var i=0; i<num1.value.length; i++) {
        tempSum += arrNum1[i] * (2+i);
    } // 주민번호 검사방법을 적용하여 앞 번호를 모두 계산하여 더함

    for (var i=0; i<num2.value.length-1; i++) {
        if(i>=2) {
            tempSum += arrNum2[i] * i;
        }
        else {
            tempSum += arrNum2[i] * (8+i);
        }
    } // 같은방식으로 앞 번호 계산한것의 합에 뒷번호 계산한것을 모두 더함

    if((11-(tempSum%11))%10!=arrNum2[6]) {
        return false;
    }else{
    	return true;
    }
}
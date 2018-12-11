<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<%@ include file="basic/settings.jsp"%>
<body>
	<script src="${project}/static/js/signUpScript.js"></script>
	<h2><center>중복 확인 페이지</center></h2>
	<div style="border:1px solid #ccc; border-radius:5px; border-collapse: collapse; width:400px; height:200px; margin:0px auto;">
		<form action="checkId" method="post" name="checkIdForm">
			<c:choose>
				<c:when test="${selectCnt!=0 }"> 
					<table width="300" height="200" style="margin:0px auto;">
						<tr>
							<th colspan="2">
								<span>${id }</span>는 사용할수 없습니다.
							</th>
						</tr>
						
						<tr>
							<th style="width:20%;">ID</th>
							<td>
							<input class="input" type="text" name="id" maxlength="20" required size="20" >
							</td>
						</tr>
						
						<tr>
							<th colspan="2">
								<input class="myButton" type="submit" value="확인">
								<input style="margin-left:25px;" class="btn-danger" type="reset" value="취소" onclick="self.close();">
							</th>
						</tr>
					</table>
				</c:when>
				<c:otherwise>
					<table width="300" height="200" style="margin:0px auto;">
						<tr>
							<td align="center">
								<span>${id }</span>는 사용할 수 있습니다.
							</td>
						</tr>
						
						<tr>
							<th >
								<input class="myButton" style="background-color: dodgerblue; "type="button" value="확인" onclick="setId('${id }');">
								<input type="reset" class="btn-danger" value="취소" onclick="self.close();">
							</th>
						</tr>
					</table>
				</c:otherwise>
			</c:choose>
		</form>
	</div>
</body>
</html>
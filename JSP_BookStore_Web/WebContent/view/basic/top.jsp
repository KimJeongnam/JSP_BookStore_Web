<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav>
	<div class="nav-header">
		<div class="logo">
			<a href="index">J BOOKS</a>
		</div>

		<div class="login">
			<c:choose>
				<c:when test="${sessionScope.userId != null }">
				<a href="#" style="visibility: hidden;" id="myBtn">로그인</a> 
				<a href="#" onclick="window.location='logout'"><%= session.getAttribute("userId") %>
					/로그아웃
				</a>
				</c:when>
				<c:otherwise>
					<a href="#" id="myBtn">로그인 / 회원가입</a>
				</c:otherwise>
			</c:choose>
		</div>

		<div id="myModal" class="modal">
			<!-- Modal content -->
			<div class="modal-content">
				<span class="close">&times;</span>

				<div id="login-table">
				<h1>로그인</h1>
					<form action="login" method="get">
						<table style="width:100%;">
							<tr>
								<th>아이디</th>
							</tr>
							
							<tr>
								<td><input type="text" name="id" maxlength="20" required autofocus></td>
							</tr>

							<tr>
								<th>비밀번호</th>
							</tr>
							
							<tr>
								<td><input type="password" name="pw" maxlength="20" required></td>
							</tr>
							
							<tr>
								<td><input type="submit" value="로 그 인"></td>
							</tr>
							
							<tr>
								<td><input type="button" value="회 원 가 입" onclick="window.location='signUpForm'"></td>
							</tr>
						</table>
					</form>
				</div>
			</div>

		</div>
	</div>

	<div class="nav-body">
	<table width="100%" height="80px">
		<tr>
			<td align="right">
				<form action="" method="post">
					<fieldset>
						<input type="text"> <input type="button" value="검색">
					</fieldset>
				</form>
				
			</td>
			
			<c:if test="${sessionScope.userId != null }">
				<td align="right" width="20%">
					<ul>
						<li><a href="#">마이페이지</a>
							<ul>
								<li><a href="userinfo.jsp">회원 정보</a></li>
								<li><a href="#">주문 내역</a></li>
								<li><a href="#">찜 목록</a></li>
							</ul></li>
						<li><a href="#">장바구니</a></li>
					</ul>
				</td>
			</c:if>
		</tr>
	</table>
	</div>
</nav>

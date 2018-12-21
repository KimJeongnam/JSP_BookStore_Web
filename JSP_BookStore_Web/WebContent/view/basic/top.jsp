<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav>
	<div class="nav-header">
		<div class="logo">
			<a href="index">J BOOKS</a>
		</div>

		<div class="login">
			<c:choose>
				<c:when test="${sessionScope.userId != null }">
					<a href="#" style="visibility: hidden;" id="myBtn">로그인</a>
					<a href="#" onclick="window.location='logout'"><%=session.getAttribute("userId")%>
						/로그아웃 </a>
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
						<table style="width: 100%;">
							<tr>
								<th>아이디</th>
							</tr>

							<tr>
								<td><input type="text" name="id" maxlength="20" required
									autofocus></td>
							</tr>

							<tr>
								<th>비밀번호</th>
							</tr>

							<tr>
								<td><input type="password" name="pw" maxlength="20"
									required></td>
							</tr>

							<tr>
								<td><input type="submit" value="로 그 인"></td>
							</tr>

							<tr>
								<td><input type="button" value="회 원 가 입"
									onclick="window.location='signUpForm'"></td>
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
				<td class="text-left">
					<form action="" method="post">
						<fieldset>
							<input class="whiteButton" type="text" autofocus>
							<input class="whiteButton" type="submit" value="검색" >
						</fieldset>
					</form>

				</td>

				<c:if test="${sessionScope.userId != null }">
					<td align="right" width="20%">
						<div class="btn"></div>
						<div onclick="history.back();" class="page_cover"></div>
						<div id="menu">
							<div onclick="history.back();" class="menu-close"></div>
							<div class="menu-list">
								<ul>
									<li><span><i class="fas fa-angle-left fa-1x" style="color:#ccc;"></i> 마이 페이지</span>
										<ul>
											<li>회원 정보</li>
											<li onclick="window.location='orders'">주문 내역</li>
											<li>찜 목록</li>
										</ul>
									</li>
									<li onclick="window.location='cartList'">장바구니</li>
								</ul>
							</div>

						</div>
					</td>
				</c:if>
			</tr>
		</table>
	</div>
</nav>

<script type="text/javascript">
	$(".btn").click(function() {
		$("#menu,.page_cover,html").addClass("open");
		window.location.hash = "#open";
	});

	window.onhashchange = function() {
		if (location.hash != "#open") {
			$("#menu,.page_cover,html").removeClass("open");
		}
	};
</script>

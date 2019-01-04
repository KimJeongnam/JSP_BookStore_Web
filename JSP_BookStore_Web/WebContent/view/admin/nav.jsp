<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav>
	<div class="nav-header">
		<div class="logo">
			<a href="${project }/index">J BOOKS</a>
		</div>
		<div class="login">
			<c:if test="${adminId != null }">
				<a href="#" onclick="window.location='logout'">로그아웃</a>
			</c:if>
		</div>
		<div class="nav-body">
			<table class="admin-navtable" width="100%" height="80px">
				<tr>
					<td class="text-left">
						<a href="${project }/Admin/index"><h2 style="color: white;">관리자 페이지</h2></a>
					</td>
					<c:if test="${adminId != null }">
						<td>
							<div class="btn"></div>
							<div onclick="history.back();" class="page_cover"></div>
							<div id="menu">
								<div onclick="history.back();" class="menu-close"></div>
								<div class="menu-list">
									<ul>
										<li><a href="bookManagePage">재고 관리</a></li>
										<li><a href="#">카테고리 관리(미구현)</a></li>
										<li><a href="orderList">주문 관리</a></li>
									</ul>
								</div>
							</div>
						</td>
					</c:if>
				</tr>
			</table>
		</div>
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
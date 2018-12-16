<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../basic/settings.jsp"%>
<body>
	<%@ include file="nav.jsp"%>

	<section>
		<div class="container">
			<div class="panel">
				<table class="table" align="center" width="1000">
					<tr>
						<th rowspan="2"><img src="${dto.image_path }" width="300">

						</th>
						<td width="60%" height="30%" colspan="3"
							style="vertical-align: top;">
							<p>
								<b>${dto.super_name }</b> > ${dto.category_name }
							</p>
							<h2>${dto.title }</h2>
							<br> <a style="font-size: 15px;">${dto.author } |
								${dto.publisher } | ${dto.publish_date } | <br>
									남은수량 ${dto.stock }개
						</a><br>
						<br>
						<!--================= 레이팅(평점) 찍기 ===================-->
						<c:if test="${dto.rating > 0 }">
							<c:set var="full_star" value="${dto.rating/2 }" /> 
							<c:set var="n" value="${(full_star*10)%10 }" /> 
							<fmt:parseNumber var="number" value="${full_star }" integerOnly="true"/>
							<c:forEach var="i"	begin="1" end="${full_star }">
								<i class="fas fa-star fa-2x"></i>
							</c:forEach>
							<c:choose>
								<c:when test="${n >= 5}">
									<i class="fas fa-star-half-alt fa-2x"></i>
									<c:forEach var="j" begin="1" end="${5-number-1 }">
										<i class="far fa-star fa-2x"></i>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="j" begin="1" end="${5-number }">
										<i class="far fa-star fa-2x"></i>
									</c:forEach>
								</c:otherwise>
							</c:choose> 
								<b style="font-size: 25px;"><fmt:formatNumber value="${dto.rating}" pattern=".0"/></b>
						</c:if>
						<!--================= 레이팅(평점) 찍기 ===================-->
							
						</td>
					</tr>

					<tr>
						<td>판매가</td>
						<td style="color: red;" width="30%"><b
							style="font-size: 20px;"><fmt:formatNumber value="${dto.price}" pattern="#,###"/></b>원</td>

						<c:if test="${userId!=null}">
							<td><input class="myButton" type="button" value="장바구니에 넣기"><br>
							<br> <input class="myButton" type="button" value="바로 구매">
							</td>
						</c:if>
					</tr>

					<tr>
						<td colspan="4" style="padding: 30px; vertical-align: top;"
							word-break:break-all>${dto.context }</td>
					</tr>
				</table>
				
				<table width="1000" align="center">
					<tr>
						<td align="right">
							<input class="myButton" type="button" onclick="window.location='bookModifyForm?board_id=${dto.board_id}&pageNum=${param.pageNum }';" value="책 수정">
							<input class="myButton" type="button" onclick="window.location='bookManagePage?pageNum=${param.pageNum}';" value="목록">
						</td>
					</tr>
				</table>
			</div>
		</div>
	</section>

	<script type="text/javascript">
		$(function() {
	<%@ include file="../basic/alertMSG.jsp"%>
		});
	</script>
</body>
</html>
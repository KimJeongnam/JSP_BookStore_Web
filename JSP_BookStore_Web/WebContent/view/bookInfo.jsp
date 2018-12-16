<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="basic/settings.jsp" />
<body>
	<%@ include file="basic/top.jsp"%>
	<jsp:include page="basic/aside.jsp" />
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	
	<script type="text/javascript">
		function checkStock(){
			if(document.getElementsByName("wish_stock")[0].value < 0){
				alert("0개 이하로는 주문이 불가능 합니다.");
				document.getElementsByName("wish_stock")[0].value=0;
			}
		}
		
		function cartAddDo(book_code){
			var stock = document.getElementsByName("wish_stock")[0].value;
			if(stock <= 0){
				alert("0개 이하로는 주문이 불가능 합니다.");
				return;
			}
			window.location="cartAddDo?book_code="+book_code+"&wish_stock="+stock;
		}
	</script>
	
	<section>
		<div class="container">
			<div class="panel">
			<c:choose>
				<c:when test="${category_id != null }">
					<i class="fas fa-angle-left fa-3x" onclick="window.location='bookList?pageNum=${pageNum}';"></i>
				</c:when>
				<c:otherwise>
					<i class="fas fa-angle-left fa-3x" onclick="window.location='bookList?pageNum=${pageNum}&category_id=${category_id }';"></i>
				</c:otherwise>
			</c:choose>
			
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
								${dto.publisher } | ${dto.publish_date } 
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
						<td style="color: red;" width="25%"><b
							style="font-size: 20px;"><fmt:formatNumber value="${dto.price}" pattern="#,###"/></b>원</td>

						<!-- ========================== 유저 세션 있을시 START ========================== -->
						<c:if test="${userId!=null}">
							<td>
							<input type="hidden" name="book_code" value="${dto.book_code }">
							<input type="hidden" name="pageNum" value="${pageNum }">
							<c:if test="${category_id != null }">
								<input type="hidden" name="category_id" value="${category_id}">
							</c:if>
							<input class="myButton" type="button" value="찜"><br><br> 
							<c:choose>
								<c:when test="${dto.stock > 0 }">
								수량&nbsp;<input type="number" name="wish_stock" width="100" value="0" min="0"><br><br>
								<input class="myButton" type="button" value="장바구니에 넣기"
									onclick="cartAddDo(${dto.book_code});"><br><br>
								<form action="nowBuy" method="post" name="nowBuyForm">
									<input class="myButton" type="submit" value="바로 구매"><br><br>
								</form>
								</c:when>
								<c:otherwise>
								<span style="font-weight: bold; color:red; font-size: 25px;">품 절</span><br><br>
								</c:otherwise>
							</c:choose>
							</td>
						</c:if>
						<!-- ========================== 유저 세션 있을시 END ========================== -->
					</tr>

					<tr>
						<td colspan="4" style="padding: 30px; vertical-align: top;"
							word-break:break-all>${dto.context }</td>
					</tr>
				</table>
				
			</div>
		</div>
	</section>

	<script type="text/javascript">
		$(function() {
			<%@ include file="basic/modalAndSliderScript.jsp"%>
			<%@ include file="basic/alertMSG.jsp" %>
		});
	</script>
</body>
</html>
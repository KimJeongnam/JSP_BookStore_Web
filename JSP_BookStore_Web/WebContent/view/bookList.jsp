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
	
	<section>
		<div class="container">
			<c:choose>
				<c:when test="${c_category != null }">
					<span style="font-size: 25px; font-weight: bold;">${p_category.category_name }</span>&nbsp;>&nbsp;
					<span style="font-size: 25px; font-weight: normal; color: #646464;">${c_category.category_name }</span>
				</c:when>
				<c:otherwise>
					<span style="font-size: 25px; font-weight: bold;">All</span>
				</c:otherwise>
			</c:choose>
			
			

			<table style="margin:0px auto;">
			<c:set var="cnt" value="0"/>
			<c:forEach var="i" begin="0" end="2">
				<tr>
				<c:forEach var="j" begin="0" end="4">
					<c:choose>
						<c:when test="${fn:length(dtos) > cnt }">
							<c:set var="dto" value="${dtos[cnt]}"/>
							<td width="150px" height="350px" align="center" style="padding:30px;">
								<c:choose>
									<c:when test="${c_category != null }">
									<a href="bookInfo?board_id=${dto.board_id }&pageNum=${pageNum}&category_id=${c_category.category_id}">
									</c:when>
									<c:otherwise>
									<a href="bookInfo?board_id=${dto.board_id }&pageNum=${pageNum}">
									</c:otherwise>
								</c:choose>
								<img src="${dto.image_path }" width="140px" height="200px"><br></a>
								
								<b>${dto.title }</b><br>
								<a>${dto.author }</a><br>
								<c:choose>
									<c:when test="${dto.stock >0 }">
										<b>가격 : </b>
										<span style="color:red; font-weight: bold;">
											<fmt:formatNumber value="${dto.price}" pattern="#,###"/>
										</span>&nbsp;원<br>
									</c:when>
									<c:otherwise>
										<span style="color:red; font-weight: bold;">품 절</span>
									</c:otherwise>
								</c:choose>
								
								<!--================= 레이팅(평점) 찍기 ===================-->
								<c:if test="${dto.rating > 0 }">
									<c:set var="full_star" value="${dto.rating/2 }" /> 
									<c:set var="n" value="${(full_star*10)%10 }" /> 
									<fmt:parseNumber var="number" value="${full_star }" integerOnly="true"/>
									<c:forEach var="i"	begin="1" end="${full_star }">
										<i class="fas fa-star fa-1x"></i>
									</c:forEach>
									<c:choose>
										<c:when test="${n >= 5}">
											<i class="fas fa-star-half-alt fa-1x"></i>
											<c:forEach var="j" begin="1" end="${5-number-1 }">
												<i class="far fa-star fa-1x"></i>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach var="j" begin="1" end="${5-number }">
												<i class="far fa-star fa-1x"></i>
											</c:forEach>
										</c:otherwise>
									</c:choose> 
									<b style="font-size: 25px;"><fmt:formatNumber value="${dto.rating}" pattern=".0"/></b>
								</c:if>
								<!--================= 레이팅(평점) 찍기 ===================-->
							</td>
						</c:when>
						<c:otherwise>
							<!-- <td width="150px" height="350px" align="center" style="padding:30px;"></td> -->
						</c:otherwise>
					</c:choose>
					<c:set var="cnt" value="${cnt+1 }"/>
				</c:forEach>
				</tr>
			</c:forEach>
			</table>
	
			<!--==================================================페이징 처리 START ==================================================  -->
			<table style="width: 100%;" align="center">
				<tr>
					<th class="text-center">
						<%-- 게시글이 있으면 --%>
							<%-- 처음 --%>
							<c:choose>
								<c:when test="${c_category != null }">
									<c:if test="${cnt > 0 }">
										<c:if test="${startPage > pageBlock }">
											<a href="bookList&category_id=${c_category.category_id}">[◀◀]</a>
											<a href="bookList?pageNum=${startPage - pageBlock }&category_id=${c_category.category_id}">[◀&nbsp;prev]</a>
										</c:if>
			
										<c:forEach var="page" begin="${startPage }" end="${endPage }">
											<c:choose>
												<c:when test="${currentPage == page }">
													<span><b>[${page }]</b></span>
												</c:when>
												<c:otherwise>
													<a href="bookList?pageNum=${page }&category_id=${c_category.category_id}">[${page }]</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
			
										<c:if test="${pageCount > endPage }">
											<a href="bookList?pageNum=${startPage + pageBlock }&category_id=${c_category.category_id}">[next&nbsp;▶]</a>
											<a href="bookList?pageNum=${pageCount }&category_id=${c_category.category_id}">[▶▶]</a>
										</c:if>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${cnt > 0 }">
										<c:if test="${startPage > pageBlock }">
											<a href="bookList">[◀◀]</a>
											<a href="bookList?pageNum=${startPage - pageBlock }">[◀&nbsp;prev]</a>
										</c:if>
			
										<c:forEach var="page" begin="${startPage }" end="${endPage }">
											<c:choose>
												<c:when test="${currentPage == page }">
													<span><b>[${page }]</b></span>
												</c:when>
												<c:otherwise>
													<a href="bookList?pageNum=${page }">[${page }]</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
			
										<c:if test="${pageCount > endPage }">
											<a href="bookList?pageNum=${startPage + pageBlock }">[next&nbsp;▶]</a>
											<a href="bookList?pageNum=${pageCount }">[▶▶]</a>
										</c:if>
									</c:if>
								</c:otherwise>
							</c:choose>
							
					</th>
				</tr>
			</table>
			<!--==================================================페이징 처리 END ==================================================  -->
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
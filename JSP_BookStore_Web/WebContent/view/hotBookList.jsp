<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cnt" value="0" />
<%--  ==================================  슬라이드 index 0, 1, 2 ==================================--%>
<c:forEach var="i" begin="0" end="2">
	<div style="width: 100%; height: 450px;">
		<table style="margin: 0px auto;">
			<tr>
				<%--  ==================================  슬라이드 내부 책5권 표시 ==================================--%>
				<c:forEach var="j" begin="0" end="4">
					<c:set var="cnt" value="${cnt+1 }" />
					<c:if test="${fn:length(hotBooks)>=cnt}">
						<td width="150px" height="350px" align="center"
							style="padding: 30px;">
							<c:set var="book" value="${hotBooks[cnt-1]}" />
							<div style="cursor:pointer; width:140px; height:200px; background-image: url('${book.image_path }'); background-size:cover;"
								onclick="window.location='bookInfo?board_id=${book.board_id }'">
							</div> 
							<b>${book.title }</b><br> 
							<a>${book.author }</a><br> 
							<!--================= 레이팅(평점) 찍기 ===================-->
							<c:if test="${book.rating > 0 }">
								<c:set var="full_star" value="${book.rating/2 }" /> 
								<c:set var="n" value="${(full_star*10)%10 }" /> 
									<fmt:parseNumber var="number" value="${full_star }" integerOnly="true" /> 
								<c:forEach var="i" begin="1" end="${full_star }">
									<i class="fas fa-star"></i>
								</c:forEach> <c:choose>
									<c:when test="${n >= 5}">
										<i class="fas fa-star-half-alt"></i>
										<c:forEach var="j" begin="1" end="${5-number-1 }">
											<i class="far fa-star"></i>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="j" begin="1" end="${5-number }">
											<i class="far fa-star"></i>
										</c:forEach>
									</c:otherwise>
								</c:choose> 
								<b><fmt:formatNumber value="${book.rating}" pattern=".0"/></b>
							</c:if>
							<!--================= 레이팅(평점) 찍기 ===================-->
							
						</td>
					</c:if>
				</c:forEach>
				<%--  ==================================  슬라이드 내부 책5권 표시 ==================================--%>
			</tr>
		</table>
	</div>
</c:forEach>
<%--  ==================================  슬라이드 index 0, 1, 2 ==================================--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="basic/settings.jsp"/>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
    <section>
        <div class="container">
            	<h3>상세 목록</h3>
            	
            	<c:choose>
            		<c:when test="${dtos.size() > 3 }">
            			<table id="cartTable" style="width:1280px;">
            		</c:when>
            		<c:otherwise>
            			<table id="cartTable" style="width:1295px;">
            		</c:otherwise>
            	</c:choose>
            	
            		<colgroup>
            			<col width="5%">
            			<col width="20%">
            			<col width="10%">
            			<col width="10%">
            			<col width="10%">
            			<col width="10%">
            		</colgroup>
            		<tr>
						<th>No</th>
            			<th>상품명</th>
            			<th>단가</th>
            			<th>수량</th>
            			<th>합계</th>
            			<th>주문</th>
            		</tr>
            	</table>
            		
            		
            	<div style="width:1295px; height:600px; overflow: auto;">
            		<table id="cartTable">
            			<colgroup>
            				<col width="5%">
            				<col width="20%">
            				<col width="10%">
            				<col width="10%">
            				<col width="10%">
            				<col width="10%">
            			</colgroup>
            			<c:choose>
            				<c:when test="${dtos == null }">
            					<td colspan="7">* Error. *</td>
            				</c:when>
            				<c:otherwise>
            					<c:forEach var="dto" items="${dtos }" varStatus="status">
            						<tr>
										<td>${status.index+1 }</td>
										<td style="padding:10px;">
											<a href="#">
												<img src="${dto.image_path }" width='100'><br>
												${dto.title }
											</a>
										</td>
										<td align="center"><fmt:formatNumber value="${dto.price }" pattern="#,###"/>원</td>
										<td align="center">${dto.wish_stock }</td>
										<td align="center"><fmt:formatNumber value="${dto.total_price }" pattern="#,###"/>원</td>
										<td>
											<input class="btn-danger" style="width:130px; margin-bottom:5px;" type="button" value="삭제"
												onclick="actionCartDel('${dto.title}', '${dto.book_code }');">
											<input class="myButton" style="width:130px;" type="button" value="바로 구매"
												onclick="cartNowBuy('${dto.title}', '${dto.book_code}', '${dto.wish_stock }')">
										</td>
            						</tr>
            					</c:forEach>
            				</c:otherwise>
            			</c:choose>
            		</table>
            	</div>
            	
            	<table width="100%">
            		<c:if test="${dtos!= null }">
            		 	<tr>
            		 		<td align="right" style="padding:20px;">
            		 			<span style="font-size:20px;">
            		 				총 금액 : <span style="font-weight: bold; font-size:23px; color:red;">
            		 				<fmt:formatNumber value="${totalPrice }" pattern="#,###"/>
            		 				</span>원
            		 			</span> 
            		 		</td>
            		 	</tr>
            		</c:if>
            	</table>
        </div>
    </section>
</body>
</html>
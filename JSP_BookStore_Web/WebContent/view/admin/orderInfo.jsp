<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../basic/settings.jsp"%>
<body>
	<script src="${project}/static/js/signUpScript.js"></script>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ include file="nav.jsp"%>
   
    <section>
        <div class="container" style="top:0px; margin:10px; margin-left:30px;">
            	<h3>상세 목록</h3>
            	
            	<c:choose>
            		<c:when test="${dtos.size() > 3 }">
            			<table id="cartTable" style="width:1000px;">
            		</c:when>
            		<c:otherwise>
            			<table id="cartTable" style="width:1000px;">
            		</c:otherwise>
            	</c:choose>
            	
            		<colgroup>
            			<col width="5%">
            			<col width="65%">
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
            		</tr>
            	</table>
            		
            		
            	<div style="width:1000px; height:300px; overflow: auto;">
            		<table id="cartTable">
            			<colgroup>
	            			<col width="5%">
	            			<col width="65%">
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
											<%-- <a href="bookInfo?board_id=${dto.board_id }"> --%>
											<a href="#" onclick="gotoBookInfo('${dto.board_id}');">
												<img src="${dto.image_path }" width='100'><br>
												${dto.title }
											</a>
										</td>
										<td align="center"><fmt:formatNumber value="${dto.price }" pattern="#,###"/>원</td>
										<td align="center">${dto.buy_stock }</td>
										<td align="center"><fmt:formatNumber value="${dto.total_price }" pattern="#,###"/>원</td>
            						</tr>
            					</c:forEach>
            				</c:otherwise>
            			</c:choose>
            		</table>
            	</div>
            	
            	<table width="1000px">
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
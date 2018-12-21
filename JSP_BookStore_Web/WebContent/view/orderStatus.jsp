<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<jsp:include page="basic/settings.jsp"/>
<body>
	<script src="${project}/static/js/signUpScript.js"></script>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   <%@ include file="basic/top.jsp" %>
   <jsp:include page="basic/aside.jsp"/>
   
    <section>
        <div class="container">
            	<h3>주문내역</h3>
            	<c:choose>
            		<c:when test="${dtos.size() > 13 }">
            			<table id="cartTable" style="width:1280px;">
            		</c:when>
            		<c:otherwise>
            			<table id="cartTable" style="width:1295px;">
            		</c:otherwise>
            	</c:choose>
	            	<colgroup>
	            		<col width="5%">
	            		<col width="40%">
	            		<col width="20%">
	            		<col width="10%">
	            		<col width="15%">
	            		<col width="10%">
	            	</colgroup>
            		<tr>
            			<th><label for="allCheck"><input type="checkbox" id="allCheck"
									onchange="check_all();"></label></th>
            			<th>주문 코드</th>
            			<th>주문일</th>
            			<th>주문건수</th>
            			<th>금액</th>
            			<th>상태</th>
            		</tr>
            	</table>
            		
            		
            	<div style="width:1295px; height:600px; overflow: auto;">
            		<table id="cartTable">
            			<colgroup>
	            			<col width="5%">
	            			<col width="40%">
	            			<col width="20%">
	            			<col width="10%">
	            			<col width="15%">
	            			<col width="10%">
	            		</colgroup>
            			<c:choose>
            				<c:when test="${dtos == null }">
            					<td colspan="7">* 주문내역이 비어있습니다. *</td>
            				</c:when>
            				<c:otherwise>
            					<c:forEach var="dto" items="${dtos }" varStatus="status">
            						<tr>
            							<td align="center"><label for="check${status.index }"><input
												type="checkbox" name="chkbox" id="check${status.index }"
												value="${dto.order_code }"></label></td>
										<td style="padding:10px;">
											<a href="#">
												${dto.order_code }
											</a>
										</td>
										<td><fmt:formatDate value="${dto.order_date }" pattern="yyyy년 MM월 dd일 HH:mm:ss "/></td>
										<td>${dto.order_cnt }</td>
										<td align="center"><fmt:formatNumber value="${dto.total_price }" pattern="#,###"/>원</td>
										<td>
											${dto.status }
										</td>
            						</tr>
            					</c:forEach>
            				</c:otherwise>
            			</c:choose>
            		</table>
            	</div>
        </div>
    </section>
	<script type="text/javascript">
	    $(function(){
	    	<%@ include file="basic/openLoginModal.jsp" %>
	    	<%@ include file="basic/alertMSG.jsp" %>
	    });
    </script>
</body>
</html>
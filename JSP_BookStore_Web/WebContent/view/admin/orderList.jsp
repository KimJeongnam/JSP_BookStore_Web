<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<%@ include file="../basic/settings.jsp"%>
<body>
	<script src="${project}/static/js/signUpScript.js"></script>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   	<%@ include file="nav.jsp"%>
   	
   	<script type="text/javascript">
   		function buyConfirm(order_code, cnt, total_price){
   			if(confirm("주문코드 : '"+order_code+"' \n("+cnt+" 건, 금액 : "+total_price+" 원) \n"+"주문 요청을 승인 하시겠습니까?"))
				window.location='orderConfirm?order_code='+order_code;   			
   		}
   		
   		function onChangeSelectStatus(){
   			var status = document.getElementById("selectStatus").value;
   			
   			window.location='orderList?status='+status;
   		}
   	</script>
   
    <section>
        <div class="container">
        
        
        <select id="selectStatus" class="whiteButton" onchange="onChangeSelectStatus();" 
        	style="font-size:20px; padding-top:0px; height:35px;" size="1">
        	<c:forEach var="entry" items="${statusMap }">
        		<c:choose>
	        		<c:when test="${status == entry.key }">
	        			<option value="${entry.key }" selected="selected">${entry.value }</option>
	        		</c:when>
	        		<c:otherwise>
	        			<option value="${entry.key }">${entry.value }</option>
	        		</c:otherwise>
        		</c:choose>
        		
        		
        	</c:forEach>
        </select>
        
            	<h3>${statusMap[status] } 내역 (${dtos.size() } 건)</h3>
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
	            		<col width="30%">
	            		<col width="20%">
	            		<col width="10%">
	            		<col width="15%">
	            		<col width="10%">
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
            			<th></th>
            		</tr>
            	</table>
            		
            		
            	<div style="width:1295px; height:600px; overflow: auto;">
            		<table id="cartTable">
            			<colgroup>
	            			<col width="5%">
		            		<col width="30%">
		            		<col width="20%">
		            		<col width="10%">
		            		<col width="15%">
		            		<col width="10%">
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
											<a onclick="orderInfo('${dto.order_code}');" href="#">
												${dto.order_code }
											</a>
										</td>
										<td><fmt:formatDate value="${dto.order_date }" pattern="yyyy년 MM월 dd일 HH:mm:ss "/></td>
										<td>${dto.order_cnt }</td>
										<td align="center"><fmt:formatNumber value="${dto.total_price }" pattern="#,###"/>원</td>
										<td>
											${dto.status }
										</td>
										
										<td>
											<c:if test="${statusMap.BUY_ASK == dto.status }">
												<input style="padding:10px; margin-top:5px; margin-bottom:5px;" 
													class="myButton" type="button" value="주문 요청 수락"
													onclick="buyConfirm('${dto.order_code}', '${dto.order_cnt }', '<fmt:formatNumber value="${dto.total_price }" pattern="#,###"/>');">
												<input style="padding:10px; margin-top:5px; margin-bottom:5px;"
													class="btn-danger" type="button" value="주문 요청 취소">
											</c:if>
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
		$(function (){
			<%@ include file="../basic/alertMSG.jsp"%>
		});
	</script>
</body>
</html>
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
   
    <script type="text/javascript">
    	function actionCartDel(title, book_code){
    		if(confirm("'"+title+"' 장바구니에서 삭제하시겠습니까?"))
	    		window.location='cartDel?book_code='+book_code;
    	}
		
    	function cartNowBuy(title, book_code, wish_stock){
    		if(confirm("'"+title+"' 바로 구매하시겠습니까?"))
	    		window.location='cartNowBuy?book_code='+book_code+'&wish_stock='+wish_stock;
    	}
    	
    	function cartsDelPost() {
    		var form = document.createElement("form");
    		form.setAttribute("charset", "UTF-8");
    		form.setAttribute("method", "Post"); // Get 또는 Post 입력
    		form.setAttribute("action", "cartsDel");
			
    		var cnt=0;
    		for(var i=0; i<document.getElementsByName("chkbox").length; i++){
    			if(document.getElementsByName("chkbox")[i].checked){
    				var hiddenField = document.createElement("input");
    	    		hiddenField.setAttribute("type", "hidden");
    	    		hiddenField.setAttribute("name", "chkbox");
    	    		hiddenField.setAttribute("value", document.getElementsByName("chkbox")[i].value);
    	    		form.appendChild(hiddenField);	
    	    		cnt++;
    			}
    		}
    		
    		if(!confirm("총 '"+cnt+"' 권 장바구니에서 삭제하시겠습니까?"))
    			return;
    		
    		document.body.appendChild(form);
    		  
    		form.submit();
    	}
    	
    	
    </script>
    <section>
        <div class="container">
            	<!-- <table class="cartStatus">
            		<tr>
            			<td style="background-color:#0174DF; color:white;">
            			카트
            			</td>
            			<td>
            			결제
            			</td>
            			<td>
            			완료
            			</td>
            		</tr>
            	</table> -->
            	<h3>장바구니</h3>
            	
            	<c:choose>
            		<c:when test="${dtos.size() > 3 }">
            			<table id="cartTable" style="width:1280px;">
            		</c:when>
            		<c:otherwise>
            			<table id="cartTable" style="width:1295px;">
            		</c:otherwise>
            	</c:choose>
            	
            		<colgroup>
            			<col width="3%">
            			<col width="5%">
            			<col width="20%">
            			<col width="10%">
            			<col width="10%">
            			<col width="10%">
            			<col width="10%">
            		</colgroup>
            		<tr>
            			<th><label for="allCheck"><input type="checkbox" id="allCheck"
									onchange="check_all();"></label></th>
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
            				<col width="3%">
            				<col width="5%">
            				<col width="20%">
            				<col width="10%">
            				<col width="10%">
            				<col width="10%">
            				<col width="10%">
            			</colgroup>
            			<c:choose>
            				<c:when test="${dtos == null }">
            					<td colspan="7">* 장바구니가 비어있습니다. *</td>
            				</c:when>
            				<c:otherwise>
            					<c:forEach var="dto" items="${dtos }" varStatus="status">
            						<tr>
            							<td align="center"><label for="check${status.index }"><input
												type="checkbox" name="chkbox" id="check${status.index }"
												value="${dto.book_code }"></label></td>
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
            			<tr>
            				<td align="right">
            					<input class="myButton" style="margin-right:10px;" type="button" value="선택 구매">
	            				<input class="btn-danger" type="button" onclick="cartsDelPost();" value="선택 삭제">
            				</td>
            			</tr>
            		</table>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<jsp:include page="basic/settings.jsp"/>
<body>
   <%@ include file="basic/top.jsp" %>
   <jsp:include page="basic/aside.jsp"/>
    
    <%
    	ArrayList<Map<String, String>> cartlist = new ArrayList<Map<String, String>>();
    	Map<String, String> cart = new HashMap<String, String>();
    	cart.put("image", "../images/구해줘.jpeg");
    	cart.put("name", "구해줘");
    	cart.put("price", "12,000원");
    	cart.put("stock", "1");
    	cart.put("totalprice", "12,000원");
    	cartlist.add(cart);
    	
    	cart = new HashMap<String, String>();
    	cart.put("image", "../images/브루크린의_소녀.jpeg");
    	cart.put("name", "브루크린의 소녀");
    	cart.put("price", "13,000원");
    	cart.put("stock", "2");
    	cart.put("totalprice", "26,000원");
    	cartlist.add(cart);
    	
    	cart = new HashMap<String, String>();
    	cart.put("image", "../images/종이여자.jpeg");
    	cart.put("name", "종이여자");
    	cart.put("price", "15,000원");
    	cart.put("stock", "5");
    	cart.put("totalprice", "75,000원");
    	cartlist.add(cart);
    %>
    <section>
        <div class="container">
            		<table class="cartStatus">
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
            		</table>
            		
            		<div class="tablebox">
            		<table id="cartTable">
            		<colgroup>
            			<col width="5%">
            			<col width="15%">
            			<col width="20%">
            			<col width="10%">
            			<col width="10%">
            			<col width="20%">
            			<col width="20%">
            		</colgroup>
            			<tr>
            				<th><input type="checkbox" name="carts"></th>
            				<th colspan="2">상품명</th>
            				<th>단가</th>
            				<th>수량</th>
            				<th>합계</th>
            				<th>주문</th>
            			</tr>
            			
            			<%
            				if(cartlist.size()==0){
            					%>
            					<td colspan="6">* 장바구니가 비어있습니다. *</td>
            					<%
            				}else{
	            				for(Map<String, String> data : cartlist){
	            					out.println("<tr>");
	            					out.println("<td><input type='checkbox'></td>");
	            					out.println("<td width='100'><img src='"+data.get("image")+"' width='100'></td>");
	            					out.println("<td style='text-align:center;'>"+data.get("name")+"</td>");
	            					out.println("<td>"+data.get("price")+"</td>");
	            					out.println("<td>"+data.get("stock")+"</td>");
	            					out.println("<td>"+data.get("totalprice")+"</td>");
	            					out.println("<td><input class='button btn-remove' type='button' value='삭제'><input class='button' type='button' value='구매'></td>");
	            					out.println("</tr>");
	            					
	            				}
            				}
            			%>
            		</table>
            		</div>
            		<div align="right" style="margin-top:20px;">
            			<input class="button" type="button" value="전체 구매">
            		</div>
        </div>
    </section>

</body>
</html>
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
    
    <section>
       <div class="container" >
        <h1>해외</h1>
        <h3>소설/시/희곡</h3>
	        <%
			ArrayList<Map<String, String>> books= new ArrayList<Map<String,String>>();
			Map<String, String> book = new HashMap<String, String>();
			book.put("image", "../images/종이여자.jpeg");
			book.put("name", "종이여자");
			book.put("author", "기욤 뮈소");
			book.put("price", "30,000");
	
			books.add(book);
			
			book = new HashMap<String, String>();
			book.put("image", "../images/구해줘.jpeg");
			book.put("name", "구해줘");
			book.put("author", "기욤 뮈소");
			book.put("price", "31,000");
	
			books.add(book);
			
			book = new HashMap<String, String>();
			book.put("image", "../images/센트럴파크.jpeg");
			book.put("name", "센트럴파크");
			book.put("author", "기욤 뮈소");
			book.put("price", "31,500");
	
			books.add(book);
			
			book = new HashMap<String, String>();
			book.put("image", "../images/브루크린의_소녀.jpeg");
			book.put("name", "브루크린의 소녀");
			book.put("author", "기욤 뮈소");
			book.put("price", "30,000");
	
			books.add(book);
			
			book = new HashMap<String, String>();
			book.put("image", "../images/제0호.jpeg");
			book.put("name", "제0호");
			book.put("author", "움베르토 에코");
			book.put("price", "32,000");
			
			books.add(book);
		%>
		
		<table align="center">
			<%
				int cnt = 0;
				for(int i=0; i<3; i++){
					%>
					<tr>
					<%
					for(int j=0; j<5; j++){
						cnt++;
						if(books.size()>=cnt){
						 	Map<String, String> data = books.get(cnt-1);
							%>
							<td width="150px" height="200px" align="center" style="padding:30px;">
							<a href="#"><img src=<%= data.get("image")%> width="140px" height="200px"><br></a>
							<b><%= data.get("name") %></b><br>
							<a><%= data.get("author") %></a><br>
							<a><b>가격</b>:<%= data.get("price") %>원</a><br>
							</td>
							<%
							continue;
						} 
						
						%>
						<td width="150px" height="200px"> </td>
						<%
					}
					%>
					</tr>
					<%
				}
			%>
			
		</table>
		<table align="center">
			<tr>
				<td align>
					<a>[◀◀]</a>
					<a>[◀&nbsp;prev]</a>
					<a>[1]</a>
					<a>[2]</a>
					<a>[3]</a>
					<a>[4]</a>
					<a>[next&nbsp;▶]</a>
					<a>[▶▶]</a>
				</td>
			</tr>
		</table>
		</div>
    </section>
    
    <jsp:include page="basic/modalAndSliderScript.jsp"/>
</body>
</html>
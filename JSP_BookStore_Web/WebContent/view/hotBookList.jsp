<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<c:set var="cnt" value="0"/>
<%--  ==================================  슬라이드 index 0, 1, 2 ==================================--%>
<c:forEach var="i" begin="0" end="2">
	<div style="width:100%; height:350px;">
		<table style="margin:0px auto;">
			<tr>
			<%--  ==================================  슬라이드 내부 책5권 표시 ==================================--%>
			<c:forEach var="j" begin="0" end="4">
			<c:set var="cnt" value="${cnt+1 }"/>
			<c:if test="${fn:length(hotBooks)>=cnt}">
				<td width="150px" height="200px" align="center" style="padding:30px;">
					<c:set var="book" value="${hotBooks[cnt-1]}"/> 
					<%-- <a href="#"><img src="${book.image_path }" width="140px" height="200px"><br></a> --%>
					<div style="cursor:pointer; width:140px; height:200px; background-image: url('${book.image_path }'); background-size:cover;">
					</div>
					<b>${book.title }</b><br>
					<a>${book.author }</a><br>
				</td>
			</c:if>
			</c:forEach>
			<%--  ==================================  슬라이드 내부 책5권 표시 ==================================--%>
			</tr>
		</table>
	</div>
</c:forEach>
<%--  ==================================  슬라이드 index 0, 1, 2 ==================================--%>
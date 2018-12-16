<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
	
	<table style="margin:0px auto;">
		<tr align="right">
			<td colspan="5"><a href="#">more</a></td>
		</tr>
	<c:set var="cnt" value="0"/>
	<c:forEach var="i" begin="0" end="2">
		<tr>
		<c:forEach var="j" begin="0" end="4">
			<c:set var="cnt" value="${cnt+1 }"/>
			<c:choose>
				<c:when test="${fn:length(newBooks)>=cnt }">
					<c:set var="book" value="${newBooks[cnt-1]}"/>
					<td width="150px" height="200px" align="center" style="padding:30px;">
						<a href="bookInfo?board_id=${book.board_id }"><img src="${book.image_path }" width="140px" height="200px"><br></a>
						<b>${book.title }</b><br>
						<a>${book.author }</a><br>
					</td>
				</c:when>
				<c:otherwise>
					<td width="150px" height="200px"></td>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</tr>
	</c:forEach>
	</table>

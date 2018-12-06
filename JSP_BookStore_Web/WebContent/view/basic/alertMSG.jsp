<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:if test="${message != null }">
	alert("${message }");
	<c:if test="${sessionScope.message != null }">
		<% request.getSession().removeAttribute("message"); %>
	</c:if>
</c:if>
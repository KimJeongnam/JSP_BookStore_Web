<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${message != null }">
	alert("${message }");
	<c:if test="${sessionScope.message != null }">
		<% request.getSession().removeAttribute("message"); %>
	</c:if>
	<c:if test="${nextPage != null}">
		<c:if test="${sessionScope.nextPage != null }">
			window.location='${nextPage }';
			<% request.getSession().removeAttribute("nextPage"); %>
		</c:if>
	</c:if>
</c:if>
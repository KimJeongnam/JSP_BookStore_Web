<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${openLogin!=null}">
	document.getElementById('myModal').style.display = "block";
	<c:if test="${sessionScope.openLogin != null }">
		<% request.getSession().removeAttribute("openLogin"); %>
	</c:if>
	
</c:if>
<%@page import="com.bookstore.model.Category"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<aside>
	<div class="aside">
		<a class="header">카테고리</a>
		<ul>
			<li onclick="window.location='bookList'">전체</li>
			<c:forEach var="p_category" items="${parentCategorys}">
				<li>${p_category.category_name }
				<c:if test="${child_categorys.size() != 0 }">
					<ul>
						<c:forEach var="c_category" items="${childCategorys }">
						<c:if test="${p_category.category_id == c_category.super_id }">
							<li onclick="window.location='bookList?category_id=${c_category.category_id }'">
								<a>${c_category.category_name }</a>
							</li>
						</c:if>
						</c:forEach>
					</ul>
				</c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
</aside>

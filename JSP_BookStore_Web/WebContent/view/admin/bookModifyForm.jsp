<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../basic/settings.jsp"%>
<body>
	<%@ include file="nav.jsp"%>
	<!-- Include Editor style. -->
	<link href='https://cdn.jsdelivr.net/npm/froala-editor@2.9.1/css/froala_editor.min.css' rel='stylesheet' type='text/css' />
	<link href='https://cdn.jsdelivr.net/npm/froala-editor@2.9.1/css/froala_style.min.css' rel='stylesheet' type='text/css' />
	 
	<!-- Include JS file. -->
	<script type='text/javascript' src='https://cdn.jsdelivr.net/npm/froala-editor@2.9.1/js/froala_editor.min.js'></script>
	
	
	<section>
		<div class="container">
			<div class="panel">
				<h1>책 수정</h1>
				<form action="bookModifyDo" method="post" name="bookModifyForm" enctype="multipart/form-data">
					<input type="hidden" name="pageNum" value="${param.pageNum}">
					<input type="hidden" name="board_id" value="${dto.board_id }">
					<input type="hidden" name="book_code" value="${dto.book_code }">
					<input type="hidden" name="old_image_path" value="${dto.image_path }">
					<table class="table" align="center" width="1000">
						<tr>
							<th rowspan="2">
								<img src="${dto.image_path }" width="300"><br>
								<label for="image">표지 이미지 변경
								<input type="file" id="image" name="image_file">
								</label>
							</th>
							<td width="60%" height="30%" colspan="3"
								style="vertical-align: top;">
								<p>
								<a><b>구분</b></a> 
								<select class="whiteButton" name="category">
									<option value="0">선택</option>
									<!-- Map 선언 -->
									<c:set var="p_categoryMap" value="<%=new java.util.HashMap()%>" />
									<c:forEach var="i" items="${categorys }" varStatus="status">
										<c:if test="${i.level == 1 }">
										<c:set target="${p_categoryMap}" property="key${i.category_id }" value="${i.category_name }" />
											<option value="${i.category_id }" disabled style="font-weight: bold;">${i.category_name }</option>
										</c:if>
										<c:if test="${i.level > 1 }">
											<c:set var="key" value="key${i.super_id }"/>
											<c:choose>
												<c:when test="${dto.category_id== i.category_id}">
													<option value="${i.category_id }" selected>&nbsp;&nbsp;&nbsp;&nbsp;${p_categoryMap[key]}|${i.category_name }</option>
												</c:when>
												<c:otherwise>
													<option value="${i.category_id }">&nbsp;&nbsp;&nbsp;&nbsp;${p_categoryMap[key]}|${i.category_name }</option>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>
								</select>
								</p>
								<h2><input class="whiteButton" type="text" name="title" placeholder="책 제목" required value="${dto.title }"></h2> <br> 
								<p>
									<a style="font-size: 15px;">  
										<input class="whiteButton" type="text" name="author" required placeholder="저자" value="${dto.author }"> | 
										<input class="whiteButton" type="text" name="publisher" required placeholder="출판사" value="${dto.publisher }">
									</a>
								</p>
								<p><a><b>출판일 :</b> <input class="whiteButton" type="date" name="publish_date" required value="${dto.publish_date }"></a></p>
								<br>
							</td>
						</tr>

						<tr>
							<td><p>가격:</p><p>수량:</p></td>
							<td width="30%">
							<p style="color: red;">
								<b style="font-size: 20px; ">
								<input class="whiteButton" type="text" name="price" placeholder="판매가" required value="${dto.price }">
								</b>원
							</p>
							<p>
								<input class="whiteButton" type="text" name="stock" placeholder="개수" required value="${dto.stock }">개
							</p> 
							</td>
						</tr>
					</table>
					 <textarea id="froala-editor" name="context">
					 <c:choose>
					 	<c:when test="${dto.context.trim().length() > 0}">
					 		${dto.context }
					 	</c:when>
					 	<c:otherwise>
					 		<p><strong><em>==책 소개==</em></strong></p><hr><p><br></p>
					 	</c:otherwise>
					 </c:choose>
					 </textarea>
					<table width="100%" align="center">
						<tr>
							<td align="right"><input class="myButton" type="submit" value="확인">
							<input class="btn-danger" type="button" onclick="window.history.back();" value="취소">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</section>
	
	<script type="text/javascript">
		$(function (){
			 $('textarea#froala-editor').froalaEditor();
			<%@ include file="../basic/alertMSG.jsp"%>
		});
	</script>
</body>
</html>
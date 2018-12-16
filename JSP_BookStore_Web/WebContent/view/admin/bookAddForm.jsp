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
				<h1>책 추가</h1>
				<form action="bookAddDo" method="post" name="bookAddForm" enctype="multipart/form-data">
					<input type="hidden" name="pageNum" value="${param.pageNum}">
					<table class="table" align="center" width="1000">
						<tr>
							<th rowspan="2">
								<label for="image">표지 이미지
								<input type="file" id="image" name="image_file" required>
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
											<option value="${i.category_id }">&nbsp;&nbsp;&nbsp;&nbsp;${p_categoryMap[key]}|${i.category_name }</option>
										</c:if>
									</c:forEach>
								</select>
								</p>
								<h2><input class="whiteButton" type="text" name="title" placeholder="책 제목" required></h2> <br> 
								<a style="font-size: 15px;">  <input class="whiteButton" type="text" name="author" required placeholder="저자"> | 
								<input class="whiteButton" type="text" name="publisher" required placeholder="출판사"> | <br> 
								<p><b>출판일 :</b> <input class="whiteButton" type="date" name="publish_date" required></p>
								</a><br>
							</td>
						</tr>

						<tr>
							<td><p>가격:</p><p>수량:</p></td>
							<td width="30%">
								<p style="color: red;">
									<b style="font-size: 20px;">
									<input class="whiteButton" type="text" name="price" placeholder="판매가" required></b>&nbsp;&nbsp;원
								</p>
								<p>
									<input class="whiteButton" type="text" name="stock" placeholder="개수" required>&nbsp;&nbsp;개
								</p>
							</td>
						</tr>
					</table>
					 <textarea id="froala-editor" name="context"><p><strong><em>==책 소개==</em></strong></p><hr><p><br></p></textarea>
					<table width="100%" align="center">
						<tr>
							<td align="right"><input class="myButton" type="submit" onclick="" value="책 추가"> 
							<input class="myButton" type="button" onclick="window.location='bookManagePage?pageNum=${param.pageNum}';" value="목록">
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
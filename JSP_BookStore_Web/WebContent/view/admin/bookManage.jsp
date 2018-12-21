<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../basic/settings.jsp"%>
<body>
	<script src="${project}/static/js/signUpScript.js"></script>
	<%@ include file="nav.jsp"%>


	<script type="text/javascript">
		function checkboxValidate(){
			var cheked = false;
			var cnt = 0;
			for(var i=0; i<document.bookDeleteForm.chkbox.length; i++){
				if(document.bookDeleteForm.chkbox[i].checked){
					cheked = true;
					cnt++;
				}
			}
			if(!cheked)
				alert("삭제할 책을 선택후 진행하세요!!");
			else
				cheked = confirm("선택된 책 : "+cnt+"권 정말로 삭제 하시겠습니까?");
	
			return cheked;
		}
	</script>
	<section>
		<div class="container">
			<div class="panel" width="1200">
				<h1>
					<center>책 재고 관리</center>
				</h1>
				<c:if test="${pageNum==null }">
					<c:set var="pageNum" value="1" scope="request" />
				</c:if>

				<form name="selectCategoryForm" method="post">
					<table width="100%;" style="width: 1000px" align="center">
						<tr>
							<th colspan="6" align="center" style="height: 25px;">책 목록(책
								갯수 : ${cnt})</th>
						</tr>
						<tr>
							<td style="font-size: 18px; text-align: left; width: 20%; vertical-align: middle;">
								<a><b>구분</b></a> <select class="whiteButton" name="p_category">
									<option value="0">선택</option>
									<!-- Map 선언 -->
									<c:set var="p_categoryMap" value="<%=new java.util.HashMap()%>" />
									<c:forEach var="i" items="${categorys }" varStatus="status">
										<c:if test="${i.level == 1 }">
											<c:set target="${p_categoryMap}"
												property="key${i.category_id }" value="${i.category_name }" />
											<option value="${i.category_id }" disabled
												style="font-weight: bold;">${i.category_name }</option>
										</c:if>
										<c:if test="${i.level > 1 }">
											<c:set var="key" value="key${i.super_id }" />
											<option value="${i.category_id }">&nbsp;&nbsp;&nbsp;&nbsp;${p_categoryMap[key]}|${i.category_name }</option>
										</c:if>
									</c:forEach>
							</select>
							</td>
						</tr>
					</table>
				</form>
				<br>


				<form action="bookDeleteDo" name="bookDeleteForm" method="post"
					onsubmit="return checkboxValidate();">
					<input type="hidden" name="pageNum" value="${param.pageNum }">
					<table class="table" style="width: 100%;" align="center">
						<thead class="thead">
							<tr>
								<th style="width: 3%" class="text-center"><label
									for="allCheck"><input type="checkbox" id="allCheck"
										onchange="check_all();"></label></th>
								<th style="width: 10%" class="text-center">No</th>
								<th style="width: 15%" class="text-center">책 제목</th>
								<th style="width: 10%" class="text-center">저자</th>
								<th style="width: 10%" class="text-center">출판사</th>
								<th style="width: 15%" class="text-center">등록일</th>
								<th style="width: 5%" class="text-center">조회수</th>
								<th style="width: 5%" class="text-center">평점</th>
							</tr>
						</thead>
						<c:choose>
							<%-- 게시글이 있으면 --%>
							<c:when test="${cnt > 0 }">
								<c:forEach var="dto" items="${list}" varStatus="status">
									<tr>
										<td align="center"><label for="check${status.index }"><input
												type="checkbox" name="chkbox" id="check${status.index }"
												value="${dto.book_code }"></label></td>

										<td align="center">${number }<c:set var="number"
												value="${number-1 }" />
										</td>

										<td align="center"><a
											href="bookInfo?board_id=${dto.board_id }&pageNum=${pageNum}">
												<img src="${dto.image_path }" width="140px" height="200px"><br>
												${dto.title }
										</a> <%-- hot image  --%> <c:if test="${dto.readcnt >= 10 }">
												<img src="${project}images/hot.gif" border="0" width="30"
													height="15">
											</c:if></td>
										<td align="center">${dto.author }</td>
										<td align="center">${dto.publisher }</td>
										<td align="center"><fmt:formatDate type="both"
												pattern="yyyy-MM-dd HH:mm" value="${dto.reg_date }" /></td>
										<td align="center">${dto.readcnt }</td>
										<td align="center">${dto.rating }</td>
									</tr>
								</c:forEach>
							</c:when>
							<%-- 게시글이 없으면 --%>
							<c:otherwise>
								<tr>
									<td colspan="6" align="center">게시글이 없습니다. 글을 작성해 주세요.!!</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>

					<!--==================================================페이징 처리 START ==================================================  -->
					<table style="width: 100%;" align="center">
						<tr>
							<th class="text-center">
								<%-- 게시글이 있으면 --%> 
								<c:if test="${cnt > 0 }">
									<%-- 처음 --%>
									<c:if test="${startPage > pageBlock }">
										<a href="bookManagePage">[◀◀]</a>
										<a href="bookManagePage?pageNum=${startPage - pageBlock }">[◀&nbsp;prev]</a>
									</c:if>

									<c:forEach var="page" begin="${startPage }" end="${endPage }">
										<c:choose>
											<c:when test="${currentPage == page }">
												<span><b>[${page }]</b></span>
											</c:when>
											<c:otherwise>
												<a href="bookManagePage?pageNum=${page }">[${page }]</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>

									<c:if test="${pageCount > endPage }">
										<a href="bookManagePage?pageNum=${startPage + pageBlock }">[next&nbsp;▶]</a>
										<a href="bookManagePage?pageNum=${pageCount }">[▶▶]</a>
									</c:if>
								</c:if>
							</th>
						</tr>
					</table>
					<!--==================================================페이징 처리 END ==================================================  -->
					<div width="100%" align="right">
						<table width="300">
							<tr>
								<td><input class="myButton" type="button"
									onclick="window.location='bookAddForm?pageNum=${pageNum}&number=${number+1}'"
									value="책 추가"></td>
								<td><input class="btn-danger" type="submit" value="책 삭제">
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
	</section>

	<script type="text/javascript">
		$(function() {
			<%@ include file="../basic/alertMSG.jsp"%>
		});
	</script>
</body>
</html>
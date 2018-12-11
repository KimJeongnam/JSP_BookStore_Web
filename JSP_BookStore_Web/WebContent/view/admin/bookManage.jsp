<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../basic/settings.jsp"%>
<body>
	<script src="${project}/static/js/signUpScript.js"></script>
	<%@ include file="nav.jsp"%>

	<section>
		<div class="container">
			<div class="panel">
				<h1>
					<center>책 재고 관리</center>
				</h1>
				<c:if test="${pageNum==null }">
					<c:set var="pageNum" value="1" scope="request" />
				</c:if>

				<form name="selectCategoryForm">
					<table width="1000" style="width: 1000px" align="center">
						<tr>
							<th colspan="6" align="center" style="height: 25px;">
								글목록(글갯수 : ${cnt})</th>
						</tr>
						<tr>
							<td
								style="font-size: 18px; text-align: left; width: 20%; vertical-align: middle;">
								<a>대분류</a> <select class="whiteButton" name="p_category">
									<option value="all">전체</option>
									<option value="all">국내</option>
							</select>
							</td>

							<td
								style="font-size: 18px; text-align: left; width: 80%; vertical-align: middle;">
								<a>소분류</a> <select class="whiteButton" name="p_category">
									<option value="all">전체</option>
									<option value="all">국내</option>
							</select>
							</td>
						</tr>
					</table>
					<br>

					<table class="table" width="1000" style="width: 1200px"
						align="center">
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
												type="checkbox" name="chkbox" id="check${status.index }"></label></td>

										<td align="center">${number }<c:set var="number"
												value="${number-1 }" />
										</td>

										<td align="center">
											<a
											href="bookInfo?board_id=${dto.board_id }&pageNum=${pageNum}&number=${number+1}">
												<img src="${dto.image_path }" width="140px" height="200px"><br>
												${dto.title }
										</a> 
											<%-- hot image  --%> 
											<c:if test="${dto.readcnt >= 10 }">
												<img src="${project}images/hot.gif" border="0" width="30"
													height="15">
											</c:if>
										</td>
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
				</form>

				<table style="width: 1000px" align="center">
					<tr>
						<th class="text-center">
							<%-- 게시글이 있으면 --%> <c:if test="${cnt > 0 }">
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

				<div width="100%" align="right">
					<table width="300">
						<tr>
							<td><input class="myButton" type="button"
								onclick="window.location='bookAdd?pageNum=${pageNum}&number=${number+1}'"
								value="책 추가"></td>
							<td><input class="btn-danger" type="button" value="책 삭제">
							</td>
						</tr>
					</table>
				</div>
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
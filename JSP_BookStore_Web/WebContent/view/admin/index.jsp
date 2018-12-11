<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../basic/settings.jsp"%>
<body>
	<%@ include file="nav.jsp"%>

	<c:choose>
		<c:when test="${adminId != null }">
			<section>
				<div class="container">
					<div class="panel">
						<table width="500" style="margin: 0px auto;">
							<thead>
								<tr>
									<td colspan="2">주문 요청 건</td>
									<td colspan="2">환불 요청 건</td>
								</tr>
							</thead>
							<tr>
								<td style="text-align: right"><a href="#"
									style="font-weight: bold; color: blue;">${orderAskcnt}</a></td>
								<td style="text-align: left;">건</td>
								<td style="text-align: right"><a
									style="font-weight: bold; color: red;">${refundAskcnt}</a></td>
								<td style="text-align: left;">건</td>
							</tr>
						</table>
						<hr>
						<table style="margin: 0px auto; margin-top: 15px;">
							<tr>
								<td style="text-align: right;">ToDay 매출액 :</td>
								<td>${todayPrice}원</td>
							</tr>
						</table>
					</div>
				</div>
			</section>
		</c:when>
		<c:otherwise>
			<%@ include file="login.jsp"%>
		</c:otherwise>
	</c:choose>

	<script type="text/javascript">
		$(function (){
			<%@ include file="../basic/alertMSG.jsp"%>
		});
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../basic/settings.jsp"%>
<body>
	<%@ include file="nav.jsp"%>

	<section>
		<div class="container">
			<div class="panel">
				<form action="bookAdd" method="post">
					<h1>
						<center>카테고리 관리</center>
					</h1>
				</form>
			</div>
	</section>

	<script type="text/javascript">
		$(function() {
	<%@ include file="../basic/alertMSG.jsp"%>
		});
	</script>
</body>
</html>
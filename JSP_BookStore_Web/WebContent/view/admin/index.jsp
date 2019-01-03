<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="../basic/settings.jsp"%>
<body>
	<%@ include file="nav.jsp"%>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  
	<c:choose>
		<c:when test="${adminId != null }">
			<section>
				<div class="container">
					<div class="panel">
						<table width="500" style="margin: 0px auto;" border="0">
							<thead>
								<tr>
									<td colspan="2" align="center" style="font-weight: bold">주문 요청</td>
									<td colspan="2" align="center" style="font-weight: bold">환불 요청</td>
								</tr>
							</thead>
							<tr>
								<td style="text-align: right"><a href="#"
									style="font-weight: bold; color: blue;">${result.buyAskCnt}</a></td>
								<td style="text-align: left;">건</td>
								<td style="text-align: right"><a
									style="font-weight: bold; color: red;">${result.refundAskCnt}</a></td>
								<td style="text-align: left;">건</td>
							</tr>
						</table>
						<hr>
						<table style="margin: 0px auto; margin-top: 15px;" width="400">
							<tr style="font-weight: bold; font-size: 25px;">
								<td colspan="2">
									총 매출액 : <span style="font-weight: bold; color: red;"><fmt:formatNumber value="${result.all_price }" pattern="#,###"/></span>원 
								</td>
							</tr>
							<tr>
								<td>
									어제 매출액 : 
									<fmt:formatNumber value="${result.yesterday_totalPrice}" pattern="#,###"/>원
								</td>
								<td align="right">
									금일 매출액 :
									<span style="font-weight: bold; color: red;">
										<fmt:formatNumber value="${result.today_totalPrice}" pattern="#,###"/>
									</span>원
								</td>
							</tr>
						</table>
					</div>
					<div id="chart_div"></div>
				</div>
			</section>
		</c:when>
		<c:otherwise>
			<%@ include file="login.jsp"%>
		</c:otherwise>
	</c:choose>

	<script type="text/javascript">
	google.charts.load('current', {packages: ['corechart']});
	google.charts.setOnLoadCallback(drawTrendlines);

	function drawTrendlines() {
	      var data = new google.visualization.arrayToDataTable([
	    	  ['Month', '판매액'],
	    	  <c:forEach var="stat" items="${statList}">
		    	  ['${stat.date}', ${stat.total_price}],
	    	  </c:forEach>
	      ]);

	      var options = {
	        hAxis: {
	          title: 'Month'
	        },
	        vAxis: {
	          title: 'Sale'
	        },
	        serialType:'bars'
	        
	      };

	      var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	      chart.draw(data, options);
	    }
		$(function (){
			<%@ include file="../basic/alertMSG.jsp"%>
			
		});
	</script>
</body>
</html>
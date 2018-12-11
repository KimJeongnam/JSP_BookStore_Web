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
				<table class="table" align="center" width="1000">
					<tr>
						<th rowspan="2"><img src="${project }/images/12가지_인생의_법칙.jpg"
							width="300"></th>
						<td width="60%" height="30%" colspan="3"
							style="vertical-align: top;">
							<p>
								<b>해외</b> > 소설
							</p>
							<h2>12가지 인생의 법칙</h2> <br> <a style="font-size: 15px;">저자
								*** | publisher | publish_date</a><br> <br> <i
							class="fas fa-star fa-2x"></i> <i class="fas fa-star fa-2x"></i>
							<i class="fas fa-star fa-2x"></i> <i
							class="fas fa-star-half-alt fa-2x"></i> <i
							class="far fa-star fa-2x"></i> <b style="font-size: 25px;">7.0</b>
						</td>
					</tr>

					<tr>
						<td>판매가</td>
						<td style="color: red;" width="30%"><b
							style="font-size: 20px;">12,420</b>원</td>

						<c:if test="${userId!=null}">
							<td><input class="myButton" type="button" value="장바구니에 넣기"><br>
								<br> <input class="myButton" type="button" value="바로 구매">
							</td>
						</c:if>
					</tr>

					<tr>
						<td colspan="4" style="padding: 30px;"><b>도대체 전 세계 젊은이들이
								조던 B. 피터슨에게 열광하는 이유는 무엇일까? 2018년 전 세계를 뒤흔든 최고의 명강의</b> “조던 피터슨은 이런
							부류의 책을 쓰는 저자들과는 완전히 다른 지식인 그룹에 속한 사람이다. 그는 가장 어려운 주제를 가장 흥미진진하게
							전달할 수 있는 능력을 지니고 있다.” [가디언] 전 하버드 대 심리학과 교수가 밝혀낸 『12가지 인생의 법칙』은
							‘어깨를 펴고 똑바로 서라’ ‘세상을 탓하기 전에 방부터 치워라’ ‘당신에게 최고의 모습을 기대하는 사람만 만나라’
							같은 인생의 진리를 심리학, 생물학, 신화, 철학, 종교 등을 바탕으로 써내려간 책이다. 미국과 캐나다 영국
							젊은이들을 비롯해 전 세계에서 ‘피터슨 현상’을 일으키며 200만 부가 넘는 판매 부수를 기록했다. 그는 하버드 대
							교수 시절부터 학생들에게 큰 인기를 끌었다. 여러 학문을 자유자재로 넘나드는 박식함과 부드럽지만 거침없는 카리스마는
							청중들로 하여금 몰입할 수밖에 없게 만든다. 하버드에서는 최고의 교수에게 수여하는 ‘레빈슨 교수상’ 후보에 이름을
							올렸고, 토론토 대에서는 학생들에게 인생을 바꾼 교수로 뽑히기도 했다. 하지만 젊은이들이 열광하는 이유는 단지 그것
							때문만은 아니다. 무엇보다 그가 어디에서도 들을 수 없는 삶의 진실을 솔직하게 이야기하고 있기 때문일 것이다.
							[뉴욕타임스]의 칼럼니스트 데이비드 브룩스는 ‘사회의 어른들은 젊은이들에게 이 시대를 살아가는 데 꼭 필요한
							현실적이고 유용한 지혜를 가르치는 데 실패했다. 피터슨은 그 차이를 메우고 있다’고 분석한다. ‘인생은 고통이다.
							하지만 무너지지 않을 길은 있다’라고 말하는 이 책은 고된 삶에 무너지지 않고 의미 있는 삶을 사는 지혜를 12가지
							법칙에 담아 전하고 있다.</td>
					</tr>
				</table>


				<table width="1000" align="center">
					<tr>
						<td align="right">
							<input class="myButton" type="button" onclick="window.loction='bookModify'" value="책 수정">
							<input class="myButton" type="button" onclick="window.history.back();" value="목록">
						</td>
					</tr>
				</table>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="basic/settings.jsp"%>
<body>
   <%@ include file="basic/top.jsp" %>
   <jsp:include page="basic/aside.jsp"/>
    
    <section>
        <div class="container">
        <c:choose>
           <c:when test="${email != null}">
           	<b style="color:#0000ff;">${email }</b>	 로 인증코드 발송 이메일 인증 후 로그인 하세요.
           </c:when>
           <c:otherwise>
           <div style="width:300px; margin:0px auto;">
           	<img src="${project }/images/check.jpeg" width="100%">
           	<h3>이메일 인증 완료! 회원가입이 완료 되었습니다. 로그인해주세요.</h3>
           </div>
           </c:otherwise>
		</c:choose>
        </div>
       
    </section>
    
    <script type="text/javascript">
	    $(function(){
	    	<%@ include file="basic/modalAndSliderScript.jsp"%>
	    	<%@ include file="basic/alertMSG.jsp" %>
	    });
    </script>
</body>
</html>
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
            <h1 align="left">인기 도서</h1>
			<div id="s_banner_wrap">
				<ul class="bxslider">
					<%@ include file="hotBookList.jsp" %>
				</ul>
			</div>
        </div>
        
        <div  class="container">
            <hr>
            <div>
            	<h1 align="left">신간 도서</h1>
            </div>
            <jsp:include page="new_books.jsp"/>
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
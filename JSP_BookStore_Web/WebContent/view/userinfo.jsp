<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:include page="basic/settings.jsp"/>
<body>
   <%@ include file="basic/top.jsp" %>
   <jsp:include page="basic/aside.jsp"/>
    
    <section>
        <div class="container">
            <form class="userInfo" action="" method="post">
                <h1>회원 정보</h1>
                <table>
                    <tr>
                        <td class="label">아이디  </td>
                        <td class="table-text"><input type="text" style="width:100%;"></td>
                    </tr>

                    <tr>
                        <td class="label">이름  </td>
                        <td class="table-text"><input type="text" style="width:100%;"></td>
                    </tr>
                    
                    <tr>
                        <td class="label">전화번호</td>
                        <td class="table-text"><input type="text" style="width:100%;"></td>
                    </tr>

                    <tr>
                        <td class="label">이메일</td>
                        <td class="table-text"><input type="text" style="width:100%;"></td>
                    </tr>
                    
                    <tr>
                        <td class="label">주소</td>
                        <td class="table-text"><input type="text" style="width:100%;"></td>
                    </tr>
                    
                </table>
                <div align="right">
                    <input type="button" value="수정">
                    <input type="button" value="비밀번호 변경">
                </div>
            </form>
        </div>
        
        
   
    </section>
   
</body>
</html>
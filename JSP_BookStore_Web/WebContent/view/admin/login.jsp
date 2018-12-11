<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<section>
	<div class="container">
		<div class="panel" style="width: 400px;">
			<h1>관리자 로그인</h1>
			<form action="login" method="post">
                    <table class="login-table">
                        <tr>
                            <td style="text-align: left;">아이디</td>
                        </tr>
                        <tr>
                            <td><input type="text" name="id" size="30"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left;">비밀번호</td>
                        </tr>
                        <tr>
                            <td><input type="password" name="pw" size="30"></td>
                        </tr>
                        <tr>
                            <td><input type="submit" class="button" value="로 그 인"></td>
                        </tr>
                    </table>
                </form>
		</div>
	</div>
</section>
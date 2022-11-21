<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%
	String loginMsg = request.getParameter("loginMsg");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
		
		
		<script type = "text/javascript">
			<%
				if(loginMsg != null) {
			%>
					
						alert("<%=loginMsg %>");
					
			<%		
				}
			%>
		</script>
	</head>
	
	<body>
		<div>
			<div>
				<h1>로그인</h1>
			</div>
		
			<div>&nbsp;</div>
		
			<div>
				<form method = "post" action = "<%=request.getContextPath()%>/loginAction.jsp">
					<div>
						<table border = "1">
							<tr>
								<th>아이디</th>
								<td>
									<input type = "text" name = "memberId">
								</td>
							</tr>
							
							<tr>
								<th>비밀번호</th>
								<td>
									<input type = "password" name = "memberPw">
								</td>
							</tr>
						
						</table>
					</div>
					
					<div>
						<button type = "submit">로그인</button>
					</div>
				</form>
			</div>
		
		</div>
	</body>
</html>
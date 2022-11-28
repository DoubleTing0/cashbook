<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%
	// 1. Controller
	
	// 로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}
	
	// 메시지 출력 변수
	String msg = request.getParameter("msg");

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>deleteMemberForm.jsp</title>
		
		<script type = "text/javascript">
			<%
				if(msg != null) {
			%>
					alert("<%=msg %>");
			<%
				}
			%>
		</script>
		
		
	</head>
	
	<body>
		<div>
			<div>
				<h1>회원 탈퇴</h1>
			</div>
		
		
			<div>
				<form action = "<%=request.getContextPath() %>/member/deleteMemberAction.jsp" method = "post">
					<div>
						<table>
							<tr>
								<th>비밀번호</th>
								<td>
									<input type = "password" name = "memberPw">
								</td>
							</tr>
						</table>
					</div>
				
					<div>
						<button type = "submit">완료</button>
					</div>
				
				</form>
			</div>
		</div>
	</body>
</html>
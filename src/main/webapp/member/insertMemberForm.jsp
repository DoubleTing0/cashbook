<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%
	// 1. Controller
	
	// 세션 검사	
	// 이미 로그인이 되어있다면 cashList.jsp redirect
	if(session.getAttribute("loginMember") != null) {
		
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}

	// 메세지
	String msg = request.getParameter("msg");
	



%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm.jsp</title>
		
		<script type = "text/javascript">
		
			// 메세지 출력	
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
				<h1>
					<span>회원가입</span>
				</h1>
			</div>
			
			<div>
				<form method = "post" action = "<%=request.getContextPath() %>/member/insertMemberAction.jsp">
					<div>
						<table>
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
							
							<tr>
								<th>이름</th>
								<td>
									<input type = "text" name = "memberName">
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
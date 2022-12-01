<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>




<%
	// 1. Contorller
	
	// 로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}

	// 메세지
	String msg = request.getParameter("msg");

	Member loginMember = (Member) session.getAttribute("loginMember");
	
	// 디버깅 확인
	System.out.println(loginMember.getMemberName() + " <-- loginMember.getMemberName()");
	

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberForm.jsp</title>
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
				<h1>내 정보 수정</h1>
			</div>


			<div>
				<form action = "<%=request.getContextPath() %>/member/updateMemberAction.jsp" method = "post">
					<div>
						<table>
							<tr>
								<th>이름</th>
								<td>
									<input type = "text" name = "memberName" value = "<%=loginMember.getMemberName() %>">
								</td>
							</tr>
								
						</table>
					</div>
					
					<div>
						<button type = "submit">수정</button>
					</div>
				
				</form>
			</div>		
		
		
		
		</div>	
	
	</body>
</html>
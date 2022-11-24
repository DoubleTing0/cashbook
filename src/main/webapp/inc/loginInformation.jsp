<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>

<%

	//로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}	

	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member) (session.getAttribute("loginMember"));

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginInformation.jsp</title>
	</head>
	
	<body>
		
		<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
		<div>
			<span>ID : <%=loginMember.getMemberId() %></span>
			<span>이름 : <%=loginMember.getMemberName() %></span>
			<%
				if(loginMember.getMemberLevel() > 0) {
			%>
					<a href = "<%=request.getContextPath() %>/admin/adminMain.jsp">
						<span>관리자 페이지</span>
					</a>
			<%
				}
			%>
			
			<a href = "<%=request.getContextPath() %>/member/updateMemberForm.jsp">
				<span>내 정보 수정</span>
			</a>
			
			<a href = "<%=request.getContextPath() %>/member/updatePwForm.jsp">
				<span>비밀번호 변경</span>
			</a>
			
			
			<a href = "<%=request.getContextPath() %>/login/logoutAction.jsp">
				<span>로그아웃</span>
			</a>
			
			<a href = "<%=request.getContextPath() %>/member/deleteMemberForm.jsp">
				<span>회원 탈퇴</span>
			</a>
			
		</div> 
		
		
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%


	//Controller

	
	// 오류 메세지 출력을 위한 변수 초기화
	
	String msg = request.getParameter("msg");
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	// 로그인 세션 및 관리자 검증
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		
		return;
	}
	
	// request
	
	String memberId = request.getParameter("memberId");
	
	if(memberId == null || memberId.equals("")) {
		
		msg = URLEncoder.encode("회원을 다시 선택해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/member/memberList.jsp");
		return;
	}
	
	
	
	// 메서드 실행을 위한 dao 객체 생성
	MemberDao memberDao = new MemberDao();
	
	Member member = new Member();
	member.setMemberId(memberId);
	
	
	Member resultMember = memberDao.selectMemberOne(member);
	
	
	

%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateLevelForm.jsp</title>
		
		
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
				<h1>레벨 수정</h1>
			</div>
		
			<div>
				<form action = "<%=request.getContextPath() %>/admin/member/updateLevelAction.jsp" method = "post">
					<div>
						<input type = "hidden" name = "memberId" value = "<%=resultMember.getMemberId() %>">
						<table border = "1">
							<tr>
								<th>멤버번호</th>
								<th>아이디</th>
								<th>레벨</th>
								<th>이름</th>
							</tr>
							
							<tr>
								<td><%=resultMember.getMemberNo() %></td>
								<td><%=resultMember.getMemberId() %></td>
								<td>
									<select name = "memberLevel">
										<option selected>0</option>
										<option
										<%
											// selected 속성을 위한 조건문
											if(resultMember.getMemberLevel() == 1) {
										%>
												selected
										<%
											}
										%>
										>1</option>
								
									</select>
								</td>
								<td><%=resultMember.getMemberName() %></td>
								
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
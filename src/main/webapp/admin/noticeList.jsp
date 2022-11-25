<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.* " %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>


<%

	// Controller
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	// 로그인 및 관리자 검증
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}
	
	// Model : notice list
	
	
	
	
	
	// View
	
	
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	
	<body>
		<ul>
			<li><a href = "<%=request.getContextPath() %>/admin/noticeList.jsp">공지관리</a></li>
			<li><a href = "<%=request.getContextPath() %>/admin/categoryList.jsp">카테고리관리</a></li>
			<li><a href = "<%=request.getContextPath() %>/admin/memberList.jsp">멤버관리(목록 출력, 레벨수정, 강제탈퇴)</a></li>
		</ul>
		
		<div>
			<!-- noticeList -->
			<div>
				<h1>공지</h1>
			</div>
			
			<a href = "">공지입력</a>
			
			<div>
				<table border = "1">
					<tr>
						<th>공지내용</th>			
						<th>공지날짜</th>			
						<th>수정</th>			
						<th>삭제</th>			
					</tr>
		
					
				
				</table>
			</div>
		</div>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	</body>
</html>
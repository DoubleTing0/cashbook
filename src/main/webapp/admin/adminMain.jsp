<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>


<%


	// Controller
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	

	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}
	
	// Model 호출
	
	// 최근 공지 5개, 최근 멤버 5명	
	
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
			<li><a href = "<%=request.getContextPath() %>/admin/notice/noticeList.jsp">공지관리</a></li>
			<li><a href = "<%=request.getContextPath() %>/admin/category/categoryList.jsp">카테고리관리</a></li>
			<li><a href = "<%=request.getContextPath() %>/admin/member/memberList.jsp">멤버관리(목록 출력, 레벨수정, 강제탈퇴)</a></li>
		</ul>
	</body>
</html>
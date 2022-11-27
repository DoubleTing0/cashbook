<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%


	//Controller

	Member loginMember = (Member) session.getAttribute("loginMember");
	
	// 로그인 세션 및 관리자 검증
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		
		return;
	}

	String strNoticeNo = request.getParameter("noticeNo");
	
	if(strNoticeNo == null || strNoticeNo.equals("")) {
		
		
	}
	
%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
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

	// 메세지 출력 변수
	String msg = null;

	// null, 공백 검사
	if(request.getParameter("memberPw") == null || request.getParameter("memberPw").equals("")) {
		
		msg = URLEncoder.encode("모든 항목을 입력하세요.", "UTF-8");
		
		response.sendRedirect(request.getContextPath() + "/member/deleteMemberForm.jsp?msg=" + msg);
		return;
		
		
	}

	
	// Member 객체 생성 및 request
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	loginMember.setMemberPw(request.getParameter("memberPw"));
	
	
	// 메서드 실행 및 객체 생성``
	MemberDao memberDao = new MemberDao();
	boolean result = memberDao.deleteMember(loginMember);
	
	if(result) {
		
		msg = URLEncoder.encode("회원 탈퇴 되었습니다.", "UTF-8");
		session.invalidate();
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp?msg=" + msg);
		
	} else {
		
		msg = URLEncoder.encode("비밀번호가 올바르지 않습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/member/deleteMemberForm.jsp?msg=" + msg);
	}
	
%>

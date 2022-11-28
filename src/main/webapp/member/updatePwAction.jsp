<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
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
	
	
	// 메세지 출력 변수 초기화
	String msg = null;
	
	// null, 공백 검사
	if(request.getParameter("memberPw") == null || request.getParameter("memberNewPw") == null 
			|| request.getParameter("memberPw").equals("") || request.getParameter("memberNewPw").equals("")) {
		
		
		msg = URLEncoder.encode("모든 항목을 입력하세요.", "UTF-8");
		
		response.sendRedirect(request.getContextPath() + "/member/updatePwForm.jsp?msg=" + msg);
		return;
		
		
	}
	
	// request 및 Member 객체 생성
	Member loginMember = new Member();
	loginMember = (Member) session.getAttribute("loginMember");
	loginMember.setMemberPw(request.getParameter("memberPw"));
	
	String memberNewPw = request.getParameter("memberNewPw");

	
	// 2. Model 호출
	
	
	// 메서드 실행을 위한 dao 객체 생성
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.updatePw(loginMember, memberNewPw);
	
	if(resultRow == 1) {
		
		// 변경 완료 메세지 출력후 loginForm.jsp redirect
		msg = URLEncoder.encode("비밀번호가 변경되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp?msg=" + msg);
		
		// 세션 초기화
		session.invalidate();
		
	} else {
		
		// 변경 실패 메세지 출력후 updatePwForm.jsp redirect
		msg = URLEncoder.encode("현재 또는 새로운 비밀번호가 올바르지 않습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/member/updatePwForm.jsp?msg=" + msg);
		
	}
	
	
	
%>



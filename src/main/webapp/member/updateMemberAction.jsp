<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
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
	
	// msg 초기화
	String msg = null;	

	Member loginMember = new Member();
	loginMember = (Member) session.getAttribute("loginMember");
	loginMember.setMemberName(request.getParameter("memberName"));
	
	// null 및 공백 검사
	if(loginMember.getMemberName() == null || loginMember.getMemberName().equals("")) {
		
		msg = URLEncoder.encode("모든 항목을 입력하세요.", "UTF-8");
		
		response.sendRedirect(request.getContextPath() + "/member/updateMemberForm.jsp?msg=" + msg);
		return;
		
	}

	
	// 2. Model 호출
	
	
	// update 메서드 실행하기 위한 dao 객체 생성
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.updateMember(loginMember);
	
	if(resultRow == 1) {
		
		// 내 정보 수정 성공하면 msg 출력 및 cashList.jsp redirect
		msg = URLEncoder.encode("내 정보를 수정하였습니다.", "UTF-8");
		
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp?msg=" + msg);
		return;
	}
		


%>

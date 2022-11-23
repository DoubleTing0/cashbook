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
	
	// request
	Member paramMember = new Member();
	paramMember.setMemberId(request.getParameter("memberId"));
	paramMember.setMemberPw(request.getParameter("memberPw"));
	
	// 메세지 출력을 위한 msg 초기화
	String msg = null;
	
	if(paramMember.getMemberId() == null || paramMember.getMemberPw() == null 
			|| paramMember.getMemberId().equals("") || paramMember.getMemberPw().equals("")) {
		
		// 아이디, 비밀번호 공백이거나 null 일 경우
		msg = URLEncoder.encode("아이디와 비밀번호가 올바르지 않습니다.", "UTF-8");
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp?msg=" + msg);
		return;
	}
	
	
	// 2. 분리된 Model 호출
	
	
	// login 메서드 객체 생성
	MemberDao memberDao = new MemberDao();
	
	// login 메서드 호출
	Member resultMember = memberDao.login(paramMember);
	
	
	String redirectUrl = "/login/loginForm.jsp";
	if(resultMember != null) {
		// 로그인 성공시 세션에 resultMember 저장
		session.setAttribute("loginMember", resultMember);
		
		redirectUrl = "/cash/cashList.jsp";
	}
	
	response.sendRedirect(request.getContextPath() + redirectUrl);
	
	
%>


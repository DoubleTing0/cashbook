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
	// Contorller
	
	// 메세지 출력 변수 초기화
	String msg = null;
	
	// 로그인 세션 및 관리자 검증
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		
		return;
	}
	
	// request
	String memberId = request.getParameter("memberId");
	
	
	// null 및 공백 검증
	if(memberId == null || memberId.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/member/memberList.jsp?msg=" + msg);
		return;
	}
	
	
	// Model 호출
	
	Member member = new Member();
	member.setMemberId(memberId);
	
	// 관리자에의한 강제탈퇴 메서드 
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.deleteMemberByAdmin(member);
	
	if(resultRow == 1) {
		
		msg = URLEncoder.encode("해당 회원을 강제 탈퇴 하였습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/member/memberList.jsp?msg=" + msg);
		return;
		
	}

%>

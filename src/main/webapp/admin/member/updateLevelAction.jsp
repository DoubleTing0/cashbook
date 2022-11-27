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

	String msg = null;
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	// 로그인 세션 및 관리자 검증
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		
		return;
	}
	
	// request
	String memberId = request.getParameter("memberId");
	String memberLevel = request.getParameter("memberLevel");
	
	// 디버깅
	System.out.println(memberLevel + " <-- memberLevel");
	
	// null 및 공백 검증
	if(memberId == null || memberLevel == null 
			|| memberId.equals("") || memberLevel.equals("")) {
		
		msg = URLEncoder.encode("회원을 다시 선택해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/member/memberList.jsp?msg=" + msg);
		return;
	}
	
	
	
	// 메서드 실행을 위한 dao 객체 생성
	MemberDao memberDao = new MemberDao();
	
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberLevel(Integer.parseInt(memberLevel));
	
	int resultRow = memberDao.updateMemberLevel(member);
	
	if(resultRow == 1) {
		
		msg = URLEncoder.encode("레벨이 수정 되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/member/memberList.jsp?msg=" + msg);
		return;
		
	}
	
	
%>


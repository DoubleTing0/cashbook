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
	
	
	// 세션 검사	
	// 이미 로그인이 되어있다면 cashList.jsp redirect
	if(session.getAttribute("loginMember") != null) {
		
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	// 메세지 출력을 위한 msg 초기화
	String msg = null;
	
	// Member 객체 생성
	Member member = new Member();

	// request
	member.setMemberId(request.getParameter("memberId"));
	member.setMemberPw(request.getParameter("memberPw"));
	member.setMemberName(request.getParameter("memberName"));


	// request 공백, null 검사
	if(member.getMemberId() == null || member.getMemberPw() == null || member.getMemberName() == null 
		|| member.getMemberId().equals("") || member.getMemberPw().equals("") || member.getMemberName().equals("")) {
		
		msg = URLEncoder.encode("모든 항목을 입력하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/member/insertMemberForm.jsp?msg=" + msg);
		return;
		
	}
	
	
	// 2. Model 호출
	
	// memberDao 객체 생성
	MemberDao memberDao = new MemberDao();
	
	if(memberDao.selectMemberIdCk(request.getParameter("memberId"))) {
		
		msg = URLEncoder.encode("아이디가 중복 되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/member/insertMemberForm.jsp?msg=" + msg);
		return;
	}
	
	
	int resultRow = memberDao.insertMember(member);
	
	if(resultRow == 1) {
		
		// 회원 가입 성공 msg
		// loginForm.jsp redirect
		
		msg = URLEncoder.encode("회원 가입 되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp?msg=" + msg);
		return;
		
	}
	
	


%>


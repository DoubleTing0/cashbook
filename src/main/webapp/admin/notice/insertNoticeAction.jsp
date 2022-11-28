<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%


	// Controller
	
	
	// 메세지 출력 변수 초기화
	String msg = null;	
	
	
	// 로그인 안되있거나 관리자가 아닐때 loginForm.jsp redirect
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}


	// request
	String noticeMemo = request.getParameter("noticeMemo");
	
	// null, 공백 검증
	if(noticeMemo == null || noticeMemo.equals("")) {
		
		msg = URLEncoder.encode("모든 항목을 입력하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/notice/insertNoticeForm.jsp?msg=" + msg);
		return;
		
	}

	// Model 호출
	
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);
	
	NoticeDao noticeDao = new NoticeDao();
	int resultRow = noticeDao.insertNotice(notice);
	
	if(resultRow == 1) {
		
		msg = URLEncoder.encode("공지가 추가되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/notice/noticeList.jsp?msg=" + msg);
		return;
	}
	

%>

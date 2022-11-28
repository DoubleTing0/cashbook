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
	
	// 메세지 출력을 위한 변수 초기화
	String msg = null;
	

	// 로그인 검증
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}
	
	
	// request
	String noticeNo = request.getParameter("noticeNo");
	
	
	// null, 공백 검증
	if(noticeNo == null || noticeNo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/notice/noticeList.jsp?msg=" + msg);
		return;
	}
	

	// Model 호출
	
	Notice notice = new Notice();
	notice.setNoticeNo(Integer.parseInt(noticeNo));
	
	NoticeDao noticeDao = new NoticeDao();
	int resultRow = noticeDao.deleteNotice(notice);
	
	if(resultRow == 1) {
		msg = URLEncoder.encode("공지가 삭제되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/notice/noticeList.jsp?msg=" + msg);
		return;
	}

%>
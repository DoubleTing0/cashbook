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
	
	// 로그인 검증
	if(session.getAttribute("loginMember") == null) {
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}

	// 메세지 출력 변수 초기화
	String msg = null;

	// request
	String helpMemo = request.getParameter("helpMemo");
	
	// null, 공백 검증
	if(helpMemo == null || helpMemo.equals("")) {
		
		msg = URLEncoder.encode("모든 항목을 입력하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/help/insertHelpForm.jsp?msg=" + msg);
		return;
	}
	
	
	// 분리된 Model 호출
	
	Help help = new Help();
	help.setHelpMemo(helpMemo);
	help.setMemberId(((Member) session.getAttribute("loginMember")).getMemberId());
	
	HelpDao helpDao = new HelpDao();
	int resultRow = helpDao.insertHelp(help);
	
	if(resultRow == 1) {
		
		msg = URLEncoder.encode("문의가 추가되었습니다.", "UTF-8"); 
		response.sendRedirect(request.getContextPath() + "/help/helpList.jsp?msg=" + msg);
		return;
				
	}
	
	

%>

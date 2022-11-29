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
	
	// 메세지 출력을 위한 변수
	String msg = null;
	
	// request
	String helpNo = request.getParameter("helpNo");
	
	// null, 공백 검증
	if(helpNo == null || helpNo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/help/helpList.jsp?msg=" + msg);
		return;
		
	}
	
	// 분리된 Model 호출
	
	Help help = new Help();
	help.setHelpNo(Integer.parseInt(helpNo));
	
	HelpDao helpDao = new HelpDao();
	int resultRow = helpDao.deleteHelp(help);
	
	if(resultRow == 1) {
		
		msg = URLEncoder.encode("문의가 삭제되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/help/helpList.jsp?msg=" + msg);
		return;
	}
	
	
	

%>

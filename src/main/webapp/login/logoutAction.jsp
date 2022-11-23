<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// 세션 종료(리셋)
	session.invalidate();

	// loginForm.jsp redirect
	response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");

%>

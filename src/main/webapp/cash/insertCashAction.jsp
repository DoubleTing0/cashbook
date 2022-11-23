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
	
	// 로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}

	// 메세지 출력 변수
	String msg = null;

	// request 
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	
	
	// null, 공백 검사
	if(request.getParameter("cashPrice") == null || request.getParameter("cashMemo") == null
			|| request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo").equals("")) {
		
		msg = URLEncoder.encode("모든 항목을 입력해주세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date + "&msg=" + msg);
		return;
		
		
	}
	
	// Member 객체 생성
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	
	
	// Cash 객체 생성
	Cash cash = new Cash();
	cash.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
	cash.setCashDate(request.getParameter("cashDate"));
	cash.setCashPrice(Integer.parseInt(request.getParameter("cashPrice")));
	cash.setCashMemo(request.getParameter("cashMemo"));
	
	
	
	// 2. Model 호출
	
	
	// 메서드 호출을 위한 객체 생성
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.insertCash(loginMember, cash);
	
	if(resultRow == 1) {
		
		msg = URLEncoder.encode("추가 완료.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?year=" + year + "&month=" + month + "&date=" + date + "&msg=" + msg);
		return;
	}
	
	

%>


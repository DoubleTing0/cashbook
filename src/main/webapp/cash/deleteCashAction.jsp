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
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	String strDate = request.getParameter("date");
	String strCashNo = request.getParameter("cashNo");
	
	// null, 공백 검사
	if(strYear == null || strMonth == null || strDate == null || strCashNo == null
			|| strYear.equals("") || strMonth.equals("") || strDate.equals("") || strCashNo.equals("")) {	
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp?&msg=" + msg);
		return;
				
	}
	
	// request int 형변환
	int year = Integer.parseInt(strYear);
	int month = Integer.parseInt(strMonth);
	int date = Integer.parseInt(strDate);
	int cashNo = Integer.parseInt(strCashNo);
	
	// Member 객체 생성
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	
	
	// 2. Model 호출
	
	// 메서드 실행할 dao 객체 생성
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.deleteCash(loginMember, cashNo);
	
	if(resultRow == 1){
		
		msg = URLEncoder.encode("항목이 삭제되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?&year=" + year + "&month=" + month + "&date=" + date + "&msg=" + msg);
		return;
		
	}
		
	
	
	
%>


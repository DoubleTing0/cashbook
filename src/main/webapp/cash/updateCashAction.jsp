<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>


<%
	// 1. Controller
	
	// 로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}
	
	// 메세지 출력 변수
	String msg = null;
	
	// request 
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	String strDate = request.getParameter("date");
	String strCashNo = request.getParameter("cashNo");
	String strCategoryNo = request.getParameter("categoryNo");
	String strCashPrice = request.getParameter("cashPrice");
	String strCashMemo = request.getParameter("cashMemo");
	
	// null, 공백 검사

	if(strYear == null || strMonth == null || strDate == null || strCashNo == null || strCategoryNo == null 
			|| strCashPrice == null || strCashMemo == null || strYear.equals("") || strMonth.equals("") 
			|| strDate.equals("") || strCashNo.equals("") || strCategoryNo.equals("") || strCashPrice.equals("") || strCashMemo.equals("")) {	
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp?&msg=" + msg);
		return;
				
	}
	
	// request int 형변환
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	
	// Cash 객체 생성
	Cash cash = new Cash();
	cash.setCashNo(cashNo);
	cash.setCategoryNo(categoryNo);
	cash.setCashPrice(cashPrice);
	cash.setCashMemo(strCashMemo);
	
	// 메서드 호출을 위한 dao 객체 생성
	CashDao cashDao = new CashDao();
	int resultRow = cashDao.updateCash(cash);
	
	if(resultRow == 1) {
		
		msg = URLEncoder.encode("항목이 수정되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashDateList.jsp?&year=" + year + "&month=" + month + "&date=" + date + "&msg=" + msg);
		return;
		
	}
	

%>



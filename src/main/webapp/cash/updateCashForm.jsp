<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
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
	
	// null, 공백 검사
	if(strYear == null || strMonth == null || strDate == null || strCashNo == null
			|| strYear.equals("") || strMonth.equals("") || strDate.equals("") || strCashNo.equals("")) {	
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp?&msg=" + msg);
		return;
				
	}
	
	// request int 형변환
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	// Member 객체 생성

	CashDao cashDao = new CashDao();
	Cash cash = cashDao.selectCashOne(cashNo);
	
	
	CategoryDao categoryDao = new CategoryDao();
	
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	
	<body>
		<div>
			<div>
				<h1>cash 수정</h1>
			</div>
		
			<div>
				<!-- cash 입력 폼 -->
				<form method = "post" action = "<%=request.getContextPath() %>/cash/updateCashAction.jsp?year=<%=year %>&month=<%=month %>&date=<%=date %>">
					<input type = "hidden" name = "cashNo" value = "<%=cashNo %>">
					<table border = "1">
						<tr>
							<td>categoryNo</td>
							<td>
								<select name = "categoryNo" >
									<%
										// category 목록 출력
										for(Category c : categoryList) {
									%>
											<option value = "<%=c.getCategoryNo() %>"
												<%
													if(cash.getCategoryNo() == c.getCategoryNo()) {
												%>
														selected
												<%
													}
												%>
											
											>
												[<%=c.getCategoryKind() %>] <%=c.getCategoryName() %>
											</option>
									<%
										}
									%>
								</select>
							</td>
						</tr>
						
						<tr>
							<td>cashDate</td>
							<td>
								<input type = "text" name = "cashDate" value = "<%=year %>-<%=month + 1 %>-<%=date %>" readonly = "readonly">
							</td>
						</tr>
							
						<tr>
							<td>cashPrice</td>
							<td>
								<input type = "number" name = "cashPrice" value = "<%=cash.getCashPrice() %>">
							</td>
						</tr>
							
						<tr>
							<td>cashMemo</td>
							<td>
								<textarea rows = "3" cols = "50" name = "cashMemo"><%=cash.getCashMemo() %></textarea>
							</td>
						</tr>	
					
					
					</table>
				
					<button type = "submit">수정</button>
				
				
				
				</form>
				
			
			</div>
		
		</div>
	</body>
</html>
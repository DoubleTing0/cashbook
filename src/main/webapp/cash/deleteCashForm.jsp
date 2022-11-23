<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>


<%
	// 1. Controller

	//로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}

	// 메세지 출력 변수
	String msg = null;

	// request 
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String date = request.getParameter("date");
	String cashNo = request.getParameter("cashNo");
	
	// null, 공백 검사
	if(year == null || month == null || date == null || cashNo == null
			|| year.equals("") || month.equals("") || date.equals("") || cashNo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp?&msg=" + msg);
		return;
		
	}
		
	



%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>deleteCashForm.jsp</title>
	</head>
	
	<body>
		<div>
			<div>
				<h1>Cash 삭제</h1>
			
			</div>
		
			<div>
				<form action = "<%=request.getContextPath() %>/cash/deleteCashAction.jsp?
														year=<%=year %>&month=<%=month %>&date=<%=date %>&cashNo=<%=cashNo%>" method = "post">
				
					<div>
						<table>
							<tr>
								<th>비밀번호</th>
								<td>
									<input type = "password" name = "memberPw">
								</td>
							</tr>
							
						
						</table>
					</div>
				
					<div>
						<button type = "submit">완료</button>
					</div>
				





				</form>
			
			
			</div>
		
		
		</div>
	</body>
</html>
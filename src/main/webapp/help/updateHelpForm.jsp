<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>
<%

	//Controller

	// 로그인 검증
	if(session.getAttribute("loginMember") == null) {
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}

	// 메세지 출력 변수 초기화
	String msg = null;

	// request
	String helpNo = request.getParameter("helpNo");
	
	// null, 공백 검증
	if(helpNo == null || helpNo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/help/helpList.jsp");
		return;
		
	}
	
	
	// 분리된 Model 호출
	
	Help help = new Help();
	help.setHelpNo(Integer.parseInt(helpNo));
	
	HelpDao helpDao = new HelpDao();
	Help resultHelp = helpDao.selectHelpOne(help);
	


%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateHelpForm.jsp</title>
	</head>
	
	<body>
		<div>
			<div>
				<h1>문의 수정</h1>
			</div>

			<div>
				<form action = "<%=request.getContextPath() %>/help/updateHelpAction.jsp" method = "post">
					<div>
						<input type = "hidden" name = "helpNo" value = "<%=helpNo %>">
					</div>
					
					<div>
						<table border = "1">
							<tr>
								<th>문의 내용</th>
								<td>
									<textarea cols = "50" rows = "10" name = "helpMemo"><%=resultHelp.getHelpMemo() %></textarea>
								</td>
							</tr>
						</table>
					</div>
					
					<div>
						<button type = "submit">수정</button>
					</div>
				</form>
			</div>
		
		</div>
	</body>
</html>
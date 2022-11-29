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

	//메세지 출력 변수
	String msg = null;
	

	// 로그인 검증
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}

	// request
	String helpNo = request.getParameter("helpNo");
	
	// null, 공백 검증
	if(helpNo == null || helpNo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/help/helpListAll.jsp?msg=" + msg);
		return;
		
	}



%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertCommentForm.jsp</title>
	</head>
	
	<body>
		<div>
			<h1>답변 입력</h1>
		</div>
		
		<div>
			<form action = "<%=request.getContextPath() %>/admin/help/insertCommentAction.jsp" method = "post">
				<div>
					<input type = "hidden" name = "helpNo" value = "<%=helpNo %>">
				</div>
			
				<div>
					<table border = "1">
						<tr>
							<th>답변 내용</th>
							<td>
								<textarea cols = "50" rows = "10" name = "commentMemo"></textarea>
							</td>
						</tr>
					</table>
				</div>
				
				<div>
					<button type = "submit">입력</button>
				</div>
			
			</form>
		</div>
		
	</body>
</html>
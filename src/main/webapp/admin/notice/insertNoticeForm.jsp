<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%

	// Controller
	// 오류 메세지 출력 변수 초기화
	String msg = request.getParameter("msg");	

	// 로그인 안되있거나 관리자가 아닐때 loginForm.jsp redirect
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}

	

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertNoticeForm.jsp</title>
		
		<script type = "text/javascript">
			<%
				if(msg != null) {
			%>
						alert("<%=msg %>");
			<%		
				}
			%>
		</script>
		
		
	</head>
	
	<body>
		<div>
			<h1>공지 추가</h1>
		</div>
		
		<div>
			<form action = "<%=request.getContextPath() %>/admin/notice/insertNoticeAction.jsp" method = "post">
				<div>
					<table>
						<tr>
							<th>공지 내용</th>
							<td>
								<textarea cols = "50" rows = "10" name = "noticeMemo"></textarea>
							</td>
						</tr>
					
					</table>
				</div>
				
				<div>
					<button type = "submit">추가</button>
				</div>
				
			</form>
		</div>
	</body>
</html>
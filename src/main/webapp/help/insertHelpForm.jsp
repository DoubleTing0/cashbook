<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	String msg = request.getParameter("msg");

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertHelpForm.jsp</title>
		
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
			<div>
				<h1>문의하기</h1>
			</div>

			<div>&nbsp;</div>
					
			<div>
				<form action = "<%=request.getContextPath() %>/help/insertHelpAction.jsp" method = "post">
					<div>
						<table border = "1">
							<tr>
								<th>문의 내용</th>
								<td>
									<textarea cols = "50" rows = "10" name = "helpMemo"></textarea>
								</td>
							</tr>
						
						</table>
					</div>
				
					<div>
						<button type = "submit">문의하기</button>
					</div>
				
				</form>
			
			</div>
		
		</div>
	</body>
</html>
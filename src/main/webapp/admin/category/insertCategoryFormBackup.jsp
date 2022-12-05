<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>


<%

	// Controller
	
	// 메세지 출력을 위한 변수
	String msg = request.getParameter("msg");
	
	// 로그인 검증
	Member loginMember = (Member) session.getAttribute("loginMember");

	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}
	
	
	
%>



<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertCategoryForm.jsp</title>
		
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
			<h1>카테고리 추가</h1>
		</div>
		
		<div>
			<form action = "<%=request.getContextPath() %>/admin/category/insertCategoryAction.jsp" method = "post">
				<div>
					<table>
						<tr>
							<th>categoryKind</th>
							<td>
								<input type = "radio" name = "categoryKind" value = "수입">수입
								<input type = "radio" name = "categoryKind" value = "지출">지출
							</td>
						</tr>
						<tr>
							<th>categoryName</th>
							<td>
								<input type = "text" name = "categoryName">
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
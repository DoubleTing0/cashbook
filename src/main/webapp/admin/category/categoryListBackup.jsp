<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>


<%

	// Controller
	
	// 메세지 출력 변수
	String msg = request.getParameter("msg");	
	

	// 로그인 검증
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}
	
	// Model 호출

	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin();
	
	// View
	
	
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		
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
			<!-- 관리자 메뉴 -->
			<div>
				<jsp:include page = "/inc/adminMenu.jsp"></jsp:include>
			</div>		
			
			<div>
				<!-- categoryList -->
				<h1>카테고리 목록</h1>
			</div>
			
			<div>&nbsp;</div>
			
			<div>
				<a href = "<%=request.getContextPath() %>/admin/category/insertCategoryForm.jsp">카테고리 추가</a>
			</div>
			
			
			<div>&nbsp;</div>
			
			<div>
				<table>
					<tr>
						<th>번호</th>
						<th>수입/지출</th>
						<th>이름</th>
						<th>마지막 수정 날짜</th>
						<th>생성 날짜</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
					
					<%
						for(Category c : categoryList) {
					%>
							<tr>
								<td><%=c.getCategoryNo() %></td>
								<td><%=c.getCategoryKind() %></td>
								<td><%=c.getCategoryName() %></td>
								<td><%=c.getUpdatedate() %></td>
								<td><%=c.getCreatedate() %></td>
								<td>
									<a href = "<%=request.getContextPath() %>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo() %>">수정</a>
								</td>
								<td>
									<a href = "<%=request.getContextPath() %>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo() %>">삭제</a>
								</td>
							</tr>
					<%
						}
					%>
						
				</table>
			</div>
		</div>
	</body>
</html>
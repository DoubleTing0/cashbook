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

	// 메세지 출력 변수 초기화
	String msg = request.getParameter("msg");	
	
	// 로그인 검증 
	Member loginMember = (Member) session.getAttribute("loginMember");

	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}

		
	// request
	String categoryNo = request.getParameter("categoryNo");
	
	// null, 공백 검증
	if(categoryNo == null || categoryNo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/category/categoryList.jsp?msg=" + msg);
		return;
		
	}

	
	// Model 호출
	
	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(categoryNo));
	
	CategoryDao categoryDao = new CategoryDao();
	Category resultCategory = categoryDao.selectCategoryOne(category);
	


%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCategoryForm.jsp</title>
	</head>
	
	<body>
		<div>
			<h1>카테고리 수정</h1>
		</div>
		
		<div>
			<form action = "<%=request.getContextPath() %>/admin/category/updateCategoryAction.jsp" method = "post">
			
				<div>
					<input type = "hidden" name = "categoryNo" value = "<%=resultCategory.getCategoryNo() %>">
				</div>
			
				<div>
					<table>
						<tr>
							<th>categoryKind</th>
							<td>
								<input type = "radio" name = "categoryKind" value = "수입" checked = "checked">수입
								<input type = "radio" name = "categoryKind" value = "지출"
								<%
									if(resultCategory.getCategoryKind().equals("지출")) {
								%>
										checked = "checked"
								<%
									}
								%>
								>지출
							</td>
						</tr>
						<tr>
							<th>categoryName</th>
							<td>
								<input type = "text" name = "categoryName" value = "<%=resultCategory.getCategoryName() %>">
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
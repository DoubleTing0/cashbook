<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%

	// Controller
	
	// 메세지 출력을 위한 변수 초기화
	String msg = null;
	
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
	}
	
	
	// Model 호출
	
	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(categoryNo));
	
	CategoryDao categoryDao = new CategoryDao();
	int resultRow = categoryDao.deleteCategory(category);
	
	if(resultRow == 1) {
		msg = URLEncoder.encode("카테고리가 삭제되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/category/categoryList.jsp?msg=" + msg);
	}
	
	

%>
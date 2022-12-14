<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>

<%

	//로그인 세션 검사
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
	}
	
	// page active 속성을 위한 page 구분
	String pageName = (String) session.getAttribute("pageName");
	
	
	

%>

<!-- Sidebar Start -->
<div class="sidebar pe-4 pb-3">
    <nav class="navbar bg-secondary navbar-dark">
        <a href="<%=request.getContextPath() %>/cash/cashList.jsp" class="navbar-brand mx-4 mb-3">
 	       <h3 class="text-primary">
    	        <i class="fa fa-user-edit me-2"></i>가계부
	        </h3>
        </a>
        <div class="d-flex align-items-center ms-4 mb-4">
            <div class="position-relative">
                <img class="rounded-circle" src="<%=request.getContextPath() %>/resources/img/user.jpg" alt="" style="width: 40px; height: 40px;">
                <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
            </div>
            <div class="ms-3">
                <h6 class="mb-0">ID : <%=loginMember.getMemberId() %></h6>
                <span>이름 : <%=loginMember.getMemberName() %></span>
            </div>
        </div>
        <div class="navbar-nav w-100">
        	<a href="<%=request.getContextPath() %>/cash/cashList.jsp" class="nav-item nav-link"><i class="fa fa-calendar-week me-2"></i>가계부</a>
				
			<!-- 관리자 메뉴 -->
        	<%
        		if(pageName.equals("adminMain")) {
        			// 세션을 통해 현재 페이지에 active 속성 부여
        	%>
		            <a href="<%=request.getContextPath() %>/admin/adminMain.jsp" class="nav-item nav-link active"><i class="fa fa-key me-2"></i>관리자 페이지</a>
		    <%
		    	} else {
		    %>
		            <a href="<%=request.getContextPath() %>/admin/adminMain.jsp" class="nav-item nav-link"><i class="fa fa-key me-2"></i>관리자 페이지</a>
		    <%
		    	}
        	%>
        	 
			<!-- 공지관리 메뉴 -->
        	<%
        		if(pageName.equals("adminNoticeList")) {
        			// 세션을 통해 현재 페이지에 active 속성 부여
        	%>
		            <a href="<%=request.getContextPath() %>/admin/notice/noticeList.jsp" class="nav-item nav-link active"><i class="fa fa-exclamation me-2"></i>공지사항 관리</a>
		    <%
		    	} else {
		    %>
		            <a href="<%=request.getContextPath() %>/admin/notice/noticeList.jsp" class="nav-item nav-link"><i class="fa fa-exclamation me-2"></i>공지사항 관리</a>
		    <%
		    	}
        	%>
        	 
			<!-- 회원관리 메뉴 -->
        	<%
        		if(pageName.equals("adminMemberList")) {
        			// 세션을 통해 현재 페이지에 active 속성 부여
        	%>
		            <a href="<%=request.getContextPath() %>/admin/member/memberList.jsp" class="nav-item nav-link active"><i class="fa fa-user me-2"></i>회원 관리</a>
		    <%
		    	} else {
		    %>
		            <a href="<%=request.getContextPath() %>/admin/member/memberList.jsp" class="nav-item nav-link"><i class="fa fa-user me-2"></i>회원 관리</a>
		    <%
		    	}
        	%> 
        	
			<!-- 카테고리관리 메뉴 -->
        	<%
        		if(pageName.equals("adminCategoryList")) {
        			// 세션을 통해 현재 페이지에 active 속성 부여
        	%>
		            <a href="<%=request.getContextPath() %>/admin/category/categoryList.jsp" class="nav-item nav-link active"><i class="fa fa-bookmark me-2"></i>카테고리 관리</a>
		    <%
		    	} else {
		    %>
		            <a href="<%=request.getContextPath() %>/admin/category/categoryList.jsp" class="nav-item nav-link"><i class="fa fa-bookmark me-2"></i>카테고리 관리</a>
		    <%
		    	}
        	%> 
			
			<!-- 문의사항관리 메뉴 -->
        	<%
        		if(pageName.equals("adminHelpList")) {
        			// 세션을 통해 현재 페이지에 active 속성 부여
        	%>
		            <a href="<%=request.getContextPath() %>/admin/help/helpListAll.jsp" class="nav-item nav-link active"><i class="fa fa-question me-2"></i>문의사항 관리</a>
		    <%
		    	} else {
		    %>
		            <a href="<%=request.getContextPath() %>/admin/help/helpListAll.jsp" class="nav-item nav-link"><i class="fa fa-question me-2"></i>문의사항 관리</a>
		    <%
		    	}
        	%> 
			
			
        </div>
    </nav>
</div>
<!-- Sidebar End -->
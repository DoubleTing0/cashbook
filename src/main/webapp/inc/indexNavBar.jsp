<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>

<%

	//세션 검사
	// 이미 로그인이 되어있다면 cashList.jsp redirect
	if(session.getAttribute("loginMember") != null) {
		
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}


%>

<!-- Navbar Start -->
<nav class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">
    <h2 class="text-primary mb-0">
	    <a href="<%=request.getContextPath() %>/cash/cashList.jsp" class="navbar-brand d-flex d-lg-none me-4">
    	    <i class="fa fa-user-edit"></i>
	    </a>
    </h2>
    <a href="#" class="sidebar-toggler flex-shrink-0">
        <i class="fa fa-bars"></i>
    </a>
    
    <div class="navbar-nav align-items-center ms-auto">
        <div class="nav-item">
            <a href="<%=request.getContextPath() %>/login/loginForm.jsp" class="nav-link">
            	<i class="fa fa-user"></i>
                <span class="d-none d-lg-inline-flex">&ensp;로그인</span>
            </a>
        </div>
    </div>
</nav>
<!-- Navbar End -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>

<%

	//로그인 세션 검사
	

	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member) (session.getAttribute("loginMember"));

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
        	<a href = "<%=request.getContextPath() %>/login/loginForm.jsp">
            	<h5 class = "text-light">
	            	<i class="fa fa-user"></i>
	            	<span>&ensp;로그인</span>
            	</h5>
        	</a>
        </div>
        <div class="navbar-nav w-100">
        
        	<!-- 가계부 메뉴 -->
            <a href="<%=request.getContextPath() %>/cash/cashList.jsp" class="nav-item nav-link"><i class="fa fa-calendar-week me-2"></i>가계부</a>
            
            <!-- 문의사항 메뉴 -->
            <a href="<%=request.getContextPath() %>/help/helpList.jsp" class="nav-item nav-link"><i class="fa fa-question me-2"></i>문의사항</a>
        </div>
    </nav>
</div>
<!-- Sidebar End -->
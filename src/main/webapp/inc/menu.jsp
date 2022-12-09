<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>

<%

	//로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}	

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
        
        	<!-- 가계부 메뉴 -->
        	<%
        		if(pageName.equals("cashList")) {
        			// 세션을 통해 현재 페이지에 active 속성 부여
        	%>
		            <a href="<%=request.getContextPath() %>/cash/cashList.jsp" class="nav-item nav-link active"><i class="fa fa-calendar-week me-2"></i>가계부</a>
		    <%
		    	} else {
		    %>
		            <a href="<%=request.getContextPath() %>/cash/cashList.jsp" class="nav-item nav-link"><i class="fa fa-calendar-week me-2"></i>가계부</a>
		    <%
		    	}
        	%> 
            
            
            <!-- 관리자 메뉴 -->
            <%
            	if(loginMember.getMemberLevel() == 1) {
            		// 관리자라면 관리자페이지 메뉴 보이도록
            %>
            		<a href="<%=request.getContextPath() %>/admin/adminMain.jsp" class="nav-item nav-link"><i class="fa fa-key me-2"></i>관리자페이지</a>
           	<%	            		
            	}
            %>
            
            
            <!-- 문의사항 메뉴 -->
            <%
        		if(pageName.equals("helpList")) {
        			// 세션을 통해 현재 페이지에 active 속성 부여
        	%>
		            <a href="<%=request.getContextPath() %>/help/helpList.jsp" class="nav-item nav-link active"><i class="fa fa-question me-2"></i>문의사항</a>
		    <%
		    	} else {
		    %>
		            <a href="<%=request.getContextPath() %>/help/helpList.jsp" class="nav-item nav-link"><i class="fa fa-question me-2"></i>문의사항</a>
		    <%
		    	}
        	%> 
            
            
            
            
            
            
        </div>
    </nav>
</div>
<!-- Sidebar End -->
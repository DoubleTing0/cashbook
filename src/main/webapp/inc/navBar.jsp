<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>

<%

	//로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}	

	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member) (session.getAttribute("loginMember"));

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
        <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <img class="rounded-circle me-lg-2" src="<%=request.getContextPath() %>/resources/img/user.jpg" alt="" style="width: 40px; height: 40px;">
                <span class="d-none d-lg-inline-flex"><%=loginMember.getMemberName() %></span>
            </a>
            <div class="dropdown-menu dropdown-menu-end bg-secondary border-0 rounded-0 rounded-bottom m-0">
                <a href="<%=request.getContextPath() %>/member/updateMemberForm.jsp" class="dropdown-item">내 정보 수정</a>
                <a href="<%=request.getContextPath() %>/member/updatePwForm.jsp" class="dropdown-item">비밀번호 변경</a>
                <a href="<%=request.getContextPath() %>/login/logoutAction.jsp" class="dropdown-item">로그아웃</a>
                <a href="<%=request.getContextPath() %>/member/deleteMemberForm.jsp" class="dropdown-item">회원탈퇴</a>
            </div>
        </div>
    </div>
</nav>
<!-- Navbar End -->
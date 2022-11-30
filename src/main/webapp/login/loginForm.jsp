<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%
	// 1. Controller
	
	// 세션 검사
	// 이미 로그인이 되어있다면 cashList.jsp redirect
	if(session.getAttribute("loginMember") != null) {
		
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}


	// 메세지 출력 변수
	String msg = request.getParameter("msg");
	
	// Model 호출
	
	// 공지 Page 변수 초기화
	Page noticePage = new Page();
	
	int noticeCurrentPage = 1;
	if(request.getParameter("noticeCurrentPage") != null) {
		noticeCurrentPage = Integer.parseInt(request.getParameter("noticeCurrentPage"));
	}
	
	int noticePageLength = 10;
	int noticeRowPerPage = 5;
	
	ArrayList<Integer> noticePageList = noticePage.getPageList(noticeCurrentPage, noticePageLength); 
	int noticeBeginRow = noticePage.getBeginRow(noticeCurrentPage, noticeRowPerPage);
	int noticePreviousPage = noticePage.getPreviousPage(noticeCurrentPage, noticePageLength);
	int noticeNextPage = noticePage.getNextPage(noticeCurrentPage, noticePageLength);
	
	NoticeDao noticeDao = new NoticeDao();
	int noticeCount = noticeDao.selectNoticeCount();
	
	int noticeLastPage = noticePage.getLastPage(noticeCount, noticeRowPerPage); 
	
	// 공지 목록 출력 메서드
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(noticeBeginRow, noticeRowPerPage);
	
	
	
	// 멤버 Page 변수 초기화
	Page memberPage = new Page();
	
	int memberCurrentPage = 1;
	if(request.getParameter("memberCurrentPage") != null) {
		memberCurrentPage = Integer.parseInt(request.getParameter("memberCurrentPage"));
	}
	
	int memberPageLength = 10;
	int memberRowPerPage = 5;
	
	ArrayList<Integer> memberPageList = memberPage.getPageList(memberCurrentPage, memberPageLength); 
	int memberBeginRow = memberPage.getBeginRow(memberCurrentPage, memberRowPerPage);
	int memberPreviousPage = memberPage.getPreviousPage(memberCurrentPage, memberPageLength);
	int memberNextPage = memberPage.getNextPage(memberCurrentPage, memberPageLength);
	
	MemberDao memberDao = new MemberDao();
	int memberCount = memberDao.selectMemberCount();
	
	int memberLastPage = memberPage.getLastPage(memberCount, memberRowPerPage); 
	
	// 멤버 목록 출력 메서드
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(memberBeginRow, memberRowPerPage);
	
	
%>


<!DOCTYPE html>
<html>

	<head>
	    <meta charset="utf-8">
	    <title>로그인</title>
	    <meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	    <!-- Favicon -->
	    <link href="<%=request.getContextPath() %>/resources/img/favicon.ico" rel="icon">
	
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
	    
	    <!-- Icon Font Stylesheet -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
	
	    <!-- Libraries Stylesheet -->
	    <link href="<%=request.getContextPath() %>/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	    <link href="<%=request.getContextPath() %>/resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
	
	    <!-- Customized Bootstrap Stylesheet -->
	    <link href="<%=request.getContextPath() %>/resources/css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- Template Stylesheet -->
	    <link href="<%=request.getContextPath() %>/resources/css/style.css" rel="stylesheet">
	    
	    <!-- 메세지 출력 스크립트 -->
	    
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
	    <div class="container-fluid position-relative d-flex p-0">
	        <!-- Spinner Start -->
	        <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
	            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
	                <span class="sr-only">Loading...</span>
	            </div>
	        </div>
	        <!-- Spinner End -->
	
	
	        <!-- Sign In Start -->
	        <div class="container-fluid">
	            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
	                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-5">
	                    <div class="bg-secondary rounded p-4 p-sm-5 my-4 mx-3">
	                        <div class="d-flex align-items-center justify-content-between mb-3">
	                        	<h3 class="text-primary"><i class="fa fa-user-edit me-2"></i>가계부</h3>
	                            <h3>로그인</h3>
	                        </div>
	                        <div>
	                        	<form method = "post" action = "<%=request.getContextPath()%>/login/loginAction.jsp">
			                        <div class="form-floating mb-3">
			                            <input type="text" class="form-control" name = "memberId" id="floatingInput" placeholder="ID">
			                            <label for="floatingInput">ID</label>
			                        </div>
			                        <div class="form-floating mb-4">
			                            <input type="password" class="form-control" name = "memberPw" id="floatingPassword" placeholder="Password">
			                            <label for="floatingPassword">Password</label>
			                        </div>
			                        <button type="submit" class="btn btn-primary py-3 w-100 mb-4">로그인</button>
	                        	</form>
	                        </div>
	                        <p class="text-center mb-0">회원이 아니신가요?&emsp;&emsp;<a href="<%=request.getContextPath() %>/member/insertMemberForm.jsp">회원 가입</a></p>
	                    </div>
	                    
						
						
						
						<!-- 공지 5개 목록 -->
						<div class = "row justify-content-center">
							<div class="bg-secondary rounded p-4 p-sm-5 my-4 mx-3">
							
								<div class="d-flex align-items-center justify-content-center mb-4">
			                        <h1 class="text-primary mb-0">
				                        <span>공지 사항</span>
			                        </h1>
			                    </div>
							
							
								<table class="table align-middle table-bordered table-hover text-center mb-0">
									<tr>
										<th>
											<h5 class = "text-danger mb-0">공지내용</h5>
										</th>
										<th>
											<h5 class = "text-danger mb-0"">날짜</h5>
										</th>
									</tr>
								
									<%
										for(Notice n : noticeList) {
									%>
											<tr>
												<td><%=n.getNoticeMemo() %></td>
												<td><%=n.getCreatedate() %></td>
											</tr>
									<%
										}
									%>
								</table>
								
								<div>&nbsp;</div>
			                    
			                    <!-- 공지 페이징 처리 시작 -->
								<div>
									<ul class="pagination justify-content-center">
										
										<!-- 페이지 처음 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?noticeCurrentPage=1&memberCurrentPage=<%=memberCurrentPage %>">
												<span>처음</span>
											</a>
										</li>
										
										<!-- 페이지 이전(-10의 1페이지) -->
										<%
											
											if(noticePreviousPage > 0) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?noticeCurrentPage=<%=noticePreviousPage %>&memberCurrentPage=<%=memberCurrentPage %>">
														<span>이전</span>
													</a>
												</li>
										<%
											}
										%>		
									
									  
									  	<!-- 페이지 1 ~ 10 -->
										<%
									  		for(int i : noticePageList) {
									  	%>
												<!-- 현재페이지만 구분하기 위한 active 속성 조건문-->
												<li 
													<%
														if(noticeCurrentPage == i) {
													%>
															class = "page-item active"
													<%
														} else {
													%>
															class = "page-item"
													<%						
														}
													%>
												> <!-- <li> 닫음 오타아님. -->
												
												<!-- 마지막 페이지까지만 출력하기 위한 조건문 -->					
												<%
													if(i <= noticeLastPage) {
												%>
														<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?noticeCurrentPage=<%=i %>&memberCurrentPage=<%=memberCurrentPage %>">
															<span><%=i %></span>
														</a>
												<%
													}
												%>
												</li>
										<%  		
										}
										%>
									  
									  	<!-- 페이지 다음(+10의 1페이지) -->
										<%
											if(noticeNextPage <= noticeLastPage) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?noticeCurrentPage=<%=noticeNextPage %>&memberCurrentPage=<%=memberCurrentPage %>">
														<span>다음</span>
													</a>
												</li>
										<%
											}
										%>
										
										<!-- 페이지 마지막 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?noticeCurrentPage=<%=noticeLastPage%>&memberCurrentPage=<%=memberCurrentPage %>">
												<span>마지막</span>
											</a>
										</li>
									</ul>
								</div>			
							
								<!-- 공지 페이징 처리 끝 -->
							</div>
		                </div>
		            </div>
				</div>
	        </div>
	        <!-- Sign In End -->
	        
	        
	        
	        
	    </div>
	
	    <!-- JavaScript Libraries -->
	    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	    <script src="<%=request.getContextPath() %>/resources/lib/chart/chart.min.js"></script>
	    <script src="<%=request.getContextPath() %>/resources/lib/easing/easing.min.js"></script>
	    <script src="<%=request.getContextPath() %>/resources/lib/waypoints/waypoints.min.js"></script>
	    <script src="<%=request.getContextPath() %>/resources/lib/owlcarousel/owl.carousel.min.js"></script>
	    <script src="<%=request.getContextPath() %>/resources/lib/tempusdominus/js/moment.min.js"></script>
	    <script src="<%=request.getContextPath() %>/resources/lib/tempusdominus/js/moment-timezone.min.js"></script>
	    <script src="<%=request.getContextPath() %>/resources/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
	
	    <!-- Template Javascript -->
	    <script src="<%=request.getContextPath() %>/resources/js/main.js"></script>
	</body>

</html>
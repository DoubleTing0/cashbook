<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>


<%


	// Controller
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	

	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
	}
	
	//페이지 세션 설정
	session.setAttribute("pageName", "adminMain");
	
	// Model 호출
	
	// 최근 공지 5개, 최근 멤버 5명	
	
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
	
	// 카테고리 Page 변수 초기화
	Page categoryPage = new Page();
	
	int categoryCurrentPage = 1;
	if(request.getParameter("categoryCurrentPage") != null) {
		categoryCurrentPage = Integer.parseInt(request.getParameter("categoryCurrentPage"));
	}
	
	int categoryPageLength = 10;
	int categoryRowPerPage = 5;
	
	ArrayList<Integer> categoryPageList = categoryPage.getPageList(categoryCurrentPage, categoryPageLength); 
	int categoryBeginRow = categoryPage.getBeginRow(categoryCurrentPage, categoryRowPerPage);
	int categoryPreviousPage = categoryPage.getPreviousPage(categoryCurrentPage, categoryPageLength);
	int categoryNextPage = categoryPage.getNextPage(categoryCurrentPage, categoryPageLength);
	
	CategoryDao categoryDao = new CategoryDao();
	
	int categoryCount = categoryDao.selectCategoryCount();
	int categoryLastPage = categoryPage.getLastPage(categoryCount, categoryRowPerPage); 
	
	
	// 카테고리 목록 출력 메서드
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin(categoryBeginRow, categoryRowPerPage);
	
	
	// 문의 Page 변수 초기화
	Page helpPage = new Page();
	
	int helpCurrentPage = 1;
	if(request.getParameter("helpCurrentPage") != null) {
		helpCurrentPage = Integer.parseInt(request.getParameter("helpCurrentPage"));
	}
	
	int helpPageLength = 10;
	int helpRowPerPage = 5;
	
	ArrayList<Integer> helpPageList = helpPage.getPageList(helpCurrentPage, helpPageLength); 
	int helpBeginRow = helpPage.getBeginRow(helpCurrentPage, helpRowPerPage);
	int helpPreviousPage = helpPage.getPreviousPage(helpCurrentPage, helpPageLength);
	int helpNextPage = helpPage.getNextPage(helpCurrentPage, helpPageLength);
	
	HelpDao helpDao = new HelpDao();
	int helpCount = helpDao.selectHelpCount();
	
	int helpLastPage = helpPage.getLastPage(helpCount, helpRowPerPage); 
	
	// 문의 목록 출력 메서드
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(helpBeginRow, helpRowPerPage);
		
	
	
	
	
	
	
	// View
	
	
	
	
%>



<!DOCTYPE html>
<html>

	<head>
	    <meta charset="utf-8">
	    <title>가계부</title>
	    <meta content="width=device-width, initial-scale=1.0" name="viewport">
	
	    <!-- Favicon -->
	    <link rel="shortcut icon" href="<%=request.getContextPath() %>/resources/favicon.ico" type="image/x-icon">
		<link rel="icon" href="<%=request.getContextPath() %>/resources/favicon.ico" type="image/x-icon">
			
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
	
	
	        <!-- Sidebar Start -->
			<div>
				<jsp:include page = "/inc/adminMenu.jsp"></jsp:include>
			</div>
	        <!-- Sidebar End -->
	
	
	        <!-- Content Start -->
	        <div class="content">
	            <!-- Navbar Start -->
         		<div>
					<jsp:include page = "/inc/navBar.jsp"></jsp:include>
				</div>
	            <!-- Navbar End -->
	
	
	
				<div class="container-fluid pt-4 px-4">
	                <div class="row g-4">
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-secondary text-center rounded p-4">
			                    <div class="d-flex align-items-center justify-content-between mb-4">
	                                <h3 class="mb-0">공지사항</h3>
	                                <a href="<%=request.getContextPath() %>/admin/notice/noticeList.jsp" class = "mt-3">더보기</a>
	                            </div>
	                            <!-- 공지 5개 목록 시작 -->
								<div>
									<table class="table align-middle table-bordered table-hover text-center mb-0">
										<tr>
											<th>
												<h5 class = "text-danger mb-0">공지내용</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">날짜</h5>
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
								</div>
								<!-- 공지 5개 목록 끝 -->
								
								
								<div>&nbsp;</div>
									
								<!-- 공지 페이징 처리 시작 -->
								<div>
									<ul class="pagination justify-content-center">
										
										<!-- 페이지 처음 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=1&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
												<span>처음</span>
											</a>
										</li>
										
										<!-- 페이지 이전(-10의 1페이지) -->
										<%
											
											if(noticePreviousPage > 0) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=<%=noticePreviousPage %>&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
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
														<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=<%=i %>&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
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
													<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=<%=noticeNextPage %>&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
														<span>다음</span>
													</a>
												</li>
										<%
											}
										%>
										
										<!-- 페이지 마지막 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=<%=noticeLastPage%>&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
												<span>마지막</span>
											</a>
										</li>
									</ul>
								</div>			
							
								<!-- 공지 페이징 처리 끝 -->
								
								
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-secondary text-center rounded p-4">
	                            <div class="d-flex align-items-center justify-content-between mb-4">
	                                <h3 class="mb-0">회원</h3>
	                                <a href="<%=request.getContextPath() %>/admin/member/memberList.jsp" class = "mt-3">더보기</a>
	                            </div>
			                    
	                            <!-- 회원 출력 시작 -->
			                    <div class="table-responsive">
			                        <table class="table text-center align-middle table-bordered table-hover mb-0">
			                            <thead>
			                                <tr>
			                                	<th>
													<h5 class = "text-danger mb-0">회원ID</h5>
												</th>
												<th>
													<h5 class = "text-danger mb-0">회원레벨</h5>
												</th>
												<th>
													<h5 class = "text-danger mb-0">회원이름</h5>
												</th>
												<th>
													<h5 class = "text-danger mb-0">가입일</h5>
												</th>
											</tr>
			                            </thead>
			                            <tbody>
			                            	<%
												for(Member m : memberList) {
											%>
													<tr>
														<td><%=m.getMemberId() %></td>
														<td><%=m.getMemberLevel() %></td>
														<td><%=m.getMemberName() %></td>
														<td><%=m.getCreatedate() %></td>
													</tr>
											<%
												}
											%>
			                            </tbody>
			                        </table>
			                    </div>
			                    <!-- 회원 출력 끝 -->
			                    
			                    
				                    
								<div>&nbsp;</div>
								
								<!-- 회원 페이징 처리 시작 -->
								<div>
									<ul class="pagination justify-content-center">
										
										<!-- 페이지 처음 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=1&noticeCurrentPage=<%=noticeCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
												<span>처음</span>
											</a>
										</li>
										
										<!-- 페이지 이전(-10의 1페이지) -->
										<%
											
											if(memberPreviousPage > 0) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=<%=memberPreviousPage %>&noticeCurrentPage=<%=noticeCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
														<span>이전</span>
													</a>
												</li>
										<%
											}
										%>		
									
									  
									  	<!-- 페이지 1 ~ 10 -->
										<%
									  		for(int i : memberPageList) {
									  	%>
												<!-- 현재페이지만 구분하기 위한 active 속성 조건문-->
												<li 
													<%
														if(memberCurrentPage == i) {
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
													if(i <= memberLastPage) {
												%>
														<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=<%=i %>&noticeCurrentPage=<%=noticeCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
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
											if(memberNextPage <= memberLastPage) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=<%=memberNextPage %>&noticeCurrentPage=<%=noticeCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
														<span>다음</span>
													</a>
												</li>
										<%
											}
										%>
										
										<!-- 페이지 마지막 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=<%=memberLastPage%>&noticeCurrentPage=<%=noticeCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>&categoryCurrentPage=<%=categoryCurrentPage %>">
												<span>마지막</span>
											</a>
										</li>
									</ul>
								</div>			
							
								<!-- 회원 페이징 처리 끝 -->
			                    
	                        </div>
	                    </div>
	                    
	                    <div class="col-sm-12 col-xl-6">
	                    	<div class="bg-secondary text-center rounded p-4">
			                    <div class="d-flex align-items-center justify-content-between mb-4">
	                                <h3 class="mb-0">카테고리</h3>
	                                <a href="<%=request.getContextPath() %>/admin/category/categoryList.jsp" class = "mt-3">더보기</a>
	                            </div>
	                            
	                            <!-- 카테고리 목록 시작 -->
								<div>
									<table class="table align-middle table-bordered table-hover text-center mb-0">
										<tr>
											<th>
												<h5 class = "text-danger mb-0">수입/지출</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">이름</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">날짜</h5>
											</th>
										</tr>
									
										<%
											for(Category c : categoryList) {
										%>
												<tr>
													<td><%=c.getCategoryKind() %></td>
													<td><%=c.getCategoryName() %></td>
													<td><%=c.getUpdatedate() %></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
								<!-- 카테고리 목록 끝 -->
	                            
	                            <div>&nbsp;</div>
									
								<!-- 카테고리 페이징 처리 시작 -->
								<div>
									<ul class="pagination justify-content-center">
										
										<!-- 페이지 처음 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?&categoryCurrentPage=1&noticeCurrentPage=<%=noticeCurrentPage %>&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>">
												<span>처음</span>
											</a>
										</li>
										
										<!-- 페이지 이전(-10의 1페이지) -->
										<%
											
											if(noticePreviousPage > 0) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?categoryCurrentPage=<%=categoryPreviousPage %>&noticeCurrentPage=<%=noticeCurrentPage %>&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>">
														<span>이전</span>
													</a>
												</li>
										<%
											}
										%>		
									
									  
									  	<!-- 페이지 1 ~ 10 -->
										<%
									  		for(int i : categoryPageList) {
									  	%>
												<!-- 현재페이지만 구분하기 위한 active 속성 조건문-->
												<li 
													<%
														if(categoryCurrentPage == i) {
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
													if(i <= categoryLastPage) {
												%>
														<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?categoryCurrentPage=<%=i %>&noticeCurrentPage=<%=noticeCurrentPage %>&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>">
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
											if(categoryNextPage <= categoryLastPage) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?categoryCurrentPage=<%=categoryNextPage %>&noticeCurrentPage=<%=noticeCurrentPage %>&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>">
														<span>다음</span>
													</a>
												</li>
										<%
											}
										%>
										
										<!-- 페이지 마지막 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?categoryCurrentPage=<%=categoryLastPage %>&noticeCurrentPage=<%=noticeCurrentPage %>&memberCurrentPage=<%=memberCurrentPage %>&helpCurrentPage=<%=helpCurrentPage %>">
												<span>마지막</span>
											</a>
										</li>
									</ul>
								</div>			
							
								<!-- 카테고리 페이징 처리 끝 -->
	                            
	                            
							</div>
						</div>
						
						
						
						
						
						<div class="col-sm-12 col-xl-6">
							<div class="bg-secondary text-center rounded p-4">
								<div class="d-flex align-items-center justify-content-between mb-4">
									<h3 class="mb-0">문의사항</h3>
									<a href="<%=request.getContextPath() %>/admin/help/helpListAll.jsp" class = "mt-3">더보기</a>
								</div>
	                            <!-- 문의사항 목록 시작 -->
								<div>
									<table class="table align-middle table-bordered table-hover text-center mb-0">
										<tr>
											<th>
												<h5 class = "text-danger mb-0">문의내용</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">회원ID</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">문의날짜</h5>
											</th>
										</tr>
									
										<%
											for(HashMap<String, Object> m : helpList) {
										%>
												<tr>
													<td><%=m.get("helpMemo") %></td>
													<td><%=m.get("memberId") %></td>
													<td><%=m.get("helpCreatedate") %></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
								<!-- 문의사항 목록 끝 -->
								
								<div>&nbsp;</div>
	                    	
	                    		
								<!-- 문의 페이징 처리 시작 -->
								<div>
									<ul class="pagination justify-content-center">
										
										<!-- 페이지 처음 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?helpCurrentPage=1&noticeCurrentPage=<%=noticeCurrentPage %>&memberCurrentPage=<%=memberCurrentPage %>">
												<span>처음</span>
											</a>
										</li>
										
										<!-- 페이지 이전(-10의 1페이지) -->
										<%
											
											if(helpPreviousPage > 0) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?helpCurrentPage=<%=helpPreviousPage %>&noticeCurrentPage=<%=noticeCurrentPage %>&memberCurrentPage=<%=memberCurrentPage %>">
														<span>이전</span>
													</a>
												</li>
										<%
											}
										%>		
									
									  
									  	<!-- 페이지 1 ~ 10 -->
										<%
									  		for(int i : helpPageList) {
									  	%>
												<!-- 현재페이지만 구분하기 위한 active 속성 조건문-->
												<li 
													<%
														if(helpCurrentPage == i) {
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
													if(i <= helpLastPage) {
												%>
														<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?helpCurrentPage=<%=i %>&noticeCurrentPage=<%=noticeCurrentPage %>&memberCurrentPage=<%=memberCurrentPage %>">
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
											if(helpNextPage <= helpLastPage) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?helpCurrentPage=<%=helpNextPage %>&noticeCurrentPage=<%=noticeCurrentPage %>&memberCurrentPage=<%=memberCurrentPage %>">
														<span>다음</span>
													</a>
												</li>
										<%
											}
										%>
										
										<!-- 페이지 마지막 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?helpCurrentPage=<%=helpLastPage%>">
												<span>마지막</span>
											</a>
										</li>
									</ul>
								</div>			
							
								<!-- 문의 페이징 처리 끝 -->
	                    	</div>
	                    </div>
	                </div>
	            </div>
	
	
	
	
	
	
	        </div>
	        <!-- Content End -->
	
	
	        <!-- Back to Top -->
	        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
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
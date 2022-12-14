<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>


<%

	// Controller
	
	// 메세지 출력 변수
	String msg = request.getParameter("msg");	
	

	// 로그인 검증
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
	}
	
	
	//페이지 세션 설정
	session.setAttribute("pageName", "adminCategoryList");
	
	
	// Model 호출

	// 카테고리 Page 변수 초기화
	Page categoryPage = new Page();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int pageLength = 10;
	int rowPerPage = 10;
	
	ArrayList<Integer> pageList = categoryPage.getPageList(currentPage, pageLength); 
	int beginRow = categoryPage.getBeginRow(currentPage, rowPerPage);
	int previousPage = categoryPage.getPreviousPage(currentPage, pageLength);
	int nextPage = categoryPage.getNextPage(currentPage, pageLength);
	
	CategoryDao categoryDao = new CategoryDao();
	int count = categoryDao.selectCategoryCount();
	
	int lastPage = categoryPage.getLastPage(count, rowPerPage); 
	
	
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin(beginRow, rowPerPage);
	
	// View
	
	
	
	
%>



<!DOCTYPE html>
<html>

	<head>
	    <meta charset="utf-8">
	    <title>카테고리관리</title>
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
	                    <div class="col-sm-12 col-xl-12">
	                        <div class="bg-secondary text-center rounded p-4">
	                            <div class="d-flex align-items-center justify-content-center mb-4">
			                        <h1 class="text-white mb-0">
				                        <span>카테고리 관리</span>
			                        </h1>
			                    </div>
			                    <div class="m-n2 text-end">
			                    	<button type="button" class="btn btn-primary rounded-pill m-2 mb-4"
			                    			onclick="location.href='<%=request.getContextPath() %>/admin/category/insertCategoryForm.jsp' ">카테고리 추가</button>
			                    </div>
			                    
	                            <!-- 카테고리 목록 시작 -->
								<div>
									<table class="table align-middle table-bordered table-hover text-center mb-0">
										<tr>
											<th>
												<h5 class = "text-danger mb-0">번호</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">수입/지출</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">이름</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">마지막 수정 날짜</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">생성 날짜</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">수정</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">삭제</h5>
											</th>
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
								<!-- 카테고리 목록 끝 -->
			                    
			                    <div>&nbsp;</div>
									
								<!-- 카테고리 페이징 처리 시작 -->
								<div>
									<ul class="pagination justify-content-center">
										
										<!-- 페이지 처음 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/category/categoryList.jsp?currentPage=1">
												<span>처음</span>
											</a>
										</li>
										
										<!-- 페이지 이전(-10의 1페이지) -->
										<%
											
											if(previousPage > 0) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/admin/category/categoryList.jsp?currentPage=<%=previousPage %>">
														<span>이전</span>
													</a>
												</li>
										<%
											}
										%>		
									
									  
									  	<!-- 페이지 1 ~ 10 -->
										<%
									  		for(int i : pageList) {
									  	%>
												<!-- 현재페이지만 구분하기 위한 active 속성 조건문-->
												<li 
													<%
														if(currentPage == i) {
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
													if(i <= lastPage) {
												%>
														<a class="page-link" href="<%=request.getContextPath() %>/admin/category/categoryList.jsp?currentPage=<%=i %>">
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
											if(nextPage <= lastPage) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/admin/category/categoryList.jsp?currentPage=<%=nextPage %>">
														<span>다음</span>
													</a>
												</li>
										<%
											}
										%>
										
										<!-- 페이지 마지막 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/admin/category/categoryList.jsp?currentPage=<%=lastPage%>">
												<span>마지막</span>
											</a>
										</li>
									</ul>
								</div>			
							
								<!-- 카테고리 페이징 처리 끝 -->
			                    
			                    
			                    
			                    
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%

	// Controller
	
	// 로그인 검증
	if(session.getAttribute("loginMember") == null) {
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}

	// 페이지 세션 설정
	session.setAttribute("pageName", "helpList");

	// 메세지 출력을 위한 변수
	String msg = request.getParameter("msg");


	// 분리된 Model 호출
	Help help = new Help();
	help.setMemberId(((Member) session.getAttribute("loginMember")).getMemberId());
	
	HelpDao helpDao = new HelpDao();
	
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(help);
	
	



%>



<!DOCTYPE html>
<html>

	<head>
	    <meta charset="utf-8">
	    <title>문의 사항</title>
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
				<jsp:include page = "/inc/menu.jsp"></jsp:include>
			</div>
	        <!-- Sidebar End -->
	
	
	        <!-- Content Start -->
	        <div class="content">
	            <!-- Navbar Start -->
         		<div>
					<jsp:include page = "/inc/navBar.jsp"></jsp:include>
				</div>
	            <!-- Navbar End -->
	
	
	
	            <!-- 문의 사항 Start -->
	            <div class="container-fluid pt-4 px-4">
	                <div class="bg-secondary text-center rounded p-4">
	                    <div class="d-flex align-items-center justify-content-center mb-4">
	                    	<h1 class="text-white mb-0">
	                        	<span>문의 사항</span>
	                        </h1>
	                    </div>
	                    <div class="m-n2 text-end">
	                    	<button type="button" class="btn btn-primary rounded-pill m-2 mb-4"
	                    			onclick="location.href='<%=request.getContextPath() %>/help/insertHelpForm.jsp' ">문의 하기</button>
	                    </div>
	                    
	                    <div class="table-responsive">
	                        <table class="table text-center align-middle table-bordered table-hover mb-0">
	                            <thead class = "text-danger">
	                                <tr>
										<th>문의내용</th>
										<th>문의날짜</th>
										<th>답변내용</th>
										<th>답변날짜</th>
										<th>수정</th>
										<th>삭제</th>
									</tr>
	                            </thead>
	                            <tbody>
										<%
											for(HashMap<String, Object> hm : list) {
										%>
												<tr>
													<td><%=(String) hm.get("helpMemo") %></td>
													<td><%=(String) hm.get("helpCreatedate") %></td>
													<td>
														<%
															if(hm.get("commentMemo") == null) {
														%>
																<span>답변 전</span>
														<%
															} else {
														%>
																<%=hm.get("commentMemo") %>
														<%
															}
														%>
													</td>
													<td>
														<%
															if(hm.get("commentCreatedate") == null) {
														%>
																<span>답변 전</span>
														<%
															} else {
														%>
																<%=hm.get("commentCreatedate") %>
														<%
															}
														%>
													</td>
													
													<%
														if(hm.get("commentMemo") == null) {
													%>
															<!-- 답변이 없을 경우 -->
															<td>
																<a href = "<%=request.getContextPath() %>/help/updateHelpForm.jsp?helpNo=<%=(Integer) hm.get("helpNo")%>" class = "link-info">수정</a>
															</td>
															<td>
																<a href = "<%=request.getContextPath() %>/help/deleteHelpAction.jsp?helpNo=<%=(Integer) hm.get("helpNo")%>" class = "link-info">삭제</a>
															</td>
													<%
														} else {
													%>
															<!-- 답변이 있을 경우 -->
															<td>수정불가</td>
															<td>삭제불가</td>
													<%
														}
													%>
													
													
												</tr>
										<%
											}
										%>
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
	            </div>
	            <!-- 문의 사항 End -->
	
	
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
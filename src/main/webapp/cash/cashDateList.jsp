<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>


<%
	// 1. Controller
	
	// 로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}
	
	// 메세지 출력 변수
	String msg = request.getParameter("msg");


	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member) (session.getAttribute("loginMember"));

	// request
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	String strDate = request.getParameter("date");
	
	// null, 공백 검증
	if(strYear == null || strMonth == null || strDate == null
			|| strYear.equals("") || strMonth.equals("") || strDate.equals("")) {
		
		msg = URLEncoder.encode("다시 선택 하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp?msg=" + msg);
		return;
	}
	
	
	
	// request int 형변환
	int year = Integer.parseInt(strYear);
	int month = Integer.parseInt(strMonth);
	int date = Integer.parseInt(strDate);
	
	
	
	// 2. Model 호출
	
	CashDao cashDao = new CashDao();
	
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month + 1, date);
	
	
	
%>


<!DOCTYPE html>
<html>

	<head>
	    <meta charset="utf-8">
	    <title><%=year %>년 <%=month + 1 %>월 <%=date %>일</title>
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
	    
	    <style>
	    
	    	.not-new-line {
	    		white-space: nowrap;
	    	}
	    
	    
	    </style>
	    
	    
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
	
	
	        <!-- cashDateList Start -->
	        <div class="container-fluid">
	            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
	                <div class="col-12 col-sm-12 col-md-8 col-lg-8 col-xl-6">
	                    
						<!-- cash 목록 출력 -->
						<div class = "row justify-content-center">
							<div class="bg-secondary rounded p-4 p-sm-5 my-4 mx-3">
								
								<div class="d-flex align-items-center justify-content-between mb-3">
		                        	<h3 class="text-primary">
		                            	<a href="<%=request.getContextPath() %>/cash/cashList.jsp">
		                                	<i class="fa fa-user-edit me-2"></i>가계부
		                            	</a>
		                           	</h3>
		                            <h3><%=year %>년 <%=month + 1 %>월 <%=date %>일</h3>
		                        </div>
								
								<div>
									<table class="table align-middle table-bordered table-hover text-center mb-3">
										<tr class = "not-new-line">
											<th>
												<h5 class = "text-danger mb-0">카테고리</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">항목</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">비용</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">메모</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">수정</h5>
											</th>
											<th>
												<h5 class = "text-danger mb-0">삭제</h5>
											</th>
										</tr>
										
											
										<%
											for(HashMap<String, Object> m : list) {
												
										%>
												<tr>
													<td><%=(String) (m.get("categoryKind")) %></td>
													<td  class = "not-new-line"><%=(String) (m.get("categoryName")) %></td>
													<td  class = "not-new-line"><%=(Long) (m.get("cashPrice")) %>원</td>
													<td><%=(String) (m.get("cashMemo")) %></td>
													<td>
														<a href = "<%=request.getContextPath() %>/cash/updateCashForm.jsp?
																year=<%=year %>&month=<%=month %>&date=<%=date %>&cashNo=<%=(Integer) m.get("cashNo")%>">
															수정
														</a>
													</td>
													<td>
														<a href = "<%=request.getContextPath() %>/cash/deleteCashAction.jsp?
																year=<%=year %>&month=<%=month %>&date=<%=date %>&cashNo=<%=(Integer) m.get("cashNo")%>">
															삭제
														</a>
													</td>
												</tr>
										<%
												
											}
										
										%>	
									</table>
									
									<div>
										<button type="button" class="btn btn-primary py-3 w-100 mb-4"
											onclick="location.href='<%=request.getContextPath() %>/cash/insertCashForm.jsp?year=<%=year %>&month=<%=month %>&date=<%=date %>' ">추가</button>
									</div>
									
									
								</div>
							</div>
						</div>
			                    
	                </div>
	            </div>
			</div>
		</div>
        <!-- cashDateList End -->
	        
	        
	        
	        
	
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
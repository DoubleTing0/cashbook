<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>


<%
	// 1. Controller : session, request
	
	// 로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}
	
	//페이지 세션 설정
	session.setAttribute("pageName", "cashList");

	// 메세지 출력 변수
	String msg = request.getParameter("msg");
	
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member) (session.getAttribute("loginMember"));
	
	
	//	request 년 + 월
	
	int year = 0;
	int month = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null 
			|| request.getParameter("year").equals("") || request.getParameter("month").equals("")) {
		
		Calendar today = Calendar.getInstance();	//	오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
		
	} else {
		
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
	
		if(month == -1) {
			month = 11;		// 12월
			year -= 1;
			
		}
		if(month == 12) {
			month = 0;		// 1월
			year += 1;
		}
		
	}
	
	
	//	출력하고자 하는 월과 그 월의 1일의 요일(일 1, 월 2, 화 3, ... 토 7)
	Calendar targetDate = Calendar.getInstance();
	
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	
	// 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay -1;
	
	int endBlank = 0;	// beginBlank + lastDate + endBlank  --> 7로 나누어 떨어진다.
	
	
	
	//	마지막 날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	if((beginBlank + lastDate) % 7 != 0) {
		
		endBlank = 7 - ((beginBlank + lastDate) % 7); 
	}
	
	// 전체 Td의 갯수
	int totalTd = beginBlank + lastDate + endBlank;
	
	
	
	
	// 마지막날짜
	
	
	
	//	Model 호출 : 일별 cash 목록
	
	
	CashDao cashDao = new CashDao();
	
	System.out.println(year + "<-- year");
	System.out.println(month + "<-- month");
	
	ArrayList<HashMap<String,Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month + 1);
	
	
	
	
		
	
	//	3. View : 달력출력 + 일별 cash 목록
	
		
			
	
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
	
	
	
	            <!-- cashList Start -->
	            <div class="container-fluid pt-4 px-4">
	                <div class="bg-secondary text-center rounded p-4">
	                    <div class="d-flex align-items-center justify-content-center mb-4">
	                        <h3 class="mb-0">
		                        <a href = "<%=request.getContextPath() %>/cash/cashList.jsp?year=<%=year %>&month=<%=month - 1 %>" 
		                        	class = "link-primary">
									<span>이전 달</span>
								</a>
	                        </h3>
	                        <h1 class="mb-0">
		                        <span>&emsp;</span>
	                        	<span><%=year %> 년 <%=month+1 %> 월</span>
		                        <span>&emsp;</span>
	                        </h1>
	                        <h3 class="mb-0">
		                        <a href = "<%=request.getContextPath() %>/cash/cashList.jsp?year=<%=year %>&month=<%=month + 1%>"
		                        	class = "link-primary">
									<span>다음 달</span>
								</a>
	                        </h3>
	                    </div>
	                    <div class="table-responsive">
	                        <table class="table text-start align-middle table-bordered table-hover mb-0">
	                            <thead class = "text-center">
	                                <tr>
										<th class = "text-primary">일</th>
										<th class = "text-white-50">월</th>
										<th class = "text-white-50">화</th>
										<th class = "text-white-50">수</th>
										<th class = "text-white-50">목</th>
										<th class = "text-white-50">금</th>
										<th class = "text-info">토</th>
									</tr>
	                            </thead>
	                            <tbody>
	                                <tr>
										<%
											// 토요일, 일요일 색 구별을 위해 / 요일을 구분하기위해
											Calendar temp = Calendar.getInstance();
											temp.set(Calendar.YEAR, year);
											temp.set(Calendar.MONTH, month);
											for(int i=1; i<=totalTd; i+=1) {
										%>
												<td class = "align-top pb-5">
										<%
												int date = i - beginBlank;
												if(date > 0 && date <= lastDate) {
													
													temp.set(Calendar.DATE, date);
												
													if(temp.get(Calendar.DAY_OF_WEEK) == 1) {
										%>
														<!-- 일요일이면 빨간색 -->
														<div>
															<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>"
																class = "link-primary">
																<%=date %>
															</a>
														</div>
										<%
													} else if(temp.get(Calendar.DAY_OF_WEEK) == 7) {
										%>
														<!-- 토요일이면 파란색 -->
														<div>
															<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>"
																class = "link-info">
																<%=date %>
															</a>
														</div>
										<%		
													} else {
										%>
														<!-- 평일이면 회색 -->
														<div>
															<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>"
																class = "link-light">
																<%=date %>
															</a>
														</div>
										<%
													}
										%>
										
													
													
													<div class = "text-end">
														<%
															for(HashMap<String, Object> m : list) {
																String cashDate = (String) (m.get("cashDate"));
																if(Integer.parseInt(cashDate.substring(8)) == date) {
														%>
																	<%
																		// 수입 : 노란색 / 지출 : 초록색
																		if(((String) m.get("categoryKind")).equals("수입")) {
																			
																	%>
																			<div class = "text-warning">
																			[<%=(String) (m.get("categoryKind")) %>]
																			<%=(String) (m.get("categoryName")) %>
																			&nbsp;
																			<%=(Long) (m.get("cashPrice")) %>원
																			</div>
																	<%
																		} else {
																	%>
																			<div class = "text-success">
																			[<%=(String) (m.get("categoryKind")) %>]
																			<%=(String) (m.get("categoryName")) %>
																			&nbsp;
																			<%=(Long) (m.get("cashPrice")) %>원
																			</div>
																	<%																			
																		}
														
																}
															}
														
														%>
													</div>
										<%
												}
										%>
												</td>
										<%
													if(i % 7 == 0 && i != totalTd) {
										%>
													</tr><tr> <!-- td 7개 만들고 테이블 줄바꿈 -->
										<%
												}
											}
										
										%>
								
									</tr>
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
	            </div>
	            <!-- cashList End -->
	
	
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
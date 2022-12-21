<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%

	//Controller
	String memberId = "goodee";		// 다른 프로젝트라 임의 지정

	// 페이징 변수 초기화
	
	// 연도
	int year = 0;
	int pageLength = 5;
	
	Calendar c = Calendar.getInstance();
	
	int previousMonth = c.get(Calendar.MONTH);
	int importCashByPreviousMonth = 0;	// 지난달 총 수입
	int exportCashByPreviousMonth = 0;	// 지난달 총 지출
	int balanceByPreviousMonth = 0;	// 지난달 잔액 = 지난달 총 수입 - 지난달 총 지출 
	
	if(request.getParameter("year") == null) {
		year = c.get(Calendar.YEAR);	// 올해
	} else {
		year = Integer.parseInt(request.getParameter("year"));
	}
	
	Page yearPage = new Page();
	int previousYear = yearPage.getPreviousYear(year, pageLength);
	int nextYear = yearPage.getNextYear(year, pageLength);
	
	ArrayList<Integer> pageList = new ArrayList<Integer>();
	pageList = yearPage.getYearPageList(year, pageLength);
	
	// 분리된 Model 호출
	ArrayList<HashMap<String, Object>> listMonthByThisYear = new ArrayList<HashMap<String, Object>>();
	ArrayList<HashMap<String, Object>> listYear = new ArrayList<HashMap<String, Object>>();
	ArrayList<HashMap<String, Object>> listMonth = new ArrayList<HashMap<String, Object>>();
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	CashDao cashDao = new CashDao();	
	
	// 지난달 수입/지출
	listMonthByThisYear = cashDao.selectCashMonth(memberId, c.get(Calendar.YEAR));
	
	for(HashMap<String, Object> hm : listMonthByThisYear) {
		
		if(Integer.parseInt((String) hm.get("month")) == (c.get(Calendar.MONTH))) {	// 지난달이면
			
			importCashByPreviousMonth = (int) hm.get("sumImportCash");
			exportCashByPreviousMonth = (int) hm.get("sumExportCash");
			balanceByPreviousMonth = importCashByPreviousMonth - exportCashByPreviousMonth;  
		}
		
	}
	
	
	// 연도별 수입/지출
	listYear = cashDao.selectCashYear(memberId);
	
	// 월별 수입/지출
	listMonth = cashDao.selectCashMonth(memberId, year);
	
	
	
	map = cashDao.selectMinMaxYear();

	int minYear = (Integer) map.get("minYear");
	int maxYear = (Integer) map.get("maxYear");
	
%>



<!DOCTYPE html>
<html>

	<head>
	    <meta charset="utf-8">
	    <title>Index</title>
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
	    
	    
	</head>

	<body>
		<div>
			<!-- 연도별 수입/지출 시작 -->
			<div>
	            <!-- JavaScript 변수로 사용하기 위한 listYear.size() -->
				<input type = "hidden" id = "listYearSize" value = "<%=listYear.size() %>">
	            
	            <!-- JavaScript 변수로 사용하기 위한 year -->
	            <%
	            	for(int i=0; i<listYear.size(); i+=1) {
	            %>
			            <input type = "hidden" id = "listYear<%=i %>" value = "<%=(String) listYear.get(i).get("year") %>년">
				<%	
	            	}
	            %>
	            
	            <!-- JavaScript 변수로 사용하기 위한 연도별 수입합계 sumImportCashByYear -->
	            <%
	            	for(int i=0; i<listYear.size(); i+=1) {
	            %>
			            <input type = "hidden" id = "sumImportCashByYear<%=i %>" value = "<%=(int) listYear.get(i).get("sumImportCash") %>">
	            <%
	            	}
	            %>
	            
	            <!-- JavaScript 변수로 사용하기 위한 연도별 지출합계 sumExportCashByYear -->
	            <%
	            	for(int i=0; i<listYear.size(); i+=1) {
	            %>
			            <input type = "hidden" id = "sumExportCashByYear<%=i %>" value = "<%=(int) listYear.get(i).get("sumExportCash") %>">
	            <%
	            	}
	            %>
			</div>
			<!-- 연도별 수입/지출 끝 -->
			
			
			
			<!-- 월별 수입/지출 시작 -->
			<div>
				<!-- JavaScript 변수로 사용하기 위한 listMonth.size() -->
				<input type = "hidden" id = "listMonthSize" value = "<%=listMonth.size() %>">
				
				<!-- JavaScript 변수로 사용하기 위한 month -->
	            <%
	            	for(int i=0; i<listMonth.size(); i+=1) {
	            %>
			            <input type = "hidden" id = "listMonth<%=i %>" value = "<%=(String) listMonth.get(i).get("month") %>월">
				<%	
	            	}
	            %>
				
				<!-- JavaScript 변수로 사용하기 위한 월별 수입합계 sumImportCashByMonth -->
	            <%
	            	for(int i=0; i<listMonth.size(); i+=1) {
	            %>
			            <input type = "hidden" id = "sumImportCashByMonth<%=i %>" value = "<%=(int) listMonth.get(i).get("sumImportCash") %>">
	            <%
	            	}
	            %>
				
				<!-- JavaScript 변수로 사용하기 위한 월별 지출합계 sumExportCashByMonth -->
	            <%
	            	for(int i=0; i<listMonth.size(); i+=1) {
	            %>
			            <input type = "hidden" id = "sumExportCashByMonth<%=i %>" value = "<%=(int) listMonth.get(i).get("sumExportCash") %>">
	            <%
	            	}
	            %>
			</div>
			<!-- 월별 수입/지출 끝 -->
            
            <!-- 지난달 총 수입/지출/잔액 시작 -->
            <div>
            	<!-- JavaScript 변수로 사용하기 위한 지난달 총 수입 -->
            	<input type = "hidden" id = "importCashByPreviousMonth" value = "<%=importCashByPreviousMonth %>">
            	
            	<!-- JavaScript 변수로 사용하기 위한 지난달 총 지출 -->
            	<input type = "hidden" id = "exportCashByPreviousMonth" value = "<%=exportCashByPreviousMonth %>">
            	
            	<!-- JavaScript 변수로 사용하기 위한 지난달 총 수입 -->
            	<input type = "hidden" id = "balanceByPreviousMonth" value = "<%=balanceByPreviousMonth %>">
            </div>
            <!-- 지난달 총 수입/지출/잔액 끝 -->
            
            
            
            
		</div>
	
	
	
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
				<jsp:include page = "/inc/indexMenu.jsp"></jsp:include>
			</div>
	        <!-- Sidebar End -->
	
	
	        <!-- Content Start -->
	        <div class="content">
	            <!-- Navbar Start -->
         		<div>
					<jsp:include page = "/inc/indexNavBar.jsp"></jsp:include>
				</div>
	            <!-- Navbar End -->
	
				<div class="container-fluid pt-4 px-4">
	                <div class="row g-4">
	                    <div class="col-sm-6 col-xl-4">
	                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
	                            <i class="fa fa-plus fa-3x text-primary"></i>
	                            <div class="ms-3">
	                                <p class="mb-2">지난달(<%=previousMonth %>월) 수입</p>
	                                <h6 class="mb-0">&#8361;<%=importCashByPreviousMonth %></h6>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="col-sm-6 col-xl-4">
	                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
	                            <i class="fa fa-minus fa-3x text-primary"></i>
	                            <div class="ms-3">
	                                <p class="mb-2">지난달(<%=previousMonth %>월) 지출</p>
	                                <h6 class="mb-0">&#8361;<%=exportCashByPreviousMonth %></h6>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="col-sm-6 col-xl-4">
	                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
	                            <i class="fa fa-won-sign fa-3x text-primary"></i>
	                            <div class="ms-3">
	                                <p class="mb-2">지난달(<%=previousMonth %>월) 잔액</p>
	                                <h6 class="mb-0">&#8361;<%=balanceByPreviousMonth %></h6>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
				
				
				
	            <!-- Chart Start -->
	            <div class="container-fluid pt-4 px-4">
	                <div class="row g-4">
	                    <div class="col-sm-12 col-xl-4">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">수입</h6>
	                            <canvas id="line-chart1"></canvas>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-2">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">수입표</h6>
		                        <div>
		                        	<table class = "table">
		                        		<tr>
		                        			<th>항목</th>
		                        			<th>금액</th>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        	</table>
		                        </div>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-4">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">수입</h6>
	                            <canvas id="line-chart2"></canvas>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-2">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">지출표</h6>
		                        <div>
		                        	<table class = "table">
		                        		<tr>
		                        			<th>항목</th>
		                        			<th>금액</th>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        		<tr>
		                        			<td>가나다</td>
		                        			<td>12345</td>
		                        		</tr>
		                        	</table>
		                        </div>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="row align-items-center bg-secondary rounded h-100 p-4">
	                            <div>
		                            <h6 class="mb-4">연도별 수입/지출</h6>
		                            <canvas id="cashYear"></canvas>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">연도별 수입/지출</h6>
	                            <div>
									<table class="table text-center align-middle table-bordered table-hover mb-0">
										<tr>
											<th>년</th>
											<th>[수입] 카운트</th>
											<th>[수입] 합계</th>
											<th>[수입] 평균</th>
											<th>[지출] 카운트</th>
											<th>[지출] 합계</th>
											<th>[지출] 평균</th>
										</tr>
										
										<%
											for(HashMap<String, Object> mapYear : listYear) {
										%>
												<tr>
													<td><%=(String) mapYear.get("year") %></td>
													<td><%=(int) mapYear.get("cntImportCash") %></td>
													<td><%=(int) mapYear.get("sumImportCash") %></td>
													<td><%=(int) mapYear.get("avgImportCash") %></td>
													<td><%=(int) mapYear.get("cntExportCash") %></td>
													<td><%=(int) mapYear.get("sumExportCash") %></td>
													<td><%=(int) mapYear.get("avgExportCash") %></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="row align-items-center bg-secondary rounded h-100 p-4">
	                        	<div>
		                            <h6 class="mb-4"><%=year %>년 월별 수입/지출</h6>
		                            <canvas id="cashMonth"></canvas>
	                        	</div>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4"><%=year %>년 월별 수입/지출</h6>
	                            
	                            <div>
									<table class="table text-center align-middle table-bordered table-hover mb-0">
										<tr>
											<th>월</th>
											<th>[수입] 카운트</th>
											<th>[수입] 합계</th>
											<th>[수입] 평균</th>
											<th>[지출] 카운트</th>
											<th>[지출] 합계</th>
											<th>[지출] 평균</th>
										</tr>
										
										<%
											for(HashMap<String, Object> mapMonth : listMonth) {
										%>
												<tr>
													<td><%=(String) mapMonth.get("month") %></td>
													<td><%=(int) mapMonth.get("cntImportCash") %></td>
													<td><%=(int) mapMonth.get("sumImportCash") %></td>
													<td><%=(int) mapMonth.get("avgImportCash") %></td>
													<td><%=(int) mapMonth.get("cntExportCash") %></td>
													<td><%=(int) mapMonth.get("sumExportCash") %></td>
													<td><%=(int) mapMonth.get("avgExportCash") %></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
								
								<div>&nbsp;</div>
								
								<!-- 연도 페이징 처리 -->
								<div>
									<ul class="pagination justify-content-center">
										
										<!-- 페이지 처음 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/chartTest.jsp?year=<%=minYear %>">
												<span>처음</span>
											</a>
										</li>
										
										<!-- 페이지 이전(-10의 1페이지) -->
										<%
											
											if(previousYear >= minYear) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/chartTest.jsp?year=<%=previousYear %>">
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
														if(year == i) {
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
													if(i >= minYear && i <= maxYear) {
												%>
														<a class="page-link" href="<%=request.getContextPath() %>/chartTest.jsp?year=<%=i %>">
															<span><%=i %>년</span>
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
											if(nextYear <= maxYear) {
										%>
												<li class="page-item">
													<a class="page-link" href="<%=request.getContextPath() %>/chartTest.jsp?year=<%=nextYear %>">
														<span>다음</span>
													</a>
												</li>
										<%
											}
										%>
										
										<!-- 페이지 마지막 -->
										<li class="page-item">
											<a class="page-link" href="<%=request.getContextPath() %>/chartTest.jsp?year=<%=maxYear %>">
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
	            <!-- Chart End -->

				
	
				
								
			                    
	
	
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
	    
	    <!-- 차트 Javascript -->
	    <script>
		    // Chart Global Color
		    Chart.defaults.color = "#6C7293";
		    Chart.defaults.borderColor = "#000000";
		    
		    
		    // 수입 파이차트
			var ctx1 = $("#line-chart1").get(0).getContext("2d");
		    var myChart1 = new Chart(ctx1, {
		        type: "pie",
		        data: {
		            labels: ["Italy", "France", "Spain", "USA", "Argentina"],
		            datasets: [{
		                backgroundColor: [
		                    "rgba(235, 22, 22, .11)",
		                    "rgba(235, 22, 22, .9)",
		                    "rgba(235, 22, 22, .7)",
		                    "rgba(235, 22, 22, .5)",
		                    "rgba(235, 22, 22, .3)"
		                ],
		                data: [30, 49, 44, 24, 15]
		            }]
		        },
		        options: {
		            responsive: true
		        }
		    });
		    
		    
		    // 지출 파이차트		   
			   
		    var ctx2 = $("#line-chart2").get(0).getContext("2d");
		    var myChart2 = new Chart(ctx2, {
		        type: "pie",
		        data: {
		            labels: ["Italy", "France", "Spain", "USA", "Argentina"],
		            datasets: [{
		                backgroundColor: [
		                    "rgba(235, 22, 22, .11)",
		                    "rgba(235, 22, 22, .9)",
		                    "rgba(235, 22, 22, .7)",
		                    "rgba(235, 22, 22, .5)",
		                    "rgba(235, 22, 22, .3)"
		                ],
		                data: [30, 49, 44, 24, 15]
		            }]
		        },
		        options: {
		            responsive: true
		        }
		    });
		    
		    
		    
	
		    // 연도별 수입/지출 지표들
		    
		    // DB에서 input hidden 통해 가져온 listYear
		    let listYear = new Array();
			for(let i=0; i<$('#listYearSize').val(); i+=1) {
		    	listYear[i] = $('#listYear' + i).val();
		    	
		    	// 디버깅
		    	console.log(listYear[i] + ' <-- listYear[' + i + ']');
		    }
			
			// DB에서 input hidden 통해 가져온 sumImportCashByYear
		    let sumImportCashByYear = new Array();
			for(let i=0; i<$('#listYearSize').val(); i+=1) {
		    	sumImportCashByYear[i] = $('#sumImportCashByYear' + i).val();
		    	
		    	// 디버깅
		    	console.log(sumImportCashByYear[i] + ' <-- sumImportCashByYear[' + i + ']');
		    }
			
			// DB에서 input hidden 통해 가져온 sumExportCashByYear
		    let sumExportCashByYear = new Array();
			for(let i=0; i<$('#listYearSize').val(); i+=1) {
		    	sumExportCashByYear[i] = $('#sumExportCashByYear' + i).val();
		    	
		    	// 디버깅
		    	console.log(sumExportCashByYear[i] + ' <-- sumExportCashByYear[' + i + ']');
		    }
			
			
			
		    // 연도별 수입/지출 차트
		    let ctx3 = $("#cashYear").get(0).getContext("2d");
		    let myChart3 = new Chart(ctx3, {
		        type: "bar",
		        data: {
		            labels: listYear,
		            datasets: [{
					    label: "수입",
					    data: sumImportCashByYear,
					    backgroundColor: "rgba(235, 22, 22, .7)"
					}, {
					    label: "지출",
					    data: sumExportCashByYear,
					    backgroundColor: "rgba(235, 22, 22, .3)"
					}]
	            },
	            
		        options: {
		            responsive: true
		        }
		    });

		    
		    
		    
		    // 월별 수입/지출 지표들
		    
		     // DB에서 input hidden 통해 가져온 listMonth
		    let listMonth = new Array();
			for(let i=0; i<$('#listMonthSize').val(); i+=1) {
		    	listMonth[i] = $('#listMonth' + i).val();
		    	
		    	// 디버깅
		    	console.log(listMonth[i] + ' <-- listMonth[' + i + ']');
		    }
			
			// DB에서 input hidden 통해 가져온 sumImportCashByMonth
		    let sumImportCashByMonth = new Array();
			for(let i=0; i<$('#listMonthSize').val(); i+=1) {
		    	sumImportCashByMonth[i] = $('#sumImportCashByMonth' + i).val();
		    	
		    	// 디버깅
		    	console.log(sumImportCashByMonth[i] + ' <-- sumImportCashByMonth[' + i + ']');
		    }
			
			// DB에서 input hidden 통해 가져온 sumExportCashByMonth
		    let sumExportCashByMonth = new Array();
			for(let i=0; i<$('#listMonthSize').val(); i+=1) {
		    	sumExportCashByMonth[i] = $('#sumExportCashByMonth' + i).val();
		    	
		    	// 디버깅
		    	console.log(sumExportCashByMonth[i] + ' <-- sumExportCashByMonth[' + i + ']');
		    }
		    
		    
		    // 월별 수입/지출 차트
		    let ctx4 = $("#cashMonth").get(0).getContext("2d");
		    let myChart4 = new Chart(ctx4, {
		        type: "bar",
		        data: {
		        	
		        	labels: listMonth,
			        datasets: [{
			                label: "수입",
			                data: sumImportCashByMonth,
			                backgroundColor: "rgba(235, 22, 22, .7)"
			            },
			            
			            {
			                label: "지출",
			                data: sumExportCashByMonth,
			                backgroundColor: "rgba(235, 22, 22, .3)"
			            }
			        ]
			        },
			    options: {
			        responsive: true
			    }
			});
	    </script>
	</body>
</html>
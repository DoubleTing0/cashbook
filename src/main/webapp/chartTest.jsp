<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	int x = 200;
%>

<%

	// Controller
	
	// 메세지 출력 변수
	String msg = request.getParameter("msg");	
	

	// 세션 검사
	// 이미 로그인이 되어있다면 cashList.jsp redirect
	if(session.getAttribute("loginMember") != null) {
		
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}
	
	// Model 호출
	
	// 공지 Page 변수 초기화
	Page noticePage = new Page();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int pageLength = 10;
	int rowPerPage = 5;
	
	ArrayList<Integer> pageList = noticePage.getPageList(currentPage, pageLength); 
	int beginRow = noticePage.getBeginRow(currentPage, rowPerPage);
	int previousPage = noticePage.getPreviousPage(currentPage, pageLength);
	int nextPage = noticePage.getNextPage(currentPage, pageLength);
	
	NoticeDao noticeDao = new NoticeDao();
	int count = noticeDao.selectNoticeCount();
	
	int lastPage = noticePage.getLastPage(count, rowPerPage); 
	
	// 멤버 목록 출력 메서드
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	
	
	
	// View
	
	
	
	
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
	                    <div class="col-sm-6 col-xl-3">
	                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
	                            <i class="fa fa-chart-line fa-3x text-primary"></i>
	                            <div class="ms-3">
	                                <p class="mb-2">이월잔액</p>
	                                <h6 class="mb-0">$1234</h6>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="col-sm-6 col-xl-3">
	                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
	                            <i class="fa fa-chart-bar fa-3x text-primary"></i>
	                            <div class="ms-3">
	                                <p class="mb-2">수입</p>
	                                <h6 class="mb-0">$1234</h6>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="col-sm-6 col-xl-3">
	                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
	                            <i class="fa fa-chart-area fa-3x text-primary"></i>
	                            <div class="ms-3">
	                                <p class="mb-2">지출</p>
	                                <h6 class="mb-0">$1234</h6>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="col-sm-6 col-xl-3">
	                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
	                            <i class="fa fa-chart-pie fa-3x text-primary"></i>
	                            <div class="ms-3">
	                                <p class="mb-2">잔액</p>
	                                <h6 class="mb-0">$1234</h6>
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
	                            <canvas id="line-chart123"></canvas>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-2">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">수입표</h6>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-4">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">지출</h6>
	                            <canvas id="line-chart123"></canvas>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-2">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">지출표</h6>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">Multiple Line Chart</h6>
	                            <canvas id="worldwide-sales123"></canvas>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">Single Bar Chart</h6>
	                            <canvas id="bar-chart"></canvas>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">Multiple Bar Chart</h6>
	                            <canvas id="worldwide-sales"></canvas>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">Pie Chart</h6>
	                            <canvas id="pie-chart"></canvas>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xl-6">
	                        <div class="bg-secondary rounded h-100 p-4">
	                            <h6 class="mb-4">Doughnut Chart</h6>
	                            <canvas id="doughnut-chart"></canvas>
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
	    <script>

	    // Pie Chart
	   
	   
	    var ctx5 = $("#line-chart123").get(0).getContext("2d");
	    var myChart5 = new Chart(ctx5, {
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
	                data: [<%=x%>, 49, 44, 24, 15]
	            }]
	        },
	        options: {
	            responsive: true
	        }
	    });
	    
	    

	    // Worldwide Sales Chart
	    var ctx1 = $("#worldwide-sales123").get(0).getContext("2d");
	    var myChart1 = new Chart(ctx1, {
	        type: "bar",
	        data: {
	            labels: ["2016월", "2017", "2018", "2019", "2020", "2021", "2022"],
	            datasets: [{
	                    label: "USA",
	                    data: [15, 30, 55, 65, 60, 80, 95],
	                    backgroundColor: "rgba(235, 22, 22, .7)"
	                },
	                
	                {
	                    label: "AU",
	                    data: [12, 25, 45, 55, 65, 70, 60],
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
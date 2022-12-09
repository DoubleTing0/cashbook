<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%

	//Controller

	// 메세지 출력 변수 초기화
	String msg = request.getParameter("msg");	
	
	// 로그인 검증 
	Member loginMember = (Member) session.getAttribute("loginMember");

	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
	}

		
	// request
	String categoryNo = request.getParameter("categoryNo");
	
	// null, 공백 검증
	if(categoryNo == null || categoryNo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/category/categoryList.jsp?msg=" + msg);
		return;
		
	}

	
	// Model 호출
	
	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(categoryNo));
	
	CategoryDao categoryDao = new CategoryDao();
	Category resultCategory = categoryDao.selectCategoryOne(category);
	


%>
<!DOCTYPE html>
<html>

	<head>
	    <meta charset="utf-8">
	    <title>카테고리수정</title>
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
    <div class="container-fluid position-relative d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- 카테고리 수정 Start -->
        <div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                    <div class="bg-secondary rounded p-4 p-sm-5 my-4 mx-3">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <h3 class="text-primary">
                            	<a href="<%=request.getContextPath() %>/admin/adminMain.jsp">
                                	<i class="fa fa-key me-2"></i>관리자
                            	</a>
                           	</h3>
                            <h3>카테고리수정</h3>
                        </div>
                        <div>
                        	<form action = "<%=request.getContextPath() %>/admin/category/updateCategoryAction.jsp" method = "post">
		                        <div>
									<input type = "hidden" name = "categoryNo" value = "<%=resultCategory.getCategoryNo() %>">
								</div>
		                        
		                        <fieldset class="row mb-3">
                                    <legend class="col-form-label col-sm-2 pt-0">수입/지출</legend>
                                    <div class="col-sm-10">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="categoryKind"
                                                id="gridRadios1" value="수입" checked>
                                            <label class="form-check-label" for="gridRadios1">
                                                수입
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="categoryKind"
                                                id="gridRadios2" value="지출"
                                            <%
												if(resultCategory.getCategoryKind().equals("지출")) {
											%>
													checked = "checked"
											<%
												}
											%>
                                            > <!-- <input ~ > 닫은 것. 오타 아님 -->
                                            <label class="form-check-label" for="gridRadios2">
                                                지출
                                            </label>
                                        </div>
                                    </div>
                                </fieldset>
		                        
		                        <div class="form-floating mb-3">
	                                <input type="text" class="form-control" name = "categoryName" value = "<%=resultCategory.getCategoryName() %>"
	                                	id="categoryName" placeholder="이름">
	                                <label for="categoryName">이름</label>
	                            </div>
		                        <button type="submit" class="btn btn-primary py-3 w-100 mb-4">수정</button>
                        	</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 카테고리수정 End -->
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
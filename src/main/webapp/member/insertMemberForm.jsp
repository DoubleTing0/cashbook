<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	



%>
<!DOCTYPE html>
<html>

	<head>
	    <meta charset="utf-8">
	    <title>회원 가입</title>
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
	
	
	        <!-- 회원 가입 Start -->
	        <div class="container-fluid">
	            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
	                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
	                    <div class="bg-secondary rounded p-4 p-sm-5 my-4 mx-3">
	                        <div class="d-flex align-items-center justify-content-between mb-3">
	                            <h3 class="text-primary">
	                            	<a href="<%=request.getContextPath() %>/cash/cashList.jsp">
	                                	<i class="fa fa-user-edit me-2"></i>가계부
	                            	</a>
	                           	</h3>
	                            <h3>회원가입</h3>
	                        </div>
	                        <div>
	                        	<form action = "<%=request.getContextPath() %>/member/insertMemberAction.jsp" method = "post" id = "insertMemberForm">
	                        	
			                        <div class="form-floating mb-3">
			                            <input type="text" class="form-control" name = "memberId" id="memberId" placeholder="ID">
			                            <label for="memberId">ID</label>
			                        </div>
			                        <div class="form-floating mb-4">
			                            <input type="password" class="form-control" name = "memberPw" id="memberPw" placeholder="Password">
			                            <label for="memberPw">Password</label>
			                        </div>
			                        <div class="form-floating mb-3">
			                            <input type="text" class="form-control" name = "memberName" id="memberName" placeholder="이름">
			                            <label for="memberName">이름</label>
			                        </div>
			                        <div>
				                        <button type="button" id = "insertMemberBtn" class="btn btn-primary py-3 w-100 mb-4">가입</button>
			                        </div>
	                        	</form>
			                </div>
			                <div>
			                	<p class="text-center mb-0">
			                		<span>이미 회원이신가요? &emsp;&emsp;</span>
			                		<a href="<%=request.getContextPath()%>/login/loginForm.jsp">
			                			<span>로그인</span>
			                		</a>
			                	</p>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <!-- 회원 가입 End -->
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
	    
   	    <!-- Javascript Form 공백 검증 -->
	    <script>
			let insertMemberBtn = document.querySelector('#insertMemberBtn');
			insertMemberBtn.addEventListener('click', function() {
			
				// 디버깅
				console.log('insertMemberBtn click!');
				
				// ID
				let memberId = document.querySelector('#memberId');
				if(memberId.value == '') {
					alert('아이디를 입력하세요.');
					memberId.focus();
					return;
				}
				
				// Password
				let memberPw = document.querySelector('#memberPw');
				if(memberPw.value == '') {
					alert('비밀번호를 입력하세요.');
					memberPw.focus();
					return;
				}
				
				// Name
				let memberName = document.querySelector('#memberName');
				if(memberName.value == '') {
					alert('이름를 입력하세요.');
					memberName.focus();
					return;
				}
				
				let insertMemberForm = document.querySelector('#insertMemberForm');
				insertMemberForm.submit();
				
			});
			
			
			
		</script>       
	    
	    
	</body>

</html>
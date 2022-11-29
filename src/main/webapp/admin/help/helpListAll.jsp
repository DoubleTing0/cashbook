<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>


<%

	// Controller
	
	// 메세지 출력 변수
	String msg = request.getParameter("msg");	
	

	// 로그인 검증
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}

	
	
	// 문의 Page 변수 초기화
	Page helpPage = new Page();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int pageLength = 10;
	int rowPerPage = 10;
	
	ArrayList<Integer> pageList = helpPage.getPageList(currentPage, pageLength); 
	int beginRow = helpPage.getBeginRow(currentPage, rowPerPage);
	int previousPage = helpPage.getPreviousPage(currentPage, pageLength);
	int nextPage = helpPage.getNextPage(currentPage, pageLength);
	
	HelpDao helpDao = new HelpDao();
	int count = helpDao.selectHelpCount();
	
	int lastPage = helpPage.getLastPage(count, rowPerPage); 
	
	// 문의 목록 출력 메서드
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);
	
	

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>helpListAll.jsp</title>
		
		<!-- Bootstrap5를 참조한다 시작-->
		
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		
		<!-- Bootstrap5를 참조한다 끝-->
		
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
		<div>
			<div>
				<h1>문의관리</h1>
			</div>
			
			<div>&nbsp;</div>
			
			<!-- 관리자 메뉴 -->
			<div>
				<jsp:include page = "/inc/adminMenu.jsp"></jsp:include>
			</div>
		
			<div>&nbsp;</div>
		
			<div>
				<table border = "1">
					<tr>
						<th>문의내용</th>
						<th>회원ID</th>
						<th>문의날짜</th>
						<th>답변내용</th>
						<th>답변날짜</th>
						<th>답변추가 / 수정 / 삭제</th>
					</tr>
					<%
						for(HashMap<String, Object> m : helpList) {
					%>
							<tr>
								<td><%=m.get("helpMemo") %></td>
								<td><%=m.get("memberId") %></td>
								<td><%=m.get("helpCreatedate") %></td>
								<td>
									<%
										if(m.get("commentMemo") == null) {
									%>
											<span>답변 전</span>
									<%
										} else {
									%>
											<%=m.get("commentMemo") %>
									<%
										}
									%>
								</td>
								<td>
									<%
										if(m.get("commentCreatedate") == null) {
									%>
											<span>답변 전</span>
									<%
										} else {
									%>
											<%=m.get("commentCreatedate") %>
									<%
										}
									%>
								
								</td>
								<td>
									<%
										if(m.get("commentMemo") == null) {
									%>
											 <!-- insertComment.jsp?helpNo= -->
											<a href = "<%=request.getContextPath() %>/admin/help/insertCommentForm.jsp?helpNo=<%=m.get("helpNo") %>">답변입력 </a>
									<%
										} else {
									%>
											<a href = "<%=request.getContextPath() %>/admin/help/updateCommentForm.jsp?commentNo=<%=m.get("commentNo") %>">수정 </a>
											<span>/ </span>
											<a href = "<%=request.getContextPath() %>/admin/help/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo") %>">삭제 </a>
									<%
										}
									%>
								</td>
							</tr>
					<%
						}
					%>			
					
				
				
				
				</table>
			</div>
		
			<div>&nbsp;</div>
			
			
			<!-- 문의 페이징 처리 시작 -->
			<div>
				<ul class="pagination">
					
					<!-- 페이지 처음 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/admin/help/helpListAll.jsp?currentPage=1">
							<span>처음</span>
						</a>
					</li>
					
					<!-- 페이지 이전(-10의 1페이지) -->
					<%
						
						if(previousPage > 0) {
					%>
							<li class="page-item">
								<a class="page-link" href="<%=request.getContextPath() %>/admin/help/helpListAll.jsp?currentPage=<%=previousPage %>">
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
									<a class="page-link" href="<%=request.getContextPath() %>/admin/help/helpListAll.jsp?currentPage=<%=i %>">
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
								<a class="page-link" href="<%=request.getContextPath() %>/admin/help/helpListAll.jsp?currentPage=<%=nextPage %>">
									<span>다음</span>
								</a>
							</li>
					<%
						}
					%>
					
					<!-- 페이지 마지막 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/admin/help/helpListAll.jsp?currentPage=<%=lastPage%>">
							<span>마지막</span>
						</a>
					</li>
				</ul>
			</div>			
		
			<!-- 문의 페이징 처리 끝 -->
		
		
		
		</div>
	</body>
</html>
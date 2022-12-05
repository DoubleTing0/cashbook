<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%

	// Controller
	
	// 메세지 출력 변수
	String msg = request.getParameter("msg");	
	

	// 로그인 안되있거나 관리자가 아닐때 loginForm.jsp redirect
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}
	
	// Model 호출
	
	// 공지 Page 변수 초기화
	Page noticePage = new Page();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int pageLength = 10;
	int rowPerPage = 10;
	
	ArrayList<Integer> pageList = noticePage.getPageList(currentPage, pageLength); 
	int beginRow = noticePage.getBeginRow(currentPage, rowPerPage);
	int previousPage = noticePage.getPreviousPage(currentPage, pageLength);
	int nextPage = noticePage.getNextPage(currentPage, pageLength);
	
	NoticeDao noticeDao = new NoticeDao();
	int count = noticeDao.selectNoticeCount();
	
	int lastPage = noticePage.getLastPage(count, rowPerPage); 
	
	// 멤버 목록 출력 메서드
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	
	
	
	// View
	
	
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeList.jsp</title>
		
		
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
			<!-- 관리자 메뉴 -->
			<div>
				<jsp:include page = "/inc/adminMenu.jsp"></jsp:include>
			</div>
			
			<div>
				<h1>공지</h1>
			</div>
			
			<div>
				<a href = "<%=request.getContextPath() %>/admin/notice/insertNoticeForm.jsp">공지추가</a>
			
			</div>
			
			
			<div>
				<table border = "1">
					<tr>
						<th>공지내용</th>			
						<th>공지날짜</th>			
						<th>수정</th>			
						<th>삭제</th>			
					</tr>
		
					<%
						for(Notice n : noticeList) {
					%>
							<tr>
								<td><%=n.getNoticeMemo() %></td>
								<td><%=n.getCreatedate() %></td>
								<td>
									<a href = "<%=request.getContextPath() %>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo() %>">수정</a>
								</td>
								<td>
									<a href = "<%=request.getContextPath() %>/admin/notice/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo() %>">삭제</a>
								</td>
							</tr>
					<%
						}
					%>
					
				
				</table>
			</div>
		</div>
		
		<div>&nbsp;</div>
		
		
		<!-- 공지 페이징 처리 시작 -->
		<div>
			<ul class="pagination">
				
				<!-- 페이지 처음 -->
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath() %>/admin/notice/noticeList.jsp?currentPage=1">
						<span>처음</span>
					</a>
				</li>
				
				<!-- 페이지 이전(-10의 1페이지) -->
				<%
					
					if(previousPage > 0) {
				%>
						<li class="page-item">
							<a class="page-link" href="<%=request.getContextPath() %>/admin/notice/noticeList.jsp?currentPage=<%=previousPage %>">
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
								<a class="page-link" href="<%=request.getContextPath() %>/admin/notice/noticeList.jsp?currentPage=<%=i %>">
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
							<a class="page-link" href="<%=request.getContextPath() %>/admin/notice/noticeList.jsp?currentPage=<%=nextPage %>">
								<span>다음</span>
							</a>
						</li>
				<%
					}
				%>
				
				<!-- 페이지 마지막 -->
				<li class="page-item">
					<a class="page-link" href="<%=request.getContextPath() %>/admin/notice/noticeList.jsp?currentPage=<%=lastPage%>">
						<span>마지막</span>
					</a>
				</li>
			</ul>
		</div>			
	
		<!-- 공지 페이징 처리 끝 -->	
		
		
	</body>
</html>
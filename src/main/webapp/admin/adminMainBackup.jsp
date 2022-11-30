<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>


<%


	// Controller
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	

	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
	}
	
	// Model 호출
	
	// 최근 공지 5개, 최근 멤버 5명	
	
	// Model 호출
	
	// 공지 Page 변수 초기화
	Page noticePage = new Page();
	
	int noticeCurrentPage = 1;
	if(request.getParameter("noticeCurrentPage") != null) {
		noticeCurrentPage = Integer.parseInt(request.getParameter("noticeCurrentPage"));
	}
	
	int noticePageLength = 10;
	int noticeRowPerPage = 5;
	
	ArrayList<Integer> noticePageList = noticePage.getPageList(noticeCurrentPage, noticePageLength); 
	int noticeBeginRow = noticePage.getBeginRow(noticeCurrentPage, noticeRowPerPage);
	int noticePreviousPage = noticePage.getPreviousPage(noticeCurrentPage, noticePageLength);
	int noticeNextPage = noticePage.getNextPage(noticeCurrentPage, noticePageLength);
	
	NoticeDao noticeDao = new NoticeDao();
	int noticeCount = noticeDao.selectNoticeCount();
	
	int noticeLastPage = noticePage.getLastPage(noticeCount, noticeRowPerPage); 
	
	// 공지 목록 출력 메서드
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(noticeBeginRow, noticeRowPerPage);
	
	
	
	// 멤버 Page 변수 초기화
	Page memberPage = new Page();
	
	int memberCurrentPage = 1;
	if(request.getParameter("memberCurrentPage") != null) {
		memberCurrentPage = Integer.parseInt(request.getParameter("memberCurrentPage"));
	}
	
	int memberPageLength = 10;
	int memberRowPerPage = 5;
	
	ArrayList<Integer> memberPageList = memberPage.getPageList(memberCurrentPage, memberPageLength); 
	int memberBeginRow = memberPage.getBeginRow(memberCurrentPage, memberRowPerPage);
	int memberPreviousPage = memberPage.getPreviousPage(memberCurrentPage, memberPageLength);
	int memberNextPage = memberPage.getNextPage(memberCurrentPage, memberPageLength);
	
	MemberDao memberDao = new MemberDao();
	int memberCount = memberDao.selectMemberCount();
	
	int memberLastPage = memberPage.getLastPage(memberCount, memberRowPerPage); 
	
	// 멤버 목록 출력 메서드
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(memberBeginRow, memberRowPerPage);
	
	
	
	
	
	
	
	// View
	
	
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>adminMain.jsp</title>
		
		<!-- Bootstrap5를 참조한다 시작-->
		
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		
		<!-- Bootstrap5를 참조한다 끝-->
		
	</head>
	
	<body>
		<div>
			<!-- 관리자 메뉴 -->
			<div>
				<!-- include 주체는 서버라서 경로를 서버기준으로 생각해야한다.
					 request.getContextPath() 쓰지마라. 
					 이미 같이 안에 있기 때문에 context path를 가져올 필요가 없다.-->
				<jsp:include page = "/inc/adminMenu.jsp"></jsp:include>
			</div>
			
			
			<div>&nbsp;</div>
			
			<!-- 공지 5개 목록 -->
			<div>
				<table border = "1">
					<tr>
					
						<th>공지내용</th>
						<th>날짜</th>
					</tr>
				
					<%
						for(Notice n : noticeList) {
					%>
							<tr>
								<td><%=n.getNoticeMemo() %></td>
								<td><%=n.getCreatedate() %></td>
							</tr>
					<%
						}
					%>
				</table>
			</div>
			
			<div>&nbsp;</div>
				
			<!-- 공지 페이징 처리 시작 -->
			<div>
				<ul class="pagination">
					
					<!-- 페이지 처음 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=1&memberCurrentPage=<%=memberCurrentPage %>">
							<span>처음</span>
						</a>
					</li>
					
					<!-- 페이지 이전(-10의 1페이지) -->
					<%
						
						if(noticePreviousPage > 0) {
					%>
							<li class="page-item">
								<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=<%=noticePreviousPage %>&memberCurrentPage=<%=memberCurrentPage %>">
									<span>이전</span>
								</a>
							</li>
					<%
						}
					%>		
				
				  
				  	<!-- 페이지 1 ~ 10 -->
					<%
				  		for(int i : noticePageList) {
				  	%>
							<!-- 현재페이지만 구분하기 위한 active 속성 조건문-->
							<li 
								<%
									if(noticeCurrentPage == i) {
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
								if(i <= noticeLastPage) {
							%>
									<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=<%=i %>&memberCurrentPage=<%=memberCurrentPage %>">
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
						if(noticeNextPage <= noticeLastPage) {
					%>
							<li class="page-item">
								<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=<%=noticeNextPage %>&memberCurrentPage=<%=memberCurrentPage %>">
									<span>다음</span>
								</a>
							</li>
					<%
						}
					%>
					
					<!-- 페이지 마지막 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?noticeCurrentPage=<%=noticeLastPage%>&memberCurrentPage=<%=memberCurrentPage %>">
							<span>마지막</span>
						</a>
					</li>
				</ul>
			</div>			
		
			<!-- 공지 페이징 처리 끝 -->			
			
			<div>&nbsp;</div>
				
			<!-- 멤버 목록 출력 -->
			
			<div>
				<table border = "1">
					<tr>
						<th>memberId</th>
						<th>memberLevel</th>
						<th>memberName</th>
						<th>createdate</th>
					</tr>
				
					<%
						for(Member m : memberList) {
					%>
							<tr>
								<td><%=m.getMemberId() %></td>
								<td><%=m.getMemberLevel() %></td>
								<td><%=m.getMemberName() %></td>
								<td><%=m.getCreatedate() %></td>
							</tr>
					<%
						}
					%>
				</table>
			</div>
			
			<div>&nbsp;</div>
			
			<!-- 멤버 페이징 처리 시작 -->
			<div>
				<ul class="pagination">
					
					<!-- 페이지 처음 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=1&noticeCurrentPage=<%=noticeCurrentPage %>">
							<span>처음</span>
						</a>
					</li>
					
					<!-- 페이지 이전(-10의 1페이지) -->
					<%
						
						if(memberPreviousPage > 0) {
					%>
							<li class="page-item">
								<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=<%=memberPreviousPage %>&noticeCurrentPage=<%=noticeCurrentPage %>">
									<span>이전</span>
								</a>
							</li>
					<%
						}
					%>		
				
				  
				  	<!-- 페이지 1 ~ 10 -->
					<%
				  		for(int i : memberPageList) {
				  	%>
							<!-- 현재페이지만 구분하기 위한 active 속성 조건문-->
							<li 
								<%
									if(memberCurrentPage == i) {
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
								if(i <= memberLastPage) {
							%>
									<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=<%=i %>&noticeCurrentPage=<%=noticeCurrentPage %>">
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
						if(memberNextPage <= memberLastPage) {
					%>
							<li class="page-item">
								<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=<%=memberNextPage %>&noticeCurrentPage=<%=noticeCurrentPage %>">
									<span>다음</span>
								</a>
							</li>
					<%
						}
					%>
					
					<!-- 페이지 마지막 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/admin/adminMain.jsp?memberCurrentPage=<%=memberLastPage%>&noticeCurrentPage=<%=noticeCurrentPage %>">
							<span>마지막</span>
						</a>
					</li>
				</ul>
			</div>			
		
			<!-- 멤버 페이징 처리 끝 -->
		
		</div>
		
		
	</body>
</html>
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
	
	// 멤버 Page 변수 초기화
	Page memberPage = new Page();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int pageLength = 10;
	int rowPerPage = 10;
	
	ArrayList<Integer> pageList = memberPage.getPageList(currentPage, pageLength); 
	int beginRow = memberPage.getBeginRow(currentPage, rowPerPage);
	int previousPage = memberPage.getPreviousPage(currentPage, pageLength);
	int nextPage = memberPage.getNextPage(currentPage, pageLength);
	
	MemberDao memberDao = new MemberDao();
	int count = memberDao.selectMemberCount();
	
	int lastPage = memberPage.getLastPage(count, rowPerPage); 
	
	// 멤버 목록 출력 메서드
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	
	
	
	// View
	
	
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>memberList.jsp</title>
		
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
				<h1>멤버목록</h1>
			</div>
			
			<div>&nbsp;</div>
			
			<div>
				<table border = "1">
					<tr>
						<th>멤버번호</th>
						<th>아이디</th>
						<th>레벨</th>
						<th>이름</th>
						<th>마지막수정일</th>
						<th>생성일</th>
						<th>레벨수정</th>
						<th>강제탈퇴</th>
					</tr>
					
					<%
						for(Member m : memberList) {
					%>
							<tr>
								<td><%=m.getMemberNo() %></td>
								<td><%=m.getMemberId() %></td>
								<td><%=m.getMemberLevel() %></td>
								<td><%=m.getMemberName() %></td>
								<td><%=m.getUpdatedate()%></td>
								<td><%=m.getCreatedate()%></td>
								<td>
									<a href = "<%=request.getContextPath() %>/admin/member/updateLevelForm.jsp?memberId=<%=m.getMemberId() %>">레벨수정</a>
								</td>
								<td>
									<a href = "<%=request.getContextPath() %>/admin/member/deleteMemberByAdmin.jsp?memberId=<%=m.getMemberId() %>">강제탈퇴</a>
								</td>
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
						<a class="page-link" href="<%=request.getContextPath() %>/admin/member/memberList.jsp?currentPage=1">
							<span>처음</span>
						</a>
					</li>
					
					<!-- 페이지 이전(-10의 1페이지) -->
					<%
						
						if(previousPage > 0) {
					%>
							<li class="page-item">
								<a class="page-link" href="<%=request.getContextPath() %>/admin/member/memberList.jsp?currentPage=<%=previousPage %>">
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
									<a class="page-link" href="<%=request.getContextPath() %>/admin/member/memberList.jsp?currentPage=<%=i %>">
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
								<a class="page-link" href="<%=request.getContextPath() %>/admin/member/memberList.jsp?currentPage=<%=nextPage %>">
									<span>다음</span>
								</a>
							</li>
					<%
						}
					%>
					
					<!-- 페이지 마지막 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/admin/member/memberList.jsp?currentPage=<%=lastPage%>">
							<span>마지막</span>
						</a>
					</li>
				</ul>
			</div>			
		
			<!-- 멤버 페이징 처리 끝 -->	
			
		
		</div>
	</body>
</html>
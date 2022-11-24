<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%
	// 1. Controller
	
	// 세션 검사
	// 이미 로그인이 되어있다면 cashList.jsp redirect
	if(session.getAttribute("loginMember") != null) {
		
		response.sendRedirect(request.getContextPath() + "/cash/cashList.jsp");
		return;
	}


	// 메세지 출력 변수
	String msg = request.getParameter("msg");
	
	// page
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	int previousPage = (((currentPage - 1) / 10) * 10) - 9;
	int nextPage = (((currentPage - 1) / 10) * 10) + 11;
	
	int pageList = 0;
	
	
	NoticeDao noticeDao = new NoticeDao();
	
	
	int count = noticeDao.noticeCount();
	
	int lastPage = count / rowPerPage;
	if((count % rowPerPage) != 0) {
		lastPage += 1;
	}
	
	// 공지 목록 출력 메서드
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	MemberDao memberDao = new MemberDao();
	
	// 멤버 목록 출력 메서드
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	
	
	
	
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
		
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
				<h1>로그인</h1>
			</div>
		
			<div>&nbsp;</div>
		
			<!-- 공지 5개 목록 페이징 -->
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
						<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?currentPage=1">
							<span>처음</span>
						</a>
					</li>
					
					
					<!-- 페이지 이전(-10의 1페이지) -->
					<%
						
						if(previousPage > 0) {
					%>
							<li class="page-item">
								<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?currentPage=<%=previousPage %>">
									<span>이전</span>
								</a>
							</li>
					<%
						}
					%>		
				
				  
				  	<!-- 페이지 1 ~ 10 -->
					<%
				  	
				  		for(int x=1; x<=10; x+=1) {
				  			pageList = (((currentPage - 1) / 10) * 10) + x;
				  	%>
							<!-- 현재페이지만 구분하기 위한 active 속성 조건문-->
							<li 
								<%
									if(currentPage == pageList) {
								%>
										class = "page-item active"
								<%
									} else {
								%>
										class = "page-item"
								<%						
									}
								%>
							>
							
							<!-- 마지막 페이지까지만 출력하기 위한 조건문 -->					
							<%
								if(pageList <= lastPage) {
							%>
									<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?currentPage=<%=pageList %>">
										<span><%=pageList %></span>
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
								<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?currentPage=<%=nextPage %>">
									<span>다음</span>
								</a>
							</li>
					<%
						}
					%>
					
					
					<!-- 페이지 마지막 -->
					<li class="page-item">
						<a class="page-link" href="<%=request.getContextPath() %>/login/loginForm.jsp?currentPage=<%=lastPage%>">
							<span>마지막</span>
						</a>
					</li>
					
				  
				</ul>
			</div>			
		
			<!-- 공지 페이징 처리 끝 -->			
			
			<div>&nbsp;</div>
			
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
			
			<div>
				<form method = "post" action = "<%=request.getContextPath()%>/login/loginAction.jsp">
					<div>
						<table border = "1">
							<tr>
								<th>아이디</th>
								<td>
									<input type = "text" name = "memberId">
								</td>
							</tr>
							
							<tr>
								<th>비밀번호</th>
								<td>
									<input type = "password" name = "memberPw">
								</td>
							</tr>
						
						</table>
					</div>
					
					<div>
						<button type = "submit">로그인 </button>
						<button type = "button" onClick = "location.href='<%=request.getContextPath() %>/member/insertMemberForm.jsp'">회원가입</button>
					</div>
				</form>
			</div>
		
		</div>
	</body>
</html>
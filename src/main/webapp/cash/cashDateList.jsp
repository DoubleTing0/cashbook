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
	
	// 로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}
	
	

	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member) (session.getAttribute("loginMember"));


	
	// request
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	
	
	// 2. Model 호출
	
	CashDao cashDao = new CashDao();
	
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month + 1, date);
	
	
	
	CategoryDao categoryDao = new CategoryDao();
	
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	
	
	
%>







<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashDateList</title>
	</head>
	
	<body>
		
		<div>
		
			<!-- 로그인 정보 partical jsp 구성 -->
			<div>
				<!-- include 주체는 서버라서 경로를 서버기준으로 생각해야한다.
					 request.getContextPath() 쓰지마라. 
					 이미 같이 안에 있기 때문에 context path를 가져올 필요가 없다.-->
				<jsp:include page = "/inc/loginInformation.jsp"></jsp:include>
			</div>
		
		
		
			
			<div>
				<h1>
					<%=year %>년 <%=month + 1 %>월 <%=date %>일
					
					<a href = "<%=request.getContextPath() %>/cash/cashList.jsp?year=<%=year %>&month=<%=month %>">
						달력으로
					</a>
				</h1>
			</div>
			
			
			
			<!-- cash 입력 폼 -->
			<form method = "post" action = "<%=request.getContextPath() %>/cash/insertCashAction.jsp">
				<input type = "hidden" name = "memberId" value = "<%=loginMember.getMemberId() %>">
				<table border = "1">
					<tr>
						<td>categoryNo</td>
						<td>
							<select name = "categoryNo">
								<%
									// category 목록 출력
									for(Category c : categoryList) {
								%>
										<option value = "<%=c.getCategoryNo() %>">
											[<%=c.getCategoryKind() %>] <%=c.getCategoryName() %>
										</option>
								<%
									}
								%>
							</select>
						</td>
					</tr>
					
					<tr>
						<td>cashDate</td>
						<td>
							<input type = "text" name = "cashDate" value = "<%=year %>-<%=month %>-<%=date %>" readonly = "readonly">
						</td>
					</tr>
						
					<tr>
						<td>cashMemo</td>
						<td>
							<textarea rows = "3" cols = "50" name = "cashMemo"></textarea>
						</td>
					</tr>	
				
				
				</table>
			
				<button type = "button">입력</button>
			
			
			
			</form>
			
			
			
			
			
			
			
			
			
			
			
			
			<!-- cash 목록 출력 -->
			
			<div>
				<table border = "1">
					<tr>
						<th>categoryKind</th>
						<th>categoryName</th>
						<th>cashPrice</th>
						<th>cashMemo</th>
						<th>수정</th><!-- /cash/updateCash.jsp?cashNo= 넘겨주기 -->
						<th>삭제</th><!-- /cash/deleteCash.jsp?cashNo= 넘겨주기-->
					</tr>
					
						
					<%
						for(HashMap<String, Object> m : list) {
							
					%>
								<tr>
									<td><%=(String) (m.get("categoryKind")) %></td>
									<td><%=(String) (m.get("categoryName")) %></td>
									<td><%=(Long) (m.get("cashPrice")) %>원</td>
									<td><%=(String) (m.get("cashMemo")) %></td>
									<td>
										<a href = "">수정</a>
									</td>
									<td>
										<a href = "">삭제</a>
									</td>
								</tr>
					<%
							
						}
					
					%>	
				</table>
			</div>
			
			
			
			
		</div>
		
		
		
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>


<%
	// 1. Controller : session, request
	
	// 로그인 세션 검사
	if(session.getAttribute("loginMember") == null) {
		
		// 세션의 loginMember가 null이면 loginForm.jsp redirect
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
		
	}
	
	
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member) (session.getAttribute("loginMember"));
	
	
	//	request 년 + 월
	
	int year = 0;
	int month = 0;
	
	if(request.getParameter("year") == null || request.getParameter("month") == null 
			|| request.getParameter("year").equals("") || request.getParameter("month").equals("")) {
		
		Calendar today = Calendar.getInstance();	//	오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
		
	} else {
		
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
	
		if(month == -1) {
			month = 11;		// 12월
			year -= 1;
			
		}
		if(month == 12) {
			month = 0;		// 1월
			year += 1;
		}
		
	}
	
	
	//	출력하고자 하는 월과 그 월의 1일의 요일(일 1, 월 2, 화 3, ... 토 7)
	Calendar targetDate = Calendar.getInstance();
	
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	
	// 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay -1;
	
	int endBlank = 0;	// beginBlank + lastDate + endBlank  --> 7로 나누어 떨어진다.
	
	
	
	//	마지막 날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	if((beginBlank + lastDate) % 7 != 0) {
		
		endBlank = 7 - ((beginBlank + lastDate) % 7); 
	}
	
	// 전체 Td의 갯수
	int totalTd = beginBlank + lastDate + endBlank;
	
	
	
	
	// 마지막날짜
	
	
	
	//	Model 호출 : 일별 cash 목록
	
	
	CashDao cashDao = new CashDao();
	
	System.out.println(year + "<-- year");
	System.out.println(month + "<-- month");
	
	ArrayList<HashMap<String,Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month + 1);
	
	
	
	
		
	
	//	3. View : 달력출력 + 일별 cash 목록
	
		
			
	
%>



<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashList</title>
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
					<a href = "<%=request.getContextPath() %>/cash/cashList.jsp?year=<%=year %>&month=<%=month - 1 %>">
						이전 달
					</a>
					<%=year %> 년 <%=month+1 %> 월
					<a href = "<%=request.getContextPath() %>/cash/cashList.jsp?year=<%=year %>&month=<%=month + 1%>">
						다음 달
					</a>
				</h1>
			</div>
			
			
			<!-- 달력 -->
			<div>
				<table border = "1">
					<tr>
						<th>일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th>토</th>
					</tr>
					
					<tr>
					<%
						for(int i=1; i<=totalTd; i+=1) {
					%>
							<td>
					<%
							int date = i - beginBlank;
							if(date > 0 && date <= lastDate) {
					%>
								<div>
									<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>">
										<%=date %>
									</a>
								</div>
								
								
								<div>
									<%
										for(HashMap<String, Object> m : list) {
											String cashDate = (String) (m.get("cashDate"));
											if(Integer.parseInt(cashDate.substring(8)) == date) {
									%>
												[<%=(String) (m.get("categoryKind")) %>]
												<%=(String) (m.get("categoryName")) %>
												&nbsp;
												<%=(Long) (m.get("cashPrice")) %>원
												<br>
									<%
											}
										}
									
									%>
								</div>
					<%
							} 
					%>
							</td>
					<%
								if(i % 7 == 0 && i != totalTd) {
					%>
								</tr><tr> <!-- td 7개 만들고 테이블 줄바꿈 -->
					<%
							}
						}
					
					%>
			
					</tr>
				</table>
			</div>
			
			
			
		</div>
	</body>
</html>
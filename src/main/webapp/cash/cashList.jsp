<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>


<%
	Member sessionMember = new Member();
	sessionMember =(Member) (session.getAttribute("loginMember"));

	
	//	Controller : session, request
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
			month = 11;
			year -= 1;
			
		}
		if(month == 12) {
			month = 0;
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
	
	ArrayList<HashMap<String,Object>> list = cashDao.selectCashListByMonth(year, month + 1);
	
	
	
	
		
	
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
		
			<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
			 
			
			
			
			
			
			
			<div>
				<%=year %> 년 <%=month+1 %> 월
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
					
					<%
						for(int i=1; i<=totalTd; i+=1) {
							
							if(i - beginBlank > 0 && i - beginBlank <= lastDate) {
					%>
								<td><%=i - beginBlank %></td>
					<%
							} else {
					%>
								<td>&nbsp;</td>
					<%
							}
							if(i % 7 == 0 && i != totalTd) {
					%>
								</tr><tr> <!-- td 7개 만들고 테이블 줄바꿈 -->
					<%
							}
						}
					
					%>
			
				</table>
			</div>
			
			
			<div>
				<%
					for(HashMap<String, Object> m : list) {
				%>
						<%=(Integer) (m.get("cashNo")) %>
				<%
					}
				%>
			
			</div>
			
			
			
			
			
		</div>
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%

	// Controller
	
	// 로그인 검증
	if(session.getAttribute("loginMember") == null) {
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		return;
		
	}

	// 메세지 출력을 위한 변수
	String msg = request.getParameter("msg");


	// 분리된 Model 호출
	Help help = new Help();
	help.setMemberId(((Member) session.getAttribute("loginMember")).getMemberId());
	
	HelpDao helpDao = new HelpDao();
	
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(help);
	
	



%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>helpList.jsp</title>
		
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
			
			
			<!-- 메뉴 -->
			<div>
				<jsp:include page = "/inc/menu.jsp"></jsp:include>
			</div>
		
		
			<div>
				<h1>문의사항</h1>
			</div>
			
			<div>&nbsp;</div>
			
			<div>
				<a href = "<%=request.getContextPath() %>/help/insertHelpForm.jsp">문의하기</a>
			</div>
			
			<div>&nbsp;</div>
			
			<div>
				<table border = "1">
					<tr>
						<th>문의내용</th>
						<th>문의날짜</th>
						<th>답변내용</th>
						<th>답변날짜</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
					
					<%
						for(HashMap<String, Object> hm : list) {
					%>
							<tr>
								<td><%=(String) hm.get("helpMemo") %></td>
								<td><%=(String) hm.get("helpCreatedate") %></td>
								<td>
									<%
										if(hm.get("commentMemo") == null) {
									%>
											<span>답변 전</span>
									<%
										} else {
									%>
											<%=hm.get("commentMemo") %>
									<%
										}
									%>
								</td>
								<td>
									<%
										if(hm.get("commentCreatedate") == null) {
									%>
											<span>답변 전</span>
									<%
										} else {
									%>
											<%=hm.get("commentCreatedate") %>
									<%
										}
									%>
								</td>
								
								<%
									if(hm.get("commentMemo") == null) {
								%>
										<!-- 답변이 없을 경우 -->
										<td>
											<a href = "<%=request.getContextPath() %>/help/updateHelpForm.jsp?helpNo=<%=(Integer) hm.get("helpNo")%>">수정</a>
										</td>
										<td>
											<a href = "<%=request.getContextPath() %>/help/deleteHelpAction.jsp?helpNo=<%=(Integer) hm.get("helpNo")%>">삭제</a>
										</td>
								<%
									} else {
								%>
										<!-- 답변이 있을 경우 -->
										<td>수정불가</td>
										<td>삭제불가</td>
								<%
									}
								%>
								
								
							</tr>
					<%
						}
					%>
					
					
				</table>
			</div>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		</div>
	</body>
</html>
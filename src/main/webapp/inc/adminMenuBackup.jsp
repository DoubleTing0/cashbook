<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
	
	<body>
		<div>
			<ul>
				<li>
					<a href = "<%=request.getContextPath() %>/admin/notice/noticeList.jsp">공지관리</a>
				</li>
				<li>
					<a href = "<%=request.getContextPath() %>/admin/category/categoryList.jsp">카테고리관리</a>
				</li>
				<li>
					<a href = "<%=request.getContextPath() %>/admin/member/memberList.jsp">멤버관리</a>
				</li>
				<li>
					<a href = "<%=request.getContextPath() %>/admin/help/helpListAll.jsp">문의사항관리</a>
				</li>
			
				<li>
					<a href = "<%=request.getContextPath() %>/login/logoutAction.jsp">
						<span>로그아웃</span>
					</a>
				</li>
			</ul>
		
		</div>
		
		
		
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>
<%@ page import = "vo.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%


	// Controller
	
	// 메세지 출력을 위한 변수 초기화
	String msg = null;
	
	// 로그인 세션 및 관리자 검증
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
		
		return;
	}

	// request
	String noticeNo = request.getParameter("noticeNo");
	
	
	// null, 공백 검증
	if(noticeNo == null || noticeNo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/notice/noticeList.jsp?msg=" + msg);
		
	}
	
	
	// Model 호출
	
	Notice notice = new Notice();
	notice.setNoticeNo(Integer.parseInt(noticeNo));
	
	NoticeDao noticeDao = new NoticeDao();
	Notice resultNotice = noticeDao.selectNoticeOne(notice);
	
	
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateNoticeForm.jsp</title>
	</head>
	
	<body>
		<div>
			<div>
				<h1>공지 수정</h1>
			</div>
			
			<div>
				<form action = "<%=request.getContextPath() %>/admin/notice/updateNoticeAction.jsp" method = "post">
				
					<div>
						<input type = "hidden" name = noticeNo value = "<%=resultNotice.getNoticeNo() %>">
					</div>
					
					<div>
						<table>
							<tr>
								<th>공지 내용</th>
								<td>
									<textarea cols = "50" rows = "10" name = "noticeMemo"><%=resultNotice.getNoticeMemo() %></textarea>
								</td>
							</tr>
						</table>
					</div>

					<div>
						<button type = "submit">수정</button>
					</div>									
				
				</form>
			</div>
		
		</div>
		
	</body>
</html>
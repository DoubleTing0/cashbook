<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 인코딩 : UTF-8
	request.setCharacterEncoding("UTF-8");
%>

<%
	

	// Controller
	
	// 메세지 출력 변수
	String msg = null;
	
	
	// 로그인 검증
	Member loginMember = (Member) session.getAttribute("loginMember");
	
	if(loginMember == null || loginMember.getMemberLevel() < 1 ) {
		response.sendRedirect(request.getContextPath() + "/login/loginForm.jsp");
	}

	// request
	String commentNo = request.getParameter("commentNo");
	
	// null, 공백 검증
	if(commentNo == null || commentNo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/help/helpListAll.jsp?msg=" + msg);
		return;
		
	}

	
	// 분리된 Model 호출
	
	Comment comment = new Comment();
	comment.setCommentNo(Integer.parseInt(commentNo));
	
	CommentDao commentDao = new CommentDao();
	Comment resultComment = commentDao.selectCommentOne(comment);


%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCommentForm.jsp</title>
	</head>
	
	<body>
		<div>
			<div>
				<h1>답변 수정</h1>
			</div>
			
			<div>&nbsp;</div>
			
			<div>
				<form action = "<%=request.getContextPath() %>/admin/help/updateCommentAction.jsp" method = "post">
					<div>
						<input type = "hidden" name = "commentNo" value = "<%=commentNo %>">
					</div>
				
					<div>
						<table>
							<tr>
								<th>답변내용</th>
								<td>
									<textarea cols = "50" rows = "10" name = "commentMemo"><%=resultComment.getCommentMemo() %></textarea>
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
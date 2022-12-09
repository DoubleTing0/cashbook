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
		return;
	}

	// request
	String helpNo = request.getParameter("helpNo");
	String commentMemo = request.getParameter("commentMemo");
	
	// null, 공백 검증
	if(helpNo == null || commentMemo == null || helpNo.equals("") || commentMemo.equals("")) {
		
		msg = URLEncoder.encode("다시 선택하세요.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/help/helpListAll.jsp?msg=" + msg);
		return;
		
	}
	
	
	// 분리된 Model 호출
	Comment comment = new Comment();
	comment.setHelpNo(Integer.parseInt(helpNo));
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(((Member) session.getAttribute("loginMember")).getMemberId());
	
	CommentDao commentDao = new CommentDao();
	
	int resultRow = commentDao.insertComment(comment);
	
	if(resultRow == 1) {
		
		msg = URLEncoder.encode("답변이 입력되었습니다.", "UTF-8");
		response.sendRedirect(request.getContextPath() + "/admin/help/helpListAll.jsp?msg=" + msg);
		return;
		
	}
	


%>
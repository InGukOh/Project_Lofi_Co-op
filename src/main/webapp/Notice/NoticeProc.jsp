<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="nMgr" class="pack_notice.NoticeMgr" scope="page"/>
<%
nMgr.insertNotice(request);
response.sendRedirect("NoticeList.jsp");
%>

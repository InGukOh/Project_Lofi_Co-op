<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="qMgr" class="pack_QnA.QnAMgr" scope="page"/>
<%
String subject = request.getParameter("subject");
qMgr.insertQnA(request, subject);
response.sendRedirect("QnAList.jsp");
%> 

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="pack_QnA.*"
    %>
    <%
    request.setCharacterEncoding("utf-8");
    
    int num = Integer.parseInt(request.getParameter("num"));
    String nowPage = request.getParameter("nowPage");
    
    String keyField = request.getParameter("keyField");
    String keyWord = request.getParameter("keyWord");
    
    QnABean bean = (QnABean)session.getAttribute("bean");
    String subject = bean.getSubject();
    String uName = bean.getuName(); 
    String content = bean.getContent();
    String fileName = bean.getFileName();
    String email = bean.getuEmail();
    int depth = bean.getDepth();
    
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QnA</title>
    <link rel="stylesheet" href="../style/style_UpdateQnA.css">
</head>
<body>
<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">
        <div id="mod">
        
        <h3>QnA</h3>
<br><br>
<form action="QnAUpdateProc.jsp" method="get" id="UpdateFrm" enctype="multipart/form-data" name="UpdateFrm">

<table id="center">
	<tbody>
		<tr>
			<td>
			<input type="text" name="subject" value="<%=subject %>"  size = "80" id="subject">
			</td>
		</tr>
		<tr>
			<td>
			<input type="text" name="uName" value="<%=uName %>" size = "80" id="uName">
			</td>
		</tr>
			<%if(depth>0){ %>
			<%}else{ %>
		<tr>
			<td>
			<% if(email == null) { %>
			<input type="text" name="email" placeholder="이메일" size = "80" id="email">
			<%}else { %>
			<input type="text" name="email" value="<%=email %>" size = "80" id="email">
			<%} %>
			<%} %>
			</td>
		</tr>
		<tr>
			<td>
			<textarea rows="30" cols="79" name="content" size="80" di="content">
			<%=content %>
			</textarea>
			</td>
		</tr>
		<tr>
			<td>
			<%if(fileName == null) {
			 } else{ %>
			<input type="text" value="<%=fileName%>" disabled>
			 <%} %>
			</td>
		</tr>
		<tr>
			<td>
			<input type="password" name="pass" placeholder="비밀번호" size = "80"  id="pass" value="">
			</td>
		</tr>
		<tr>
			<td>
			<button type="button" id="cancel" class="modBtn" onclick="history.back()">취소</button>
			<button type="button" id="regBtnMod" class="modBtn">등록하기</button>
			</td>
		</tr>
	</tbody>
</table>
				<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
				<input type="hidden" name="num" value="<%=num%>" id="num">
				
</form>
        
        </div>

</div>
<%@include file="../Main/Main_Bottom.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_QnA.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="pack_review.ReviewBean"%>
    
    <jsp:useBean id="rMgr" class="pack_review.ReviewMgr" scope="page"/>
    
    <%
    request.setCharacterEncoding("utf-8");
    
    int numParam = Integer.parseInt(request.getParameter("num"));
    
    String keyField = request.getParameter("keyField");
    String keyWord = request.getParameter("keyWord"); 
    
    ReviewBean bean = rMgr.getReview(numParam);
    
    String nowPage = request.getParameter("nowPage");
    
    int num = bean.getNum();
    
    String uName = bean.getuName();
    String subject = bean.getSubject();
    String content = bean.getContent();
    String email = bean.getuEmail();
    
    int pos = bean.getPos();
    int ref = bean.getRef();
    int depth = bean.getDepth();
    String regData = bean.getRegDate();
    String pass = bean.getPass();
    String fileName = bean.getFileName();
    double fileSize = bean.getFileSize();
    String fUnit = "Bytes";
    if(fileSize>1024){
    	fileSize /= 1024;
    	fUnit = "KBytes";
    }
    
    String ip = bean.getIp();
    
    session.setAttribute("bean", bean);
    %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REVIEW</title>
    <link rel="stylesheet" href="../style/style_Read.css">
</head>
<body>
<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">
<main id="main_Review">
<table id = "read">
	<tbody>
		<tr>
			<td class="rContent"><span>제목</span><span><%=subject %></span></td>
		</tr>
		<tr>
			<td class="rContent"><span>작성자</span><span><%=uName %></span></td>
		</tr>
		<tr>
			<td id="readContents" >
			
			<div id="readContent">
			
			<img src="../Resource/ReviewImg/1234/<%=fileName%>" width="auto" height="auto" alt="">
			<textarea name="txtArea" id="txtArea" cols="30" rows="10" readonly><%=content %></textarea>
			
			</div>
			
			</td>
		</tr>
	</tbody>
</table>

	<button type="button" id="listBtn" class="reviewBtn">리스트</button>
	<button type="button" id="modBtn"  class="reviewBtn">수정</button>
	<button type="button" id="delBtn"  class="reviewBtn">삭제</button>

			<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
			<input type="hidden" name="num" value="<%=num%>" id="num">
			<input type="hidden" id="pKeyField" value="<%=keyField%>">
			<input type="hidden" id="pKeyWord" value="<%=keyWord%>">
			<input type="hidden" name="email" value="<%=email%>" id="email">


</main>

</div>
<%@include file="../Main/Main_Bottom.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Review.js"></script>
</body>
</html>
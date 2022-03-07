<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QnA</title>
    <link rel="stylesheet" href="../style/style_postQnA.css">
</head>
<body>
<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">

<div id="QnA">
<h3>QnA</h3>
<br><br>
<form action="QnAProc.jsp" method="Post" id="postFrm" enctype="multipart/form-data" name="postFrm">

<table id="center">
	<tbody>
		<tr>
			<td>
			<input type="text" name="subject" placeholder="제목"  size = "80" id="subject">
			</td>
		</tr>
		<tr>
			<td>
			<%if(uID == null) {%>
			<input type="text" name="uName" placeholder="작성자"  size = "80" id="uName">
			<%} else { %>
			<input type="text" name="uName" value="<%=uID %>"  size = "80" id="uName">
			<%} %>
			</td>
		</tr>
		<tr>
			<td>
			<input type="email" name="email" placeholder="이메일" size = "80" id="email">
			</td>
		</tr>
		<tr>
			<td>
			<textarea rows="30" cols="79" name="content" size="80" id="content"></textarea>
			</td>
		</tr>
		<tr>
			<td>
			<input type="file" name="file"size = "71" id="file"
			 onchange="fileNameValue(this.value)" accept="image/*">
			<input type="text" name="fileName" id="fileName" value="파일 선택" disabled="disabled" size="58">
			 <label for="file" id="upload">첨부하기</label>
			</td>
		</tr>
		<tr>
			<td>
			<input type="password" name="pass" placeholder="비밀번호" size = "80"  id="pass">
			</td>
		</tr>
		<tr>
			<td>
			<button type="button" id="cancel" class="pBtn" onclick="history.back()">취소</button>
			<button type="button" id="regBtn" class="pBtn">등록하기</button>
			</td>
		</tr>
	</tbody>
</table>
				<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
</form>

</div>

</div>
<%@include file="../Main/Main_Bottom.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_QnA.js"></script>
</body>
</html>
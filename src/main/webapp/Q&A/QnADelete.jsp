<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="pack_QnA.*"
    %>
    <jsp:useBean id = "qMgr" class = "pack_QnA.QnAMgr" scope="page"/>
    <%
    request.setCharacterEncoding("utf-8");
    
    String nowPage = request.getParameter("nowPage");
    String num = request.getParameter("num");
    
    int numParam = Integer.parseInt(num);
    
    if(request.getParameter("passParam") != null){
    	String passParam = request.getParameter("passParam");
    	
    	QnABean bean = (QnABean)session.getAttribute("bean");
    	String pass = bean.getPass();
    	
    	if(passParam.equals(pass)){
    		int exeCnt = qMgr.deleteQnA(numParam);
    		
    		%>
    		
    		<script>
    		alert("삭제 완료");
    		location.href = "QnAList.jsp"; 
    		</script>
    	<%} else{%>
    	<script>
    	alert("비밀번호 확인 필요");
    	history.back();
    	</script>
    	<%}
    	} else{
    	%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QnA</title>
    <link rel="stylesheet" href="../style/style_DeleteQnA.css">
</head>
<body>
<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">

              
        <div id="delete">
        
        <h4>QnA</h4>
			<br><br>
		<form id="delFrm" name="delFrm">
		
		<table>
			<tbody>
				<tr>
					<td>
					<input type="password" name="passParam" id="pass" placeholder="비밀번호를 입력하세요">
					</td>
				</tr>
			</tbody>
		</table>
		<button type="button" id="delSbmBtn" class="delBtn">삭제하기</button>
		<button type="button" onclick="history.back()" class="delBtn">돌아가기</button>
		
			<input type="hidden" name="num" value="<%=numParam%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
		</form>	

        </div>
        
</div>
<%@include file="../Main/Main_Bottom.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Review.js"></script>
</body>
</html>

<%}%>
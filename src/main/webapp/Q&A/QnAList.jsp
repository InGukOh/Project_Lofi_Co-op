<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="pack_QnA.QnABean"
    import="java.util.Vector"
    %>

<jsp:useBean id="qMgr" class="pack_QnA.QnAMgr" scope="page"/>
    
    <%
    request.setCharacterEncoding("utf-8");
    
    
    int totalRecord = 0; // 전체 레코드
    int numPerPage = 5; // 페이지 당 레코드
    int pagePerBlock = 5; // 블럭 당 페이지
    
    int totalPage = 0;
    int totalBlock = 0;
    
    
    int nowPage = 1; // 현재 페이지
    int nowBlock = 1;// 현재 블럭
    
    int start = 0; // DB의 select 시작 번호
    int end = 5; // 시작번호로부터 가져올 select 수

    int listSize = 0; // 현재 읽어온 게시물 수
    
    String keyField = "";
    String keyWord = "";
    
    if (request.getParameter("keyWord") != null) {
    	keyField = request.getParameter("keyField");
    	keyWord = request.getParameter("keyWord");
    }
    
    
    if (request.getParameter("nowPage") != null) {
    	nowPage = Integer.parseInt(request.getParameter("nowPage"));
    	start = (nowPage * numPerPage) - numPerPage;
    	end = numPerPage;
    }
    
    totalRecord = qMgr.getTotalCount(keyField, keyWord);
    
    totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
    nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
    totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
    
    Vector<QnABean> vList = null;
  
    
    %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QnA</title>
    <link rel="stylesheet" href="../style/style_ListQnA.css">
</head>
<body>
<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">

       
<main id="main_QnA">
<div id="top"><h4>QnA</h4></div>


<table id="QnAList">

	<tbody>
<%
vList = qMgr.getQnAList(keyField, keyWord, start, end);
listSize = vList.size();


	if(vList.isEmpty()){
	%>
	<tr>
	<td colspan="3">
	<%= "작성글이 없습니다." %>
	</td>
	</tr>
	<%} else {
	%> 
	
	<%
	for(int i = 0; i<numPerPage; i++){
		
		if(i==listSize) break;
		
		QnABean bean = vList.get(i);
		
		int num = bean.getNum();
		String subject = bean.getSubject();
		String uName = bean.getuName();
		String filename = bean.getFileName();
		String content = bean.getContent();
		int depth = bean.getDepth();
	
		%>
  	<tr id="listNum" class="prnTr"  onclick="QnARead('<%=num%>', '<%=nowPage%>')">
			<td class="List">
					<% if (depth == 0) out.print(num);  %>
					여기1여기1여기1여기1여기1여기1여기1여기1여기1
			</td> 
			<td class="List">
			<%
				if (depth > 0) {
					for(int blank=0; blank<depth; blank++) {
						out.print("Re: ");
					}
				} 
				out.print(subject);
			%>
			</td>
			<td class="List"><%= uName %></td>
		</tr>
		
		<%
		}
	}
%>
		<tr>
			<td colspan="3"><button type="button" id="writeBtn" onclick="location.href='QnAWrite.jsp'">작성하기</button></td>
		</tr>
		<tr>
		<td colspan="3" id="pagingTd">
		<%
		int pageStart = (nowBlock-1)*pagePerBlock+1;
		
		int pageEnd = (nowBlock<totalBlock) ?
				pageStart + pagePerBlock-1 : totalPage;
		
		if(totalPage != 0) {%>
		
		<%
		if(nowBlock>1){
		%>
		<span onclick="moveBlock('<%=nowBlock-1%>', '<%=pagePerBlock%>')">
		&lt;
		</span>
		<%} else{ %>
		<span></span>
		<% } %>
		
		<%
		for( ; pageStart<=pageEnd; pageStart++) {		%>
		<%
		if(pageStart == nowPage){%>
		<span class="mBtn" id="nowView" onclick="movePage('<%=pageStart%>')">
		<%=pageStart %>
		</span>
		<%} else{%>
		<span class="mBtn" onclick="movePage('<%=pageStart%>')">
		<%=pageStart %>
		</span>
		<%} %>
		<%} %>
		
		<%if(totalBlock>nowBlock) { %>
		<span onclick="moveBlock('<%=nowBlock+1%>', '<%=pagePerBlock%>')">
		&gt;
		</span>
		<%} else{ %>
		<span></span>
		<%} %>
		
		<%} %>
		
		</td>
		</tr>
	</tbody>
</table>

<div id="searchArea" class="flex-container">

<form name = "searchFrm" id="searchFrm">

	<select name="keyDate" id="keyDate">
		<option value="week">일주일</option>
		<option value="month">한달</option>
		<option value="threeMonth">세달</option>
		<option value="all">전체</option>
	</select>
	
	<select name="keyField" id="keyField">
		<option value="subject" <% if(keyField.equals("subject")) out.print("selected"); %>>제목</option>
		<option value="content" <% if(keyField.equals("content")) out.print("selected"); %>>내용</option>
		<option value="uName" <% if(keyField.equals("uName")) out.print("selected"); %>>작성자</option>
	</select>
	
	<input type="text" name="keyWord" id="keyWord" value="<%= keyWord%>">
	<button type="button" id="searchBtn">검색</button>
	</form>
	
	<input type="hidden" id="pKeyField" value="<%= keyField%>">
	<input type="hidden" id="pKeyWord" value="<%= keyWord%>">
</div>

</main>
</div>

 <%@include file="../Main/Main_Bottom.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_QnA.js"></script>
</body>
</html>
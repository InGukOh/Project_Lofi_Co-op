<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="pack_notice.NoticeBean"
    import="java.util.Vector"
    %>
    
    <jsp:useBean id="nMgr" class="pack_notice.NoticeMgr" scope="page"/>
    
    <%
    request.setCharacterEncoding("utf-8");
    
    
    int totalRecord = 0; // 전체 레코드
    int numPerPage = 5; // 페이지 당 레코드
    int pagePerBlock = 5; // 블럭 당 페이지
    
    int totalPage = 0;
    int totalBlock = 0;
    
    
    int nowPage = 1;
    int nowBlock = 1;
    
    int start = 0;
    int end = 5; 

    int listSize = 0;
    
    if (request.getParameter("nowPage") != null) {
    	nowPage = Integer.parseInt(request.getParameter("nowPage"));
    	start = (nowPage * numPerPage) - numPerPage;
    	end = numPerPage;
    }
    
    totalRecord = nMgr.getTotalCount();
    
    totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
    nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
    totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
    
    Vector<NoticeBean> vList = null;

    %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NoticeList</title>
    <link rel="stylesheet" href="../style/style_List.css">
</head>
<body>
<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">



<div id="top"><h4>NOTICE</h4></div>

<main id="main_Notice">
<%
vList = nMgr.getNoticeList(start, end);
listSize = vList.size();
%>

<table id="rList">
	<tbody>
	<%
	if(vList.isEmpty()){
	%>
	<tr>
	<td colspan="3">
	<%= "공지가 없습니다." %>
	</td>
	</tr>
	<%}
	else{
	%> 
	
	<%
	for(int i = 0; i<listSize; i++){
		
		if(i==listSize) break;
		
		NoticeBean bean = vList.get(i);
		
		int num = bean.getNum();
		String subject = bean.getSubject();
		String uName = bean.getuName();
		String regDate = bean.getRegDate();
		String content = bean.getContent();
	
	%>
		<tr class="prnTr" >
			<td class="List" id="listNum" onclick="NoticeRead('<%=num%>', '<%=nowPage%>')"><%= num %></td>
			<td class="List" id="listSub"><%= subject %></td>
			<td class="List" id="listName"><%= uName %></td>
		</tr>
		
		<%
		}
	}
		%>
		<%if(uID !=null && authority.equals("admin")){ %>
		<tr>
			<td colspan="3"><button type="button" id="writeBtn" onclick="location.href='NoticeWrite.jsp'">공지 입력</button></td>
		</tr>
		<%} %>


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
		<span class="mBtn" id="nowView" onclick="movePage('<%=pageStart%>)">
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
</main>
</div>

<%@include file="../Main/Main_Bottom.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Notice.js"></script>
</body>
</html>
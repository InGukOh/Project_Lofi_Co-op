<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.NumberFormat"%>
 
<%@ page import="pack_goods.Goods, java.util.Vector" %>
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />

<% request.setCharacterEncoding("UTF-8");%>
 
<%
Vector<Goods> GoodsList = null;
 
String SAVEFOLDER
="C:/Users/TridentK/git/Project_Lofi_Co-op/src/main/webapp/Resource/GoodsImg/"; // 경로명 반드시 변경

Encoder encoder = Base64.getEncoder();
Decoder decoder = Base64.getDecoder();

NumberFormat money = NumberFormat.getNumberInstance();

int listSize = 0;

int totalRecord = 0; // 전체 레코드
int numPerPage = 9; // 페이지 당 레코드
int pagePerBlock = 9; // 블럭 당 페이지

int totalPage = 0;
int totalBlock = 0;


int nowPage = 1; // 현재 페이지
int nowBlock = 1;// 현재 블럭

int start = 0; // DB의 select 시작 번호
int end = 9; // 시작번호로부터 가져올 select 수

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

totalRecord = goods.GoodsCount(keyField, keyWord);

totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
%> 

<!DOCTYPE html>
<html lang="ko"> 
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GoodsList</title>
</head>
<link rel="stylesheet" href="../style/style_goods.css">
<body>

<%@include file="../Main/Main_Top.jsp" %>

<div id="wrap" >
	<div id="searchArea" class="flex-container">

		<form name = "searchFrm" id="searchFrm">
				
			<select name="keyField" id="keyField">
				<option value="all">전체</option>
				<option value="정장" <% if(keyField.equals("goodsType")) out.print("selected"); %>>정장</option>
				<option value="패딩" <% if(keyField.equals("goodsType")) out.print("selected"); %>>패딩</option>
				<option value="기타" <% if(keyField.equals("goodsType")) out.print("selected"); %>>기타</option>
			</select>
			
			<input type="text" name="keyWord" id="keyWord" value="<%= keyWord%>">
			<button type="button" id="searchBtn">검색</button>
			
		</form>
		
	</div> 
	
	<div id="goodsList">
		<%
		GoodsList = goods.getBoardList(keyField, keyWord, start, end);
		listSize = GoodsList.size();			
		if (GoodsList.isEmpty()) { // 등록상품이 없을 경우 출력 
		%> 
		
		<h1>등록상품이 없습니다</h1>
					
		<%	
		} else { // 등록상품이 있을 경우 출력 시작
			for (int i=0; i < listSize; i++) {						
				Goods list = GoodsList.get(i);
				int goodsNum = list.getGoodsNum();
				String goodsName = list.getGoodsName();
				int NL = goodsName.length();	 //NameLength = 서버내 상품이름길이
				int TL = NL - 11;                   //true length 서버내 상품이름에서 날짜 빼기
				String showName = goodsName.substring(0,TL); //표기할 상품명 생성
				String dates = goodsName.substring(TL,NL); // 상품 등록 날짜
				byte[] getName = showName.getBytes();//바이트로 변환
				String tloc = encoder.encodeToString(getName);//인코딩
				tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
				String goodsType = list.getGoodsType();
				int goodsPrice = list.getGoodsPrice();
				int goodsSPrice = list.getGoodsSPrice();
				String regDate = list.getRegDate();
				int RL = regDate.length();
				int SL = RL - 9;
				String showRegDate = regDate.substring(0,SL);
				int count = list.getwCount();
				String way = SAVEFOLDER + tloc +"/thumb/"; // 이미지 저장경로 + 서버상품이름 + 썸네일폴더
				String thumbnail =null;
				File TF = new File(way+"thumb_"+list.getGoodsThumbnail());
		%>
		
		<div id="Show">
			<div id="imgSrc">
		<%	try { 
					if(TF.isFile()) { thumbnail = TF.getName(); 
		%>
				<a href="GoodsView.jsp?goodsName=<%=goodsName%>">
					<img id="ListThumb" src="../Resource/GoodsImg/<%=tloc %>/thumb/<%=thumbnail %>"/>
				</a>
		<% 	}else{ %>
				<img src="../Resource/GoodsImg/GoodsReady/goods_ready.jpg" id="no_goods" alt="상품 준비중" ><br>
		<% 	} %>
		 	</div>
			<table id="ListTable">
				<tbody>
					<tr>
						<td>이름</td>
						<td><%=showName%></td>
					</tr>
					<% if(list.getGoodsSPrice() != 0){ %>
					<tr>
						<td style="text-decoration: line-through;">가격</td>
						<td style="text-decoration: line-through;"><%=money.format(goodsPrice)%></td>
					</tr>
					<tr>
						<td style="text-decoration:underline;">세일 가격</td>
						<td style="font-size: 16px;"><%=money.format(goodsSPrice)%></td>
					</tr>
					<% } else { %>
					<tr>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>가격</td>
						<td><%=money.format(goodsPrice)%></td>
					</tr>
					<% } %>
				</tbody>
			</table>
			<hr />
			<div id="ListInfo">
				<span>종류&nbsp:&nbsp<%=goodsType%>&nbsp/&nbsp</span>
				<span>등록일&nbsp:&nbsp<%=showRegDate%>&nbsp/&nbsp</span>
				<span>조회수&nbsp:&nbsp<%=count %></span>
			</div>
		</div>		
	
		<%
					} catch (Exception e) {
						out.println(e);
					}
				}
			}
		%>
	</div>
	
	<div id="GoodsListPage">

		<%
		int pageStart = (nowBlock-1)*pagePerBlock+1;
		int pageEnd = (nowBlock<totalBlock) ?
		pageStart + pagePerBlock-1 : totalPage;
		if(totalPage != 0) {
			if(nowBlock>1) { 
		%>
		<span onclick="moveBlock('<%=nowBlock-1%>', '<%=pagePerBlock%>')"> << </span>
		<% } 
		for( ; pageStart<=pageEnd; pageStart++) {	
			if(pageStart == nowPage){%>
			<span class="mBtn" id="nowView" onclick="movePage('<%=pageStart%>')"> <%=pageStart %> </span>
		<%} else {%>
			<span class="mBtn" onclick="movePage('<%=pageStart%>')"> <%=pageStart %> </span>
		<%
			} 
		} 
		%>
		
		<% if(totalBlock>nowBlock) { %>
		<span onclick="moveBlock('<%=nowBlock+1%>', '<%=pagePerBlock%>')"> >> </span>
		<% 
			}
		}
		%>
	</div>
	
	<input type="hidden" id="pKeyField" value="<%= keyField%>">
	<input type="hidden" id="pKeyWord" value="<%= keyWord%>">
	
</div>
	
<%@include file="../Main/Main_Bottom.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_GoodsList.js"></script>
<script type="text/javascript">

</script>
</body>
</html>
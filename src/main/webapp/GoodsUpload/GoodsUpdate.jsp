<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<%@page import="java.io.File"%> 
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>
  
<%@ page import="pack_goods.Goods" %>
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
    
<%request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.io.PrintWriter"%>
 
<%
	String uID = null;
	if(session.getAttribute("uID") != null){ 
		uID = (String)session.getAttribute("uID"); 
	} 
	String authority = null;
	if(session.getAttribute("authority") == "admin"){ 
		authority = (String)session.getAttribute("authority");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다!!!')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
	}
	String goodsNameParam = null;
	 
	if((String)request.getParameter("goodsName") != null){
		goodsNameParam = (String)request.getParameter("goodsName");
	}


	Encoder encoder = Base64.getEncoder();
	Decoder decoder = Base64.getDecoder();

	Goods view =goods.getGoodsView(goodsNameParam);

	String goodsName = view.getGoodsName(); // 상품 이름
	int NL = goodsName.length(); // Name Length = 서버내 상품이름길이
	int TL = NL - 11;                   // True length = 서버내 상품이름에서 날짜 빼기
	String showName = goodsName.substring(0,TL); // 표기할 상품명 생성
	String dates = goodsName.substring(TL,NL); // 상품 등록 날짜
	byte[] getName = showName.getBytes(); //바이트로 변환
	String tloc = encoder.encodeToString(getName); //인코딩
	tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환


	String goodsImages =view.getGoodsImages(); // 상품 이미지 이름
	String[] imgArray = goodsImages.split(" / ");
	int imgL = imgArray.length;

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GoodsUpdate</title>
<link rel="stylesheet" href="../style/style_GoodsUpdate&Upload.css">
</head>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="wrap">

           <header id="header" class="flex-container">
            
            <div id="logo">
                <a href="index.html"><img src="/logoB.jpg" alt=""></a>

            </div>
            <nav id="nav1" class="flex-container">
                <ul id="goods"><a href="#">shop</a>
                    <li class="goods1"><a href="#">품목1</a></li>
                    <li class="goods1"><a href="#">품목2</a></li>
                    <li class="goods1"><a href="#">품목3</a></li>
                    <li class="goods1"><a href="#">품목4</a></li>
                    <li class="goods1"><a href="#">품목5</a></li>
                </ul>
                <ul><a href="#">LookBook</a></ul>
                <ul><a href="#">About</a></ul>
                <ul id="board1"><a href="#">Board</a>
                    <li class="board"><a href="../Notice/NoticeList.jsp">Notice</a></li>
                    <li class="board"><a href="../Q&A/QnAList.jsp">Q&A</a></li>
                    <li class="board"><a href="../Review/ReviewList.jsp">Review</a></li>
                </ul>
            </nav>
             
            <nav id="nav2" class="flex-container">
            <% if(uID == null){ /* 로그인 안되있을때 */ %>
                <ul><a href="../Account/Login.jsp">Login</a></ul>
                <ul><a href="../Account/Join.jsp">Account</a></ul>
			<%  }
            
            else if(uID !=null && authority.equals("user")){ %> <!-- 로그인이 되있을때 -->
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
                <ul><a href="../GoodsUpload/MyBasket.jsp">Cart</a></ul>
                <ul><a href="../Account/Mypage.jsp">MyPage</a></ul>
			<% } 
            else if(uID !=null && authority.equals("admin")){
			%>
			<p>안녕하세요<br><%=uID %>님! 관리자 권한입니다!</p>
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
				<ul><a href="../GoodsUpload/GoodsUpload.jsp">GoodsUpload</a></ul>
			<% } %>
                <ul id="search1"><a href="#">Search</a>
                    <li class="search2"><input type="text" placeholder="검색어를 입력해주세요"><a href="#" id="searcha">검색</a></li>
                </ul>
                
            </nav>
            

        </header>

	<hr id="crossLine" />
	<form action="GoodsUpdateProc.jsp?oldGoodsInfo=
							<%=view.getGoodsName() %>//
							<%=view.getGoodsThumbnail() %>//
							<%=view.getGoodsImages() %>//"
	 			method="post" id="send" enctype="multipart/form-data">
		
		<div id="InputInfo"><!-- <div id="InputInfo"> -->
		
			<div id="Gcontents">
				<h2>상품 내용</h2>
				<div id="write" contenteditable="true" spellcheck="true" >
					<%=view.getGoodsContent() %>
				</div>
				<div id="hider">
					<textarea name="goodsContent" id="goodsContent" placeholder="테스트"></textarea> 
				</div>
			</div>
 
			<div id="must"><!-- <div id="must"> -->
				<div id="goodsTextInfo"><!-- goodsTextInfo -->
					<div id="NIT">
						<span id="InfoSpan">상품명 : <input type="text" name="goodsName" id="goodsName" value="<%=showName%>"/></span>
						<span id="InfoSpan">상품 입고일 : <input type="text" name="goodsWarehousing" id="goodsWarehousing" placeholder="yy.mm.dd" value="<%= view.getGoodsWarehousing()%>"/></span>
						<span id="InfoSpan">현재 상품 종류 : <span id="GTP"><%=view.getGoodsType() %></span></span> 
						<span id="InfoSpan">
							상품 종류 : 
							<select name="goodsType" id="goodsType">
								<option value='1' selected>-- 선택 --</option>
								<option value='정장'>정장</option>
					 			<option value='패딩'>패딩</option>
					  			<option value='기타'>기타</option>
							</select>
						</span>
					</div>
				
					<div id="priceArea">
						<p id="Price" >상품 판매 가격 : <input type="number" name="goodsPrice" id="goodsPrice" 
					    									value="<%=view.getGoodsPrice()%>" maxlength="7" min="1000" max="9999999"/></p>
						<p id="SPrice">상품 세일 가격 : <input type="number" name="goodsSPrice" id="goodsSPrice"  
					  										value="<%=view.getGoodsSPrice()%>" maxlength="7" min="1000" max="9999999"/>
												  <span id="SPriceNotice">미입력시 세일가격은 0원입니다.</span>
						</p>
					</div>
				</div> <!-- goodsTextInfo -->
			
				<div id="inventoryList"> <!-- inventoryList -->
					<table id="inventory">
						<tbody>
							<tr>
								<td>S 사이즈 재고 : <input type="number" name="inventoryS" id="inventoryS" max="999" value="<%=view.getInventoryS()%>"/></td>
								<td>M 사이즈 재고 : <input type="number" name="inventoryM" id="inventoryM" max="999" value="<%=view.getInventoryM()%>"/></td>
								<td>L 사이즈 재고 : <input type="number" name="inventoryL" id="inventoryL" max="999" value="<%=view.getInventoryL()%>" /></td>
								<td>XL 사이즈 재고 : <input type="number" name="inventoryXL" id="inventoryXL" max="999" value="<%=view.getInventoryXL()%>" /></td>
							</tr>
						</tbody>
					</table>
				</div> <!-- inventoryList -->
			</div><!-- <div id="must"> -->
			
		</div><!-- <div id="InputInfo"> -->
		
		<hr id="crossLine" />
		
		<div id="nowImgs"><!-- <div id="nowImgs"> -->
		
			<div id="oldThumb">
				<h2>현재 썸네일</h2>
				<div id="showOT">
					<img id="gthumb" src="../Resource/GoodsImg/<%=tloc %>/thumb/thumb_<%=view.getGoodsThumbnail() %>"  />
				</div>
			</div><!-- <div id="nowImgs"> -->
			
			<div id="oldImg"><!-- <div id="oldImg"> -->
				<h2>현재 이미지</h2>
				<div id="showOI">
					<%for(int i = 0 ; i < imgL ; i++){ %>
					<img id="gImg" src="../Resource/GoodsImg/<%=tloc %>/<%=imgArray[i] %> " /><br>
					<%} %>
				</div>
			</div> <!-- <div id="oldImg"> -->
			
		</div><!-- <div id="nowImgs"> -->

		<hr id="crossLine" />

		<div id="resetbtnArea">
			<p id="reset" >전체 이미지 재선택</p>
		</div>

		<div id="GoodsUpload_Imgs"> <!--GoodsUpload_Imgs-->
		
			<div id="GoodsUploadThumb">
				<h2>썸네일</h2>
			
				<div id="Thumb_drop">
					<div id="Preview_Thumb"></div>
					<p id="T_here">drag & drop</p>
				</div>
			
				<span id="or">or</span><br />
				<input type="file" id="goodsThumbnail" name="goodsThumbnail" multiple="multiple" accept='.png, .jpg' required="required"/>
			</div>
		
			<div id="GoodsUploadImg">
				<h2>상품 이미지</h2>
				
				<div id="Img_drop">
					<div id="Preview_Img"></div>
					<p id="I_here">drag & drop</p>
				</div>
			
				<span id="or">or</span><br />
				<input type="file" id="goodsImages" name="goodsImages" multiple="multiple" accept='.png, .jpg' required="required">
			</div>
		
		</div> <!--GoodsUpload_Imgs-->

	</form>
	
	<hr id="crossLine" />

	<div id="btnArea">
		<p id="goback" onclick='history.back();'>뒤로가기
		<p id="btnSubmit">업로드</p>
	</div>
	<hr id="crossLine" />


	    <footer id="footer">


            <div id="info" class="flex-container">
            
            <div id="cs">
                <h4>C.S CENTER</h4>
                <ul>고객센터 -070-4131-0032</ul>
                <ul>OPEN : MON - FIR 10:30AM - 18:00PM</ul> 
                <ul>LUNCH : 12:30PM - 13:30PM</ul>
                <ul>EVERY WEEKEND, HOLIDAY OFF</ul>
                <br>
                <ul>협찬/CS 문의 : peace@lofi.co.kr</ul>
            </div>
            <div id="bank">
                <h4>BANK ACOOUNT</h4>
                <ul>국민은행 022201-04-252808</ul>
                <ul>예금주 : 주식회사 슬랜빌리지</ul>
            </div>
            <div id="links">
                <h4>LINKS</h4>
                <ul><a href="#">회사소개</a></ul>
                <ul><a href="#">이용약관</a></ul>
                <ul><a href="#">개인정보취급방침</a></ul>
                <ul><a href="#">이용안내</a></ul>
            </div>
            <div id="follow">
                <h4>FOLLOW</h4>
                <ul><a href="#">대충 인스타그램 이미지</a></ul>
            </div>
        </div>

            <div id="info2">
                <p>&copy; <b>로파이</b> / site bt the 131DESIGN </p>
                <br>
                <p>주식회사 슬랜빌리지 Ceo : 고혁준 Address : 서울시 광진구 동일로66길 14 2층 슬랜빌리지 (반품 주소 아님) Business License : 485-88-01590 E-Connerce Permit:제 2013-서울중랑-0431 호 Email : 김도윤(team@lofi.co.kr)</p>
            </div>

        </footer>	
	
</div> 
 

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>


<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_HeaderFooter.js"></script>
<script src="../script/script_GoodsUpdate.js"></script>
<script type="text/javascript">
var oldGT = '<%=view.getGoodsType()%>';
if(oldGT == '정장'){
$("#goodsType option:eq(1)").prop("selected",true);
} else if (oldGT == '패딩'){
$("#goodsType option:eq(2)").prop("selected",true);
} else if (oldGT == '기타'){
$("#goodsType option:eq(3)").prop("selected",true);
}
</script>
</body>
</html>
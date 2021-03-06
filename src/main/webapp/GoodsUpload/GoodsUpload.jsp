<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8"); %>
 
<%@page import="java.io.PrintWriter"%>
  
<%
	String uID = null;
	if(session.getAttribute("uID") != null){
		uID = (String)session.getAttribute("uID"); 
	} 
	String authority = null;
	if(session.getAttribute("authority").equals("admin")){ 
		authority = (String)session.getAttribute("authority");		
	} else {
		PrintWriter script = response.getWriter(); 
		script.println("<script>");
		script.println("alert('권한이 없습니다!!!')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
	}

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GoodsUpload</title>
<link rel="stylesheet" href="../style/style_GoodsUpdate&Upload.css">
</head>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="wrap">
	<hr id="crossLine" />
	<form action="GoodsUploadProc.jsp" method="post" id="send" enctype="multipart/form-data">
		
		<div id="InputInfo"><!-- <div id="InputInfo"> -->
		
			<div id="Gcontents">
				<h2>상품 내용</h2>
				<div id="write" contenteditable="true" spellcheck="true" ></div>
				<div id="hider">
					<textarea name="goodsContent" id="goodsContent" placeholder="테스트"></textarea> 
				</div>
			</div>
			
			<div id="must">
				<div id="goodsTextInfo"><!-- goodsTextInfo -->
					<div id="NIT">
						<span id="InfoSpan">상품명 : <input type="text" name="goodsName" id="goodsName" /></span>
						<span id="InfoSpan">상품 입고일 : <input type="text" name="goodsWarehousing" id="goodsWarehousing" placeholder="yy.mm.dd"/></span>
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
							  	   							maxlength="7" min="1000" max="9999999"/></p>
						<p id="SPrice">상품 세일 가격 : <input type="number" name="goodsSPrice" id="goodsSPrice"  
								   							maxlength="7" min="1000" max="9999999"/><span id="SPriceNotice">미입력시 세일가격은 0원입니다.</span>
						</p>
						
					</div>
				</div> <!-- goodsTextInfo -->
			
				<div id="inventoryList"> <!-- inventoryList -->
					<table id="inventory">
						<tbody>
							<tr>
								<td>S 사이즈 재고 : <input type="number" name="inventoryS" id="inventoryS" max="999" value="0"/></td>
								<td>M 사이즈 재고 : <input type="number" name="inventoryM" id="inventoryM" max="999" value="0"/></td>
								<td>L 사이즈 재고 : <input type="number" name="inventoryL" id="inventoryL" max="999" value="0"/></td>
								<td>XL 사이즈 재고 : <input type="number" name="inventoryXL" id="inventoryXL" max="999" value="0"/></td>
							</tr>
						</tbody>
					</table>
				</div> <!-- inventoryList -->
			</div>
		</div><!-- <div id="InputInfo"> -->
		
		<hr id="crossLine" />
		
		<div id="resetbtnArea">
			<p id="reset">전체 이미지 재선택</p>
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
	<p id="btnSubmit">업로드</p>
</div> 

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>
 

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_GoodsUpload.js"></script>

</body>
</html>
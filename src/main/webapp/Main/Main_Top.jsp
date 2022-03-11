<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MainTop</title>
<link rel="stylesheet" href="../style/style_HeaderFooter.css">
</head>
<body>

<% // 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크 
    String uID = null;
    if(session.getAttribute("uID") != null){
    	uID = (String)session.getAttribute("uID"); 
    	} 
    String authority = null;
    if(session.getAttribute("authority") != null){ 
    	authority = (String)session.getAttribute("authority"); 
    	}
    %> 
    <div id="wrap">
    
    <!-- HTML템플릿(Template, Templet) 헤더 시작 -->

        <header id="header" class="flex-container">
        
            
            <div id="logo">
                <a href="../Main/Main.jsp"><img src="../Main/mainlogo.PNG" alt=""></a>

            </div>
            <nav id="nav1" class="flex-container">
                <ul id="goods"><a href="../GoodsUpload/GoodsList.jsp">shop</a>
                    <li class="goods1"><a href="../GoodsUpload/GoodsList.jsp?keyField=패딩&keyWord=">패딩</a></li>
                    <li class="goods1"><a href="../GoodsUpload/GoodsList.jsp?keyField=정장&keyWord=">정장</a></li>
                    <li class="goods1"><a href="../GoodsUpload/GoodsList.jsp?keyField=기타&keyWord=">기타</a></li>
                </ul>
                <ul><a href="../Lookbook/Look.jsp">LookBook</a></ul>
                <ul id="board1"><a href="#">Board</a>
                    <li class="board"><a href="../Notice/NoticeList.jsp">Notice</a></li>
                    <li class="board"><a href="../Q&A/QnAList.jsp">Q&A</a></li>
                    <li class="board"><a href="../Review/ReviewList.jsp">Review</a></li>
                </ul>
            </nav>
             
            <nav id="nav2" class="flex-container">
            <% if(uID == null){ /* 로그인 안되있을때 */ %>
            <div id="nonLog">
                <ul><a href="../Account/Login.jsp">Login</a></ul>
                <ul><a href="../Account/Join.jsp">Account</a></ul>
            </div>
			<%  }
            
            else if(uID !=null && authority.equals("user")){ %> <!-- 로그인이 되있을때 -->
			<div id="user_op">
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
                <ul><a href="../GoodsUpload/MyBasket.jsp">Cart</a></ul>
                <ul><a href="../Account/Mypage.jsp">MyPage</a></ul>
            </div>
			<% } 
            else if(uID !=null && authority.equals("admin")){
			%>
			<div id="admin_op">
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
				<ul><a href="../GoodsUpload/OrderShow.jsp">OrderManagement</a></ul>
				<ul><a href="../GoodsUpload/GoodsUpload.jsp">GoodsUpload</a></ul>
			</div>
			<div id="AL">
				<p id="logIn_notice">안녕하세요 <%=uID %>님! 관리자 권한입니다!</p>
			</div>
			<% } %>
            </nav>
            
        </header>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Review.js"></script>
</body>
</html>

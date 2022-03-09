<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로파이</title>
<link rel="stylesheet" href="../style/style_index.css">
</head>
<body>

<%@include file="../Main/Main_Top.jsp" %>

    <div id="wrap">

        <main id="main">
            <div id="goods">
            	<a href="../GoodsUpload/GoodsList.jsp">
            		<img src="Main_img/go_GoodsEd.jpg" />
            	</a>
            </div>
            <div id="review">
            	<a href="../Review/ReviewList.jsp">
            		<img src="Main_img/go_Review.png" />
            	</a>
            </div>
            <div id="QnA">
            	<a href="../Q&A/QnAList.jsp">
            		<img src="Main_img/go_QnA.png" />
            	</a>
            </div>
        </main>

    </div>
 <%@include file="../Main/Main_Bottom.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/jquery-3.6.0.min.js"></script>
<script src="../script/script_main.js"></script>
</body>
</html>
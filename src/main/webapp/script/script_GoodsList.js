function movePage(p1){
	let p3 = $("#pKeyField").val().trim();
    let p4 = $("#pKeyWord").val().trim();
 
	let param = "GoodsList.jsp?nowPage="+p1+"&keyField="+p3+"&keyWord="+p4;
	location.href = param;
}

function moveBlock(p1, p2) {    // 블럭 이동 
 
	let pageNum = parseInt(p1);
	let pagePerBlock = parseInt(p2);	
	
	let param = "GoodsList.jsp?nowPage="+(pagePerBlock*(pageNum-1)+1);
	location.href=param;

}

$("#searchBtn").click(function(){
	let keyWord = $("#keyWord").val().trim();
	if (keyWord=="") {
		alert("검색어를 입력해주세요.");
		$("#keyWord").focus();			
	} else {
		$("#searchFrm").submit();
		}
});
	

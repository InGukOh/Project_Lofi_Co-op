function forUpdate(goodsName){
	location.href="GoodsUpdate.jsp?goodsName="+goodsName;
} 

let nowday = new Date();   
let weekday = nowday.getDay();
let hours = nowday.getHours(); 
let arrival = null;
let send = null;

if(10 < hours && hours < 16){ //오늘발송
	if(weekday == 5 || weekday == 6){
		send = '월요일';
	} else {
		send = '오늘';
	}
	arrival = weekday + 2;
	alert(weekday);
	alert(arrival);
} else {    //내일발송
	if(weekday == 4){
		send = '월요일';
	}
	send = '내일'
}


window.onload = 
	function(){
	$('#arriveDate').append(send);
	let origPrice = document.getElementById('origPrice').value;
	calc(origPrice);
};

let SALL = 0;
let MALL = 0;
let LALL = 0;
let XLALL = 0;
let sum = 0;

function choice(size,sellPrice){
	let selector = '#'+'add'+size;
	let buyCount = 
		'<div id="buyCount'+size+'" style="display: flex;"> \
		<p id="plus'+size+'" class="no-drag" onclick='+'count("plus'+size+'","'+sellPrice+'","'+size+'")'+'\
			style="border: 1px solid #000; width: 40px; \
				   height: 40px; line-height: 40px; text-align: center;">+</p> \
		<p id="result'+size+'" \
			style="border: 1px solid #000; width: 40px; \
				   height: 40px; line-height: 40px; text-align: center;">1</p> \
		<p id="minus'+size+'" class="no-drag" onclick='+'count("minus'+size+'","'+sellPrice+'","'+size+'")'+'\
			style="border: 1px solid #000; width: 40px; \
				   height: 40px; line-height: 40px; text-align: center;">-</p> \
		<p id="delete'+size+'" style="border: 1px solid #000; width: 40px; \
			height: 40px; line-height: 40px; text-align: center; margin-left:15px;" \
			onclick='+'del("'+size+'","'+sellPrice+'")'+'>취소</p> \
		</div> ' ;
	$(selector).append(buyCount);
	document.getElementById("P"+size).setAttribute("onclick","del('"+size+"','"+sellPrice+"')");
	if(size == 'S'){
		SALL = 1;
		calc(sellPrice);
	} else if(size == 'M') {
		MALL = 1;
		calc(sellPrice);
	} else if(size == 'L') {
		LALL = 1;
		calc(sellPrice);
	} else {
		XLALL = 1;
		calc(sellPrice);
	}
}

function del(size,sellPrice){
	let resetter = document.getElementById("P"+size);
	$('#buyCount'+size+'').remove();
	resetter.setAttribute("onclick","choice('"+size+"','"+sellPrice+"')");
	if(size == 'S'){
		SALL = 0;
		calc(sellPrice);
	} else if(size == 'M') {
		MALL = 0;
		calc(sellPrice);
	} else if(size == 'L') {
		LALL = 0;
		calc(sellPrice);
	} else {
		XLALL = 0;
		calc(sellPrice);
	}
}

function count(type,sellPrice,size)  {

	// 결과를 표시할 element
	let resultElement = document.getElementById('result'+size);
  
 	// 현재 화면에 표시된 값
  	let number = resultElement.innerText;
  	expP = /plus/;
  	expM = /minus/;
  	// 더하기/빼기
  	if(expP.test(type))	{
    	number = parseInt(number) + 1;
  	} else if(expM.test(type))	{
    	if(parseInt(number) == 1){
		number = parseInt(number)
		} else {
			number = parseInt(number) - 1;
		}
  	}
  	
  	if(size == 'S'){
		SALL = number;
		calc(sellPrice);
	} else if(size == 'M') {
		MALL = number;
		calc(sellPrice);
	} else if(size == 'L') {
		LALL = number;
		calc(sellPrice);
	} else {
		XLALL = number;
		calc(sellPrice);
	}
	
	// 결과 출력
  	resultElement.innerText = number;
  
}

function calc(sellPrice){
	let fullCalc = SALL + MALL + LALL + XLALL;
	let allCount = document.getElementById('Allcount');
	let calcRes = document.getElementById('calcRes');
	let res = sellPrice * fullCalc;
	allCount.value = fullCalc;
	if(res == 0){
		res = sellPrice;
	}
	document.getElementById('Scount').value = SALL;
	document.getElementById('Mcount').value = MALL;
	document.getElementById('Lcount').value = LALL;
	document.getElementById('XLcount').value = XLALL;
	calcRes.value = res;
}

function addBasket(){
	if(SALL == 0 && MALL == 0 && LALL == 0 && XLALL == 0){
		alert('상품의 사이즈와 갯수를 선택해주세요.');
	} else {
		$("#addBasket").submit(); 
	}
}
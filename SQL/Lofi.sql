create database LofiP;
use LofiP;
/*---------------------유저 테이블--------------------*/
create table userInfo(
Nationality   char(10),
Certify         char(10), 
uID        	  char(20),
uPw             char(20),
uZip             char(100),
uAddr1         char(100),
uAddr2         char(100),
authority      char(5),
Wallet      	   int(8),
uEmail char(100),
PhoneNum1 varchar(5),
PhoneNum2 varchar(5),
PhoneNum3 varchar(5),
BirthYear int(5),
BirthMonth int(5),
BirthDay int(5),
Recommend char(20),
uName char(20),
primary key(uID)
); 

/*---------------------상품 테이블--------------------*/
create table GoodsInfo(
goodsNum       			int     				auto_increment     primary key,
goodsName     			varchar(200)			not null,
goodsWarehousing 		varchar(8)				,
goodsType      		 	varchar(20)				,
goodsPrice      			int(7)						,
goodsSPrice    			int(7)						,
goodsThumbnail   		varchar(1000)			,
goodsImages   			varchar(1000)			,
goodsContent   			varchar(5000)			,
regDate 					varchar(20)			not null,
inventoryS					int(3)						,
inventoryM					int(3)						,
inventoryL					int(3)						,
inventoryXL				int(3)						,
wCount        				int default 0,
goodsLike      			double
);

/*---------------------주문 테이블--------------------*/
create table userOrder(
uID        	  				char(20)				not null,
orderDate                  char(20)             	not null,
addDate                  	char(20)             	not null,
orderName   				char(20)				not null,
goodsName     			varchar(200)			not null,
Scount                     	int(3)						,
Mcount                  	int(3)						,
Lcount                      	int(3)						,
XLcount                    	int(3)						,
calcRes 						int(9)						,
Zip							int(7)					not null,
Addr1						char(100)				not null,
Addr2						char(100)				not null,
phone						char(13)				not null,
notice						char(100)					,
delivery						int(1)					not null
);

/*---------------------장바구니 테이블--------------------*/

create table userBasket (
uID        			char(20),
addDate				char(20)  				not null,
goodsName     	varchar(200)			not null,
Scount 				int(3),
Mcount 				int(3),
Lcount 				int(3),
XLcount 			int(3),
allcount 			int(4),
calcRes 				int(9),
ordered				int(1)
);

/*---------------------게시판 테이블--------------------*/
create table tblReview (
    num          int                    auto_increment,
    uName		char(20)			not null,
    subject     char(50)			not null,
    uEmail		char(50),
    content		text					null		,    
    ref			int					not null,
    pos			int					not null,
    depth		int					not null,
    regDate		date					not null,
    pass			char(20)			null,
    ip				char(15)			null,    
    count			int					not null,
    fileName	char(50)			null,
    fileSize		int					null,
    constraint		primary key(num)
);

create table tblQnA (
    num          int                    auto_increment,
    uName		char(20)			not null,
    subject     char(50)			not null,
    uEmail		char(50)			null,
    content		text					null		,    
    ref			int					not null,
    pos			int					not null,
    depth		int					not null,
    regDate		date					not null,
    pass			char(20)			null,
    ip				char(15)			null,    
    count			int					not null,
    fileName	char(50)			null,
    fileSize		int					null,
    constraint		primary key(num)
);

create table tblNotice (
    num          int                    auto_increment,
    uName		char(20)			not null,
    subject     char(50)			not null,
    content		text				not	null,    
    regDate		date				not null,
    ip				char(15)			null,    
    constraint		primary key(num)
);



/*----------------초기 입력----------------*/
insert into userInfo(uID,uPw,authority) values ('test1234','1234','admin');  /*관리자 권한 계정 임시 생성*/
insert into userInfo(uID,uPw,authority) values ('user1234','1234','user');  
/*------------------------------------------------------*/
select now();
-- --///////////////desc 문/////////////--  -- 
desc userInfo;
desc Goodsinfo;
desc userOrder;
desc userBasket;
desc tblReview;
desc tblQnA;
desc tblNotice;

-- --////////////// 선택문 //////////////--  -- 

select*from userInfo;
select*from GoodsInfo; 
select*from userOrder;
select*from userBasket;
select*from tblReview;
select*from tblQnA;
select*from tblNotice;


select count(*) from goodsInfo where goodsType = '패딩';
select count(*) from tblNotice;
select * from tblNotice order by num desc limit ?,?;
insert into tblNotice(uName, subject, content, regDate, ip) values(1, '2', '3', now(), 10);
select max(num) from tblNotice;
select*from tblNotice order by num desc limit 0,5;
select count(*) from tblNotice;

-- --///////////// 명령어 /////////////--  --
select * from goodsInfo where goodsLike = 1 order by goodsnum desc limit 0,20;
select count(*) from goodsInfo where goodsName like '%겨울%' ;
select count(*) from goodsInfo where goodsLike = 1;
update GoodsInfo set goodsLike=1 where goodsName = '테스트 업로드 TTTT_2201240604';
select * from tblReview order by num desc limit 0,10;
select*from userOrder where goodsName like 'user1231' or uID like 'user1231' order by num desc limit 0,5;
select count(*) from goodsInfo where goodsType = '기타' and goodsName like '%봄%' ;
select count(*) from goodsInfo where goodsName like '%겨울%';
select*from goodsInfo where goodsType = '정장' and goodsName like '%겨울%' order by goodsnum desc limit 0,9;
update userInfo set wallet = 10000000 where uID = 'user1231';
update userBasket set ordered = 0 where uID = 'user1231' and goodsName = '새로운 겨울옷시리즈_2201070445' and ordered = 1;
update userOrder set delivery = 1 where uID ='user1231' and orderDate = '2022-01-17 16:05:03' and goodsName = '여름옷 시리즈~_2201140900' and delivery = 0;
select * from userOrder where uID = 'user1231';
select * from userOrder where uID ='user1231' and addDate = '2022-01-14 18:31:03' and goodsName = '시험상품_2201100601' and delivery = 1 ;
delete from userBasket where uID = 'user1231' and addDate = '2022-01-17 18:15:39' and goodsName ='여름옷 시리즈~_2201140900' and Scount=0  and Mcount= 0 and Lcount= 0 and XLcount= 1 and allcount= 1 and calcRes= 80000 and ordered = 0;
delete from userBasket where uID='user1231' and goodsName ='여름옷 시리즈~_2201140900' and addDate = '2022-01-17 18:15:39';
insert into userBasket value('user1231',  '2022-01-17 18:15:39',  '여름옷 시리즈~_2201140900',  0, 0,  0,  1,  1,  80000, 0);

-- --////////////// 업데이트 //////////////--  -- 
set SQL_SAFE_UPDATES = 0;



-- --//////////////!!!드랍!!!///////////////--  -- 

drop database !lofip;
drop table !UserInfo;
drop table !GoodsInfo;
drop table !tblReview;
drop table !userBasket;
drop table !userOrder;
drop table !tblQnA;
drop table !tblNotice;
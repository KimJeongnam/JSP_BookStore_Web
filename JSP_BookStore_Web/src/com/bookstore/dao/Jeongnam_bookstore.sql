
/* Drop Tables */

DROP TABLE recomments CASCADE CONSTRAINTS;
DROP TABLE book_board CASCADE CONSTRAINTS;
DROP TABLE carts CASCADE CONSTRAINTS;
DROP TABLE dibs CASCADE CONSTRAINTS;
DROP TABLE order_info CASCADE CONSTRAINTS;
DROP TABLE books CASCADE CONSTRAINTS;
DROP TABLE categorys CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE order_status CASCADE CONSTRAINTS;
DROP TABLE users CASCADE CONSTRAINTS;
DROP TABLE permissions CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE books
(
	book_code number NOT NULL,
	title nvarchar2(100) NOT NULL,
	author nvarchar2(100) NOT NULL,
	price number NOT NULL,
	stock number NOT NULL,
	reg_date timestamp,
	publisher nvarchar2(100) NOT NULL,
	publish_date date,
	image_path nvarchar2(255),
	rating number(2,1) DEFAULT 0,
	rating_cnt number DEFAULT 0,
	delete_status number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (book_code)
);


CREATE TABLE book_board
(
	board_id number NOT NULL,
	context nvarchar2(2000) NOT NULL,
	readcnt number,
	book_code number NOT NULL,
	category_id number,
	delete_status number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (board_id)
);


CREATE TABLE carts
(
	user_id nvarchar2(20) NOT NULL,
	book_code number NOT NULL,
	wish_stock number NOT NULL,
	reg_date date DEFAULT SYSDATE,
	PRIMARY KEY (user_id, book_code)
);


CREATE TABLE categorys
(
	category_id number NOT NULL,
	category_name nvarchar2(50) NOT NULL,
	super_id number,
	PRIMARY KEY (category_id)
);


CREATE TABLE dibs
(
	user_id nvarchar2(20) NOT NULL,
	book_code number NOT NULL,
	PRIMARY KEY (user_id, book_code)
);


CREATE TABLE orders
(
	order_code varchar2(40) NOT NULL,
	user_id nvarchar2(20) NOT NULL,
	status nvarchar2(20) NOT NULL,
	total_price number NOT NULL,
	order_date timestamp,
	refund_date timestamp,
	PRIMARY KEY (order_code)
);


CREATE TABLE order_info
(
	order_code varchar2(40) NOT NULL,
	book_code number NOT NULL,
	buy_stock number NOT NULL,
	PRIMARY KEY (order_code, book_code)
);


CREATE TABLE order_status
(
	status nvarchar2(20) NOT NULL,
	PRIMARY KEY (status)
);


CREATE TABLE permissions
(
	permission varchar2(50) NOT NULL,
	PRIMARY KEY (permission)
);


CREATE TABLE recomments
(
	recomment_id number NOT NULL,
	content nvarchar2(500) NOT NULL,
	board_id number NOT NULL,
	p_id number NOT NULL,
	delete_status number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (recomment_id)
);


CREATE TABLE users
(
	user_id nvarchar2(20) NOT NULL,
	user_pw nvarchar2(20) NOT NULL,
	name nvarchar2(10),
	ssn varchar2(14) NOT NULL UNIQUE,
	email nvarchar2(30) NOT NULL,
	zipcode nvarchar2(10) NOT NULL,
	address1 nvarchar2(50) NOT NULL,
	address2 nvarchar2(50),
	phone_number nvarchar2(13) NOT NULL,
	hire_date timestamp DEFAULT SYSDATE,
	delete_status number(1) NOT NULL,
	accept_code nvarchar2(36),
	accept_status number(1) DEFAULT 0 NOT NULL,
	permission varchar2(50) NOT NULL,
	PRIMARY KEY (user_id)
);



/* Create Foreign Keys */

ALTER TABLE book_board
	ADD FOREIGN KEY (book_code)
	REFERENCES books (book_code)
;


ALTER TABLE carts
	ADD FOREIGN KEY (book_code)
	REFERENCES books (book_code)
;


ALTER TABLE dibs
	ADD FOREIGN KEY (book_code)
	REFERENCES books (book_code)
;


ALTER TABLE order_info
	ADD FOREIGN KEY (book_code)
	REFERENCES books (book_code)
;


ALTER TABLE recomments
	ADD FOREIGN KEY (board_id)
	REFERENCES book_board (board_id)
;


ALTER TABLE book_board
	ADD FOREIGN KEY (category_id)
	REFERENCES categorys (category_id)
;


ALTER TABLE categorys
	ADD FOREIGN KEY (super_id)
	REFERENCES categorys (category_id)
;


ALTER TABLE order_info
	ADD FOREIGN KEY (order_code)
	REFERENCES orders (order_code)
;


ALTER TABLE orders
	ADD FOREIGN KEY (status)
	REFERENCES order_status (status)
;


ALTER TABLE users
	ADD FOREIGN KEY (permission)
	REFERENCES permissions (permission)
;


ALTER TABLE recomments
	ADD FOREIGN KEY (p_id)
	REFERENCES recomments (recomment_id)
;


ALTER TABLE carts
	ADD FOREIGN KEY (user_id)
	REFERENCES users (user_id)
;


ALTER TABLE dibs
	ADD FOREIGN KEY (user_id)
	REFERENCES users (user_id)
;


ALTER TABLE orders
	ADD FOREIGN KEY (user_id)
	REFERENCES users (user_id)
;



REM INSERTING into JEONGNAMBOOKSTORE.PERMISSIONS
SET DEFINE OFF;
Insert into JEONGNAMBOOKSTORE.PERMISSIONS (PERMISSION) values ('admin');
Insert into JEONGNAMBOOKSTORE.PERMISSIONS (PERMISSION) values ('customer');

REM INSERTING into JEONGNAMBOOKSTORE.USERS
SET DEFINE OFF;
Insert into JEONGNAMBOOKSTORE.USERS (USER_ID,USER_PW,NAME,SSN,EMAIL,ZIPCODE,ADDRESS1,ADDRESS2,PHONE_NUMBER,HIRE_DATE,DELETE_STATUS,ACCEPT_CODE,ACCEPT_STATUS,PERMISSION) values ('root','1q2w3e4r5t','관리자','000000-0000000','none@none.none','000-000','NONE','NONE','NONE',to_timestamp('18/12/12 05:17:20.000000000','RR/MM/DD HH24:MI:SSXFF'),0,null,1,'admin');
Insert into JEONGNAMBOOKSTORE.USERS (USER_ID,USER_PW,NAME,SSN,EMAIL,ZIPCODE,ADDRESS1,ADDRESS2,PHONE_NUMBER,HIRE_DATE,DELETE_STATUS,ACCEPT_CODE,ACCEPT_STATUS,PERMISSION) values ('tester','1234','tester1','000000-0000001','none@none.none','000-000','NONE','NONE','NONE',to_timestamp('18/12/12 05:17:20.000000000','RR/MM/DD HH24:MI:SSXFF'),0,null,1,'customer');
Insert into JEONGNAMBOOKSTORE.USERS (USER_ID,USER_PW,NAME,SSN,EMAIL,ZIPCODE,ADDRESS1,ADDRESS2,PHONE_NUMBER,HIRE_DATE,DELETE_STATUS,ACCEPT_CODE,ACCEPT_STATUS,PERMISSION) values ('kim910712','qwjdskap!2','김정남','9107121588028','qwjdskap@naver.com','08531','서울 금천구 시흥대로153길 17 (독산동)','611호','010-9515-7416',to_timestamp('18/12/14 14:14:59.518000000','RR/MM/DD HH24:MI:SSXFF'),0,'a7f71517-7437-4924-8418-7ef0684ee67d',1,'customer');

REM INSERTING into JEONGNAMBOOKSTORE.CATEGORYS
SET DEFINE OFF;
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (1,'국내도서',null);
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (2,'해외도서',null);
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (3,'소설',2);
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (4,'소설',1);
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (5,'문학',1);
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (6,'문학',2);
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (7,'경제 경영',1);
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (21,'역사',1);
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (22,'경제 경영',2);
Insert into JEONGNAMBOOKSTORE.CATEGORYS (CATEGORY_ID,CATEGORY_NAME,SUPER_ID) values (23,'역사',2);

DROP SEQUENCE category_seq;

CREATE SEQUENCE category_seq
    START WITH 24
    INCREMENT BY 1
    MAXVALUE 9999999;

commit;

REM INSERTING into JEONGNAMBOOKSTORE.BOOKS
SET DEFINE OFF;
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (1,'종이여자','기욤 뮈소',15860,1200,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/종이여자.jpeg',8,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (2,'구해줘','기욤 뮈소',15130,1500,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/구해줘.jpeg',7,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (3,'센트럴 파크','기욤 뮈소',15130,1350,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/센트럴파크.jpeg',9,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (4,'브루클린의 소녀','기욤 뮈소',15000,1350,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/브루클린의_소녀.jpeg',9,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (5,'제0호','움베르토 에코',15000,3000,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'열린책들',to_date('10/10/30','RR/MM/DD'),'/JSP_BookStore_Web/images/books/제0호1.jpeg',9,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (6,'12가지 인생의 법칙','조던 B. 피터슨',15000,1350,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/12가지_인생의_법칙.jpg',9,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (7,'트렌드 코리아 2019','김난도, 이준영 외 7명',15000,1350,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/트렌드_코리아_2019.jpg',9,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (8,'걷는 사람 하정우','하정우',13900,1350,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/걷는_사람_하정우.jpg',9,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (9,'고요할수록 밝아지는 것들','혜민 저',13500,1350,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/고요할수록_밝아지는_것들.jpg',9,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (10,'아가씨와 밤','기욤 뮈소',13050,1350,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/아가씨와_밤.jpg',9,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (11,'당신이 옳다','정혜신',14220,1350,to_timestamp('18/12/12 05:17:21.000000000','RR/MM/DD HH24:MI:SSXFF'),'밝은세상',to_date('10/12/15','RR/MM/DD'),'/JSP_BookStore_Web/images/books/당신이_옳다.jpg',9,1,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (12,'고마워, 우리 함께했던 순간들','Stone Music Entertainment ',43650,2500,to_timestamp('18/12/12 14:25:33.984000000','RR/MM/DD HH24:MI:SSXFF'),'Stone Music Entertainment ',to_date('18/12/31','RR/MM/DD'),'/JSP_BookStore_Web/images/books/고마워,_우리_함께했던_모든_순간들.jpg',0,0,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (13,'곰돌이 푸, 행복한 일은 매일 있어 (한정판 겨울 에디션)','곰돌이 푸',10800,2000,to_timestamp('18/12/12 14:42:07.122000000','RR/MM/DD HH24:MI:SSXFF'),' 알에이치코리아(RHK)',to_date('18/03/12','RR/MM/DD'),'/JSP_BookStore_Web/images/books/곰돌이_푸,_행복한_일은_매일_있어_(한정판_겨울_에디션).jpg',0,0,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (14,'경제 트렌드 2019','김동환, 김일구, 김한진 공저',14400,350,to_timestamp('18/12/12 18:19:04.207000000','RR/MM/DD HH24:MI:SSXFF'),'포레스트북스',to_date('18/12/05','RR/MM/DD'),'/JSP_BookStore_Web/images/books/경제_트렌드_2019.jpg',0,0,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (21,'리밸런싱','박홍기',16650,3000,to_timestamp('18/12/13 09:59:42.465000000','RR/MM/DD HH24:MI:SSXFF'),'좋은땅',to_date('18/12/05','RR/MM/DD'),'/JSP_BookStore_Web/images/books/리밸런싱.jpg',0,0,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (22,'골든아워 1','이국종',14220,3000,to_timestamp('18/12/13 10:20:15.849000000','RR/MM/DD HH24:MI:SSXFF'),'흐름출판',to_date('18/10/02','RR/MM/DD'),'/JSP_BookStore_Web/images/books/골든아워_1.jpg',0,0,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (23,'나는 나로 살기로 했다','김수현',12420,5000,to_timestamp('18/12/13 10:27:57.956000000','RR/MM/DD HH24:MI:SSXFF'),'마음의숲',to_date('16/11/05','RR/MM/DD'),'/JSP_BookStore_Web/images/books/나는_나로_살기로_했다.jpg',0,0,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (24,'역사의 역사','유시민',14400,5000,to_timestamp('18/12/13 10:36:21.394000000','RR/MM/DD HH24:MI:SSXFF'),'돌베개',to_date('18/06/25','RR/MM/DD'),'/JSP_BookStore_Web/images/books/역사의_역사.jpg',0,0,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (25,'경제의 속살','이완배 저',13500,5000,to_timestamp('18/12/13 10:40:16.096000000','RR/MM/DD HH24:MI:SSXFF'),'민중의소리',to_date('18/12/03','RR/MM/DD'),'/JSP_BookStore_Web/images/books/경제의_속살_1_경제학_편.jpg',0,0,0);
Insert into JEONGNAMBOOKSTORE.BOOKS (BOOK_CODE,TITLE,AUTHOR,PRICE,STOCK,REG_DATE,PUBLISHER,PUBLISH_DATE,IMAGE_PATH,RATING,RATING_CNT,DELETE_STATUS) values (26,'골든아워 2','이국종',14220,0,to_timestamp('18/12/13 10:42:49.262000000','RR/MM/DD HH24:MI:SSXFF'),'흐름출판',to_date('18/10/02','RR/MM/DD'),'/JSP_BookStore_Web/images/books/골든아워_2.jpg',0,0,0);

REM INSERTING into JEONGNAMBOOKSTORE.BOOK_BOARD
SET DEFINE OFF;
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (1,' ',0,1,3,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (2,' ',0,2,3,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (3,' ',0,3,3,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (4,' ',0,4,3,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (5,'<p><strong>우리가 사랑한 작가 움베르토 에코의 마지막 소설!</strong><br>미디어, 정치, 음모, 살인의 탁하고 음산한 세계를 그린 움베르토 에코의 유작으로, 누가 거짓을 만들어내고 사람들은 어떻게 그런 거짓에 현혹되는지 그리고 그런 거짓을 만들어내는 자들은 어떻게 몰락하는지 묻고 답하는 소설. “거짓이 너희를 자유롭게 하리라!” 가짜 뉴스의 가면 벗기는 이번 소설은 한국사회에도 동일한 질문을 던진다.<br><br><strong>위기의 저널리즘,&nbsp;<br>이 시대 최고의 지성이 파헤친&nbsp;<br>언론의 천태만상</strong><br><br>우리 시대의 가장 영향력 있는 사상가, 권위 있는 기호학자이자 뛰어난 철학자, 역사학자, 미학자, 전 세계적인 인기를 누린 베스트셀러 소설가 - 움베르토 에코의 마지막 소설 『제0호』가 열린책들에서 출간되었다. 이탈리아에서만 25만부 이상의 판매고를 올리며 미국, 프랑스, 스페인, 일본, 폴란드, 러시아 등 전 세계 40개국 이상에서 출간 또는 출간을 앞두고 있다.&nbsp;<br><br>토마스 아퀴나스에서부터 대중문화에 이르기까지 다양한 영역을 넘나들며 시대를 대표하는 지성으로 존경받은 에코의 작품들은 전무후무한 베스트셀러로 오랜 시간 독자들의 열광을 불러일으켰다. 데뷔작이자 대표작인 『장미의 이름』은 40개국 이상에서 번역되었으며 전 세계에서 3천만 부 이상이 팔렸고 동명의 영화로도 제작되었다. 또, 같은 작품으로 1981년 이탈리아 스트레가상을, 1982년 프랑스 메디치 외국 문학상을 받았다. 에코는 2016년 2월 19일 췌장암으로 별세했다.&nbsp;<br><br>2015년 출간된 그의 마지막 소설 『제0호』는 정보의 홍수 속에 사는 현대인에게 올바른 저널리즘〉에 대한 묵직한 질문을 던진다. 공정성을 잃은 보도와 음모론적 역설(力說)의 난장, 뚜렷한 방향 없는 단말마의 포르노적 정보 공세. 일찍이『 푸코의 진자』,『 프라하의 묘지』 등에서 다뤘듯 음모론을 둘러싼 대중의 망상에 오랜 시간 흥미를 가져온 에코는 저널리즘의 편집증을 목록화해 펼쳐 보인다.<br><br>『프라하의 묘지』, 『로아나 여왕의 신비한 불꽃』, 『세상의 바보들에게 웃으면서 화내는 방법』 등을 번역한 바 있는 이세욱 역자는 작가에 대한 심도 있는 이해를 바탕으로, 정교하게 계산된 움베르토 에코의 문체를 한국어로 세심하게 옮겼다.</p>',0,5,6,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (6,'<p><strong><em>==책 소개==</em></strong></p><hr><p><br></p>',0,6,6,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (7,' ',0,7,5,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (8,' ',0,8,5,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (9,' ',0,9,5,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (10,' ',0,10,3,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (11,' ',0,11,5,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (21,'<p><strong><em>==책 소개==</em></strong></p><hr><p>정치와 경제가 초양극화로 치달으면서 가진 것 없는 사람들은 더욱 허덕이며 지내고 있으며 이들은 사회의 ‘신흥 금융노예’가 되고 있다. 현재 우리의 경제는 가진 것 없고 몫 없는 자들을 착취한 배부른 1%의 경제시장에서 겨우겨우 살아가고 있다.&nbsp;<br><br>박홍기 저자의 《리밸런싱》은 감언이설로 경제를 속여 온 이들에 대한 날카로운 비판과 함께 곧 들이닥쳐 우리의 목을 옥죌 2019~2022년까지의 경제 상황을 전망하고 있다. 그리고 이러한 위기를 어떻게 돌파해야 하는지 제시하고 있다.</p>',0,21,7,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (22,'<p><strong><em>==책 소개==</em></strong></p><hr><p><strong>“사람을 살리는 것, 그것이 우리의 일이다.”<br>단 한 생명도 놓치지 않으려는 이름 없는 사람들의 분투</strong><br><br>외상외과 의사 이국종 교수가 눌러쓴 삶과 죽음의 기록이다. 저자는 17년간 외상외과 의사로서 맞닥뜨린 냉혹한 현실, 고뇌와 사색, 의료 시스템에 대한 문제의식 등을 기록해왔다. 때로는 짧게 때로는 길게 적어 내려간 글은 그동안 ‘이국종 비망록’으로 일부 언론에 알려졌다. 그 기록이 오랜 시간 갈고 다듬어져 두 권의 책(1권 2002-2013년, 2권 2013-2018)으로 출간됐다. 이국종 교수의 『골든아워』는 대한민국 중증외상 의료 현실에 대한 냉정한 보고서이자, 시스템이 기능하지 않는 현실 속에서도 생명을 지키려 애써온 사람들-의료진, 소방대원, 군인 등-의 분투를 날 것 그대로 담아낸 역사적 기록이다.&nbsp;<br><br>1권에서는 외상외과에 발을 들여놓은 후 마주친 척박한 의료 현실에 절망하고 미국과 영국의 외상센터에 연수하면서 비로소 국제 표준의 외상센터가 어떠해야 하는지 스스로 기준을 세워나가는 과정이 그려진다. 생사가 갈리는 위중한 상황에 처한 의료진과 환자, 보호자의 통렬한 심정, 늘 사고의 위험에 노출된 육체노동자들의 고단한 삶, 가정폭력, 조직폭력 등 우리네 세상의 다양한 면면이 펼쳐진다. 무엇보다도 아덴만 여명 작전에서 부상당한 석 선장을 생환하고 소생시킨 석 선장 프로젝트의 전말은 물론, 전 국민적 관심 속에 중증외상 치료 시스템의 획기적인 전기를 마련하고도 소중한 기회를 제대로 살리지 못한 대한민국의 의료 현실을, 슬픔을 꾹꾹 눌러 담은 담담한 어조로 묘사한다.&nbsp;<br><br>2권에서는 우여곡절 끝에 저자가 몸담은 대학병원이 권역별 외상센터로 지정된 후에도 국제 표준에 훨씬 못 미치는 의료 현실 속에서 고투하는 과정을 그렸다.</p>',0,22,5,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (23,'<p><strong><em>==책 소개==</em></strong></p><hr><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td><strong>진짜 ‘나’로 살기 위한 뜨거운 조언들!<br>어른이 처음인 당신을 위한 단단한 위로들!</strong><br><br>“어른이 되어보니 세상은 냉담한 곳이었다.” 김수현은 책을 펴내면서 이런 말을 했다. 부조리가 넘쳐났고, 사람들은 불필요할 정도로 서로에게 선을 긋고, 평범한 이들조차 기회가 있으면 차별과 멸시를 즐긴다. 우리는 자본주의 사회에서 철저한 갑과 을이 되어 살아가고 있다. 그것이 우리가 이토록 발버둥 치며 살고 있는 세상이다.&nbsp;<br><br>이 책은 우리가 온전한 ‘나’로 살아가기 위해 무엇이 필요한지 말해준다. 돈 많고 잘나가는 타인의 SNS를 훔쳐보며 비참해질 필요 없고, 스스로에게 변명하고 모두에게 이해받으려 애쓰지 말라고 이야기한다. 불안하다고 무작정 열심히 할 필요 없고, 세상의 정답에 굴복하지 말라고 응원한다. 인생의 지나가는 사람들에게 더 이상 상처받지 말고, 누군가의 말에 흔들리지 말고, 자신만의 문제라고 착각하지 말라고. 우리에게 가장 필요한 말, 나답게 살라고 말한다.&nbsp;<br><br>그래서 이 책은 내가 누구인지 고민할 시간조차 없는 현대인들에게, ‘나’를 돌아보게 하는 시간을 선물하고 있다. 남처럼 사는 것이 아니라 나처럼 살 수 있도록, 진짜 ‘나’로 살기 위해 우리가 한번쯤 생각하고 고민해야 할 것들을 수록했다. 길을 잃고 있는 당신에게 가장 필요한 책, 어른이 되어서도 ‘나’를 찾고자 하는 어른아이를 위한 책, 밥벌이와 어른살이에 지친 모든 현대인에게 이 책을 바친다.</td></tr></tbody></table>',0,23,5,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (12,'<p><strong><em>==책 소개==</em></strong></p><hr><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td><strong>다신 없을 찬란했던 지난 시간의 기억<br>오래도록 간직하고픈 워너원의 빛났던 순간들&nbsp;</strong><br><br>최근 첫 정규앨범을 발매하고 마지막 음반 활동 중인 워너원이 팬들을 위한 포토 에세이를 발간했다. 『워너원 포토 에세이 ‘고마워, 우리 함께했던 모든 순간들’』은 지난 4월 출간된 ‘우리 기억 잃어버리지 않게’ 이어서 시즌 2 포토 에세이로 출간되며, 2018년 1년간의 활동들을 사진과 이야기로 엮었다.&nbsp;<br><br>특히 이번 포토 에세이는 VOL.1과 VOL.2 두 권으로 구성돼 더욱 풍성한 내용으로 다채로운 워너원의 매력을 느낄 수 있다. VOL.1에는 두 번째 미니앨범 ‘0+1=1 (I PROMISE YOU)’과 세 번째 미니앨범 ‘1÷χ=1 (UNDIVIDED)’의 앨범 재킷 촬영 현장과 뮤직비디오 촬영 현장 등 워너원의 앨범 제작 과정과 비하인드 스토리를 담았고, VOL.2에는 올 한 해 성황리에 마친 워너원 월드투어 ‘ONE : THE WORLD’ 콘서트의 백스테이지 및 라이브 무대 모습을 실어 함께 하지 못했던 팬들의 아쉬움을 달랜다. 또한 이들의 첫 번째 정규앨범인 ‘1¹¹=1 (POWER OF DESTINY)’의 앨범 재킷과 뮤직비디오 촬영 현장 역시 엿볼 수 있다.&nbsp;<br><br><strong>미공개 비하인드 총 700여 컷의 초호화 화보집과&nbsp;<br>멤버별 스페셜 인터뷰, 그리고 그들의 마음을 대변하는 노랫말</strong><br><br>이번 포토 에세이는 워너원의 2018년 동안의 활동 모습을 모두 담고 있는 만큼 더욱 알차게 준비됐다. 총 620여 페이지에 달하는 화보집은 워너원의 지난 일 년을 순차적으로 기록하고 있는데, 그들의 음악을 대하는 진지함과 멤버들이 함께 할 때의 편안하고 솔직한 모습 등이 담겨있다. 특별히 별책 부록으로 구성된 ‘메모리북’은 포토 앨범과 함께 워너블에게 전하는 워너원의 마지막 친필 메시지가 담겨 있다.&nbsp;<br><br>화보집뿐만 아니라 VOL.1과 VOL.2 각 권에 모두 담긴 스페셜 인터뷰 ‘MEMORY OF 11’에서는 멤버별 개개인의 이야기를 진솔하게 풀어낸다. 지난 활동에 대한 생각과 고민, 꿈과 열정에 관한 진심. 이것은 그동안 함께 성장한 워너원과 워너블에게 전하는 이야기이기도 하다. 또한 이들의 마음을 대변해주는 아련한 노랫말이 화보 사진 곳곳에 함께 구성돼 워너원을 영원히 추억하고 싶을 분들께 더욱 진하게 와닿을 것이다.&nbsp;</td></tr></tbody></table>',0,12,5,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (13,'<p><strong><em>==책 소개==</em></strong></p><hr><p><strong>나를 지키기 위해 자꾸만 나를 잃어가는 세상 속에서,&nbsp;<br>나로 살기 위한 곰돌이 푸의 마음을 들여다보는 말.&nbsp;</strong><br><br>“푸는 말이야,&nbsp;<br>머리는 별로 좋지 않지만 절대 나쁜 일은 하지 않아!<br>바보 같은 짓을 해도 푸가 하면 잘 돼.”<br><br>이 책 『곰돌이 푸, 행복한 일은 매일 있어』는 곰돌이 푸의 긍정적인 기운과 ‘나의 삶은 나의 방식으로 정한다’라고 말했던 독일의 철학자 니체의 말 중에서 오늘날의 우리에게도 도움이 될 만한 조언들을 모았다. 말하자면 곰돌의 푸의 입으로 전하고 니체가 거드는 셈이다. 행복은 여전히 먼 곳에 있고, 나는 어떤 사람인지, 나는 무엇을 할 때 행복했는지에 대한 기억도 점차 흐려져 오늘도 ‘행복’을 찾는 일이 영 요원하게 느껴질 때, 이 책을 펼치면 어떤 페이지를 열든 푸가 느긋한 미소를 지으며 ‘너무 걱정하지 마. 다 잘 될 거야’라고 말하며 우리를 위로해줄 것이다. 어린 시절 우리의 마음을 행복으로 물들여주었던 작지만 사랑스러운 그 모습 그대로!<br><br>"멋지지 않으면 어떤가요? 눈앞의 행복을 꽉 잡으세요.&nbsp;<br>행복이 눈앞에 있는데도 나의 대외적인 이미지 때문에 외면하고 있나요? 혹은 눈앞의 행복이 생각했던 것처럼 근사하지 않아서 머뭇거리게 되나요? 멋지지 않아도 됩니다. 다른 사람의 시선은 그리 중요한 게 아니에요. (...) 어떻게든 찾아온 행복을 꽉 움켜쥐세요!"<br><br>이렇듯 이 책은 행복한 기억으로 남아 있는 곰돌이 푸의 추억을 다시 불러온다. 그래서 푸를 기억하고 있는 사람이라면 누구라도, 단순하지만 편안하게 스며들어오는 푸의 이야기 속에서 오늘을 살아가기 위한 용기를 얻어갈 수 있을 것이다.</p>',0,13,3,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (14,'<p><strong><em>==책 소개==</em></strong></p><hr><p><strong>“2019년 경제, 5D에 주목하라!”<br>대한민국 3대 이코노미스트가 통찰한 투자 대응 전략<br><br>한양대학교 임형록 교수 추천&nbsp;<br>키움증권 홍춘욱 박사 추천&nbsp;<br>MBC 손에 잡히는 경제 이진우 추천&nbsp;<br>전업투자자 정채진 추천&nbsp;<br></strong><br>2019년 경제는 어느 때보다 변동성과 불확실성이 클 것으로 전망된다. “수많은 소음이 눈과 귀를 가리고 있고”, “갈피를 잡기 어려울 만큼 복잡하게 얽힌” 지금의 경제 상황에서 ‘올바른 신호’를 찾기 위해선 ‘기준점’을 어디에 두고 살펴야 하는지가 매우 중요하다. 『경제 트렌드 2019』는 바로 그런 점에서 지금의 세계 경제와 한국 경제를 가늠하는 데 매우 유의미한 인사이트와 힌트를 제시해주는 책이다. 세계 경제와 한국 경제를 꿰뚫는 이슈들을 살피며 부동산, 주식, 금리·채권, 환율 등 자산시장별로 예상되는 흐름을 전망해준다. 무엇보다 2019년 투자 전략을 수립하는 데 도움이 될 핵심 트렌드 키워드 ‘5D’는 내년 한 해 심사숙고해야 할 화두가 될 것이다.</p>',0,14,7,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (24,'<p><strong><em>==책 소개==</em></strong></p><hr><p><strong>‘국가란 무엇인가’ 이후, ‘역사란 무엇인가’를 묻다<br>유시민과 함께 역사의 갈피를 찾다!</strong><br><br>『거꾸로 읽는 세계사』로부터 30년, 작가 유시민 글쓰기의 새로운 시작. 헤로도토스의 『역사』, 투키디데스의 『펠로폰네소스 전쟁사』부터 유발 하라리의 『사피엔스』까지 고대로부터 최근까지 역사를 사로잡은 18권의 역사서들을 9장으로 나누어 훑으며 ‘역사’라는 화두를 전개해간다. 각 역사서의 주요 내용과 시대적인 맥락, 서사의 새로운 초점과 해석, 역사가의 생애 등을 유시민만의 언어로 요약했다.<br><br>여기에 역사가의 속마음을 전달하고, 놓치지 말아야 할 부분을 체크해 주거나, 이해하지 못해도 좋다고 위로하고 격려하는 안내자 역할까지 맡았다. 역사에 대한 애정과 역사 공부의 중요성을 몸소 보여주며, 자신의 역사 공부법을 공개하는 셈이다. 역사의 힘과 논리, 역사가의 생각과 감정, 역사 공부의 재미와 깨달음을 함께 나누는 가운데 저마다 ''어떻게 살 것인가''라는 질문으로 나아가게 한다.&nbsp;</p><p><br></p><p><strong><em>== 저자 소개 ==</em></strong></p><hr><p><img alt="" src="http://image.yes24.com/momo/TopCate74/MidCate05/7340877.jpg"></p><p>Rhyu Simin,柳時民서울대학교 경제학과를 졸업하고 독일 마인츠 대학에서 경제학 석사학위를 받았다. 개혁국민정당 대표와 16, 17대 국회의원, 44대 보건복지부 장관을 지냈으며 2009년 국민참여당을 창당해 대표를 맡았다. <br><br>대한민국이 자유롭고 민주적인 나라가 되기를 바란 덕분에 거리와 감옥에서 대학 시절을 보냈다. 감옥에서 ‘항소이유서’를 쓰면서 글쓰기 재능을 처음 발견했다. 민주화가 시작된 뒤 남들이 어떻게 사는지 보고 싶어 아내와 함께 독일로 유학을 떠났다. 한국에 돌아와 책과 칼럼을 쓰고 방송 일을 하다가 2002년부터 정치에 참여했다. 좋은 대통령, 좋은 나라를 만들겠노라며 뛰어다녔는데, 성공한 일도 있고 실패한 것도 많았다. 2008년 총선 후 정치활동을 접고 글쓰기와 강의활동에 몰두하던 때 노무현 대통령이 세상을 떠났다. 대통령의 자서전 『운명이다』를 대신 정리하면서 슬픔을 견뎠다. 2013년 정계를 은퇴했다.</p>',0,24,21,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (25,'<p><strong><em>==책 소개==</em></strong></p><hr><p><strong>인간은 이기적 존재가 아니며<br>얼마든지 연대와 협동의 공동체를 건설할 수 있다!<br><br>차가운 경제학을 넘어서는&nbsp;<br>따뜻한 경제학에 대한 희망의 메시지</strong><br><br>『한국재벌흑역사』의 저자 민중의소리 이완배 기자가 『경제의 속살』 1, 2권으로 돌아왔다. 2년 8개월 동안 팟캐스트 ‘김용민의 브리핑’에서 따뜻한 경제 이야기를 전하며 큰 인기를 끌었던 이완배 기자의 주요 방송 내용이 이 책에 담겼다.&nbsp;<br><br>저자는 이 땅의 청년들과 청소년들에게 사죄의 말을 전하며 이 책을 시작한다. “좋은 세상을 물려드리지 못해 죄송합니다. 여러분들을 경쟁의 구렁텅이로 몰아넣은 것은 우리 기성세대의 잘못입니다”가 저자가 남긴 말이다.&nbsp;<br><br>저자는 기성세대가 청년들에게 엄청난 빚을 지고 있다고 생각한다. 이 땅의 청년들은 대한민국 역사상 가장 비열한 경쟁의 세상에 내몰렸기 때문이다. 이들은 어렸을 때부터 경쟁에 이기지 못하면 삶을 유지할 수 없는 잔인한 세상을 경험했다. 남을 짓밟지 않으면 자신이 죽는 세상, 이 처참한 세상을 물려준 것은 기성세대의 씻을 수 없는 원죄다.<br><br>그래서 저자는 이 책을 통해 “무언가를 이야기해야 한다면, 내가 이야기할 수 있는 주제는 단 하나뿐이었다. 연대와 협동, 우리 인류가 7000년 동안 지켜왔던 공동체의 가치를 복원하자는 것이 내가 전해야 하는 유일한 이야기라고 지금도 굳게 믿는다”고 말한다. 남을 짓밟는 경쟁의 경제학이 아니라 연대와 협동을 통한 따뜻한 경제학을 가꿔야 한다는 것이다.&nbsp;<br><br>『경제의 속살』 1권에서는 그 동안 방송에서 다뤘던 다양한 경제 이론들이 담겨 있다. 인간이 이기적인 존재라는 주류 경제학의 전제와 싸워온 수많은 경제학 이론들이 1권의 주제다.&nbsp;<br><br>1권의 마지막 장 제목을 ‘동행의 경제학’으로 잡은 이유도 따로 있다. 저자는 우리 모두 한걸음씩 내딛으면 이 사회가 바뀔 것이라고 굳게 믿는다. 누군가 내딛는 한 명의 한걸음이 아니라 우리 모두의 한걸음이 그 기적을 이뤄낸다는 것이다.<br><br>그래서 저자는 저자의 수많은 벗들과 그 아름다운 한걸음을 함께 걷는 행복한 상상을 멈추지 않는다. 부디 이 책이 저자의 바람처럼 자본주의가 망쳐놓은 연대와 협동의 공동체성을 복원하는 계기가 되기를 기대한다.</p>',0,25,7,0);
Insert into JEONGNAMBOOKSTORE.BOOK_BOARD (BOARD_ID,CONTEXT,READCNT,BOOK_CODE,CATEGORY_ID,DELETE_STATUS) values (26,'<p><strong><em>==책 소개==</em></strong></p><hr><table border="0" cellpadding="0" cellspacing="0"><tbody><tr><td><strong>막을 수 있었던 수많은 죽음을 목격하고도<br>왜 우리는 변하지 못하는가?&nbsp;</strong><br><br>외상외과 의사 이국종 교수가 눌러쓴 삶과 죽음의 기록. 저자는 17년간 외상외과 의사로서 맞닥뜨린 냉혹한 현실, 고뇌와 사색, 의료 시스템에 대한 문제의식 등을 기록해왔다. 때로는 짧게 때로는 길게 적어 내려간 글은 그동안 ‘이국종 비망록’으로 일부 언론에 알려졌다. 그 기록이 오랜 시간 갈고 다듬어져 두 권의 책(1권 2002-2013년, 2권 2013-2018년)으로 출간됐다. 이국종 교수의 『골든아워』는 대한민국 중증외상 의료 현실에 대한 냉정한 보고서이자, 시스템이 기능하지 않는 현실 속에서도 생명을 지키려 애써온 사람들-의료진, 소방대원, 군인 등-의 분투를 날 것 그대로 담아낸 역사적 기록이다.&nbsp;<br><br>2권에서는 우여곡절 끝에 저자가 몸담은 대학병원이 권역별 중증외상센터로 지정된 후에도 국제 표준에 훨씬 못 미치는 의료 현실 속에서 고투하는 과정을 그렸다. 중증외상센터 사업이 시간이 흐를수록 원칙과 본질에서 벗어나 복잡한 이해관계에 휘둘리며 표류하는 동안 시스템의 미비를 몸으로 때우던 동료들이 한계상황에 내몰리고 부상으로 쓰러진다. 켜켜이 쌓여가던 모순과 부조리는 결국 전 국민을 슬픔에 빠뜨린 대참사를 통해 적나라하게 드러났다. 세월호, 귀순한 북한군 병사 등 대한민국 중증외상 치료의 현장을 증언하며 저자는 이제 동료들의 희생과 땀과 눈물을 돌아본다. 낙관 없이 여기까지 왔고 희망 없이 나아가고 있지만, 전우처럼 지금껏 같은 길을 걸어온 사람들을 기록하고자 밤새워 한 자 한 자 적어 내려갔다. 부상을 감수하며 헬리콥터에 오른 조종사들과 의료진들, 사고 현장에서 죽음과 싸우는 소방대원들, 목숨을 각오하고 국민을 지키는 군인들…. 이 책은 단 한 생명도 놓치지 않으려 분투해 온 그 모든 사람들에게 바치는 헌사다.&nbsp;</td></tr></tbody></table>',0,26,5,0);

commit;

DROP SEQUENCE book_seq;
DROP SEQUENCE board_seq;


CREATE SEQUENCE book_seq
    START WITH 27
    INCREMENT BY 1
    MAXVALUE 9999999;
    

CREATE SEQUENCE board_seq
    START WITH 27
    INCREMENT BY 1
    MAXVALUE 9999999;
    
INSERT INTO order_status values('BUY_ASK');
INSERT INTO order_status values('BUY_CONFIRM');
INSERT INTO order_status values('BUY_CANCLE');
INSERT INTO order_status values('REFUND_ASK');
INSERT INTO order_status values('REFUND_CONFIRM');
INSERT INTO order_status values('REFUND_CANCLE');
COMMIT;
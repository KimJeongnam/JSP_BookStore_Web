
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
	wish_stock number NOT NULL
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



insert into permissions values('customer');

insert into permissions values('admin');


insert into users(
    USER_ID
    , USER_PW
    , NAME
    , SSN
    , EMAIL
    , ZIPCODE
    , ADDRESS1
    , ADDRESS2
    , PHONE_NUMBER
    , HIRE_DATE
    , DELETE_STATUS
    , PERMISSION)
    values('root', '1q2w3e4r5t', '관리자', '000000-0000000',
    'none@none.none', '000-000', 'NONE', 'NONE', 'NONE', SYSDATE, 0, 'admin');


update users SET accept_status=1 WHERE user_id='root';

insert into users(
    USER_ID
    , USER_PW
    , NAME
    , SSN
    , EMAIL
    , ZIPCODE
    , ADDRESS1
    , ADDRESS2
    , PHONE_NUMBER
    , HIRE_DATE
    , DELETE_STATUS
    , PERMISSION)
    values('tester', '1234', 'tester1', '000000-0000001',
    'none@none.none', '000-000', 'NONE', 'NONE', 'NONE', SYSDATE, 0, 'customer');
    
update users SET accept_status=1 WHERE user_id='tester';
    
commit;

SELECT COUNT(*) FROM users WHERE user_id='hong1';

delete FROM users WHERE user_id='kim910712';

DROP SEQUENCE category_seq;
DROP SEQUENCE book_seq;
DROP SEQUENCE board_seq;

CREATE SEQUENCE category_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999;

CREATE SEQUENCE book_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999;
    

CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999;


insert into categorys(category_id, category_name) values(category_seq.nextval, '국내');

insert into categorys(category_id, category_name) values(category_seq.nextval, '해외');

insert into categorys(category_id, category_name, super_id) values(category_seq.nextval, '소설', 2);

insert into categorys(category_id, category_name, super_id) values(category_seq.nextval, '소설', 1);
insert into categorys(category_id, category_name, super_id) values(category_seq.nextval, '문학', 1);
insert into categorys(category_id, category_name, super_id) values(category_seq.nextval, '문학', 2);

commit;

-- 외부 조인
select p.category_name, c.category_name, c.super_id
    FROM categorys c RIGHT OUTER JOIN categorys p
    ON c.category_id = p.category_id;
    
    
/*
    계층형 쿼리
*/
SELECT level, category_id, LPAD(' ', 2*(level-1)) || category_name  as category_name,
    super_id, CONNECT_BY_ISLEAF ISLEAF
    FROM categorys
    START WITH super_id IS NULL
    CONNECT BY PRIOR category_id = super_id
    ORDER SIBLINGS BY category_id ASC;
    
INSERT INTO books(
    BOOK_CODE
    , TITLE
    , AUTHOR
    , PRICE
    , STOCK
    , REG_DATE
    , PUBLISHER
    , PUBLISH_DATE
    , IMAGE_PATH
    , RATING
    , RATING_CNT
    , DELETE_STATUS)
    VALUES(book_seq.nextval, '종이여자', '기욤 뮈소', 15860, 1200,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/종이여자.jpeg'
    ,8, 1, 0); 

INSERT INTO book_board(
    BOARD_ID
    , CONTEXT
    , READCNT
    , BOOK_CODE
    , CATEGORY_ID
    , DELETE_STATUS)
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 3, 0);


INSERT INTO books
    VALUES(book_seq.nextval, '구해줘', '기욤 뮈소', 15130, 1500,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/구해줘.jpeg'
    ,7, 1, 0); 
    

INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 3, 0);
    
INSERT INTO books
    VALUES(book_seq.nextval, '센트럴 파크', '기욤 뮈소', 15130, 1350,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/센트럴파크.jpeg'
    ,9, 1, 0); 


INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 3, 0);
    
INSERT INTO books
    VALUES(book_seq.nextval, '브루클린의 소녀', '기욤 뮈소', 15000, 1350,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/브루클린의_소녀.jpeg'
    ,9, 1, 0); 

INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 3, 0);
    
INSERT INTO books
    VALUES(book_seq.nextval, '제0호', '움베르토 에코', 15000, 1350,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/제0호.jpeg'
    ,9, 1, 0); 

INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 6, 0);
    

INSERT INTO books
    VALUES(book_seq.nextval, '12가지 인생의 법칙', '조던 B. 피터슨', 15000, 1350,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/12가지_인생의_법칙.jpg'
    ,9, 1, 0);
    

INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 6, 0);
    
INSERT INTO books
    VALUES(book_seq.nextval, '트렌드 코리아 2019', '김난도, 이준영 외 7명', 15000, 1350,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/트렌드_코리아_2019.jpg'
    ,9, 1, 0); 


INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 5, 0);
    
INSERT INTO books
    VALUES(book_seq.nextval, '걷는 사람, 하정우', '하정우', 13900, 1350,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/걷는_사람_하정우.jpg'
    ,9, 1, 0); 

INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 5, 0);

INSERT INTO books
    VALUES(book_seq.nextval, '고요할수록 밝아지는 것들', '혜민 저', 13500, 1350,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/고요할수록_밝아지는_것들.jpg'
    ,9, 1, 0); 
    
INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 5, 0);
    
INSERT INTO books
    VALUES(book_seq.nextval, '아가씨와 밤', '기욤 뮈소', 13050, 1350,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/아가씨와_밤.jpg'
    ,9, 1, 0); 
    
INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 3, 0);

INSERT INTO books
    VALUES(book_seq.nextval, '당신이 옳다', '정혜신', 14220, 1350,  SYSDATE, '밝은세상'
    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/당신이_옳다.jpg'
    ,9, 1, 0); 

INSERT INTO book_board
    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 5, 0);

commit;


-- 책장( 책 게시판) 총 개수 구하기
SELECT COUNT(*) as cnt FROM book_board;


-- 책 1권 조회
SELECT
        ROWNUM as rnum
        , board_id      -- 게시판 id
        , context       -- 내용
        , readcnt       -- 조회수
        , book_code     -- 책코드
        , title         -- 책 제목
        , author        -- 저자
        , price         -- 가격
        , stock         -- 수량
        , publisher     -- 출판사
        , publish_date  -- 출판일
        , reg_date      -- 등록일
        , image_path    -- 이미지 경로
        , rating        -- 평점
        , delete_status -- 삭제여부
        , category_id   -- 카테고리 id
        , category_name -- 카테고리 이름
        , super_id      -- 상위 카테고리 id
        , super_name    -- 상위 카테고리 이름
        FROM(SELECT 
            board_id, board.context, board.readcnt, b.book_code, b.title, b.author, b.price, b.stock, b.publisher, b.publish_date, b.reg_date
            , b.image_path, b.rating, b.delete_status, c.category_id, c.category_name, c.super_id
            , super.category_name as super_name
            FROM (SELECT * FROM book_board
                WHERE delete_status <> 1
                ORDER BY board_id DESC                
                ) board 
            JOIN books b ON board.book_code = b.book_code 
            JOIN categorys c ON c.category_id = board.category_id JOIN categorys super ON c.super_id = super.category_id
            WHERE board.board_id = 11
            ORDER BY reg_date DESC, title ASC);

-- 책목록 조회
SELECT *
    FROM(
    SELECT
        ROWNUM as rnum
        , board_id      -- 게시판 id
        , context       -- 내용
        , readcnt       -- 조회수
        , book_code     -- 책코드
        , title         -- 책 제목
        , author        -- 저자
        , price         -- 가격
        , stock         -- 수량
        , publisher     -- 출판사
        , publish_date  -- 출판일
        , reg_date      -- 등록일
        , image_path    -- 이미지 경로
        , rating        -- 평점
        , delete_status -- 삭제여부
        , category_id   -- 카테고리 id
        , category_name -- 카테고리 이름
        , super_id      -- 상위 카테고리 id
        , super_name    -- 상위 카테고리 이름
        FROM(SELECT 
            board_id, board.context, board.readcnt, b.book_code, b.title, b.author, b.price, b.stock, b.publisher, b.publish_date, b.reg_date
            , b.image_path, b.rating, b.delete_status, c.category_id, c.category_name, c.super_id
            , super.category_name as super_name
            FROM (SELECT * FROM book_board
                WHERE delete_status <> 1
                ORDER BY board_id DESC                
                ) board 
            JOIN books b ON board.book_code = b.book_code 
            JOIN categorys c ON c.category_id = board.category_id JOIN categorys super ON c.super_id = super.category_id
            ORDER BY reg_date DESC, title ASC)
    )
    WHERE rnum >= 1 AND rnum <= 5;


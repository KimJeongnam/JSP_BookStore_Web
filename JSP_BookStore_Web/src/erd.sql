
/* Drop Tables */

DROP TABLE recomments CASCADE CONSTRAINTS;
DROP TABLE book_board CASCADE CONSTRAINTS;
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
	category_id nvarchar2(50) NOT NULL,
	delete_status number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (board_id)
);


CREATE TABLE categorys
(
	category_id nvarchar2(50) NOT NULL,
	category_name nvarchar2(50) NOT NULL UNIQUE,
	super_id nvarchar2(50) NOT NULL,
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
	restep number DEFAULT 0,
	redepth number DEFAULT 0,
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


update users SET accpet_status=1 WHERE user_id='root';

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
    
update users SET accpet_status=1 WHERE user_id='tester';
    
commit;

SELECT COUNT(*) FROM users WHERE user_id='hong1';

delete FROM users WHERE user_id='kim910712';


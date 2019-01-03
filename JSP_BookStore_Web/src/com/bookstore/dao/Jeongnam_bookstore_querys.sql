
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
    
-- 관리자 계정 생성
--insert into users(
--    USER_ID
--    , USER_PW
--    , NAME
--    , SSN
--    , EMAIL
--    , ZIPCODE
--    , ADDRESS1
--    , ADDRESS2
--    , PHONE_NUMBER
--    , HIRE_DATE
--    , DELETE_STATUS
--    , PERMISSION)
--    values('root', '1q2w3e4r5t', '관리자', '000000-0000000',
--    'none@none.none', '000-000', 'NONE', 'NONE', 'NONE', SYSDATE, 0, 'admin');

-- 이메일 인증 update
--update users SET accept_status=1 WHERE user_id='root';
--

-- 테스트 계정 생성
--insert into users(
--    USER_ID
--    , USER_PW
--    , NAME
--    , SSN
--    , EMAIL
--    , ZIPCODE
--    , ADDRESS1
--    , ADDRESS2
--    , PHONE_NUMBER
--    , HIRE_DATE
--    , DELETE_STATUS
--    , PERMISSION)
--    values('tester', '1234', 'tester1', '000000-0000001',
--    'none@none.none', '000-000', 'NONE', 'NONE', 'NONE', SYSDATE, 0, 'customer');
--    
--update users SET accept_status=1 WHERE user_id='tester';
--    
--commit;


--
--SELECT COUNT(*) FROM users WHERE user_id='hong1';
--
--delete FROM users WHERE user_id='kim910712';
--
--DROP SEQUENCE category_seq;
--DROP SEQUENCE book_seq;
--DROP SEQUENCE board_seq;
--
--CREATE SEQUENCE category_seq
--    START WITH 1
--    INCREMENT BY 1
--    MAXVALUE 9999999;
--
--CREATE SEQUENCE book_seq
--    START WITH 1
--    INCREMENT BY 1
--    MAXVALUE 9999999;
--    
--
--CREATE SEQUENCE board_seq
--    START WITH 1
--    INCREMENT BY 1
--    MAXVALUE 9999999;

--
--insert into categorys(category_id, category_name) values(category_seq.nextval, '국내');
--
--insert into categorys(category_id, category_name) values(category_seq.nextval, '해외');
--
--insert into categorys(category_id, category_name, super_id) values(category_seq.nextval, '소설', 2);
--
--insert into categorys(category_id, category_name, super_id) values(category_seq.nextval, '소설', 1);
--insert into categorys(category_id, category_name, super_id) values(category_seq.nextval, '문학', 1);
--insert into categorys(category_id, category_name, super_id) values(category_seq.nextval, '문학', 2);

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


-- 책 추가 쿼리
-- 1. book 테이블에 데이터 추가
--INSERT INTO books(
--    BOOK_CODE
--    , TITLE
--    , AUTHOR
--    , PRICE
--    , STOCK
--    , REG_DATE
--    , PUBLISHER
--    , PUBLISH_DATE
--    , IMAGE_PATH
--    , RATING
--    , RATING_CNT
--    , DELETE_STATUS)
--    VALUES(book_seq.nextval, '종이여자', '기욤 뮈소', 15860, 1200,  SYSDATE, '밝은세상'
--    , TO_DATE('2010-12-15', 'YYYY-MM-DD'), '/JSP_BookStore_Web/images/종이여자.jpeg'
--    ,8, 1, 0); 
--
-- 2. book_board 테이블에 데이터 추가 
--INSERT INTO book_board(
--    BOARD_ID
--    , CONTEXT
--    , READCNT
--    , BOOK_CODE
--    , CATEGORY_ID
--    , DELETE_STATUS)
--    VALUES(board_seq.nextval, ' ', 0, book_seq.currval, 3, 0);
--
--commit;


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


/*
    ON 조건을 만족하면 WHEN MATCHED THEN 실행
    만족하지 못하면 WHEN NOT MATCHED THEN 실행
    
    장바구니에 해당 user_id와 book_code가 이미 있다면 wish_stock에 수량을 더하며
    없다면 새로 추가하는 query
*/
MERGE INTO carts c
USING ( SELECT 'tester' user_id, 1 book_code, 10 wish_stock   -- USING절에 뷰가 올수 있다.
        FROM dual) s
ON ( c.user_id = s.user_id 
    AND c.book_code = s.book_code)
WHEN MATCHED THEN
  UPDATE SET c.wish_stock = c.wish_stock + s.wish_stock
  WHERE c.wish_stock+s.wish_stock <= (SELECT stock FROM books WHERE book_code = s.book_code)
WHEN NOT MATCHED THEN
    INSERT (c.user_id, c.book_code, c.wish_stock)
    VALUES (s.user_id, s.book_code, s.wish_stock)
    WHERE s.wish_stock <= (SELECT stock FROM books WHERE book_code = s.book_code);
    
-- 'tester'계정이 추가한 장바구니 조회
SELECT c.book_code
    , board.board_id
    , b.image_path
    , b.title 
    , b.author
    , b.price
    , c.wish_stock
    , b.price*c.wish_stock as total_price
    FROM carts c JOIN books b
    ON c.book_code = b.book_code 
    JOIN book_board board
    ON b.book_code = board.book_code
    WHERE c.user_id = 'tester';
    
    
-- 'tester' 계정의 장비구니의 총 금액
SELECT SUM(b.price*c.wish_stock ) as total_price
    FROM carts c JOIN books b
    ON c.book_code = b.book_code 
    WHERE c.user_id = 'tester';
    
DELETE FROM carts WHERE user_id = 'tester' AND book_code=4;

rollback;


-- 주문 시 발생하는 트리거
drop trigger trigger_insert_orderinfo;

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trigger_insert_orderinfo
    AFTER INSERT
    ON order_info
    FOR EACH ROW
BEGIN
    if inserting then
        DBMS_OUTPUT.PUT_LINE('insert Trigger 발생');
        
        UPDATE orders SET
            total_price = total_price+(SELECT price*:new.buy_stock                     
                                        FROM books
                                        WHERE book_code = :new.book_code)
            WHERE order_code = :new.order_code;
    end if;
END;
/

-- 구매 요청 후 책 수량 트리거-- 
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trigger_updatebooks
    AFTER INSERT
    ON order_info
    FOR EACH ROW
BEGIN
    if inserting then
        DBMS_OUTPUT.PUT_LINE('insert Trigger 발생');
        
        UPDATE books SET
            stock = stock-:new.buy_stock                     
            WHERE book_code = :new.book_code;
    end if;
END;
/

--drop trigger trigger_deletecarts;
--SET SERVEROUTPUT ON
--CREATE OR REPLACE TRIGGER trigger_deletecarts
--    AFTER INSERT
--    ON order_info
--    FOR EACH ROW
--BEGIN
--    if inserting then
--        DBMS_OUTPUT.PUT_LINE('insert Trigger 발생');
--        
--        DELETE FROM carts WHERE book_code=:new.book_code
--            AND user_id = (SELECT user_id FROM orders WHERE order_code=:new.order_code);
--            
--    end if;
--END;
--/

-- orders 컬럼 삭제시 orders컬럼 삭제 전에 발생하는 트리거 로서 자식 테이블을 모두 지운다.
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trigger_delete_ordersbefore
    BEFORE DELETE
    ON orders
    FOR EACH ROW
BEGIN    
    DBMS_OUTPUT.PUT_LINE('order delete before Trigger 발생');
        
    DELETE FROM order_info
        WHERE order_code = :old.order_code;
    
END;
/


-- order_info 컬럼 삭제시 발생하는 트리거로 컬럼이 지워지면 books에있는 book_code의 수량을 다시 채운다.
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trigger_delete_orderinfo
    AFTER DELETE
    ON order_info
    FOR EACH ROW
BEGIN    
    DBMS_OUTPUT.PUT_LINE('order_info delete Trigger 발생');
        
    UPDATE books 
        SET stock = stock+:old.buy_stock
        WHERE book_code = :old.book_code;
END;
/


--ORDER_CODE	VARCHAR2(40 BYTE)
--USER_ID	NVARCHAR2(20 CHAR)
--STATUS	NVARCHAR2(20 CHAR)
--ORDER_DATE	TIMESTAMP(6)
--REFUND_DATE	TIMESTAMP(6)
--TOTAL_PRICE	NUMBER
-- 주문 Insert
INSERT INTO orders(
    order_code
    , user_id
    , status
    , order_date
    , total_price)
    VALUES('code1', 'tester' , 'BUY_ASK', SYSDATE, 0);
    
--ORDER_CODE
--BOOK_CODE
--BUY_STOCK
INSERT INTO order_info(
    order_code
    , book_code
    , buy_stock)
    VALUES('code1', 1, 3);
rollback;


-- 주문 조회 (고객)
SELECT order_code
    , order_date
    , (SELECT COUNT(*) FROM order_info WHERE order_code=o.order_code) as cnt
    , total_price
    , status
    FROM orders o 
    WHERE user_id='tester'
    group by order_code, order_date, total_price, status;

-- 주문 조회 (관리자) 주문 요청
SELECT order_code
    , order_date
    , user_id
    , (SELECT COUNT(*) FROM order_info WHERE order_code=o.order_code) as cnt
    , total_price
    , status
    FROM orders o
    WHERE status = 'BUY_ASK'
    group by order_code, order_date, user_id, total_price, status;
    
-- 주문 상세 조회
SELECT oi.order_code
    , bb.board_id
    , oi.book_code
    , oi.buy_stock
    , b.title
    , b.author
    , b.price
    , b.image_path
    , b.price*oi.buy_stock total_price
    FROM order_info oi JOIN books b
    ON oi.book_code = b.book_code
    JOIN book_board bb
    ON b.book_code = bb.book_code
    WHERE oi.order_code = 'b37edc3a-a23a-4d0e-9291-35017dcabfc3';

-- 주문 요청, 환불 요청 건수, 어제 판매액, 오늘 판매액
SELECT (SELECT COUNT(*) FROM orders WHERE status = 'BUY_ASK') buyAskCnt
    , (SELECT COUNT(*) FROM orders WHERE status = 'REFUND_ASK') refundAskCnt
    , NVL((SELECT SUM(total_price) 
        FROM orders 
        WHERE status = 'BUY_CONFIRM'
        AND TO_CHAR(order_date, 'YYYY/MM/DD') = (SELECT 
                            TO_CHAR(SYSDATE-1, 'YYYY/MM/DD') yesterday
                            FROM DUAL)
        ), 0) yesterday_totalPrice
    , NVL((SELECT SUM(total_price) FROM orders
        WHERE status = 'BUY_CONFIRM'
        AND TO_CHAR(order_date, 'YYYY/MM/DD') >= (SELECT
                            TO_CHAR(SYSDATE, 'YYYY/MM/DD') today
                            FROM DUAL)
        ), 0) today_totalPrice
    , NVL((SELECT SUM(total_price) FROM orders WHERE status = 'BUY_CONFIRM'), 0) all_price
    FROM dual;
    
--UPDATE orders SET
--    status = 'BUY_ASK';
--
--commit;
    
-- 어제 일자, 오늘 일자
SELECT 
    TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYY/MM/DD') yesterday 
    , TO_CHAR(SYSDATE, 'yyyy/mm/dd') today
    FROM dual;


SELECT SUM(total_price) FROM orders
        WHERE status = 'BUY_CONFIRM'
        AND order_date >= (SELECT
                            TO_DATE(SYSDATE, 'yyyy-mm-dd HH:mi:ss')-1
                            FROM DUAL)
        AND order_date < (SELECT
                            TO_DATE(SYSDATE, 'yyyy-mm-dd HH:mi:ss') today
                            FROM DUAL);
                            
-- 통계 쿼리
SELECT *  
    FROM
    (SELECT ROWNUM as rnum, total, dt
        FROM
        (SELECT SUM(total_price) total, TO_CHAR(order_date, 'YYYY-MM') as dt
            FROM orders
            WHERE status='BUY_CONFIRM'
            GROUP BY TO_CHAR(order_date, 'YYYY-MM')
            ORDER BY TO_CHAR(order_date, 'YYYY-MM') ASC))
    WHERE rnum >= 1 AND rnum <= 12;

--, NVL((SELECT SUM(total_price) FROM orders
--    WHERE status='BUY_CONFIRM'
--    AND TO_CHAR(order_date, 'YYYY/MM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYY/MM')), 0) one
--    ,  NVL((SELECT SUM(total_price) FROM orders
--    WHERE status='BUY_CONFIRM'
--    AND TO_CHAR(order_date, 'YYYY/MM') = TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'YYYY/MM')), 0) two
--    ,  NVL((SELECT SUM(total_price) FROM orders
--    WHERE status='BUY_CONFIRM'
--    AND TO_CHAR(order_date, 'YYYY/MM') = TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'YYYY/MM')), 0) three

SELECT SUM(total_price) as one FROM orders
    WHERE status='BUY_CONFIRM'
    AND TO_CHAR(order_date, 'YYYY/MM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYY/MM');
    
--UPDATE orders SET
--    status='REFUND_ASK'
--    WHERE order_code = ?

DELETE FROM orders where order_code = '8ea99597-3298-4328-b0a7-1be1f3bd7613';

rollback;
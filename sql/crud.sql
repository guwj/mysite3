-- users

-- insert

INSERT INTO users
     VALUES (user_seq.NEXTVAL,
             '김용준',
             'guwj@naver.com',
             '1234',
             'male');

-- delete

DELETE FROM users;

COMMIT;

-- select ( login )

SELECT no, name
  FROM users
 WHERE email = 'guwj@naver.com' AND password = '1234';

SELECT * FROM users;

select * from board;

-- board

-- view

SELECT no, title, content
  FROM board
 WHERE no = 5;

UPDATE board
   SET hit = hit + 1
 WHERE no = 5; -- 조회수 늘리기

-- list

SELECT COUNT (*) FROM board;

SELECT *
  FROM (SELECT ROWNUM AS rn,
               no,
               title,
               hit,
               reg_date,
               name,
			   users_no
          FROM (  SELECT a.no,
                         a.title,
                         a.hit,
                         TO_CHAR (a.reg_date, 'yyyy-mm-dd hh:mi:ss')
                            AS reg_date,
                         b.name,
						 a.users_no
                    FROM board a, users b
                   WHERE a.users_no = b.no
                -- AND title LIKE '%kwd%' OR content LIKE '%kwd%' --
                ORDER BY group_no DESC, order_no ASC))
 WHERE (1 - 1) * 5 + 1 <= rn AND rn <= 1 * 5;  -- 페이지 사이즈가 5인 경우(2는 현재 페이지)

-- 새 글 insert

INSERT INTO board
     VALUES (board_seq.NEXTVAL,
             '안녕',
             '안녕하십니까',
             SYSDATE,
             0,
             NVL ( (SELECT MAX (group_no) FROM board), 0) + 1,
             1,
             0,
             5);
			 
insert into board values( board_seq.nextval, :var1, :var2, :var3, :var4, :var5, :var6, :var7);


SELECT MAX (group_no) FROM board;

-- 답글

UPDATE board
   SET order_no = order_no + 1
 WHERE group_no = 2 AND order_no > 2; -- 부모 글 순서

 -- 짜장면 먹자는 글에 대해 답글을 단 경우

INSERT INTO board
     VALUES (board_seq.NEXTVAL,
             '짬뽕 먹자',
             '냉무',
             SYSDATE,
             0,
             2,                                       -- 답글이므로 부모글의 그룹 번호를 받는다
             3,                                                  -- 부모글 순서 + 1
             2,                                                  -- 부모글 깊이 + 1
             5);


COMMIT;
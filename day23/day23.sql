-- 7.
-- 다음 조건을 만족하는 테이블 생성 DDL을 작성하십시오.
--
-- 테이블 명 : board
--
-- 테이블에 대한 이해 : 게시판 정보를 가지는 테이블
--
-- 칼럼명:
-- board_seq	    (게시물 번호) 정수 최대 10자리,
-- board_title	    (게시물 제목) 문자 가변 자릿수 255자리,
-- board_contents   (게시물 내용) 문자 가변 자릿수 4000자리
-- board_writer     (게시물 작성자) 문자 가변 자릿수 100자리,
-- board_date       (게시물 작성시간) 날짜,
-- board_viewcount  (게시물 조회수) 정수 최대 6자리,
-- board_password   (게시물 암호) 문자 가변 자릿수 20자리,
--
-- 제약조건 :  board_seq : 기본 키(Primary Key)  제약 조건명은 BOARD_SEQ_PK
--  board_title :  값이 반드시 존재(NOT NULL)
--  board_writer : Member 테이블의 member_id 컬럼 참조
--
-- (Member  테이블
-- member_id 문자 가변 자릿수 100자리
--            primary key 라고 가정합니다)
create table member
(
    member_id   number(3)
        constraint member_member_id_pk primary key,
    member_name varchar2(20) not null
);

create table board
(
    board_seq       number(10)
        constraint BOARD_SEQ_PK primary key,
    board_title     varchar2(255) not null,
    board_contents  varchar2(4000),
    board_writer    number(3)
        constraint board_writer_fk references member (member_id),
    board_date      date,
    board_viewcount number(6)
        constraint board_viewcount_ch check (board_viewcount > 0),
    board_password  varchar2(20),
    board_image     varchar2(100)
        constraint board_image_unique unique
);
-- 7 test
select *
from board;

insert into board(board_seq, board_title)
values (1, '목요일');

insert into board(board_seq, board_title, board_contents)
values (2, 'aa', '날씨가 좋아요');

insert into board(board_seq, board_title, board_contents)
values (3, 'aa', '날씨가 좋아요');

insert into board(board_seq, board_title, board_contents, board_writer)
values (4, 'aa', '날씨가 좋아요', 100); -- 오류
insert into member
values (100, '배대장');
insert into board(board_seq, board_title, board_contents, board_writer)
values (4, 'aa', '날씨가 좋아요', 100); -- 멤버id가 생겼으므로 성공

insert into board(board_seq, board_title, board_contents, board_writer, board_date)
values (5, 'aa', '날씨가 좋아요', 100, '2021-12-31');

insert into board(board_seq, board_title, board_contents, board_writer, board_date, board_viewcount)
values (6, 'aa', '날씨가 좋아요', 100, '2021-12-31', 0); -- check에서 board_viewcount > 0이므로 오류
insert into board(board_seq, board_title, board_contents, board_writer, board_date, board_viewcount)
values (6, 'aa', '날씨가 좋아요', 100, '2021-12-31', 1);

insert into board(board_seq, board_title, board_contents, board_writer, board_date, board_viewcount, board_password)
values (7, 'aa', '날씨가 좋아요', 100, '2021-12-31', 1, '1234');

insert into board
values (8, 'aa', '날씨가 좋아요', 100, '2021-12-31', 1, '1234', 'image/logo.png');
insert into board
values (8, 'aa', '날씨가 좋아요', 100, '2021-12-31', 1, '1234', 'image/logo.png'); -- 유니크므로 오류
insert into board
values (9, 'aa', '날씨가 좋아요', 100, '2021-12-31', 1, '1234', 'image/logo2.png');
-- 성공

-- constraint(제약조건) 확인
select *
from USER_CONSTRAINTS
where TABLE_NAME = 'BOARD';

select *
from USER_CONS_COLUMNS
where table_name = 'BOARD';

--------------------------------------------------------------------------

-- DDL (Data Definition Language) : create, alter, drop, rename ...
-- DML (Data Manipulation Language) : insert, delete, update, merge
-- DQL (Data Query Language) : select
-- table 제약조건 : not null, primary key, unique, check, reference key(foreign key)

--------------------------------------------------------------------------

-- Review
-- DML
insert into 테이블(칼럼리스트)
values (값리스트);

update 테이블
set 칼럼 = 값,
    칼럼 = 값,
    칼럽 = 값
where 조건문;

delete
from 테이블
where 조건문;

---------------------------------------------------------------------------
-- CRUD 연습(JDBCEducation day23(MVC))
desc EMPLOYEES;
-- -- EMPLOYEE_ID
-- -- FIRST_NAME
-- -- LAST_NAME
-- -- EMAIL
-- -- PHONE_NUMBER
-- -- HIRE_DATE
-- -- JOB_ID
-- -- SALARY
-- -- COMMISSION_PCT
-- -- MANAGER_ID
-- -- DEPARTMENT_ID

-- CRUD: Update
update EMPLOYEES
set FIRST_NAME     = ?,
    LAST_NAME      = ?,
    EMAIL          = ?,
    PHONE_NUMBER   = ?,
    HIRE_DATE      = ?,
    JOB_ID         = ?,
    SALARY         = ?,
    COMMISSION_PCT = ?,
    MANAGER_ID     = ?,
    DEPARTMENT_ID  = ?
where EMPLOYEE_ID = ?;

-- CRUD: Delete
delete
from EMPLOYEES
where EMPLOYEE_ID = ?;

select *
from EMPLOYEES;

--------------------------------------------------------------
-- View (가상 테이블)
-- SQL문을 간단히 하고자하는 경우 사용, 보안상 사용
-- table을 보기위한 창의 역할

-- View 만들기
create
[or replace] [force | noforce] view view_name (alias, alias, alias...)
as subquery
[
with check option]
[with read only];

create table emp_backup -- 실습을 위한 백업
as
select *
from EMPLOYEES;

-- emp_backup_view 생성
create view emp_backup_view
as
select *
from emp_backup
where DEPARTMENT_ID = 60;

-- emp_backup_view 재생성 (create or replace)
create or replace view emp_backup_view
as
select *
from emp_backup
where DEPARTMENT_ID = 60;

-- 조회
select *
from emp_backup_view;

-- 만들어진 view 조회
select *
from user_views;

-- emp_backup_view2
create or replace view emp_backup_view2
as
select EMPLOYEE_ID, FIRST_NAME, SALARY
from emp_backup
where DEPARTMENT_ID = 60;

select *
from emp_backup_view2;

-- view 수정
select *
from emp_backup_view2
where SALARY > 5000;
-- 103	Alexander	9000.00
-- 104	Bruce	6000.00

-- view를 통해서 원 테이블 수정 가능
update EMP_BACKUP_VIEW2
set SALARY = 10000
where SALARY > 5000;

select *
from emp_backup;
-- 103	Alexander	Hunold	AHUNOLD	590.423.4567	2006-01-03 00:00:00	IT_PROG	10000.00
-- 104	Bruce	Ernst	BERNST	590.423.4568	2007-05-21 00:00:00	IT_PROG	10000.00

-- 뷰의 종류
단순 뷰: 하나의 테이블로 생성, 그룹 함수의 사용이 불가능, DISTINCT 사용 불가능, DML 사용 가능
복합 뷰: 여러 개의 테이블로 생성, 그룹 함수의 사용이 가능, DISTINCT 사용 가능, DML 사용 불가능

-- emp_backup_view3
create or replace view emp_backup_view3
            (직원번호, 직원이름, 급여) -- 칼럼 이름 변경 가능
as
select EMPLOYEE_ID, FIRST_NAME, SALARY
from emp_backup
where DEPARTMENT_ID = 60;

select *
from emp_backup_view3
where 급여 > 5000;

update EMP_BACKUP_VIEW3
set 급여 = 20000
where 급여 >= 10000;

-- 그룹함를 사용한 단순 뷰
create or replace view emp_backup_view_groupby
as
select DEPARTMENT_ID, avg(SALARY) sal_avg
from emp_backup
group by DEPARTMENT_ID;

select *
from emp_backup_view_groupby;
-- join 가능
select DEPARTMENT_ID, sal_avg
from emp_backup_view_groupby
         join DEPARTMENTS using (department_id);

-- emp_backup_view_groupby 수정 불가능 : group by를 사용하면 DML 불가능
update emp_backup_view_groupby
set sal_avg = sal_avg * 1.1;
-- 원본이 없기 때문에 불가능

-- 뷰 삭제
-- 뷰는 실체가 없는 가상 테이블이기 때문에 USER_VIEWS 데이터 딕셔너리에 저장되어 있는 정의를 삭제하는 것을 의미
DROP VIEW VIEW_NAME

-- view force option
create or replace force view emp_backup_view_groupby
as
select DEPARTMENT_ID, avg(SALARY) sal_avg
from emp_backup2 -- emp_backup2는 없지만 추후에 정의한다는 가정으로 force 옵션 사용
group by DEPARTMENT_ID;

select *
from emp_backup_view_groupby; -- emp_backup2는 없으므로 안보임 하지만 VIEW는 생성되있음

select *
from USER_VIEWS; -- 정의된 view 확인
EMP_BACKUP_VIEW_GROUPBY	168

create table emp_backup2 -- emp_backup2 생성
as
select *
from EMPLOYEES;

select *
from emp_backup_view_groupby;
-- emp_backup2를 생성하였으므로 조회가능

-- with check option: 값 변경 못하게 하는 옵션
create or replace view emp_backup_60
as
select *
from emp_backup
where DEPARTMENT_ID = 60;

select *
from emp_backup_60;

update emp_backup_60
set DEPARTMENT_ID = 30;

select *
from emp_backup_60;
-- 위와 같이하면 부서id가 변경되었으므로 emp_backup_60 뷰가 의미 없어짐

-- 그러므로 with check option을 사용하여 변경 못하게 할 수 있음
create or replace view emp_backup_30
as
select *
from emp_backup
where DEPARTMENT_ID = 30
with check option;

select *
from emp_backup_30;

update emp_backup_30
set DEPARTMENT_ID = 60; -- with check option으로 불가능

update emp_backup_30
set SALARY = 10000;
-- 해당 with check option이 없으므로 가능

-- with read only: 읽기 전용 옵션
create or replace view emp_backup_30
as
select *
from emp_backup
where DEPARTMENT_ID = 30
with read only;

-- 자신의 부서의 평균급여보다 더 적은 급여를 받는 직원 조회
create or replace view emp_dept_avg
as
select DEPARTMENT_ID, avg(SALARY) sal_avg
from EMPLOYEES
group by DEPARTMENT_ID;

select FIRST_NAME, SALARY, sal_avg
from EMPLOYEES
         join emp_dept_avg using (DEPARTMENT_ID)
where SALARY < sal_avg;

-- inline view 이용
select FIRST_NAME, SALARY, aa.sal_avg
from EMPLOYEES
         join (select DEPARTMENT_ID, avg(SALARY) sal_avg
               from EMPLOYEES
               group by DEPARTMENT_ID) aa using (DEPARTMENT_ID)
where SALARY < aa.sal_avg;
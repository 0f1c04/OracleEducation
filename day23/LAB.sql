-- conn hr/hr
-- 1.
-- 2007년 입사한(hire_date) 직원들의 사번(employee_id), 이름(first_name),
-- 성(last_name), 부서명(department_name)을 조회하려 합니다.
-- 임시 테이블 용도로 사용하는 Object를 생성합니다.
-- ==>emp_2007_details
-- 이때, 부서에 배치되지 않은 직원의 경우, '<NOT ASSIGNED>'로 보여줍니다.
create or replace view emp_2007_details
    (사번, 이름, 성, 부서)
as
select employee_id,
       first_name,
       last_name,
       nvl(department_name, '<NOT ASSIGNED>')
from employees e,
     departments d
where substr(hire_date, 1, 2) = '07'
  and d.department_id(+) = e.department_id;

select *
from emp_2007_details;

-- ========================================
-- 2.
-- 기존 EMPLOYEES 테이블에 있는 레코드들 중, 'Marketing'부서에 근무하는 직원 레코드를
--   이용하여 EMPLOYEES_MARKETING 테이블을   만들기 위한 DDL을 작성하십시오.
--   단, EMPLOYEES_MARKETING 테이블의 키는   없어도 관계없습니다.
create table EMPLOYEES_MARKETING as
select *
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID
                       from DEPARTMENTS
                       where lower(DEPARTMENT_NAME) like '%marketing%');

select *
from EMPLOYEES_MARKETING;

-- ========================================
-- 3.
-- 인사관리를 위하여 현재 직원정보에 대한 백업테이블을 생성하여 보관하기로 합니다.
-- 새로 생성하는 백업테이블명은 "EMPLOYEES_BACKUP" 이며 기존테이블(EMPLOYEES)의 Index,
-- Constraint는 필요로 하지 않습니다. 단 급여(Salary)가 5000을 초과하는 직원만 백업테이블 내에 존재해야 합니다.
-- 위 설명에 해당하는 테이블을 생성하기 위한 sql 스크립트를 작성하시오.
create table EMPLOYEES_BACKUP
as
select *
from EMPLOYEES
where SALARY > 5000;

commit;

select *
from EMPLOYEES_BACKUP;

-- ========================================
-- 4.
-- 인사관리를 위한 시스템 구축중 지역(Regions), 국가(Countries),
-- 위치(Locations)에 대한 전체 리스트 정보를 빈번하게 사용할 경우가 생겼다.
-- 여러 프로그램에서 매번 반복적으로 사용되며 일부 개발자의 경우 잘못된
-- 조인으로 올바른 결과를 가져오지 못하는 경우가 발생하였다.
-- 이를 해결하기 위해 복잡한 질의를 숨기기 위한 논리적 테이블의 용도로
-- 쓰이는 DB Object 를 생성하기로 하였다.
-- DB Object 이름은 LOC_DETAILS_{DB OBJECT명} 을 사용한다.
-- 위 설명에 해당하는 DB Object를 생성하기 위한 sql 스크립트를 작성하라.
create or replace view LOC_DETAILS_view
as
select r.region_id,
       c.country_id,
       l.location_id,
       region_name,
       country_name,
       street_address,
       postal_code,
       city,
       state_province
from REGIONS r,
     COUNTRIES c,
     LOCATIONS l
where r.region_id = c.region_id
  and c.country_id = l.country_id
order by region_id, country_id;

-- 강사님 풀이
create or replace view LOC_DETAILS_view2
as
select CITY, COUNTRY_NAME, REGION_NAME
from LOCATIONS
         join COUNTRIES using (COUNTRY_ID)
         join REGIONS using (REGION_ID);

-- ======================================
-- 5.
-- 사원이 한 명 이상인 부서들에 대해 부서 번호, 부서 이름, 사원 수,
-- 최고 급여, 최저 급여, 평균 급여, 급여 총액을 빈번하게 조회하여야
-- 할 필요가 있어, VIEW를 생성하여 사용하고자 합니다.
-- 생성된 DB Object(VIEW)의 전체 레코드에 대한 조회 결과가 아래와 같이 출력되도록
-- "DEPT_SAL_INFO"라는 VIEW 를 생성하는 sql 스크립트를 작성하십시오.
-- 단, 평균 급여의 소수점 이하는 절사합니다.
--
-- 출력 : DEPT_ID | DEPT_NAME | NUM_EMP | MAX_SAL | MIN_SAL | AVG_SAL | SUM _SAL
CREATE OR REPLACE VIEW DEPT_SAL_INFO
AS
SELECT D.DEPARTMENT_ID,
       DEPARTMENT_NAME,
       COUNT(EMPLOYEE_id) 사원수,
       MAX(SALARY)        "최고 급여",
       MIN(SALARY)        "최저 급여",
       AVG(SALARY)        "평균 급여",
       SUM(SALARY)        "급여 총액"
FROM EMPLOYEES E,
     DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID, DEPARTMENT_NAME
HAVING COUNT(EMPLOYEE_id) >= 1;

-- 강사님 풀이
select DEPARTMENT_ID               DEPT_ID,
       DEPARTMENTS.DEPARTMENT_NAME DEPT_NAME,
       count(*)                    NUM_EXP,
       MAX(SALARY)                 MAX_SAL,
       MIN(SALARY)                 MIN_SAL,
       avg(SALARY)                 AVG_SAL,
       sum(SALARY)                 SUM_SAL
from EMPLOYEES
         join DEPARTMENTS using (DEPARTMENT_ID)
group by DEPARTMENT_ID, DEPARTMENTS.DEPARTMENT_NAME
having count(*) > 1;

-- ========================================
-- 6.
-- Sales 부서에서 Gerald Cambrault 라는 관리자(Manager_id)를 가지는
-- 직원의 정보를 조회하여 employee_sales_Gerald 라는 view를 생성하십시오.
--
-- 사원번호  |  사원명  |  부서명  |  관리자명
create or replace view employee_sales_Gerald
as
select employee_id, department_name, e.manager_id
from employees e,
     departments d
where e.manager_id =
      (select employee_id
       from employees
       where first_name = 'Gerald'
         and last_name = 'Cambrault')
  and department_name = 'Sales'
  and e.department_id = d.department_id;

-- =====================================
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
    board_viewcount number(6),
    board_password  varchar2(20)
);

-- ====================================
-- 8.locations 테이블에서 2000번 이상의 도시코드, 도시명, 국가명, 그 도시에 있는
--  부서명을 조회하여 citycode_gt_2000 라는 이름의 view를  생성하는 SQL 문장을 작성하시오.
-- 단, citycode_gt_2000 view는 변경 가능하도록 생성합니다.
--
-- LOCATION_ID	  CITY	  COUNTRY_NAME	  DEPARTMENT_NAME

create or replace view citycode_gt_2000 (LOCATION_ID, CITY, COUNTRY_NAME, DEPARTMENT_NAME)
as
select location_id, city, country_name, department_name
from locations
         join departments using (location_id)
         join countries using (country_id)
where location_id >= 2000;

------------------------------------------------------------------
-- 시퀀스(SEQUENCE): 자동 번호 발생기, table과 무관, 여러테이블이 공유가능
-- 시퀀스 정보보기
DESC USER_SEQUENCES;

select *
from USER_SEQUENCES;

-- 시퀀스 생성
select *
from board; -- BOARD_SEQ 시퀀스가 존재

create sequence board_no_sequence
    start with 10; -- 10부터 시작하는 board_no_sequence 생성

select board_no_sequence.nextval
from dual;

desc board;

insert into board (BOARD_SEQ, BOARD_TITLE)
values (board_no_sequence.nextval, '게시타이틀');

select *
from board;
-------
drop sequence board_no_sequence;

create sequence board_no_sequence
    start with 100
    cache 100;

insert into board (BOARD_SEQ, BOARD_TITLE)
values (board_no_sequence.nextval, '게시타이틀');

select *
from board;
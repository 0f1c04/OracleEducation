-- DDL(CREATE)
drop table customer;
create table customer
(
    cust_id   number,
    cust_name varchar2(20),
    gender    char(1),
    gender2   char(10),
    birthday  date,
    year01    interval year (3) to month,
    day01     interval day (3) to second
);

insert into customer
values (1, '홍길동', 'M', '남자', sysdate, interval '36' month(3), interval '100' day(3));
insert into customer
values (2, '홍길동2', 'F', '여자', sysdate, interval '36' month(3), interval '100' day(3));
insert into customer
values (3, '홍길동3', 'M', '남자 ', sysdate, interval '36' month(3), interval '100' day(3));
insert into customer
values (4, '홍길동4      ', 'M', '남자 ', sysdate, interval '36' month(3), interval '100' day(3));
insert into customer
values (5, '홍길동4', 'M', '남자 ', sysdate, interval '36' month(3), interval '100' day(3));
-- char: 고정길이, varchar2: 가변길이

select *
from customer;

select *
from customer
where gender2 = '남자';

select cust_name, birthday, birthday + year01, birthday + day01
from customer;


create table emp
(
    empid   number(3),
    empname varchar(20),
    salary  number(9, 2)
);

insert into emp
values (1, '배대장12345678901', 9000000.00);
insert into emp
values (2, '배대장12345678901', 9000000.12);

select *
from emp;


-- 백업(EMPLOYEES > emp2), 구조복사
create table emp2
as
select *
from EMPLOYEES;

create table emp3
as
select *
from EMPLOYEES
where DEPARTMENT_ID = 80;

create table emp4
as
select *
from EMPLOYEES
where 1 = 0; -- 조건이 맞지 않다면 칼럼은 복사되지만 값들은 안됨

create table emp5
as
select EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE
from EMPLOYEES
where 1 = 0; -- 조건은 맞지 않게해서 원하는 칼럼들(구조)만 복사가능

select *
from emp5;

-- DDL(ALTER)
-- ADD column: 추가
-- MODIFY column: 수정
-- DROP column: 삭제
alter table emp5
    add (deptid number, address varchar2(100)); -- 추가

alter table emp5
    modify (deptid number(3), address varchar2(50)); -- 수정(이름은 못바꿈)

alter table emp5
    drop (deptid); -- 삭제

alter table emp5
    add (dept_id number(3)); -- 추가

select *
from emp5;

-- DDL(DROP)
drop table emp5;

-- TRUCATE: row(데이터)만 날리기
select *
from emp3;

truncate table emp3;

-- RENAME: 이름 변경
RENAME emp4 to tbl_emp4;

select *
from tbl_emp4;

-- 데이터 딕셔너리(시스템 테이블), 데이터 딕셔너리 뷰
desc USER_TABLES;

-- show user
-- 계정 확인
show user;


-------------------------------------------------------------


-- DML (INSERT)
create table customer2
(
    cust_id   number,
    cust_name varchar2(20),
    gender    char(1),
    gender2   char(10),
    birthday  date
);

insert into customer2
values (1, 'aa', 'M', '남자', sysdate);

insert into customer2
values (2, 'aa', 'M', '남자'); -- 오류 (values 수가 맞지 않음)

insert into customer2(cust_id, cust_name, gender, gender2)
values (2, 'aa', 'M', '남자'); -- 요건 됨 (넣지 않은 칼럼 데이터 값은 null)

select *
from customer2;

create table emp_backup
as
select employee_id, first_name, salary, hire_date
from employees
where department_id = 10;

-- insert문의 subquery
insert into emp_backup
select employee_id, first_name, salary, hire_date
from employees
where department_id = 100;

insert into emp_backup
select location_id, department_name, 0, sysdate
from departments;

select *
from emp_backup;

-- 다중 입력
create table emp_basic as
select employee_id, first_name, salary
from EMPLOYEES
where 1 = 0;

create table emp_addinfo as
select employee_id, first_name, hire_date
from EMPLOYEES
where 1 = 0;

insert all
    into emp_basic
values (employee_id, first_name, salary)
into emp_addinfo
values (employee_id, first_name, hire_date)
select employee_id, first_name, salary, hire_date
from EMPLOYEES;

select *
from emp_basic;

select *
from emp_addinfo;

-- 데이터 삭제
truncate table emp_basic;
truncate table emp_addinfo;
-- 조건 넣어서 다중 입력
insert all
    when employee_id < 110 then
    into emp_basic
values (employee_id, first_name, salary)
    when salary > 10000 then
into emp_addinfo
values (employee_id, first_name, hire_date)
select employee_id, first_name, salary, hire_date
from employees;

select *
from emp_basic;

select *
from emp_addinfo;

-- DML (UPDATE)
update emp_basic
set salary = salary * 0.9;

update emp_basic
set salary = salary * 1.1
where salary >= 10000;

select *
from emp_basic;

-----
update emp_backup
set hire_date = sysdate
where salary > 0;

update emp_backup
set hire_date = '2022-02-22'
where salary = 0;

select *
from emp_backup;

----
-- Luis의 급여는 Jennifer와 같다
update emp_backup
set salary = (select salary
              from emp_backup
              where first_name = 'Jennifer')
where first_name = 'Luis';

select *
from emp_backup;

-----------------
-- DML (DELETE)
-- trucate와 다른점 : 복구가능!,해당 세션에서만 지워짐, 다른세션에선 안지워짐 / 실행 후 commit을 하게 되면 날라간채로 저장됨
delete
from emp_backup;
commit;
drop table emp_backup;

create table emp_backup
as
select employee_id, first_name, salary, hire_date, department_id
from employees;

select *
from emp_backup;

-- IT 부서의 직원들 모두 삭제
delete
from emp_backup
where department_id = (select department_id from departments where department_name = 'IT');

--------------------
-- merge (병합)
create table emp01
as
select EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE
from EMPLOYEES;

create table emp02
as
select EMPLOYEE_ID, FIRST_NAME, SALARY, HIRE_DATE
from EMPLOYEES
where DEPARTMENT_ID = 60;

update emp02
set FIRST_NAME = '수정';

insert into emp02
values (99, '임덕배', 30000, sysdate);

-- emp01: 107건, emp02: 5건 + 1건
merge into emp01
using emp02
on (emp01.EMPLOYEE_ID = emp02.EMPLOYEE_ID)
when matched then
    update
    set emp01.FIRST_NAME = emp02.FIRST_NAME
when not matched then
    insert
    values (emp02.EMPLOYEE_ID, emp02.FIRST_NAME, emp02.SALARY, emp02.HIRE_DATE);

select *
from emp01;

----------------
-- JDBC CRUD
desc EMPLOYEES;

insert into EMPLOYEES value(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

select *
from EMPLOYEES;

------------------
-- 트랜젝션

-- DML(insert, update, delete)
-- 작업시작
delete
from emp02
where EMPLOYEE_ID = 103;
delete
from emp02
where EMPLOYEE_ID = 104;
delete
from emp02
where EMPLOYEE_ID = 105;

select *
from emp02;

commit;
rollback;
-- 작업 끝

-- 작업 시작
select *
from emp02;
delete
from emp02
where EMPLOYEE_ID = 106;
-- sqlplus SQL> update emp02 set first_name = 'aa' where employee_id = 106; -- lock 걸려서 대기
rollback;
-- sqlplus 1 row updated. -- 완료
delete
from emp02
where EMPLOYEE_ID = 106;
-- sqlplus가 선점하고 있어서 lock
-- sqlplus SQL> rollback; -- 하면 됨
commit;
-- 작업 끝

------------------------
-- 제약조건

desc user_constraints;

select *
from USER_CONSTRAINTS
where table_name = 'EMPLOYEES';

select *
from USER_CONS_COLUMNS
where TABLE_NAME = 'EMPLOYEES';

select COLUMN_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
from USER_CONSTRAINTS
         join USER_CONS_COLUMNS using (CONSTRAINT_NAME)
where USER_CONSTRAINTS.TABLE_NAME = 'EMPLOYEES';

--P(Primary key): 유일값, null불가 (필수칼럼), 하나의 테이블에 오직 하나
--U(Unique): 유일값, null가능
--R(Foreign key): 참조키, 외래키, 일반적으로 다른테이블의 PK를 참조한다. 같은테이블의 칼럼참조가능, PK가 아닌칼럼도 참조가능
--C(Check): 조건에 맞는 데이터만 가능

-----

drop table customer;

create table customer
(
    cust_id   number
        constraint customer_cust_id_pk primary key,
    cust_name varchar2(30) not null,
    email     varchar2(20)
        constraint customer_email_unique unique,
    address   varchar2(100),
    gender    char(1)
        constraint customer_gender_check check ( gender in ('M', 'F') ),
    dept_id   number
        constraint customer_dept_id_FK REFERENCES DEPARTMENTS (DEPARTMENT_ID),
    loc       varchar2(20) default 'SEOUL' -- 안넣어도 기본값 SEOUL
);

insert into customer (cust_id, cust_name, email, gender, dept_id)
values (4, '임덕배', '4@4.com', 'M', 100);

select *
from customer;

-- PK가 2개 이상인 경우
select COLUMN_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
from USER_CONSTRAINTS
         join USER_CONS_COLUMNS using (CONSTRAINT_NAME)
where USER_CONSTRAINTS.TABLE_NAME = 'JOB_HISTORY';

-- 상품정보: 상품번호, 상품이름, 가격
-- 고객정보: 고객번호, 고객이름, ...
create table 상품정보
(
    상품번호 number
        constraint 상품정보_goods_pk primary key,
    상품이름 varchar2(100),
    상품가격 number(9)
);
INSERT INTO 상품정보
VALUES (1, '노트북', 2000000);
INSERT INTO 상품정보
VALUES (2, '스마트폰', 2000000);


-- 주문: 고객번호, 주문일자, 순서, 상품번호, 수량
create table 주문
(
    고객번호 number,
    주문일자 date,
    순서   number,
    상품번호 number
        constraint ORDER_GOODS_FK REFERENCES 상품정보 (상품번호),
    수량   number,
    CONSTRAINT ORDER_PK PRIMARY KEY (고객번호, 주문일자, 순서)
);

select *
from customer;

insert into 주문
VALUES (4, '2001/03/17', 1, 2, 10);
insert into 주문
VALUES (4, '2001/03/17', 2, 2, 10);
insert into 주문
VALUES (4, '2001/03/17', 3, 2, 10);

select *
from 주문;

-- 제약조건 해지
alter table employees
    disable constraint emp_dept_fk;
alter table customer
    disable constraint customer_dept_id_fk;

delete from departments where department_id = 100;

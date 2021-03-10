--부서정보 모두보기
select *
from departments;
--hr
--직원정보 모두보기
select *
from employees; --hr

select *
from EMP;
--SCOTT

--딕셔너리 TAB: 소유자가 소유하고 있는 테이블
create table kosta_Student
(
    id   number,
    name varchar2(30)
);
select *
from tab;

--desc: 테이블 구조확인 (sqlplus)
desc kosta_Student;

--order by ... desc; : 내림차순
select *
from EMPLOYEES
order by EMPLOYEES.EMPLOYEE_ID desc;

--order by ... asc; : 오름차순
select *
from EMPLOYEES
order by EMPLOYEES.EMPLOYEE_ID asc;

--DISTINCT: 중복제외
select DISTINCT DEPARTMENT_ID
from employees;

--부서가 null인 사람찾기
select *
from EMPLOYEES
where DEPARTMENT_ID is null;

--모든 컬럼 나열
select *
from EMPLOYEES;
--특정 컬럼 나열
select employee_id, FIRST_NAME
from EMPLOYEES;
--특정 컬럼 나열 ... 별명부여
select employee_id 직원번호, first_name 성
from EMPLOYEES;
--연산식
select employee_id 직원번호, first_name 성, 10 + 20 계산
from EMPLOYEES;
-- ||: concat 연산자
select employee_id 직원번호, first_name || LAST_NAME "전체 이름"
from EMPLOYEES;

--Java:     char > 'A'       String > "Java"
--Oracle:   '': 값을 뜻함      "": 컬럼이름 또는 테이블이름, 대소문자를 구별함
select FIRST_NAME
from "EMPLOYEES"; -- 됨
select FIRST_NAME
from "employees"; -- 안됨
select employee_id 직원번호, first_name || ' ' || LAST_NAME "전체 이름"
from EMPLOYEES;

--조건: first_name = 'Steven' 값을 줄땐 ''
select *
from EMPLOYEES
where FIRST_NAME = 'Steven';

--급여의 10% 세금 연산
select salary, salary * 0.1 세금
from EMPLOYEES;
--세금, 커미션 계산, nvl(): null인지 체크하는 함수
select salary, salary * 0.1 세금, commission_pct, salary + SALARY * nvl(COMMISSION_PCT, 0) 수령액
from EMPLOYEES;

---------------------

--작성순서: select - from - where - order by
--해석순서: from -where - select - order by
select rownum, first_name, hire_date, salary, DEPARTMENT_ID
from EMPLOYEES
where SALARY > 10000
  and DEPARTMENT_ID <> 80 -- !=, <>, ^= 모두 not연산자
order by salary;

--급여가 1500이하인 사원의 사원번호, 사원 이름, 급여를 출력하는 sql문을 작성하시오 (SCOTT)
select EMPNO 사원번호, ENAME 사원이름, SAL 급여
from EMP
where SAL <= 1500;

--82년 전에 입사한 사원
select EMPNO 사원번호, ENAME 사원이름, SAL 급여, HIREDATE 입사일
from EMP
where HIREDATE <= '82-01-01';
--default date format: RR/MM/DD
--RR: 50이상이면 1900년대 50미만이면 2000년대
--파라메타값 확인
select *
from NLS_SESSION_PARAMETERS;
--NLS_TIMESTAMP_FORMAT 설정변경해보기 --원래:RR/MM/DD HH24:MI:SSXFF
alter session set NLS_TIMESTAMP_FORMAT = 'yyyy-mm-dd';
select *
from NLS_SESSION_PARAMETERS
where PARAMETER = 'NLS_TIMESTAMP_FORMAT';

--바뀐 타임스탬프 형식으로 다시 조회
select EMPNO 사원번호, ENAME 사원이름, SAL 급여, HIREDATE 입사일
from EMP
where HIREDATE <= '1982-01-01';
--to_char()활용
select EMPNO 사원번호, ENAME 사원이름, SAL 급여, HIREDATE 입사일
from EMP
where to_char(HIREDATE, 'RR/MM/DD') <= '82-01-01';

--논리 연산자
--AND 두 조건 다 참일 때
--OR 한 조건이라도 참일 때
--NOT 반대로 바꿔버리기

--LAB
--1. 급여가 15000 이상인 직원들의 이름, 급여, 부서id를 조회하시오.
select *
from EMPLOYEES;
select FIRST_NAME || ' ' || LAST_NAME 직원이름, SALARY 급여, DEPARTMENT_ID 부서id
from EMPLOYEES;
--2. 직원 중에서 연봉이 170000 이상인 직원들의 이름, 연봉을 조회하시오. 연봉은 급여(salary)에 12를 곱한 값
select FIRST_NAME || ' ' || LAST_NAME 직원이름, SALARY * 12 연봉
from EMPLOYEES
where SALARY * 12 >= 170000;
--3. 직원 중에서 부서id가 없는 직원의 이름과 급여를 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 직원이름, SALARY 급여, HIRE_DATE 입사일
from EMPLOYEES
where DEPARTMENT_ID is null;
--4. 04년 이전에 입사한 직원의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 직원이름, SALARY 급여, HIRE_DATE 입사일
from EMPLOYEES
where HIRE_DATE <= '04-12-31';

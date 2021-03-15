-- 단일행함수: 숫자, 문자, 날짜, 변환 함수 (to_char, to_date, to_number...)
select first_name, substr(EMPLOYEES.FIRST_NAME, 1, 3)
from EMPLOYEES;

select COMMISSION_PCT, SALARY, SALARY + SALARY * nvl(COMMISSION_PCT, 0) 급여
from EMPLOYEES;

-- 다중행함수 ... null 무시
-- count(): row 개수를 구하는 함수, sum(): 더하기
select count(DEPARTMENT_ID),
       count(COMMISSION_PCT) 건수1,
       count(FIRST_NAME)     건수2,
       sum(SALARY)           급여총액,
       sum(COMMISSION_PCT)   커미션합계
from EMPLOYEES;

select count(COMMISSION_PCT), --null 불포함
       count(*)
from EMPLOYEES;
-- null 포함

-- avg(): 평균을 구하는 함수
select sum(SALARY), avg(SALARY), sum(SALARY) / count(SALARY)
from EMPLOYEES;

-- max(), min(): 최대값, 최소값
select max(SALARY), min(SALARY)
from EMPLOYEES;
select SALARY
from EMPLOYEES
order by SALARY desc;

-- 입사일이 가장 오래된 사람과 최근인 사람 조회
select max(HIRE_DATE) 뉴비, min(HIRE_DATE) 고인물
from EMPLOYEES;

-- 80번 부서 소속 사원중에서 커미션을 받는 사원의 수를 구해보시오.
select count(COMMISSION_PCT), count(*)
from EMPLOYEES
where DEPARTMENT_ID = 80;

-- 80번 부서가 아닌 소속 사원중에서 커미션을 받는 사원의 수를 구해보시오.
select *
from EMPLOYEES
where DEPARTMENT_ID is null
  and COMMISSION_PCT is not null;

-- count(distinct ...) 중복제
select count(distinct DEPARTMENT_ID)
from EMPLOYEES;

select count(distinct JOB_ID)
from EMPLOYEES;

-- group by 절
-- 전체가 아닌 특정 컬럼 값을 기준으로 적용
-- SELECT 컬럼, 그룹함수
-- FROM 테이블명
-- WHERE 조건(연산자)
-- GROUP BY 컬럼;
select DEPARTMENT_ID,
       max(FIRST_NAME),
       sum(SALARY) -- 그룹함수를 사용하지 않은 컬럼은 반드시 group by절에 참여해야
from EMPLOYEES
group by DEPARTMENT_ID
order by DEPARTMENT_ID;

select FIRST_NAME, SALARY
from EMPLOYEES
where DEPARTMENT_ID = 20
order by FIRST_NAME desc;

-- 각 부서별 인원수를 조회하되 인원수가 5명 이상인 부서만 출력되도록 하시오.
select DEPARTMENT_ID, count(*)
from EMPLOYEES
group by DEPARTMENT_ID
having count(*) >= 5 -- having: 그룹의 결과를 제한할 때 사용, 집계함수에 대한 조건
order by DEPARTMENT_ID;
-- 부서별 평균구하기
select DEPARTMENT_ID, avg(SALARY) sal_avg
from EMPLOYEES
group by DEPARTMENT_ID
having avg(SALARY) >= 10000
order by sal_avg desc;

-- 각 부서별 최대급여와 최소급여를 조회하시오.
-- 단, 최대급여와 최소급여가 같은 부서는 직원이 한명일 가능성이 높기때문에
-- 조회결과에서 제외시킨다.
select DEPARTMENT_ID, max(SALARY) sal_max, min(SALARY) sal_min
from EMPLOYEES
group by DEPARTMENT_ID
having max(SALARY) <> min(SALARY)
order by DEPARTMENT_ID;

-- 부서가 50, 80, 110 번인 직원들 중에서 급여를 5000 이상 24000 이하를 받는
-- 직원들을 대상으로 부서별 평균 급여를 조회하시오.
-- 다, 평균급여가 8000 이상인 부서만 출력되어야 하며, 출력결과를 평균급여가 높은
-- 부서면저 출력되도록 해야 한다.
select DEPARTMENT_ID, avg(SALARY)
from EMPLOYEES
where DEPARTMENT_ID in (50, 80, 110)
  and SALARY between 5000 and 24000
group by DEPARTMENT_ID
having avg(SALARY) >= 8000
order by 2 desc;


---------------------------

-- join 절

-- join을 안쓰면
select DEPARTMENT_ID
from EMPLOYEES
where FIRST_NAME = 'Steven'
  and LAST_NAME = 'King'; -- 부서명을 알 수 없으므로

select *
from DEPARTMENTS
where DEPARTMENT_ID = (select DEPARTMENT_ID -- 서브 쿼리문
                       from EMPLOYEES
                       where FIRST_NAME = 'Steven'
                         and LAST_NAME = 'King'
);
-- 이것도 부서명이 나오진 않음

-- join 사용 (cross join)
select FIRST_NAME, SALARY, DEPARTMENT_NAME
from EMPLOYEES,
     DEPARTMENTS
where EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

-- 표준문법
select FIRST_NAME, SALARY, DEPARTMENT_NAME
from EMPLOYEES
         join DEPARTMENTS using (department_id);

-- employees: 컬럼 11, 건수 107
-- departments: 컬럼 4, 건수 27
select *
from DEPARTMENTS,
     EMPLOYEES;

select DEPARTMENT_ID
from DEPARTMENTS
         join EMPLOYEES using (department_id);

select EMPLOYEES.*, DEPARTMENT_NAME
from DEPARTMENTS,
     EMPLOYEES
where EMPLOYEES.DEPARTMENT_ID = EMPLOYEES.department_id;

-- join문에서 컬럼 이름이 다를 경우
--
-- [customer정보]
-- id
-- name
-- address
--
-- [orderInfo 정보]
-- id
-- title
-- price
-- cust_id

-- 표준문법
-- select *
-- from customer join orderInfo on(customer.id = orderInfo.cust_id); --요런식

--밴더문법
-- select *
-- from customer, orderInfo
-- where customer.id = orderInfo.cust_id;

-- [employees, departments]
-- 벤더문법
select EMPLOYEES.*, DEPARTMENT_NAME
from EMPLOYEES,
     DEPARTMENTS
where EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

-- 표준문법
select DEPARTMENT_ID, FIRST_NAME, DEPARTMENT_NAME
from EMPLOYEES
         join DEPARTMENTS using (department_id);

select DEPARTMENTS.DEPARTMENT_NAME, EMPLOYEES.*
from EMPLOYEES
         join DEPARTMENTS on EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
where SALARY >= 10000;

-- 별칭 (table 이름도 별칭이 가능 Alias)
select d.DEPARTMENT_NAME, e.*
from EMPLOYEES e
         join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
where SALARY >= 10000;

-- 실습: 뉴욕에 근무하는 사원의 이름과 급여를 출력

-- subquery
select ENAME, SAL
from EMP
where DEPTNO = (
    select DEPT.DEPTNO
    from DEPT
    where LOC = 'NEW YORK'
);

-- equi join: oracle 문법
select ENAME, SAL
from EMP,
     DEPT
where EMP.DEPTNO = DEPT.DEPTNO
  and DEPT.LOC = 'NEW YORK';

-- equi join: 표준문법 using 사용
select ENAME, SAL
from EMP
         join DEPT using (DEPTNO)
where LOC = 'NEW YORK';

-- equi join: 표준문법 on 사용
select ENAME, SAL
from EMP
         join DEPT on (EMP.DEPTNO = DEPT.DEPTNO)
where LOC = 'NEW YORK';

select ENAME, HIREDATE
from EMP
         join DEPT on (EMP.DEPTNO = DEPT.DEPTNO)
where DNAME = 'ACCOUNTING';

-- 직급이 manager인 사원의 이름, 부서명을 출력하시오
SELECT *
FROM EMP
         JOIN DEPT USING (DEPTNO)
WHERE JOB = 'MANAGER';

-- 문제
-- ========================================
-- 		JOIN
-- ========================================
--
-- 1. 직원들의 이름과 직급명(job_title)을 조회하시오.
select EMPLOYEES.FIRST_NAME, JOBS.JOB_TITLE
from EMPLOYEES,
     JOBS
where EMPLOYEES.JOB_ID = JOBS.JOB_ID;

select EMPLOYEES.FIRST_NAME, JOBS.JOB_TITLE
from EMPLOYEES
         join JOBS using (JOB_ID);

select EMPLOYEES.FIRST_NAME, JOBS.JOB_TITLE
from EMPLOYEES
         join JOBS on EMPLOYEES.JOB_ID = JOBS.JOB_ID;

-- 2. 부서이름과 부서가 속한 도시명(city)을 조회하시오.
select DEPARTMENTS.DEPARTMENT_NAME, LOCATIONS.CITY
from DEPARTMENTS,
     LOCATIONS
where DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID;

select DEPARTMENTS.DEPARTMENT_NAME, LOCATIONS.CITY
from DEPARTMENTS
         join LOCATIONS using (LOCATION_ID);

select DEPARTMENTS.DEPARTMENT_NAME, LOCATIONS.CITY
from DEPARTMENTS
         join LOCATIONS on DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID;

-- 3. 직원의 이름과 근무국가명을 조회하시오. (employees, departments, locations,countries)
select FIRST_NAME, COUNTRY_NAME
from EMPLOYEES,
     DEPARTMENTS,
     LOCATIONS,
     COUNTRIES
where EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
  and DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
  and LOCATIONS.COUNTRY_ID = COUNTRIES.COUNTRY_ID;

select FIRST_NAME, COUNTRY_NAME
from EMPLOYEES
         join DEPARTMENTS using (DEPARTMENT_ID)
         join LOCATIONS using (LOCATION_ID)
         join COUNTRIES using (COUNTRY_ID);

select FIRST_NAME, COUNTRY_NAME
from EMPLOYEES
         join DEPARTMENTS on (EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID)
         join LOCATIONS on (DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID)
         join COUNTRIES on (LOCATIONS.COUNTRY_ID = COUNTRIES.COUNTRY_ID);

-- 4. 직책(job_title)이 'manager' 인 사람의 이름, 직책, 부서명을 조회하시오.
select FIRST_NAME, JOB_TITLE, DEPARTMENT_NAME
from EMPLOYEES,
     JOBS,
     DEPARTMENTS
where EMPLOYEES.JOB_ID = JOBS.JOB_ID
  and EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
  and lower(JOB_TITLE) like '%manager';

SELECT FIRST_NAME, JOB_TITLE, DEPARTMENT_NAME
FROM EMPLOYEES
         JOIN JOBS USING (JOB_ID)
         JOIN DEPARTMENTS USING (DEPARTMENT_ID)
WHERE LOWER(JOB_TITLE) LIKE '%manager';

SELECT FIRST_NAME, JOB_TITLE, DEPARTMENT_NAME
FROM DEPARTMENTS
         JOIN EMPLOYEES USING (DEPARTMENT_ID)
         JOIN JOBS USING (JOB_ID)
WHERE SUBSTR(JOB_TITLE, -7, 7) = INITCAP('manager');

-- 5. 직원들의 이름, 입사일, 부서명을 조회하시오.
select e.FIRST_NAME, j.START_DATE, d.DEPARTMENT_NAME
from EMPLOYEES e,
     JOB_HISTORY j,
     DEPARTMENTS d
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
  and e.EMPLOYEE_ID = j.EMPLOYEE_ID;

select EMPLOYEES.FIRST_NAME, JOB_HISTORY.START_DATE, DEPARTMENTS.DEPARTMENT_NAME
from EMPLOYEES
         join DEPARTMENTS using (DEPARTMENT_ID)
         join JOB_HISTORY using (EMPLOYEE_ID);

-- 6. 직원들의 이름, 입사일, 부서명을 조회하시오.
-- 단, 부서가 없는 직원이 있다면 그 직원정보도 출력결과에 포함시킨다.
-- outer join(oracle)
select FIRST_NAME, HIRE_DATE, DEPARTMENT_NAME
from EMPLOYEES,
     DEPARTMENTS
where EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID(+);
-- 표준 - inner join
select FIRST_NAME, HIRE_DATE, DEPARTMENT_NAME
from EMPLOYEES
         inner join DEPARTMENTS
                    on EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;
-- outer join
select FIRST_NAME, HIRE_DATE, DEPARTMENT_NAME
from EMPLOYEES
         left outer join DEPARTMENTS
                         on EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

select FIRST_NAME, HIRE_DATE, DEPARTMENT_NAME
from DEPARTMENTS
         right outer join EMPLOYEES
                          on EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

select FIRST_NAME, HIRE_DATE, DEPARTMENT_NAME
from DEPARTMENTS
         full outer join EMPLOYEES
                         on EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

-- 7. 직원의 이름과 직책(job_title)을 출력하시오.
-- 단, 사용되지 않는 직책이 있다면 그 직책정보도 출력결과에 포함시키시오.

-- non equi join
select FIRST_NAME, SALARY
from EMPLOYEES;

create table salgrade
(
    grade  char(1),
    minsal number,
    maxsal number
);
insert into salgrade
values ('A', 0, 5000);
insert into salgrade
values ('B', 5001, 8000);
insert into salgrade
values ('C', 8001, 10000);
insert into salgrade
values ('D', 10001, 15000);
insert into salgrade
values ('E', 15001, 25000);

select *
from salgrade;

select *
from EMPLOYEES
         join salgrade on EMPLOYEES.SALARY between salgrade.minsal and salgrade.maxsal;

-- self join
select 직원.ENAME, 매니저.ENAME
from EMP 직원,
     emp 매니저
where 직원.MGR = 매니저.EMPNO;

select emp.EMPLOYEE_ID, emp.FIRST_NAME, 매니저.FIRST_NAME, 매니저.EMPLOYEE_ID
from EMPLOYEES emp
         left outer join EMPLOYEES 매니저
                         on emp.MANAGER_ID = 매니저.EMPLOYEE_ID;

-- SELF JOIN
-- 1. 직원의 이름과 관리자 이름을 조회하시오.
select emp.EMPLOYEE_ID, emp.FIRST_NAME, 매니저.FIRST_NAME, 매니저.EMPLOYEE_ID
from EMPLOYEES emp,
     EMPLOYEES 매니저
where emp.MANAGER_ID = 매니저.EMPLOYEE_ID;

-- 2. 직원의 이름과 관리자 이름을 조회하시오.
-- 관리자가 없는 직원정보도 모두 출력하시오.
select emp.EMPLOYEE_ID, emp.FIRST_NAME, 매니저.FIRST_NAME, 매니저.EMPLOYEE_ID
from EMPLOYEES emp
         left outer join EMPLOYEES 매니저
                         on emp.MANAGER_ID = 매니저.EMPLOYEE_ID;

-- 3. 관리자 이름과 관리자가 관리하는 직원의 수를 조회하시오.
-- 단, 관리직원수가 3명 이상인 관리자만 출력되도록 하시오.
select count(직원.EMPLOYEE_ID), 관리자.FIRST_NAME
from EMPLOYEES 직원,
     EMPLOYEES 관리자
where 직원.MANAGER_ID = 관리자.EMPLOYEE_ID
group by 관리자.FIRST_NAME
having count(직원.EMPLOYEE_ID) >= 3;






-- Review
-- join oracle문법
select FIRST_NAME, SALARY, JOB_TITLE, MIN_SALARY, DEPARTMENT_NAME
from EMPLOYEES,
     JOBS,
     DEPARTMENTS
where EMPLOYEES.JOB_ID = JOBS.JOB_ID
  and EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

-- join ANSI표준
select FIRST_NAME, SALARY, JOB_TITLE, MIN_SALARY, DEPARTMENT_NAME
from EMPLOYEES
         join JOBS using (JOB_ID)
         join DEPARTMENTS using (DEPARTMENT_ID)

-- join 칼럼명이 다른경우
select FIRST_NAME, SALARY, JOB_TITLE, MIN_SALARY, DEPARTMENT_NAME
from EMPLOYEES
         join JOBS on EMPLOYEES.JOB_ID = JOBS.JOB_ID
         join DEPARTMENTS on EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID

-- outer join
-- nvl(대상, null이면 출력)
-- nvl2(대상, 아닌경우, null경우)
select FIRST_NAME,
       SALARY,
       JOB_TITLE,
       MIN_SALARY,
       nvl(DEPARTMENT_NAME, '부서없음')                                                부서이름,
       nvl2(DEPARTMENTS.DEPARTMENT_ID, to_char(DEPARTMENTS.DEPARTMENT_ID), '부서없음') 부서번호,
       nvl(to_char(DEPARTMENTS.DEPARTMENT_ID), '부서없음')                             부서번호2
from EMPLOYEES
         join JOBS on EMPLOYEES.JOB_ID = JOBS.JOB_ID
         left outer join DEPARTMENTS on EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

-- full outer join
select FIRST_NAME,
       SALARY,
       JOB_TITLE,
       MIN_SALARY,
       nvl(DEPARTMENT_NAME, '부서없음')                                                부서이름,
       nvl2(DEPARTMENTS.DEPARTMENT_ID, to_char(DEPARTMENTS.DEPARTMENT_ID), '부서없음') 부서번호,
       nvl(to_char(DEPARTMENTS.DEPARTMENT_ID), '부서없음')                             부서번호2
from EMPLOYEES
         join JOBS on EMPLOYEES.JOB_ID = JOBS.JOB_ID
         full outer join DEPARTMENTS on EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

-- 부서의 부서장정보를 알아보기: 이름, 급여, 입사
select DEPARTMENTS.*, EMPLOYEES.FIRST_NAME, EMPLOYEES.SALARY, EMPLOYEES.HIRE_DATE
from DEPARTMENTS
         left outer join EMPLOYEES on (DEPARTMENTS.MANAGER_ID = EMPLOYEES.EMPLOYEE_ID);

-- self join
select 직원.FIRST_NAME, 직원.SALARY, nvl(매니저.FIRST_NAME, '매니저 없음'), nvl(매니저.SALARY, 0)
from EMPLOYEES 직원,
     EMPLOYEES 매니저
where 직원.MANAGER_ID = 매니저.EMPLOYEE_ID(+);

-- ANSI self join
select 직원.FIRST_NAME, 직원.SALARY, nvl(매니저.FIRST_NAME, '매니저 없음'), nvl(매니저.SALARY, 0)
from EMPLOYEES 직원
         left outer join
     EMPLOYEES 매니저
     on 직원.MANAGER_ID = 매니저.EMPLOYEE_ID;

-----------------------------------------------

-- sub query (SCOTT)

--join
select ENAME, DNAME
from emp
         join dept using (DEPTNO)
where ENAME = 'SMITH';

-- sub query
select DNAME
from DEPT
where DEPTNO = (select DEPTNO
                from EMP
                where ename = 'SMITH');

-- 'SMITH' 직원과 같은 부서에 근무하는 직원 조회 (sub query)
select *
from EMP
where DEPTNO = (select DEPTNO
                from EMP
                where ename = 'SMITH');
-- 'SMITH' 직원과 같은 부서에 근무하는 직원 조회 (self join)
select 동료.*
from emp 스미스,
     emp 동료
where 스미스.DEPTNO = 동료.DEPTNO
  and 스미스.ENAME = 'SMITH';
-- 'SMITH' 직원과 같은 부서에 근무하는 직원 조회 (ANSI join)
select 동료.*
from emp 스미스
         join emp 동료
              on 스미스.DEPTNO = 동료.DEPTNO
where 스미스.ENAME = 'SMITH';

-- 스티븐과 같은부서에 근무하는 직원들 조회 (hr)
select *
from EMPLOYEES
where DEPARTMENT_ID in (select DEPARTMENT_ID
                        from EMPLOYEES
                        where FIRST_NAME = 'Steven');

-- SMITH와 동일한 직급을 가진 동료들
select *
from emp
where job = (
    select job
    from emp
    where ename = 'SMITH');

-- Lex와 급여가 같거나 더 많은 사람 조회
select *
from employees
where salary >= (
    select salary
    from employees
    where first_name = 'Lex');

--  LEX와 급여가 같거나 더 많은 사람 조회  (Lex는 제외)
select *
from employees
where salary >= (
    select salary
    from employees
    where first_name = 'Lex')
  and first_name <> 'Lex';

-- DALLAS에 근무하는 직원들
select *
from emp
where deptno = (
    select deptno
    from dept
    where loc = 'DALLAS');
-- join
select *
from emp
         join dept using (deptno)
where loc = 'DALLAS';

-- 직속 상관이 KING인 사원정보
select *
from EMP
where MGR = (select EMPNO
             from EMP
             where ENAME = 'KING');
-- self join
select *
from emp 직원,
     emp 상관
where 직원.MGR = 상관.EMPNO
  and 상관.ENAME = 'KING';
-- ANSI self join
select *
from emp 직원
         join emp 상관
              on 직원.MGR = 상관.EMPNO
where 상관.ENAME = 'KING';

-- 직속 상관이 스티븐인 사람
select *
from EMPLOYEES
where MANAGER_ID in (select EMPLOYEE_ID
                     from EMPLOYEES
                     where FIRST_NAME = 'Steven');
-- self join
select *
from EMPLOYEES 직원,
     EMPLOYEES 상관
where 직원.MANAGER_ID = 상관.EMPLOYEE_ID
  and 상관.FIRST_NAME = 'Steven';
-- ANSI self join
select *
from EMPLOYEES 직원
         join EMPLOYEES 상관
              on 직원.MANAGER_ID = 상관.EMPLOYEE_ID
where 상관.FIRST_NAME = 'Steven';

-- 직원의 평균 급여보다 많은 급여를 받는 직원 조회
-- sub query
select *
from EMPLOYEES
where salary >= (select avg(SALARY)
                 from EMPLOYEES);

-- 급여가 10000이상인 부서의 직원들
select *
from EMPLOYEES
where DEPARTMENT_ID in (select distinct DEPARTMENT_ID
                        from EMPLOYEES
                        where SALARY >= 10000);
-- =any: 아무거나 같으면 참
-- =all: 모두일치해야 참
select *
from EMPLOYEES
where DEPARTMENT_ID in (select distinct DEPARTMENT_ID
                        from EMPLOYEES
                        where SALARY = any 10000);

-- 부서별 가장 많은 급여를 받는 직원
select DEPARTMENT_ID, max(SALARY) 최대급여
from EMPLOYEES
group by DEPARTMENT_ID;

select *
from EMPLOYEES
where (DEPARTMENT_ID, SALARY) in (select DEPARTMENT_ID, max(SALARY) 최대급여
                                  from EMPLOYEES
                                  group by DEPARTMENT_ID);

-- 직급이 IT_PROG인 사람의 속한 부서의 부서 번호와 부서명과 지역을 출력
select *
from DEPARTMENTS
where DEPARTMENT_ID = (select distinct DEPARTMENT_ID
                       from EMPLOYEES
                       where JOB_ID = 'IT_PROG');

-- >ALL: 최대보다 크다
select *
from EMPLOYEES
where salary > ALL (select SALARY
                    from EMPLOYEES
                    where DEPARTMENT_ID = 60);

-- >ANY: 최소보다 크다
select *
from EMPLOYEES
where salary > ANY (select SALARY
                    from EMPLOYEES
                    where DEPARTMENT_ID = 60);

-- 영업 사원들보다 급여를 많이 받는 사원들의 이름과 급여와 직급을 출력하되 영업 사원은 출력하지 않는다.
select *
from EMP
where SAL > ALL (select SAL
                 from EMP
                 where DEPTNO = (select DEPTNO
                                 from DEPT
                                 where DNAME = 'SALES'));

-- 상관형 서브쿼리
-- 본인이 받는 급여가 본인이 속한 부서의 평균 급여보다 적은 급여를 받는 직원의 이름, 부서번호, 급여를 조회
select *
from EMPLOYEES aa
where SALARY < (select avg(SALARY)
                from EMPLOYEES
                where DEPARTMENT_ID = aa.DEPARTMENT_ID);
-- 가상 테이블(inline view) 활용
select *
from EMPLOYEES aa,
     (select DEPARTMENT_ID, avg(SALARY) avg_sal
      from EMPLOYEES
      group by DEPARTMENT_ID) bb
where aa.DEPARTMENT_ID = bb.DEPARTMENT_ID
  and aa.SALARY < avg_sal;

-- 평균 급여보다 높고 최대 급여보다 낮은 급여를 받는 사원들을 조회
select EMPLOYEES.*,
       (select avg(SALARY)
        from EMPLOYEES),
       (select max(SALARY)
        from EMPLOYEES)
from EMPLOYEES
where SALARY > (select avg(SALARY)
                from EMPLOYEES)
  and SALARY < (select max(SALARY)
                from EMPLOYEES);

select EMPLOYEES.*, aa.sal, bb.sal
from EMPLOYEES,
     (select avg(SALARY) sal
      from EMPLOYEES) aa,
     (select max(SALARY) sal
      from EMPLOYEES) bb
where SALARY > aa.sal
  and SALARY < bb.sal;

-- 'IT'부서에서 근무하는 직원들의 이름, 급여, 입사일을 조회
select FIRST_NAME, SALARY, HIRE_DATE, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID
                       from DEPARTMENTS
                       where DEPARTMENT_NAME = 'IT');

-- 'Alexander'와 같은 부서에서 근무하는 직원의 이름과 부서id를 조회
select FIRST_NAME, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID in (select DEPARTMENT_ID
                        from EMPLOYEES
                        where FIRST_NAME = 'Alexander');
select FIRST_NAME, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID = any (select DEPARTMENT_ID
                           from EMPLOYEES
                           where FIRST_NAME = 'Alexander');

-- 3. 직원들의 이름, 입사일, 부서명을 조회하시오.
-- 단, 부서가 없는 직원이 있다면 그 직원정보도 출력결과에 포함시킨다.
-- 그리고 부서가 없는 직원에 대해서는 '<부서없음>' 이 출력되도록 한다.
select FIRST_NAME, HIRE_DATE, nvl(DEPARTMENT_NAME, '부서없음')
from EMPLOYEES
         left outer join
     DEPARTMENTS using (DEPARTMENT_ID);
select FIRST_NAME, HIRE_DATE, nvl(DEPARTMENT_NAME, '부서없음')
from EMPLOYEES
         left outer join
     DEPARTMENTS on (EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID);

-- 4. 직원의 직책에 따라 월급을 다르게 지급하려고 한다.
-- 직책에 'Manager'가 포함된 직원은 급여에 0.5를 곱하고
-- 나머지 직원들에 대해서는 원래의 급여를 지급하도록 한다.
-- 적절하게 조회하시오.

select first_name,
       JOB_TITLE,
       SALARY                                                                 "원래 급여",
       decode(substr(job_title, -7, 7), 'Manager', salary * 0.5, salary)      "급여",
       case when JOB_TITLE like '%Manager%' then SALARY * 0.5 else SALARY end "급여2"
from employees
         join jobs using (job_id);

-- 5. 각 부서별로 최저급여를 받는 직원의 이름과 부서id, 급여를 조회하시오.

-- inline view
select FIRST_NAME, bb.DEPARTMENT_ID, SALARY
from employees aa,
     (select DEPARTMENT_ID,
             min(SALARY) sal
      from employees
      group by DEPARTMENT_ID) bb
where aa.DEPARTMENT_ID = bb.DEPARTMENT_ID
and aa.SALARY = bb.sal;

---------------------------------prob 5
select EMPLOYEE_ID, FIRST_NAME, SALARY
from EMPLOYEES
where FIRST_NAME like initcap('%d%');
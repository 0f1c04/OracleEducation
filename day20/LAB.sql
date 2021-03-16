-- ========================================
-- SELECT 기본
-- ========================================
--
-- 1. 급여가 15000 이상인 직원들의 이름, 급여, 부서id를 조회하시오.
select FIRST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where SALARY >= 15000;

-- 2. 직원 중에서 연봉이 170000 이상인 직원들의 이름, 연봉을 조회하시오.
-- 연봉은 급여(salary)에 12를 곱한 값입니다.
select FIRST_NAME, SALARY * 12
from EMPLOYEES
where SALARY * 12 >= 170000;

-- 3. 직원 중에서 부서id가 없는 직원의 이름과 급여를 조회하시오.
select FIRST_NAME, SALARY
from EMPLOYEES
where DEPARTMENT_ID is null;

-- 4. 2007년 이전에 입사한 직원의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME, SALARY, HIRE_DATE
from EMPLOYEES
where HIRE_DATE < '20070101';

-- -- 논리연산자 --
-- 1. 80, 50 번 부서에 속해있으면서 급여가 13000 이상인 직원의 이름, 급여, 부서id
-- 를 조회하시오.
select FIRST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID in (80, 50)
  and SALARY >= 13000;

-- 2. 95년 이후에 입사한 직원들 중에서 급여가 1300 이상 20000 이하인 직원들의
-- 이름, 급여, 부서id, 입사일을 조회하시오.
select FIRST_NAME, SALARY, DEPARTMENT_ID, HIRE_DATE
from EMPLOYEES
where HIRE_DATE >= '950101'
  and SALARY between 1300 and 20000;

-- -- SQL 비교연산자 --
-- 1. 80, 50 번 부서에 속해있으면서 급여가 13000 이상인 직원의 이름, 급여, 부서id
-- 를 조회하시오.
select FIRST_NAME, SALARY, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID = 50
   or DEPARTMENT_ID = 80 and SALARY >= 13000;

-- 2. 2005년 이후에 입사한 직원들 중에서 급여가 1300 이상 20000 이하인 직원들의
-- 이름, 급여, 부서id, 입사일을 조회하시오.
select FIRST_NAME, SALARY, DEPARTMENT_ID, HIRE_DATE
from EMPLOYEES
where HIRE_DATE > '051231'
  and SALARY between 1300 and 20000;

-- 3. 2005년도 입사한 직원의 정보만 출력하시오.
select *
from EMPLOYEES
where HIRE_DATE between '050101' and '051231';

-- 4. 이름이 D로 시작하는 직원의 이름, 급여, 입사일을 조회하시오.
select *
from EMPLOYEES
where FIRST_NAME like 'D%';

-- 5. 12월에 입사한 직원의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME, SALARY, HIRE_DATE
from EMPLOYEES
where HIRE_DATE like '__/12/__';

-- 6. 이름에 le 가 들어간 직원의 이름, 급여, 입사일을 조회하시오.
select
from EMPLOYEES
where FIRST_NAME like '%le%';
-- 7. 이름이 m으로 끝나는 직원의 이름, 급여, 입사일을 조회하시오.
--
--
-- 8. 이름의 세번째 글자가 d인 이름, 급여, 입사일을 조회하시오.
--
--
-- 9. 커미션을 받는 직원의 이름, 커미션, 급여를 조회하시오.
--
--
-- 10. 커미션을 받지 않는 직원의 이름, 커미션, 급여를 조회하시오.
--
--
-- 11. 2000년대에 입사해서 30, 50, 80 번 부서에 속해있으면서,
-- 급여를 5000 이상 17000 이하를 받는 직원을 조회하시오.
-- 단, 커미션을 받지 않는 직원들은 검색 대상에서 제외시키며, 먼저 입사한 직원이
-- 먼저 출력되어야 하며 입사일이 같은 경우 급여가 많은 직원이 먼저 출력되록 하시오.
--
--
-- ========================================
-- 단일행 함수
-- ========================================
--
-- 1. 이름이 'adam' 인 직원의 급여와 입사일을 조회하시오.
--
-- 2. 나라 명이 'united states of america' 인 나라의 국가 코드를 조회하시오.
--
-- 3. 'Adam의 입사일은 95/11/02 이고, 급여는 7000 입니다.' 이런 식으로 직원
-- 정보를 조회하시오.
--
-- 4. 이름이 5글자 이하인 직원들의 이름, 급여, 입사일을 조회하시오.
-- select first_name, salary, hire_date
--
-- 5. 96년도에 입사한 직원의 이름, 입사일을 조회하시오.
--
--
--
-- 6. 20년 이상 장기 근속한 직원들의 이름, 입사일, 급여, 근무년차를 조회하시오.
--
--
--
--
--
-- 7. 각 부서별 인원수를 조회하되 인원수가 5명 이상인 부서만 출력되도록 하시오.
--
--
-- 8. 각 부서별 최대급여와 최소급여를 조회하시오.
-- 단, 최대급여와 최소급여가 같은 부서는 직원이 한명일 가능성이 높기때문에
-- 조회결과에서 제외시킨다.
--
--
-- 9. 부서가 50, 80, 110 번인 직원들 중에서 급여를 5000 이상 24000 이하를 받는
-- 직원들을 대상으로 부서별 평균 급여를 조회하시오.
-- 다, 평균급여가 8000 이상인 부서만 출력되어야 하며, 출력결과를 평균급여가 높은
-- 부서면저 출력되도록 해야 한다.
--
--
--
--
-- ========================================
-- JOIN
-- ========================================
--
-- 1.직원들의 이름과 직급명(job_title)을 조회하시오.
--
--
-- 2.부서이름과 부서가 속한 도시명(city)을 조회하시오.
--
--
--
-- 3. 직원의 이름과 근무국가명을 조회하시오.
--
--
--
-- 4. 직책(job_title)이 'manager' 인 사람의 이름, 직책, 부서명을 조회하시오.
--
--
--
-- 5. 직원들의 이름, 입사일, 부서명을 조회하시오.
--
--
--
-- 6. 직원들의 이름, 입사일, 부서명을 조회하시오.
-- 단, 부서가 없는 직원이 있다면 그 직원정보도 출력결과에 포함시킨다.
--
--
-- 7. 직원의 이름과 직책(job_title)을 출력하시오.
-- 단, 사용되지 않는 직책이 있다면 그 직책정보도 출력결과에 포함시키시오.
--
--
--
-- -- SELF JOIN
-- 8. 직원의 이름과 관리자 이름을 조회하시오.
--
--
-- 9. 직원의 이름과 관리자 이름을 조회하시오.
-- 관리자가 없는 직원정보도 모두 출력하시오.
--
--
--
-- 10. 관리자 이름과 관리자가 관리하는 직원의 수를 조회하시오.
-- 단, 관리직원수가 3명 이상인 관리자만 출력되도록 하시오.
--
--
--
-- ========================================
-- SubQuery
-- ========================================
-- 1. 'IT'부서에서 근무하는 직원들의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME, SALARY, HIRE_DATE, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID
                       from DEPARTMENTS
                       where DEPARTMENT_NAME = 'IT');

-- 2. 'Alexander' 와 같은 부서에서 근무하는 직원의 이름과 부서id를 조회하시오.
select FIRST_NAME, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID in (
    select DEPARTMENT_ID
    from EMPLOYEES
    where FIRST_NAME = 'Alexander'
);

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
select first_name, department_id, salary
from employees
where (department_id, salary) in (select department_id,
                                         min(salary)
                                  from employees
                                  group by department_id);

-- -- 연습문제
-- 1. 80번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 부서id, 급여를 조회하시오.
select FIRST_NAME, DEPARTMENT_ID, SALARY
from EMPLOYEES
where SALARY > (select avg(SALARY)
                from EMPLOYEES
                where DEPARTMENT_ID = 80);

-- 2. 'South San Francisco'에 근무하는 직원의 최소급여보다 급여를 많이 받으면서
-- 50 번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 급여, 부서명,
-- 부서id를 조회하시오.
select e.first_name 이름, e.salary 급여, d.department_name 부서명, d.department_id 부서id
from employees e,
     departments d
where e.department_id = d.department_id
  and salary > all ((select min(e.salary)
                     from employees e,
                          departments d,
                          locations l
                     where e.department_id = d.department_id
                       and d.location_id = l.location_id
                       and l.city = 'South San Francisco'), (select avg(e.salary)
                                                             from employees e
                                                             where e.department_id = 50));

-- 3. 각 직급별(job_title) 인원수를 조회하되 사용되지 않은 직급이 있다면 해당 직급도
-- 출력결과에 포함시키시오. 그리고 직급별 인원수가 3명 이상인 직급만 출력결과에 포함시키시오.
select jobs.job_title, count(*) 인원수
from employees
         right outer join jobs using (job_id)
group by jobs.job_title
having count(*) >= 3;


-- 4. 각 부서별 최대급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.
select FIRST_NAME, DEPARTMENT_NAME, SALARY
from employees
         join DEPARTMENTS using (DEPARTMENT_ID)
where (DEPARTMENT_ID, SALARY) in (select DEPARTMENT_ID,
                                         max(SALARY)
                                  from employees
                                  group by DEPARTMENT_ID);

-- 5. 직원의 이름, 부서id, 급여를 조회하시오. 그리고 직원이 속한 해당 부서의
-- 최소급여를 마지막에 포함시켜 출력 하시오.
-- inline
select emp.first_name, emp.department_id, salary, emp2.minSal
from employees emp
         left outer join
     (
         select nvl(department_id, 0) department_id, min(salary) minSal
         from employees
         group by department_id) emp2 on nvl(emp.DEPARTMENT_ID, 0) = emp2.DEPARTMENT_ID;
-- scala
select first_name,
       department_id,
       salary,
       (
           select min(salary)
           from employees
           where nvl(department_id, 0) = nvl(emp.department_id, 0))
from employees emp;

-- ==========================================
-- Inline View 와 Top-N SubQuery
-- ==========================================
--
-- 1. 급여를 가장 많이 받는 상위 5명의 직원 정보를 조회하시오.
select rownum, first_name, salary
from (
         select first_name,
                salary
         from employees
         order by salary desc)
where rownum <= 5;

-- 2. 커미션을 가장 많이 받는 상위 3명의 직원 정보를 조회하시오.
select *
from (
         select FIRST_NAME, COMMISSION_PCT
         from employees
         order by commission_pct desc nulls last)
where rownum <= 3;

-- -- 연습문제
-- 1. 월별 입사자 수를 조회하되, 입사자 수가 5명 이상인 월만 출력하시오.
select to_char(hire_date, 'mm') || '월' 월별, count(*) 인원수
from employees
group by to_char(hire_date, 'mm')
having count(*) >= 5
order by count(*) desc;

-- 2. 년도별 입사자 수를 조회하시오.
-- 단, 입사자수가 많은 년도부터 출력되도록 합니다.
select to_char(hire_date, 'yyyy') || '년' 월별, count(*) "입사 인원"
from employees
group by to_char(hire_date, 'yyyy')
having count(*) >= 5
order by count(*) desc;

-- << 연습문제 >>
-- 1. 'Southlake'에서 근무하는 직원의 이름, 급여, 직책(job_title)을 조회하시오.
select e.first_name 이름, e.salary 급여, j.job_title 직책
from employees e,
     jobs j,
     locations l,
     departments d
where e.department_id = d.department_id
  and d.location_id = l.location_id
  and l.city = 'Southlake'
  and e.job_id = j.job_id;

-- 2. 국가별 근무 인원수를 조회하시오. 단, 인원수가 3명 이상인 국가정보만 출력되어야함.
select c.country_name 국가, count(e.first_name)
from employees e,
     countries c,
     locations l,
     departments d
where e.department_id = d.department_id
  and d.location_id = l.location_id
  and c.country_id = l.country_id
group by c.country_name
having count(e.first_name) >= 3;

-- 3. 직원의 이름, 급여, 직원의 관리자 이름을 조회하시오. 단, 관리자가 없는 직원은
-- '<관리자 없음>'이 출력되도록 해야 한다.
select e.first_name 이름, e.salary 급여, nvl(m.first_name, '<관리자 없음>') 관리자
from employees e,
     employees m
where e.manager_id = m.employee_id(+);


-- 4. 직원의 이름, 부서명, 근무년수를 조회하되, 20년 이상 장기 근속자만 출력되록한다.
select e.first_name 이름, d.department_name 부서명, months_between(sysdate, hire_date) / 12 근무년수
from employees e,
     departments d
where e.department_id = d.department_id
  and months_between(sysdate, hire_date) / 12 >= 10;

-- 5. 각 부서 이름별로 최대급여와 최소급여를 조회하시오. 단, 최대/최소급여가 동일한
-- 부서는 출력결과에서 제외시킨다.
select d.department_name 부서명, max(e.salary) 최대급여, min(e.salary) 최소급여
from employees e,
     departments d
where e.department_id = d.department_id
group by d.department_name
having max(e.salary) != min(e.salary);

-- 6. 자신이 속한 부서의 평균급여보다 많은 급여를 받는 직원정보만 조회하시오.
-- 단, 출력결과에 자신이 속한 부서의 평균 급여정보도 출력되어야한다.
select e.first_name 이름, a.department_name 부서명, e.salary 급여, a.avg 부셔평균급여
from employees e,
     (select d.department_name, d.department_id id, avg(e.salary) avg
      from employees e,
           departments d
      where e.department_id = d.department_id
      group by d.department_id, d.department_name) a
where e.department_id = a.id
  and e.salary >= a.avg;

-- 7. '월'별 최대급여자의 이름, 급여를 조회하시오.


-- 8. 부서별, 직급별, 평균급여를 조회하시오.
-- 단, 평균급여가 50번부서의 평균보다 많은 부서만 출력되어야 합니다.
select DEPARTMENT_NAME, JOB_TITLE, avg(SALARY)
from EMPLOYEES
         join JOBS using (JOB_ID)
         join DEPARTMENTS using (DEPARTMENT_ID)
group by DEPARTMENT_NAME, JOB_TITLE
having avg(SALARY) > (select avg(SALARY)
                      from EMPLOYEES
                      where DEPARTMENT_ID = 50)
order by 1, 2;

-- 9. 자신의 관리자보다 많은 급여를 받는 직원의 이름과 급여를 조회하시오.
select 직원.FIRST_NAME, 직원.SALARY
from EMPLOYEES 직원,
     EMPLOYEES 매니저
where 직원.MANAGER_ID = 매니저.EMPLOYEE_ID
  and 직원.SALARY > 매니저.SALARY;

select FIRST_NAME, SALARY
from EMPLOYEES emp1
where SALARY > (select emp2.SALARY
                from EMPLOYEES emp2
                where emp1.MANAGER_ID = emp2.EMPLOYEE_ID);

-- 10. 급여가 가장 많은 직원 6번째부터 10번째 직원만 출력하시오.
select *
from (select rownum rr, aa.*
      from (select first_name, salary
            from employees
            order by salary desc) aa
     )
where rr > 5 and rr <= 10;


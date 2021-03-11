--
-- hr/hr
-- ========================================
-- 		SELECT 기본
-- ========================================
--
-- 1. 급여가 15000 이상인 직원들의 이름, 급여, 부서id를 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       DEPARTMENT_ID                  부서ID
from EMPLOYEES
where SALARY >= 15000;

-- 2. 직원 중에서 연봉이 170000 이상인 직원들의 이름, 연봉을 조회하시오. 연봉은 급여(salary)에 12를 곱한 값입니다.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY * 12                    연봉
from EMPLOYEES
where SALARY * 12 >= 170000;

-- 3. 직원 중에서 부서id가 없는 직원의 이름과 급여를 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여
from EMPLOYEES
where DEPARTMENT_ID is null;

-- 4. 2004년 이전에 입사한 직원의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       HIRE_DATE                      입사일
from EMPLOYEES
where HIRE_DATE <= '20041231';
--
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       HIRE_DATE                      입사일
from EMPLOYEES
where to_char(HIRE_DATE, 'yyyy') <= 2004;
--
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       HIRE_DATE                      입사일
from EMPLOYEES
where substr(HIRE_DATE, 1, 2) <= '04';

-- -- 논리연산자 --
-- 1. 80, 50 번 부서에 속해있으면서 급여가 13000 이상인 직원의 이름, 급여, 부서id
-- 를 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       DEPARTMENT_ID                  부서ID
from EMPLOYEES
where (DEPARTMENT_ID = 80 or DEPARTMENT_ID = 50)
  and SALARY >= 13000;
--
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       DEPARTMENT_ID                  부서ID
from EMPLOYEES
where DEPARTMENT_ID in (50, 80)
  and SALARY >= 13000;

-- 2. 2005년 이후에 입사한 직원들 중에서 급여가 1300 이상 20000 이하인 직원들의 이름, 급여, 부서id, 입사일을 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       DEPARTMENT_ID                  부서ID,
       HIRE_DATE                      입사일
from EMPLOYEES
where HIRE_DATE >= '2005/01/01'
  and (SALARY >= 1300 and SALARY <= 20000);
--
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       DEPARTMENT_ID                  부서ID,
       HIRE_DATE                      입사일
from EMPLOYEES
where HIRE_DATE >= '2005/01/01'
  and SALARY between 1300 and 20000;

-- -- SQL 비교연산자 --
-- 1. 80, 50 번 부서에 속해있으면서 급여가 13000 이상인 직원의 이름, 급여, 부서id를 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       DEPARTMENT_ID                  부서ID
from EMPLOYEES
where DEPARTMENT_ID in (80, 50)
  and SALARY >= 13000;

-- 2. 2005년 이후에 입사한 직원들 중에서 급여가 1300 이상 30000 이하인 직원들의 이름, 급여, 부서id, 입사일을 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       DEPARTMENT_ID                  부서ID,
       HIRE_DATE                      입사일
from EMPLOYEES
where HIRE_DATE >= '2005/01/01'
  and SALARY between 1300 and 30000;

-- 3. 2005년도 입사한 직원의 정보만 출력하시오.
select *
from EMPLOYEES
where HIRE_DATE between '2005/01/01' and '2005/12/31';

-- 4. 이름이 D로 시작하는 직원의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       HIRE_DATE                      입사일
from EMPLOYEES
where LAST_NAME like 'D%';

-- 5. 12월에 입사한 직원의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       HIRE_DATE                      입사일
from EMPLOYEES
where HIRE_DATE like '__/12/__';

-- 6. 이름에 le 가 들어간 직원의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       HIRE_DATE                      입사일
from EMPLOYEES
where LAST_NAME like '%le%';

-- 7. 이름이 m으로 끝나는 직원의 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       HIRE_DATE                      입사일
from EMPLOYEES
where LAST_NAME like '%m';

-- 8. 이름의 세번째 글자가 r인 이름, 급여, 입사일을 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         급여,
       HIRE_DATE                      입사일
from EMPLOYEES
where LAST_NAME like '__r%';

-- 9. 커미션을 받는 직원의 이름, 커미션, 급여를 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       COMMISSION_PCT                 커미션,
       SALARY                         급여
from EMPLOYEES
where COMMISSION_PCT is not null;

-- 10. 커미션을 받지 않는 직원의 이름, 커미션, 급여를 조회하시오.
select FIRST_NAME || ' ' || LAST_NAME 이름,
       COMMISSION_PCT                 커미션,
       SALARY                         급여
from EMPLOYEES
where COMMISSION_PCT is null;

-- 11. 2000년대에 입사해서 30, 50, 80 번 부서에 속해있으면서,
-- 급여를 5000 이상 17000 이하를 받는 직원을 조회하시오.
-- 단, 커미션을 받지 않는 직원들은 검색 대상에서 제외시키며, 먼저 입사한 직원이
-- 먼저 출력되어야 하며 입사일이 같은 경우 급여가 많은 직원이 먼저 출력되록 하시오.
select *
from EMPLOYEES
where HIRE_DATE between '2001/01/01' and '2009/12/31'
  and DEPARTMENT_ID in (30, 50, 80)
  and SALARY between 5000 and 17000
  and COMMISSION_PCT is not null
order by HIRE_DATE asc, SALARY desc;


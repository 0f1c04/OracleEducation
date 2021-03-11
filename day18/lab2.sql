-- ========================================
-- 		단일행 함수
-- ========================================
--
-- 1. 이름이 'adam' 인 직원의 급여와 입사일을 조회하시오.
select SALARY    급여,
       HIRE_DATE 입사일
from EMPLOYEES
where FIRST_NAME = initcap('adam');

-- 2. 나라 명이 'united states of america' 인 나라의 국가 코드를 조회하시오.
select *
from COUNTRIES
where lower(COUNTRY_NAME) = 'united states of america';

-- 3. 'Adam의 입사일은 95/11/02 이고, 급여는 7000 입니다.' 이런 식으로 직원정보를 조회하시오.
select FIRST_NAME || '의 입사일은 ' || HIRE_DATE || ' 이고, 급여는 ' || SALARY || ' 입니다.'
from EMPLOYEES;

-- 4. 이름이 5글자 이하인 직원들의 이름, 급여, 입사일을 조회하시오.
select LAST_NAME 이름,
       SALARY    급여,
       HIRE_DATE 입사일
from EMPLOYEES
where length(LAST_NAME) <= 5;

-- 5.2006년도에 입사한 직원의 이름, 입사일을 조회하시오.
select LAST_NAME 이름,
       SALARY    급여,
       HIRE_DATE 입사일
from EMPLOYEES
where HIRE_DATE between '2006/01/01' and '2006/12/31';

-- 6. 7년 이상 장기 근속한 직원들의 이름, 입사일, 급여, 근무년차를 조회하시오.
select LAST_NAME                                      이름,
       HIRE_DATE                                      입사일,
       SALARY                                         급여,
       round(months_between(sysdate, HIRE_DATE) / 12) 근무년차
from EMPLOYEES
where round(months_between(sysdate, HIRE_DATE) / 12) >= 15;

--select review
select rownum, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where SALARY >= 10000
  and SALARY <= 20000
order by SALARY asc;

--and = between
select rownum, FIRST_NAME, LAST_NAME, SALARY
from EMPLOYEES
where SALARY between 10000 and 20000
order by SALARY asc;

--or --연산자 우선순위: not - and - or
select rownum, FIRST_NAME, LAST_NAME, SALARY, COMMISSION_PCT
from EMPLOYEES
where (SALARY between 10000 and 20000)
  and (COMMISSION_PCT = 0.3 or COMMISSION_PCT = 0.2)
order by SALARY asc;

--or = in
select EMPLOYEE_ID
from EMPLOYEES
where EMPLOYEE_ID in (100, 150, 200);

--2005~2007년 사이에 입사원 직원조회
select *
from EMPLOYEES
where HIRE_DATE >= '2005-01-01'
  and HIRE_DATE <= '2007-12-31';

--2005~2007년 사이에 입사원 직원조회 (between)
select *
from EMPLOYEES
where HIRE_DATE between '2005-01-01' and '2007-12-31';

--not in (100번 101번 102번 사원번호를 가진 직원 제외)
select *
from EMPLOYEES
where EMPLOYEE_ID not in (100, 101, 102);

select *
from EMPLOYEES
where EMPLOYEE_ID <> 100
  and EMPLOYEE_ID <> 101
  and EMPLOYEE_ID <> 102;

--like % _
--%: 0개 이상 아무문자 가능
--_: 1문자 아무문자 가능
select *
from EMPLOYEES
where FIRST_NAME like 'S%';

select *
from EMPLOYEES
where FIRST_NAME like '%s%';

--이름이 네자리인 사람
select *
from EMPLOYEES
where FIRST_NAME like '____';
--length()함수 사용
select *
from EMPLOYEES
where length(FIRST_NAME) = 4;

--첫 문자와 두 번째 문자는 아무거나, 세 번째는 꼭 s, 나머지는 아무거나
select *
from EMPLOYEES
where FIRST_NAME like '__s%';

--n으로 끝나는 직원정보 조회
select *
from EMPLOYEES
where FIRST_NAME like '%n';

--not like n으로 끝나지 않는 직원정보 조회
select *
from EMPLOYEES
where FIRST_NAME not like '%n';

--is null, is not null
--null은 비교연산자로 비교가 불가능하기 때문에 is null, is not null을 사용
select *
from EMPLOYEES
where DEPARTMENT_ID = null; --불가능

select *
from EMPLOYEES
where DEPARTMENT_ID is null;

select *
from EMPLOYEES
where DEPARTMENT_ID is not null;

--MANAGER_ID가 null인 사람 찾기 (사장)
select *
from EMPLOYEES
where MANAGER_ID is null;


--order by (정렬) 기본값: asc
--asc: 오름차순, desc: 내림차순
--커미션에 따라 정렬
select *
from EMPLOYEES
order by COMMISSION_PCT asc;

select *
from EMPLOYEES
order by COMMISSION_PCT desc nulls last;
--nulls last: null이 뒤에 나오게 하는 구문 (반대는 first)

--정렬의 기준(같은 기준일 때 어느 조건으로 정렬할 것인지)
--부서번호가 30 or 60 or 80인 부서 확인
select FIRST_NAME, SALARY, DEPARTMENT_ID, HIRE_DATE
from EMPLOYEES
where DEPARTMENT_ID in (30, 60, 80)
order by DEPARTMENT_ID asc;
--HIRE_DATE를 내림차순
select FIRST_NAME, SALARY, DEPARTMENT_ID, HIRE_DATE
from EMPLOYEES
where DEPARTMENT_ID in (30, 60, 80)
order by DEPARTMENT_ID asc, HIRE_DATE desc;
--sql문 해석순서: 1)from 2)where 3)select 4)order by
--select절이 order by절보다 순서가 빠르므로 SALARY*0.1을 계산 후 정렬 출력
select FIRST_NAME, SALARY, DEPARTMENT_ID, HIRE_DATE, SALARY * 0.1 tax
from EMPLOYEES
where DEPARTMENT_ID in (30, 60, 80)
order by tax desc, DEPARTMENT_ID asc, HIRE_DATE desc;
--tax가 같으면 DEPARTMENT_ID, DEPARTMENT_ID가 같으면 HIRE_DATE 비교해서 정렬


---------------------------------------

--SQL 주요함수
--DUAL 테이블을 활용하여 실습 (DUAL 테이블은 row 1, column 1라서 함수 실습에 좋음)
select 1 + 2
from DUAL;

--숫자 함수
select abs(-100)          절대값,
       floor(10.1)        소수점버림,
       ceil(10.1)         소수점버리고올림,
       round(10.1)        반올림,
       round(10.12312, 2) 반올림2,
       trunc(10.234, 2)   내림,
       mod(10, 3)         나머지
from DUAL;

--문자 함수
select lower('HELLO')                       소문자,
       upper('hello')                       대문자,
       initcap('hello world')               첫문자를대문자로,
       'hello' || '코스타'                     문자열연결,
       concat('hello', '코스타')               문자열연결concat, --concat은 두 문자열밖에 안됨 할라면 concat끼리 연결
       concat(concat('hello', '코스타'), '메롱') "문자열연결 concat 3문자",
       substr('hello world', 1, 5)          문자열자르기,
       length('안녕')                         문자열길이,
       lengthb('안녕')                        문자열길이를바이트로
from DUAL;
--substr()
select FIRST_NAME,
       length(FIRST_NAME)         이름자릿수,
       substr(FIRST_NAME, 1, 3)   "앞에서 3자리 자르기",
       substr(FIRST_NAME, 2)      "2자리에서 끝까지",
       substr(FIRST_NAME, -3, 3)  "끝에서 3자리 자르기",
       substr(FIRST_NAME, -3)     "끝에서 3자리 자르기",

       substr(HIRE_DATE, 1, 2)    년도,
       substr(HIRE_DATE, 4, 2)    월,
       substr(HIRE_DATE, 7, 2)    일,
       --to_char() 활용
       to_char(HIRE_DATE, 'yyyy') "년도 4자리",
       to_char(HIRE_DATE, 'mm')   "월"
from EMPLOYEES;

--9월에 입사한 직원
select * --substr() 활용
from EMPLOYEES
where substr(HIRE_DATE, 4, 2) = '09';

select * --to_char() 활용
from EMPLOYEES
where to_char(HIRE_DATE, 'mm') = '09';

select * --like 활용
from EMPLOYEES
where HIRE_DATE like '__/09/__';

--instr(): 특정 문자의 위치 구하기 (이름에 s가 들어있는 직원찾기)
select FIRST_NAME, instr(FIRST_NAME, 's')
from EMPLOYEES;

select FIRST_NAME
from EMPLOYEES
where instr(FIRST_NAME, 's') > 0;

select FIRST_NAME
from EMPLOYEES
where FIRST_NAME like '%s%';

--lpad(),rpad(): 특정 기호로 채우는 함수
select FIRST_NAME,
       lpad(FIRST_NAME, 10, ' ') lpad, --공백으로 채우기
       rpad(FIRST_NAME, 10, '#') rpad
from EMPLOYEES;

--trim
select ltrim('       oracle  ')  왼쪽공백지우기,
       rtrim('   oracle      ')  오른쪽지우기,
       trim('     oracle      ') 공백지우기
from EMPLOYEES;

--날짜 함수
select sysdate, sysdate - 1 어제, sysdate + 1 내일
from DUAL;

select HIRE_DATE, HIRE_DATE - 7 일주일전
from EMPLOYEES;

--특정 기준으로 반올림하는 round, trunc
select HIRE_DATE,
       HIRE_DATE - 7          일주일전,
       round(HIRE_DATE, 'mm') 월반올림,
       trunc(HIRE_DATE, 'mm') 월버림
from EMPLOYEES;

--months_between
select HIRE_DATE,
       round(months_between(sysdate, HIRE_DATE), 2)   "입사월수",
       round(months_between(sysdate, HIRE_DATE) / 12) "입사년수",
       trunc(sysdate - HIRE_DATE)                     입사일수
from EMPLOYEES;

--add_months
--오늘부터 4개월 후
select add_months(sysdate, 4)
from DUAL;

--last_day(): 해당 달의 마지막 날
select last_day(sysdate)
from DUAL;

--형변환 함수
--to_char: 날짜형 혹은 숫자형을 문자형으로 변환
--날짜시간을 문자로 변환
select to_char(HIRE_DATE, 'yyyy/mm/dd MON DAY DY hh:mi:ss') 날짜시간을문자로변경
from EMPLOYEES;
--숫자를 문자로 변환
select FIRST_NAME,
       SALARY,
       to_char(SALARY, 'L999,999.00') 급여
from EMPLOYEES;

select FIRST_NAME,
       to_char(SALARY, '000,000,000,000'),
       to_char(SALARY, '999,999,999,999')
from EMPLOYEES;

--to_date(): 날짜형으로 반환
select HIRE_DATE
from EMPLOYEES
where HIRE_DATE >= to_date('01012004', 'ddmmyyyy');

--nvl(): null을 다른 값으로 변환
select salary, salary * 0.1 세금, commission_pct, salary + SALARY * nvl(COMMISSION_PCT, 0) 수령액
from EMPLOYEES;

select FIRST_NAME,
       nvl(to_char(MANAGER_ID), '사장님')                     매니저,
       nvl(COMMISSION_PCT, 0)                              커미션,
       nvl(to_char(DEPARTMENT_ID), '부서없음')                 부서,
       nvl2(DEPARTMENT_ID, to_char(DEPARTMENT_ID), '부서없음') 부서2
from EMPLOYEES;

--nullif, coalesce
select FIRST_NAME,
       nullif(EMPLOYEE_ID, 60)                             "60번 부서인지",
       coalesce(COMMISSION_PCT, DEPARTMENT_ID, MANAGER_ID) "null이 아닌 처음값찾기"
from EMPLOYEES
where nullif(DEPARTMENT_ID, 60) is null;

--decode(): 선택을 위한 함수 (switch, if 같음) Java의 삼항연산자
select FIRST_NAME,
       DEPARTMENT_ID,
       decode(DEPARTMENT_ID, 10, '개발부', 20, '영업부', 30, '마케팅', '나머지') 조건에따른결과
from EMPLOYEES;

--case(): if else문이라 생각하셈
select FIRST_NAME,
       DEPARTMENT_ID,
       case
           when DEPARTMENT_ID <= 30 then '30보다 작아'
           when DEPARTMENT_ID <= 50 then '50보다 작아'
           when DEPARTMENT_ID <= 100 then '100보다 작아'
           else '기타' end "case 연습"
from EMPLOYEES;

-----------------------------------------
--jdbc 연습
select FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE
from EMPLOYEES
where EMPLOYEE_ID = 100;

select JOB_ID
from EMPLOYEES;

select * from employees where last_name like '%c%'
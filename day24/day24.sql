-- 서버에 설정 : 출력을 보여줌
set serverout on;

declare
begin
    dbms_output.put_line('Hello');
end;
/

declare
    /*스칼라 변수*/
    v_empno number(4);
    v_empname varchar2(20);
    /*레퍼런스 변수*/
    v_empno2 employees.employee_id%TYPE;
    v_empname2 employees.first_name%type;
    /*recode*/
    v_emp employees%rowtype;
begin
    v_empno := 100;
    v_empname := '홍길동';
    v_empno2 := 100;
    v_empname2 := '홍길동2';
    v_emp.salary := 10000;
    v_emp.first_name := '홍길동3';
    dbms_output.put_line('Hello');
    dbms_output.put_line('아이디는 '||v_empno);
    dbms_output.put_line('이름은 '||v_empname);
    dbms_output.put_line('아이디2는 '||v_empno2);
    dbms_output.put_line('이름2는 '||v_empname2);
    dbms_output.put_line('salary는 '||v_emp.salary);
    dbms_output.put_line('firstname은 '||v_emp.first_name);
end;
/

declare
    v_empid number := 100;
    v_fname employees.first_name%type;
    v_salary employees.salary%type;

    -- 테이블 타입 정의
    TYPE  ENAME_TABLE_TYPE IS TABLE OF employees.first_name%TYPE
        INDEX BY BINARY_INTEGER;
    TYPE  JOB_TABLE_TYPE IS TABLE OF employees.job_id%TYPE
        INDEX BY BINARY_INTEGER;
    -- 테이블 타입으로 변수 선언
    first_name_arr ENAME_TABLE_TYPE;
    job_id_arr JOB_TABLE_TYPE;
    idx BINARY_INTEGER := 0;

    TYPE emp_record_type IS RECORD(
        v_empno    employees.employee_id%TYPE,
        v_ename    employees.first_name%TYPE,
        v_job    employees.job_id%TYPE,
        v_deptno  employees.department_id%TYPE);

    emp_record emp_record_type;

    emp_record2 employees%rowtype;

begin
    select first_name, salary
    into v_fname, v_salary
    from employees
    where employee_id = v_empid;
    dbms_output.put_line('v_empid '||v_empid);
    dbms_output.put_line('v_fname '||v_fname);
    dbms_output.put_line('v_salary '||v_salary);

    FOR empRecord IN (SELECT first_name, JOB_id FROM employees) LOOP
            idx := idx + 1;                            --인덱스 증가
            first_name_arr(idx) := empRecord.first_name; --사원이름과
            job_id_arr(idx) := empRecord.JOB_id;       --직급을 저장.
        END LOOP;

    -- 확장for (1부터 idx까지)
    FOR J IN 1..idx LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(first_name_arr(J),12)  /*RPAD(변수, 12) : 12자리로 작성, 남으면 공백*/
                || ' / ' ||  RPAD(job_id_arr(J),9));
        END LOOP;

    DBMS_OUTPUT.PUT_LINE('=========================');

    SELECT employee_id, first_name, JOB_id, department_id
    into emp_record
    FROM employees
    where employee_id = 100;

    DBMS_OUTPUT.PUT_LINE(emp_record.v_empno);
    DBMS_OUTPUT.PUT_LINE(emp_record.v_ename);
    DBMS_OUTPUT.PUT_LINE(emp_record.v_job);
    DBMS_OUTPUT.PUT_LINE(emp_record.v_deptno);

    DBMS_OUTPUT.PUT_LINE('**************************');

    SELECT *
    into emp_record2
    FROM employees
    where employee_id = 100;

    DBMS_OUTPUT.PUT_LINE(emp_record2.employee_id);
    DBMS_OUTPUT.PUT_LINE(emp_record2.last_name);
    DBMS_OUTPUT.PUT_LINE(emp_record2.email);
    DBMS_OUTPUT.PUT_LINE(emp_record2.salary);
end;
/

declare
    emp_record2 employees%rowtype;
begin
    SELECT *
    into emp_record2
    FROM employees
    where employee_id = 100;

    if(emp_record2.commission_pct is null) then
        DBMS_OUTPUT.PUT_LINE('null이다'||emp_record2.salary*12);
    else
        DBMS_OUTPUT.PUT_LINE('null이 아니다'||emp_record2.salary*12+emp_record2.salary*emp_record2.commission_pct);
    end if;
    DBMS_OUTPUT.PUT_LINE(emp_record2.employee_id);
    DBMS_OUTPUT.PUT_LINE(emp_record2.last_name);
    DBMS_OUTPUT.PUT_LINE(emp_record2.email);
    DBMS_OUTPUT.PUT_LINE(emp_record2.salary);
end;
/

declare
    num number := 1;
begin
    /*1번째 방법*/
    loop
        DBMS_OUTPUT.PUT_LINE('loop : '||num);
        num := num+1;
        if(num > 5) then
            exit;
        end if;
    end loop;
    /*2번째 방법*/
    for i in 1..5 loop
            dbms_output.put_line('for : '||i);
        end loop;
    /*3번째 방법*/
    num := 1;
    while(num <= 5) loop
            DBMS_OUTPUT.PUT_LINE('while loop : '||num);
            num := num+1;
        end loop;
end;
/

create or replace procedure sp_print5
    is
    num number := 1;
begin
    /*1번째 방법*/
    loop
        DBMS_OUTPUT.PUT_LINE('loop : '||num);
        num := num+1;
        if(num > 5) then
            exit;
        end if;
    end loop;
    /*2번째 방법*/
    for i in 1..5 loop
            dbms_output.put_line('for : '||i);
        end loop;
    /*3번째 방법*/
    num := 1;
    while(num <= 5) loop
            DBMS_OUTPUT.PUT_LINE('while loop : '||num);
            num := num+1;
        end loop;
end;
/

select * from user_source where name = 'SP_PRINT5';

variable a varchar2(20);
variable b varchar2(20);
variable c number;

execute sp_empinfo(100, :a, :b, :c);
print a;
print b;
print c;
create or replace procedure sp_empinfo(empid in number, fname out varchar2, job out varchar2, sal out number)
    is
    -- 변수선언
    aa varchar2(20);
begin
    select first_name, job_id, salary
    into fname, job, sal
    from employees
    where employee_id = empid;
end;
/

-- day24 추가 예정
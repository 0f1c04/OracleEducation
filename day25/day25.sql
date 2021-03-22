create or replace procedure sp_emplist
    is
    -- 선언부 : 변수선언
    v_emp_record employees%rowtype;
    -- 1. 커서 선언
    cursor cur_emp is select employee_id, first_name, last_name
                      from employees;

begin
    -- 실행부 : 실행문장
    -- 2. 커서 실행
    open cur_emp;
    -- 3. 한건 씩 fetch
    loop
        fetch cur_emp into v_emp_record.employee_id, v_emp_record.first_name, v_emp_record.last_name;
        exit when cur_emp%notfound; -- 더이상 데이터가 없으면 loop 빠져나옴
        dbms_output.put_line('직원 번호 : ' || v_emp_record.employee_id);
        dbms_output.put_line('직원 first_name : ' || v_emp_record.first_name);
        dbms_output.put_line('직원 last_name : ' || v_emp_record.last_name);
        dbms_output.put_line('----------------------------------------');
    end loop;
    -- 4. 커서 닫기
    close cur_emp;
end;
/

set serverout on;

execute sp_emplist;

-- trigger (insert)
create or replace trigger trigger_jobs
    after insert
    on JOBS
    for each row
begin
    dbms_output.PUT_LINE('jobs table에 1건 입력');
    insert into jobs_ref values (job_ref_seq.nextval, 1000, :NEW.job_id);
end;
/

desc jobs;

insert into jobs
values ('test12', 'test12', 1000, 2000);
select *
from jobs;

-- create sequence
create sequence job_ref_seq;

create table jobs_ref
(
    salno  number(4) primary key,
    sal    number(7, 2),
    job_id varchar2(10) references jobs (job_id)
);

select *
from jobs_ref;

-- trigger (delete)
create or replace trigger trigger_jobs_del
    after insert
    on JOBS
    for each row
begin
    dbms_output.PUT_LINE('jobs table에 1건 삭제');
    delete from jobs_ref where job_id = :OLD.job_id;
end;
/

select *
from jobs;
delete
from jobs
where job_id = 'test12';

select *
from jobs_ref;

--

CREATE TABLE 상품
(
    상품코드  CHAR(6) PRIMARY KEY,
    상품명   VARCHAR2(12) NOT NULL,
    제조사   VARCHAR(12),
    소비자가격 NUMBER(8),
    재고수량  NUMBER DEFAULT 0
);

select *
from 상품;

INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격)
VALUES ('A00001', '세탁기', 'LG', 500);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격)
VALUES ('A00002', '컴퓨터', 'LG', 700);
INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격)
VALUES ('A00003', '냉장고', '삼성', 600);

select *
from 상품;

commit;


CREATE TABLE 입고
(
    입고번호 NUMBER(6) PRIMARY KEY,
    상품코드 CHAR(6) REFERENCES 상품 (상품코드),
    입고일자 DATE DEFAULT SYSDATE,
    입고수량 NUMBER(6),
    입고단가 NUMBER(8),
    입고금액 NUMBER(8)
);

select *
from 입고;

-- 입고 트리거
CREATE OR REPLACE TRIGGER TRG_04
    AFTER INSERT
    ON 입고
    FOR EACH ROW
BEGIN
    UPDATE 상품
    SET 재고수량 = 재고수량 + :NEW.입고수량
    WHERE 상품코드 = :NEW.상품코드;
END;
/

INSERT INTO 입고(입고번호, 상품코드, 입고수량, 입고단가, 입고금액)
VALUES (4, 'A00002', 120, 320, 1600);

SELECT *
FROM 입고;
SELECT *
FROM 상품;

-- 갱신 트리거
CREATE OR REPLACE TRIGGER TRG03
    AFTER UPDATE
    ON 입고
    FOR EACH ROW
BEGIN
    UPDATE 상품
    SET 재고수량 = 재고수량 + (-:old.입고수량 + :new.입고수량)
    WHERE 상품코드 = :new.상품코드;
END;
/

UPDATE 입고
SET 입고수량=10,
    입고금액=2200
WHERE 입고번호 = 3;
SELECT *
FROM 입고
ORDER BY 입고번호;
SELECT *
FROM 상품;

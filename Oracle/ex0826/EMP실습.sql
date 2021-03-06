-- 각자의 계정으로 접속.
--계정생성
CREATE USER EXAM IDENTIFIED BY EXAM;

--기본 권한 부여
GRANT CONNECT , RESOURCE TO EXAM;

--접속 CONN EXAM/EXAM


drop table emp;

--emp 테이블 생성
Create Table emp(
	emp_id 	   NUMBER(4)  Primary KEY, --사원번호
	emp_name	 Varchar2(30) Not Null,  --사원이름
	job      	               Varchar2(20) Not Null,  --직업
	dept_id  	  NUMBER(3), --부서번호
	sal 	              NUMBER(5) Not Null,--급여
	bonus	              NUMBER(5),--보너스
	mgr_id	              NUMBER(5),--관리자번호
	hiredate             date  Not Null --입사일
)



--데이터삽입

INSERT INTO EMP VALUES (6200,'박철수','대표이사',200,  5000,NULL,NULL, '1997-12-17');

INSERT INTO EMP VALUES (6311,'김대정','부장',100, 3500,Null,6200, '1998-12-17');

INSERT INTO EMP VALUES (7489,'민동규','세일즈',400,  1850,200,6321, '1999-02-27') ;

INSERT INTO EMP VALUES (7522,'정종철','세일즈',400, 1850,300,6321,'1998-02-28') ;

INSERT INTO EMP VALUES (6321,'이종길','부장',400, 3800,500,6200,'1999-04-20') ;

INSERT INTO EMP VALUES (6351,'진대준','부장',300,   2850,NULL,6200,'2000-05-31');

INSERT INTO EMP VALUES (7910,'이영희','경리',300, 1000,NULL,6351,'2001-05-01');

INSERT INTO EMP VALUES (6361,'김철수','부장',200, 3200,NULL,6200,'2000-06-09') ;

INSERT INTO EMP VALUES (7878,'백기수','연구직',200, 3000,NULL,6361,'2001-06-05') ;

INSERT INTO EMP VALUES (7854,'진영진','세일즈',400, 1500,0,6321,'2001-09-08') ;

INSERT INTO EMP VALUES (7872,'이문정','사무직',100, 1500,NULL,6311,'2001-02-12') ;

INSERT INTO EMP VALUES (7920,'김마리아','사무직',300, 1050,NULL,6351,'2001-03-18');

INSERT INTO EMP VALUES (7901,'정동길','연구직',NULL, 3000,NULL,NULL,'2001-12-03');

INSERT INTO EMP VALUES (7933,'김철수','사무직',200,  1050,NULL,6361,'2002-01-02');


--1. emp 테이블에서 각 사원 emp_name의 급여(sal)에 100을 더한 후 12를 곱한 값이 출력되도록 select절에 산술식을 사용해보세요
select emp_name, ((sal+100)*12) as 계산 from emp;

--2. 담당업무 job이 세일즈인 모든 사원의 이름, 담당업무, 부서번호를 검색해보세요
select emp_name, job, dept_id from emp where job='세일즈';

--3. 입사일이 2001년 12월 3일인 모든 사원을 검색하세요
select * from emp where hiredate='2001-12-03';
select * from emp where to_char(hiredate,'YYYY"년"MM"월"DD"일"') = '2001년12월03일';

--4. 부서번호가 200인 부서에서 근무하는 모든 사원의 이름과 담당업무,입사일, 부서번호 검색하세요.
select emp_name, job, hiredate, dept_id from emp where dept_id=200;

--5. emp테이블에서 급여가 3000이상 5000이하인 모든 사원의 이름과 급여를 출력하세요.
select emp_name, sal from emp where sal between 3000 and 5000;

--6. emp 테이블에서 관리자번호가 6311, 6361, 6351 가운데 하나인 모든 사원의 사원번호, 관리자번호, 이름, 부서번호를 출력하세요
select emp_id, mgr_id, emp_name, dept_id from emp where mgr_id in(6311, 6361, 6351);

--7. 담당업무가 사무직이거나 경리인 사원의 모든 정보를 검색하세요.
select * from emp where job in('사무직','경리');

--8. emp 테이블에서 급여가 3000이상인 모든 부장의 정보를 검색하세요
select * from emp where sal >= 3000 and job='부장';

--9. emp 테이블에서 담당업무가 세일즈이거나 사무직이 아닌 모든 사원의 정보를 검색하세요
select * from emp where not job = '사무직';
select * from emp where job not in('세일즈','사무직');

--10. emp 테이블에서 급여가 1500이상 2500 이하가 아닌 모든 사원의 정보를 검색하세요
select * from emp where not sal between 1500 and 2500;

--11. 담당업무가 경리이거나 부장이면서 급여가 3000이 넘는 모든 사원의 정보를 검색하고 가장 먼저 입사한 사람부터 출력하세요
select * from emp where job = '경리' or job = '부장' and sal >= 3000 order by hiredate;

--12. 사원의 부서번호를 기준으로 오름차순으로 정렬하되, 같은 부서 안에서는 급여가 많은 사람이 먼저 출력 되도록하세요.
select * from emp order by dept_id , sal desc;

--13. 보너스가 null이 아니면서 입사일이 2000년 이상인 사원의 정보를 검색하세요
select * from emp where bonus is not null and hiredate >= '2000-01-01';
select * from emp where bonus is not null and to_char(hiredate,'yyyy') >= '2000';

--14. emp_name이 3글자이고 끝 글자가 '수'이며 첫글자는 '박'으로 시작하는 사원의 정보검색하세요
select * from emp;
select * from emp where emp_name LIKE '박_수';

--15. 보너스가 null인 사원의 보너스를 0으로 변경하세요
update emp set bonus = 0 where bonus is null; -- 수행능력 빠름. where 절로 먼저 선별해서 보기 때문 
update emp set bonus = nvl(bonus, 0); -- 수행능력 느림. 전체 레코드를 보기 때문

--16. 직업이 '직'으로 끝나면서 급여가 2000~3000 사이인 사원의 이름을 '장동건' 급여를 3500으로 변경하세요
update emp set emp_name ='장동건', sal=3500 where job like '%직';

--17. emp_name에 '철'자가 들어가면서 직급이 부장인 사원의 정보를 삭제하세요.
delete emp where emp_name like '%철%' and job = '부장';

--18. 테이블을 삭제하세요 
drop table emp;

--DDL : CREATE, ALTER, DROP - ROLLBACK 안됨
--DML : INSERT, UPDATE, DELETE - ROLLBACK 가능 


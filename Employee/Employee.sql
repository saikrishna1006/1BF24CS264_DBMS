create database employee;
use employee;
create table DEPT(DEPT_NO int primary key,DNAME varchar(30),DLOC varchar(30));
create table EMP(EMP_NO int primary key,ENAME varchar(30),MNG_NO int,HIRE_DATE date,SAL int,DEPT_NO int ,Foreign key (DEPT_NO) references DEPT(DEPT_NO));
create table PROJECT(PNO int primary key,PNAME varchar(30),PLOC varchar(30));
create table INCENTIVES(EMP_NO int ,INCENTIVE_DATE date primary key,Amount int,foreign key (EMP_NO) references EMP(EMP_NO));
create table ASSIGNED_TO(EMP_NO int,PNO int,JOB_ROLE varchar(30),foreign key (EMP_NO) references EMP(EMP_NO),foreign key (PNO) references PROJECT(PNO));

INSERT INTO dept VALUES (10,"ACCOUNTING","MUMBAI");
INSERT INTO dept VALUES (20,"RESEARCH","BENGALURU");
INSERT INTO dept VALUES (30,"SALES","DELHI");
INSERT INTO dept VALUES (40,"OPERATIONS","CHENNAI");

INSERT INTO emp VALUES (7369,'Adarsh',7902,'2012-12-17',80000.00,20);
INSERT INTO emp VALUES (7499,'Shruthi',7698,'2013-02-20',16000.00,30);
INSERT INTO emp VALUES (7521,'Anvitha',7698,'2015-02-22',12500.00,30);
INSERT INTO emp VALUES (7566,'Tanvir',7839,'2008-04-02',29750.00,20);
INSERT INTO emp VALUES (7654,'Ramesh',7698,'2014-09-28',12500.00,30);
INSERT INTO emp VALUES (7698,'Kumar',7839,'2015-05-01',28500.00,30);
INSERT INTO emp VALUES (7782,'CLARK',7839,'2017-06-09',24500.00,10);
INSERT INTO emp VALUES (7788,'SCOTT',7566,'2010-12-09',30000.00,20);
INSERT INTO emp VALUES (7839,'KING',NULL,'2009-11-17',500000.00,10);
INSERT INTO emp VALUES (7844,'TURNER',7698,'2010-09-08',15000.00,30);
INSERT INTO emp VALUES (7876,'ADAMS',7788,'2013-01-12',11000.00,20);
INSERT INTO emp VALUES (7900,'JAMES',7698,'2017-12-03',9500.00,30);
INSERT INTO emp VALUES (7902,'FORD',7566,'2010-12-03',30000.00,20);

INSERT INTO incentives VALUES(7499,'2019-02-01',5000.00);
INSERT INTO incentives VALUES(7521,'2019-03-01',2500.00);
INSERT INTO incentives VALUES(7566,'2022-02-01',5070.00);
INSERT INTO incentives VALUES(7654,'2020-02-01',2000.00);
INSERT INTO incentives VALUES(7654,'2022-04-01',879.00);
INSERT INTO incentives VALUES(7521,'2019-05-01',8000.00);
INSERT INTO incentives VALUES(7698,'2019-04-01',500.00);
INSERT INTO incentives VALUES(7698,'2020-03-01',9000.00);
INSERT INTO incentives VALUES(7698,'2022-05-01',4500.00);

INSERT INTO project VALUES(101,"AI Project","BENGALURU");
INSERT INTO project VALUES(102,"IOT","HYDERABAD");
INSERT INTO project VALUES(103,"BLOCKCHAIN","BENGALURU");
INSERT INTO project VALUES(104,"DATA SCIENCE","MYSURU");
INSERT INTO project VALUES(105,"AUTONOMUS SYSTEMS","PUNE");

INSERT INTO assigned_to VALUES(7499,101,"Software Engineer");
INSERT INTO assigned_to VALUES(7521,101,'Software Architect');
INSERT INTO assigned_to VALUES(7566,101,'Project Manager');
INSERT INTO assigned_to VALUES(7654,102,'Sales');
INSERT INTO assigned_to VALUES(7521,102,'Software Engineer');
INSERT INTO assigned_to VALUES(7499,102,'Software Engineer');
INSERT INTO assigned_to VALUES(7654,103,'Cyber Security');
INSERT INTO assigned_to VALUES(7698,104,"Software Engineer");
INSERT INTO assigned_to VALUES(7900,105,"Software Engineer");
INSERT INTO assigned_to VALUES(7839,104,"General Manager");
 
select EMP_NO from ASSIGNED_TO where PNO in (select PNO from PROJECT where PLOC in ("BENGALURU","HYDERABAD","MYSURU"));

select EMP_NO from emp where EMP_NO not in(select EMP_NO from incentives);
 
select ename,sal from emp as m where m.EMP_NO in (select mng_no from emp) and m.sal > (select avg(e.sal) from emp as e where e.mng_no = m.emp_no);

select ename,dept_no from emp e where e.dept_no = (select e1.dept_no from emp e1 where e1.emp_no = e.mng_no);

select *
from emp e,incentives i
where e.emp_no=i.emp_no and 2 = ( select count(*)
from incentives j
where (i.amount<=j.amount ));

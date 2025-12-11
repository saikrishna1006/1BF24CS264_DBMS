create database suppliers;
use suppliers;

create table supplier(sid int primary key,sname varchar(20),city varchar(20));
insert into supplier(sid,sname,city) values(1001,"Acme Widget","Banglore"),(1002,"Jhons","Kolkata"),(1003,"Vimal","Mumbai"),(1004,"Reliance","Delhi");

create table parts(pid int primary key,pname varchar(20),color varchar(15));
insert into parts(pid,pname,color) values (20001,"Book","Red"),(20002,"Pen","Red"),(20003,"Pencil","Green"),(20004,"Mobile","Green"),(20005,"Charger","Black");

create table Catalog(sid int,foreign key (sid) references supplier(sid),pid int,foreign key (pid) references parts(pid),cost int);
alter table Catalog add constraint primary key(sid,pid);
insert into catalog(sid,pid,cost) values (1001,20001,10),(1001,20002,10),(1001,20003,30),(1001,20004,10),(1001,20005,10),(1002,20001,10),(1002,20002,20),(1003,20003,30),(1004,20003,40);

select pname from parts where(pid in (select distinct(pid) from catalog));

select sname from supplier s where((select count(pid) from parts p)=(select count(c.pid) from catalog c where(c.sid=s.sid)));	

SELECT S.sname FROM Supplier S WHERE (( SELECT count(P.pid) FROM Parts P where color="Red") = ( SELECT count(C.pid) FROM Catalog C, Parts P WHERE C.sid = S.sid AND C.pid = P.pid AND P.color ="Red"));

select distinct C.sid from catalog C where(C.cost>(select avg(c1.cost) from catalog c1 where (c1.pid=c.pid)));

SELECT P.pid, S.sname FROM Parts P, Supplier S, Catalog C WHERE C.pid = P.pid AND C.sid = S.sid AND C.cost = (SELECT MAX(C1.cost) FROM Catalog C1 WHERE C1.pid = P.pid);

SELECT p.pname, s.sname, c.cost
FROM Catalog c
JOIN parts p ON c.pid = p.pid
JOIN supplier s ON c.sid = s.sid
WHERE c.cost = (SELECT MAX(cost) FROM Catalog);

Select s.sname
from supplier s 
where s.sid not in ( select sid from catalog c join parts p on p.pid = c.pid where p.color = "Red");

SELECT S.SNAME ,SUM(COST)
FROM CATALOG C
JOIN SUPPLIER S ON S.SID = C.SID
GROUP BY C.SID;

SELECT s.sname
FROM supplier s
WHERE s.sid IN (SELECT c.sid
				FROM catalog c
				WHERE c.cost < 20
				AND c.pid IN (SELECT b.pid
							FROM catalog b
							GROUP BY b.pid
							HAVING COUNT(b.pid) >= 2));

SELECT s.sname, p.pname, c.cost
FROM catalog c
JOIN supplier s ON s.sid = c.sid
JOIN parts p ON p.pid = c.pid
WHERE c.cost = (
    SELECT MIN(c2.cost)
    FROM catalog c2
    WHERE c2.pid = c.pid
);

create view SAI as
select s.sname ,count(c.pid)
from supplier s
join catalog c on c.sid= s.sid
group by s.sid; 

select * from sai;

create view M as
SELECT s.sname, p.pname, c.cost
FROM catalog c
JOIN supplier s ON s.sid = c.sid
JOIN parts p ON p.pid = c.pid
WHERE c.cost = (
    SELECT MAX(c2.cost)
    FROM catalog c2
    WHERE c2.pid = c.pid
);
select * from M;




--Report 1
select * from "winner" natural join "cast" natural join (select cid, "companies".name as "company name", mid, "movies".name as "movie name"
						from "companies", "movies"
						where "companies".cid = "movies".companyid) as sub1

--Report 2 (for top 250)
SELECT mid, name, sum(sale)
FROM "movies" natural join "boxoffice"
group by mid, name
ORDER BY sum(sale) DESC
LIMIT 5

--Report 3
select mid, pid, name, sum(sale) from (select *
			  from "person" natural join "cast") as sub1 natural join "boxoffice"
group by mid, pid, name
having sum(sale) > 100

--Report 4
select "Network"  from (select "network".name as "Network", count(*) as num
					from "network", "series"
					where "network".nid = "series".networkid
					group by "Network") as sub1
where num = ( select max(num) from (select "network".name as "Network", count(*) as num
					from "network", "series"
					where "network".nid = "series".networkid
					group by "Network") as sub1)
					
--Report 5
SELECT mid, cid, "company name", "movie name", sum(sale)
FROM (select cid, "companies".name as "company name", mid, "movies".name as "movie name"
						from "companies", "movies"
						where "companies".cid = "movies".companyid) as sub1 natural join "boxoffice"
group by mid, cid, "company name", "movie name"
ORDER BY sum(sale) DESC
LIMIT 10

--Report 6
select festival_name from "person" natural join "winner"

--Report 7
select * from "movies"
where year between '2019-01-01' and '2019-12-30'
order by rate desc
limit 5

--Report 8
select name, count(name)
from  "person" natural join "cast"  natural join  "winner" 
group by name
order by count (name) desc
limit 1

--Report 9
select sale
from   "movies" natural join "boxoffice"  natural join  "winner"

--Report 10
select festival_name, count(festival_name)
from "winner" natural join "cast" natural join (select cid, "companies".name as "company name", mid, "movies".name as "movie name"
						from "companies", "movies"
						where "companies".cid = "movies".companyid) as sub1 
group by festival_name


select * from "companies"
select * from "movies"
select * from "series"
select * from "person"
select * from "cast"
select * from "winner"
select * from "award"
select * from "event"
select * from "festival"
select * from "boxoffice"
select * from "network"
select * from "M&S"
insert into "festival" values('Oscar')
insert into "festival" values('Golden Glob')
insert into "event" values('Oscar', '1975-01-01')
insert into "award" values('Oscar', 'Best Actor')
insert into "person" values(1, 'Marlon Brando')
insert into "cast" values(1,1, 'Actor')
update "companies" set name = 'Paramount' where cid = 0
insert into "winner" values(1,1,'Actor', 'Oscar','Oscar', 'Best Actor', '1975-01-01' )
insert into "movies" values(2, 'Dark Knight', 8.5, 1, '2008-01-01', 2.1, 0)
insert into "movies" values(3, 'Star Wars', 8.4, 1, '1977-01-01', 2.1, 0)
insert into "movies" values(4, 'Avengers', 8.3, 1, '2019-01-01', 2.1, 0)
insert into "movies" values(5, 'A Seperate', 8.4, 1, '2011-01-01', 2.1, 0)
insert into "movies" values(6, 'Joker', 8.4, 1, '2019-01-01', 2.1, 0)
update "movies" set rate = 8.2 where mid = 5
insert into "M&S" values(1,0, 'God Father')
insert into "M&S" values(2,0, 'Dark Knight')
insert into "M&S" values(3,0, 'Star Wars')
insert into "M&S" values(4,0, 'Avengers')
insert into "M&S" values(5,0, 'A Seperate')
insert into "M&S" values(6,0, 'Joker')
insert into "boxoffice" values(1, '2000-01-01', 100)
insert into "boxoffice" values(1, '2000-01-02', 200)
insert into "boxoffice" values(2, '2000-01-01', 200)
insert into "boxoffice" values(3, '2000-01-01', 300)
insert into "boxoffice" values(4, '2000-01-01', 400)
insert into "boxoffice" values(5, '2000-01-01', 500)
insert into "boxoffice" values(6, '2000-01-01', 600)
update "series" set networkid = 3 where sid  = 1
insert into "network" values(1, 'HBO')
insert into "network" values(2, 'BBC ONE')
insert into "network" values(3, 'amc')
insert into "series" values(3, 'Doctor Who', 8.6, 1, '2005-01-01', 130, 2)
insert into "series" values(4, 'Sherlock', 9.1, 1, '2010-01-01', 130, 2)
insert into "M&S" values(0,1, 'TWD')
insert into "M&S" values(0,2, 'GOT')
insert into "M&S" values(0,3, 'Doctor Who')
insert into "M&S" values(0,4, 'Sherlock')



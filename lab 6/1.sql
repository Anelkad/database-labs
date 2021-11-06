--a
select * from dealer,client;
--b
select d.name, c.name, c.city, c.priority, s.id, s.date, s.amount
from dealer d inner join client c on d.id = c.dealer_id
inner join sell s on c.id = s.client_id and d.id=s.dealer_id;
--c
select d.name, c.name
from dealer d inner join client c on d.id = c.dealer_id and c.city=d.location;
--d
select s.id, s.amount, c.city, s.amount
from sell s inner join client c on c.id = s.client_id
where s.amount between 100 and 500;
--e
select d.name, count(c.name)
from dealer d left outer join client c on d.id = c.dealer_id
group by d.name;
--f
select c.name, c.city, d.name, s.id, d.charge as commission
from dealer d inner join client c on d.id = c.dealer_id
inner join sell s on c.id = s.client_id and d.id=s.dealer_id;
--g
select c.name, c.city, d.name, d.charge as commission
from dealer d inner join client c on d.id = c.dealer_id
inner join sell s on c.id = s.client_id and d.id=s.dealer_id
where d.charge>0.12;
--h
select c.name, c.city, s.id, s.date, s.amount, d.name, d.charge
from dealer d full outer join client c on d.id = c.dealer_id
full outer join sell s on c.id = s.client_id;
--i
select c.name, c.priority, d.name, count(s.id), sum(s.amount)
from client c full outer join sell s on c.id = s.client_id
right join dealer d on d.id = c.dealer_id
group by c.name, c.priority, d.name
having c.priority is not NULL and sum(s.amount)>2000 or count(s.id)=0;

--2
create view clients_by_date as
    select date, count(distinct client_id), avg(amount), sum(amount)
    from sell
    group by date
    order by date;
--a
select * from clients_by_date;

create view top5days as
    select date, sum(amount) as total
    from sell
    group by date
    order by total desc
    limit 5;
--b
select * from top5days;

create view dealer_report as
    select s.dealer_id, d.name, count(s.id) as number_of_sales, avg(s.amount) as avg, sum(s.amount) as total
    from dealer d inner join sell s on d.id=s.dealer_id
    group by s.dealer_id, d.name;
--c
select * from dealer_report;

create view loc_deal as
    select d.location, sum(d.charge * s.amount)
    from dealer d inner join sell s on d.id=s.dealer_id
    group by d.location;
--d
select * from loc_deal;

create view loc_deal2 as
    select d.location, count(s.id) as count, avg(s.amount) as avg, sum(s.amount) as total
    from dealer d inner join sell s on d.id=s.dealer_id
    group by d.location;
--e
select * from loc_deal2;

create view loc_client as
    select c.city, count(s.id) as count, avg(s.amount) as avg, sum(s.amount) as total
    from client c inner join sell s on c.id=s.client_id
    group by c.city;
--f
select * from loc_client;

create view c_more_d as
    select c.city, c.total as expense, l.total
    from loc_client c inner join loc_deal2 l on c.city = l.location
    where c.total > l.total;
--g
select * from c_more_d;

drop view clients_by_date;
drop view top5days;
drop view dealer_report;
drop view loc_deal;
drop view loc_deal2;
drop view loc_client;
drop view c_more_d;
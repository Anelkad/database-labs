--1
select EXTRACT(year FROM s.date_of_sale) as year,
       EXTRACT(month FROM s.date_of_sale) as month,
       EXTRACT(week FROM s.date_of_sale) as week,
       v.brand_name, ci.gender, count(s.vin) as count
from sales s natural join vehicles v
inner join client_info ci on s.client_id = ci.id
group by v.brand_name,year, month,week, ci.gender
order by year, month,week;

select div(ci.annual_income,1000000)*1000000 as income,
       EXTRACT(year FROM s.date_of_sale) as year,
       EXTRACT(month FROM s.date_of_sale) as month,
       EXTRACT(week FROM s.date_of_sale) as week,
       v.brand_name, count(s.vin) as count
from sales s natural join vehicles v
inner join client_info ci on s.client_id = ci.id
group by income, v.brand_name, year, month,week
order by year, month,week;

--2
create view plant_product as
    select *
    from plants p natural join manufacture  m;

create or replace view client_info as
    select p.id, p.name, p.surname, s.vin, s.date_of_sale, p.city, p.phone_number, p.gender, c.annual_income
    from persons p inner join clients c on p.id = c.client_id
    inner join sales s on c.client_id = s.client_id;

select v.vin, c.name, c.surname, p.name,v.date_of_made
from plant_product p
inner join vehicles v on v.brand_name=p.brand_name
full outer join client_info c on c.vin=v.vin
where p.product='transmission' and
      p.name='Gunma Oizumi Plant' and
      v.date_of_made>'2019-01-01' and v.date_of_made<'2019-10-10';

--3
select v.brand_name, sum(s.sum) as sum
from sales s natural join vehicles v
where EXTRACT(year FROM s.date_of_sale) = 2020
group by v.brand_name
order by sum desc
limit 2;

--4
select v.brand_name, count(s.vin) as count
from sales s natural join vehicles v
where EXTRACT(year FROM s.date_of_sale) = 2020
group by v.brand_name
order by count desc
limit 2;

--5
select EXTRACT(month FROM s.date_of_sale) as month, count(v.vin) as count
from sales s natural join vehicles v natural join models m
where m.body_style='crossover'
group by month
order by count desc;


--6
select i.dealer_id, p.name, p.surname, avg(now()-i.arrival_date) as time
from inventory i inner join persons p on i.dealer_id=p.id
where i.status='available'
group by i.dealer_id, p.name, p.surname
order by time desc;

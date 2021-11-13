--1
--Large objects (photos, videos, CAD files, etc.) are stored as a large object:
--• blob: binary large object -- object is a large collection of uninterpreted binary data
-- (whose interpretation is left to an application outside of the database system)
--• clob: character large object -- object is a large collection of character data
--2
--grant <privilege list> on <relations> to <user or role>
--	create accountant, administrator, support roles and grant appropriate privileges
create role accountant;
grant select on transactions to accountant;
create role administrator;
grant insert, delete on accounts, customers, transactions to administrator;
create role support;
grant update on accounts, customers to support;
--	create some users and assign them roles,
create user Alex;
create user Jax;
grant support to Alex;
grant accountant to Jax;
--	give to some of them permission to grant roles to other users
grant select on transactions to Alex with grant option;
--	revoke some privilege from particular user
revoke select on transactions from Alex;
--4
create domain Currency as varchar(3);
alter table accounts
alter column currency type varchar(3);
--5.1
create index cust_index on accounts(customer_id, currency);
--5.2
create index trans_index on accounts(currency, balance);
create index src_index on transactions(src_account);
create index dst_index on transactions(dst_account);

--6
begin;
INSERT INTO transactions VALUES (4, '2021-08-05 18:02:45.000000', 'RS88012', 'NT10204', 1000, 'init');
update accounts set balance=balance+1000 where account_id='NT10204';
update accounts set balance=balance-1000 where account_id='RS88012';

rollback;
update transactions set status='rollback' where id=4;

update transactions set status='commit' where id=4;
commit;
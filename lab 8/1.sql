--1
--a
CREATE FUNCTION inc(val integer) RETURNS integer AS $$
BEGIN 
RETURN val + 1; 
END; $$ 
LANGUAGE PLPGSQL;

select * from inc(1);
--b
CREATE FUNCTION sum(val1 integer, val2 integer) RETURNS integer AS $$
BEGIN
RETURN val1 + val2;
END; $$
LANGUAGE PLPGSQL;

select * from sum(1,2);
--c
CREATE FUNCTION even(val integer) RETURNS boolean AS $$
BEGIN
RETURN val%2=0;
END; $$
LANGUAGE PLPGSQL;

select * from even(2);
--d
CREATE FUNCTION valid(p varchar(100)) RETURNS boolean AS $$
BEGIN
RETURN p ~ '^[0-9\.]+$';
END; $$
LANGUAGE PLPGSQL;

select * from valid('123f5678910');
--e
CREATE OR REPLACE FUNCTION hi_lo(a integer,
OUT b integer,
OUT c integer)
AS $$
BEGIN
 b:= a/10;
 c := a%10;
END; $$
LANGUAGE plpgsql;

select * from hi_lo(12);
--2
--a
CREATE FUNCTION save_time()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	INSERT INTO triggers
		 VALUES(now());
	RETURN NEW;
	END;
$$;

CREATE TRIGGER insert_time
  BEFORE INSERT
  ON accounts
  FOR EACH ROW
  EXECUTE PROCEDURE save_time();

insert into accounts values ('AB10204',202,'USD',1000,100);

--b
CREATE FUNCTION get_age()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
    declare a varchar(100) := EXTRACT(year FROM age(now(),new.time));
	BEGIN
        RAISE info 'age %', a;
        return new;
	END;
$$;

CREATE TRIGGER age
  BEFORE INSERT
  ON triggers
  FOR EACH ROW
  EXECUTE PROCEDURE get_age();

insert into triggers values ('2002-04-16');
--c
CREATE or replace FUNCTION get_tax()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
  AS
$$
	BEGIN
	    new.price:=new.price*1.12;
        return new;
	END;
$$;


CREATE TRIGGER tax
  BEFORE INSERT
  ON items
  FOR EACH ROW
  EXECUTE PROCEDURE get_tax();

insert into items values ('1',100);
--d
CREATE or replace FUNCTION check_del()
RETURNS trigger
    LANGUAGE PLPGSQL
    AS $SS$
    BEGIN
    RAISE EXCEPTION 'cannot delete default category';

    END;
$SS$;

CREATE TRIGGER del
    BEFORE DELETE ON items
    FOR EACH ROW
    EXECUTE PROCEDURE check_del();

delete from items where name='1';

--e
CREATE or replace FUNCTION late()
RETURNS trigger
    LANGUAGE PLPGSQL
    AS $SS$
    BEGIN
        if not valid(new.pass) then
        RAISE EXCEPTION 'not right password';
        end if;
    raise info '%', hi_lo(new.id);
    return new;
    END;
$SS$;

CREATE TRIGGER last
    BEFORE insert
    ON acc
    FOR EACH ROW
    EXECUTE PROCEDURE late();

insert into acc values ('10','1234');
insert into acc values ('10','12g4');
--3
--What is the difference between procedure and function?

--4
--a
create or replace procedure a(
   i int,
   n varchar(50),
   d timestamp,
   s integer,
   w integer
)
language plpgsql
as $$
    declare a varchar(100);
    declare dis integer;
begin
    dis:=10;
    a:=extract(year from age(now(),d));
    if w>2 then s:=s*(w/2); end if;
    if w>=5 then dis=dis+1; end if;
    insert into task values (i,n,d,a,s,w,dis);
    commit;
end;
    $$;

call a(3,'A','1998-01-01',10000,10);
--b
create or replace procedure b(
   i int,
   n varchar(50),
   d timestamp,
   s integer,
   w integer
)
language plpgsql
as $$
    declare a varchar(100);
    declare dis integer;
begin
    dis:=0;
    a:=extract(year from age(now(),d));
    if a>='40' then s:=s*1.15; end if;
    if w>8 then s:=s*1.15;dis=20; end if;
    insert into task values (i,n,d,a,s,w,dis);
    commit;
end;
    $$;

call b(5,'A','1968-01-01',10000,10);
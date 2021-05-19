--Functions
create or replace function signin(integer, varchar, oid, varchar) 
	returns bool as $$
	
	declare name character varying(30);
	DECLARE c CURSOR FOR (
		SELECT "user".name 
		FROM "user");
		
	begin 
		open c;
		loop
			FETCH c INTO name;
			IF NOT FOUND THEN EXIT; END IF;
			IF name = $2 THEN 
				RAISE NOTICE 'user already exists'; 
				return false; --false means user already exists
			END IF;
		end loop;
		close c;
		INSERT INTO "user" VALUES($1, $2, $3);
		INSERT INTO "login" VALUES($1, $2, $4);
		return true;
	end
$$ language plpgsql;

--Test signin
select signin(6, 'Tom', 123, '12345');
select signin(20, 'Hosein', 3, '12345');
select * from "user";
select * from "login";
drop function signin;
select * from "rate"


create or replace function rating(integer, integer, func_rate float ) 
	returns bool as $$
	
	declare rating_uid integer;
	declare rating_mid integer;
	DECLARE c CURSOR FOR (
		SELECT "rate".uid, "rate".mid
		FROM "rate");
		
	begin 
		open c;
		loop
			FETCH c INTO rating_uid, rating_mid;
			IF NOT FOUND THEN EXIT; END IF;
			IF rating_uid = $1 and rating_mid =$2 THEN 
				UPDATE "rate"
				SET rate = func_rate
				WHERE uid = $1 and mid = $2;
				return false; -- false return means table has been update, not inserted
				exit;
			END IF;
		end loop;
		close c;
		INSERT INTO "rate" VALUES($1, $2, $3);
		return true;
	end
$$ language plpgsql;


--Test rating 
drop function rating;
update "rate" set rate = 9 where uid = 2 and mid = 1;
select rating(5,1, 9)
select * from "rate"
select * from "user"
select * from "login"
select * from "movies"
insert into "movies" values(1, 'God Father', 9, 1,'1974-02-12', 2, 0);


create or replace function find(ref refcursor,varchar) 
	returns setof refcursor as $$
	
	declare func_mid integer;
	declare func_sid integer;
	declare func_name character varying(30);
	DECLARE c CURSOR FOR (
		SELECT mid, sid, name
		FROM "M&S");
		
	begin 
		open c;
		loop
			FETCH c INTO func_mid, func_sid, func_name;
			IF NOT FOUND THEN EXIT; END IF;
			IF func_name = $2 THEN 
				if (func_mid = 0) then
					--insert into "visit" values((اینجا آی دی یوزری رو بذار که سرچ کرده), 0, 'func_sid', تایمی که از سیستم میگیری)
					 OPEN ref FOR
        			 SELECT *
					 FROM "series"
       				 where "series".sid = func_sid;

    				 RETURN NEXT ref;
				end if;
				if (func_sid = 0) then
					 OPEN ref FOR
        			 SELECT *
					 FROM "movies"
       				 where "movies".mid = func_mid;
    				 RETURN NEXT ref;
				end if	;			
			END IF;
		end loop;
		close c;
	end
$$ language plpgsql;


--Test find
drop function find
select * from "series"
insert into "series" values(1, 'TWD', 8.4, 1, '2010-01-01', 120, 0) --Beware to insert movies and series into M&S table!
insert into "series" values(2, 'TWD', 9, 1, '2030-01-01', 120, 0)
select * from "movies"
select * from "M&S"
insert into "M&S" values(-1,3,'TW')


--Starting Trancsaction to show refcursor output
BEGIN;
 	SELECT find('TWD', 'TWD');
    FETCH ALL IN "TWD";
	--To see the result you mustn't commit transaction but after that you have to commit transaction to unlock table.
COMMIT;

--Triggers

--Trigger for inserting on "rate" table
CREATE OR REPLACE FUNCTION rate_ave_ins()
	RETURNS trigger AS $$ 
	BEGIN
	UPDATE "movies" 
	SET rate = ((rate * noofraters) + new.rate) / (noofraters + 1), noofraters = noofraters + 1
	WHERE mid = NEW.mid; 
	RETURN NULL;
	END;
	$$ LANGUAGE PLpgSQL;

CREATE TRIGGER rate_ave_ins
	AFTER INSERT ON "rate"
	FOR EACH ROW 
	EXECUTE PROCEDURE rate_ave_ins();
	
--Trigger for updating "rate" table

CREATE OR REPLACE FUNCTION rate_ave_upd()
	RETURNS trigger AS $$ 
	BEGIN	
	UPDATE "movies" 
	SET rate = ((rate * noofraters) - (old.rate) + new.rate) / (noofraters)
	WHERE mid = NEW.mid; 
	RETURN NULL;
	END;
	$$ LANGUAGE PLpgSQL;

CREATE TRIGGER rate_ave_upd
	after update ON "rate"
	FOR EACH ROW 
	EXECUTE PROCEDURE rate_ave_upd();
	
-- test trigger 
select rating(5,3, 7)
select * from "movies"
select * from "rate"
INSERT INTO "movies" VALUES (3, 'test3', 9, 0, '2011-02-12', 1.5);
update "movies" set rate = 9, noofraters = 1 where mid = 3
delete from "rate" where uid = 5


create table "user"
(
  uid INTEGER NOT NULL,
  name CHARACTER VARYING(30),
  photo oid,
  primary key (uid)
)

create table "login"
(
  uid INTEGER NOT NULL,
  username CHARACTER VARYING(30),
  password CHARACTER VARYING(30),
  primary key (uid),
  foreign key (uid) REFERENCES "user" (uid)
)

create table "visit"
(
	uid INTEGER NOT NULL,
	mid INTEGER NOT NULL,
	sid integer not null,
	date date,
	primary key (uid, date),
	foreign key (uid) REFERENCES "user" (uid),
	foreign key (mid) REFERENCES "movies" (mid),
	foreign key (sid) references "series" (sid)
)

create table "comment"
(
	uid INTEGER NOT NULL,
	mid INTEGER NOT NULL,
	cid INTEGER NOT NULL,
	reply INTEGER NOT NULL,
	comment CHARACTER VARYING(4000),
	primary key (uid, mid, cid),
	foreign key (uid) REFERENCES "user" (uid),
	foreign key (mid) REFERENCES "movies" (mid)
)

create table "rate"
(
	uid INTEGER NOT NULL,
	mid INTEGER NOT NULL,
	rate float check ( rate >= 1 and rate <= 10),
	primary key (uid, mid),
	foreign key (uid) REFERENCES "user" (uid),
	foreign key (mid) REFERENCES "movies" (mid)
)


create table "watchlist"
(
  uid INTEGER NOT NULL,
  wid INTEGER NOT NULL,
  username CHARACTER VARYING(30),
  primary key (uid,wid),
  foreign key (uid) REFERENCES "user" (uid)
)

create table "detail"
(
  mid INTEGER NOT NULL,
  uid INTEGER NOT NULL,
  wid INTEGER NOT NULL,
  primary key (mid,wid),
  foreign key (uid,wid) REFERENCES "watchlist" (uid,wid),
  foreign key (mid) REFERENCES "movies" (mid)
)

create table "movies"
(
  mid INTEGER NOT NULL,
  name CHARACTER VARYING(30),
  rate float check ( rate >= 1 and rate <= 10),
  year date,
  duration float,
  companyid integer not null,
  primary key (mid),
  foreign key (companyid) references "companies" (cid)
)

insert into "movies" values(0, 'null_value', 1,'2000-01-01' , 1.5, 0)

create table "series"
(
  sid INTEGER NOT NULL,
  name CHARACTER VARYING(30),
  rate float check ( rate >= 1 and rate <= 10),
  year date,
  noOFepisodes INTEGER,
  networkid integer not null,
  primary key (sid),
  foreign key (networkid) references "network" (nid)
)

insert into "series" values(0, 'null_value', 1, '2000-01-01', 0, 0)


create table "M&S"
(
	mid integer,
	sid integer,
	name character varying(30),
	primary key (mid, sid),
	foreign key (mid) REFERENCES "movies" (mid),
	foreign key (sid) REFERENCES "series" (sid)
)

create table "companies"
(
  cid integer not null,
  name CHARACTER VARYING(30),
  year date,
  description character varying(2000),
  primary key (cid)
)

insert into "companies" values(0)

create table "boxoffice"
(
  mid INTEGER NOT NULL,
  date date,
  sale float,
  primary key (mid, date),
  foreign key (mid) REFERENCES "movies" (mid)
)

create table "top250movies"
(
  mid INTEGER NOT NULL,
  name CHARACTER VARYING(30),
  rate float,
  year date,
  primary key (mid),
  foreign key (mid) REFERENCES "movies" (mid)
)

create table "top250series"
(
  sid INTEGER NOT NULL,
  rate float,
  name CHARACTER VARYING(30),
  year date,
  primary key (sid),
  foreign key (sid) REFERENCES "series" (sid)
)

create table "shows"
(
  sid INTEGER NOT NULL,
  nid INTEGER NOT NULL,
  name CHARACTER VARYING(30),
  primary key (sid),
  foreign key (nid) references "network" (nid)
)

create table "network"
(
  nid INTEGER NOT NULL,
  name CHARACTER VARYING(30),
  year date,
  description character varying(2000),
  primary key (nid)
)

insert into "network" values(0)

create table "cast"
(
  pid INTEGER NOT NULL,
  mid INTEGER NOT NULL,
  role CHARACTER VARYING(30),
  primary key (pid, mid, role),
  foreign key (mid) REFERENCES "movies" (mid),
  foreign key (pid) references "person" (pid),
  check (role in ('Director', 'Producer', 'Actor', 'Composer', 'Editor'))
)


create table "photo"
(
   photo_id integer not null, 
   mid integer not null,
   photo oid,
   primary key (photo_id, mid),
   foreign key (mid) references "movies" (mid)
)

create table "person"
(
  pid INTEGER NOT NULL,
  name CHARACTER VARYING(30),
  birthdate date,
  primary key (pid)
)

create table "winner"
(
	pid integer not null,
	mid integer not null,
	role CHARACTER VARYING(30),
	festival_name CHARACTER VARYING(30),
	event_name CHARACTER VARYING(30),
	award_name CHARACTER VARYING(30),
	date date,
	primary key (pid, mid, festival_name, award_name, date),
	foreign key (pid, mid, role) references "cast" (pid, mid, role),
	foreign key (festival_name, award_name) references "award" (festival_name, name),
	foreign key (event_name, date) references "event" (name, date)
)

create table "award"
(
	festival_name CHARACTER VARYING(30),
	name CHARACTER VARYING(30),
	primary key (festival_name, name),
	foreign key (festival_name) references "festival" (name)
)

create table "festival"
(
	name CHARACTER VARYING(30),
	description CHARACTER VARYING(4000),
	primary key (name)
)

create table "event"
(
	name CHARACTER VARYING(30),
	date date,
	place character varying(40),
	primary key (name, date),
	foreign key (name) references "festival" (name)
)


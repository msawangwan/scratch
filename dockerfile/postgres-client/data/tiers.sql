begin;

drop table subscribers;
drop table members;
drop table ranges;

create table subscribers(sid serial primary key);
create table members(mid serial primary key,sid integer references subscribers(sid));
create table ranges(tmin integer,tmax integer,r numeric(18,6),sid integer references subscribers(sid));

insert into subscribers default values;
insert into subscribers default values;
insert into subscribers default values;
insert into members (sid) values (1),(1),(1),(1),(2),(2),(2),(3),(3),(3),(3),(3),(1),(1),(1),(1),(1),(1),(1),(1),(1);
insert into ranges (tmin,tmax,r, sid) values
        (0,3,10.00,1),
        (4,7,9.00,1),
        (8,11,8.00,1),
        (12,15,7.00,1),
        (16,21,6.00,1),
        (22,25,5.00,1),
        (26,29,4.00,1),

commit;

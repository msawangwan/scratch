begin;

drop table if exists jump cascade;
drop table if exists participant cascade;

create table if not exists participant
(
    id serial primary key,
    firstname text,
    lastname text
);
create table if not exists jump
(
    id serial primary key,
    pid integer references participant(id),
    cid integer,
    length integer
);

insert into participant (firstname, lastname) values
    ('mary', 'lamb'),
    ('bad', 'wolf'),
    ('hanz', 'gretzel');

insert into jump (pid, cid, length) values
    (1,1,667),
    (1,2,745),
    (1,3,723),
    (2,1,736),
    (2,2,669),
    (2,3,508),
    (3,1,664),
    (3,2,502),
    (3,3,739);

commit;

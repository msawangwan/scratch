begin;

drop table if exists employee;

create table if not exists employee
(
        id serial primary key,
        firstname text,
        lastname text,
        managerid integer
);

insert into employee (firstname,lastname,managerid) values
        ('maisy', 'bloom', NULL),
        ('caine', 'farrow', 1),
        ('waqar', 'jarvis', 2),
        ('lacey-mai', 'rahman', 2),
        ('merryn', 'french', 3);

commit;

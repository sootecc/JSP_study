drop table member;

create table member(
    id varchar2(100) not null constraint PK_member_id primary key,
    pass varchar2(100) null,
    name varchar2(100) null
);


insert into member values('1','1234','È«±æµ¿');
insert into member values('2','1235','±è¶Ê¶Ê');

select * from member;

commit;
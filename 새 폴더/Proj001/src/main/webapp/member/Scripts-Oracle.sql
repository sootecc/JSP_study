Create table t_member(
	id varchar2(10) primary key,
	pwd varchar2(10) not null,
	name varchar2(50) not null,
	email varchar2(100) null,
	joinDate date default sysdate
);


-- ���̵����� �Է�
insert into t_member
values('hong','1234','ȫ�浿','hong@gmail.com',sysdate);

insert into t_member
values('lee','1234','�̼���','lee@gmail.com',sysdate);

insert into t_member
values('kim','1234','������','kim@gmail.com',sysdate);


select * from t_member;


-- ����Ʈ ���� �� ����ְ� �÷� ���� ����
-- �۾��� -> insert
create table  freeboard(
    id number constraint PK_freeboard_id primary key,   -- 자동 증가 컬럼
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null, -- 글 제목
    contents varchar2(2000) not null, -- 글 내용
    inputdate varchar2(100) not null, -- 글 쓴 날짜
    masterid number default 0,      -- 질문 답변형 게시판에서 답변 글을 그루핑할 때 사용
    readcount number default 0,     -- 글 조회수 
    replynum number default 0,      -- 
    step number default 0
);

select * from freeboard;

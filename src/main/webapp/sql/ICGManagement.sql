--2조 코딩프로젝트 테이블

create table memberT(
    id varchar2(30) PRIMARY key
        CONSTRAINT id check (length(id) between 4 and 12),
    password varchar2(40) not null
        CONSTRAINT password check (length(password) between 8 and 16),
    name varchar2(30) not null,
    citizennum varchar2(15) not null,
    tele varchar2(15) not null,
    email VARCHAR2(100),
    classify number(3)
        default '1' not null,
    joinDate timestamp
        default systimestamp not null,
    lastLoginDate timestamp,
    loginCount number(6)
        default '0' not null
);

insert into membert(id,password,name,citizennum,tele,email,classify)
    values('adminmaster','12345678','admin','1212121234567','0100000000','asd@nasd.com',101);
insert into membert(id,password,name,citizennum,tele,email,classify)
    values('admin2','12345678','admin2','1212121234567','0100000000','asd2@nasd.com',102);




create SEQUENCE b_sq
    INCREMENT by 1
    START with 1
    NOMAXVALUE
    MINVALUE 1
    NOCYCLE;


create table boardT(
    b_no number(8) primary key,
    b_title varchar2(300) not null,
    b_contents long not null,
    b_writer varchar2(30) not null,
        CONSTRAINT b_writer_fk foreign key(b_writer)
            REFERENCES memberT(id),
    b_writeDate timestamp
        default systimestamp not null,
    b_rewriteDate timestamp,
    b_viewCount number(6)
        default '0' not null,
    b_imageURL varchar2(4000),
    b_notice char(1)
        default '0' not null
);
alter table boardT 
add(b_replyCount  number(6) default '0' not null);
insert into boardT(b_no,b_title,b_contents,b_writer,b_notice) values(b_sq.nextval,'테스트 공지','테스트입니다','adminmaster',1);
insert into boardT(b_no,b_title,b_contents,b_writer) values(b_sq.nextval,'테스트','테스트입니다','adminmaster');


create SEQUENCE br_sq
    INCREMENT by 1
    START with 1
    NOMAXVALUE
    MINVALUE 1
    NOCYCLE;

create table boardReplyT(
    b_no number(8) not null,
        CONSTRAINT br_b_no_fk foreign key(b_no)
            REFERENCES boardT(b_no),
    br_no number(5) not null,
    br_reNo number(5)
        default '0' not null,
    br_contents long not null,
    br_writer varchar2(30) not null,
        CONSTRAINT br_writer_fk foreign key(br_writer)
            REFERENCES memberT(id),
    br_writeDate timestamp
        default systimestamp not null,
    br_rewriteDate timestamp
);

insert into boardReplyT(b_no,br_no,br_contents,br_writer) values(1,br_sq.nextval,'댓글 테스트입니다','adminmaster');
insert into boardReplyT(b_no,br_no,br_reNo,br_contents,br_writer) values(1,1,1,'대댓글 테스트입니다','adminmaster');


create SEQUENCE e_sq
    INCREMENT by 1
    START with 1
    NOMAXVALUE
    MINVALUE 1
    NOCYCLE;

create table exBoardT(
    e_no    number(8)   PRIMARY key,
    e_title varchar2(300) not null,
    e_contents  varchar2(4000)  not null,
    e_writer    varchar2(30) not null,
        CONSTRAINT e_writer_fk foreign key(e_writer)
            REFERENCES memberT(id),
    e_writeDate timestamp
        default systimestamp not null,
    e_rewriteDate   timestamp,
    e_viewCount number(6)
        default '0' not null,
    e_reviewCount   number(6)
        default '0' not null,
    e_imageURL  varchar2(4000)
);

insert into exBoardT(e_no,e_title,e_contents,e_writer) values(e_sq.nextval,'테스트2(외부)','테스트입니다','adminmaster');



create SEQUENCE er_sq
    INCREMENT by 1
    START with 1
    NOMAXVALUE
    MINVALUE 1
    NOCYCLE;


create table exBoardReplyT(
    e_no    number(8)   not null,
        CONSTRAINT er_e_no_fk foreign key(e_no)
            REFERENCES exBoardT(e_no),
    er_no   number(5)   not null,
    er_reNo  number(5)
        default '0' not null,
    er_contents varchar2(3000)  not null,
    er_writer   varchar2(30)    not null,
        CONSTRAINT er_writer_fk foreign key(er_writer)
            REFERENCES memberT(id),
    er_writeDate    timestamp
        default systimestamp not null,
    er_rewriteDate  timestamp,
    er_reviewScore  number(3,1)
        default '0' not null
);

insert into exBoardReplyT(e_no,er_no,er_contents,er_writer) values(1,er_sq.nextval,'댓글 테스트입니다','adminmaster');
insert into exBoardReplyT(e_no,er_no,er_reNo,er_contents,er_writer) values(1,1,1,'대댓글 테스트입니다','adminmaster');


create SEQUENCE fb_sq
    INCREMENT by 1
    START with 1
    NOMAXVALUE
    MINVALUE 1
    NOCYCLE;

create table faqBoardT(
    fb_no   number(8) not null,
    fb_reply  number(1)
        default '0' not null,
    fb_title    varchar2(300)   not null,
    fb_contents varchar2(4000)  not null,
    fb_writer   varchar2(30),
        CONSTRAINT fb_writer_fk foreign key(fb_writer)
            REFERENCES memberT(id),
    fb_writeDate    timestamp
        default systimestamp not null,
    fb_rewriteDate  timestamp,
    fb_viewCount    number(6)
        default '0' not null,
    fb_answered char(1)
        default '0' not null,
    fb_notice   char(1)
        default '0' not null,
        constraint faqB_pk primary key(fb_no, fb_reply)
);

insert into faqBoardT(fb_no,fb_title,fb_contents,fb_writer) values(fb_sq.nextval,'질문테스트','테스트입니다','adminmaster');
insert into faqBoardT(fb_no,fb_reply,fb_title,fb_contents,fb_writer) values(1,1,'답변테스트','테스트입니다','adminmaster');

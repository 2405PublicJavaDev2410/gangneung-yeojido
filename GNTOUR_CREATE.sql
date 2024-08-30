CREATE TABLE TRAVEL_INFO (
    TRAVEL_NO NUMBER PRIMARY KEY,
    TRAVEL_NAME VARCHAR2(1000) NOT NULL,
    LATITUDE NUMBER NOT NULL,
    LONGITUDE NUMBER NOT NULL,
    ADDRESS VARCHAR2(1000),
    PHONE VARCHAR2(1000),
    USE_TIME VARCHAR2(1000),
    PARK_FEE VARCHAR2(1000),
    ENTRY_FEE VARCHAR2(1000),
    USE_FEE VARCHAR2(1000),
    INTRODUCE CLOB,
    REGION VARCHAR2(20),
    CATEGORY VARCHAR2(20),
    ZOOM_LEVEL NUMBER,
    SITE_URL VARCHAR2(1000),
    IMAGE_URL VARCHAR2(1000),
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT UK_LATITUDE_LONGITUDE UNIQUE (LATITUDE, LONGITUDE)
);
CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2(100) PRIMARY KEY,
    PASSWORD VARCHAR2(100) NOT NULL,
    NAME VARCHAR2(10) NOT NULL,
    BIRTH_DATE TIMESTAMP NOT NULL,
    EMAIL VARCHAR2(100) NOT NULL,
    PHONE VARCHAR2(100) NOT NULL,
    STATUS VARCHAR2(10) NOT NULL,
    DELETE_YN VARCHAR2(10) DEFAULT 'N' NOT NULL,
    ROLE VARCHAR2(10) NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL
);
CREATE TABLE REQ_MARK_ADD (
    REQ_MARK_ADD_NO NUMBER PRIMARY KEY,
    TRAVEL_NAME VARCHAR2(1000) NOT NULL,
    ADDRESS VARCHAR2(1000),
    PHONE VARCHAR2(1000),
    USE_TIME VARCHAR2(1000),
    PARK_FEE VARCHAR2(1000),
    ENTRY_FEE VARCHAR2(1000),
    USE_FEE VARCHAr2(1000),
    INTRODUCE CLOB,
    ACCEPTABLE_STATUS VARCHAR2(10),
    SITE_URL VARCHAR2(1000),
    IMAGE_URL VARCHAR2(1000),
    MEMBER_ID VARCHAR2(100) NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);
CREATE TABLE FAVORITES (
    FAVORITES_NO NUMBER PRIMARY KEY,
    MEMBER_ID VARCHAR2(100) NOT NULL,
    TRAVEL_NO NUMBER NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_FAVORITES_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID),
    CONSTRAINT FK_FAVORITES_TRAVEL FOREIGN KEY (TRAVEL_NO) REFERENCES TRAVEL_INFO(TRAVEL_NO)
);
CREATE TABLE TRAVEL_DIARY (
    DIARY_NO NUMBER PRIMARY KEY,
    TRAVEL_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(100) NOT NULL,
    DIARY_CONTENT CLOB NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_TRAVEL_DIARY_TRAVEL FOREIGN KEY (TRAVEL_NO) REFERENCES TRAVEL_INFO(TRAVEL_NO),
    CONSTRAINT FK_TRAVEL_DIARY_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);
CREATE TABLE TRAVEL_DIARY_FILE (
    DIARY_FILE_NO NUMBER PRIMARY KEY,
    FILE_PATH VARCHAR2(100) NOT NULL,
    FILE_NAME VARCHAR2(100) NOT NULL,
    FILE_RENAME VARCHAR2(100) NOT NULL,
    DIARY_NO NUMBER NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_TRAVEL_DIARY_FILE FOREIGN KEY (DIARY_NO) REFERENCES TRAVEL_DIARY(DIARY_NO)
);
CREATE TABLE REVIEW (
    REVIEW_NO NUMBER PRIMARY KEY,
    SCORE NUMBER NOT NULL,
    REVIEW_CONTENT CLOB NOT NULL,
    PARENT_REVIEW_NO NUMBER,
    TRAVEL_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(100) NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT CK_REVIEW_SCORE CHECK (SCORE BETWEEN 1.0 AND 5.0),
    CONSTRAINT FK_REVIEW_PARENT FOREIGN KEY (PARENT_REVIEW_NO) REFERENCES REVIEW(REVIEW_NO),
    CONSTRAINT FK_REVIEW_TRAVEL FOREIGN KEY (TRAVEL_NO) REFERENCES TRAVEL_INFO(TRAVEL_NO),
    CONSTRAINT FK_REVIEW_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);
CREATE TABLE REVIEW_COMPLAIN (
    COMPLAIN_NO NUMBER PRIMARY KEY,
    CATEGORY VARCHAR2(100) NOT NULL,
    REVIEW_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(100) NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_REVIEW_COMPLAIN_REVIEW FOREIGN KEY (REVIEW_NO) REFERENCES REVIEW(REVIEW_NO),
    CONSTRAINT FK_REVIEW_COMPLAIN_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);
CREATE TABLE REVIEW_FILE (
    REVIEW_FILE_NO NUMBER PRIMARY KEY,
    FILE_PATH VARCHAR2(100) NOT NULL,
    FILE_NAME VARCHAR2(100) NOT NULL,
    FILE_RENAME VARCHAR2(100) NOT NULL,
    REVIEW_NO NUMBER NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_REVIEW_FILE_REVIEW FOREIGN KEY (REVIEW_NO) REFERENCES REVIEW(REVIEW_NO)
);
CREATE TABLE NOTICE (
    NOTICE_NO NUMBER PRIMARY KEY,
    NOTICE_SUBJECT VARCHAR2(500) NOT NULL,
    NOTICE_CONTENT CLOB NOT NULL,
    IMPORTANT_YN VARCHAR2(10) DEFAULT 'N' NOT NULL,
    ADMIN_ID VARCHAR2(100) NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_NOTICE_ADMIN FOREIGN KEY (ADMIN_ID) REFERENCES MEMBER(MEMBER_ID)
);
CREATE TABLE QNA (
    QNA_NO NUMBER PRIMARY KEY,
    QNA_SUBJECT VARCHAR2(500) NOT NULL,
    QNA_CONTENT CLOB NOT NULL,
    MEMBER_ID VARCHAR2(100) NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_QNA_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);
CREATE TABLE QNA_ANSWER (
    ANSWER_NO NUMBER PRIMARY KEY,
    ANSWER_SUBJECT VARCHAR2(500) NOT NULL,
    ANSWER_CONTENT CLOB NOT NULL,
    QNA_NO NUMBER NOT NULL,
    MEMBER_ID VARCHAR2(100) NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_QNA_ANSWER_QNA FOREIGN KEY (QNA_NO) REFERENCES QNA(QNA_NO),
    CONSTRAINT FK_QNA_ANSWER_MEMBER FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID)
);
CREATE TABLE QNA_FILE (
    QNA_FILE_NO NUMBER PRIMARY KEY,
    FILE_PATH VARCHAR2(100) NOT NULL,
    FILE_NAME VARCHAR2(100) NOT NULL,
    FILE_RENAME VARCHAR2(100) NOT NULL,
    QNA_NO NUMBER NOT NULL,
    REG_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    UPDATE_DATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT FK_QNA_FILE_QNA FOREIGN KEY (QNA_NO) REFERENCES QNA(QNA_NO)
);

CREATE SEQUENCE SEQ_TRAVEL_INFO_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_REQ_MARK_ADD_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_FAVORITES_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_TRAVEL_DIARY_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_TRAVEL_DIARY_FILE_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_REVIEW_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_REVIEW_COMPLAIN_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_REVIEW_FILE_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_NOTICE_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_QNA_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_QNAANSWER_NO
NOCACHE
NOCYCLE;

CREATE SEQUENCE SEQ_QNA_FILE_NO
NOCACHE
NOCYCLE;


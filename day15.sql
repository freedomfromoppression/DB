CREATE TABLE office_coin(
        market VARCHAR2(100) primary key
       ,kor_nm VARCHAR2(100)
       ,en_nm VARCHAR2(100)

);
CREATE TABLE office_worker(
        user_id VARCHAR2(100) primary key
       ,nm VARCHAR2(100)
);

CREATE TABLE coin_sales(
         market VARCHAR2(100)
        ,user_id VARCHAR2(100)
        ,CONSTRAINT pk_coin PRIMARY KEY(market, user_id)

);
INSERT INTO office_worker VALUES ('a001', '�ؼ�');
INSERT INTO office_worker VALUES ('a002', '����');
INSERT INTO office_coin VALUES ('BIT', 'BITCOIN', '��Ʈ����');
INSERT INTO coin_sales VALUES ('BIT', 'b001');
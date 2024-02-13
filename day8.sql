
ALTER TABLE �л� ADD CONSTRAINT PK_�л�_�й� PRIMARY KEY (�й�);
ALTER TABLE �������� ADD CONSTRAINT PK_��������_����������ȣ PRIMARY KEY (����������ȣ);
ALTER TABLE ���� ADD CONSTRAINT PK_���񳻿�_�����ȣ PRIMARY KEY (�����ȣ);
ALTER TABLE ���� ADD CONSTRAINT PK_����_������ȣ PRIMARY KEY (������ȣ);

ALTER TABLE �������� 
ADD CONSTRAINT FK_�л�_�й� FOREIGN KEY(�й�)
REFERENCES �л�(�й�);

ALTER TABLE �������� 
ADD CONSTRAINT FK_����_�����ȣ FOREIGN KEY(�����ȣ)
REFERENCES ����(�����ȣ);

ALTER TABLE ���ǳ��� 
ADD CONSTRAINT FK_����_������ȣ FOREIGN KEY(������ȣ)
REFERENCES ����(������ȣ);

ALTER TABLE ���ǳ��� 
ADD CONSTRAINT FK_����_�����ȣ2 FOREIGN KEY(�����ȣ)
REFERENCES ����(�����ȣ);



COMMIT;


/* INNER JOIN �������� (��������) */
SELECT *
FROM �л�;

SELECT *
FROM ��������;

SELECT �л�.�̸�
     , �л�.����
     , �л�.�й� 
     , ��������.����������ȣ
     , ��������.�����ȣ
     , ����.�����̸�
FROM �л�, ��������, ����
WHERE �л�.�й� = ��������.�й�
AND   ��������.�����ȣ = ����.�����ȣ 
AND �л�.�̸� = '������';

--�л��� �������� �Ǽ��� ��ȸ�Ͻÿ�(���� �Ҽ��� 2°�ڸ� ���� ǥ��,�̸�����)




SELECT �л�.�̸�
     , ROUND(�л�.����,2) as ����
     , �л�.�й� 
     , COUNT(��������.����������ȣ) as �����Ǽ�
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й�
GROUP BY �л�.�̸�, �л�.����, �л�.�й�
ORDER BY 1 ;


/* outer join �ܺ����� null���� ���Խ�Ű�� ������*/
SELECT �л�.�̸�
     , ROUND(�л�.����,2) as ����
     , �л�.�й� 
     , COUNT(��������.����������ȣ) as �����Ǽ�
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й�(+) -- null�������Խ�ų �ʿ� (+)
GROUP BY �л�.�̸�, �л�.����, �л�.�й�
ORDER BY 1 ;
SELECT �л�.�̸�
     , ROUND(�л�.����,2) as ����
     , �л�.�й� 
     , ��������.����������ȣ as �����Ǽ�
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й�(+) -- null�������Խ�ų �ʿ� (+)
ORDER BY 1 ;
-- �л��� ������������ �� ���������� ����Ͻÿ� 
SELECT �л�.�̸�
     , ROUND(�л�.����,2) as ����
     , �л�.�й� 
     , COUNT(��������.����������ȣ) as �����Ǽ�
     ,SUM(NVL(����.����,0)) as �Ѽ�������
FROM �л�, ��������, ����
WHERE �л�.�й� = ��������.�й�(+) 
AND   ��������.�����ȣ = ����.�����ȣ(+)
GROUP BY �л�.�̸�, ROUND(�л�.����,2), �л�.�й� 
ORDER BY 1 ;


SELECT count(*)
FROM �л�, ��������; -- cross join (�����ؾ���) 
                   -- 9 * 17 = 153
SELECT count(*)
FROM �л�, ��������
WHERE �л�.�й� = ��������.�й�;







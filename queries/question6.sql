CREATE VIEW LVL1
AS
SELECT A1.AUTHOR_NAME AS A1, A1.PAPER_ID AS P1, REF.REFERENCE_ID AS P2
FROM AUTHORS A1
INNER JOIN REF
ON A1.PAPER_ID = REF.PAPER_ID;

CREATE VIEW LVL2
AS
SELECT LVL1.A1, LVL1.P1, LVL1.P2, A2.AUTHOR_NAME AS A2, REF.REFERENCE_ID AS P3
FROM LVL1
INNER JOIN AUTHORS A2
ON LVL1.P2 = A2.PAPER_ID
INNER JOIN REF
ON REF.PAPER_ID = LVL1.P2;

CREATE VIEW LVL3
AS
SELECT LVL2.A1, LVL2.P1, LVL2.A2, LVL2.P2, LVL2.P3, A3.AUTHOR_NAME AS A3, REF.REFERENCE_ID AS P4
FROM LVL2
INNER JOIN AUTHORS A3
ON LVL2.P3 = A3.PAPER_ID
INNER JOIN REF
ON REF.PAPER_ID = LVL2.P3;

CREATE VIEW LVL4
AS
SELECT LVL3.A1, LVL3.P1, LVL3.A2, LVL3.P2, LVL3.A3, LVL3.P3, LVL3.P4, A4.AUTHOR_NAME AS A4
FROM LVL3
INNER JOIN AUTHORS A4
ON LVL3.P4 = A4.PAPER_ID AND A4.AUTHOR_NAME = A1;

CREATE VIEW AUTHOR_TUPLES
AS
SELECT A1, A2, A3
FROM LVL4
WHERE A1 > A2 AND A2 > A3;

SELECT A1, A2, A3, COUNT(*) AS NUMBER_OF_TIMES
FROM AUTHOR_TUPLES
GROUP BY A1, A2, A3;
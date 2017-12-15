/* Zadaca 1 */ 
/* Креирај тригер */
CREATE OR REPLACE TRIGGER "brisi_uloga_1"
BEFORE
DELETE ON "VRABOTENI"
FOR EACH ROW
BEGIN
DELETE FROM ULOGI WHERE V = :OLD.V;
DELETE FROM ZARABOTUVA WHERE V = :OLD.V;
END;

/* Бриши */
DELETE FROM VRABOTENI WHERE IMEV = 'Tana Mimeska'

/* Zadaca 2 */ 

/* Нова колона */
ALTER TABLE TEATRI ADD VKUPNOPRETSTAVI NUMBER;
  
/* Напишете SQL израз со кој ќе ја пополните вредноста на овој атрибут кај сите записи во табелата Teatri. */
UPDATE (
	SELECT VKUPNOPRETSTAVI, BROJ
	FROM TEATRI t1 
	INNER JOIN (
		SELECT tempT.T AS TT, COUNT(BILETI.P) AS BROJ 
		FROM TEATRI tempT INNER JOIN BILETI 
		ON BILETI.T = tempT.T GROUP BY tempT.T
	)
	ON  t1.T = TT
)
SET VKUPNOPRETSTAVI = BROJ;

/* Тие што не одржале претстави */
UPDATE TEATRI SET VKUPNOPRETSTAVI = 0 WHERE VKUPNOPRETSTAVI IS NULL;

/* Потоа да се креира тригер со кој после додавање или бришење на запис во табелата Bileti ќе се ажурира атрибутот VkupnoPretstavi кај соодветниот театар. */
CREATE OR REPLACE TRIGGER "azuriranje_vkupnopretstavi"
AFTER INSERT OR DELETE ON "BILETI"
FOR EACH ROW
BEGIN
IF INSERTING THEN
UPDATE TEATRI
SET VKUPNOPRETSTAVI=VKUPNOPRETSTAVI+1
WHERE :NEW.T=TEATRI.T;
ELSE
UPDATE TEATRI
SET VKUPNOPRETSTAVI=VKUPNOPRETSTAVI-1
WHERE :OLD.T=TEATRI.T;
END IF;
END;
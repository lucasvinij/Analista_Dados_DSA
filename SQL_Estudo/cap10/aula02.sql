# Carregando tabela via programacao | stored procedures 
SELECT * FROM cap10.TB_TEMPO; 

# Stored Procedure
DELIMITER //
CREATE PROCEDURE cap10.CARREGA_TB_TEMPO(IN startdate DATE, IN stopdate DATE)
BEGIN
    DECLARE currentdate DATE;
    SET currentdate = startdate;
    WHILE currentdate <= stopdate DO
        INSERT INTO cap10.TB_TEMPO VALUES (
           YEAR(currentdate)*10000+MONTH(currentdate)*100 + DAY(currentdate),
           currentdate,
           YEAR(currentdate),
           MONTH(currentdate),
           DAY(currentdate),
           QUARTER(currentdate),
           WEEKOFYEAR(currentdate),
           DATE_FORMAT(currentdate,'%W'),
           DATE_FORMAT(currentdate,'%M'),
           'f',
           CASE DAYOFWEEK(currentdate) WHEN 1 THEN 't' WHEN 7 then 't' ELSE 'f' END);
        SET currentdate = ADDDATE(currentdate,INTERVAL 1 DAY);
    END WHILE;
END
//
DELIMITER ;


# Executa a Stored Procedure
CALL cap10.CARREGA_TB_TEMPO('2010-01-01','2030-01-01');

OPTIMIZE TABLE cap10.TB_TEMPO;

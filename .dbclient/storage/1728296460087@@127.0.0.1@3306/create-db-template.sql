-- Active: 1728296460087@@127.0.0.1@3306
drop DATABASE IF EXISTS gererlescommandes;
CREATE DATABASE gererlescommandes;
USE gererlescommandes;
DROP TABLE IF EXISTS article;
CREATE TABLE article(
    numart INT PRIMARY KEY,
    desart VARCHAR(100),
    puart DECIMAL,
    qteenstock INT,
    seuilminimum DECIMAL,
    seuilmaximum DECIMAL
);
DROP TABLE IF EXISTS commande;
CREATE TABLE commande(
    numcom INT PRIMARY KEY,
    datcom DATE
);
DROP TABLE IF EXISTS lignecommande;
CREATE TABLE lignecommande(
    numarti INT,
    qtecommandee INT,
    FOREIGN KEY (numarti) REFERENCES article(numart),
    numcoma INT,
    FOREIGN KEY (numcoma) REFERENCES commande(numcom)
);
INSERT INTO article (numart, desart, puart, qteenstock, seuilminimum, seuilmaximum) VALUES
(1, 'Article A', 10.50, 100, 5, 200),
(2, 'Article B', 15.00, 50, 3, 100),
(3, 'Article C', 8.75, 200, 10, 300),
(4, 'Article D', 22.00, 0, 2, 50),
(5, 'Article E', 5.25, 75, 10, 150);
INSERT INTO commande (numcom, datcom) VALUES
(1, '2024-10-01'),
(2, '2024-10-05'),
(3, '2024-10-05'),
(4, '2024-10-05'),
(5, '2024-10-05'),
(6, '2024-10-05'),
(7, '2024-10-05'),
(8, '2024-10-05'),
(9, '2024-10-05'),
(10, '2024-10-05'),
(11, '2024-10-05'),
(12, '2024-10-05'),
(13, '2024-10-07');
INSERT INTO lignecommande (numarti, qtecommandee, numcoma) VALUES
(1, 10, 1),
(2, 5, 1),
(3, 20, 2),
(1, 15, 2),
(4, 1, 3),
(5, 30, 3);
DELIMITER//

CREATE PROCEDURE montant(IN commandenum INT)
BEGIN
   DECLARE mont DECIMAL(10,2);
   SELECT SUM(lignecommande.qtecommandee*article.puart)INTO mont
   FROM lignecommande
   JOIN article ON article.numart=lignecommande.numarti
   WHERE lignecommande.numcoma=10;
   IF mont IS NULL THEN
    SELECT 'commande inexiste' AS messages;
   ELSEIF mont <10000 THEN
    SELECT 'commande normale' AS messages;
   ELSE 
    SELECT 'commande speciale' AS messages;
   END IF;
END //

DELIMITER ;

call montant(10);

DELIMITER//

drop PROCEDURE if exists supmis;
CREATE PROCEDURE supmis(IN numar INT, IN numcomm INT)
BEGIN
DECLARE qtcom INT;
SELECT qtecommandee INTO qtcom
FROM lignecommande
WHERE numcoma=numcomm AND numarti=numar;
DELETE FROM lignecommande
WHERE numcoma=numcomm AND numarti=numar;
UPDATE article
SET qteenstock=qteenstock + qtcom
WHERE numart=numar;
IF NOT EXISTS(SELECT*FROM lignecommande WHERE numcoma=numcomm)THEN
 DELETE FROM commande WHERE numcom=numcomm;
END IF;
END //
DELIMITER ;
call supmis(3,4);

SELECT commande.numcom,commande.datcom,SUM(lignecommande.qtecommandee*article.puart),
CASE 
    WHEN SUM(lignecommande.qtecommandee*article.puart) <= 10000 THEN 'commande normale' 
    ELSE 'commande speciale' 
END
FROM commande
JOIN lignecommande ON lignecommande.numcoma=commande.numcom
JOIN article ON article.numart=lignecommande.numarti
GROUP BY commande.numcom,commande.datcom;

DROP TEMPORARY TABLE IF EXISTS meilleur;
CREATE TEMPORARY TABLE meilleur(
    numcomt INT,
    datcomt DATE,
    montcom DECIMAL(15, 2)
);
INSERT INTO meilleur(numcomt,datcomt,montcom)
SELECT
  commande.numcom AS numcomt,
  commande.datcom AS datcomt,
  SUM(lignecommande.qtecommandee*article.puart) AS montcom
FROM commande
JOIN lignecommande ON lignecommande.numcoma=commande.numcom
JOIN article ON article.numart=lignecommande.numarti
GROUP BY commande.numcom,commande.datcom
ORDER BY montcom DESC
LIMIT 2;
SELECT*FROM meilleur; 


SELECT MAX(numcom)INTO @incre FROM commande;
SET @incre=@incre+1;
INSERT INTO commande (numcom, datcom)
VALUES (@incre, CURDATE());
INSERT INTO lignecommande (numarti, numcoma, qtecommandee)
SELECT 
    numart, 
    @incre, 
    3 * seuilminimum
FROM 
    article
WHERE 
    qteenstock <= seuilminimum;
SELECT * FROM commande WHERE numcom =@incre;
SELECT * FROM lignecommande WHERE numcoma =@incre;
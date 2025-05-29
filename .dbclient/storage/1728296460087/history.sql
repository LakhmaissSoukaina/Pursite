/* 2024-10-07 11:31:15 [19 ms] */ 
CREATE DATABASE gererlescommandes;
/* 2024-10-07 11:31:17 [17 ms] */ 
USE gererlescommandes;
/* 2024-10-07 11:31:18 [107 ms] */ 
CREATE TABLE article(
    numart INT PRIMARY KEY,
    desart VARCHAR(100),
    puart DECIMAL,
    qteenstock INT,
    seuilminimum DECIMAL,
    seuilmaximum DECIMAL
);
/* 2024-10-07 11:37:53 [103 ms] */ 
CREATE TABLE lignecommande(
    numarti INT,
    qtecommandee INT,
    FOREIGN KEY (numarti) REFERENCES article(numart)
);
/* 2024-10-07 11:40:21 [30 ms] */ 
DROP TABLE IF EXISTS lignecommande;
/* 2024-10-07 11:40:46 [75 ms] */ 
CREATE TABLE lignecommande(
    numarti INT,
    qtecommandee INT,
    FOREIGN KEY (numarti) REFERENCES article(numart),
    numcoma INT
);
/* 2024-10-07 11:41:16 [36 ms] */ 
CREATE TABLE commande(
    numcom INT PRIMARY KEY,
    datcom DATE
);
/* 2024-10-07 11:41:17 [71 ms] */ 
DROP TABLE IF EXISTS lignecommande;
/* 2024-10-07 11:41:18 [87 ms] */ 
CREATE TABLE lignecommande(
    numarti INT,
    qtecommandee INT,
    FOREIGN KEY (numarti) REFERENCES article(numart),
    numcoma INT,
    FOREIGN KEY (numcoma) REFERENCES commande(numcom)
);
/* 2024-10-07 11:48:13 [48 ms] */ 
INSERT INTO article (numart, desart, puart, qteenstock, seuilminimum, seuilmaximum) VALUES
(1, 'Article A', 10.50, 100, 5, 200),
(2, 'Article B', 15.00, 50, 3, 100),
(3, 'Article C', 8.75, 200, 10, 300),
(4, 'Article D', 22.00, 0, 2, 50),
(5, 'Article E', 5.25, 75, 10, 150);
/* 2024-10-07 11:48:14 [26 ms] */ 
INSERT INTO commande (numcom, datcom) VALUES
(1, '2024-10-01'),
(2, '2024-10-05'),
(3, '2024-10-07');
/* 2024-10-07 11:48:16 [121 ms] */ 
INSERT INTO lignecommande (numarti, qtecommandee, numcoma) VALUES
(1, 10, 1),
(2, 5, 1),
(3, 20, 2),
(1, 15, 2),
(4, 1, 3),
(5, 30, 3);
/* 2024-10-07 12:20:19 [37 ms] */ 
DROP TABLE IF EXISTS lignecommande;
/* 2024-10-07 12:20:21 [18 ms] */ 
DROP TABLE IF EXISTS commande;
/* 2024-10-07 12:20:25 [13 ms] */ 
DROP TABLE IF EXISTS article;
/* 2024-10-07 12:20:27 [49 ms] */ 
CREATE TABLE article(
    numart INT PRIMARY KEY,
    desart VARCHAR(100),
    puart DECIMAL,
    qteenstock INT,
    seuilminimum DECIMAL,
    seuilmaximum DECIMAL
);
/* 2024-10-07 12:20:30 [7 ms] */ 
DROP TABLE IF EXISTS commande;
/* 2024-10-07 12:20:31 [264 ms] */ 
CREATE TABLE commande(
    numcom INT PRIMARY KEY,
    datcom DATE
);
/* 2024-10-07 12:20:35 [7 ms] */ 
DROP TABLE IF EXISTS lignecommande;
/* 2024-10-07 12:20:36 [70 ms] */ 
CREATE TABLE lignecommande(
    numarti INT,
    qtecommandee INT,
    FOREIGN KEY (numarti) REFERENCES article(numart),
    numcoma INT,
    FOREIGN KEY (numcoma) REFERENCES commande(numcom)
);
/* 2024-10-07 12:20:38 [21 ms] */ 
INSERT INTO article (numart, desart, puart, qteenstock, seuilminimum, seuilmaximum) VALUES
(1, 'Article A', 10.50, 100, 5, 200),
(2, 'Article B', 15.00, 50, 3, 100),
(3, 'Article C', 8.75, 200, 10, 300),
(4, 'Article D', 22.00, 0, 2, 50),
(5, 'Article E', 5.25, 75, 10, 150);
/* 2024-10-07 12:20:39 [29 ms] */ 
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
/* 2024-10-07 12:20:41 [44 ms] */ 
INSERT INTO lignecommande (numarti, qtecommandee, numcoma) VALUES
(1, 10, 1),
(2, 5, 1),
(3, 20, 2),
(1, 15, 2),
(4, 1, 3),
(5, 30, 3);
/* 2024-10-07 12:22:27 [16 ms] */ 
SELECT 
    SUM(l.qtecommandee * a.puart) AS montant_total
FROM 
    lignecommande l
JOIN 
    article a ON l.numarti = a.numart
WHERE 
    l.numcoma = 10 LIMIT 100;
/* 2024-10-07 12:25:22 [22 ms] */ 
SELECT SUM(lignecommande.qtecommandee*article.puart)
FROM lignecommande
JOIN article ON article.numart=lignecommande.numarti
WHERE lignecommande.numcoma=10 LIMIT 100;
/* 2024-10-07 12:35:58 [58 ms] */ 
CREATE PROCEDURE CalculMontantCommande(IN commande_num INT)
BEGIN
    DECLARE montant DECIMAL(10, 2);
    -- Calculer le montant total de la commande
    SELECT SUM(l.qtecommandee * a.puart) INTO montant
    FROM lignecommande l
    JOIN article a ON l.numarti = a.numart
    WHERE l.numcoma = commande_num;
    -- Vérifier le montant et afficher le message approprié
    IF montant IS NULL THEN
        SELECT 'Commande inexistante' AS message;
    ELSEIF montant < 100000 THEN
        SELECT 'Commande Normale' AS message;
    ELSE
        SELECT 'Commande Spéciale' AS message;
    END IF;
END ;
/* 2024-10-07 12:36:04 [35 ms] */ 
CALL CalculMontantCommande(10);
/* 2024-10-07 12:37:11 [93 ms] */ 
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
END;
/* 2024-10-07 12:37:15 [4 ms] */ 
call montant(10);
/* 2024-10-07 12:37:31 [16 ms] */ 
CALL CalculMontantCommande(10);
/* 2024-10-07 15:11:48 [47 ms] */ 
CREATE PROCEDURE supmis(IN numar INT, IN numcomm INT)
BEGIN
DECLARE qtcom INT;
SELECT qtecommandee INTO qtcom
FROM lignecommade
WHERE numcoma=numcomm AND numarti=numar;
DELETE FROM lignecommande
WHERE numcoma=numcomm AND numarti=numar;
UPDATE article
SET qteenstock=qteenstock - qtcom
WHERE numarti=numar;
IF NOT EXISTS(SELECT*FROM lignecommande WHERE numcoma=numcomm)THEN
 DELETE FROM commande WHERE numcom=numcomm;
END IF;
END;
/* 2024-10-07 15:13:01 [99 ms] */ 
drop DATABASE IF EXISTS gererlescommandes;
/* 2024-10-07 15:13:02 [23 ms] */ 
CREATE DATABASE gererlescommandes;
/* 2024-10-07 15:13:07 [11 ms] */ 
USE gererlescommandes;
/* 2024-10-07 15:13:11 [12 ms] */ 
DROP TABLE IF EXISTS article;
/* 2024-10-07 15:13:13 [59 ms] */ 
CREATE TABLE article(
    numart INT PRIMARY KEY,
    desart VARCHAR(100),
    puart DECIMAL,
    qteenstock INT,
    seuilminimum DECIMAL,
    seuilmaximum DECIMAL
);
/* 2024-10-07 15:13:15 [4 ms] */ 
DROP TABLE IF EXISTS commande;
/* 2024-10-07 15:13:17 [34 ms] */ 
CREATE TABLE commande(
    numcom INT PRIMARY KEY,
    datcom DATE
);
/* 2024-10-07 15:13:18 [18 ms] */ 
DROP TABLE IF EXISTS lignecommande;
/* 2024-10-07 15:13:19 [156 ms] */ 
CREATE TABLE lignecommande(
    numarti INT,
    qtecommandee INT,
    FOREIGN KEY (numarti) REFERENCES article(numart),
    numcoma INT,
    FOREIGN KEY (numcoma) REFERENCES commande(numcom)
);
/* 2024-10-07 15:13:24 [18 ms] */ 
INSERT INTO article (numart, desart, puart, qteenstock, seuilminimum, seuilmaximum) VALUES
(1, 'Article A', 10.50, 100, 5, 200),
(2, 'Article B', 15.00, 50, 3, 100),
(3, 'Article C', 8.75, 200, 10, 300),
(4, 'Article D', 22.00, 0, 2, 50),
(5, 'Article E', 5.25, 75, 10, 150);
/* 2024-10-07 15:13:29 [14 ms] */ 
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
/* 2024-10-07 15:13:39 [40 ms] */ 
INSERT INTO lignecommande (numarti, qtecommandee, numcoma) VALUES
(1, 10, 1),
(2, 5, 1),
(3, 20, 2),
(1, 15, 2),
(4, 1, 3),
(5, 30, 3);
/* 2024-10-07 15:13:47 [35 ms] */ 
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
END;
/* 2024-10-07 15:13:54 [14 ms] */ 
call montant(10);
/* 2024-10-07 15:14:01 [75 ms] */ 
CREATE PROCEDURE supmis(IN numar INT, IN numcomm INT)
BEGIN
DECLARE qtcom INT;
SELECT qtecommandee INTO qtcom
FROM lignecommade
WHERE numcoma=numcomm AND numarti=numar;
DELETE FROM lignecommande
WHERE numcoma=numcomm AND numarti=numar;
UPDATE article
SET qteenstock=qteenstock - qtcom
WHERE numarti=numar;
IF NOT EXISTS(SELECT*FROM lignecommande WHERE numcoma=numcomm)THEN
 DELETE FROM commande WHERE numcom=numcomm;
END IF;
END;
/* 2024-10-07 15:15:06 [37 ms] */ 
CREATE PROCEDURE SupprimerArticleEtCommande(IN article_num INT, IN commande_num INT)
BEGIN
    DECLARE qte_commandee INT;
    -- Récupérer la quantité commandée avant de la supprimer
    SELECT qtecommandee INTO qte_commandee
    FROM lignecommande 
    WHERE numarti = article_num AND numcoma = commande_num;
    -- Suppression de l'article de la commande
    DELETE FROM lignecommande 
    WHERE numarti = article_num AND numcoma = commande_num;
    -- Mise à jour du stock (soustraction de la quantité commandée)
    UPDATE article 
    SET qteenstock = qteenstock - qte_commandee 
    WHERE numart = article_num;
    -- Vérification si la commande n'a plus d'articles associés
    IF NOT EXISTS (SELECT * FROM lignecommande WHERE numcoma = commande_num) THEN
        DELETE FROM commande WHERE numcom = commande_num;
    END IF;
END ;
/* 2024-10-07 15:15:11 [81 ms] */ 
CALL SupprimerArticleEtCommande(8, 5);
/* 2024-10-07 15:16:16 [25 ms] */ 
drop PROCEDURE if exists supmis;
/* 2024-10-07 15:16:17 [120 ms] */ 
CREATE PROCEDURE supmis(IN numar INT, IN numcomm INT)
BEGIN
DECLARE qtcom INT;
SELECT qtecommandee INTO qtcom
FROM lignecommade
WHERE numcoma=numcomm AND numarti=numar;
DELETE FROM lignecommande
WHERE numcoma=numcomm AND numarti=numar;
UPDATE article
SET qteenstock=qteenstock - qtcom
WHERE numarti=numar;
IF NOT EXISTS(SELECT*FROM lignecommande WHERE numcoma=numcomm)THEN
 DELETE FROM commande WHERE numcom=numcomm;
END IF;
END;
/* 2024-10-07 15:17:39 [31 ms] */ 
drop PROCEDURE if exists supmis;
/* 2024-10-07 15:17:40 [45 ms] */ 
CREATE PROCEDURE supmis(IN numar INT, IN numcomm INT)
BEGIN
DECLARE qtcom INT;
SELECT qtecommandee INTO qtcom
FROM lignecommande
WHERE numcoma=numcomm AND numarti=numar;
DELETE FROM lignecommande
WHERE numcoma=numcomm AND numarti=numar;
UPDATE article
SET qteenstock=qteenstock - qtcom
WHERE numarti=numar;
IF NOT EXISTS(SELECT*FROM lignecommande WHERE numcoma=numcomm)THEN
 DELETE FROM commande WHERE numcom=numcomm;
END IF;
END;
/* 2024-10-07 15:18:36 [30 ms] */ 
drop PROCEDURE if exists supmis;
/* 2024-10-07 15:18:37 [32 ms] */ 
CREATE PROCEDURE supmis(IN numar INT, IN numcomm INT)
BEGIN
DECLARE qtcom INT;
SELECT qtecommandee INTO qtcom
FROM lignecommande
WHERE numcoma=numcomm AND numarti=numar;
DELETE FROM lignecommande
WHERE numcoma=numcomm AND numarti=numar;
UPDATE article
SET qteenstock=qteenstock - qtcom
WHERE numart=numar;
IF NOT EXISTS(SELECT*FROM lignecommande WHERE numcoma=numcomm)THEN
 DELETE FROM commande WHERE numcom=numcomm;
END IF;
END;
/* 2024-10-07 15:18:40 [80 ms] */ 
call supmis(3,4);
/* 2024-10-07 17:17:03 [72 ms] */ 
SELECT commande.numcom,commande.datcom,SUM(lignecommande.qtecommandee*article.puart),
CASE 
    WHEN SUM(lignecommande.qtecommandee*article.puart) <= 10000 THEN 'commande normale' 
    ELSE 'commande speciale' 
END
FROM commande
JOIN lignecommande ON lignecommande.numcoma=commande.numcom
JOIN article ON article.numart=lignecommande.numarti
GROUP BY commande.numcom,commande.datcom LIMIT 100;
/* 2024-10-07 17:26:22 [78 ms] */ 
CREATE TEMPORARY TABLE meilleur(
    numcomt INT,
    datcomt DATE,
    montcom DECIMAL(15, 2)
);
/* 2024-10-07 17:27:29 [9 ms] */ 
DROP TEMPORARY TABLE IF EXISTS meilleur;
/* 2024-10-07 17:27:30 [20 ms] */ 
CREATE TEMPORARY TABLE meilleur(
    numcomt INT,
    datcomt DATE,
    montcom DECIMAL(15, 2)
);
/* 2024-10-07 17:28:37 [23 ms] */ 
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
/* 2024-10-07 17:28:40 [27 ms] */ 
SELECT*FROM meilleur;
/* 2024-10-07 17:35:09 [64 ms] */ 
SELECT MAX(numcom)INTO @incre FROM commande;
/* 2024-10-07 17:35:18 [9 ms] */ 
SET @incre=@incre+1;
/* 2024-10-07 17:35:28 [55 ms] */ 
INSERT INTO commande (numcom, datcom)
VALUES (@incre, CURDATE());
/* 2024-10-07 17:35:35 [19 ms] */ 
INSERT INTO lignecommande (numarti, numcoma, qtecommandee)
SELECT 
    numart, 
    @incre, 
    3 * seuilminimum
FROM 
    article
WHERE 
    qteenstock <= seuilminimum;
/* 2024-10-07 17:35:48 [44 ms] */ 
SELECT * FROM commande WHERE numcom =@incre LIMIT 100;
/* 2024-10-07 17:35:55 [14 ms] */ 
SELECT * FROM lignecommande WHERE numcoma =@incre LIMIT 100;

-- Active: 1725782199018@@127.0.0.1@3306
DROP DATABASE Ecole;
CREATE DATABASE Ecole;
USE Ecole;
CREATE TABLE Etudiants(
    id_E INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    age_E INT,
    classe VARCHAR(255)
);
CREATE TABLE Cours(
    id_cours INT PRIMARY KEY AUTO_INCREMENT,
    nom_cours VARCHAR(255),
    id_professeur INT
);
CREATE TABLE Professeurs(
    id_professeur INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    matiere VARCHAR(255)
);
INSERT INTO Etudiants(nom,prenom,age_E,classe)
VALUES ("BENALLOU","Hanane",19,"Full Stack"),
    ("CHABAB","Rekia",21,"WEB"),
    ("KHRISS","Khadija",20,"informatique");
INSERT INTO Cours(nom_cours,id_professeur)
VALUES ("Gestion_Donnees",1),
    ("Approche_Agile",2),
    ("REACT_JS",3);
INSERT INTO Professeurs(nom,matiere)
VALUES ("EL KANDOUSSI","GD"),
    ("NAIM","AA"),
    ("NAIM","REACT");

SELECT *
FROM Etudiants;

SELECT nom,prenom
FROM Etudiants
WHERE age_E > 20;

SELECT * 
FROM Etudiants
WHERE classe="informatique";

UPDATE Etudiants
SET age_E=20
WHERE nom="BENALLOU";

DELETE FROM Etudiants
WHERE id_E=1;

SELECT *
FROM Etudiants;

SELECT C.*,P.nom
FROM Cours C
JOIN Professeurs P ON C.id_professeur=P.id_professeur;

ALTER TABLE Etudiants
ADD COLUMN note FLOAT;;

SELECT avg(note) AS moyenne
FROM Etudiants;

SELECT classe,count(*) AS nombre
FROM Etudiants
GROUP BY classe;

CREATE PROCEDURE information(IN id_etudiant INT)
BEGIN
SELECT *
FROM Etudiants
WHERE id_E=id_etudiant;
END;

CALL information(2);

CREATE PROCEDURE ajoute(IN p_nom VARCHAR(255),IN p_prenom VARCHAR(255),IN p_age INT,IN p_classe VARCHAR(255))
BEGIN
INSERT INTO Etudiants(nom,prenom,age_E,classe)
VALUES (p_nom,p_prenom,p_age,p_classe);
END;

CALL ajoute("BENALLOU","Hanane",19,"Full Stack");

DELIMITER //

CREATE TRIGGER verification_age_E
BEFORE INSERT ON Etudiants
FOR EACH ROW
BEGIN
    IF NEW.age_E <= 18 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Entrez un âge supérieur à 18';
    END IF;
END;
//

DELIMITER ;

START TRANSACTION;

-- Vérification si le solde du compte source est suffisant
SELECT solde FROM Comptes WHERE id_compte = 1 FOR UPDATE;

-- Si le solde est insuffisant, annuler la transaction
IF (SELECT solde FROM Comptes WHERE id_compte = 1) < 100 THEN
    ROLLBACK;
    SELECT 'Solde insuffisant, la transaction a été annulée.';
ELSE
    -- Débiter le compte source
    UPDATE Comptes
    SET solde = solde - 100
    WHERE id_compte = 1;

    -- Crédite le compte destination
    UPDATE Comptes
    SET solde = solde + 100
    WHERE id_compte = 2;

    -- Commit de la transaction si tout est validé
    COMMIT;
    SELECT 'Transaction réussie.';
END IF;

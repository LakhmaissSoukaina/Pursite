/* 2024-11-10 16:38:47 [3 ms] */ 
SELECT * FROM etudiants LIMIT 100;
/* 2024-11-10 17:02:14 [13 ms] */ 
UPDATE `etudiants` SET `note`=18 WHERE `id_E`=2;UPDATE `etudiants` SET `note`=12 WHERE `id_E`=3;
/* 2024-11-10 17:31:57 [4 ms] */ 
INSERT INTO `etudiants`(`nom`,`prenom`,`age_E`,`classe`) VALUES('LAKHMAISS','Soukaina',18,'Full Stack');
/* 2024-11-10 18:05:44 [14 ms] */ 
USE Ecole;
/* 2024-11-10 18:05:45 [70 ms] */ 
DROP DATABASE Ecole;
/* 2024-11-10 18:05:46 [8 ms] */ 
CREATE DATABASE Ecole;
/* 2024-11-10 18:05:49 [9 ms] */ 
USE Ecole;
/* 2024-11-10 18:05:53 [72 ms] */ 
CREATE TABLE Etudiants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    age INT,
    classe VARCHAR(50)
);
/* 2024-11-10 18:05:55 [50 ms] */ 
INSERT INTO Etudiants (nom, prenom, age, classe) VALUES
('Dupont', 'Pierre', 22, 'Informatique'),
('Durand', 'Marie', 19, 'Informatique'),
('Martin', 'Lucie', 21, 'Mathématiques');
/* 2024-11-10 18:05:57 [12 ms] */ 
SELECT * FROM Etudiants LIMIT 100;
/* 2024-11-10 18:06:02 [13 ms] */ 
SELECT nom, prenom FROM Etudiants WHERE age > 20 LIMIT 100;
/* 2024-11-10 18:06:07 [14 ms] */ 
SELECT * FROM Etudiants WHERE classe = 'Informatique' LIMIT 100;
/* 2024-11-10 18:06:13 [24 ms] */ 
UPDATE Etudiants SET age = 23 WHERE id = 1;
/* 2024-11-10 18:06:16 [30 ms] */ 
DELETE FROM Etudiants WHERE id = 2;
/* 2024-11-10 18:06:20 [16 ms] */ 
SELECT * FROM Etudiants LIMIT 100;
/* 2024-11-10 18:06:25 [59 ms] */ 
CREATE TABLE Cours (
    id_cours INT AUTO_INCREMENT PRIMARY KEY,
    nom_cours VARCHAR(100),
    id_professeur INT
);
/* 2024-11-10 18:06:26 [72 ms] */ 
CREATE TABLE Professeurs (
    id_professeur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    matiere VARCHAR(50)
);
/* 2024-11-10 18:06:28 [29 ms] */ 
INSERT INTO Professeurs (nom, matiere) VALUES
('Lemoine', 'Mathématiques'),
('Roche', 'Informatique');
/* 2024-11-10 18:06:30 [23 ms] */ 
INSERT INTO Cours (nom_cours, id_professeur) VALUES
('Algèbre', 1),
('Programmation', 2);
/* 2024-11-10 18:06:33 [21 ms] */ 
SELECT C.nom_cours, P.nom AS professeur
FROM Cours C
JOIN Professeurs P ON C.id_professeur = P.id_professeur LIMIT 100;
/* 2024-11-10 18:06:39 [39 ms] */ 
ALTER TABLE Etudiants ADD COLUMN note DECIMAL(5,2);
/* 2024-11-10 18:06:40 [5 ms] */ 
SELECT AVG(note) AS moyenne_notes FROM Etudiants LIMIT 100;
/* 2024-11-10 18:06:55 [18 ms] */ 
SELECT classe, COUNT(*) AS nombre_etudiants
FROM Etudiants
GROUP BY classe LIMIT 100;
/* 2024-11-10 18:07:03 [54 ms] */ 
CREATE PROCEDURE GetEtudiantInfo(IN id_etudiant INT)
BEGIN
    SELECT * FROM Etudiants WHERE id = id_etudiant;
END ;
/* 2024-11-10 18:07:09 [25 ms] */ 
CALL GetEtudiantInfo(1);
/* 2024-11-10 18:07:18 [24 ms] */ 
CREATE PROCEDURE AddEtudiant(IN nom VARCHAR(50), IN prenom VARCHAR(50), IN age INT, IN classe VARCHAR(50))
BEGIN
    INSERT INTO Etudiants (nom, prenom, age, classe) VALUES (nom, prenom, age, classe);
END ;
/* 2024-11-10 18:07:22 [22 ms] */ 
CALL AddEtudiant('Leblanc', 'Paul', 24, 'Physique');
/* 2024-11-10 18:07:29 [23 ms] */ 
CREATE TRIGGER CheckAgeBeforeInsert
BEFORE INSERT ON Etudiants
FOR EACH ROW
BEGIN
    IF NEW.age <= 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L\'âge doit être supérieur à 18 ans.';
    END IF;
END ;
/* 2024-11-10 18:07:37 [43 ms] */ 
CREATE TABLE Comptes (
    id_compte INT AUTO_INCREMENT PRIMARY KEY,
    solde DECIMAL(10, 2)
);
/* 2024-11-10 18:07:40 [28 ms] */ 
INSERT INTO Comptes (solde) VALUES (1000), (500);
/* 2024-11-10 18:07:44 [13 ms] */ 
START TRANSACTION;
/* 2024-11-10 18:07:46 [19 ms] */ 
SELECT solde FROM Comptes WHERE id_compte = 1 FOR UPDATE;
/* 2024-11-10 18:08:57 [15 ms] */ 
START TRANSACTION;
/* 2024-11-10 18:08:58 [18 ms] */ 
SELECT solde FROM Comptes WHERE id_compte = 1 FOR UPDATE;
/* 2024-11-10 18:09:06 [13 ms] */ 
SELECT 'Solde insuffisant, la transaction a été annulée.';
/* 2024-11-10 18:09:14 [11 ms] */ 
UPDATE Comptes
    SET solde = solde + 100
    WHERE id_compte = 2;
/* 2024-11-10 18:09:15 [6 ms] */ 
COMMIT;
/* 2024-11-10 18:09:18 [16 ms] */ 
SELECT 'Transaction réussie.';

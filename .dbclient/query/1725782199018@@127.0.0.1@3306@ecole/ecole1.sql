-- Active: 1725782199018@@127.0.0.1@3306@ecole
DROP DATABASE Ecole;
CREATE DATABASE Ecole;

USE Ecole;

CREATE TABLE Etudiants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    age INT,
    classe VARCHAR(50)
);

INSERT INTO Etudiants (nom, prenom, age, classe) VALUES
('Dupont', 'Pierre', 22, 'Informatique'),
('Durand', 'Marie', 19, 'Informatique'),
('Martin', 'Lucie', 21, 'Mathématiques');

SELECT * FROM Etudiants;

SELECT nom, prenom FROM Etudiants WHERE age > 20;

SELECT * FROM Etudiants WHERE classe = 'Informatique';

UPDATE Etudiants SET age = 23 WHERE id = 1;

DELETE FROM Etudiants WHERE id = 2;

SELECT * FROM Etudiants;

CREATE TABLE Cours (
    id_cours INT AUTO_INCREMENT PRIMARY KEY,
    nom_cours VARCHAR(100),
    id_professeur INT
);

CREATE TABLE Professeurs (
    id_professeur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    matiere VARCHAR(50)
);

INSERT INTO Professeurs (nom, matiere) VALUES
('Lemoine', 'Mathématiques'),
('Roche', 'Informatique');

INSERT INTO Cours (nom_cours, id_professeur) VALUES
('Algèbre', 1),
('Programmation', 2);

SELECT C.nom_cours, P.nom AS professeur
FROM Cours C
JOIN Professeurs P ON C.id_professeur = P.id_professeur;

ALTER TABLE Etudiants ADD COLUMN note DECIMAL(5,2);

SELECT AVG(note) AS moyenne_notes FROM Etudiants;

SELECT classe, COUNT(*) AS nombre_etudiants
FROM Etudiants
GROUP BY classe;

DELIMITER //
CREATE PROCEDURE GetEtudiantInfo(IN id_etudiant INT)
BEGIN
    SELECT * FROM Etudiants WHERE id = id_etudiant;
END //
DELIMITER ;

CALL GetEtudiantInfo(1);

DELIMITER //
CREATE PROCEDURE AddEtudiant(IN nom VARCHAR(50), IN prenom VARCHAR(50), IN age INT, IN classe VARCHAR(50))
BEGIN
    INSERT INTO Etudiants (nom, prenom, age, classe) VALUES (nom, prenom, age, classe);
END //
DELIMITER ;

CALL AddEtudiant('Leblanc', 'Paul', 24, 'Physique');

DELIMITER //
CREATE TRIGGER CheckAgeBeforeInsert
BEFORE INSERT ON Etudiants
FOR EACH ROW
BEGIN
    IF NEW.age <= 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L\'âge doit être supérieur à 18 ans.';
    END IF;
END //
DELIMITER ;

CREATE TABLE Comptes (
    id_compte INT AUTO_INCREMENT PRIMARY KEY,
    solde DECIMAL(10, 2)
);

INSERT INTO Comptes (solde) VALUES (1000), (500);

START TRANSACTION;

SELECT solde FROM Comptes WHERE id_compte = 1 FOR UPDATE;

IF (SELECT solde FROM Comptes WHERE id_compte = 1) < 100 THEN
    ROLLBACK;
    SELECT 'Solde insuffisant, la transaction a été annulée.';
ELSE
    UPDATE Comptes
    SET solde = solde - 100
    WHERE id_compte = 1;

    UPDATE Comptes
    SET solde = solde + 100
    WHERE id_compte = 2;

    COMMIT;
    SELECT 'Transaction réussie.';
END IF;

-- Active: 1725782199018@@127.0.0.1@3306@phpmyadmin
CREATE DATABASE gestiondescours;
USE gestiondescours;

-- Table "etudiants"
CREATE TABLE etudiants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    date_naissance DATE NOT NULL
);

-- Table "cours"
CREATE TABLE cours (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    places_disponibles INT NOT NULL
);

-- Table "inscriptions"
CREATE TABLE inscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    etudiant_id INT,
    cours_id INT,
    note INT DEFAULT NULL,
    FOREIGN KEY (etudiant_id) REFERENCES etudiants(id),
    FOREIGN KEY (cours_id) REFERENCES cours(id)
);

DELIMITER //

CREATE PROCEDURE ajouter_etudiant(
    IN p_nom VARCHAR(255),
    IN p_prenom VARCHAR(255),
    IN p_date_naissance DATE
)
BEGIN
    INSERT INTO etudiants (nom, prenom, date_naissance)
    VALUES (p_nom, p_prenom, p_date_naissance);
END //
call ajouter_etudiant("hanane","benallou","2000-09-01")

DELIMITER ;





















DELIMITER //
CREATE PROCEDURE inscrire_etudiant(p_etudiant_id INT,p_cours_id INT)
BEGIN
    DECLARE places INT;
    SELECT places_disponibles INTO places FROM cours WHERE id = p_cours_id;
    
    IF places > 0 THEN
        INSERT INTO inscriptions (etudiant_id, cours_id)
        VALUES (p_etudiant_id, p_cours_id);
        UPDATE cours
        SET places_disponibles = places_disponibles - 1
        WHERE id = p_cours_id;
    ELSE
        SELECT "Pas de places disponibles";
    END IF;
END //
call inscrire_etudiant(1,1)
 DELIMITER ;















 DELIMITER //

CREATE PROCEDURE supprimer_etudiant(
    IN p_etudiant_id INT
)
BEGIN
    DELETE FROM inscriptions WHERE etudiant_id = p_etudiant_id;
    DELETE FROM etudiants WHERE id = p_etudiant_id;
END //
call supprimer_etudiant(1)

DELIMITER ;
















DELIMITER //

CREATE PROCEDURE lister_etudiants_par_cours(
    IN p_cours_id INT
)
BEGIN
    SELECT e.id, e.nom, e.prenom, e.date_naissance
    FROM etudiants e
    INNER JOIN inscriptions i ON e.id = i.etudiant_id
    WHERE i.cours_id = p_cours_id;
END //

DELIMITER ;


















DELIMITER //

CREATE PROCEDURE statistiques_cours(
    IN p_cours_id INT
)
BEGIN
    SELECT 
        COUNT(i.etudiant_id) AS nb_etudiants_inscrits,
        AVG(i.note) AS moyenne_notes
    FROM inscriptions i
    GROUP BY id_cours;
END //

DELIMITER ;


















DELIMITER //

CREATE PROCEDURE maj_etudiant(
    IN p_id INT,
    IN p_nom VARCHAR(255),
    IN p_prenom VARCHAR(255),
    IN p_date_naissance DATE
)
BEGIN
    UPDATE etudiants
    SET nom = p_nom,
        prenom = p_prenom,
        date_naissance = p_date_naissance
    WHERE id = p_id;
END //

DELIMITER ;

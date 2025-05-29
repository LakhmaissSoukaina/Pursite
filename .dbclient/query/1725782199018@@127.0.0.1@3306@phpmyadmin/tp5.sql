-- Active: 1725782199018@@127.0.0.1@3306@phpmyadmin
CREATE DATABASE gestiondescours;
USE gestiondescours;
CREATE TABLE etudiants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    date_naissance DATE NOT NULL
);
CREATE TABLE cours (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    places_disponibles INT NOT NULL
);
CREATE TABLE inscriptions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    etudiant_id INT NOT NULL,
    cours_id INT NOT NULL,
    note INT DEFAULT NULL,
    FOREIGN KEY (etudiant_id) REFERENCES etudiants(id),
    FOREIGN KEY (cours_id) REFERENCES cours(id)
);
DELIMITER $$

CREATE PROCEDURE afficher_moyenne_notes()
BEGIN
    -- Variables pour stocker les données récupérées par le curseur
    DECLARE done INT DEFAULT 0;
    DECLARE etudiant_nom VARCHAR(255);
    DECLARE etudiant_prenom VARCHAR(255);
    DECLARE etudiant_id INT;
    DECLARE moyenne FLOAT;

    -- Déclaration du curseur
    DECLARE curseur_etudiants CURSOR FOR 
    SELECT id, nom, prenom FROM etudiants;

    -- Déclaration de la condition de fin du curseur
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Ouvrir le curseur
    OPEN curseur_etudiants;

    etudiant_loop: LOOP
        -- Récupérer les valeurs depuis le curseur
        FETCH curseur_etudiants INTO etudiant_id, etudiant_nom, etudiant_prenom;

        -- Vérifier la condition de fin
        IF done THEN
            LEAVE etudiant_loop;
        END IF;

        -- Calculer la moyenne des notes pour cet étudiant
        SELECT AVG(note) INTO moyenne
        FROM inscriptions
        WHERE etudiant_id = etudiant_id AND note IS NOT NULL;

        -- Si l'étudiant n'a aucune note, définir la moyenne à NULL
        IF moyenne IS NULL THEN
            SET moyenne = 0;
        END IF;

        -- Afficher le nom, le prénom de l'étudiant et sa moyenne
        SELECT CONCAT('Étudiant: ', etudiant_nom, ' ', etudiant_prenom, ' - Moyenne: ', moyenne) AS resultat;

    END LOOP;

    -- Fermer le curseur
    CLOSE curseur_etudiants;

END$$

DELIMITER ;

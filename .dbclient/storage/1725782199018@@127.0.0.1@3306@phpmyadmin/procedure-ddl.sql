-- Active: 1725782199018@@127.0.0.1@3306@phpmyadmin
DROP PROCEDURE ajouter_etudiant;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajouter_etudiant`(
    IN p_nom VARCHAR(255),
    IN p_prenom VARCHAR(255),
    IN p_date_naissance DATE
)
BEGIN
    INSERT INTO etudiants (nom, prenom, date_naissance)
    VALUES (p_nom, p_prenom, p_date_naissance);
END
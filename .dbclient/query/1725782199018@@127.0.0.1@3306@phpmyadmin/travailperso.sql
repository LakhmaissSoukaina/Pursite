-- Active: 1725782199018@@127.0.0.1@3306@phpmcreate
-- Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS travailperso;
CREATE DATABASE travailperso;

-- Switch to the new database (depends on your environment)
USE travailperso;

-- Create the cliente table
CREATE TABLE cliente(
    codeC INT,
    nomC VARCHAR(100),
    prenomC VARCHAR(100),
    adresse VARCHAR(100),
    ville VARCHAR(100)
);

-- Insert data into the cliente table
INSERT INTO cliente (codeC, nomC, prenomC, adresse, ville)
VALUES
    (1, 'Dupont', 'Jean', '123 Rue de la Paix', 'Paris'),
    (2, 'Martin', 'Sophie', '45 Avenue des Champs', 'Lyon'),
    (3, 'Durand', 'Marie', '78 Boulevard Voltaire', 'Marseille'),
    (4, 'Leclerc', 'Pierre', '56 Rue Lafayette', 'Nice'),
    (5, 'Blanc', 'Luc', '12 Place du Capitole', 'Toulouse'),
    (6, 'Bernard', 'Isabelle', '34 Rue de l’Église', 'Bordeaux'),
    (7, 'Roux', 'Antoine', '89 Avenue Jean Jaurès', 'Lille'),
    (8, 'Moreau', 'Claire', '23 Rue de la République', 'Rennes'),
    (9, 'Petit', 'Louis', '67 Rue Gambetta', 'Nantes'),
    (10, 'Girard', 'Camille', '10 Rue du Dôme', 'Strasbourg'),
    (17, 'Marchand', 'Celine', '91 Avenue Jean Jaurès', 'Lille'),
    (18, 'Giraud', 'Lucie', '26 Rue de la République', 'Rennes'),
    (19, 'Renard', 'David', '70 Rue Gambetta', 'Nantes'),
    (20, 'Leroux', 'Sarah', '12 Rue du Dôme', 'Strasbourg');

-- Create a user-defined function adr_complet
DELIMITER //

CREATE FUNCTION adresse_complete(@codeC INT)
RETURNS VARCHAR(200)
BEGIN
    DECLARE @adresse VARCHAR(200);
    
    SELECT @adresse = CONCAT(adresse, ' ', ville)
    FROM cliente
    WHERE codeC = @codeC;

    RETURN @adresse;
END //

DELIMITER ;




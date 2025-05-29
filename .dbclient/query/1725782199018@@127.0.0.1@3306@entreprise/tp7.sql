-- Active: 1725782199018@@127.0.0.1@3306@entreprise
drop DATABASE IF EXISTS vvvvvv;
CREATE DATABASE vvvvvv;
USE vvvvvv;
CREATE TABLE agences (
    Num_Agence INT PRIMARY KEY,
    Nom_Agence VARCHAR(255),
    Ville_Agence VARCHAR(255),
    Actif_Agence DECIMAL(10,2),
    taux_Actif DECIMAL(5,2),
    total_Actif DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE clients (
    Num_Client INT PRIMARY KEY,
    Nom_Client VARCHAR(255),
    Prenom_Client VARCHAR(255),
    sexe CHAR(1),
    Ville_Client VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE comptes (
    Num_Compte INT PRIMARY KEY,
    Solde_Compte DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Num_Client INT,
    Num_Agence INT,
    FOREIGN KEY (Num_Client) REFERENCES clients(Num_Client),
    FOREIGN KEY (Num_Agence) REFERENCES agences(Num_Agence)
);

CREATE TABLE emprunts (
    Num_Emprunt INT PRIMARY KEY,
    Montant_Emprunt DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Num_Client INT,
    Num_Agence INT,
    FOREIGN KEY (Num_Client) REFERENCES clients(Num_Client),
    FOREIGN KEY (Num_Agence) REFERENCES agences(Num_Agence)
);

CREATE TABLE emprunts_supprimees (
    Num_Emprunt INT,
    Montant_Emprunt DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Num_Client INT,
    Num_Agence INT
);
CREATE TRIGGER emprunts_supprimees_trigger
AFTER DELETE ON emprunts
FOR EACH ROW
BEGIN
    INSERT INTO emprunts_supprimees (Num_Emprunt, Montant_Emprunt, created_at, updated_at, Num_Client, Num_Agence)
    VALUES (OLD.Num_Emprunt, OLD.Montant_Emprunt, OLD.created_at, OLD.updated_at, OLD.Num_Client, OLD.Num_Agence);
END;
CREATE TABLE audit_comptes (
    event_type VARCHAR(50),
    event_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Num_Compte INT
);
CREATE TRIGGER comptes_inserees_trigger
AFTER INSERT ON comptes
FOR EACH ROW
BEGIN
    INSERT INTO audit_comptes (event_type, Num_Compte)
    VALUES ('INSERT', NEW.Num_Compte);
END;
CREATE TRIGGER comptes_supprimees_trigger
AFTER DELETE ON comptes
FOR EACH ROW
BEGIN
    INSERT INTO audit_comptes (event_type, Num_Compte)
    VALUES ('DELETE', OLD.Num_Compte);
END;
CREATE TRIGGER comptes_modifiees_trigger
AFTER UPDATE ON comptes
FOR EACH ROW
BEGIN
    INSERT INTO audit_comptes (event_type, Num_Compte)
    VALUES ('UPDATE', NEW.Num_Compte);
END;
CREATE TRIGGER verif_agence_trigger
BEFORE INSERT ON emprunts
FOR EACH ROW
BEGIN
    DECLARE agence_exists INT;
    SELECT COUNT(*) INTO agence_exists 
    FROM agences 
    WHERE Num_Agence = NEW.Num_Agence;

    IF agence_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'L\'agence n\'existe pas.';
    END IF;
END;

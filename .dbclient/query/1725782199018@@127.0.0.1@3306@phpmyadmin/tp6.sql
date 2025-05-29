-- Active: 1725782199018@@127.0.0.1@3306@phpmyadmin
-- Création de la base de données AEROPORT
CREATE DATABASE IF NOT EXISTS AEROPORT;
USE AEROPORT;

-- Création de la table Pilote
CREATE TABLE IF NOT EXISTS Pilote (
    Code_pilote INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    salaire DECIMAL(10, 2) NOT NULL
);

-- Création de la table Compagnie
CREATE TABLE IF NOT EXISTS Compagnie (
    Code_compagnie INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    origine VARCHAR(255) NOT NULL
);

-- Création de la table Avion
CREATE TABLE IF NOT EXISTS Avion (
    Code_avion INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    capacite INT NOT NULL
);

-- Création de la table Vol
CREATE TABLE IF NOT EXISTS Vol (
    Code_vol INT AUTO_INCREMENT PRIMARY KEY,
    Ville_depart VARCHAR(255) NOT NULL,
    Ville_arrivee VARCHAR(255) NOT NULL,
    heure_depart TIME NOT NULL,
    jour_depart DATE NOT NULL,
    heure_arrivee TIME NOT NULL,
    jour_arrivee DATE NOT NULL,
    ref_pilote INT,
    ref_avion INT,
    ref_compagnie INT,
    FOREIGN KEY (ref_pilote) REFERENCES Pilote(Code_pilote) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (ref_avion) REFERENCES Avion(Code_avion) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (ref_compagnie) REFERENCES Compagnie(Code_compagnie) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Insertion de 10 pilotes dans la table Pilote
INSERT INTO Pilote (nom, prenom, salaire) VALUES
('Durand', 'Jean', 6000),
('Martin', 'Sophie', 6500),
('Dupont', 'Pierre', 7000),
('Leroy', 'Claire', 5000),
('Rousseau', 'Luc', 8000),
('Moreau', 'Marie', 7500),
('Fournier', 'Alain', 5500),
('Bernard', 'Julie', 6000),
('Girard', 'Paul', 6700),
('Blanc', 'Alice', 7000);

-- Insertion de 10 compagnies dans la table Compagnie
INSERT INTO Compagnie (nom, origine) VALUES
('Air France', 'France'),
('Lufthansa', 'Allemagne'),
('British Airways', 'Royaume-Uni'),
('American Airlines', 'États-Unis'),
('Emirates', 'Émirats Arabes Unis'),
('Qantas', 'Australie'),
('Iberia', 'Espagne'),
('Air Canada', 'Canada'),
('KLM', 'Pays-Bas'),
('Qatar Airways', 'Qatar');

-- Insertion de 10 avions dans la table Avion
INSERT INTO Avion (type, capacite) VALUES
('Boeing 737', 189),
('Airbus A320', 180),
('Boeing 777', 396),
('Airbus A380', 853),
('Boeing 747', 416),
('Embraer E190', 100),
('Bombardier CRJ700', 78),
('Airbus A330', 277),
('Boeing 787', 242),
('Airbus A350', 300);

-- Insertion de vols dans la table Vol avec ajustement des salaires selon les conditions de l'exercice 3

-- Pilote 1 : 2 vols (5% d'augmentation)
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Paris', 'New York', '08:30:00', '2024-10-01', '11:30:00', '2024-10-01', 1, 1, 1),
('Paris', 'Londres', '07:00:00', '2024-10-02', '08:10:00', '2024-10-02', 1, 2, 1);

-- Pilote 2 : 3 vols (5% d'augmentation)
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Londres', 'Paris', '09:00:00', '2024-10-02', '10:20:00', '2024-10-02', 2, 2, 3),
('Londres', 'Berlin', '13:00:00', '2024-10-03', '15:30:00', '2024-10-03', 2, 3, 3),
('Berlin', 'Madrid', '12:15:00', '2024-10-03', '14:45:00', '2024-10-03', 2, 4, 2);

-- Pilote 3 : 2 vols (5% d'augmentation)
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Berlin', 'Rome', '08:00:00', '2024-10-04', '10:00:00', '2024-10-04', 3, 3, 2),
('Rome', 'New York', '14:00:00', '2024-10-04', '18:30:00', '2024-10-04', 3, 5, 3);

-- Pilote 4 : 4 vols (10% d'augmentation)
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Sydney', 'Dubai', '16:45:00', '2024-10-04', '22:30:00', '2024-10-04', 4, 4, 6),
('Dubai', 'Singapore', '10:00:00', '2024-10-05', '14:30:00', '2024-10-05', 4, 6, 6),
('Singapore', 'Tokyo', '16:00:00', '2024-10-06', '22:00:00', '2024-10-06', 4, 8, 6),
('Tokyo', 'Sydney', '08:00:00', '2024-10-07', '18:30:00', '2024-10-07', 4, 9, 6);

-- Pilote 5 : 5 vols (10% d'augmentation)
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Doha', 'Tokyo', '10:00:00', '2024-10-05', '18:00:00', '2024-10-05', 5, 5, 10),
('Tokyo', 'Seoul', '12:00:00', '2024-10-06', '14:00:00', '2024-10-06', 5, 7, 10),
('Seoul', 'Beijing', '16:00:00', '2024-10-06', '18:30:00', '2024-10-06', 5, 8, 10),
('Beijing', 'Shanghai', '09:00:00', '2024-10-07', '11:30:00', '2024-10-07', 5, 9, 10),
('Shanghai', 'Guangzhou', '14:00:00', '2024-10-08', '16:30:00', '2024-10-08', 5, 10, 10);

-- Pilote 6 : 6 vols (10% d'augmentation)
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Los Angeles', 'Toronto', '14:30:00', '2024-10-06', '17:00:00', '2024-10-06', 6, 6, 4),
('Toronto', 'Montreal', '09:00:00', '2024-10-07', '10:30:00', '2024-10-07', 6, 7, 4),
('Montreal', 'Vancouver', '12:00:00', '2024-10-08', '15:00:00', '2024-10-08', 6, 8, 4),
('Vancouver', 'Calgary', '09:00:00', '2024-10-09', '11:30:00', '2024-10-09', 6, 9, 4),
('Calgary', 'Edmonton', '13:00:00', '2024-10-10', '14:30:00', '2024-10-10', 6, 10, 4),
('Edmonton', 'Los Angeles', '16:00:00', '2024-10-11', '18:30:00', '2024-10-11', 6, 6, 4);

-- Pilote 7 : 7 vols (15% d'augmentation)
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Amsterdam', 'Dubai', '06:00:00', '2024-10-07', '14:30:00', '2024-10-07', 7, 7, 9),
('Dubai', 'Mumbai', '18:00:00', '2024-10-07', '21:30:00', '2024-10-07', 7, 10, 9),
('Mumbai', 'Delhi', '08:00:00', '2024-10-08', '09:30:00', '2024-10-08', 7, 9, 9),
('Delhi', 'Bangkok', '11:00:00', '2024-10-08', '14:30:00', '2024-10-08', 7, 8, 9),
('Bangkok', 'Singapore', '16:00:00', '2024-10-09', '18:30:00', '2024-10-09', 7, 7, 9),
('Singapore', 'Kuala Lumpur', '10:00:00', '2024-10-10', '11:30:00', '2024-10-10', 7, 6, 9),
('Kuala Lumpur', 'Jakarta', '13:00:00', '2024-10-11', '14:30:00', '2024-10-11', 7, 5, 9);

-- Pilote 8 : 3 vols (5% d'augmentation)
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Madrid', 'Buenos Aires', '18:00:00', '2024-10-08', '04:30:00', '2024-10-09', 8, 8, 7),
('Buenos Aires', 'Santiago', '09:00:00', '2024-10-09', '10:30:00', '2024-10-09', 8, 6, 7),
('Santiago', 'Lima', '12:00:00', '2024-10-10', '14:00:00', '2024-10-10', 8, 9, 7);

-- Pilote 9 : 1 vol (5% d'augmentation)
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Paris', 'Rome', '07:00:00', '2024-10-09', '08:45:00', '2024-10-09', 9, 9, 1);

 
DELIMITER //
DROP PROCEDURE list_pilots;

CREATE PROCEDURE list_pilots()
BEGIN
    
    DECLARE done INT DEFAULT FALSE;
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE pilote_salaire DECIMAL(10,2);
    
    
    DECLARE pilote_cursor CURSOR FOR
    SELECT Code_pilote, nom, prenom, salaire
    FROM Pilote;
    
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    
    OPEN pilote_cursor;
    
    read_loop: LOOP
        
        FETCH pilote_cursor INTO pilote_id, pilote_nom, pilote_prenom, pilote_salaire;
        
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        
        SELECT pilote_id AS 'Code Pilote', 
               CONCAT(pilote_nom, ' ', pilote_prenom) AS 'Nom Complet',
               pilote_salaire AS 'Salaire';
    END LOOP;
    
    
    CLOSE pilote_cursor;
END //

DELIMITER ;
CALL list_pilots();



DELIMITER //
DROP PROCEDURE IF EXISTS list_pilots_and_flights;
CREATE PROCEDURE list_pilots_and_flights()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE vol_depart VARCHAR(100);
    DECLARE vol_arrivee VARCHAR(100);

    -- Déclaration du curseur pour récupérer les pilotes
    DECLARE pilote_cursor CURSOR FOR
        SELECT Code_Pilote, nom, prenom FROM Pilote;

    -- Déclaration du curseur pour récupérer les vols pour chaque pilote
    DECLARE vol_cursor CURSOR FOR
        SELECT Ville_Depart, Ville_Arrivee FROM Vol WHERE ref_Pilote = pilote_id;

    -- Gestion des exceptions : Un seul handler pour la fin des curseurs
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Ouvrir le curseur des pilotes
    OPEN pilote_cursor;

    -- Boucle pour chaque pilote
    read_pilot_loop: LOOP
        SET done=TRUE;
        -- Récupérer les informations du pilote
        FETCH pilote_cursor INTO pilote_id, pilote_nom, pilote_prenom;

        -- Sortir de la boucle si nous avons terminé de parcourir les pilotes
        IF done THEN
            LEAVE read_pilot_loop;
        END IF;

        -- Afficher les informations du pilote
        SELECT CONCAT('Le pilote ', pilote_nom, ' ', pilote_prenom, ' est affecté aux vols :');

        -- Réinitialiser la variable done pour l'utilisation du curseur des vols
        SET done = FALSE;

        -- Ouvrir le curseur des vols pour ce pilote
        OPEN vol_cursor;
        
        -- Boucle pour les vols du pilote
        read_vol_loop: LOOP
            -- Récupérer les informations des vols
            FETCH vol_cursor INTO vol_depart, vol_arrivee;

            -- Sortir de la boucle si nous avons terminé de parcourir les vols
            IF done THEN
                LEAVE read_vol_loop;
            END IF;

            -- Afficher les informations de chaque vol
            SELECT CONCAT('Départ : ', vol_depart, '  Arrivée : ', vol_arrivee);
        END LOOP;
        
        -- Fermer le curseur des vols après avoir parcouru tous les vols du pilote
        CLOSE vol_cursor;
    END LOOP;

    -- Fermer le curseur des pilotes
    CLOSE pilote_cursor;
END //

DELIMITER ;

CALL list_pilots_and_flights();








DELIMITER //

CREATE PROCEDURE update_pilot_salary()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE pilote_salaire DECIMAL(10,2);
    DECLARE vol_count INT;
    DECLARE nouveau_salaire DECIMAL(10,2);

    -- Déclaration du curseur pour récupérer les pilotes
    DECLARE pilote_cursor CURSOR FOR
        SELECT Code_Pilote, nom, prenom, salaire FROM Pilote;

    -- Déclaration du curseur pour compter les vols
    DECLARE vol_count_cursor CURSOR FOR
        SELECT COUNT(*) FROM Vol WHERE ref_Pilote = pilote_id;

    -- Gestion des exceptions : Un seul handler pour la fin des curseurs
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Ouvrir le curseur des pilotes
    OPEN pilote_cursor;

    -- Boucle pour chaque pilote
    read_pilot_loop: LOOP
        -- Récupérer les informations du pilote
        FETCH pilote_cursor INTO pilote_id, pilote_nom, pilote_prenom, pilote_salaire;

        -- Sortir de la boucle si nous avons terminé de parcourir les pilotes
        IF done THEN
            LEAVE read_pilot_loop;
        END IF;

        -- Compter les vols pour ce pilote
        SET done = FALSE;
        OPEN vol_count_cursor;
        FETCH vol_count_cursor INTO vol_count;
        CLOSE vol_count_cursor;

        -- Calculer le nouveau salaire
        IF vol_count = 0 THEN
            nouveau_salaire := pilote_salaire;
        ELSEIF vol_count BETWEEN 1 AND 3 THEN
            nouveau_salaire := pilote_salaire * 1.05;
        ELSEIF vol_count BETWEEN 4 AND 6 THEN
            nouveau_salaire := pilote_salaire * 1.10;
        ELSE
            nouveau_salaire := pilote_salaire * 1.15;
        END IF;

        -- Afficher l'ancien et le nouveau salaire
        SELECT CONCAT('Pilote : ', pilote_nom, ' ', pilote_prenom, ', Ancien Salaire : ', pilote_salaire, ', Nouveau Salaire : ', nouveau_salaire);
    END LOOP;

    -- Fermer le curseur des pilotes
    CLOSE pilote_cursor;
END //

DELIMITER ;

CALL update_pilot_salary();















DELIMITER //

CREATE PROCEDURE top_three_pilots()
BEGIN
    CREATE TABLE IF NOT EXISTS Top_Pilots AS
    SELECT * FROM (
        SELECT * FROM Pilote
        ORDER BY salaire DESC
    ) WHERE ROWNUM <= 3;

    SELECT * FROM Top_Pilots;
END //

DELIMITER ;

CALL top_three_pilots();


















DELIMITER //

CREATE PROCEDURE frequent_flights_per_pilot()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE vol_depart VARCHAR(100);
    DECLARE vol_arrivee VARCHAR(100);
    DECLARE vol_count INT;

    -- Déclaration du curseur pour récupérer les pilotes
    DECLARE pilote_cursor CURSOR FOR
        SELECT Code_Pilote, nom, prenom FROM Pilote;

    -- Déclaration du curseur pour récupérer les vols
    DECLARE vol_cursor CURSOR FOR
        SELECT Ville_Depart, Ville_Arrivee, COUNT(*) AS nb_vols
        FROM Vol WHERE ref_Pilote = pilote_id
        GROUP BY Ville_Depart, Ville_Arrivee
        ORDER BY nb_vols DESC;

    -- Gestion des exceptions : Un seul handler pour la fin des curseurs
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Ouvrir le curseur des pilotes
    OPEN pilote_cursor;

    -- Boucle pour chaque pilote
    read_pilot_loop: LOOP
        -- Récupérer les informations du pilote
        FETCH pilote_cursor INTO pilote_id, pilote_nom, pilote_prenom;

        -- Sortir de la boucle si nous avons terminé de parcourir les pilotes
        IF done THEN
            LEAVE read_pilot_loop;
        END IF;

        -- Afficher le pilote
        SELECT CONCAT('Le pilote ', pilote_nom, ' ', pilote_prenom, ' a effectué les vols suivants :');

        -- Réinitialiser la variable done pour l'utilisation du curseur des vols
        SET done = FALSE;

        -- Ouvrir le curseur des vols pour ce pilote
        OPEN vol_cursor;

        -- Boucle pour les vols du pilote
        read_vol_loop: LOOP
            -- Récupérer les informations des vols
            FETCH vol_cursor INTO vol_depart, vol_arrivee, vol_count;

            -- Sortir de la boucle si nous avons terminé de parcourir les vols
            IF done THEN
                LEAVE read_vol_loop;
            END IF;

            -- Afficher les informations de chaque vol
            SELECT CONCAT('Départ : ', vol_depart, ', Arrivée : ', vol_arrivee, ', Nombre de vols : ', vol_count);
        END LOOP;

        -- Fermer le curseur des vols après avoir parcouru tous les vols du pilote
        CLOSE vol_cursor;
    END LOOP;

   

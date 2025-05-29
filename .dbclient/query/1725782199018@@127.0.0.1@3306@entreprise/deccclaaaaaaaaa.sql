-- Active: 1725782199018@@127.0.0.1@3306@entreprise
-- Création des tables
drop DATABASE IF exists avvv;
CREATE DATABASE avvv;
use avvv;
CREATE TABLE Produit (
    id_produit INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100),
    stock INT,
    prix DECIMAL(10, 2)
);

CREATE TABLE Commande (
    id_commande INT PRIMARY KEY AUTO_INCREMENT,
    date_commande DATE
);

CREATE TABLE LigneCommande (
    id_ligne INT PRIMARY KEY AUTO_INCREMENT,
    id_commande INT,
    id_produit INT,
    quantite INT,
    FOREIGN KEY (id_commande) REFERENCES Commande(id_commande),
    FOREIGN KEY (id_produit) REFERENCES Produit(id_produit)
);

INSERT INTO Produit (nom, stock, prix) VALUES
('Ordinateur', 10, 1000),
('Souris', 50, 20),
('Clavier', 30, 50);

CREATE TABLE JourFerie (
    id_jour INT PRIMARY KEY AUTO_INCREMENT,
    date_ferie DATE
);

INSERT INTO JourFerie (date_ferie) VALUES
('2024-01-01'),
('2024-05-01'),
('2024-08-20');

CREATE PROCEDURE diffffff()
BEGIN commandeid INT;
DECLARE 
  START TRANSACTION;


  INSERT INTO Commande (date_commande) VALUES (CURDATE());

  SET commandeid = LAST_INSERT_ID();

  INSERT INTO LigneCommande (id_commande, id_produit, quantite) VALUES (commandeid, 1, 1); 
  INSERT INTO LigneCommande (id_commande, id_produit, quantite) VALUES (commandeid, 2, 2); 

  UPDATE Produit SET stock = stock - 1 WHERE id_produit = 1; 
  UPDATE Produit SET stock = stock - 2 WHERE id_produit = 2; 

  COMMIT;
  
END;



DELIMITER //

CREATE PROCEDURE ajouter_commande(IN p_id_produit INT, IN p_quantite INT)
BEGIN
    DECLARE stock_disponible INT;
    DECLARE id_commande INT;
    
    SELECT stock INTO stock_disponible FROM Produit WHERE id_produit = p_id_produit;
    
    IF stock_disponible < p_quantite THEN
        SELECT 'Erreur : Stock insuffisant pour ce produit' AS message;
    ELSE
        START TRANSACTION;
        
        INSERT INTO Commande (date_commande) VALUES (CURDATE());
        SET id_commande = LAST_INSERT_ID();
        
        INSERT INTO LigneCommande (id_commande, id_produit, quantite)
        VALUES (id_commande, p_id_produit, p_quantite);
        
        UPDATE Produit SET stock = stock - p_quantite WHERE id_produit = p_id_produit;
        
        COMMIT;
        
        SELECT 'Commande ajoutée avec succès' AS message;
    END IF;
END //

DELIMITER ;


CALL ajouter_commande(1, 2); 
CALL ajouter_commande(2, 100); 



CREATE TABLE JourFerie (
    id_jour INT PRIMARY KEY AUTO_INCREMENT,
    date_ferie DATE
);

INSERT INTO JourFerie (date_ferie) VALUES
('2024-01-01'),
('2024-05-01'),
('2024-08-20');



DELIMITER //

CREATE PROCEDURE ajouter_commande_jour_ferie(IN p_id_produit INT, IN p_quantite INT)
BEGIN
    DECLARE stock_disponible INT;
    DECLARE is_ferie INT;
    DECLARE id_commande INT;
    
    SELECT stock INTO stock_disponible FROM Produit WHERE id_produit = p_id_produit;
    
    SELECT COUNT(*) INTO is_ferie FROM JourFerie WHERE date_ferie = CURDATE();
    
    IF is_ferie > 0 THEN
        SELECT 'Erreur : La commande ne peut pas être passée un jour férié' AS message;
    ELSEIF stock_disponible < p_quantite THEN
        SELECT 'Erreur : Stock insuffisant pour ce produit' AS message;
    ELSE
        START TRANSACTION;
        
        INSERT INTO Commande (date_commande) VALUES (CURDATE());
        SET id_commande = LAST_INSERT_ID();
        
        INSERT INTO LigneCommande (id_commande, id_produit, quantite)
        VALUES (id_commande, p_id_produit, p_quantite);
        
        UPDATE Produit SET stock = stock - p_quantite WHERE id_produit = p_id_produit;
        
        COMMIT;
        
        SELECT 'Commande ajoutée avec succès' AS message;
    END IF;
END //

DELIMITER ;



CALL ajouter_commande_jour_ferie(1, 2); -- Ajoute 2 ordinateurs, sauf si c'est un jour férié




DELIMITER //

CREATE PROCEDURE ajouter_commande_avec_budget(IN p_id_produit INT, IN p_quantite INT, IN budget_max DECIMAL(10, 2))
BEGIN
    DECLARE stock_disponible INT;
    DECLARE total_commande DECIMAL(10, 2);
    DECLARE id_commande INT;
    DECLARE prix_produit DECIMAL(10, 2);
    
    SELECT stock, prix INTO stock_disponible, prix_produit FROM Produit WHERE id_produit = p_id_produit;
    
    SET total_commande = p_quantite * prix_produit;
    
    IF total_commande > budget_max THEN
        SELECT 'Erreur : Le total de la commande dépasse le budget autorisé' AS message;
    ELSEIF stock_disponible < p_quantite THEN
        SELECT 'Erreur : Stock insuffisant pour ce produit' AS message;
    ELSE
        START TRANSACTION;
        
        INSERT INTO Commande (date_commande) VALUES (CURDATE());
        SET id_commande = LAST_INSERT_ID();
        
        INSERT INTO LigneCommande (id_commande, id_produit, quantite)
        VALUES (id_commande, p_id_produit, p_quantite);
        
        UPDATE Produit SET stock = stock - p_quantite WHERE id_produit = p_id_produit;
        
        COMMIT;
        
        SELECT 'Commande ajoutée avec succès' AS message;
    END IF;
END //

DELIMITER ;




CALL ajouter_commande_avec_budget(1, 2, 1500); -- Tentative d'ajouter 2 ordinateurs avec un budget de 1500 EUR



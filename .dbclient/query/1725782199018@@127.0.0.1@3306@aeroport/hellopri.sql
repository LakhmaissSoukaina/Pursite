-- Active: 1725782199018@@127.0.0.1@3306@aeroport
-- 1. Créer la base de données
CREATE DATABASE gestion_entreprise;

-- 2. Créer un utilisateur avec un mot de passe
CREATE USER 'employe_user'@'localhost' IDENTIFIED BY 'password123';

-- 3. Accorder tous les privilèges sur la base de données à l'utilisateur
GRANT ALL PRIVILEGES ON gestion_entreprise.* TO 'employe_user'@'localhost';

-- 4. Appliquer les changements
FLUSH PRIVILEGES;

-- 5. Utiliser la base de données
USE gestion_entreprise;

-- 6. Créer la table Employes
CREATE TABLE Employes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    poste VARCHAR(50),
    salaire DECIMAL(10, 2)
);

-- 7. Insérer des données dans la table
INSERT INTO Employes (nom, prenom, poste, salaire) VALUES
('Doe', 'John', 'Developpeur', 3000.00),
('Smith', 'Jane', 'Manager', 4500.00);

-- 8. Afficher les données
SELECT * FROM Employes;

-- 9. Mettre à jour les données
UPDATE Employes SET salaire = 3500.00 WHERE nom = 'Doe' AND prenom = 'John';

-- 10. Supprimer un employé
DELETE FROM Employes WHERE nom = 'Smith' AND prenom = 'Jane';

-- 11. Vérifier les modifications
SELECT * FROM Employes;

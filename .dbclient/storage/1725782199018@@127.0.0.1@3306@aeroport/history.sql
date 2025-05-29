/* 2024-10-12 16:31:53 [20 ms] */ 
CREATE DATABASE gestion_entreprise;
/* 2024-10-12 16:31:54 [16 ms] */ 
CREATE USER 'employe_user'@'localhost' IDENTIFIED BY 'password123';
/* 2024-10-12 16:31:55 [12 ms] */ 
GRANT ALL PRIVILEGES ON gestion_entreprise.* TO 'employe_user'@'localhost';
/* 2024-10-12 16:31:56 [11 ms] */ 
FLUSH PRIVILEGES;
/* 2024-10-12 16:31:58 [7 ms] */ 
USE gestion_entreprise;
/* 2024-10-12 16:32:00 [121 ms] */ 
CREATE TABLE Employes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    poste VARCHAR(50),
    salaire DECIMAL(10, 2)
);
/* 2024-10-12 16:32:04 [114 ms] */ 
INSERT INTO Employes (nom, prenom, poste, salaire) VALUES
('Doe', 'John', 'Developpeur', 3000.00),
('Smith', 'Jane', 'Manager', 4500.00);
/* 2024-10-12 16:32:07 [21 ms] */ 
SELECT * FROM Employes LIMIT 100;
/* 2024-10-12 16:32:10 [30 ms] */ 
UPDATE Employes SET salaire = 3500.00 WHERE nom = 'Doe' AND prenom = 'John';
/* 2024-10-12 16:32:13 [53 ms] */ 
DELETE FROM Employes WHERE nom = 'Smith' AND prenom = 'Jane';
/* 2024-10-12 16:32:14 [6 ms] */ 
SELECT * FROM Employes LIMIT 100;

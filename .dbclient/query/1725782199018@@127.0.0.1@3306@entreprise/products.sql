-- Active: 1725782199018@@127.0.0.1@3306@entreprise
-- Création de la table Client
CREATE TABLE Client (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telephone VARCHAR(15)
);
 
-- Création de la table Article
CREATE TABLE Article (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prix DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0 -- Nombre d'articles en stock
);
 
-- Création de la table Commande
CREATE TABLE Commande (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    date_commande DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Client(id) ON DELETE CASCADE
);
 
-- Création de la table DetailCommande
CREATE TABLE DetailCommande (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    article_id INT NOT NULL,
    quantite INT NOT NULL CHECK (quantite > 0), -- Vérifie que la quantité est positive
    FOREIGN KEY (commande_id) REFERENCES Commande(id) ON DELETE CASCADE,
    FOREIGN KEY (article_id) REFERENCES Article(id) ON DELETE CASCADE
);
 
-- Insertion d'exemples de données dans la table Client
INSERT INTO Client (nom, email, telephone) VALUES
('Alice Dupont', 'alice.dupont@example.com', '0123456789'),
('Bob Martin', 'bob.martin@example.com', '0987654321');
 
-- Insertion d'exemples de données dans la table Article
INSERT INTO Article (nom, prix, stock) VALUES
('Article A', 15.00, 10),
('Article B', 25.50, 5),
('Article C', 5.75, 20);
 
INSERT INTO commande(client_id,date_commande) VALUES (1,'2024-1-12');
 
INSERT INTO detailcommande(commande_id,article_id,quantite) VALUES(1,1,5);
 
DELETE FROM detailcommande
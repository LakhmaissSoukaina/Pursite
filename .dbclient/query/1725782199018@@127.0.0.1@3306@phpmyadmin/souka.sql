-- Active: 1725782199018@@127.0.0.1@3306@phpmyadmin
CREATE DATABASE entreprise;
CREATE TABLE produit(
 idProduit int primary key AUTO_INCREMENT,
 nomProduit VARCHAR(100),
 decription VARCHAR(100),
 prix INT,
 categorie VARCHAR(100)
);

CREATE TABLE client_1(
idClient int primary key AUTO_INCREMENT,
nomClient VARCHAR(100),
prenomClient VARCHAR(100),
email VARCHAR (100),
ville VARCHAR (100),
rue VARCHAR (100),
pays VARCHAR (100),
telephone VARCHAR(100)
);
CREATE TABLE commande (
 idCommande int PRIMARY KEY AUTO_INCREMENT,
 idClient int,
 dateCommande DATE,
 statut VARCHAR(100),
 FOREIGN KEY (idClient) REFERENCES client_1(idClient)
);
CREATE TABLE paiement(
idPaiement int PRIMARY KEY AUTO_INCREMENT,
idCommande int,
montant int,
datePaiement DATE,
modePaiement VARCHAR(100),
FOREIGN KEY (idCommande) REFERENCES commande(idCommande)
);
CREATE TABLE detailCommande (
idCommande int,
idProduit int,
quantite int,
PRIMARY KEY (idCommande,idProduit),
FOREIGN KEY (idCommande) REFERENCES commande(idCommande),
FOREIGN KEY (idProduit) REFERENCES produit(idProduit)
);
SELECT * FROM produit WHERE `nomProduit` LIKE '%usb%';
SELECT (SUM(prix*dt.quantite)),produit.`idProduit` FROM produit as produit
INNER JOIN detailcommande dt on produit.`idProduit`=dt.`idProduit`
GROUP BY produit.`idProduit`;
SELECT client_1.`idClient`,(SUM(prix*detailcommande.quantite))FROM client_1
INNER JOIN commande on client_1.`idClient`=commande.`idClient`
INNER JOIN detailcommande on commande.`idCommande`=detailcommande.`idCommande`
INNER JOIN produit on detailcommande.`idProduit`=produit.`idProduit`
GROUP BY client_1.`idClient`;
SELECT produit.`idProduit`,(SUM(detailcommande.quantite))FROM produit
INNER JOIN detailcommande on produit.`idProduit`=detailcommande.`idProduit`
GROUP BY produit.`idProduit`
ORDER BY SUM(detailcommande.quantite) DESC
LIMIT 2;
SELECT * from commande WHERE dateCommande BETWEEN '2020-05-04' AND '2024-06-07';
SELECT * FROM produit WHERE `idProduit`
NOT IN(SELECT `idProduit` FROM detailcommande);
SELECT client_1.* FROM client_1
INNER JOIN commande on client_1.`idClient`=commande.`idClient`
GROUP BY client_1.`idClient`
ORDER BY COUNT(commande.`idClient`) DESC;
SELECT DATEDIFF(paiement.`datePaiement`,commande.`dateCommande`)FROM paiement
INNER JOIN commande on paiement.`idCommande`=commande.`idCommande`;
SELECT client_1.* , paiement.* , commande.statut FROM client_1
INNER JOIN commande on client_1.`idClient`=commande.`idClient`
INNER JOIN paiement on commande.`idCommande`=paiement.`idCommande`
WHERE (statut="true");
SELECT client_1.* , commande.* FROM client_1
RIGHT JOIN commande on client_1.`idClient`=commande.`idClient`;
SELECT * FROM paiement
RIGHT JOIN commande on paiement.`idCommande`=commande.`idCommande`;
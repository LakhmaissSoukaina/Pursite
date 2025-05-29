-- Active: 1725782199018@@127.0.0.1@3306@phpmyadmin
CREATE DATABASE societe;
USE societe;
CREATE TABLE ProduitFini (
    CodProFini INT PRIMARY KEY,     -- Code du produit fini
    NomPro VARCHAR(255),            -- Nom du produit fini
    QteEnStock DECIMAL(10, 2)       -- Quantité en stock pour ce produit fini
);

CREATE TABLE Fournisseur (
    NumFour INT PRIMARY KEY,        -- Numéro du fournisseur
    RsFour VARCHAR(255),            -- Raison sociale du fournisseur
    AdrFour VARCHAR(255)            -- Adresse du fournisseur
);
CREATE TABLE ProduitBrut (
    CodProBrut INT PRIMARY KEY,     -- Code du produit brut
    NomProBrut VARCHAR(255),        -- Nom du produit brut
    PrixAchat DECIMAL(10, 2),       -- Prix d'achat du produit brut
    NumFour INT,                    -- Numéro du fournisseur de ce produit brut
    FOREIGN KEY (NumFour) REFERENCES Fournisseur(NumFour)
);
CREATE TABLE Composition (
    CodProFini INT,                 -- Code du produit fini
    CodProBrut INT,                 -- Code du produit brut utilisé dans la composition
    Quantite DECIMAL(10, 2),        -- Quantité de produit brut utilisée dans la composition
    PRIMARY KEY (CodProFini, CodProBrut),
    FOREIGN KEY (CodProFini) REFERENCES ProduitFini(CodProFini),
    FOREIGN KEY (CodProBrut) REFERENCES ProduitBrut(CodProBrut)
);

CREATE TABLE Mouvement (
    NumMvt INT PRIMARY KEY,         -- Numéro de mouvement
    TypeMvt CHAR(1),                -- Type de mouvement : 'S' pour sortie, 'E' pour entrée
    Quantite DECIMAL(10, 2),        -- Quantité déplacée dans le mouvement
    CodProFini INT,                 -- Code du produit fini concerné
    CodProBrut INT,                 -- Code du produit brut (utilisé uniquement si nécessaire pour certains types de mouvements)
    QteUtilisee DECIMAL(10, 2),     -- Quantité utilisée de produit brut (optionnel)
    FOREIGN KEY (CodProFini) REFERENCES ProduitFini(CodProFini),
    FOREIGN KEY (CodProBrut) REFERENCES ProduitBrut(CodProBrut)
);
DELIMITER $$

CREATE PROCEDURE NbProduitsBrutsParFini()
BEGIN
    SELECT pf.NomPro AS ProduitFini, COUNT(c.CodProBrut) AS NbProduitsBruts
    FROM ProduitFini pf
    JOIN Composition c ON pf.CodProFini = c.CodProFini
    GROUP BY pf.NomPro;
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE MaxPrixAchat(OUT prixMax DECIMAL(10, 2))
BEGIN
    SELECT MAX(PrixAchat) INTO prixMax
    FROM ProduitBrut;
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE ProduitsPlusDeDeuxBruts()
BEGIN
    SELECT pf.NomPro
    FROM ProduitFini pf
    JOIN Composition c ON pf.CodProFini = c.CodProFini
    GROUP BY pf.NomPro
    HAVING COUNT(c.CodProBrut) > 2;
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE RsFourProduitBrut(IN nomProduitBrut VARCHAR(255), OUT rsFour VARCHAR(255))
BEGIN
    SELECT f.RsFour INTO rsFour
    FROM ProduitBrut pb
    JOIN Fournisseur f ON pb.NumFour = f.NumFour
    WHERE pb.NomProBrut = nomProduitBrut;
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE ListeMouvementsSortie(IN codProduitFini INT)
BEGIN
    SELECT *
    FROM Mouvement
    WHERE CodProFini = codProduitFini AND TypeMvt = 'S';
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE ListeMouvementsType(IN codProduitFini INT, IN typeMvt CHAR(1))
BEGIN
    SELECT *
    FROM Mouvement
    WHERE CodProFini = codProduitFini AND TypeMvt = typeMvt;
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE VerifierStockProduitFini()
BEGIN
    SELECT pf.NomPro, pf.QteEnStock, 
           (SELECT SUM(m.Quantite) FROM Mouvement m WHERE m.CodProFini = pf.CodProFini AND m.TypeMvt = 'S') AS QteSortie,
           (SELECT SUM(m.Quantite) FROM Mouvement m WHERE m.CodProFini = pf.CodProFini AND m.TypeMvt = 'E') AS QteEntree,
           CASE 
               WHEN pf.QteEnStock = ((SELECT SUM(m.Quantite) FROM Mouvement m WHERE m.CodProFini = pf.CodProFini AND m.TypeMvt = 'E') - 
                                     (SELECT SUM(m.Quantite) FROM Mouvement m WHERE m.CodProFini = pf.CodProFini AND m.TypeMvt = 'S'))
               THEN 'Stock Ok'
               ELSE 'Problème de Stock'
           END AS StatusStock
    FROM ProduitFini pf;
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE PrixRevientProduitFini(IN codProduitFini INT, OUT prixRevient DECIMAL(10, 2))
BEGIN
    SELECT SUM(pb.PrixAchat * c.Quantite) INTO prixRevient
    FROM ProduitBrut pb
    JOIN Composition c ON pb.CodProBrut = c.CodProBrut
    WHERE c.CodProFini = codProduitFini;
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE InfosProduitsFini()
BEGIN
    SELECT pf.NomPro AS ProduitFini, 
           (SELECT SUM(pb.PrixAchat * c.Quantite) 
            FROM ProduitBrut pb
            JOIN Composition c ON pb.CodProBrut = c.CodProBrut
            WHERE c.CodProFini = pf.CodProFini) AS PrixRevient,
           GROUP_CONCAT(CONCAT(pb.NomProBrut, ' (', pb.PrixAchat, ' ', f.RsFour, ')') SEPARATOR ', ') AS ListeProduitsBruts,
           COUNT(c.CodProBrut) AS NbProduitsBruts
    FROM ProduitFini pf
    JOIN Composition c ON pf.CodProFini = c.CodProFini
    JOIN ProduitBrut pb ON c.CodProBrut = pb.CodProBrut
    JOIN Fournisseur f ON pb.NumFour = f.NumFour
    GROUP BY pf.NomPro;
END $$

DELIMITER ;
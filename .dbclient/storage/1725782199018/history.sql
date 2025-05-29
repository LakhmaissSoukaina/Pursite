/* 2024-09-08 09:00:40 [15 ms] */ 
CREATE DATABASE entreprise;
/* 2024-09-08 09:01:49 [51 ms] */ 
CREATE TABLE table1(  
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    create_time DATETIME,
    name VARCHAR(255)
);
/* 2024-09-08 09:02:12 [6 ms] */ 
SELECT * FROM table1 LIMIT 100;
/* 2024-09-09 21:25:04 [48 ms] */ 
CREATE TABLE produit(
 idProduit int primary key AUTO_INCREMENT,
 nomProduit VARCHAR(100),
 decription VARCHAR(100),
 prix INT,
 categorie VARCHAR(100)
);
/* 2024-09-09 21:25:07 [32 ms] */ 
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
/* 2024-09-09 21:25:09 [89 ms] */ 
CREATE TABLE commande (
 idCommande int PRIMARY KEY AUTO_INCREMENT,
 idClient int,
 dateCommande DATE,
 statut VARCHAR(100),
 FOREIGN KEY (idClient) REFERENCES client_1(idClient)
);
/* 2024-09-09 21:25:11 [101 ms] */ 
CREATE TABLE paiement(
idPaiement int PRIMARY KEY AUTO_INCREMENT,
idCommande int,
montant int,
datePaiement DATE,
modePaiement VARCHAR(100),
FOREIGN KEY (idCommande) REFERENCES commande(idCommande)
);
/* 2024-09-09 21:25:18 [89 ms] */ 
CREATE TABLE detailCommande (
idCommande int,
idProduit int,
quantite int,
PRIMARY KEY (idCommande,idProduit),
FOREIGN KEY (idCommande) REFERENCES commande(idCommande),
FOREIGN KEY (idProduit) REFERENCES produit(idProduit)
);
/* 2024-09-09 21:27:32 [6 ms] */ 
INSERT INTO `client_1`(`nomClient`,`prenomClient`,`email`,`ville`,`rue`,`pays`,`telephone`) VALUES('nnn','mmmm','nnn@gmail.com','el jadida','hay ssalam','maroc','0689765432');
/* 2024-09-09 21:27:53 [12 ms] */ 
UPDATE `client_1` SET `ville`='casa' WHERE `idClient`=1;
/* 2024-09-09 21:30:22 [8 ms] */ 
SELECT * FROM produit WHERE `nomProduit` LIKE '%usb%' LIMIT 100;
/* 2024-09-09 21:31:02 [13 ms] */ 
INSERT INTO `produit`(`nomProduit`,`decription`,`prix`,`categorie`) VALUES('usbnhg','nhgy',19,'nul');
/* 2024-09-09 21:31:06 [11 ms] */ 
SELECT * FROM produit WHERE `nomProduit` LIKE '%usb%' LIMIT 100;
/* 2024-09-09 21:37:41 [19 ms] */ 
SELECT (SUM(prix*dt.quantite)),produit.`idProduit` FROM produit as produit
INNER JOIN detailcommande dt on produit.`idProduit`=dt.`idProduit`
GROUP BY produit.`idProduit` LIMIT 100;
/* 2024-09-09 21:46:09 [16 ms] */ 
SELECT client_1.`idClient`,(SUM(prix*detailcommande.quantite))FROM client_1
INNER JOIN commande on client_1.`idClient`=commande.`idClient`
INNER JOIN detailcommande on commande.`idCommande`=detailcommande.`idCommande`
INNER JOIN produit on detailcommande.`idProduit`=produit.`idProduit`
GROUP BY client_1.`idClient`;
/* 2024-09-09 21:51:38 [23 ms] */ 
SELECT produit.`idProduit`,(SUM(detailcommande.quantite))FROM produit
INNER JOIN detailcommande on produit.`idProduit`=detailcommande.`idProduit`
GROUP BY produit.`idProduit`
ORDER BY SUM(detailcommande.quantite) DESC
LIMIT 2;
/* 2024-09-09 21:52:57 [9 ms] */ 
SELECT * from commande WHERE dateCommande BETWEEN '2020-05-04' AND '2024-06-07' LIMIT 100;
/* 2024-09-09 21:58:01 [6 ms] */ 
SELECT client_1.* FROM client_1
INNER JOIN commande on client_1.`idClient`=commande.`idClient`
GROUP BY client_1.`idClient`
ORDER BY COUNT(commande.`idClient`) DESC LIMIT 100;
/* 2024-09-09 22:02:28 [5 ms] */ 
SELECT DATEDIFF(paiement.`datePaiement`,commande.`dateCommande`)FROM paiement
INNER JOIN commande on paiement.`idCommande`=commande.`idCommande`;
/* 2024-09-09 22:05:25 [11 ms] */ 
INSERT INTO `commande`(`statut`) VALUES('true');INSERT INTO `commande`(`statut`) VALUES('false');
/* 2024-09-09 22:09:08 [12 ms] */ 
SELECT client_1.* , paiement.* , commande.statut FROM client_1
INNER JOIN commande on client_1.`idClient`=commande.`idClient`
INNER JOIN paiement on commande.`idCommande`=paiement.`idCommande`
WHERE (statut="true") LIMIT 100;
/* 2024-09-09 22:14:40 [8 ms] */ 
SELECT client_1.* , commande.* FROM client_1
RIGHT JOIN commande on client_1.`idClient`=commande.`idClient` LIMIT 100;
/* 2024-09-09 22:20:03 [9 ms] */ 
SELECT * FROM paiement
RIGHT JOIN commande on paiement.`idCommande`=commande.`idCommande` LIMIT 100;
/* 2024-09-18 17:20:58 [20 ms] */ 
CREATE DATABASE tp_procedure;
/* 2024-09-18 17:37:29 [14 ms] */ 
CREATE DATABASE gestiondescours;
/* 2024-09-18 17:37:36 [27 ms] */ 
CREATE TABLE etudiant(
 idetudiant int primary key AUTO_INCREMENT,
 nometudiant VARCHAR(100),
 prenometudiant VARCHAR(100),
 datenaiss DATE
);
/* 2024-09-18 17:37:50 [62 ms] */ 
CREATE TABLE cours(
 idcours int primary key AUTO_INCREMENT,
 nomcours VARCHAR(100),
 descriptionc VARCHAR(100),
 placedispo INT
);
/* 2024-09-18 17:38:48 [115 ms] */ 
CREATE TABLE inscription(
 idinscription int primary key AUTO_INCREMENT,
 idetudiant INT,
 idcours INT,
 FOREIGN KEY (idetudiant) REFERENCES etudiant(idetudiant),
 FOREIGN KEY (idcours) REFERENCES cours(idcours),
 note INT
);
/* 2024-09-18 17:40:45 [29 ms] */ 
CREATE PROCEDURE ajouter_etudiant(
    IN p_nom VARCHAR(255),
    IN p_prenom VARCHAR(255),
    IN p_date_naissance DATE
)
BEGIN
    INSERT INTO etudiants (nom, prenom, date_naissance)
    VALUES (p_nom, p_prenom, p_date_naissance);
END ;
/* 2024-09-18 18:04:58 [36 ms] */ 
INSERT INTO `etudiant`(`idetudiant`,`nometudiant`,`prenometudiant`,`datenaiss`) VALUES(1,'lolo','nice','18-12-2001');
/* 2024-09-18 18:05:33 [44 ms] */ 
CREATE TABLE etudiants(
 idetudiant int primary key AUTO_INCREMENT,
 nometudiant VARCHAR(100),
 prenometudiant VARCHAR(100),
 datenaiss DATE
);
/* 2024-09-18 18:06:23 [16 ms] */ 
INSERT INTO `etudiants`(`idetudiant`,`nometudiant`,`prenometudiant`,`datenaiss`) VALUES(1,'doli','fim','2000-01-01');
/* 2024-09-19 15:03:24 [6 ms] */ 
USE gestiondescours;
/* 2024-09-19 15:03:26 [84 ms] */ 
CREATE TABLE etudiants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    date_naissance DATE NOT NULL
);
/* 2024-09-19 15:03:29 [45 ms] */ 
CREATE TABLE cours (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    places_disponibles INT NOT NULL
);
/* 2024-09-19 15:03:32 [114 ms] */ 
CREATE TABLE inscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    etudiant_id INT,
    cours_id INT,
    note INT DEFAULT NULL,
    FOREIGN KEY (etudiant_id) REFERENCES etudiants(id),
    FOREIGN KEY (cours_id) REFERENCES cours(id)
);
/* 2024-09-19 15:04:25 [23 ms] */ 
CREATE PROCEDURE ajouter_etudiant(
    IN p_nom VARCHAR(255),
    IN p_prenom VARCHAR(255),
    IN p_date_naissance DATE
)
BEGIN
    INSERT INTO etudiants (nom, prenom, date_naissance)
    VALUES (p_nom, p_prenom, p_date_naissance);
END ;
/* 2024-09-19 15:05:12 [24 ms] */ 
call ajouter_etudiant("nour","helin","2000-01-01");
/* 2024-09-19 15:05:40 [43 ms] */ 
CREATE PROCEDURE inscrire_etudiant(
    IN p_etudiant_id INT,
    IN p_cours_id INT
)
BEGIN
    DECLARE places INT;
    SELECT places_disponibles INTO places FROM cours WHERE id = p_cours_id;
    IF places > 0 THEN
        INSERT INTO inscriptions (etudiant_id, cours_id)
        VALUES (p_etudiant_id, p_cours_id);
        UPDATE cours
        SET places_disponibles = places_disponibles - 1
        WHERE id = p_cours_id;
    ELSE
        SELECT "Pas de places disponibles";
    END IF;
END ;
/* 2024-09-19 15:05:49 [35 ms] */ 
CREATE PROCEDURE supprimer_etudiant(
    IN p_etudiant_id INT
)
BEGIN
    DELETE FROM inscriptions WHERE etudiant_id = p_etudiant_id;
    DELETE FROM etudiants WHERE id = p_etudiant_id;
END ;
/* 2024-09-19 15:05:53 [50 ms] */ 
CREATE PROCEDURE lister_etudiants_par_cours(
    IN p_cours_id INT
)
BEGIN
    SELECT e.id, e.nom, e.prenom, e.date_naissance
    FROM etudiants e
    INNER JOIN inscriptions i ON e.id = i.etudiant_id
    WHERE i.cours_id = p_cours_id;
END ;
/* 2024-09-19 15:05:58 [26 ms] */ 
CREATE PROCEDURE statistiques_cours(
    IN p_cours_id INT
)
BEGIN
    SELECT 
        COUNT(i.etudiant_id) AS nb_etudiants_inscrits,
        AVG(i.note) AS moyenne_notes
    FROM inscriptions i
    WHERE i.cours_id = p_cours_id;
END ;
/* 2024-09-19 15:06:06 [45 ms] */ 
CREATE PROCEDURE maj_etudiant(
    IN p_id INT,
    IN p_nom VARCHAR(255),
    IN p_prenom VARCHAR(255),
    IN p_date_naissance DATE
)
BEGIN
    UPDATE etudiants
    SET nom = p_nom,
        prenom = p_prenom,
        date_naissance = p_date_naissance
    WHERE id = p_id;
END ;
/* 2024-09-19 16:22:36 [34 ms] */ 
call ajouter_etudiant("hanane","benallou","2000-09-01");
/* 2024-09-19 16:25:54 [12 ms] */ 
call inscrire_etudiant(2,111);
/* 2024-09-19 16:30:07 [27 ms] */ 
INSERT INTO `cours`(`nom`,`description`,`places_disponibles`) VALUES('algo','cours magistrale','3');
/* 2024-09-19 16:30:48 [30 ms] */ 
call inscrire_etudiant(1,1);
/* 2024-09-19 16:32:08 [33 ms] */ 
call supprimer_etudiant(1);
/* 2024-09-19 16:40:21 [19 ms] */ 
call ajouter_etudiant("hanane","benallou","2000-09-01");
/* 2024-09-25 11:21:49 [29 ms] */ 
CREATE TABLE departements(
    idd INT PRIMARY KEY,
    nom VARCHAR(255)
);
/* 2024-09-25 11:21:52 [37 ms] */ 
CREATE TABLE projets(
    idp INT PRIMARY KEY,
    nom VARCHAR(255),
    descriptions VARCHAR(255)
);
/* 2024-09-25 11:25:05 [68 ms] */ 
CREATE TABLE employes(
    ide INT PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    date_embauche DATE,
    salaire DECIMAL,
    departement_id INT,
    FOREIGN KEY (departement_id) REFERENCES departements(idd)
);
/* 2024-09-25 11:26:33 [3 ms] */ 
DROP TABLE IF EXISTS emplyes;
/* 2024-09-25 11:26:45 [38 ms] */ 
DROP TABLE IF EXISTS employes;
/* 2024-09-25 11:27:49 [43 ms] */ 
CREATE TABLE employes(
    ide INT PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    date_embauche DATE,
    salaire DECIMAL,
    departement_id INT,
    superieur_id INT,
    FOREIGN KEY (departement_id) REFERENCES departements(idd),
    FOREIGN KEY (superieur_id) REFERENCES employes(ide)
);
/* 2024-09-25 11:33:56 [64 ms] */ 
CREATE TABLE employes_projets(
    employe_id INT,
    projet_id INT,
    rolee VARCHAR(255),
    FOREIGN KEY (employe_id) REFERENCES employes(ide),
    FOREIGN KEY (projet_id) REFERENCES projets(idp)
);
/* 2024-09-25 11:39:10 [31 ms] */ 
CREATE FUNCTION calculer_salaire_moyen(dept_id INT)
RETURNS DECIMAL
BEGIN
    DECLARE salaire_moyen DECIMAL(10,2);

    SELECT AVG(salaire)
    INTO salaire_moyen
    FROM employes
    WHERE departement_id = dept_id;

    RETURN salaire_moyen;
END;
/* 2024-09-25 11:39:16 [39 ms] */ 
CREATE FUNCTION nombre_employes_par_projet(projet_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE nb_employes INT;

    SELECT COUNT(DISTINCT employe_id)
    INTO nb_employes
    FROM employes_projets
    WHERE projet_id = projet_id;

    RETURN nb_employes;
END;
/* 2024-09-25 11:39:18 [26 ms] */ 
CREATE FUNCTION nombre_employes_par_departement(dept_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE nb_employes INT;

    SELECT COUNT(*)
    INTO nb_employes
    FROM employes
    WHERE departement_id = dept_id;

    RETURN nb_employes;
END;
/* 2024-09-25 11:39:21 [23 ms] */ 
CREATE FUNCTION calculer_tache_duree(tache_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE duree INT;

    SELECT DATEDIFF(date_fin, date_debut)
    INTO duree
    FROM taches
    WHERE ID = tache_id;

    RETURN duree;
END;
/* 2024-09-25 11:39:23 [21 ms] */ 
CREATE FUNCTION statut_employe_projet(emp_id INT, projet_id INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE role_employe VARCHAR(255);

    SELECT role
    INTO role_employe
    FROM employes_projets
    WHERE employe_id = emp_id AND projet_id = projet_id;

    RETURN role_employe;
END;
/* 2024-09-25 11:39:27 [25 ms] */ 
CREATE FUNCTION projet_termine(projet_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE toutes_terminees BOOLEAN;

    SELECT CASE
           WHEN COUNT(*) = 0 THEN TRUE
           ELSE FALSE
           END
    INTO toutes_terminees
    FROM taches
    WHERE projet_id = projet_id AND date_fin > CURRENT_DATE;

    RETURN toutes_terminees;
END;
/* 2024-09-25 11:40:14 [99 ms] */ 
CREATE TABLE employes_taches(
    employe_id INT,
    FOREIGN KEY (employe_id) REFERENCES employes(ide)
);
/* 2024-09-25 11:41:56 [34 ms] */ 
DROP TABLE IF EXISTS employes_taches;
/* 2024-09-25 12:09:33 [12 ms] */ 
INSERT INTO departements (idd,nom) VALUES 
(0,'Informatique'),
(1,'Marketing'),
(2,'Ressources Humaines'),
(3,'Finance');
/* 2024-09-25 12:10:54 [16 ms] */ 
INSERT INTO projets (idp,nom, descriptions) VALUES 
(0,'Développement Web', 'Projet de création d’un site web e-commerce'),
(1,'Analyse de marché', 'Projet d’analyse du marché pour un nouveau produit'),
(2,'Formation RH', 'Projet de formation pour les nouveaux employés du département RH'),
(3,'Audit financier', 'Projet d’audit des comptes de l’entreprise pour l’année 2023');
/* 2024-09-25 12:12:28 [25 ms] */ 
CREATE TABLE taches(
    idt INT PRIMARY KEY,
    nom VARCHAR(255),
    date_debut DATE,
    date_fin DATE,
    projet_id INT
);
/* 2024-09-25 12:12:32 [14 ms] */ 
INSERT INTO taches (idt,nom, date_debut, date_fin, projet_id) VALUES 
(0,'Création du frontend', '2024-09-01', '2024-09-15', 1),
(1,'Création du backend', '2024-09-16', '2024-09-30', 1),
(2,'Étude de marché', '2024-08-01', '2024-08-20', 2),
(3,'Formation sur les outils RH', '2024-09-10', '2024-09-20', 3),
(4,'Audit des comptes bancaires', '2024-07-01', '2024-07-31', 4);
/* 2024-09-25 12:15:16 [18 ms] */ 
INSERT INTO employes (ide,nom, prenom, date_embauche, salaire) VALUES 
(0,'Bennani', 'Khalid', '2022-01-10', 30000.00),  -- Khalid est le chef
(1,'El Aoufi', 'Sara', '2022-03-20', 25000.00),
(2,'Taha', 'Amine', '2023-06-15', 22000.00),  -- Amine est le chef du département marketing
(3,'Moujahid', 'Amina', '2023-02-01', 21000.00),
(4,'Bouarfa', 'Fatima', '2021-12-15', 24000.00);
/* 2024-09-25 12:17:43 [30 ms] */ 
INSERT INTO employes_projets (rolee) VALUES 
('Membre de l\'équipe'),
('Responsable'),
('Membre de l\'équipe'),
('Responsable');
/* 2024-09-26 18:11:40 [23 ms] */ 
CREATE PROCEDURE afficher_moyenne_notes()
BEGIN
    -- Variables pour stocker les données récupérées par le curseur
    DECLARE done INT DEFAULT 0;
    DECLARE etudiant_nom VARCHAR(255);
    DECLARE etudiant_prenom VARCHAR(255);
    DECLARE etudiant_id INT;
    DECLARE moyenne FLOAT;

    -- Déclaration du curseur
    DECLARE curseur_etudiants CURSOR FOR 
    SELECT id, nom, prenom FROM etudiants;

    -- Déclaration de la condition de fin du curseur
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Ouvrir le curseur
    OPEN curseur_etudiants;

    etudiant_loop: LOOP
        -- Récupérer les valeurs depuis le curseur
        FETCH curseur_etudiants INTO etudiant_id, etudiant_nom, etudiant_prenom;

        -- Vérifier la condition de fin
        IF done THEN
            LEAVE etudiant_loop;
        END IF;

        -- Calculer la moyenne des notes pour cet étudiant
        SELECT AVG(note) INTO moyenne
        FROM inscriptions
        WHERE etudiant_id = etudiant_id AND note IS NOT NULL;

        -- Si l'étudiant n'a aucune note, définir la moyenne à NULL
        IF moyenne IS NULL THEN
            SET moyenne = 0;
        END IF;

        -- Afficher le nom, le prénom de l'étudiant et sa moyenne
        SELECT CONCAT('Étudiant: ', etudiant_nom, ' ', etudiant_prenom, ' - Moyenne: ', moyenne) AS resultat;

    END LOOP;

    -- Fermer le curseur
    CLOSE curseur_etudiants;

END;
/* 2024-10-01 10:45:09 [14 ms] */ 
DROP DATABASE IF EXISTS travailperso;
/* 2024-10-01 10:45:10 [17 ms] */ 
CREATE DATABASE travailperso;
/* 2024-10-01 10:45:21 [63 ms] */ 
CREATE Table cliente(
    codeC INT,
    nomC VARCHAR(100),
    prenomC VARCHAR(100),
    adresse VARCHAR(100),
    ville VARCHAR(100)
);
/* 2024-10-01 10:49:58 [125 ms] */ 
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
    (10, 'Girard', 'Camille', '10 Rue du Dôme', 'Strasbourg');
/* 2024-10-01 10:52:40 [34 ms] */ 
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
/* 2024-10-01 11:04:38 [15 ms] */ 
DROP DATABASE IF EXISTS travailperso;
/* 2024-10-01 11:04:39 [18 ms] */ 
CREATE DATABASE travailperso;
/* 2024-10-01 11:04:40 [3 ms] */ 
USE travailperso;
/* 2024-10-01 11:04:45 [40 ms] */ 
CREATE TABLE cliente(
    codeC INT,
    nomC VARCHAR(100),
    prenomC VARCHAR(100),
    adresse VARCHAR(100),
    ville VARCHAR(100)
);
/* 2024-10-01 11:04:54 [50 ms] */ 
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
/* 2024-10-01 14:44:36 [13 ms] */ 
CREATE DATABASE IF NOT EXISTS AEROPORT;
/* 2024-10-01 14:44:37 [23 ms] */ 
USE AEROPORT;
/* 2024-10-01 14:44:39 [58 ms] */ 
CREATE TABLE IF NOT EXISTS Pilote (
    Code_pilote INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    salaire DECIMAL(10, 2) NOT NULL
);
/* 2024-10-01 14:45:10 [78 ms] */ 
CREATE TABLE IF NOT EXISTS Compagnie (
    Code_compagnie INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    origine VARCHAR(255) NOT NULL
);
/* 2024-10-01 14:45:12 [66 ms] */ 
CREATE TABLE IF NOT EXISTS Avion (
    Code_avion INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    capacite INT NOT NULL
);
/* 2024-10-01 14:45:16 [192 ms] */ 
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
/* 2024-10-01 14:45:24 [21 ms] */ 
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
/* 2024-10-01 14:45:27 [45 ms] */ 
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
/* 2024-10-01 14:45:30 [15 ms] */ 
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
/* 2024-10-01 14:45:35 [42 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Paris', 'New York', '08:30:00', '2024-10-01', '11:30:00', '2024-10-01', 1, 1, 1),
('Paris', 'Londres', '07:00:00', '2024-10-02', '08:10:00', '2024-10-02', 1, 2, 1);
/* 2024-10-01 14:45:37 [21 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Londres', 'Paris', '09:00:00', '2024-10-02', '10:20:00', '2024-10-02', 2, 2, 3),
('Londres', 'Berlin', '13:00:00', '2024-10-03', '15:30:00', '2024-10-03', 2, 3, 3),
('Berlin', 'Madrid', '12:15:00', '2024-10-03', '14:45:00', '2024-10-03', 2, 4, 2);
/* 2024-10-01 14:45:39 [45 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Berlin', 'Rome', '08:00:00', '2024-10-04', '10:00:00', '2024-10-04', 3, 3, 2),
('Rome', 'New York', '14:00:00', '2024-10-04', '18:30:00', '2024-10-04', 3, 5, 3);
/* 2024-10-01 14:45:41 [42 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Sydney', 'Dubai', '16:45:00', '2024-10-04', '22:30:00', '2024-10-04', 4, 4, 6),
('Dubai', 'Singapore', '10:00:00', '2024-10-05', '14:30:00', '2024-10-05', 4, 6, 6),
('Singapore', 'Tokyo', '16:00:00', '2024-10-06', '22:00:00', '2024-10-06', 4, 8, 6),
('Tokyo', 'Sydney', '08:00:00', '2024-10-07', '18:30:00', '2024-10-07', 4, 9, 6);
/* 2024-10-01 14:45:43 [40 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Doha', 'Tokyo', '10:00:00', '2024-10-05', '18:00:00', '2024-10-05', 5, 5, 10),
('Tokyo', 'Seoul', '12:00:00', '2024-10-06', '14:00:00', '2024-10-06', 5, 7, 10),
('Seoul', 'Beijing', '16:00:00', '2024-10-06', '18:30:00', '2024-10-06', 5, 8, 10),
('Beijing', 'Shanghai', '09:00:00', '2024-10-07', '11:30:00', '2024-10-07', 5, 9, 10),
('Shanghai', 'Guangzhou', '14:00:00', '2024-10-08', '16:30:00', '2024-10-08', 5, 10, 10);
/* 2024-10-01 14:45:46 [50 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Los Angeles', 'Toronto', '14:30:00', '2024-10-06', '17:00:00', '2024-10-06', 6, 6, 4),
('Toronto', 'Montreal', '09:00:00', '2024-10-07', '10:30:00', '2024-10-07', 6, 7, 4),
('Montreal', 'Vancouver', '12:00:00', '2024-10-08', '15:00:00', '2024-10-08', 6, 8, 4),
('Vancouver', 'Calgary', '09:00:00', '2024-10-09', '11:30:00', '2024-10-09', 6, 9, 4),
('Calgary', 'Edmonton', '13:00:00', '2024-10-10', '14:30:00', '2024-10-10', 6, 10, 4),
('Edmonton', 'Los Angeles', '16:00:00', '2024-10-11', '18:30:00', '2024-10-11', 6, 6, 4);
/* 2024-10-01 14:45:53 [48 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Amsterdam', 'Dubai', '06:00:00', '2024-10-07', '14:30:00', '2024-10-07', 7, 7, 9),
('Dubai', 'Mumbai', '18:00:00', '2024-10-07', '21:30:00', '2024-10-07', 7, 10, 9),
('Mumbai', 'Delhi', '08:00:00', '2024-10-08', '09:30:00', '2024-10-08', 7, 9, 9),
('Delhi', 'Bangkok', '11:00:00', '2024-10-08', '14:30:00', '2024-10-08', 7, 8, 9),
('Bangkok', 'Singapore', '16:00:00', '2024-10-09', '18:30:00', '2024-10-09', 7, 7, 9),
('Singapore', 'Kuala Lumpur', '10:00:00', '2024-10-10', '11:30:00', '2024-10-10', 7, 6, 9),
('Kuala Lumpur', 'Jakarta', '13:00:00', '2024-10-11', '14:30:00', '2024-10-11', 7, 5, 9);
/* 2024-10-01 14:45:55 [26 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Madrid', 'Buenos Aires', '18:00:00', '2024-10-08', '04:30:00', '2024-10-09', 8, 8, 7),
('Buenos Aires', 'Santiago', '09:00:00', '2024-10-09', '10:30:00', '2024-10-09', 8, 6, 7),
('Santiago', 'Lima', '12:00:00', '2024-10-10', '14:00:00', '2024-10-10', 8, 9, 7);
/* 2024-10-01 14:45:57 [18 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Paris', 'Rome', '07:00:00', '2024-10-09', '08:45:00', '2024-10-09', 9, 9, 1);
/* 2024-10-01 15:00:37 [85 ms] */ 
CREATE PROCEDURE list_pilots()
BEGIN
    -- Déclarations
    DECLARE done INT DEFAULT FALSE;
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE pilote_salaire DECIMAL(10,2);
    
    -- Déclaration du curseur
    DECLARE pilote_cursor CURSOR FOR
    SELECT Code_pilote, nom, prenom, salaire
    FROM Pilote;
    
    -- Gestion des exceptions, quand le curseur n'a plus de données
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Ouvrir le curseur
    OPEN pilote_cursor;
    
    -- Boucle pour parcourir les résultats
    read_loop: LOOP
        -- Récupérer les données du curseur
        FETCH pilote_cursor INTO pilote_id, pilote_nom, pilote_prenom, pilote_salaire;
        
        -- Vérifier s'il y a encore des données
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Afficher les informations du pilote
        SELECT pilote_id AS 'Code Pilote', 
               CONCAT(pilote_nom, ' ', pilote_prenom) AS 'Nom Complet',
               pilote_salaire AS 'Salaire';
    END LOOP;
    
    -- Fermer le curseur
    CLOSE pilote_cursor;
END ;
/* 2024-10-01 15:02:43 [29 ms] */ 
DROP PROCEDURE list_pilots;
/* 2024-10-01 15:02:45 [39 ms] */ 
CREATE PROCEDURE list_pilots()
BEGIN
    -- Déclarations
    DECLARE done INT DEFAULT FALSE;
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE pilote_salaire DECIMAL(10,2);
    -- Déclaration du curseur
    DECLARE pilote_cursor CURSOR FOR
    SELECT Code_pilote, nom, prenom, salaire
    FROM Pilote;
    -- Gestion des exceptions, quand le curseur n'a plus de données
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -- Ouvrir le curseur
    OPEN pilote_cursor;
    -- Boucle pour parcourir les résultats
    read_loop: LOOP
        -- Récupérer les données du curseur
        FETCH pilote_cursor INTO pilote_id, pilote_nom, pilote_prenom, pilote_salaire;
        -- Vérifier s'il y a encore des données
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Afficher les informations du pilote
        SELECT pilote_id AS 'Code Pilote', 
               CONCAT(pilote_nom, ' ', pilote_prenom) AS 'Nom Complet',
               pilote_salaire AS 'Salaire';
    END LOOP;
    -- Fermer le curseur
    CLOSE pilote_cursor;
END ;
/* 2024-10-01 15:06:34 [26 ms] */ 
DROP PROCEDURE list_pilots;
/* 2024-10-01 15:06:36 [97 ms] */ 
CREATE PROCEDURE list_pilots()
BEGIN
    -- Déclarations
    DECLARE done INT DEFAULT FALSE;
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE pilote_salaire DECIMAL(10,2);
    -- Déclaration du curseur
    DECLARE pilote_cursor CURSOR FOR
    SELECT Code_pilote, nom, prenom, salaire
    FROM Pilote;
    -- Gestion des exceptions, quand le curseur n'a plus de données
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -- Ouvrir le curseur
    OPEN pilote_cursor;
    -- Boucle pour parcourir les résultats
    read_loop: LOOP
        -- Récupérer les données du curseur
        FETCH pilote_cursor INTO pilote_id, pilote_nom, pilote_prenom, pilote_salaire;
        -- Vérifier s'il y a encore des données
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Afficher les informations du pilote
        SELECT pilote_id AS 'Code Pilote', 
               CONCAT(pilote_nom, ' ', pilote_prenom) AS 'Nom Complet',
               pilote_salaire AS 'Salaire';
    END LOOP;
    -- Fermer le curseur
    CLOSE pilote_cursor;
END ;
/* 2024-10-01 15:07:47 [8 ms] */ 
CREATE DATABASE IF NOT EXISTS AEROPORT;
/* 2024-10-01 15:07:48 [13 ms] */ 
USE AEROPORT;
/* 2024-10-01 15:07:49 [17 ms] */ 
CREATE TABLE IF NOT EXISTS Pilote (
    Code_pilote INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    salaire DECIMAL(10, 2) NOT NULL
);
/* 2024-10-01 15:07:51 [64 ms] */ 
CREATE TABLE IF NOT EXISTS Compagnie (
    Code_compagnie INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    origine VARCHAR(255) NOT NULL
);
/* 2024-10-01 15:07:52 [30 ms] */ 
CREATE TABLE IF NOT EXISTS Avion (
    Code_avion INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    capacite INT NOT NULL
);
/* 2024-10-01 15:07:54 [24 ms] */ 
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
/* 2024-10-01 15:07:56 [17 ms] */ 
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
/* 2024-10-01 15:07:58 [26 ms] */ 
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
/* 2024-10-01 15:08:00 [16 ms] */ 
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
/* 2024-10-01 15:08:02 [39 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Paris', 'New York', '08:30:00', '2024-10-01', '11:30:00', '2024-10-01', 1, 1, 1),
('Paris', 'Londres', '07:00:00', '2024-10-02', '08:10:00', '2024-10-02', 1, 2, 1);
/* 2024-10-01 15:08:04 [51 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Londres', 'Paris', '09:00:00', '2024-10-02', '10:20:00', '2024-10-02', 2, 2, 3),
('Londres', 'Berlin', '13:00:00', '2024-10-03', '15:30:00', '2024-10-03', 2, 3, 3),
('Berlin', 'Madrid', '12:15:00', '2024-10-03', '14:45:00', '2024-10-03', 2, 4, 2);
/* 2024-10-01 15:08:05 [30 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Berlin', 'Rome', '08:00:00', '2024-10-04', '10:00:00', '2024-10-04', 3, 3, 2),
('Rome', 'New York', '14:00:00', '2024-10-04', '18:30:00', '2024-10-04', 3, 5, 3);
/* 2024-10-01 15:08:06 [14 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Sydney', 'Dubai', '16:45:00', '2024-10-04', '22:30:00', '2024-10-04', 4, 4, 6),
('Dubai', 'Singapore', '10:00:00', '2024-10-05', '14:30:00', '2024-10-05', 4, 6, 6),
('Singapore', 'Tokyo', '16:00:00', '2024-10-06', '22:00:00', '2024-10-06', 4, 8, 6),
('Tokyo', 'Sydney', '08:00:00', '2024-10-07', '18:30:00', '2024-10-07', 4, 9, 6);
/* 2024-10-01 15:08:09 [41 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Doha', 'Tokyo', '10:00:00', '2024-10-05', '18:00:00', '2024-10-05', 5, 5, 10),
('Tokyo', 'Seoul', '12:00:00', '2024-10-06', '14:00:00', '2024-10-06', 5, 7, 10),
('Seoul', 'Beijing', '16:00:00', '2024-10-06', '18:30:00', '2024-10-06', 5, 8, 10),
('Beijing', 'Shanghai', '09:00:00', '2024-10-07', '11:30:00', '2024-10-07', 5, 9, 10),
('Shanghai', 'Guangzhou', '14:00:00', '2024-10-08', '16:30:00', '2024-10-08', 5, 10, 10);
/* 2024-10-01 15:08:10 [88 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Los Angeles', 'Toronto', '14:30:00', '2024-10-06', '17:00:00', '2024-10-06', 6, 6, 4),
('Toronto', 'Montreal', '09:00:00', '2024-10-07', '10:30:00', '2024-10-07', 6, 7, 4),
('Montreal', 'Vancouver', '12:00:00', '2024-10-08', '15:00:00', '2024-10-08', 6, 8, 4),
('Vancouver', 'Calgary', '09:00:00', '2024-10-09', '11:30:00', '2024-10-09', 6, 9, 4),
('Calgary', 'Edmonton', '13:00:00', '2024-10-10', '14:30:00', '2024-10-10', 6, 10, 4),
('Edmonton', 'Los Angeles', '16:00:00', '2024-10-11', '18:30:00', '2024-10-11', 6, 6, 4);
/* 2024-10-01 15:08:12 [28 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Amsterdam', 'Dubai', '06:00:00', '2024-10-07', '14:30:00', '2024-10-07', 7, 7, 9),
('Dubai', 'Mumbai', '18:00:00', '2024-10-07', '21:30:00', '2024-10-07', 7, 10, 9),
('Mumbai', 'Delhi', '08:00:00', '2024-10-08', '09:30:00', '2024-10-08', 7, 9, 9),
('Delhi', 'Bangkok', '11:00:00', '2024-10-08', '14:30:00', '2024-10-08', 7, 8, 9),
('Bangkok', 'Singapore', '16:00:00', '2024-10-09', '18:30:00', '2024-10-09', 7, 7, 9),
('Singapore', 'Kuala Lumpur', '10:00:00', '2024-10-10', '11:30:00', '2024-10-10', 7, 6, 9),
('Kuala Lumpur', 'Jakarta', '13:00:00', '2024-10-11', '14:30:00', '2024-10-11', 7, 5, 9);
/* 2024-10-01 15:08:14 [34 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Madrid', 'Buenos Aires', '18:00:00', '2024-10-08', '04:30:00', '2024-10-09', 8, 8, 7),
('Buenos Aires', 'Santiago', '09:00:00', '2024-10-09', '10:30:00', '2024-10-09', 8, 6, 7),
('Santiago', 'Lima', '12:00:00', '2024-10-10', '14:00:00', '2024-10-10', 8, 9, 7);
/* 2024-10-01 15:08:16 [34 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Paris', 'Rome', '07:00:00', '2024-10-09', '08:45:00', '2024-10-09', 9, 9, 1);
/* 2024-10-01 15:08:25 [48 ms] */ 
CREATE PROCEDURE list_pilots()
BEGIN
    -- Déclarations
    DECLARE done INT DEFAULT FALSE;
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE pilote_salaire DECIMAL(10,2);
    -- Déclaration du curseur
    DECLARE pilote_cursor CURSOR FOR
    SELECT Code_pilote, nom, prenom, salaire
    FROM Pilote;
    -- Gestion des exceptions, quand le curseur n'a plus de données
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -- Ouvrir le curseur
    OPEN pilote_cursor;
    -- Boucle pour parcourir les résultats
    read_loop: LOOP
        -- Récupérer les données du curseur
        FETCH pilote_cursor INTO pilote_id, pilote_nom, pilote_prenom, pilote_salaire;
        -- Vérifier s'il y a encore des données
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Afficher les informations du pilote
        SELECT pilote_id AS 'Code Pilote', 
               CONCAT(pilote_nom, ' ', pilote_prenom) AS 'Nom Complet',
               pilote_salaire AS 'Salaire';
    END LOOP;
    -- Fermer le curseur
    CLOSE pilote_cursor;
END ;
/* 2024-10-01 15:08:32 [19 ms] */ 
CALL list_pilots();
/* 2024-10-01 15:39:19 [93 ms] */ 
CREATE PROCEDURE list_pilots_and_flights()
BEGIN
    DECLARE done INT DEFAULT FALSE;    -- Variable pour indiquer la fin des curseurs
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE vol_depart VARCHAR(100);
    DECLARE vol_arrivee VARCHAR(100);
    -- Déclaration du curseur pour récupérer les pilotes
    DECLARE pilote_cursor CURSOR FOR
    SELECT Code_pilote, nom, prenom FROM Pilote;
    -- Déclaration du curseur pour récupérer les vols pour chaque pilote
    DECLARE vol_cursor CURSOR FOR
    SELECT Ville_depart, Ville_arrivee FROM Vol WHERE ref_pilote = pilote_id;
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
END ;
/* 2024-10-01 15:39:43 [19 ms] */ 
CALL list_pilots_and_flights();
/* 2024-10-01 15:43:10 [22 ms] */ 
DROP PROCEDURE list_pilots_and_flights;
/* 2024-10-01 15:43:11 [108 ms] */ 
CREATE PROCEDURE list_pilots_and_flights()
BEGIN
    DECLARE done INT DEFAULT FALSE;    -- Variable pour indiquer la fin des curseurs
    DECLARE pilote_id INT;
    DECLARE pilote_nom VARCHAR(100);
    DECLARE pilote_prenom VARCHAR(100);
    DECLARE vol_depart VARCHAR(100);
    DECLARE vol_arrivee VARCHAR(100);
    -- Déclaration du curseur pour récupérer les pilotes
    DECLARE pilote_cursor CURSOR FOR
    SELECT Code_pilote, nom, prenom FROM Pilote;
    -- Déclaration du curseur pour récupérer les vols pour chaque pilote
    DECLARE vol_cursor CURSOR FOR
    SELECT Ville_depart, Ville_arrivee FROM Vol WHERE ref_pilote = pilote_id;
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
        -- Afficher les informations du pilote
        SELECT CONCAT('Le pilote ', pilote_nom, ' ', pilote_prenom, ' est affecté aux vols :');
        -- Réinitialiser la variable done pour l'utilisation du curseur des vols
        

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
END ;
/* 2024-10-01 15:43:22 [9 ms] */ 
CALL list_pilots_and_flights();
/* 2024-10-02 11:28:51 [20 ms] */ 
CREATE DATABASE IF NOT EXISTS AEROPORT;
/* 2024-10-02 11:28:55 [12 ms] */ 
USE AEROPORT;
/* 2024-10-02 11:28:57 [28 ms] */ 
CREATE TABLE IF NOT EXISTS Pilote (
    Code_pilote INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    salaire DECIMAL(10, 2) NOT NULL
);
/* 2024-10-02 11:28:59 [24 ms] */ 
CREATE TABLE IF NOT EXISTS Compagnie (
    Code_compagnie INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    origine VARCHAR(255) NOT NULL
);
/* 2024-10-02 11:29:01 [20 ms] */ 
CREATE TABLE IF NOT EXISTS Avion (
    Code_avion INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    capacite INT NOT NULL
);
/* 2024-10-02 11:29:03 [88 ms] */ 
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
/* 2024-10-02 11:29:07 [34 ms] */ 
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
/* 2024-10-02 11:29:09 [39 ms] */ 
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
/* 2024-10-02 11:29:12 [16 ms] */ 
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
/* 2024-10-02 11:29:15 [48 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Paris', 'New York', '08:30:00', '2024-10-01', '11:30:00', '2024-10-01', 1, 1, 1),
('Paris', 'Londres', '07:00:00', '2024-10-02', '08:10:00', '2024-10-02', 1, 2, 1);
/* 2024-10-02 11:29:17 [67 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Londres', 'Paris', '09:00:00', '2024-10-02', '10:20:00', '2024-10-02', 2, 2, 3),
('Londres', 'Berlin', '13:00:00', '2024-10-03', '15:30:00', '2024-10-03', 2, 3, 3),
('Berlin', 'Madrid', '12:15:00', '2024-10-03', '14:45:00', '2024-10-03', 2, 4, 2);
/* 2024-10-02 11:29:18 [20 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Berlin', 'Rome', '08:00:00', '2024-10-04', '10:00:00', '2024-10-04', 3, 3, 2),
('Rome', 'New York', '14:00:00', '2024-10-04', '18:30:00', '2024-10-04', 3, 5, 3);
/* 2024-10-02 11:29:20 [34 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Sydney', 'Dubai', '16:45:00', '2024-10-04', '22:30:00', '2024-10-04', 4, 4, 6),
('Dubai', 'Singapore', '10:00:00', '2024-10-05', '14:30:00', '2024-10-05', 4, 6, 6),
('Singapore', 'Tokyo', '16:00:00', '2024-10-06', '22:00:00', '2024-10-06', 4, 8, 6),
('Tokyo', 'Sydney', '08:00:00', '2024-10-07', '18:30:00', '2024-10-07', 4, 9, 6);
/* 2024-10-02 11:29:22 [30 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Doha', 'Tokyo', '10:00:00', '2024-10-05', '18:00:00', '2024-10-05', 5, 5, 10),
('Tokyo', 'Seoul', '12:00:00', '2024-10-06', '14:00:00', '2024-10-06', 5, 7, 10),
('Seoul', 'Beijing', '16:00:00', '2024-10-06', '18:30:00', '2024-10-06', 5, 8, 10),
('Beijing', 'Shanghai', '09:00:00', '2024-10-07', '11:30:00', '2024-10-07', 5, 9, 10),
('Shanghai', 'Guangzhou', '14:00:00', '2024-10-08', '16:30:00', '2024-10-08', 5, 10, 10);
/* 2024-10-02 11:29:24 [36 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Los Angeles', 'Toronto', '14:30:00', '2024-10-06', '17:00:00', '2024-10-06', 6, 6, 4),
('Toronto', 'Montreal', '09:00:00', '2024-10-07', '10:30:00', '2024-10-07', 6, 7, 4),
('Montreal', 'Vancouver', '12:00:00', '2024-10-08', '15:00:00', '2024-10-08', 6, 8, 4),
('Vancouver', 'Calgary', '09:00:00', '2024-10-09', '11:30:00', '2024-10-09', 6, 9, 4),
('Calgary', 'Edmonton', '13:00:00', '2024-10-10', '14:30:00', '2024-10-10', 6, 10, 4),
('Edmonton', 'Los Angeles', '16:00:00', '2024-10-11', '18:30:00', '2024-10-11', 6, 6, 4);
/* 2024-10-02 11:29:26 [50 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Amsterdam', 'Dubai', '06:00:00', '2024-10-07', '14:30:00', '2024-10-07', 7, 7, 9),
('Dubai', 'Mumbai', '18:00:00', '2024-10-07', '21:30:00', '2024-10-07', 7, 10, 9),
('Mumbai', 'Delhi', '08:00:00', '2024-10-08', '09:30:00', '2024-10-08', 7, 9, 9),
('Delhi', 'Bangkok', '11:00:00', '2024-10-08', '14:30:00', '2024-10-08', 7, 8, 9),
('Bangkok', 'Singapore', '16:00:00', '2024-10-09', '18:30:00', '2024-10-09', 7, 7, 9),
('Singapore', 'Kuala Lumpur', '10:00:00', '2024-10-10', '11:30:00', '2024-10-10', 7, 6, 9),
('Kuala Lumpur', 'Jakarta', '13:00:00', '2024-10-11', '14:30:00', '2024-10-11', 7, 5, 9);
/* 2024-10-02 11:29:28 [51 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Madrid', 'Buenos Aires', '18:00:00', '2024-10-08', '04:30:00', '2024-10-09', 8, 8, 7),
('Buenos Aires', 'Santiago', '09:00:00', '2024-10-09', '10:30:00', '2024-10-09', 8, 6, 7),
('Santiago', 'Lima', '12:00:00', '2024-10-10', '14:00:00', '2024-10-10', 8, 9, 7);
/* 2024-10-02 11:29:30 [30 ms] */ 
INSERT INTO Vol (Ville_depart, Ville_arrivee, heure_depart, jour_depart, heure_arrivee, jour_arrivee, ref_pilote, ref_avion, ref_compagnie) VALUES
('Paris', 'Rome', '07:00:00', '2024-10-09', '08:45:00', '2024-10-09', 9, 9, 1);
/* 2024-10-02 11:29:33 [49 ms] */ 
DROP PROCEDURE list_pilots;
/* 2024-10-02 11:29:35 [36 ms] */ 
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
END ;
/* 2024-10-02 11:29:43 [46 ms] */ 
CALL list_pilots();
/* 2024-10-02 11:31:44 [31 ms] */ 
DROP PROCEDURE IF EXISTS list_pilots_and_flights;
/* 2024-10-02 11:31:46 [55 ms] */ 
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
END ;
/* 2024-10-02 11:31:51 [26 ms] */ 
CALL list_pilots_and_flights();
/* 2024-10-02 11:59:44 [98 ms] */ 
DROP PROCEDURE IF EXISTS list_pilots_and_flights;
/* 2024-10-02 11:59:46 [138 ms] */ 
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
END ;
/* 2024-10-02 12:00:18 [30 ms] */ 
CALL list_pilots_and_flights();
/* 2024-10-02 12:03:00 [30 ms] */ 
DROP PROCEDURE IF EXISTS list_pilots_and_flights;
/* 2024-10-02 12:03:01 [79 ms] */ 
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
        set done=TRUE;
    END LOOP;
    -- Fermer le curseur des pilotes
    CLOSE pilote_cursor;
END ;
/* 2024-10-02 12:03:05 [26 ms] */ 
CALL list_pilots_and_flights();
/* 2024-10-02 12:04:19 [32 ms] */ 
DROP PROCEDURE IF EXISTS list_pilots_and_flights;
/* 2024-10-02 12:04:20 [89 ms] */ 
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
        SET done=TRUE;
        -- Fermer le curseur des vols après avoir parcouru tous les vols du pilote
        CLOSE vol_cursor;
    END LOOP;
    -- Fermer le curseur des pilotes
    CLOSE pilote_cursor;
END ;
/* 2024-10-02 12:04:25 [17 ms] */ 
CALL list_pilots_and_flights();
/* 2024-10-02 12:06:10 [60 ms] */ 
DROP PROCEDURE IF EXISTS list_pilots_and_flights;
/* 2024-10-02 12:06:11 [82 ms] */ 
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
        SET done=TRUE;
        -- Fermer le curseur des vols après avoir parcouru tous les vols du pilote
        CLOSE vol_cursor;
    END LOOP;
    -- Fermer le curseur des pilotes
    CLOSE pilote_cursor;
END ;
/* 2024-10-02 12:06:16 [5 ms] */ 
CALL list_pilots_and_flights();
/* 2024-10-02 12:06:43 [27 ms] */ 
DROP PROCEDURE IF EXISTS list_pilots_and_flights;
/* 2024-10-02 12:06:44 [103 ms] */ 
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
END ;
/* 2024-10-02 12:06:50 [18 ms] */ 
CALL list_pilots_and_flights();
/* 2024-10-03 17:50:50 [114 ms] */ 
CREATE TABLE Client (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telephone VARCHAR(15)
);
/* 2024-10-03 17:51:00 [122 ms] */ 
CREATE TABLE Article (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prix DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0 -- Nombre d'articles en stock
);
/* 2024-10-03 17:51:06 [83 ms] */ 
CREATE TABLE Commande (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    date_commande DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES Client(id) ON DELETE CASCADE
);
/* 2024-10-03 17:51:11 [80 ms] */ 
CREATE TABLE DetailCommande (
    id INT AUTO_INCREMENT PRIMARY KEY,
    commande_id INT NOT NULL,
    article_id INT NOT NULL,
    quantite INT NOT NULL CHECK (quantite > 0), -- Vérifie que la quantité est positive
    FOREIGN KEY (commande_id) REFERENCES Commande(id) ON DELETE CASCADE,
    FOREIGN KEY (article_id) REFERENCES Article(id) ON DELETE CASCADE
);
/* 2024-10-03 17:51:15 [37 ms] */ 
INSERT INTO Client (nom, email, telephone) VALUES
('Alice Dupont', 'alice.dupont@example.com', '0123456789'),
('Bob Martin', 'bob.martin@example.com', '0987654321');
/* 2024-10-03 17:51:18 [32 ms] */ 
INSERT INTO Article (nom, prix, stock) VALUES
('Article A', 15.00, 10),
('Article B', 25.50, 5),
('Article C', 5.75, 20);
/* 2024-10-03 17:51:43 [16 ms] */ 
INSERT INTO commande(client_id,date_commande) VALUES (1,'2024-12-12');
/* 2024-10-03 17:51:47 [13 ms] */ 
INSERT INTO detailcommande(commande_id,article_id,quantite) VALUES(1,1,5);
/* 2024-10-03 17:51:49 [16 ms] */ 
DELETE FROM detailcommande;
/* 2024-10-03 18:03:36 [57 ms] */ 
CREATE TRIGGER TRG1 BEFORE INSERT ON commande FOR EACH ROW
BEGIN
   IF NEW.date_commande < CURDATE() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La date de commande doit être égale ou supérieure à la date du jour';
   END IF;
END;
/* 2024-10-03 18:04:22 [10 ms] */ 
DELETE FROM detailcommande;
/* 2024-10-03 18:04:24 [54 ms] */ 
INSERT INTO detailcommande(commande_id,article_id,quantite) VALUES(1,1,5);
/* 2024-10-03 18:04:29 [27 ms] */ 
INSERT INTO commande(client_id,date_commande) VALUES (1,'2024-12-12');
/* 2024-10-03 18:04:42 [10 ms] */ 
DELETE FROM detailcommande;
/* 2024-10-08 13:54:16 [20 ms] */ 
drop DATABASE IF EXISTS vvvvvv;
/* 2024-10-08 13:54:17 [12 ms] */ 
CREATE DATABASE vvvvvv;
/* 2024-10-08 13:54:18 [7 ms] */ 
USE vvvvvv;
/* 2024-10-08 13:58:27 [82 ms] */ 
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
/* 2024-10-08 13:58:29 [68 ms] */ 
CREATE TABLE clients (
    Num_Client INT PRIMARY KEY,
    Nom_Client VARCHAR(255),
    Prenom_Client VARCHAR(255),
    sexe CHAR(1),
    Ville_Client VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
/* 2024-10-08 13:58:31 [141 ms] */ 
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
/* 2024-10-08 13:58:36 [197 ms] */ 
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
/* 2024-10-08 14:09:55 [56 ms] */ 
CREATE TABLE emprunts_supprimees (
    Num_Emprunt INT,
    Montant_Emprunt DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Num_Client INT,
    Num_Agence INT
);
/* 2024-10-08 14:09:58 [81 ms] */ 
CREATE TRIGGER emprunts_supprimees_trigger
AFTER DELETE ON emprunts
FOR EACH ROW
BEGIN
    INSERT INTO emprunts_supprimees (Num_Emprunt, Montant_Emprunt, created_at, updated_at, Num_Client, Num_Agence)
    VALUES (OLD.Num_Emprunt, OLD.Montant_Emprunt, OLD.created_at, OLD.updated_at, OLD.Num_Client, OLD.Num_Agence);
END;
/* 2024-10-08 14:10:01 [68 ms] */ 
CREATE TABLE audit_comptes (
    event_type VARCHAR(50),
    event_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Num_Compte INT
);
/* 2024-10-08 14:10:03 [203 ms] */ 
CREATE TRIGGER comptes_inserees_trigger
AFTER INSERT ON comptes
FOR EACH ROW
BEGIN
    INSERT INTO audit_comptes (event_type, Num_Compte)
    VALUES ('INSERT', NEW.Num_Compte);
END;
/* 2024-10-08 14:10:08 [74 ms] */ 
CREATE TRIGGER comptes_supprimees_trigger
AFTER DELETE ON comptes
FOR EACH ROW
BEGIN
    INSERT INTO audit_comptes (event_type, Num_Compte)
    VALUES ('DELETE', OLD.Num_Compte);
END;
/* 2024-10-08 14:10:10 [38 ms] */ 
CREATE TRIGGER comptes_modifiees_trigger
AFTER UPDATE ON comptes
FOR EACH ROW
BEGIN
    INSERT INTO audit_comptes (event_type, Num_Compte)
    VALUES ('UPDATE', NEW.Num_Compte);
END;
/* 2024-10-08 14:10:13 [62 ms] */ 
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
/* 2024-10-08 23:52:42 [65 ms] */ 
CREATE DATABASE gestion_ecole;
/* 2024-10-08 23:52:43 [7 ms] */ 
USE gestion_ecole;
/* 2024-10-08 23:52:44 [51 ms] */ 
CREATE TABLE Etudiant (
    eid INT PRIMARY KEY,
    enom VARCHAR(100),
    age INT,
    niveau VARCHAR(50),
    section VARCHAR(50)
);
/* 2024-10-08 23:52:45 [29 ms] */ 
CREATE TABLE Professeur (
    pid INT PRIMARY KEY,
    pnom VARCHAR(100),
    depid INT
);
/* 2024-10-08 23:52:47 [58 ms] */ 
CREATE TABLE Cours (
    cnom VARCHAR(100) PRIMARY KEY,
    heure_cours TIME,
    salle VARCHAR(50),
    pid INT,
    FOREIGN KEY (pid) REFERENCES Professeur(pid)
);
/* 2024-10-08 23:52:48 [58 ms] */ 
CREATE TABLE Inscription (
    eid INT,
    cnom VARCHAR(100),
    PRIMARY KEY (eid, cnom),
    FOREIGN KEY (eid) REFERENCES Etudiant(eid),
    FOREIGN KEY (cnom) REFERENCES Cours(cnom)
);
/* 2024-10-08 23:52:50 [33 ms] */ 
INSERT INTO Etudiant (eid, enom, age, niveau, section)
VALUES (1, 'Ali', 22, 'L3', 'Mathématiques'),
       (2, 'Amina', 21, 'L3', 'base de données'),
       (3, 'Youssef', 23, 'L3', 'Informatique');
/* 2024-10-08 23:52:52 [21 ms] */ 
INSERT INTO Professeur (pid, pnom, depid)
VALUES (101, 'Dr. Fatiha', 33),
       (102, 'Dr. Hamid', 12),
       (103, 'Dr. Sara', 33);
/* 2024-10-08 23:52:54 [10 ms] */ 
INSERT INTO Cours (cnom, heure_cours, salle, pid)
VALUES ('base de données', '10:00:00', 'Salle 101', 101),
       ('algèbre', '12:00:00', 'Salle 102', 102),
       ('informatique théorique', '14:00:00', 'Salle 103', 103);
/* 2024-10-08 23:52:56 [23 ms] */ 
INSERT INTO Inscription (eid, cnom)
VALUES (1, 'base de données'),
       (2, 'informatique théorique'),
       (3, 'algèbre');
/* 2024-10-08 23:52:57 [49 ms] */ 
CREATE TRIGGER MaxEtudiantsCours
BEFORE INSERT ON Inscription
FOR EACH ROW
BEGIN
  DECLARE effectif INT;
  SELECT COUNT(*) INTO effectif 
  FROM Inscription
  WHERE cnom = NEW.cnom;

  IF effectif >= 30 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ce cours a déjà atteint le nombre maximum d\'étudiants.';
  END IF;
END;
/* 2024-10-08 23:53:45 [64 ms] */ 
CREATE TRIGGER LimiteCoursEnseignantDep33
BEFORE INSERT ON Cours
FOR EACH ROW
BEGIN
  DECLARE nb_cours INT;
  SELECT COUNT(*) INTO nb_cours 
  FROM Cours
  WHERE pid = NEW.pid;

  IF (NEW.pid = 33 AND nb_cours >= 3) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Les enseignants du département 33 ne peuvent pas enseigner plus de trois cours.';
  END IF;
END;
/* 2024-10-08 23:53:48 [41 ms] */ 
CREATE TRIGGER InscriptionInformatiqueTheorique
AFTER INSERT ON Etudiant
FOR EACH ROW
BEGIN
  INSERT INTO Inscription(eid, cnom) 
  VALUES (NEW.eid, 'informatique théorique');
END;
/* 2024-10-08 23:53:51 [59 ms] */ 
CREATE TRIGGER LimiteEnseignantsDepartement
BEFORE INSERT ON Professeur
FOR EACH ROW
BEGIN
  DECLARE nb_enseignants INT;
  SELECT COUNT(*) INTO nb_enseignants 
  FROM Professeur
  WHERE depid = NEW.depid;

  IF nb_enseignants >= 10 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ce département a déjà atteint le nombre maximum d\'enseignants.';
  END IF;
END;
/* 2024-10-08 23:53:53 [49 ms] */ 
CREATE TRIGGER LimiteSectionBaseDeDonnees
BEFORE INSERT ON Etudiant
FOR EACH ROW
BEGIN
  DECLARE nb_bd INT;
  DECLARE nb_math INT;
  
  SELECT COUNT(*) INTO nb_bd FROM Etudiant WHERE section = 'base de données';
  SELECT COUNT(*) INTO nb_math FROM Etudiant WHERE section = 'Mathématiques';

  IF nb_bd <= nb_math THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le nombre d\'étudiants dans la section "base de données" doit être supérieur à celui de la section "Mathématiques".';
  END IF;
END;
/* 2024-10-08 23:53:56 [39 ms] */ 
CREATE TRIGGER LimiteInscriptionDep33
BEFORE INSERT ON Inscription
FOR EACH ROW
BEGIN
  DECLARE nb_inscriptions_dep33 INT;
  DECLARE nb_inscriptions_math INT;
  
  SELECT COUNT(*) INTO nb_inscriptions_dep33 
  FROM Inscription i
  JOIN Cours c ON i.cnom = c.cnom
  JOIN Professeur p ON c.pid = p.pid
  WHERE p.depid = 33;

  SELECT COUNT(*) INTO nb_inscriptions_math 
  FROM Inscription i
  JOIN Etudiant e ON i.eid = e.eid
  WHERE e.section = 'Mathématiques';

  IF nb_inscriptions_dep33 <= nb_inscriptions_math THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le nombre d\'inscriptions aux cours du département 33 doit être supérieur à celui des inscriptions dans la section "Mathématiques".';
  END IF;
END;
/* 2024-10-08 23:54:12 [54 ms] */ 
CREATE TRIGGER SalleUniquePourDepartements
BEFORE INSERT ON Cours
FOR EACH ROW
BEGIN
  DECLARE dep_cours INT;
  SELECT depid INTO dep_cours
  FROM Professeur p
  JOIN Cours c ON p.pid = c.pid
  WHERE c.salle = NEW.salle;

  IF dep_cours IS NOT NULL AND dep_cours != NEW.pid THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Les professeurs de différents départements ne peuvent pas enseigner dans la même salle.';
  END IF;
END;
/* 2024-10-09 11:58:52 [9 ms] */ 
CREATE DATABASE gestion;
/* 2024-10-09 11:58:52 [4 ms] */ 
USE gestion;
/* 2024-10-09 11:58:53 [26 ms] */ 
CREATE TABLE Etudiant (
    eid INT PRIMARY KEY,
    enom VARCHAR(100),
    age INT
);
/* 2024-10-09 12:03:20 [18 ms] */ 
CREATE PROCEDURE lopi()
begin
  loop
    INSERT INTO Etudiant(enom,age)
    VALUES('hind','alami');
  end LOOP;
end;
/* 2024-10-09 12:03:58 [17 ms] */ 
drop TABLE if EXISTS Etudiant;
/* 2024-10-09 12:03:59 [50 ms] */ 
CREATE TABLE Etudiant (
    eid INT,
    enom VARCHAR(100),
    age INT
);
/* 2024-10-09 12:04:55 [25 ms] */ 
drop PROCEDURE IF exists lopi;
/* 2024-10-09 12:04:56 [16 ms] */ 
CREATE PROCEDURE lopi()
begin
  loop
    INSERT INTO Etudiant(enom,age)
    VALUES('hind','alami');
  end LOOP;
end;
/* 2024-10-09 12:06:08 [33 ms] */ 
drop DATABASE IF exists gestion;
/* 2024-10-09 12:06:09 [5 ms] */ 
CREATE DATABASE gestion;
/* 2024-10-09 12:06:10 [10 ms] */ 
USE gestion;
/* 2024-10-09 12:06:11 [3 ms] */ 
drop TABLE if EXISTS Etudiant;
/* 2024-10-09 12:06:12 [30 ms] */ 
CREATE TABLE Etudiant (
    eid INT,
    enom VARCHAR(100),
    age INT
);
/* 2024-10-09 12:06:13 [7 ms] */ 
drop PROCEDURE IF exists lopi;
/* 2024-10-09 12:06:15 [30 ms] */ 
CREATE PROCEDURE lopi()
begin
  loop
    INSERT INTO Etudiant(enom,age)
    VALUES('hind','alami');
  end LOOP;
end;
/* 2024-10-09 12:09:56 [23 ms] */ 
drop DATABASE IF exists gestion;
/* 2024-10-09 12:09:57 [5 ms] */ 
CREATE DATABASE gestion;
/* 2024-10-09 12:09:58 [3 ms] */ 
USE gestion;
/* 2024-10-09 12:09:59 [4 ms] */ 
drop TABLE if EXISTS Etudiant;
/* 2024-10-09 12:10:50 [39 ms] */ 
CREATE TABLE Etudiant (
    eid INT AUTO_INCREMENT PRIMARY KEY,
    enom VARCHAR(100),
    age INT
);
/* 2024-10-09 12:10:53 [4 ms] */ 
drop PROCEDURE IF exists lopi;
/* 2024-10-09 12:10:55 [26 ms] */ 
CREATE PROCEDURE lopi()
begin
  loop
    INSERT INTO Etudiant(enom,age)
    VALUES('hind','alami');
  end LOOP;
end;
/* 2024-10-09 12:27:47 [42 ms] */ 
drop DATABASE IF exists gestion;
/* 2024-10-09 12:27:48 [15 ms] */ 
CREATE DATABASE gestion;
/* 2024-10-09 12:27:49 [4 ms] */ 
USE gestion;
/* 2024-10-09 12:27:49 [8 ms] */ 
drop TABLE if EXISTS Etudiant;
/* 2024-10-09 12:27:50 [55 ms] */ 
CREATE TABLE Etudiant (
    eid INT AUTO_INCREMENT PRIMARY KEY,
    enom VARCHAR(100),
    age INT
);
/* 2024-10-09 12:27:51 [16 ms] */ 
drop PROCEDURE IF exists lopi;
/* 2024-10-09 12:27:52 [47 ms] */ 
CREATE PROCEDURE lopi()
begin
declare exit handler for SQLSTATE 'HY000'
  BEGIN
     ROLLBACK;
  END;
  START TRANSACTION;
  loop
    INSERT INTO Etudiant(enom,age)
    VALUES('hind','alami');
  end LOOP;
end;
/* 2024-10-09 12:27:55 [3 ms] */ 
COMMIT;
/* 2024-10-09 12:29:08 [8 ms] */ 
INSERT INTO `etudiant`(`enom`,`age`) VALUES('jsasdh',22);
/* 2024-10-09 12:29:30 [57 ms] */ 
drop DATABASE IF exists gestion;
/* 2024-10-09 12:29:30 [10 ms] */ 
CREATE DATABASE gestion;
/* 2024-10-09 12:29:31 [5 ms] */ 
USE gestion;
/* 2024-10-09 12:29:32 [4 ms] */ 
drop TABLE if EXISTS Etudiant;
/* 2024-10-09 12:29:34 [35 ms] */ 
CREATE TABLE Etudiant (
    eid INT AUTO_INCREMENT PRIMARY KEY,
    enom VARCHAR(100),
    age INT
);
/* 2024-10-09 12:29:36 [16 ms] */ 
drop PROCEDURE IF exists lopi;
/* 2024-10-09 12:29:37 [36 ms] */ 
CREATE PROCEDURE lopi()
begin
declare exit handler for SQLSTATE 'HY000'
  BEGIN
     ROLLBACK;
  END;
  START TRANSACTION;
  loop
    INSERT INTO Etudiant(enom,age)
    VALUES('hind','alami');
  end LOOP;
end;
/* 2024-10-09 12:29:39 [6 ms] */ 
COMMIT;
/* 2024-10-09 12:32:00 [33 ms] */ 
drop DATABASE IF exists gestion;
/* 2024-10-09 12:32:01 [7 ms] */ 
CREATE DATABASE gestion;
/* 2024-10-09 12:32:01 [3 ms] */ 
USE gestion;
/* 2024-10-09 12:32:02 [3 ms] */ 
drop TABLE if EXISTS Etudiant;
/* 2024-10-09 12:32:03 [26 ms] */ 
CREATE TABLE Etudiant (
    eid INT AUTO_INCREMENT PRIMARY KEY,
    enom VARCHAR(100),
    age INT
);
/* 2024-10-09 12:32:04 [8 ms] */ 
INSERT INTO Etudiant(enom,age)
VALUES ("rihab",23);
/* 2024-10-09 12:32:06 [6 ms] */ 
drop PROCEDURE IF exists lopi;
/* 2024-10-09 12:32:07 [39 ms] */ 
CREATE PROCEDURE lopi()
begin
declare exit handler for SQLSTATE 'HY000'
  BEGIN
     ROLLBACK;
  END;
  START TRANSACTION;
  loop
    INSERT INTO Etudiant(enom,age)
    VALUES('hind','alami');
  end LOOP;
end;
/* 2024-10-09 12:32:10 [2 ms] */ 
COMMIT;
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
/* 2024-10-29 15:47:51 [17 ms] */ 
CREATE DATABASE DKM;
/* 2024-10-29 15:47:52 [11 ms] */ 
USE DKM;
/* 2024-10-29 15:47:53 [35 ms] */ 
CREATE TABLE service (
    codeSer INT PRIMARY KEY,
    nomSer VARCHAR(50)
);
/* 2024-10-29 15:47:54 [69 ms] */ 
CREATE TABLE salarie (
    codeSal INT PRIMARY KEY,
    nomSal VARCHAR(50),
    prenomSal VARCHAR(50),
    dateEmbauche DATE,
    dateNaissance DATE,
    fonction VARCHAR(50),
    codeSer INT,
    FOREIGN KEY (codeSer) REFERENCES service(codeSer)
);
/* 2024-10-29 15:47:56 [48 ms] */ 
CREATE TABLE voiture (
    matricule VARCHAR(20) PRIMARY KEY,
    marque VARCHAR(50),
    couleur VARCHAR(20),
    dateMiseEnCirculation DATE
);
/* 2024-10-29 15:47:57 [104 ms] */ 
CREATE TABLE utilisation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    matricule VARCHAR(20),
    codeSal INT,
    dateDebutUtilisation DATE,
    dateFinUtilisation DATE,
    FOREIGN KEY (matricule) REFERENCES voiture(matricule),
    FOREIGN KEY (codeSal) REFERENCES salarie(codeSal)
);
/* 2024-10-29 15:48:02 [25 ms] */ 
CREATE TABLE garagiste (
    codeGar INT PRIMARY KEY,
    nomGar VARCHAR(50),
    adresse VARCHAR(100)
);
/* 2024-10-29 15:48:05 [101 ms] */ 
CREATE TABLE demandeReparation (
    codeDem INT PRIMARY KEY,
    dateDem DATE,
    codeSal INT,
    descriptionDem TEXT,
    codeGar INT,
    syntheseReparation TEXT,
    dateFinReparation DATE,
    FOREIGN KEY (codeSal) REFERENCES salarie(codeSal),
    FOREIGN KEY (codeGar) REFERENCES garagiste(codeGar)
);
/* 2024-10-29 15:50:03 [19 ms] */ 
INSERT INTO service (codeSer, nomSer) VALUES 
(1, 'Ressources Humaines'),
(2, 'Informatique'),
(3, 'Comptabilité');
/* 2024-10-29 15:50:05 [64 ms] */ 
INSERT INTO salarie (codeSal, nomSal, prenomSal, dateEmbauche, dateNaissance, fonction, codeSer) VALUES 
(1, 'Ali', 'Ahmed', '2020-01-15', '1995-07-20', 'Développeur', 2),
(2, 'Omar', 'Hassan', '2019-03-10', '1988-02-25', 'Comptable', 3),
(3, 'Fatima', 'Zahra', '2021-07-22', '1993-10-18', 'Responsable RH', 1);
/* 2024-10-29 15:50:07 [17 ms] */ 
INSERT INTO voiture (matricule, marque, couleur, dateMiseEnCirculation) VALUES 
('ABC123', 'Toyota', 'Rouge', '2018-06-20'),
('XYZ789', 'Renault', 'Bleu', '2020-03-15'),
('LMN456', 'Peugeot', 'Noir', '2019-11-10');
/* 2024-10-29 15:50:09 [38 ms] */ 
INSERT INTO utilisation (matricule, codeSal, dateDebutUtilisation, dateFinUtilisation) VALUES 
('ABC123', 1, '2022-01-10', '2022-01-15'),
('XYZ789', 2, '2022-02-05', '2022-02-10'),
('LMN456', 3, '2022-03-01', '2022-03-05');
/* 2024-10-29 15:50:12 [17 ms] */ 
INSERT INTO garagiste (codeGar, nomGar, adresse) VALUES 
(1, 'Garage Central', '123 Rue des Mécaniciens, Ville A'),
(2, 'Auto Service', '456 Avenue des Ateliers, Ville B'),
(3, 'Garage Plus', '789 Boulevard des Réparations, Ville C');
/* 2024-10-29 15:50:13 [17 ms] */ 
INSERT INTO demandeReparation (codeDem, dateDem, codeSal, descriptionDem, codeGar, syntheseReparation, dateFinReparation) VALUES 
(1, '2022-01-12', 1, 'Problème de frein', 1, 'Freins remplacés', '2022-01-13'),
(2, '2022-02-06', 2, 'Problème moteur', 2, 'Moteur réparé', '2022-02-08'),
(3, '2022-03-02', 3, 'Révision générale', 3, 'Révision complète effectuée', '2022-03-04');
/* 2024-10-29 16:11:13 [22 ms] */ 
CREATE PROCEDURE NombreSalariesParService()
BEGIN
    SELECT service.nomSer AS Service, COUNT(salarie.codeSal) AS NombreSalaries
    FROM service
    LEFT JOIN salarie ON service.codeSer = salarie.codeSer
    GROUP BY service.nomSer;
END;
/* 2024-10-29 16:14:53 [26 ms] */ 
CREATE PROCEDURE NombreSalariesParServi()
BEGIN
    SELECT service.nomSer AS Service, COUNT(salarie.codeSal) AS NombreSalaries
    FROM service
    LEFT JOIN salarie ON service.codeSer = salarie.codeSer
    GROUP BY service.nomSer;
END;
/* 2024-10-29 16:15:23 [23 ms] */ 
CREATE PROCEDURE NombreSalariesParServ()
BEGIN
    SELECT service.nomSer AS Service, COUNT(salarie.codeSal) AS NombreSalaries
    FROM service
    LEFT JOIN salarie ON service.codeSer = salarie.codeSer
    GROUP BY service.nomSer;
END;
/* 2024-10-29 16:16:02 [24 ms] */ 
CREATE PROCEDURE NombreSalariesParSer()
BEGIN
    SELECT service.nomSer AS Service, COUNT(*) AS NombreSalaries
    FROM service
    LEFT JOIN salarie ON service.codeSer = salarie.codeSer
    GROUP BY service.nomSer;
END;
/* 2024-10-29 16:17:00 [17 ms] */ 
CREATE PROCEDURE NombreSalariesParS(OUT NombreSalaries INT)
BEGIN
    SELECT service.nomSer AS Service, COUNT(*) AS NombreSalaries
    FROM service
    LEFT JOIN salarie ON service.codeSer = salarie.codeSer
    GROUP BY service.nomSer;
END;
/* 2024-10-29 16:17:40 [27 ms] */ 
CREATE PROCEDURE NombreSalariesPar()
BEGIN
    SELECT service.nomSer AS Service, COUNT(*) AS NombreSalaries
    FROM service
    LEFT JOIN salarie ON service.codeSer = salarie.codeSer
    GROUP BY service.nomSer;
END;
/* 2024-10-29 16:17:46 [10 ms] */ 
CALL NombreSalariesPar();
/* 2024-10-29 16:18:57 [26 ms] */ 
CREATE PROCEDURE NombreSalariesPa()
BEGIN
    SELECT service.nomSer AS Service, COUNT(*) AS NombreSalaries
    FROM service
    JOIN salarie ON service.codeSer = salarie.codeSer
    GROUP BY service.nomSer;
END;
/* 2024-10-29 16:19:00 [5 ms] */ 
CALL NombreSalariesPa();
/* 2024-10-29 16:19:27 [18 ms] */ 
CREATE PROCEDURE NombreSalariesP()
BEGIN
    SELECT service.codeSer AS Service, COUNT(*) AS NombreSalaries
    FROM service
    JOIN salarie ON service.codeSer = salarie.codeSer
    GROUP BY service.codeSer;
END;
/* 2024-10-29 16:19:31 [4 ms] */ 
CALL NombreSalariesP();
/* 2024-10-29 16:20:19 [22 ms] */ 
CREATE PROCEDURE NombreSalaries()
BEGIN
    SELECT COUNT(*) AS NombreSalaries
    FROM service
    JOIN salarie ON service.codeSer = salarie.codeSer
    GROUP BY service.nomSer;
END;
/* 2024-10-29 16:20:22 [11 ms] */ 
CALL NombreSalaries();
/* 2024-10-29 16:32:15 [29 ms] */ 
CREATE Function codesalari(mat VARCHAR(255),date_u DATE)
RETURNS INT
BEGIN
DECLARE codee INT;
SELECT U.codeSal INTO codee
FROM utilisation U
where U.matricule=mat AND U.dateDebutUtilisation=date_u;
RETURN codee;
END;
/* 2024-10-29 16:34:00 [7 ms] */ 
select codesalari('ABC123','2022-01-10');
/* 2024-10-29 16:34:22 [10 ms] */ 
select codesalari('XYZ789','2022-01-10');
/* 2024-10-29 16:50:59 [29 ms] */ 
CREATE Trigger tri
BEFORE INSERT ON utilisation
FOR EACH ROW
BEGIN
if (SELECT 1 FROM salarie JOIN services ON salarie.codeSer=services.codeSer 
WHERE services.codeSal=NEW.codeSal AND services.nomSer="informatique") THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="ERROR";
END IF;
END;
/* 2024-11-10 16:26:06 [46 ms] */ 
CREATE DATABASE Ecole;
/* 2024-11-10 16:29:25 [10 ms] */ 
DROP DATABASE Ecole;
/* 2024-11-10 16:29:27 [9 ms] */ 
CREATE DATABASE Ecole;
/* 2024-11-10 16:29:36 [10 ms] */ 
DROP DATABASE Ecole;
/* 2024-11-10 16:29:37 [13 ms] */ 
CREATE DATABASE Ecole;
/* 2024-11-10 16:30:28 [6 ms] */ 
USE Ecole;
/* 2024-11-10 16:30:30 [41 ms] */ 
CREATE TABLE Etudiants(
    id_E INT PRIMARY KEY,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    age_E INT,
    classe VARCHAR(255)
);
/* 2024-11-10 16:30:59 [29 ms] */ 
DROP DATABASE Ecole;
/* 2024-11-10 16:31:00 [7 ms] */ 
CREATE DATABASE Ecole;
/* 2024-11-10 16:31:01 [6 ms] */ 
USE Ecole;
/* 2024-11-10 16:31:59 [34 ms] */ 
CREATE TABLE Etudiants(
    id_E INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    age_E INT,
    classe VARCHAR(255)
);
/* 2024-11-10 16:32:00 [50 ms] */ 
INSERT INTO Etudiants(nom,prenom,age_E,classe)
VALUES ("BENALLOU","Hanane",19,"Full Stack"),
    ("CHABAB","Rekia",21,"WEB"),
    ("KHRISS","Khadija",20,"Front-end");
/* 2024-11-10 16:33:29 [13 ms] */ 
SELECT *
FROM Etudiants LIMIT 100;
/* 2024-11-10 16:34:36 [20 ms] */ 
SELECT nom,prenom
FROM Etudiants
WHERE age_E > 20 LIMIT 100;
/* 2024-11-10 16:35:11 [39 ms] */ 
DROP DATABASE Ecole;
/* 2024-11-10 16:35:12 [3 ms] */ 
CREATE DATABASE Ecole;
/* 2024-11-10 16:35:13 [4 ms] */ 
USE Ecole;
/* 2024-11-10 16:35:14 [32 ms] */ 
CREATE TABLE Etudiants(
    id_E INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    age_E INT,
    classe VARCHAR(255)
);
/* 2024-11-10 16:35:16 [21 ms] */ 
INSERT INTO Etudiants(nom,prenom,age_E,classe)
VALUES ("BENALLOU","Hanane",19,"Full Stack"),
    ("CHABAB","Rekia",21,"WEB"),
    ("KHRISS","Khadija",20,"informatique");
/* 2024-11-10 16:35:17 [4 ms] */ 
SELECT *
FROM Etudiants LIMIT 100;
/* 2024-11-10 16:35:22 [14 ms] */ 
SELECT nom,prenom
FROM Etudiants
WHERE age_E > 20 LIMIT 100;
/* 2024-11-10 16:36:18 [32 ms] */ 
SELECT * 
FROM Etudiants
WHERE classe="informatique" LIMIT 100;
/* 2024-11-10 16:37:34 [21 ms] */ 
UPDATE Etudiants
SET age_E=20
WHERE nom="BENALLOU";
/* 2024-11-10 16:38:42 [16 ms] */ 
DELETE FROM Etudiants
WHERE id_E=1;
/* 2024-11-10 16:38:47 [3 ms] */ 
SELECT * FROM etudiants LIMIT 100;
/* 2024-11-10 16:39:19 [15 ms] */ 
SELECT *
FROM Etudiants LIMIT 100;
/* 2024-11-10 16:42:42 [47 ms] */ 
CREATE TABLE Cours(
    id_cours INT PRIMARY KEY AUTO_INCREMENT,
    nom_cours VARCHAR(255),
    id_professeur INT
);
/* 2024-11-10 16:42:43 [29 ms] */ 
CREATE TABLE Professeurs(
    id_professeur INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    matiere VARCHAR(255)
);
/* 2024-11-10 16:46:42 [23 ms] */ 
INSERT INTO Cours(nom_cours)
VALUES ("Gestion_Donnees"),
    ("Approche_Agile"),
    ("REACT_JS");
/* 2024-11-10 16:46:44 [25 ms] */ 
INSERT INTO Professeurs(nom,matiere)
VALUES ("EL KANDOUSSI","GD"),
    ("NAIM","AA"),
    ("NAIM","REACT");
/* 2024-11-10 16:48:02 [71 ms] */ 
DROP DATABASE Ecole;
/* 2024-11-10 16:48:03 [16 ms] */ 
CREATE DATABASE Ecole;
/* 2024-11-10 16:48:04 [3 ms] */ 
USE Ecole;
/* 2024-11-10 16:48:05 [28 ms] */ 
CREATE TABLE Etudiants(
    id_E INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    age_E INT,
    classe VARCHAR(255)
);
/* 2024-11-10 16:48:06 [62 ms] */ 
CREATE TABLE Cours(
    id_cours INT PRIMARY KEY AUTO_INCREMENT,
    nom_cours VARCHAR(255),
    id_professeur INT
);
/* 2024-11-10 16:48:09 [33 ms] */ 
CREATE TABLE Professeurs(
    id_professeur INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    matiere VARCHAR(255)
);
/* 2024-11-10 16:48:10 [16 ms] */ 
INSERT INTO Etudiants(nom,prenom,age_E,classe)
VALUES ("BENALLOU","Hanane",19,"Full Stack"),
    ("CHABAB","Rekia",21,"WEB"),
    ("KHRISS","Khadija",20,"informatique");
/* 2024-11-10 16:48:13 [12 ms] */ 
INSERT INTO Cours(nom_cours,id_professeur)
VALUES ("Gestion_Donnees",1),
    ("Approche_Agile",2),
    ("REACT_JS",3);
/* 2024-11-10 16:48:15 [15 ms] */ 
INSERT INTO Professeurs(nom,matiere)
VALUES ("EL KANDOUSSI","GD"),
    ("NAIM","AA"),
    ("NAIM","REACT");
/* 2024-11-10 16:48:17 [5 ms] */ 
SELECT *
FROM Etudiants LIMIT 100;
/* 2024-11-10 16:48:21 [16 ms] */ 
SELECT nom,prenom
FROM Etudiants
WHERE age_E > 20 LIMIT 100;
/* 2024-11-10 16:48:25 [17 ms] */ 
SELECT * 
FROM Etudiants
WHERE classe="informatique" LIMIT 100;
/* 2024-11-10 16:48:29 [21 ms] */ 
UPDATE Etudiants
SET age_E=20
WHERE nom="BENALLOU";
/* 2024-11-10 16:48:33 [15 ms] */ 
DELETE FROM Etudiants
WHERE id_E=1;
/* 2024-11-10 16:48:36 [12 ms] */ 
SELECT *
FROM Etudiants LIMIT 100;
/* 2024-11-10 16:56:34 [11 ms] */ 
SELECT C.*,P.nom
FROM Cours C
JOIN Professeurs P ON C.id_professeur=P.id_professeur LIMIT 100;
/* 2024-11-10 16:59:10 [16 ms] */ 
ALTER TABLE Etudiants
ADD COLUMN note FLOAT;
/* 2024-11-10 17:02:14 [13 ms] */ 
UPDATE `etudiants` SET `note`=18 WHERE `id_E`=2;UPDATE `etudiants` SET `note`=12 WHERE `id_E`=3;
/* 2024-11-10 17:03:52 [6 ms] */ 
SELECT avg(note)
FROM Etudiants LIMIT 100;
/* 2024-11-10 17:05:57 [14 ms] */ 
SELECT avg(note) AS moyenne
FROM Etudiants LIMIT 100;
/* 2024-11-10 17:09:20 [52 ms] */ 
SELECT count(*) AS nombre
FROM Etudiants
GROUP BY classe LIMIT 100;
/* 2024-11-10 17:09:33 [97 ms] */ 
SELECT classe,count(*) AS nombre
FROM Etudiants
GROUP BY classe LIMIT 100;
/* 2024-11-10 17:12:16 [51 ms] */ 
CREATE PROCEDURE information(IN id_etudiant INT)
BEGIN
SELECT *
FROM Etudiants
WHERE id_E=id_etudiant;
END;
/* 2024-11-10 17:12:40 [16 ms] */ 
CALL information(2);
/* 2024-11-10 17:17:54 [40 ms] */ 
CREATE PROCEDURE ajouter(IN p_nom VARCHAR(255),IN p_prenom VARCHAR(255),IN p_age INT,IN p_classe VARCHAR(255))
BEGIN
INSERT INTO Etudiant(nom,prenom,age_E,classe)
VALUES (p_nom,p_prenom,p_age,p_classe);
END;
/* 2024-11-10 17:18:26 [26 ms] */ 
CREATE PROCEDURE ajoute(IN p_nom VARCHAR(255),IN p_prenom VARCHAR(255),IN p_age INT,IN p_classe VARCHAR(255))
BEGIN
INSERT INTO Etudiants(nom,prenom,age_E,classe)
VALUES (p_nom,p_prenom,p_age,p_classe);
END;
/* 2024-11-10 17:18:27 [12 ms] */ 
CALL ajoute("BENALLOU","Hanane",19,"Full Stack");
/* 2024-11-10 17:31:00 [184 ms] */ 
CREATE TRIGGER verification_age
BEFORE INSERT ON Etudiants
FOR EACH ROW
BEGIN
IF (SELECT age_E <=18 FROM Etudiants ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="Entrez un age superieur a 18";
END IF;
END;
/* 2024-11-10 17:31:57 [4 ms] */ 
INSERT INTO `etudiants`(`nom`,`prenom`,`age_E`,`classe`) VALUES('LAKHMAISS','Soukaina',18,'Full Stack');
/* 2024-11-10 17:45:36 [59 ms] */ 
CREATE TRIGGER verification_age_E
BEFORE INSERT ON Etudiants
FOR EACH ROW
BEGIN
    IF NEW.age_E <= 18 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Entrez un âge supérieur à 18';
    END IF;
END;
/* 2024-11-10 18:05:44 [14 ms] */ 
USE Ecole;
/* 2024-11-10 18:05:45 [70 ms] */ 
DROP DATABASE Ecole;
/* 2024-11-10 18:05:46 [8 ms] */ 
CREATE DATABASE Ecole;
/* 2024-11-10 18:05:49 [9 ms] */ 
USE Ecole;
/* 2024-11-10 18:05:53 [72 ms] */ 
CREATE TABLE Etudiants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    age INT,
    classe VARCHAR(50)
);
/* 2024-11-10 18:05:55 [50 ms] */ 
INSERT INTO Etudiants (nom, prenom, age, classe) VALUES
('Dupont', 'Pierre', 22, 'Informatique'),
('Durand', 'Marie', 19, 'Informatique'),
('Martin', 'Lucie', 21, 'Mathématiques');
/* 2024-11-10 18:05:57 [12 ms] */ 
SELECT * FROM Etudiants LIMIT 100;
/* 2024-11-10 18:06:02 [13 ms] */ 
SELECT nom, prenom FROM Etudiants WHERE age > 20 LIMIT 100;
/* 2024-11-10 18:06:07 [14 ms] */ 
SELECT * FROM Etudiants WHERE classe = 'Informatique' LIMIT 100;
/* 2024-11-10 18:06:13 [24 ms] */ 
UPDATE Etudiants SET age = 23 WHERE id = 1;
/* 2024-11-10 18:06:16 [30 ms] */ 
DELETE FROM Etudiants WHERE id = 2;
/* 2024-11-10 18:06:20 [16 ms] */ 
SELECT * FROM Etudiants LIMIT 100;
/* 2024-11-10 18:06:25 [59 ms] */ 
CREATE TABLE Cours (
    id_cours INT AUTO_INCREMENT PRIMARY KEY,
    nom_cours VARCHAR(100),
    id_professeur INT
);
/* 2024-11-10 18:06:26 [72 ms] */ 
CREATE TABLE Professeurs (
    id_professeur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    matiere VARCHAR(50)
);
/* 2024-11-10 18:06:28 [29 ms] */ 
INSERT INTO Professeurs (nom, matiere) VALUES
('Lemoine', 'Mathématiques'),
('Roche', 'Informatique');
/* 2024-11-10 18:06:30 [23 ms] */ 
INSERT INTO Cours (nom_cours, id_professeur) VALUES
('Algèbre', 1),
('Programmation', 2);
/* 2024-11-10 18:06:33 [21 ms] */ 
SELECT C.nom_cours, P.nom AS professeur
FROM Cours C
JOIN Professeurs P ON C.id_professeur = P.id_professeur LIMIT 100;
/* 2024-11-10 18:06:39 [39 ms] */ 
ALTER TABLE Etudiants ADD COLUMN note DECIMAL(5,2);
/* 2024-11-10 18:06:40 [5 ms] */ 
SELECT AVG(note) AS moyenne_notes FROM Etudiants LIMIT 100;
/* 2024-11-10 18:06:55 [18 ms] */ 
SELECT classe, COUNT(*) AS nombre_etudiants
FROM Etudiants
GROUP BY classe LIMIT 100;
/* 2024-11-10 18:07:03 [54 ms] */ 
CREATE PROCEDURE GetEtudiantInfo(IN id_etudiant INT)
BEGIN
    SELECT * FROM Etudiants WHERE id = id_etudiant;
END ;
/* 2024-11-10 18:07:09 [25 ms] */ 
CALL GetEtudiantInfo(1);
/* 2024-11-10 18:07:18 [24 ms] */ 
CREATE PROCEDURE AddEtudiant(IN nom VARCHAR(50), IN prenom VARCHAR(50), IN age INT, IN classe VARCHAR(50))
BEGIN
    INSERT INTO Etudiants (nom, prenom, age, classe) VALUES (nom, prenom, age, classe);
END ;
/* 2024-11-10 18:07:22 [22 ms] */ 
CALL AddEtudiant('Leblanc', 'Paul', 24, 'Physique');
/* 2024-11-10 18:07:29 [23 ms] */ 
CREATE TRIGGER CheckAgeBeforeInsert
BEFORE INSERT ON Etudiants
FOR EACH ROW
BEGIN
    IF NEW.age <= 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L\'âge doit être supérieur à 18 ans.';
    END IF;
END ;
/* 2024-11-10 18:07:37 [43 ms] */ 
CREATE TABLE Comptes (
    id_compte INT AUTO_INCREMENT PRIMARY KEY,
    solde DECIMAL(10, 2)
);
/* 2024-11-10 18:07:40 [28 ms] */ 
INSERT INTO Comptes (solde) VALUES (1000), (500);
/* 2024-11-10 18:07:44 [13 ms] */ 
START TRANSACTION;
/* 2024-11-10 18:07:46 [19 ms] */ 
SELECT solde FROM Comptes WHERE id_compte = 1 FOR UPDATE;
/* 2024-11-10 18:08:57 [15 ms] */ 
START TRANSACTION;
/* 2024-11-10 18:08:58 [18 ms] */ 
SELECT solde FROM Comptes WHERE id_compte = 1 FOR UPDATE;
/* 2024-11-10 18:09:06 [13 ms] */ 
SELECT 'Solde insuffisant, la transaction a été annulée.';
/* 2024-11-10 18:09:14 [11 ms] */ 
UPDATE Comptes
    SET solde = solde + 100
    WHERE id_compte = 2;
/* 2024-11-10 18:09:15 [6 ms] */ 
COMMIT;
/* 2024-11-10 18:09:18 [16 ms] */ 
SELECT 'Transaction réussie.';

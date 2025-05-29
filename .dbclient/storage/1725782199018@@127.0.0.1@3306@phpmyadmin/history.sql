/* 2024-09-08 09:00:40 [15 ms] */ 
CREATE DATABASE entreprise;
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

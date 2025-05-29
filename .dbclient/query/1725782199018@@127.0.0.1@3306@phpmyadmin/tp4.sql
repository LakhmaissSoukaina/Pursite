-- Active: 1725782199018@@127.0.0.1@3306@phpmyadmin
CREATE DATABASE depprota;
USE depprota;
CREATE TABLE departements(
    idd INT PRIMARY KEY,
    nom VARCHAR(255)
);
CREATE TABLE projets(
    idp INT PRIMARY KEY,
    nom VARCHAR(255),
    descriptions VARCHAR(255)
);
CREATE TABLE taches(
    idt INT PRIMARY KEY,
    nom VARCHAR(255),
    date_debut DATE,
    date_fin DATE,
    projet_id INT
);
DROP TABLE IF EXISTS employes;
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
CREATE TABLE employes_projets(
    employe_id INT,
    projet_id INT,
    rolee VARCHAR(255),
    FOREIGN KEY (employe_id) REFERENCES employes(ide),
    FOREIGN KEY (projet_id) REFERENCES projets(idp)
);
DROP TABLE IF EXISTS employes_taches;
CREATE TABLE employes_taches (
    employe_id INT,
    tache_id INT,
    FOREIGN KEY (employe_id) REFERENCES employes(ide),
    FOREIGN KEY (tache_id) REFERENCES taches(idt)
);
INSERT INTO departements (idd,nom) VALUES 
(0,'Informatique'),
(1,'Marketing'),
(2,'Ressources Humaines'),
(3,'Finance');
INSERT INTO projets (idp,nom, descriptions) VALUES 
(0,'Développement Web', 'Projet de création d’un site web e-commerce'),
(1,'Analyse de marché', 'Projet d’analyse du marché pour un nouveau produit'),
(2,'Formation RH', 'Projet de formation pour les nouveaux employés du département RH'),
(3,'Audit financier', 'Projet d’audit des comptes de l’entreprise pour l’année 2023');
INSERT INTO taches (idt,nom, date_debut, date_fin, projet_id) VALUES 
(0,'Création du frontend', '2024-09-01', '2024-09-15', 1),
(1,'Création du backend', '2024-09-16', '2024-09-30', 1),
(2,'Étude de marché', '2024-08-01', '2024-08-20', 2),
(3,'Formation sur les outils RH', '2024-09-10', '2024-09-20', 3),
(4,'Audit des comptes bancaires', '2024-07-01', '2024-07-31', 4);
INSERT INTO employes (ide,nom, prenom, date_embauche, salaire) VALUES 
(0,'Bennani', 'Khalid', '2022-01-10', 30000.00),  -- Khalid est le chef
(1,'El Aoufi', 'Sara', '2022-03-20', 25000.00),
(2,'Taha', 'Amine', '2023-06-15', 22000.00),  -- Amine est le chef du département marketing
(3,'Moujahid', 'Amina', '2023-02-01', 21000.00),
(4,'Bouarfa', 'Fatima', '2021-12-15', 24000.00);  -- Fatima est responsable de la finance
INSERT INTO employes_projets (rolee) VALUES 
('Membre de l\'équipe'),
('Responsable'),
('Membre de l\'équipe'),
('Responsable');
CREATE FUNCTION calculer_salaire_moyen(dept_id INT)
RETURNS DECIMAL
BEGIN
    DECLARE salaire_moyen DECIMAL;
    SELECT AVG(salaire)
    INTO salaire_moyen
    FROM employes
    WHERE departement_id = dept_id;
    RETURN salaire_moyen;
END;
CREATE FUNCTION nombre_employes_par_projet(projet_id INT)
RETURNS INT
BEGIN
    DECLARE nb_employes INT;
    SELECT COUNT(DISTINCT employe_id)
    INTO nb_employes
    FROM employes_projets
    WHERE projet_id = projet_id;
    RETURN nb_employes;
END;
CREATE FUNCTION nombre_employes_par_departement(dept_id INT)
RETURNS INT
BEGIN
    DECLARE nb_employes INT;
    SELECT COUNT(*)
    INTO nb_employes
    FROM employes
    WHERE departement_id = dept_id;
    RETURN nb_employes;
END;
CREATE FUNCTION calculer_tache_duree(tache_id INT)
RETURNS INT
BEGIN
    DECLARE duree INT;
    SELECT DATEDIFF(date_fin, date_debut)
    INTO duree
    FROM taches
    WHERE ID = tache_id;

    RETURN duree;
END;
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

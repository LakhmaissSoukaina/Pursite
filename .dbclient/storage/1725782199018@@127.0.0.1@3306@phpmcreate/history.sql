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

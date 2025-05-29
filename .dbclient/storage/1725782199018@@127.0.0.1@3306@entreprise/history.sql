/* 2024-09-08 09:01:49 [51 ms] */ 
CREATE TABLE table1(  
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    create_time DATETIME,
    name VARCHAR(255)
);
/* 2024-09-08 09:02:12 [6 ms] */ 
SELECT * FROM table1 LIMIT 100;
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

-- Active: 1725782199018@@127.0.0.1@3306@entreprise
CREATE DATABASE gestion_ecole;
USE gestion_ecole;
CREATE TABLE Etudiant (
    eid INT PRIMARY KEY,
    enom VARCHAR(100),
    age INT,
    niveau VARCHAR(50),
    section VARCHAR(50)
);
CREATE TABLE Professeur (
    pid INT PRIMARY KEY,
    pnom VARCHAR(100),
    depid INT
);
CREATE TABLE Cours (
    cnom VARCHAR(100) PRIMARY KEY,
    heure_cours TIME,
    salle VARCHAR(50),
    pid INT,
    FOREIGN KEY (pid) REFERENCES Professeur(pid)
);
CREATE TABLE Inscription (
    eid INT,
    cnom VARCHAR(100),
    PRIMARY KEY (eid, cnom),
    FOREIGN KEY (eid) REFERENCES Etudiant(eid),
    FOREIGN KEY (cnom) REFERENCES Cours(cnom)
);
INSERT INTO Etudiant (eid, enom, age, niveau, section)
VALUES (1, 'Ali', 22, 'L3', 'Mathématiques'),
       (2, 'Amina', 21, 'L3', 'base de données'),
       (3, 'Youssef', 23, 'L3', 'Informatique');
INSERT INTO Professeur (pid, pnom, depid)
VALUES (101, 'Dr. Fatiha', 33),
       (102, 'Dr. Hamid', 12),
       (103, 'Dr. Sara', 33);
INSERT INTO Cours (cnom, heure_cours, salle, pid)
VALUES ('base de données', '10:00:00', 'Salle 101', 101),
       ('algèbre', '12:00:00', 'Salle 102', 102),
       ('informatique théorique', '14:00:00', 'Salle 103', 103);
INSERT INTO Inscription (eid, cnom)
VALUES (1, 'base de données'),
       (2, 'informatique théorique'),
       (3, 'algèbre');



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



CREATE TRIGGER InscriptionInformatiqueTheorique
AFTER INSERT ON Etudiant
FOR EACH ROW
BEGIN
  INSERT INTO Inscription(eid, cnom) 
  VALUES (NEW.eid, 'informatique théorique');
END;



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

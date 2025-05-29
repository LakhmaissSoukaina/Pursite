-- Active: 1725782199018@@127.0.0.1@3306@entreprise
drop DATABASE IF exists gestion;
CREATE DATABASE gestion;
USE gestion;
drop TABLE if EXISTS Etudiant;
CREATE TABLE Etudiant (
    eid INT AUTO_INCREMENT PRIMARY KEY,
    enom VARCHAR(100),
    age INT
);
INSERT INTO Etudiant(enom,age)
VALUES ("rihab",23);
drop PROCEDURE IF exists lopi;
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

COMMIT;

call lopi();
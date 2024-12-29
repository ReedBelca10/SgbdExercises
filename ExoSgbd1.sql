--Création de la base de donnéés
CREATE DATABASE IF NOT EXISTS `ETUDIANTS`;
USE `ETUDIANTS`;

--Création de la table sexe
CREATE TABLE IF NOT EXISTS `Sexe`
(
    `Cdsexe` CHAR(5) PRIMARY KEY,
    `Libsexe` CHAR(8) NOT NULL
);

--Création de la table Etudiant
CREATE TABLE IF NOT EXISTS `Etudiant`
(
    `Numetu` CHAR(5),
    `Nometu` VARCHAR(30) NOT NULL,
    `Dtnaiss` DATE NOT NULL,
    `Cdsexe` VARCHAR(10),
    PRIMARY KEY(Numetu),
    FOREIGN KEY(Cdsexe) REFERENCES sexe(Cdsexe) ON DELETE CASCADE
);

--Création de la table Enseignant
CREATE TABLE IF NOT EXISTS `Enseignant`
(
    `Numens` CHAR(5) PRIMARY KEY,
    `Nomens` VARCHAR(40) NOT NULL,
    `Grade` VARCHAR(80),
    `DateEmb` DATE
);

--Création de la table Matière
CREATE TABLE IF NOT EXISTS `Matière`
(
    `Nummat` CHAR(4) PRIMARY KEY,
    `Nommat` VARCHAR(40) NOT NULL,
    `Coeff` SMALLINT(1),
    `Numens` CHAR(5),
    FOREIGN KEY(Numens) REFERENCES Enseignant(Numens) ON DELETE CASCADE
);

--Création de la table Note
CREATE TABLE IF NOT EXISTS `Notes`
(
    `Nummat` CHAR(4),
    `Numetu` CHAR(5),
    `Note` DECIMAL(4,2) NOT NULL,
    PRIMARY KEY (Nummat,Numetu),
    FOREIGN KEY(Nummat) REFERENCES Matière(Nummat) ON DELETE CASCADE,
    FOREIGN KEY(Numetu) REFERENCES Etudiant(Numetu) ON DELETE CASCADE,
    CHECK(Note <= 20 AND Note >= 0)
);

--Insertion des étudiants

INSERT INTO sexe(Cdsexe, Libsexe)
VALUES ('M', 'Masculin');

INSERT INTO sexe(Cdsexe, Libsexe)
VALUES ('F', 'Féminin');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00001', 'ADJEODA Kokou Messanh Caleb', '2003/07/02', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00002', 'ADJAKLI Komlan Kévin', '2005/01/12', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00003', 'AFEDIKOU Akoèno Arnaud', '2005/10/12', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00004', 'AGBENOHEVI Tona K. Divin', '2000/05/20', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00005', 'ALI Abdou Sabour', '2001/07/15', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00006', 'ALIZIOU Essowèdéou', '2004/11/03', 'F');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00007', 'ATANDJI Koffi Jérôme', '1999/02/10', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00008', 'ATTIOGBE Koffi David', '2004/08/13', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00009', 'BELLOW AZALEKO Afi', '2005/09/10', 'F');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00010', 'DZAHINI Afi Raïssa', '2001/06/14', 'F');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00011', 'ETTOH Yao Joseph', '2002/05/09', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00012', 'FIOKLOU Fiomégnon Bryan', '2001/03/11', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00013', 'KPOGNON Kossi Léopold', '1998/04/09', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00014', 'LAPTIO Makléwa Ambroise', '2002/02/10', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00015', 'REDAH Dibé Ariane', '2003/10/05', 'F');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00016', 'SAPARAPA Rayane', '2003/10/03', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00017', 'ZILEVU Adjovi Gloria', '2005/05/03', 'F');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00018', 'ADEDJOUMA Farid', '2000/07/20', 'M');

INSERT INTO Etudiant(Numetu, Nometu, Dtnaiss, Cdsexe)
VALUES ('00019', 'BEDI Ayéfouni Kokou', '2001/03/15', 'M');

--Affichage des données de la table etudiant
select * from Etudiant;

--Affichage des noms des étudiants uniquement 
select Nometu from etudiant;

--Affichage du nom complet de l'étudiant dont le Numetu est 00001
select Nometu from etudiant where Numetu = '00001';

--Affichage de l'age moyen des garçons et des filles au 1er Janv 2010
SELECT AVG(2010-01-01 - Dtnaiss), Libsexe
FROM Etudiant, Sexe
WHERE Etudiant.Cdsexe = Sexe.Cdsexe
GROUP BY Libsexe
ORDER BY Libsexe;

SELECT AVG(DATEDIFF('2010-01-01', Dtnaiss)) / 365 
AS AgeMoyen, Libsexe 
FROM Etudiant 
JOIN Sexe 
ON Etudiant.Cdsexe = Sexe.Cdsexe 
GROUP BY Libsexe 
ORDER BY Libsexe;

--Affichage du nom et grade des enseignants d'histoire
SELECT Nomens, Grade
FROM Enseignant, Matière
WHERE Enseignant.Nummat = Matière.Nummat
AND Nommat = 'Histoire';

--Affichage des noms et numéro des étudiants qui n'ont pas de notes en Archi logicielle
SELECT Nometu, Numetu
FROM Etudiant, Matière, Notes
WHERE Etudiant.Numetu = Notes.Numetu
AND Matière.Nummat = Notes.Nummat
AND Nommat = 'Architecture logicielle'
AND Notes IS NULL;

--Affichage de nom et coeff des matières qui sont enseignées par des maîtres de conférences ou des assistants.
SELECT Nommat, Coeff, Grade
FROM Matière, Enseignant
WHERE Matière.Numens = Enseignant.Numens
AND Grade IN ('Docteur en Génie informatique', 'Maitre de conférence');

--Affichage pour chaque étudiant (nom et numéro), et par ordre alphabétique, la moyenne qu'il a obtenue dans chaque matière
SELECT Nometu AS 'Nom', E.Numetu AS 'Numero', AVG(Note) AS 'Moyenne'
FROM Etudiant E, Matière M, Notes N
WHERE E.Numetu = N.Numetu
AND M.Nummat = N.Nummat
GROUP BY E.Numetu
ORDER BY Nometu;

--Insertion dans les autres tables
INSERT INTO `Enseignant`(`Numens`, `Nomens`, `Grade`, `DateEmb`)
VALUES
('00001', 'SIBABI Razak', 'Docteur en Génie informatique', '2009/09/10'),
('00002', 'SALAMI Ousmane', 'Docteur en Génie informatique', '2018/09/16'),
('00003', 'OBANDJE Isaak', 'Ingénieur en génie logiciel', '2008/09/10'),
('00004', 'AZIATCHI Jérome', 'Ingénieur en Réseaux et systèmes informatiques', '2016/09/15'),
('00005', 'ABOTCHI Yao', 'Ingénieur en Statistique', '2019/09/25'),
('00006', 'OGOU Komlan', 'Ingénieur en statistique', '2022/10/20'),
('00007', 'AYITE Kokou', 'Ingénieur en Génie logiciel', '2016/09/12'),
('00008', 'AYIVI Gédéon', 'Ingénieur en Réseaux et systèmes informatiques', '2010/10/19'),
('00009', 'ADJRAH Nelson', 'Docteur en agronomie', '2007/11/20'),
('00010', 'OUYAYI Ousmane', 'Ingénieur en Génie logiciel', '2017/08/24'),
('00011', 'BOUTCHOU Sadate', 'Docteur en lettre moderne', '2009/10/21'),
('00012', 'TAKOUGNADJI Esso', 'Docteur en mathématiques', '2011/10/16'),
('00013', 'NICOUE Alfrèd', 'Docteur en analyse mathématiques', '2015/09/16'),
('00014', 'ASSIOBO Kodzo', 'Ingénieur en système informatique', '2009/10/21'),
('00015', 'BASSI Adjo', 'Docteur en anglais', '2009/10/21');

INSERT INTO `Matière`(`Nummat`, `Nommat`, `Coeff`, `Numens`)
VALUES
('0001', 'Statistique', '2', '00005'),
('0002', 'Probabilité', '2', '00005'),
('0003', 'Base de données', '3', '00001'),
('0004', 'Système de gestion de base de données', '3', '00002'),
('0005', 'Topologie des fonctions R', '3', '00013'),
('0006', 'Analyse des fonctions dans R', '3', '00013'),
('0007', 'Initiation à la programmation C', '3', '00007'),
('0008', 'Cycle de gestion de projets', '2', '00009'),
('0009', 'UML', '3', '00002'),
('0010', 'Programmation Web', '6', '00010'),
('0011', 'Algorithmique', '3', '00010'),
('0012', 'Merise', '2', '00003'),
('0013', 'Architecture et technologie des ordi', '2', '00003'),
('0014', 'Algèbre linéaire', '6', '00012'),
('0015', 'Français', '2', '00011');

INSERT INTO `Notes`(`Nummat`, `Numetu`, `Note`)
VALUES
('0001', '00001', 19.50),
('0001', '00003', 16.00),
('0002', '00001', 14.25),
('0004', '00005', 17.50),
('0008', '00010', 16.00),
('0011', '00015', 12.00),
('0001', '00005', 13.50),
('0007', '00006', 18.25),
('0012', '00016', 14.50),
('0013', '00009', 10.50),
('0003', '00018', 19.50),
('0002', '00010', 13.00),
('0010', '00016', 16.00),
('0003', '00012', 14.50),
('0015', '00015', 15.50),
('0012', '00017', 11.00),
('0001', '00006', 16.00),
('0006', '00001', 18.50),
('0012', '00001', 20.00),
('0014', '00002', 10.50),
('0006', '00018', 12.50),
('0004', '00001', 13.50),
('0010', '00002', 17.00),
('0005', '00005', 16.00),
('0006', '00006', 15.00),
('0007', '00007', 17.25);
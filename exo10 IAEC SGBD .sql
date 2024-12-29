--Création de la base de données
CREATE DATABASE IF NOT EXISTS `IAEC`;
USE `IAEC`;

--a : Création de l'utilisateur
CREATE USER 'iaec'@'localhost' IDENTIFIED BY '1234';

--b : Accord des privilèges
GRANT ALL
ON IAEC.*
TO 'iaec'@'localhost';

--Se connecter à tant que l'utilisateur iaec

--Création de la table employees 
CREATE TABLE IF NOT EXISTS `employeesIaec`
(
    `id_emp` SMALLINT(5) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nom_emp` VARCHAR(30) NOT NULL,
    `salaire_emp` DECIMAL(8,2) NOT NULL,
    `post_emp` VARCHAR(20)
);

ALTER TABLE `employeesIaec`
MODIFY `post_emp` VARCHAR(50);

--afficher la table

--c : Insertion des données

INSERT INTO `employeesIaec`(`nom_emp`, `salaire_emp`, `post_emp`)
VALUES ('KOFFI Albert', '110000', 'Sécrétaire');
INSERT INTO `employeesIaec`(`nom_emp`, `salaire_emp`, `post_emp`)
VALUES ('KODZO Camus', '180000', 'Assitant de direction');
INSERT INTO `employeesIaec`(`nom_emp`, `salaire_emp`, `post_emp`)
VALUES ('ABALO Jules', '200000', 'Directeur économique');
INSERT INTO `employeesIaec`(`nom_emp`, `salaire_emp`, `post_emp`)
VALUES ('ALI Komlan', '300000', 'Directeur général');
INSERT INTO `employeesIaec`(`nom_emp`, `salaire_emp`, `post_emp`)
VALUES ('KOFFI Hélène', '100000', 'Service client'); 

--d : Faire de la Mise à Jour occurrence colonne
UPDATE `employeesIaec`
SET `nom_emp` = ''
WHERE `id_emp` = '';

--e : Ajout, et suppression de colonne
ALTER TABLE `employeesIaec`
ADD `sexe_emp` CHAR(1);
DROP `sexe_emp` CHAR(1);

--Voir les enrégistrements
SELECT * FROM `employeesIaec`;
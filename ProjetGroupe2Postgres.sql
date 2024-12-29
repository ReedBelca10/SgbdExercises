/*
----------------------------------------------------------------------------------------------------------------
-- PROJET DE GESTION DE LA COMPAGNIE AERIENNE AVEC LE SGBD POSTGRESQL
-- GROUPE 2 
----------------------------------------------------------------------------------------------------------------
-- Création de la base de données ----------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
*/
CREATE DATABASE IF NOT EXISTS `agence_voyage_sgbd`;

/*-------------------------------------------------------------------------------------------------------------
-- Sélection de la base de données
*/
\connect `agence_voyage_sgbd`;

/*-----------------------------------------------------------------------------------------------------
-- Création de l'utilisateur avec accord de tous les privilèges
*/
CREATE USER iaectest WITH PASSWORD 'iaec';

GRANT ALL PRIVILEGES
ON DATABASE agence_voyage_sgbd
TO iaectest;

/*-----------------------------------------------------------------------------------------------------
-- Création des tables
*/
CREATE TABLE IF NOT EXISTS `clients`
(
    `client_id` INT(5),
    `nom_client` VARCHAR(45) NOT NULL,
    `adresse_client` VARCHAR(100) NOT NULL,
    `type_client` VARCHAR(12) NOT NULL,
    `email_client` VARCHAR(25) NOT NULL,
    `telephone_client` CHAR(10),
    CONSTRAINT PK_Client PRIMARY KEY(`client_id`)
);

CREATE TABLE IF NOT EXISTS `hotels`
(
    `hotel_id` INT(5),
    `nom_hotel` VARCHAR(50) NOT NULL,
    `adresse_hotel` VARCHAR(100) NOT NULL,
    `prix_chambre` DECIMAL(7,2) NOT NULL,
    CONSTRAINT PK_Hotel PRIMARY KEY(`hotel_id`),
    CONSTRAINT CHK_PrixChambre CHECK(`prix_chambre` > 0)
);

CREATE TABLE IF NOT EXISTS `compagnies_aeriennes`
(
    `compagnie_id` INT(5),
    `nom_compagnie` VARCHAR(50) NOT NULL,
    `code_iata` CHAR(3) NOT NULL,
    `pays_compagnie` VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Compagnie PRIMARY KEY(`compagnie_id`)
);

CREATE TABLE IF NOT EXISTS `reservations`
(
    `reservation_id` INT(5),
    `client_id` INT(5) NOT NULL,
    `hotel_id` INT(5) NOT NULL,
    `compagnie_id` INT(5) NOT NULL,
    `date_debut` DATE NOT NULL,
    `date_fin` DATE NOT NULL,
    `prix_total` DECIMAL(7,2) NOT NULL,
    `type_sejour` VARCHAR(50) NOT NULL,
    `duree_sejour` VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Reservation PRIMARY KEY(`reservation_id`),
    CONSTRAINT FK_ClientReservation FOREIGN KEY(`client_id`) REFERENCES `clients`(`client_id`),
    CONSTRAINT FK_HotelReservation FOREIGN KEY(`hotel_id`) REFERENCES `hotels`(`hotel_id`),
    CONSTRAINT FK_CompagnieReservation FOREIGN KEY(`compagnie_id`) REFERENCES `compagnies_aeriennes`(`compagnie_id`),
    CONSTRAINT CHK_PrixTotal CHECK(`prix_total` > 0)
);

CREATE TABLE IF NOT EXISTS `conventions`
(
    `convention_id` INT(5),    
    `hotel_id` INT(5) NOT NULL,
    `compagnie_id` INT(5) NOT NULL,
    `date_convention` DATE NOT NULL,
    `numero_convention` INT NOT NULL,
    `duree_convention` VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Convention PRIMARY KEY(`convention_id`),
    CONSTRAINT FK_HotelConvention FOREIGN KEY(`hotel_id`) REFERENCES `hotels`(`hotel_id`),
    CONSTRAINT FK_CompagnieConvention FOREIGN KEY(`compagnie_id`) REFERENCES `compagnies_aeriennes`(`compagnie_id`)
);

CREATE TABLE IF NOT EXISTS `avis`
(
    `avis_id` INT(5),
    `reservation_id` INT(5),
    `client_id` INT(5) NOT NULL,
    `hotel_id` INT(5) NOT NULL,
    `compagnie_id` INT(5) NOT NULL,
    `note_hotel` DECIMAL(4,2) NOT NULL,
    `note_compagnie` DECIMAL(4,2) NOT NULL,
    `commentaires` VARCHAR(70),
    CONSTRAINT PK_Avis PRIMARY KEY(`avis_id`),
    CONSTRAINT FK_ClientAvis FOREIGN KEY(`client_id`) REFERENCES `clients`(`client_id`),
    CONSTRAINT FK_HotelAvis FOREIGN KEY(`hotel_id`) REFERENCES `hotels`(`hotel_id`),
    CONSTRAINT FK_CompagnieAvis FOREIGN KEY(`compagnie_id`) REFERENCES `compagnies_aeriennes`(`compagnie_id`),
    CONSTRAINT FK_ReservationAvis FOREIGN KEY(`reservation_id`) REFERENCES `reservations`(`reservation_id`),
    CONSTRAINT CHK_Notes CHECK(`note_hotel` >= 0 AND `note_hotel` <= 10 AND `note_compagnie` >= 0 AND `note_compagnie` <= 10)
);

CREATE TABLE IF NOT EXISTS `sejours`
(
    `sejour_id` INT(5),
    `nom_sejour` VARCHAR(50) NOT NULL,
    `description` VARCHAR(70),
    `date_depart` DATE NOT NULL,
    `date_retour` DATE NOT NULL,
    `prix` DECIMAL(7,2) NOT NULL,
    CONSTRAINT PK_Sejour PRIMARY KEY(`sejour_id`),
    CONSTRAINT CHK_PrixSejour CHECK(`prix` > 0)
);

CREATE TABLE IF NOT EXISTS `disponibilites`
(
    `disponibilite_id` INT(5),    
    `hotel_id` INT(5) NOT NULL,
    `date_disponible` DATE NOT NULL,
    `nombre_chambre` SMALLINT(10) NOT NULL,
    CONSTRAINT PK_Disponibilite PRIMARY KEY(`disponibilite_id`),
    CONSTRAINT FK_HotelDisponibilite FOREIGN KEY(`hotel_id`) REFERENCES `hotels`(`hotel_id`)
);

/*-----------------------------------------------------------------------------------------------------
-- Insertion des données dans la table
*/
INSERT INTO `clients`(`client_id`, `nom_client`, `adresse_client`, `type_client`, `email_client`, `telephone_client`)
VALUES
(1, 'Alice Dupont', '10 rue des Lilas, Paris', 'Individuel', 'alice@gmail.com', '70851920'),
(2, 'Entreprise Alpha', '123 avenue des Champs, Lyon', 'Groupe', 'alpha@gmail.com', '93123578'),
(3, 'Jean Martin', '56 boulevard Saint-Michel, Toulouse', 'Individuel', 'jean@gmail.com', '98242536'),
(4, 'Entreprise Beta', 'Bld de la Kara, Lomé', 'Groupe', 'beta@gmail.com', '93123578');

INSERT INTO `hotels`(`hotel_id`, `nom_hotel`, `adresse_hotel`, `prix_chambre`)
VALUES
(1, 'Hôtel des Étoiles', '25 rue du Soleil, Nice', 120.50),
(2, 'Hôtel Paradis', '78 avenue de la Plage, Cannes', 200.00),
(3, 'Hôtel Relax', '9 boulevard de la Mer, Marseille', 95.00),
(4, 'Hôtel Enfer', 'Bld 13 Janvier, Lomé', 150.00);

INSERT INTO `compagnies_aeriennes`(`compagnie_id`, `nom_compagnie`, `code_iata`, `pays_compagnie`)
VALUES
(1, 'Air France', 'CDG', 'France'),
(2, 'British Airways', 'BAC', 'Grande bretagne'),
(3, 'Lufthansa', 'CDT', 'Allemagne');

INSERT INTO `reservations`(`reservation_id`, `client_id`, `hotel_id`, `compagnie_id`, `date_debut`, `date_fin`, `prix_total`, `type_sejour`, `duree_sejour`)
VALUES
(1, 2, 2, 2, '2024/12/11', '2025/02/18', 12000.50, 'Culturel', '2 mois'),
(2, 1, 4, 3, '2025/01/03', '2025/03/18', 9000.70, 'Aventure', '2 mois');

INSERT INTO `conventions`(`convention_id`, `hotel_id`, `compagnie_id`, `date_convention`, `numero_convention`, `duree_convention`)
VALUES
(1, 1, 1, '2024/12/10', 365, '10 Jours'),
(2, 3, 3, '2024/01/12', 180, '15 Jours'),
(3, 2, 2, '2025/11/09', 365, '2 Mois');

INSERT INTO `avis`(`avis_id`, `reservation_id`, `client_id`, `hotel_id`, `compagnie_id`, `note_hotel`, `note_compagnie`, `commentaires`)
VALUES
(1, 1, 3, 1, 3, 7, 8, 'Les services sont chouettes !'),
(2, 2, 4, 3, 1, 6, 5, 'Les services sont acceptables !');

INSERT INTO `sejours`(`sejour_id`, `nom_sejour`, `description`, `date_depart`, `date_retour`, `prix`)
VALUES
(1, 'Plage', 'La plage sous le soleil pour se bronzer la peau', '2024/12/15', '2025/02/03', 12000.15),
(2, 'Expédition sauvage', 'Exploration des zoo et forêts', '2024/12/20', '2025/03/18', 1000.15);

INSERT INTO `disponibilites`(`disponibilite_id`, `hotel_id`, `date_disponible`, `nombre_chambre`)
VALUES
(1, 2, '2025/03/15', 6),
(2, 2, '2025/06/16', 10);

/*-----------------------------------------------------------------------------------------------------
-- Mise à jour pour la colonne adresse_client de la table clients
*/
UPDATE `clients`
SET `adresse_client` = 'Lomé, Gbossimé'
WHERE `client_id` = '2';

/*-----------------------------------------------------------------------------------------------------
-- Ajout et suppression de colonne
*/
ALTER TABLE`hotels`
ADD COLUMN `hotel_email` VARCHAR(20);

DROP COLUMN `hotel_email` VARCHAR(20);

/*-----------------------------------------------------------------------------------------------------
-- Modification du type de données d'une colonne
*/
ALTER TABLE `conventions`
ALTER COLUMN `duree_convention` TYPE TIME;

/*-----------------------------------------------------------------------------------------------------
-- Suppression d'une ligne
*/
DELETE FROM `avis`
WHERE `avis_id` = '2';

/*-----------------------------------------------------------------------------------------------------
-- Suppression de toutes les occurrences
*/
TRUNCATE TABLE `disponibilites`;

/*-----------------------------------------------------------------------------------------------------
-- Suppression de la table
*/
DROP TABLE `disponibilites`;

/*-----------------------------------------------------------------------------------------------------
-- Suppression de l'utilisateur
*/
DROP USER compagnie;

/*-----------------------------------------------------------------------------------------------------
-- Arrêt de la base de données
*/
pg_ctl -D /chemin/vers/le/répertoire/des/données stop

/*-----------------------------------------------------------------------------------------------------
-- Redémarrage de la base de données
*/
pg_ctl -D /usr/local/var/postgres start
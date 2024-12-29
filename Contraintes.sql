CREATE DATABASE IF NOT EXISTS `cours_sql`;
USE `cours_sql`;

CREATE TABLE IF NOT EXISTS `t_users`
(
    `id_user` SMALLINT(5) NOT NULL,
    `user_name` VARCHAR(50) NOT NULL,
    `user_email` VARCHAR(70) NOT NULL,
    `user_registration` DATE NOT NULL,
    `user_admin` BOOLEAN
);

ALTER TABLE `t_users`

--Mettre 0 pour le champ admin par défaut
ALTER `user_admin` SET DEFAULT 0; 
--Retirer la contrainte default
ALTER `user_admin` DROP DEFAULT;

--Contrainte de vérification d'une condition
ADD CHECK(`id_user` <= 10000);
ADD CONSTRAINT CH_userTooBig CHECK(id_user <= 10000 AND user_admin > 1); 
--Supprimer
DROP CONSTRAINT CH_userTooBig;

--Contraite d'unicité
ADD CONSTRAINT UC_ForUsers UNIQUE(`user_name`, `user_email`);
--Supprimer
DROP CONSTRAINT UC_ForUsers;

--Créer un index
CREATE INDEX `indx_users` ON `t_users`(`id_user`,`user_name`);
--Supprimer
DROP INDEX `indx_users`;

--Création d'un utilisateur
CREATE USER IF NOT EXISTS 'reed'@'localhost' IDENTIFIED BY '1234';

--Définir le mot de passe pour un utilisateur existant
SET PASSWORD FOR 'reed'@'localhost' = 'reed';

--Modification de mot de passe
ALTER USER 'reed'@'localhost' IDENTIFIED BY 'reed';

--Changer le nom d'utilisateur
RENAME USER 'reed'@'localhost' TO 'belca'@'localhost';

--Supprimer un utilisateur
DROP USER 'belca'@'localhost';

--Accorder toutes les privilèges à reed uniquement sur la base cours_sql et sur toutes les tables
GRANT ALL
ON cours_sql.*
TO 'reed'@'localhost';

--Retirer toutes les privilèges à reed 
REVOKE ALL
ON cours_sql.*
FROM 'reed'@'localhost';

--Voir l'utilisateur courant 
select current_user;
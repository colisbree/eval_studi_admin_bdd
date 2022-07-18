-- Evaluation Studi - Créer et administrer une base de données - 07/2022 --
-- Thème : gestion de plusieurs complexes de cinéma
-- un administrateur gère 1 à plusieurs complexe
-- un utilisateur peut ajouter les séances de son propre complexe
-- un cinéma peut diffuser plusieurs films
-- un cinéma possède plusieurs salles
-- un film peut être projeté dans une ou plusieurs salles
-- plusieurs tarifs possibles
-- paiement sur place et à l'avenir paiement en ligne possible
-- --------------------------------------------------------
-- le spectacteur choisit un tarif et une ou plusieurs séances, mais il ne fait pas partie de la BDD
-- --------------------------------------------------------
-- Administrateur et utilisateur, pas de création de clé étrangère car gestion avec le backoffice 
-- --------------------------------------------------------
-- 
-- 
-- BDD 
CREATE DATABASE IF NOT EXISTS studi_eval_bdd;
USE studi_eval_bdd;
--
-- Tables
--
CREATE TABLE IF NOT EXISTS complexe (
   Id_complexe int (11) AUTO_INCREMENT PRIMARY KEY,
   Nom VARCHAR (60) NOT NULL,
   Adresse VARCHAR (255) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
--
CREATE TABLE IF NOT EXISTS salle (
   Id_salle int (11) AUTO_INCREMENT PRIMARY KEY,
   Nom VARCHAR (60) NOT NULL,
   Nombre_fauteuils int (5) NOT NULL,
   FK_complexe int(11) NOT NULL,
   FOREIGN KEY (FK_complexe) REFERENCES complexe (Id_complexe)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
--
CREATE TABLE IF NOT EXISTS seance (
   Id_seance int (11) AUTO_INCREMENT PRIMARY KEY,
   Titre_film VARCHAR (60) NOT NULL,
   Date_Heure DATETIME NOT NULL,
   FK_salle int(11) NOT NULL,
   FOREIGN KEY (FK_salle) REFERENCES salle (Id_salle)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
--
CREATE TABLE IF NOT EXISTS tarif (
   Id_tarif int (11) AUTO_INCREMENT PRIMARY KEY,
   Prix DECIMAL (3, 2) NOT NULL,
   Description VARCHAR (60) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
--
CREATE TABLE IF NOT EXISTS utilisateur (
   Id_utilisateur int (11) AUTO_INCREMENT PRIMARY KEY,
   Nom VARCHAR (60) NOT NULL,
   Password VARCHAR (60) NOT NULL,
   Type VARCHAR (60) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
--
--
--
-- Ajout de données
-- 
INSERT INTO complexe (Nom, Adresse)
VALUES ('Cinéma Gaumont', 'Grenoble');
INSERT INTO complexe (Nom, Adresse)
VALUES ('Pathé Echirolles', 'Echirolles');
INSERT INTO complexe (Nom, Adresse)
VALUES ('Le Méliès', 'Grenoble');
--
INSERT INTO salle (Nom, Nombre_fauteuils, FK_complexe)
VALUES ('Vercors', 50, 2);
INSERT INTO salle (Nom, Nombre_fauteuils, FK_complexe)
VALUES ('Chartreuse', 150, 2);
INSERT INTO salle (Nom, Nombre_fauteuils, FK_complexe)
VALUES ('Meije', 150, 1);
--
INSERT INTO seance (Titre_film, Date_Heure, FK_salle)
Values ('Starwars 4', '2022-07-18 17:00:00', 3);
INSERT INTO seance (Titre_film, Date_Heure, FK_salle)
Values ('Grand Bleu', '2022-07-18 15:30:00', 1);
INSERT INTO seance (Titre_film, Date_Heure, FK_salle)
Values ('Grand Bleu', '2022-07-18 16:00:00', 2);
INSERT INTO seance (Titre_film, Date_Heure, FK_salle)
Values ('Léon', '2022-07-18 17:00:00', 1);
INSERT INTO seance (Titre_film, Date_Heure, FK_salle)
Values ('Minions', '2022-07-18 19:00:00', 1);
--
INSERT INTO tarif (Prix, Description)
VALUES (9.20, 'Plein tarif');
INSERT INTO tarif (Prix, Description)
VALUES (7.60, 'Etudiant');
INSERT INTO tarif (Prix, Description)
VALUES (5.90, 'moins de 14 ans');
--
-- encryptage avec Bcrypt
INSERT INTO utilisateur (Nom, Password, Type)
VALUES (
      'Jean',
      '$2y$10$44LXC9/Xrq1TNc/0nSZUnuCTfHOUygTi8aCyWJxljNA1Wl0aaUsKe',
      'administrateur'
   );
INSERT INTO utilisateur (Nom, Password, Type)
VALUES (
      'George',
      '$2y$10$l/uo3CHUEMgf7I2pwURc..o2vSCBhfroRYUH77NZecuFCtfeJjGD6',
      'administrateur'
   );
INSERT INTO utilisateur (Nom, Password, Type)
VALUES (
      'Dupont',
      '$2y$10$xFO1/HncTKi/naLdWvYEb.J4.LgMfA.cGSu4AQeME0c.0IV5dvXIS',
      'utilisateur'
   );
INSERT INTO utilisateur (Nom, Password, Type)
VALUES (
      'Michèle',
      '$2y$10$lGbUqa781xdDZlbmNPKBaO7o70Jm.a.8cdNeg64.l3PjKOY2zbur.',
      'utilisateur'
   );
--
--
-- test 
SELECT *
FROM salle s
   INNER JOIN complexe c ON c.Id_complexe = s.FK_complexe;
--
SELECT *
FROM seance s1
   INNER JOIN salle s2 ON s2.Id_salle = s1.FK_salle;
--
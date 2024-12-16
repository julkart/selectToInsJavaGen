-- V1.0.0__H2_create_tables_and_insert_data.sql

-- Table Auteurs
CREATE TABLE Auteurs (
    auteur_id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255)
);

-- Table Éditeurs
CREATE TABLE Editeurs (
    editeur_id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    ville VARCHAR(255)
);

-- Table Livres
CREATE TABLE Livres (
    livre_id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    annee_publication INTEGER,
    editeur_id INTEGER REFERENCES Editeurs(editeur_id)
);

-- Table Exemplaires
CREATE TABLE Exemplaires (
    exemplaire_id SERIAL PRIMARY KEY,
    livre_id INTEGER REFERENCES Livres(livre_id),
    numero_enregistrement VARCHAR(255) UNIQUE,
    etat VARCHAR(50) DEFAULT 'Neuf'
);

-- Table Emprunteurs
CREATE TABLE Emprunteurs (
    emprunteur_id SERIAL PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    adresse VARCHAR(255),
    telephone VARCHAR(20)
);

-- Insérer des auteurs
INSERT INTO Auteurs (nom, prenom) VALUES
('Rowling', 'J.K.'),
('Tolkien', 'J.R.R.'),
('Asimov', 'Isaac');

-- Insérer des éditeurs
INSERT INTO Editeurs (nom, ville) VALUES
('Gallimard', 'Paris'),
('Folio Junior', 'Paris'),
('Pocket', 'Paris');

-- Insérer des livres
INSERT INTO Livres (titre, isbn, annee_publication, editeur_id) VALUES
('Harry Potter à l''école des sorciers', '9782070514096', 1997, 1),
('Le Seigneur des anneaux : La Communauté de l''anneau', '9782266102274', 1954, 2),
('Fondation', '9782266114352', 1951, 3);

-- Insérer des exemplaires
INSERT INTO Exemplaires (livre_id, numero_enregistrement) VALUES
(1, 'EX0001'),
(1, 'EX0002'),
(2, 'EX0003');

-- Insérer des emprunteurs
INSERT INTO Emprunteurs (nom, adresse, telephone) VALUES
('Dupont', '10 rue de la Paix, Paris', '0123456789'),
('Martin', '20 avenue des Champs-Élysées, Paris', '0987654321');

-- Insérer des emprunts
INSERT INTO Emprunts (exemplaire_id, emprunteur_id, date_emprunt, date_retour_prevue) VALUES
(1, 1, '2024-10-26', '2024-11-09'),
(3, 2, '2024-10-20', '2024-11-03');

-- Association livres auteurs
INSERT INTO Livre_Auteur (livre_id, auteur_id) VALUES
(1, 1), --Harry Potter par J.K. Rowling
(2, 2), --Le Seigneur des Anneaux par J.R.R. Tolkien
(3, 3); --Fondation par Isaac Asimov

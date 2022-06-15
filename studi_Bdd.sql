CREATE DATABASE IF NOT EXISTS studi_theaters DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;

CREATE USER 'complex_admin'@'localhost' IDENTIFIED BY '$2y$10$03iiUUPYZPRaO3tTAx.JFu3UtWPJBtlNzJJo0hs0fp38Tqhh/HLau';
GRANT ALL PRIVILEGES ON studi_theaters.* TO 'complex_admin'@'localhost';

CREATE USER 'complex_reader'@'localhost' IDENTIFIED BY '$2y$10$16rrGyUDjyHNrdiV1LnkYO7DEqWpP/Io2gVXsjPJWLBEKldMfbcae';
GRANT SELECT ON studi_theaters.* TO 'complex_reader'@'localhost';

USE studi_theaters;

CREATE TABLE IF NOT EXISTS theaters
(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(50),
    city VARCHAR(50),
    address VARCHAR(100),
    zip VARCHAR(5)
) engine=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS movies
(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(100),
    genre VARCHAR(50),
    minutes_duration INT NOT NULL
) engine=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS shows
(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    date DATE,
    hour TIME,
    id_theater INT NOT NULL,
    id_movie INT NOT NULL,
    FOREIGN KEY (id_theater) REFERENCES theaters(id),
    FOREIGN KEY (id_movie) REFERENCES movies(id)
) engine=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS rooms
(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(50),
    seats INT NOT NULL,
    id_theater INT NOT NULL,
    FOREIGN KEY (id_theater) REFERENCES theaters(id)
) engine=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS shows_rooms
(
    id_show INT,
    id_room INT,
    FOREIGN KEY (id_show) REFERENCES shows(id),
    FOREIGN KEY (id_room) REFERENCES rooms(id),
    PRIMARY KEY (id_show, id_room)
) engine=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS prices
(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    category VARCHAR(20),
    price FLOAT NOT NULL
) engine=INNODB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS shows_prices
(
    id_show INT,
    id_price INT,
    FOREIGN KEY (id_show) REFERENCES shows(id),
    FOREIGN KEY (id_price) REFERENCES prices(id),
    PRIMARY KEY (id_show, id_price)
) engine=INNODB DEFAULT CHARSET=utf8;


INSERT INTO theaters (name, city, address, zip) VALUES
    ('Le Royal', 'Boulogne-Billancourt', '10 avenue Victor Hugo', 92000),
    ('Le Duplex', 'Vincennes', '8 place des Vosges', 94000),
    ('Panama Theater', 'Paris', '56 avenue des Champs-Elysées', 75000),
    ('Excalibur', 'Montrouge', '12 rue de la Maire', 92000),
    ('Le Milenium', 'Massy', '32 place Stalingrad', 91000);


INSERT INTO movies (name, genre, minutes_duration) VALUES
    ('Le Loup de Wall-Street', 'Biopic', 180),
    ('Star Wars - Episode III', 'Science-fiction', 140),
    ('Harry Potter et le Prisonnier d''Azkaban', 'Action', 142),
    ('The Social Network', 'Biopic', 120),
    ('Lion', 'Drame', 118);


INSERT INTO rooms (id_theater, name, seats) VALUES (1, 'Royal Salle 1', 150), (1, 'Royal Salle 2', 110), (1, 'Royal Salle 3', 90);
INSERT INTO rooms (id_theater, name, seats) VALUES (2, 'Duplex Salle 1', 160), (2, 'Duplex Salle 2', 150), (2, 'Duplex Salle 3', 130), (2, 'Duplex Salle IMAX', 160);
INSERT INTO rooms (id_theater, name, seats) VALUES (3, 'Panama Theater Salle 1', 200), (3, 'Panama Theater Salle 2', 120), (3, 'Panama Theater Salle 3', 150), (3, 'Panama Theater Salle 4DX', 90);
INSERT INTO rooms (id_theater, name, seats) VALUES (4, 'Excalibur Salle 1', 180), (4, 'Excalibur Salle 2', 100), (4, 'Excalibur Salle 3', 140);
INSERT INTO rooms (id_theater, name, seats) VALUES (5, 'Milenium Salle 1', 110), (5, 'Milenium Salle 2', 140), (5, 'Milenium Salle 3', 120);


INSERT INTO shows (id_movie, date, hour, id_theater) VALUES
    (1, STR_TO_DATE('1-7-2022', '%d-%m-%Y'), '21:00', 4),
    (1, STR_TO_DATE('30-6-2022', '%d-%m-%Y'), '15:50', 2),
    (2, STR_TO_DATE('25-6-2022', '%d-%m-%Y'), '20:25', 3),
    (2, STR_TO_DATE('29-6-2022', '%d-%m-%Y'), '15:20', 1),
    (3, STR_TO_DATE('21-6-2022', '%d-%m-%Y'), '9:15', 2),
    (3, STR_TO_DATE('25-6-2022', '%d-%m-%Y'), '10:30',  5),
    (4, STR_TO_DATE('25-6-2022', '%d-%m-%Y'), '12:50',  1),
    (5, STR_TO_DATE('23-6-2022', '%d-%m-%Y'), '16:40',  4),
    (5, STR_TO_DATE('23-6-2022', '%d-%m-%Y'), '16:40',  4);


INSERT INTO shows_rooms (id_show, id_room) VALUES 
    (1, 12), 
    (2, 5), 
    (3, 10), 
    (4, 2), 
    (5, 7), 
    (6, 16), 
    (7, 1), 
    (8, 13), 
    (9, 14);


INSERT INTO prices (category, price) VALUES
    ('Plein tarif', 9.20),
    ('Etudiant', 7.60),
    ('Moins de 14 ans', 5.90);

INSERT INTO shows_prices (id_show, id_price) VALUES (1, 1), (1, 2);
INSERT INTO shows_prices (id_show, id_price) VALUES (2, 1), (2, 2);
INSERT INTO shows_prices (id_show, id_price) VALUES (3, 1), (3, 2), (3, 3);
INSERT INTO shows_prices (id_show, id_price) VALUES (4, 1), (4, 2), (4, 3);
INSERT INTO shows_prices (id_show, id_price) VALUES (5, 1), (5, 2), (5, 3);
INSERT INTO shows_prices (id_show, id_price) VALUES (6, 1), (6, 2), (6, 3);
INSERT INTO shows_prices (id_show, id_price) VALUES (7, 1), (7, 2), (7, 3);
INSERT INTO shows_prices (id_show, id_price) VALUES (8, 1), (8, 2), (8, 3);
INSERT INTO shows_prices (id_show, id_price) VALUES (9, 1), (9, 2), (9, 3);
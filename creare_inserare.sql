
CREATE TABLE Pizza
(
  ID_Pizza VARCHAR2(10) NOT NULL,
  Nume VARCHAR2(20) NOT NULL,
  Tip VARCHAR2(20) NOT NULL,
  Pret int not null,
  
  PRIMARY KEY (ID_Pizza)
);


create TABLE Angajat(
ID_Angajat int not null,
Nume VARCHAR2(50) not null,
Salariu int not null,
Data_Angajare date not null,
Numar_numar_telefon VARCHAR2(10),

PRIMARY KEY (ID_Angajat)
);


CREATE TABLE Locatie
(
  ID_Locatie VARCHAR2(10) NOT NULL,
  Oras VARCHAR2(20) NOT NULL,
  Strada VARCHAR2(30),
  Cod_postal VARCHAR2(10) NOT NULL,
  
  PRIMARY KEY (ID_Locatie)
);

CREATE TABLE Pizzerie
(
  ID_PIZZERIE VARCHAR2(20) NOT NULL,
  Nume VARCHAR2(10) NOT NULL,
  numar_telefon VARCHAR2(10),
  Capacitate int not null,
  ID_Locatie VARCHAR2(10) NOT NULL,
  PRIMARY KEY (ID_Pizzerie),
  FOREIGN KEY (ID_Locatie) REFERENCES Locatie(ID_Locatie)
);


CREATE TABLE Bucatar
(
  ID_Bucatar INT NOT NULL,
  Specializare VARCHAR2(20) NOT NULL,
  ID_Pizzerie VARCHAR2(10) NOT NULL,
  ID_Angajat not null,
  PRIMARY KEY (ID_Bucatar),
  FOREIGN KEY (ID_Angajat) REFERENCES Angajat(ID_Angajat),
  FOREIGN KEY (ID_Pizzerie) REFERENCES Pizzerie(ID_Pizzerie)
);

CREATE TABLE Client
(
  ID_Client INT NOT NULL,
  Nume VARCHAR2(20) NOT NULL,
  Email VARCHAR2(30),
  PRIMARY KEY (ID_Client)
);






CREATE TABLE Personal
(
  ID_Personal INT NOT NULL,
  Specializare VARCHAR2(20) NOT NULL,
  ID_ANGAJAT not null,
  ID_PIZZERIE VARCHAR2(10) NOT NULL,
  PRIMARY KEY (ID_Personal),
  FOREIGN KEY (ID_Angajat) REFERENCES Angajat(ID_Angajat),
  FOREIGN KEY (ID_PIZZERIE) REFERENCES Pizzerie(ID_Pizzerie)
);


create TABLE Rezervare(
ID_Rezervare int not null primary key,
Data_Rezervare date,
Ora VARCHAR2(8),
Numar_Persoane int not null,
ID_Client int not null,
ID_Pizzerie VARCHAR2(10) not null,

foreign key(ID_Client) references Client(ID_Client),
foreign key(ID_Pizzerie) references Pizzerie(ID_Pizzerie)
);


create TABLE Recenzie(
ID_Recenzie int not null primary key,
Data_Recenzie date,
Rating int not null,
Comentariu VARCHAR2(50) NOT NULL,
ID_Client int not null,
ID_Pizzerie VARCHAR2(10) not null,

foreign key(ID_Client) references Client(ID_Client),
foreign key(ID_Pizzerie) references Pizzerie(ID_Pizzerie)
);


create TABLE Promotie(
ID_Promotie int not null primary key,
Data_Start date,
Data_Stop date,
Valoare_Reducere int not null,
ID_Pizza VARCHAR2(10) not null,

foreign key(ID_Pizza) references Pizza(ID_Pizza)
);

CREATE SEQUENCE seq_id_ingredient
 START WITH 1
 INCREMENT BY 1
 NOCYCLE;


create TABLE Ingredient(
ID_Ingredient int not null primary key,
Nume VARCHAR2(50) not null,
Cantitate int NOT NULL
);

CREATE TABLE Preparare (
    ID_Pizza VARCHAR2(10) NOT NULL,
    ID_Ingredient INT NOT NULL,
    PRIMARY KEY (ID_Pizza, ID_Ingredient),
    FOREIGN KEY (ID_Pizza) REFERENCES Pizza(ID_Pizza),
    FOREIGN KEY (ID_Ingredient) REFERENCES Ingredient(ID_Ingredient)
);


CREATE TABLE Comanda
(
  ID_Comanda INT NOT NULL,
  Cantitate INT NOT NULL,
  Pret INT NOT NULL,
  Data_Comanda date,
  ID_Pizza VARCHAR2(10) NOT NULL,
  ID_Pizzerie VARCHAR2(10) NOT NULL,
  ID_Client INT NOT NULL,
  PRIMARY KEY (ID_Comanda),
  FOREIGN KEY (ID_Pizza) REFERENCES Pizza(ID_Pizza),
  FOREIGN KEY (ID_Pizzerie) REFERENCES Pizzerie(ID_Pizzerie),
  FOREIGN KEY (ID_Client) REFERENCES Client(ID_Client)
);







insert into Client (ID_Client, nume, email) VALUES (1, 'Ana Popescu', 'ana.popescu@example.com');
insert into Client (ID_Client, nume, email) VALUES(2, 'Mihai Ionescu', 'mihai.ionescu@example.com');
insert into Client (ID_Client, nume, email) VALUES(3, 'Ioana Dumitrescu', 'ioana.dumitrescu@example.com');
insert into Client (ID_Client, nume, email) VALUES(4, 'Andrei Georgescu', 'andrei.georgescu@example.com');
insert into Client (ID_Client, nume, email) VALUES(5, 'Elena Radu', 'elena.radu@example.com');
select * from client;



insert into Locatie (ID_Locatie,  Oras, Strada, Cod_postal) VALUES('RO001',  'Bucharest', 'Nordului', '010101');
insert into Locatie (ID_Locatie,  Oras, Strada, Cod_postal) VALUES('RO002', 'Cluj-Napoca', 'Gheorghe Titeica', '020202');
insert into Locatie (ID_Locatie, Oras, Strada, Cod_postal) VALUES('RO003', 'Timisoara', 'Brailita', '030303');
insert into Locatie (ID_Locatie,  Oras, Strada, Cod_postal) VALUES('RO004', 'Iasi', 'Mugur Mugurel', '040404');
insert into Locatie (ID_Locatie, Oras, Strada, Cod_postal) VALUES('RO005', 'Constanta', 'Poenaru', '050505');
insert into Locatie (ID_Locatie,  Oras, Strada, Cod_postal) VALUES('RO006', 'Brasov', 'Sforii', '060606');
insert into Locatie (ID_Locatie,  Oras, Strada, Cod_postal) VALUES('RO007','Iasi', 'Radului', '101010');
insert into Locatie (ID_Locatie,  Oras, Strada, Cod_postal) VALUES('RO008', 'Bucuresti', 'Floreasca', '202020');
insert into Locatie (ID_Locatie,  Oras, Strada, Cod_postal) VALUES('RO009', 'Bucuresti', 'Arcului', '303030');
insert into Locatie (ID_Locatie,  Oras, Strada, Cod_postal) VALUES('RO010', 'Constanta', 'Plajei', '001122');
select * from locatie;



insert into Pizzerie (ID_Pizzerie, Nume, numar_telefon,Capacitate, ID_Locatie) VALUES ('MAG001', 'Pizzerie1', '1234567890',88, 'RO001');
insert into Pizzerie (ID_Pizzerie, Nume, numar_telefon,Capacitate, ID_Locatie) VALUES('MAG002', 'Pizzerie2', '0987654321',25, 'RO002');
insert into Pizzerie (ID_Pizzerie, Nume, numar_telefon,Capacitate, ID_Locatie) VALUES('MAG003', 'Pizzerie3', '1112223333',40, 'RO003');
insert into Pizzerie (ID_Pizzerie, Nume, numar_telefon,Capacitate, ID_Locatie) VALUES('MAG004', 'Pizzerie4', '4445556666',100, 'RO007');
insert into Pizzerie (ID_Pizzerie, Nume, numar_telefon,Capacitate, ID_Locatie) VALUES('MAG005', 'Pizzerie5', '7778889999',55, 'RO009');
select * from Pizzerie;


insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(1, 'Ion Popescu', 3000, TO_DATE('2023-01-15', 'YYYY-MM-DD'), '0712345678');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(2, 'Maria Ionescu', 3500, TO_DATE('2022-11-20', 'YYYY-MM-DD'), '0723456789');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(3, 'Ana Dumitrescu', 3200, TO_DATE('2023-02-10', 'YYYY-MM-DD'), '0734567890');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(4, 'Andrei Georgescu', 4000, TO_DATE('2023-03-05', 'YYYY-MM-DD'), '0745678901');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(5, 'Elena Radu', 3800, TO_DATE('2022-09-25', 'YYYY-MM-DD'), '0756789012');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(6, 'Mihai Stan', 3400, TO_DATE('2022-12-10', 'YYYY-MM-DD'), '0767890123');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(7, 'Cristina Stoica', 3700, TO_DATE('2023-04-15', 'YYYY-MM-DD'), '0778901234');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(8, 'Alexandra Marin', 3600, TO_DATE('2023-05-20', 'YYYY-MM-DD'), '0789012345');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(9, 'Florin Munteanu', 3900, TO_DATE('2023-07-01', 'YYYY-MM-DD'), '0790123456');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(10, 'Diana Andreescu', 3300, TO_DATE('2023-08-10', 'YYYY-MM-DD'), '0801234567');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(11, 'Gabriel Popa', 3100, TO_DATE('2023-09-15', 'YYYY-MM-DD'), '0812345678');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(12, 'Andreea Dumitrascu', 3400, TO_DATE('2023-10-20', 'YYYY-MM-DD'), '0823456789');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(13, 'Catalin Stanciu', 3200, TO_DATE('2023-11-10', 'YYYY-MM-DD'), '0834567890');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(14, 'Larisa Radulescu', 3800, TO_DATE('2023-12-05', 'YYYY-MM-DD'), '0845678901');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(15, 'Marius Iorgulescu', 3700, TO_DATE('2024-01-15', 'YYYY-MM-DD'), '0856789012');
insert into Angajat (ID_Angajat, nume, salariu, data_angajare, numar_telefon) VALUES(16, 'Dan Beleaua', 4300, TO_DATE('2024-01-19', 'YYYY-MM-DD'), '0732456852');

select * from angajat;

insert into Personal (ID_Personal, Specializare, ID_Angajat, ID_Pizzerie) VALUES(1, 'Ospatar', 1, 'MAG001');
insert into Personal (ID_Personal, Specializare, ID_Angajat, ID_Pizzerie) VALUES(2, 'Ospatar', 2, 'MAG002');
insert into Personal (ID_Personal, Specializare, ID_Angajat, ID_Pizzerie) VALUES(3, 'Ospatar', 3, 'MAG003');
insert into Personal (ID_Personal, Specializare, ID_Angajat, ID_Pizzerie) VALUES(4, 'Manager', 4, 'MAG004');
insert into Personal (ID_Personal, Specializare, ID_Angajat, ID_Pizzerie) VALUES(5, 'Manager', 5, 'MAG005');
select * from Personal;






insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(6, 'Diavola', 'MAG001', 6);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(7, 'Quattro Formaggi', 'MAG002', 7);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(8, 'Quattro Formaggi', 'MAG003', 8);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(9, 'Prosciutto Funghi', 'MAG004', 9);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(10, 'Prosciutto Funghi', 'MAG005', 10);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(11, 'Diavola', 'MAG001', 11);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(12, 'Prosciutto Funghi', 'MAG002', 12);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(13, 'Prosciutto Funghi', 'MAG003', 13);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(14, 'Diavola', 'MAG004', 14);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(15, 'Quattro Formaggi', 'MAG005', 15);
insert into Bucatar (ID_Bucatar, Specializare, ID_Pizzerie, ID_Angajat) VALUES(16, 'Diavola', 'MAG001', 16);
select * from Bucatar;



insert into Pizza (ID_Pizza, Nume, Tip, Pret) VALUES ('PIZ001', 'Margherita', 'Vegetarian', 30);
insert into Pizza (ID_Pizza, Nume, Tip, Pret) VALUES ('PIZ002', 'Diavola', 'Picant', 40);
insert into Pizza (ID_Pizza, Nume, Tip, Pret) VALUES ('PIZ003', 'Quattro Formaggi', 'Nepicant', 45);
insert into Pizza (ID_Pizza, Nume, Tip, Pret) VALUES ('PIZ004', 'Veggie Delight', 'Vegetarian', 35);
insert into Pizza (ID_Pizza, Nume, Tip, Pret) VALUES ('PIZ005', 'Prosciutto Funghi', 'Nepicant', 50);
SELECT * FROM Pizza;


insert into Ingredient (ID_Ingredient, Nume, Cantitate) VALUES (seq_id_ingredient.NEXTVAL, 'Sos de rosii', 100);
insert into Ingredient (ID_Ingredient, Nume, Cantitate) VALUES (seq_id_ingredient.NEXTVAL, 'Mozzarela', 200);
insert into Ingredient (ID_Ingredient, Nume, Cantitate) VALUES (seq_id_ingredient.NEXTVAL, 'Pepperoni', 150);
insert into Ingredient (ID_Ingredient, Nume, Cantitate) VALUES (seq_id_ingredient.NEXTVAL, 'Ananas', 120);
insert into Ingredient (ID_Ingredient, Nume, Cantitate) VALUES (seq_id_ingredient.NEXTVAL, 'Pui', 170);
insert into Ingredient (ID_Ingredient, Nume, Cantitate) VALUES (seq_id_ingredient.NEXTVAL, 'Sunca', 130);
SELECT * FROM Ingredient;


insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ001', 41);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ001', 42);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ002', 41);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ002', 42);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ002', 43);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ003', 41);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ003', 42);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ003', 44);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ004', 41);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ004', 42);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ004', 46);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ005', 41);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ005', 42);
insert into Preparare (ID_Pizza, ID_Ingredient) VALUES ('PIZ005', 45);
SELECT * FROM Preparare;


insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (1, 2, 60, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'PIZ001', 'MAG001', 1);
insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (2, 1, 40, TO_DATE('2024-05-02', 'YYYY-MM-DD'), 'PIZ002', 'MAG002', 2);
insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (3, 3, 135, TO_DATE('2024-05-03', 'YYYY-MM-DD'), 'PIZ003', 'MAG003', 3);
insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (4, 2, 70, TO_DATE('2024-05-04', 'YYYY-MM-DD'), 'PIZ004', 'MAG004', 4);
insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (5, 1, 50, TO_DATE('2024-05-05', 'YYYY-MM-DD'), 'PIZ005', 'MAG005', 5);
insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (6, 2, 60, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'PIZ001', 'MAG001', 5);
insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (7, 3, 83, TO_DATE('2024-05-02', 'YYYY-MM-DD'), 'PIZ002', 'MAG002', 4);
insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (8, 1, 36, TO_DATE('2024-05-03', 'YYYY-MM-DD'), 'PIZ003', 'MAG003', 4);
insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (9, 4, 112, TO_DATE('2024-05-04', 'YYYY-MM-DD'), 'PIZ004', 'MAG004', 3);
insert into Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Pizza, ID_Pizzerie, ID_Client) VALUES (10, 1, 45, TO_DATE('2024-05-05', 'YYYY-MM-DD'), 'PIZ005', 'MAG005', 5);
SELECT * FROM Comanda;


insert into Rezervare (ID_Rezervare, Data_Rezervare, Ora,Numar_Persoane, ID_Client, ID_Pizzerie) VALUES (1, TO_DATE('2024-06-01', 'YYYY-MM-DD'), 18,4, 1, 'MAG001');
insert into Rezervare (ID_Rezervare, Data_Rezervare, Ora,Numar_Persoane, ID_Client, ID_Pizzerie) VALUES (2, TO_DATE('2024-06-02', 'YYYY-MM-DD'), 19,2, 2, 'MAG002');
insert into Rezervare (ID_Rezervare, Data_Rezervare, Ora,Numar_Persoane, ID_Client, ID_Pizzerie) VALUES (3, TO_DATE('2024-06-03', 'YYYY-MM-DD'), 20,6, 3, 'MAG003');
insert into Rezervare (ID_Rezervare, Data_Rezervare, Ora,Numar_Persoane, ID_Client, ID_Pizzerie) VALUES (4, TO_DATE('2024-06-04', 'YYYY-MM-DD'), 21,1, 4, 'MAG004');
insert into Rezervare (ID_Rezervare, Data_Rezervare, Ora,Numar_Persoane, ID_Client, ID_Pizzerie) VALUES (5, TO_DATE('2024-06-05', 'YYYY-MM-DD'), 22,2, 5, 'MAG005');
SELECT * FROM Rezervare;



insert into Promotie (ID_Promotie, Data_Start, Data_Stop, Valoare_Reducere, ID_Pizza) VALUES (1, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-15', 'YYYY-MM-DD'), 20, 'PIZ001');
insert into Promotie (ID_Promotie, Data_Start, Data_Stop, Valoare_Reducere, ID_Pizza) VALUES (2, TO_DATE('2024-06-16', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 25, 'PIZ002');
insert into Promotie (ID_Promotie, Data_Start, Data_Stop, Valoare_Reducere, ID_Pizza) VALUES (3, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-15', 'YYYY-MM-DD'), 15, 'PIZ003');
insert into Promotie (ID_Promotie, Data_Start, Data_Stop, Valoare_Reducere, ID_Pizza) VALUES (4, TO_DATE('2024-07-16', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'), 30, 'PIZ004');
insert into Promotie (ID_Promotie, Data_Start, Data_Stop, Valoare_Reducere, ID_Pizza) VALUES (5, TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-15', 'YYYY-MM-DD'), 20, 'PIZ005');
SELECT * FROM Promotie;



INSERT INTO Recenzie (ID_Recenzie, Data_Recenzie, Rating, Comentariu, ID_Client, ID_Pizzerie) VALUES (1, TO_DATE('2024-05-10', 'YYYY-MM-DD'), 5, 'Pizza excelent?!', 1, 'MAG001');
INSERT INTO Recenzie (ID_Recenzie, Data_Recenzie, Rating, Comentariu, ID_Client, ID_Pizzerie) VALUES (2, TO_DATE('2024-05-11', 'YYYY-MM-DD'), 4, 'Serviciu foarte bun.', 2, 'MAG002');
INSERT INTO Recenzie (ID_Recenzie, Data_Recenzie, Rating, Comentariu, ID_Client, ID_Pizzerie) VALUES (3, TO_DATE('2024-05-12', 'YYYY-MM-DD'), 3, 'Experien?? medie.', 3, 'MAG003');
INSERT INTO Recenzie (ID_Recenzie, Data_Recenzie, Rating, Comentariu, ID_Client, ID_Pizzerie) VALUES (4, TO_DATE('2024-05-13', 'YYYY-MM-DD'), 2, 'Ar putea fi mai bine.', 4, 'MAG004');
INSERT INTO Recenzie (ID_Recenzie, Data_Recenzie, Rating, Comentariu, ID_Client, ID_Pizzerie) VALUES (5, TO_DATE('2024-05-14', 'YYYY-MM-DD'), 1, 'Nu sunt mul?umit.', 5, 'MAG005');

SELECT * FROM Recenzie;











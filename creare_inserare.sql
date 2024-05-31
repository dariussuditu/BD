--CREARE
CREATE TABLE Client
(
  ID_Client INT NOT NULL,
  NUME_CLIENT VARCHAR(30) NOT NULL,
  EMAIL_CLIENT VARCHAR(10),
  PRIMARY KEY (ID_Client)
);


CREATE TABLE Locatie
(
  ID_Locatie VARCHAR(10) NOT NULL,
  Tara VARCHAR(20) NOT NULL,
  Oras VARCHAR(20) NOT NULL,
  Strada VARCHAR(30),
  Cod_postal VARCHAR(10) NOT NULL
  
  PRIMARY KEY (ID_Locatie)
);

CREATE TABLE Magazin
(
  ID_Magazin VARCHAR(10) NOT NULL,
  Nume VARCHAR(20) NOT NULL,
  Telefon VARCHAR(20),
  ID_Locatie VARCHAR(10) NOT NULL,
  PRIMARY KEY (ID_Magazin),
  FOREIGN KEY (ID_Locatie) REFERENCES Locatie(ID_Locatie)
);

create TABLE Angajat(
ID_Angajat int not null primary key,
Nume_Angajat varchar2(50) not null,
Salariu_Angajat int not null,
Data_Angajat date not null,
Telefon_Angajat varchar2(10)
);

CREATE TABLE Angajat_Magazin
(
  ID_Angajat_Magazin INT NOT NULL,
  Specializare VARCHAR(20) NOT NULL,
  ID_ANGAJAT not null,
  ID_Magazin VARCHAR(10) NOT NULL,
  PRIMARY KEY (ID_Angajat_Magazin),
  FOREIGN KEY (ID_Angajat) REFERENCES Angajat(ID_Angajat),
  FOREIGN KEY (ID_Magazin) REFERENCES Magazin(ID_Magazin)
);



CREATE TABLE Fabrica
(
  ID_Fabrica VARCHAR(10) NOT NULL,
  Productie INT NOT NULL,
  Data_infintare DATE NOT NULL,
  ID_Locatie VARCHAR(10) NOT NULL,
  PRIMARY KEY (ID_Fabrica),
  FOREIGN KEY (ID_Locatie) REFERENCES Locatie(ID_Locatie)
);

CREATE TABLE Muncitor
(
  ID_Muncitor INT NOT NULL,
  Specializare VARCHAR(20) NOT NULL,
  ID_Fabrica VARCHAR(10) NOT NULL,
  ID_Angajat not null,
  PRIMARY KEY (ID_Muncitor),
  FOREIGN KEY (ID_Angajat) REFERENCES Angajat(ID_Angajat),
  FOREIGN KEY (ID_Fabrica) REFERENCES Fabrica(ID_Fabrica)
);

CREATE TABLE Depozit
(
  ID_Depozit VARCHAR(10) NOT NULL,
  Capacitate INT NOT NULL,
  ID_Locatie VARCHAR(10) NOT NULL,
  PRIMARY KEY (ID_Depozit),
  FOREIGN KEY (ID_Locatie) REFERENCES Locatie(ID_Locatie)
);

CREATE TABLE Contract
(
  ID_Contract INT NOT NULL,
  Suma INT NOT NULL,
  ID_Depozit VARCHAR(10) NOT NULL,
  ID_Magazin VARCHAR(10) NOT NULL,
  PRIMARY KEY (ID_Contract),
  FOREIGN KEY (ID_Depozit) REFERENCES Depozit(ID_Depozit),
  FOREIGN KEY (ID_Magazin) REFERENCES Magazin(ID_Magazin)
);

CREATE TABLE Geaca
(
  ID_Geaca VARCHAR(10) NOT NULL,
  Nume VARCHAR(20) NOT NULL,
  Tip VARCHAR(20) NOT NULL,
  Marime VARCHAR(10) NOT NULL,
  ID_Fabrica VARCHAR(10) NOT NULL,
  ID_Depozit VARCHAR(10) NOT NULL,
  PRIMARY KEY (ID_Geaca),
  FOREIGN KEY (ID_Fabrica) REFERENCES Fabrica(ID_Fabrica),
  FOREIGN KEY (ID_Depozit) REFERENCES Depozit(ID_Depozit)
);

create TABLE Materiale(
ID_Material int not null primary key,
Nume varchar2(50) not null,
Cantitate int
);

CREATE TABLE Construire (
    ID_Geaca VARCHAR(10) NOT NULL,
    ID_Material INT NOT NULL,
    PRIMARY KEY (ID_Geaca, ID_Material),
    FOREIGN KEY (ID_Geaca) REFERENCES Geaca(ID_Geaca),
    FOREIGN KEY (ID_Material) REFERENCES Materiale(ID_Material)
);


CREATE TABLE Comanda
(
  ID_Comanda INT NOT NULL,
  Cantitate INT NOT NULL,
  Pret INT NOT NULL,
  Data_Comanda date,
  ID_Geaca VARCHAR(10) NOT NULL,
  ID_Magazin VARCHAR(10) NOT NULL,
  ID_Client INT NOT NULL,
  PRIMARY KEY (ID_Comanda),
  FOREIGN KEY (ID_Geaca) REFERENCES Geaca(ID_Geaca),
  FOREIGN KEY (ID_Magazin) REFERENCES Magazin(ID_Magazin),
  FOREIGN KEY (ID_Client) REFERENCES Client(ID_Client)
);


INSERT INTO Client (ID_Client, NUME_CLIENT, EMAIL_CLIENT) VALUES (1, 'Ana Popescu', 'ana.popescu@example.com');
INSERT INTO Client (ID_Client, NUME_CLIENT, EMAIL_CLIENT) VALUES(2, 'Mihai Ionescu', 'mihai.ionescu@example.com');
INSERT INTO Client (ID_Client, NUME_CLIENT, EMAIL_CLIENT) VALUES(3, 'Ioana Dumitrescu', 'ioana.dumitrescu@example.com');
INSERT INTO Client (ID_Client, NUME_CLIENT, EMAIL_CLIENT) VALUES(4, 'Andrei Georgescu', 'andrei.georgescu@example.com');
INSERT INTO Client (ID_Client, NUME_CLIENT, EMAIL_CLIENT) VALUES(5, 'Elena Radu', 'elena.radu@example.com');
select * from client;



INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES('RO001', 'Romania', 'Bucharest', 'Main Street', '010101');
INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES('RO002', 'Romania', 'Cluj-Napoca', 'Second Street', '020202');
INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES('RO003', 'Romania', 'Timisoara', 'Third Street', '030303');
INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES('RO004', 'Romania', 'Iasi', 'Fourth Street', '040404');
INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES('RO005', 'Romania', 'Constanta', 'Fifth Street', '050505');
INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES('RO006', 'Romania', 'Brasov', 'Sixth Street', '060606');
INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES ('DE001', 'Germany', 'Berlin', 'Berlin Street', '101010');
INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES('DE002', 'Germany', 'Munich', 'Munich Street', '202020');
INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES('DE003', 'Germany', 'Hamburg', 'Hamburg Street', '303030');
INSERT INTO Locatie (ID_Locatie, Tara, Oras, Strada, Cod_postal) VALUES('IT001', 'Italy', 'Rome', 'Rome Street', '001122', 'IT');
select * from locatie;



INSERT INTO Magazin (ID_Magazin, Nume, Telefon, ID_Locatie) VALUES ('MAG001', 'Magazin1', '1234567890', 'RO001');
INSERT INTO Magazin (ID_Magazin, Nume, Telefon, ID_Locatie) VALUES('MAG002', 'Magazin2', '0987654321', 'RO002');
INSERT INTO Magazin (ID_Magazin, Nume, Telefon, ID_Locatie) VALUES('MAG003', 'Magazin3', '1112223333', 'RO003');
INSERT INTO Magazin (ID_Magazin, Nume, Telefon, ID_Locatie) VALUES('MAG004', 'Magazin4', '4445556666', 'DE001');
INSERT INTO Magazin (ID_Magazin, Nume, Telefon, ID_Locatie) VALUES('MAG005', 'Magazin5', '7778889999', 'DE002');
select * from Magazin;


INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(1, 'Ion Popescu', 3000, TO_DATE('2023-01-15', 'YYYY-MM-DD'), '0712345678');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(2, 'Maria Ionescu', 3500, TO_DATE('2022-11-20', 'YYYY-MM-DD'), '0723456789');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(3, 'Ana Dumitrescu', 3200, TO_DATE('2023-02-10', 'YYYY-MM-DD'), '0734567890');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(4, 'Andrei Georgescu', 4000, TO_DATE('2023-03-05', 'YYYY-MM-DD'), '0745678901');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(5, 'Elena Radu', 3800, TO_DATE('2022-09-25', 'YYYY-MM-DD'), '0756789012');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(6, 'Mihai Stan', 3400, TO_DATE('2022-12-10', 'YYYY-MM-DD'), '0767890123');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(7, 'Cristina Stoica', 3700, TO_DATE('2023-04-15', 'YYYY-MM-DD'), '0778901234');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(8, 'Alexandra Marin', 3600, TO_DATE('2023-05-20', 'YYYY-MM-DD'), '0789012345');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(9, 'Florin Munteanu', 3900, TO_DATE('2023-07-01', 'YYYY-MM-DD'), '0790123456');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(10, 'Diana Andreescu', 3300, TO_DATE('2023-08-10', 'YYYY-MM-DD'), '0801234567');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(11, 'Gabriel Popa', 3100, TO_DATE('2023-09-15', 'YYYY-MM-DD'), '0812345678');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(12, 'Andreea Dumitrascu', 3400, TO_DATE('2023-10-20', 'YYYY-MM-DD'), '0823456789');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(13, 'Catalin Stanciu', 3200, TO_DATE('2023-11-10', 'YYYY-MM-DD'), '0834567890');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(14, 'Larisa Radulescu', 3800, TO_DATE('2023-12-05', 'YYYY-MM-DD'), '0845678901');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(15, 'Marius Iorgulescu', 3700, TO_DATE('2024-01-15', 'YYYY-MM-DD'), '0856789012');
INSERT INTO Angajat (ID_Angajat, Nume_Angajat, Salariu_Angajat, Data_Angajat, Telefon_Angajat) VALUES(16, 'Dan Beleaua', 4300, TO_DATE('2024-01-19', 'YYYY-MM-DD'), '0732456852');

select * from angajat;

INSERT INTO Angajat_Magazin (ID_Angajat_Magazin, Specializare, ID_Angajat, ID_Magazin) VALUES(1, 'Vanzator', 1, 'MAG001');
INSERT INTO Angajat_Magazin (ID_Angajat_Magazin, Specializare, ID_Angajat, ID_Magazin) VALUES(2, 'Vanzator', 2, 'MAG002');
INSERT INTO Angajat_Magazin (ID_Angajat_Magazin, Specializare, ID_Angajat, ID_Magazin) VALUES(3, 'Asistent', 3, 'MAG003');
INSERT INTO Angajat_Magazin (ID_Angajat_Magazin, Specializare, ID_Angajat, ID_Magazin) VALUES(4, 'Manager', 4, 'MAG004');
INSERT INTO Angajat_Magazin (ID_Angajat_Magazin, Specializare, ID_Angajat, ID_Magazin) VALUES(5, 'Vanzator', 5, 'MAG005');
select * from angajat_magazin;


INSERT INTO Fabrica (ID_Fabrica, Productie, Data_infintare, ID_Locatie) VALUES('FAB001', 1000, TO_DATE('2020-01-01', 'YYYY-MM-DD'), 'RO001');
INSERT INTO Fabrica (ID_Fabrica, Productie, Data_infintare, ID_Locatie) VALUES('FAB002', 1500, TO_DATE('2018-05-15', 'YYYY-MM-DD'), 'RO002');
INSERT INTO Fabrica (ID_Fabrica, Productie, Data_infintare, ID_Locatie) VALUES('FAB003', 1200, TO_DATE('2019-09-30', 'YYYY-MM-DD'), 'RO003');
INSERT INTO Fabrica (ID_Fabrica, Productie, Data_infintare, ID_Locatie) VALUES('FAB004', 2000, TO_DATE('2021-03-20', 'YYYY-MM-DD'), 'DE001');
INSERT INTO Fabrica (ID_Fabrica, Productie, Data_infintare, ID_Locatie) VALUES('FAB005', 1800, TO_DATE('2022-11-10', 'YYYY-MM-DD'), 'DE002');
select * from fabrica;


INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(6, 'Croitor', 'FAB001', 6);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(7, 'Croitor', 'FAB002', 7);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(8, 'Croitor', 'FAB003', 8);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(9, 'Croitor', 'FAB004', 9);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(10, 'Croitor', 'FAB005', 10);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(11, 'Cusator', 'FAB001', 11);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(12, 'Cusator', 'FAB002', 12);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(13, 'Cusator', 'FAB003', 13);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(14, 'Cusator', 'FAB004', 14);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(15, 'Cusator', 'FAB005', 15);
INSERT INTO Muncitor (ID_Muncitor, Specializare, ID_Fabrica, ID_Angajat) VALUES(16, 'Croitor', 'FAB001', 16);
select * from muncitor;


INSERT INTO Depozit (ID_Depozit, Capacitate, ID_Locatie) VALUES('DEP001', 1000, 'RO001');
INSERT INTO Depozit (ID_Depozit, Capacitate, ID_Locatie) VALUES('DEP002', 1500, 'RO002');
INSERT INTO Depozit (ID_Depozit, Capacitate, ID_Locatie) VALUES('DEP003', 1200, 'RO003');
INSERT INTO Depozit (ID_Depozit, Capacitate, ID_Locatie) VALUES('DEP004', 2000, 'DE001');
INSERT INTO Depozit (ID_Depozit, Capacitate, ID_Locatie) VALUES('DEP005', 1800, 'DE002');
select * from depozit;


INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(1, 5000, 'DEP001', 'MAG001');
INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(2, 6000, 'DEP002', 'MAG002');
INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(3, 7000, 'DEP003', 'MAG003');
INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(4, 8000, 'DEP004', 'MAG004');
INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(5, 9000, 'DEP005', 'MAG005');
INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(6, 5500, 'DEP001', 'MAG001');
INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(7, 6500, 'DEP002', 'MAG002');
INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(8, 7500, 'DEP003', 'MAG003');
INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(9, 8500, 'DEP004', 'MAG004');
INSERT INTO Contract (ID_Contract, Suma, ID_Depozit, ID_Magazin) VALUES(10, 9500, 'DEP005', 'MAG005');
select * from contract;





INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G001', 'Winter Jacket', 'Winter', 'M', 'FAB001', 'DEP001');
INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G002', 'Leather Jacket', 'Leather', 'L', 'FAB002', 'DEP002');
INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G003', 'Sport Jacket', 'Sport', 'S', 'FAB003', 'DEP003');
INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G004', 'Denim Jacket', 'Denim', 'XL', 'FAB004', 'DEP004');
INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G005', 'Parka Jacket', 'Parka', 'M', 'FAB005', 'DEP005');
INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G006', 'Bomber Jacket', 'Bomber', 'L', 'FAB001', 'DEP001');
INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G007', 'Puffer Jacket', 'Puffer', 'S', 'FAB002', 'DEP002');
INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G008', 'Windbreaker Jacket', 'Windbreaker', 'XL', 'FAB003', 'DEP003');
INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G009', 'Rain Jacket', 'Rain', 'M', 'FAB004', 'DEP004');
INSERT INTO Geaca (ID_Geaca, Nume, Tip, Marime, ID_Fabrica, ID_Depozit) VALUES('G010', 'Fleece Jacket', 'Fleece', 'L', 'FAB005', 'DEP005');
select * from geaca;



INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(1, 5, 200, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'G001', 'MAG001', 1);
INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(2, 3, 300, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'G002', 'MAG002', 2);
INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(3, 7, 250, TO_DATE('2024-01-05', 'YYYY-MM-DD'), 'G003', 'MAG003', 3);
INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(4, 4, 180, TO_DATE('2024-01-19', 'YYYY-MM-DD'), 'G004', 'MAG004', 4);
INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(5, 6, 220, TO_DATE('2023-08-29', 'YYYY-MM-DD'), 'G005', 'MAG005', 5);
INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(6, 2, 150, TO_DATE('2022-04-10', 'YYYY-MM-DD'), 'G006', 'MAG001', 3);
INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(7, 8, 280, TO_DATE('2024-03-5', 'YYYY-MM-DD'), 'G007', 'MAG002', 2);
INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(8, 1, 350, TO_DATE('2022-9-03', 'YYYY-MM-DD'), 'G008', 'MAG003', 4);
INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(9, 9, 200, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'G009', 'MAG004', 2);
INSERT INTO Comanda (ID_Comanda, Cantitate, Pret, Data_Comanda, ID_Geaca, ID_Magazin, ID_Client) VALUES(10, 5, 270, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'G010', 'MAG005', 5);

select * from comanda;


CREATE SEQUENCE seq_id_material
 START WITH 1
 INCREMENT BY 1
 NOCYCLE;




INSERT INTO Materiale (ID_Material, Nume, Cantitate) VALUES(seq_id_material.NEXTVAL, 'Bumbac', 100);
INSERT INTO Materiale (ID_Material, Nume, Cantitate) VALUES(seq_id_material.NEXTVAL, 'Piele', 150);
INSERT INTO Materiale (ID_Material, Nume, Cantitate) VALUES(seq_id_material.NEXTVAL, 'Poliester', 200);
INSERT INTO Materiale (ID_Material, Nume, Cantitate) VALUES(seq_id_material.NEXTVAL, 'Lân?', 120);
INSERT INTO Materiale (ID_Material, Nume, Cantitate) VALUES(seq_id_material.NEXTVAL, 'Nylon', 180);
select * from materiale;



INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G001', 1);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G001', 2);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G002', 3);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G003', 4);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G004', 5);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G005', 3);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G002', 1);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G005', 4);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G004', 2);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G004', 3);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G003', 2);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G001', 4);
INSERT INTO Construire (ID_Geaca, ID_Material) VALUES('G002', 4);
select * from construire;


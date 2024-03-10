
--afiseaza numele si prenumele clientilor si numarul de GECI diferite pe care le-au comandat.Selecteaza doar clientii care au cumparat cel putin 2 GECI diferite.Rezultatele vor fi ordonate descrescator dupa nr de GECI diferite 
SELECT 
    C.NUME_CLIENT,
    COUNT(DISTINCT G.ID_Geaca) AS Numar_Geci_Diferite
FROM 
    Client C
JOIN 
    Comanda CM ON C.ID_Client = CM.ID_Client
JOIN 
    Geaca G ON CM.ID_Geaca = G.ID_Geaca
GROUP BY 
    C.NUME_CLIENT
HAVING COUNT(DISTINCT G.ID_Geaca) >= 2
ORDER BY 
    Numar_Geci_Diferite DESC;



--afisati numele si email-ul pt fiecare client.Clientii care au comenzi mai mari de 500 de lei devin "Clienti premium",iar ceilalti "Clienti uzuali"

SELECT 
    C.Nume_Client,
    C.Email_Client,
    CASE 
        WHEN SUM(CM.Pret) > 500 THEN 'Client premium'
        ELSE 'Client uzual'
    END AS Tip_Client
FROM 
    Client C
LEFT JOIN 
    Comanda CM ON C.ID_Client = CM.ID_Client
GROUP BY 
    C.Nume_Client,
    C.Email_Client;





---Sa se afiseze numele , id-ul si numele magazinului in care lucreaza , si salariul vechi si majoratstiind ca se majoreaza astfel: 20% pt Magazin1,15% pentruMagazin2, 10% pentru Magazin3, 10 % pentru Magazin4 si 20% pentru Magazin5.Salariul este majorat angajatiilor care s-au angajat dupa 2022, se afiseaza in ordinea magazinelor in functie de id.

SELECT 
    A.Nume_Angajat,
    A.ID_Angajat,
    M.Nume,
    A.Salariu_Angajat AS Salariu_Vechi,
    NVL(
        DECODE(
            M.ID_Magazin,
            'MAG001', A.Salariu_Angajat * 1.20,
            'MAG002', A.Salariu_Angajat * 1.15,
            'MAG003', A.Salariu_Angajat * 1.10,
            'MAG004', A.Salariu_Angajat * 1.10,
            'MAG005', A.Salariu_Angajat * 1.20
        ),
        A.Salariu_Angajat
    ) AS Salariu_Majorat
FROM 
    Angajat A
INNER JOIN 
    Angajat_Magazin AM ON A.ID_Angajat = AM.ID_Angajat
INNER JOIN 
    Magazin M ON AM.ID_Magazin = M.ID_Magazin
WHERE 
    A.Data_Angajat > TO_DATE('2022-01-01', 'YYYY-MM-DD')
ORDER BY 
    M.ID_Magazin; 




--Sa se afiseze numele angajatilor,numele magazinelor si numele clientilor pt Clientii care au plasat o comanda in magazinul respectiv ce contine o geaca de marimea M sau L construita din bumbac in intervalul de timp 1 ianuarie-1 martie 2024

SELECT DISTINCT A.Nume_Angajat, M.Nume AS Nume_Magazin, Cl.Nume_Client 
FROM Angajat A
JOIN Angajat_Magazin AM ON A.ID_Angajat = AM.ID_Angajat
JOIN Magazin M ON AM.ID_Magazin = M.ID_Magazin
JOIN Comanda Co ON M.ID_Magazin = Co.ID_Magazin
JOIN Geaca G ON Co.ID_Geaca = G.ID_Geaca
JOIN Construire C ON G.ID_Geaca = C.ID_Geaca
JOIN Materiale Mat ON C.ID_Material = Mat.ID_Material
JOIN Client Cl ON Co.ID_Client = Cl.ID_Client
WHERE UPPER(G.Marime) LIKE 'M' OR LOWER(G.Marime) LIKE 'l'
AND Mat.Nume = 'Bumbac'
AND Co.Data_Comanda BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-03-01', 'YYYY-MM-DD');



--Afisati numele angajatilor si numele magazinelor care au cel putin o comanda plasata de un client cu un email care se termina cu ".com", si care au produs cel putin o geaca de tip "Polar" in fabrica cu ID-ul "FAB001".

WITH Comenzi_Email AS (
    SELECT DISTINCT Co.ID_Magazin
    FROM Comanda Co
    JOIN Client Cl ON Co.ID_Client = Cl.ID_Client
    WHERE Cl.EMAIL_CLIENT LIKE '%.com'
),
Geaci_Polare AS (
    SELECT DISTINCT G.ID_Geaca
    FROM Geaca G
    WHERE G.Tip = 'Winter'
    AND G.ID_Fabrica = 'FAB001'
)
SELECT DISTINCT A.Nume_Angajat, M.Nume AS Nume_Magazin
FROM Angajat A
JOIN Angajat_Magazin AM ON A.ID_Angajat = AM.ID_Angajat
JOIN Magazin M ON AM.ID_Magazin = M.ID_Magazin
JOIN Comenzi_Email CE ON M.ID_Magazin = CE.ID_Magazin
JOIN Comanda Co ON M.ID_Magazin = Co.ID_Magazin
JOIN Geaci_Polare GP ON Co.ID_Geaca = GP.ID_Geaca;



--implementarea a 3 operatii de actualizare a datelor utilizand subcereri.

--Aplicati o reducere de 20% la toate comenzile care sunt plasate de un client care a plasat 2 sau mai multe comenzi.
update Comanda
set Pret=Pret-Pret/10
where ID_Client in 
  (select c.ID_Client
  from client c
  join comanda co on c.ID_Client=co.ID_Client
  group by c.ID_Client
  having count(co.ID_Client)>=2);
  
  ROLLBACK;



--Aceasta interogare sterge platile facute de clientii cu id-ul mai mare de 2.
DELETE FROM Comanda
WHERE ID_COMANDA IN (SELECT ID_COMANDA FROM COMANDA WHERE ID_CLIENT
IN(SELECT ID_CLIENT FROM CLIENT WHERE ID_CLIENT > 2));
ROLLBACK;


--Sa se mareasca salariul angajatilor de la Magazinul 2 cu 20%
UPDATE Angajat
SET Salariu_Angajat = Salariu_Angajat * 1.2
WHERE ID_Angajat IN (
    SELECT AM.ID_Angajat
    FROM Angajat_Magazin AM
    INNER JOIN Magazin M ON AM.ID_Magazin = M.ID_Magazin
    WHERE M.Nume = 'Magazin2'
);
rollback;











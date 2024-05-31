--grupari de date, functii grup, filtrare la nivel de grupuri cu subcereri nesincronizate(in clauza de HAVING) in care intervin cel pu?in 3 tabele (in cadrul aceleia?i cereri)
--afiseaza numele clientilor si numarul de GECI diferite pe care le-au comandat.Selecteaza doar clientii care au cumparat un numar de geci diferite mai mare decat media numarului de geci diferite cumparate de toti clientii.Rezultatele vor fi ordonate descrescator dupa nr de GECI diferite 

SELECT 
    C.NUME_CLIENT,
    COUNT(DISTINCT G.ID_Geaca) AS Numar_Geci_Diferite
FROM 
    Client C
JOIN 
    Comanda CM ON C.ID_Client = CM.ID_Client
JOIN 
    Geaca G ON CM.ID_Geaca = G.ID_Geaca
JOIN
    Magazin M ON CM.ID_Magazin = M.ID_Magazin
GROUP BY 
    C.NUME_CLIENT
HAVING 
    COUNT(DISTINCT G.ID_Geaca) > (
        SELECT AVG(Numar_Geci)
        FROM (
            SELECT 
                CM2.ID_Client, 
                COUNT(DISTINCT G2.ID_Geaca) AS Numar_Geci
            FROM 
                Comanda CM2
            JOIN 
                Geaca G2 ON CM2.ID_Geaca = G2.ID_Geaca
            JOIN
                Magazin M2 ON CM2.ID_Magazin = M2.ID_Magazin
            GROUP BY 
                CM2.ID_Client
        ) Suma_Medie_Geci
    )
ORDER BY 
    Numar_Geci_Diferite DESC;


--afisati numele si email-ul pt fiecare client.Clientii care au comenzi mai mari de 500 de lei devin "Clienti premium",iar ceilalti "Clienti uzuali"
--subcereri nesincronizate in clauza from, expresie CASE.    
SELECT 
    C.Nume_Client,
    C.Email_Client,
    CASE 
        WHEN NVL(Suma_Comenzi, 0) > 500 THEN 'Client premium'
        ELSE 'Client uzual'
    END AS Tip_Client
FROM 
    Client C
LEFT JOIN 
    (
        SELECT 
            ID_Client,
            SUM(Pret) AS Suma_Comenzi
        FROM 
            Comanda
        GROUP BY 
            ID_Client
    ) Sume_Client ON C.ID_Client = Sume_Client.ID_Client;




            


---Sa se afiseze numele , id-ul si numele magazinului in care lucreaza , si salariul vechi si majoratstiind ca se majoreaza astfel: 20% pt Magazin1,15% pentruMagazin2, 10% pentru Magazin3, 10 % pentru Magazin4 si 20% pentru Magazin5.Salariul este majorat angajatiilor care s-au angajat dupa 2022, se afiseaza in ordinea magazinelor in functie de id.
--NVL, DECODE, ORDER BY
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




--Pentru toate comenzile plasate in anul 2023 sa se afiseze urmatoarele infromatii: numele clientului, numele magazinului, data in care a fost efectuata comanda,numele gecii comandate, respectiv numarul de ani si luni trecuti de la efectuarea comenzii.
--subcereri sincronizate in care intervin cel putin 3 tabele, functii pe date calendaristice.

SELECT
  c.NUME_CLIENT,
  m.Nume AS NUME_MAGAZIN,
  TO_CHAR(o.Data_Comanda, 'DD MONTH YY') AS DATA_COMANDA,
  g.Nume AS NUME_GEACA,
  f.ID_Fabrica AS NUME_FABRICA,
  TRUNC(MONTHS_BETWEEN(SYSDATE, o.Data_Comanda) / 12) AS ANI_TRECUTI,
  MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, o.Data_Comanda)), 12) AS LUNI_TRECUTI
FROM
  Comanda o
  JOIN Client c ON o.ID_Client = c.ID_Client
  JOIN Magazin m ON o.ID_Magazin = m.ID_Magazin
  JOIN Geaca g ON o.ID_Geaca = g.ID_Geaca
  JOIN Fabrica f ON g.ID_Fabrica = f.ID_Fabrica
WHERE
  o.ID_Client IN (
    SELECT
      o2.ID_Client
    FROM
      Comanda o2
    JOIN Geaca g2 ON o2.ID_Geaca = g2.ID_Geaca
    JOIN Fabrica f2 ON g2.ID_Fabrica = f2.ID_Fabrica
    WHERE
      TO_CHAR(o2.Data_Comanda, 'YYYY') = '2023'
  )
ORDER BY
  o.Data_Comanda;



    




--Afisati numele angajatilor si numele magazinelor care au cel putin o comanda plasata de un client cu un email care se termina cu ".com", si care au produs cel putin o geaca de tip "Polar" in fabrica cu ID-ul "FAB001".
--clauza WITH, functiile pe siruri de caractere LIKE,LOWER,UPPER
WITH Comenzi_Email AS (
    SELECT DISTINCT Co.ID_Magazin
    FROM Comanda Co
    JOIN Client Cl ON Co.ID_Client = Cl.ID_Client
    WHERE Cl.EMAIL_CLIENT LIKE '%.com'
),
Geaci_Polare AS (
    SELECT DISTINCT G.ID_Geaca
    FROM Geaca G
    WHERE LOWER(G.Tip) = 'winter'
    AND UPPER(G.ID_Fabrica) = 'FAB001'
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










--grupari de date, functii grup, filtrare la nivel de grupuri cu subcereri nesincronizate(in clauza de HAVING) in care intervin cel pu?in 3 tabele (in cadrul aceleia?i cereri)
--afiseaza numele clientilor si numarul de pizze diferite pe care le-au comandat.Selecteaza doar clientii care au cumparat un numar de pizze diferite mai mare decat media numarului de pizze diferite cumparate de toti clientii.Rezultatele vor fi ordonate descrescator dupa nr de pizze diferite 


SELECT 
    C.Nume AS Nume_Client,
    COUNT(DISTINCT P.ID_Pizza) AS Numar_Pizze_Diferite
FROM 
    Client C
JOIN 
    Comanda CM ON C.ID_Client = CM.ID_Client
JOIN 
    Pizza P ON CM.ID_Pizza = P.ID_Pizza
JOIN
    Pizzerie PI ON CM.ID_Pizzerie = PI.ID_Pizzerie
GROUP BY 
    C.Nume
HAVING 
    COUNT(DISTINCT P.ID_Pizza) > (
        SELECT AVG(Numar_Pizze)
        FROM (
            SELECT 
                CM2.ID_Client, 
                COUNT(DISTINCT P2.ID_Pizza) AS Numar_Pizze
            FROM 
                Comanda CM2
            JOIN 
                Pizza P2 ON CM2.ID_Pizza = P2.ID_Pizza
            JOIN
                Pizzerie PI2 ON CM2.ID_Pizzerie = PI2.ID_Pizzerie
            GROUP BY 
                CM2.ID_Client
        ) Suma_Medie_Pizze
    )
ORDER BY 
    Numar_Pizze_Diferite DESC;
    
    
--afisati numele si email-ul pt fiecare client.Clientii care au comenzi mai mari de 500 de lei devin "Clienti premium",iar ceilalti "Clienti uzuali"
--subcereri nesincronizate in clauza from, expresie CASE.    
SELECT 
    C.Nume,
    C.Email,
    CASE 
        WHEN NVL(Suma_Comenzi, 0) > 200 THEN 'Client premium'
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
    
    
---Sa se afiseze numele , id-ul si numele magazinului in care lucreaza , si salariul vechi si majoratstiind ca se majoreaza astfel: 20% pt Pizzeria1,15% pentru Pizzeria2, 10% pentru Pizzeria3, 10 % pentru Pizzeria4 si 20% pentru Pizzeria5.Salariul este majorat angajatiilor care s-au angajat dupa 2022, se afiseaza in ordinea magazinelor in functie de id.
--NVL, DECODE, ORDER BY
SELECT 
    A.Nume,
    A.ID_Angajat,
    PI.Nume,
    A.Salariu AS Salariu_Vechi,
    NVL(
        DECODE(
            PI.ID_Pizzerie,
            'MAG001', A.Salariu * 1.20,
            'MAG002', A.Salariu * 1.15,
            'MAG003', A.Salariu * 1.10,
            'MAG004', A.Salariu * 1.10,
            'MAG005', A.Salariu * 1.20
        ),
        A.Salariu
    ) AS Salariu_Majorat
FROM 
    Angajat A
INNER JOIN 
    Personal AM ON A.ID_Angajat = AM.ID_Angajat
INNER JOIN 
    Pizzerie PI ON AM.ID_Pizzerie = PI.ID_Pizzerie
WHERE 
    A.Data_Angajare > TO_DATE('2022-01-01', 'YYYY-MM-DD')
ORDER BY 
    PI.ID_Pizzerie; 
    
    
    
--Pentru toate comenzile plasate in anul 2023 sa se afiseze urmatoarele infromatii: numele clientului, numele magazinului, data in care a fost efectuata comanda,numele pizzei comandate, respectiv numarul de ani si luni trecuti de la efectuarea comenzii.
--subcereri sincronizate in care intervin cel putin 3 tabele, functii pe date calendaristice.

SELECT
  c.Nume AS NUME_CLIENT,
  p.Nume AS NUME_PIZZERIE,
  TO_CHAR(o.Data_Comanda, 'DD MONTH YY') AS DATA_COMANDA,
  pizza.Nume AS NUME_PIZZA,
  TRUNC(MONTHS_BETWEEN(SYSDATE, o.Data_Comanda) / 12) AS ANI_TRECUTI,
  MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, o.Data_Comanda)), 12) AS LUNI_TRECUTI
FROM
  Comanda o
  JOIN Client c ON o.ID_Client = c.ID_Client
  JOIN Pizzerie p ON o.ID_Pizzerie = p.ID_Pizzerie
  JOIN Pizza pizza ON o.ID_Pizza = pizza.ID_Pizza
WHERE
  o.ID_Client IN (
    SELECT
      o2.ID_Client
    FROM
      Comanda o2
    JOIN Pizza pizza2 ON o2.ID_Pizza = pizza2.ID_Pizza
    JOIN Pizzerie p2 ON o2.ID_Pizzerie = p2.ID_Pizzerie
    WHERE
      TO_CHAR(o2.Data_Comanda, 'YYYY') = '2024'
  )
ORDER BY
  o.Data_Comanda;


--Afisati numele angajatilor si numele pizzeriilor care au cel putin o comanda plasata de un client cu un email care se termina cu '.com', si care au produs cel putin o pizza de tip 'vegetarian'".
--clauza WITH, functiile pe siruri de caractere LIKE,LOWER,UPPER
WITH Comenzi_Email AS (
    SELECT DISTINCT Co.ID_Pizzerie
    FROM Comanda Co
    JOIN Client Cl ON Co.ID_Client = Cl.ID_Client
    WHERE Cl.Email LIKE '%.com'
),
Pizza_Calda AS (
    SELECT DISTINCT P.ID_Pizza
    FROM Pizza P
    WHERE LOWER(P.Tip) = 'vegetarian'
)
SELECT DISTINCT A.Nume, Pz.Nume AS Nume_Pizzerie
FROM Angajat A
JOIN Personal AP ON A.ID_Angajat = AP.ID_Angajat
JOIN Pizzerie Pz ON AP.ID_Pizzerie = Pz.ID_Pizzerie
JOIN Comenzi_Email CE ON Pz.ID_Pizzerie = CE.ID_Pizzerie
JOIN Comanda Co ON Pz.ID_Pizzerie = Co.ID_Pizzerie
JOIN Pizza_Calda PC ON Co.ID_Pizza = PC.ID_Pizza;



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


--Sa se mareasca salariul angajatilor de la pizzeria 2 cu 20%
UPDATE Angajat
SET Salariu = Salariu * 1.2
WHERE ID_Angajat IN (
    SELECT AM.ID_Angajat
    FROM Personal AM
    INNER JOIN Pizzerie PI ON AM.ID_Pizzerie = PI.ID_Pizzerie
    WHERE PI.Nume = 'Pizzerie2'
);
rollback;

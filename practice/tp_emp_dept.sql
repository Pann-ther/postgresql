--  Tous les employés avec tous leurs attributs  
SELECT * FROM emp;

-- Tous les employes
SELECT nom FROM emp;

-- Tous les employés triés par n° de département croissant,    
SELECT * FROM emp
ORDER BY ne ASC;
-- ordre alphabétique des fonctions decroissqntes
SELECT * FROM emp
ORDER BY job DESC;
-- ancienneté décroissantes
SELECT * FROM emp
ORDER BY datemb DESC;




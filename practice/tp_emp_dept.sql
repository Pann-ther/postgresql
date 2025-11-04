-- VERSION POSTGRESQL --
-------------------------------------------------------
--  Tous les employés avec tous leurs attributs  
SELECT * FROM emp;

-- Tous les employes
SELECT nom FROM emp;

-- Tous les employés triés par n° de département croissant,    
SELECT nom, ne FROM emp
ORDER BY ne ASC;
-- ordre alphabétique des fonctions decroissqntes
SELECT nom, job FROM emp
ORDER BY job DESC;
-- ancienneté décroissantes
SELECT nom, datemb FROM emp
ORDER BY datemb DESC;

-- Tous les employés avec leurs salaires triés par salaire décroissant 
SELECT nom, sal FROM emp 
ORDER BY sal DESC;

-- Tous les employés du département 30 avec tous leurs attributs 
SELECT * FROM emp
WHERE nd = 30;

-- Tous les employés du département 30 triés par ordre alphabétique
SELECT nom, nd FROM emp 
WHERE nd = 30
ORDER BY nom ASC;

-- Tous les managers des départements 20 et 30
SELECT nom, job, nd FROM emp
WHERE (nd = 30 OR nd=20) AND job = 'MANAGER';

-- Tous les employés qui ne sont pas managers et qui sont embauchés en 1981
SELECT nom, job, datemb FROM emp
WHERE job != 'MANAGER' AND EXTRACT(YEAR FROM datemb) = 1981;

-- Toutes les fonctions de la société
SELECT DISTINCT job FROM emp;

-- Tous les employés ne travaillant pas dans le département 30 et qui soit ont un salaire > à 2800, soit son manager. 
SELECT nom, nd, sal, job FROM emp
WHERE nd != 30 AND (sal > 2800 OR job = 'MANAGER');

-- Tous les employés dont le salaire est compris entre 1000 et 2000 
SELECT nom, sal FROM emp
WHERE sal BETWEEN 1000 AND 2000;

-- Tous les numéros de département non vides (dans lesquels travaille au moins un employé) 
SELECT DISTINCT nd FROM emp;

-- Tous les employés ayant ou pouvant avoir une commission  
SELECT nom, comm FROM emp
WHERE comm IS NOT NULL;

-- Tous les salaires, commissions et totaux (salaire + commission) des vendeurs 
SELECT nom, job, sal, comm, (sal + comm) as totaux FROM emp
WHERE job = 'SALESMAN';

-- Tous les salaires, commissions et totaux (salaire + commission) des employés 
SELECT nom, job, sal, comm, (sal + comm) as totaux FROM emp;

-- Tous les employés embauchés en 1981 
SELECT nom, datemb FROM emp
WHERE EXTRACT(YEAR FROM datemb) = 1981;

-- Tous les employés avec leur date d’embauche, la date du jour et leur nombre d’années d’ancienneté (on considérera que toute année commencée vaut pour une année), triés par ancienneté (on utilisera les fonctions de base de traitement de date et de traitement de chaîne).  
SELECT nom, datemb, (EXTRACT(YEAR FROM CURRENT_DATE)-EXTRACT(YEAR FROM datemb)) as ancienneté FROM emp
ORDER BY ancienneté DESC;

-- Tous les employés ayant un A en troisième lettre de leurs noms. 
SELECT nom FROM emp
WHERE SUBSTRING(nom FROM 3 FOR 1)='A';

-- Tous les employés ayant au moins deux A dans leurs noms.  
SELECT nom FROM emp
WHERE nom LIKE '%A%A%';

-- Donner les quatre dernières lettres du nom de chaque employé. 
SELECT nom, RIGHT(nom,4) as dernieres_lettres FROM emp;

-- Quel est le plus gros salaire de l’entreprise ? FONCTION MAX interdite.  
SELECT nom, sal FROM emp
ORDER BY sal DESC LIMIT 1;

-- Combien d'employés dans la société 
SELECT COUNT(*) as nb_employes FROM emp;

-- Combien d'employés embauchés en 1981 
SELECT COUNT(*) as employe_en_1981 FROM emp
WHERE EXTRACT(YEAR FROM datemb) = 1981;

-- Combien de départements non vides dans la société  
SELECT COUNT(DISTINCT nd) as nombre_departement FROM emp;
-- Combien de vendeurs (« Salesman ») dans la société  

SELECT COUNT(*) as nombre_vendeurs FROM emp
WHERE job = 'SALESMAN';

-- Combien de jobs différents dans la société  
SELECT COUNT(DISTINCT job) as nb_fonctions FROM emp;

-- Combien y a-t-il d’employés qui n’ont pas et ne peuvent pas avoir de commission ? 
SELECT COUNT(*) as sans_commision FROM emp
WHERE comm IS NULL;

-- Salaires minimum, maximum et moyen de la société 
SELECT MIN(sal) as sal_min, MAX(sal) sal_max, ROUND(AVG(sal),2) sal_moyen FROM emp;

-- Salaires moyens des vendeurs 
SELECT ROUND(AVG(sal,2)) as sal_moyen_salesman FROM emp
WHERE job = 'SALESMAN';

-- Salaires moyens de tous les employés en tenant compte des commissions 
SELECT ROUND(AVG(( sal+comm)),2) as totaux_moyen FROM emp;

-- Pourcentage moyen de la commission des vendeurs par rapport à leur salaire 
SELECT ROUND(AVG((comm/sal*100)),2) as pourcentage_moyen_commission FROM emp;

-- Quel est le salaire moyen, les salaires min et max et le nombre d’employé par profession ? 
SELECT job, MAX(sal) as salaire_max, MIN(sal) as salaire_min, ROUND(AVG(sal),2) as salaire_moyen FROM emp
GROUP BY job
ORDER BY job ASC;
 

 
-- Quels sont les salaires maximums de chaque département ?  
SELECT nd, MAX(sal) as salaire_max FROM emp
GROUP BY nd
ORDER BY nd;

-- Quels sont les départements dans lesquels travaillent plus de deux personnes et quels sont les salaires moyens dans ces départements ? 
SELECT nd,COUNT(*) as nb_employes, ROUND(AVG(sal),2) as salaire_moyen FROM emp
GROUP BY nd 
HAVING COUNT(*) > 2;

-- Quels sont les départements dans lequel il y a plus que 4 personnes ?  
SELECT nd, COUNT(*) as nb_employes FROM emp
GROUP BY nd 
HAVING COUNT(*) > 4;

-- Quels sont les jobs pour lesquels la moyenne du salaire est supérieure à 2000 ? 
SELECT job, ROUND(AVG(sal),2)as sal_moyen FROM emp
GROUP BY job
HAVING AVG(sal) > 2000;

-- Combien y a-t-il d’employés par département et par fonction et quelle est la moyenne de leurs salaires ? 
SELECT nd, job ,COUNT(*) as nb_employes, ROUND(AVG(sal), 2) as salaire_moyen FROM emp
GROUP BY nd, job
ORDER BY nd ASC;

-- Quel est le nombre d’employés par année d’embauche ? 
SELECT EXTRACT(YEAR FROM datemb) as annee_embauche, COUNT(*) as nb_employes FROM emp
GROUP BY EXTRACT(YEAR FROM datemb)
ORDER BY EXTRACT(YEAR FROM datemb) ASC;
--- 1)
SELECT nom_lieu FROM lieu 
WHERE nom_lieu LIKE '%um'

--- 2)
SELECT COUNT(pe.id_personnage), li.nom_lieu AS ville FROM personnage pe, lieu li
WHERE pe.id_lieu = li.id_lieu
GROUP BY ville;

--- 3)
SELECT pe.nom_personnage, pe.adresse_personnage, li.nom_lieu, spe.nom_specialite FROM personnage pe, lieu li, specialite spe
WHERE pe.id_lieu = li.id_lieu
AND pe.id_specialite = spe.id_specialite
ORDER BY li.nom_lieu, pe.nom_personnage ASC

--- 4)
SELECT COUNT(pe.id_personnage), spe.nom_specialite AS specialite FROM personnage pe, specialite spe
WHERE pe.id_specialite = spe.id_specialite
GROUP BY specialite;

--- 5)
SELECT bat.nom_bataille, bat.date_bataille, li.nom_lieu FROM bataille bat, lieu li
WHERE li.id_lieu = bat.id_lieu
ORDER BY bat.date_bataille ASC

--- 6) 
SELECT  po.nom_potion, SUM(ingr.cout_ingredient*comp.qte) AS prix FROM potion po, composer comp, ingredient ingr
WHERE po.id_potion = comp.id_potion
GROUP BY po.nom_potion
ORDER BY prix DESC

--- 7)
SELECT ingr.nom_ingredient, ingr.cout_ingredient, comp.qte FROM ingredient ingr, composer comp
WHERE comp.id_potion = 3
AND ingr.id_ingredient = comp.id_ingredient
ORDER BY ingr.cout_ingredient DESC

--- 8)
SELECT pe.nom_personnage, MAX(pr.qte) FROM prendre_casque pr, personnage pe
WHERE pr.id_bataille = 1
AND pe.id_personnage = pr.id_personnage
GROUP BY pe.nom_personnage, pr.qte
ORDER BY pr.qte DESC
LIMIT 1

--- 9)
SELECT p.nom_personnage, SUM(b.dose_boire) AS potion_bu FROM personnage p, boire b
WHERE b.id_personnage = p.id_personnage
GROUP BY p.nom_personnage
ORDER by potion_bu DESC

--- 10) 
SELECT b.nom_bataille, SUM(pr.qte) AS casque_prit FROM bataille b, prendre_casque pr
WHERE b.id_bataille = pr.id_bataille
GROUP BY b.nom_bataille
ORDER BY casque_prit DESC
LIMIT 1

--- 11)
SELECT t.nom_type_casque, COUNT(c.id_casque) AS collection FROM type_casque t, casque c
WHERE c.id_type_casque = t.id_type_casque
GROUP BY t.nom_type_casque

--- 12)
SELECT p.nom_potion FROM composer c, potion p
WHERE c.id_potion = p.id_potion
AND c.id_ingredient = '24'

--- 13)
SELECT l.nom_lieu, COUNT(p.id_personnage) AS habitants FROM personnage p, lieu l
WHERE p.id_lieu = l.id_lieu
AND p.id_lieu BETWEEN '2' AND '18'
GROUP BY l.nom_lieu

--- 14)
SELECT p.nom_personnage FROM personnage p
WHERE p.id_personnage NOT IN 
(SELECT b.id_potion FROM boire b)

--- 15) 
SELECT p.nom_personnage FROM personnage p
WHERE p.id_personnage NOT IN 
(SELECT a.id_personnage FROM autoriser_boire a WHERE a.id_potion = '1')


--- A)
INSERT INTO `personnage`(`id_personnage`, `nom_personnage`, `adresse_personnage`, `image_personnage`, `id_lieu`, `id_specialite`) 
VALUES ('0','Champdeblix','ferme Hantassion','indisponible.jpeg','6','12')

--- B)
INSERT INTO `autoriser_boire`(`id_potion`, `id_personnage`) VALUES ('1','12')

--- C)
DELETE FROM casque
WHERE id_type_casque = '2'
AND id_casque NOT IN
(SELECT p.id_casque FROM prendre_casque p)

--- D)
UPDATE personnage 
SET adresse_personnage = 'mis en prison à Condate'
WHERE nom_personnage = 'Zérozérosix'

--- E)
DELETE FROM composer
WHERE id_potion = 9
AND id_ingredient = 19

--- F)
UPDATE
  prendre_casque
SET
  id_casque = '14'
WHERE
  id_casque = '10'
  AND id_bataille = '2'
  AND id_personnage = '5'
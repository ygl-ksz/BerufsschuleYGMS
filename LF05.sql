[1]"Auswahl aller Zutaten eines Rezepts nach Rezeptname":
SELECT 
Z.BEZEICHNUNG AS Zutat, Rz.Menge, Rz.Einheit AS Einheit
FROM REZEPTZUTATEN AS Rz
JOIN ZUTAT AS Z ON Rz.ZutatenNr = Z.ZUTATENNR
WHERE RezeptNr =
(SELECT RezeptNr FROM REZEPT As R WHERE R.RezeptName = 'Käseapfel mit Kichererbseb')





[2]"Auswahl aller Rezepte einer bestimmten Ernährungskategorie":
SELECT 
RezeptName AS Rezept, RezeptNr as ID 
FROM REZEPT AS R
WHERE RezeptKategorie =
(SELECT KategorieNr FROM REZEPTKATEGORIE AS Rk WHERE Rk.KategorieName = 'Frutarisch')



[3]"Auswahl aller Rezepte die eine bestimmte Zutat enthalten":
SELECT 
R.RezeptName AS name 
FROM REZEPT AS R
WHERE R.RezeptNr =
(SELECT RezeptNr FROM REZEPTZUTATEN WHERE ZUTATENNR =
(SELECT ZUTATENNR FROM ZUTAT WHERE BEZEICHNUNG = 'Salz') 
)


[4]"Berechnung der durchschnittlichen Nährwerte aller Bestellungen eines Kunden"
Frage: Gilt für jede Bestellung ein Rezept? 


[4.1]"Erstmal nur die Durchschnittlichen Nährwerte eines Rezeptes":

Muss noch angepasst werden. Die Rezept-Einheiten müssen z.B mit einer extra Tabelle noch in Lager-Einheiten umgerechnet werden.

SELECT
Z.BEZEICHNUNG, SUM(Z.KALORIEN * Rz.Menge * Z.EINHEITFAKTOR) AS Kcal, SUM(Z.KOHLENHYDRATE * Rz.Menge * Z.EINHEITFAKTOR) AS Kohlenhydrate, SUM(Z.PROTEIN * Rz.Menge * Z.EINHEITFAKTOR) AS Protein
FROM ZUTAT AS Z 
JOIN REZEPTZUTATEN AS Rz 
ON Z.ZUTATENNR = Rz.ZutatenNr WHERE Rz.RezeptNr = 
(SELECT REZEPTNR FROM REZEPT WHERE RezeptName = 'Nudeln mit Tomatensosse');

[4.2]Hier muss das ganze dann auf alle Bestellungen eines Kunden angewendet und summiert werden.


[5]"Auswahl aller Zutaten, die bisher keinem Rezept zugeordnet sind"
SELECT
Z.BEZEICHNUNG AS Zutat
FROM ZUTAT as Z
LEFT JOIN REZEPTZUTATEN AS Rz
ON Z.ZutatenNr = Rz.ZutatenNr 
WHERE Rz.RezeptNr IS NULL --Nur Zutaten, welche kein Rezept zugehörig haben

[6]"Auswahl aller Rezepte, die eine bestimmte Kalorienmenge nicht überschreiten"

SELECT R.RezeptName FROM REZEPT AS R
LEFT JOIN REZEPTZUTATEN AS Rz ON R.RezeptNr = Rz.RezeptNr
WHERE 
(SELECT SUM(kalorien) FROM REZEPTZUTATEN AS Rz WHERE ??????)


[7&8]"Auswahl aller Rezepte, die Weniger als 5 Zutaten enthalten (und eine bestimmte Ernährungskategorie erfüllen)"

SELECT * FROM REZEPT AS R WHERE R.RezeptNr =
(SELECT * FROM REZEPTZUTATEN AS Rz WHERE ?????)


[AUSSICHT NOTIZEN]
- Alle Nährwerte sind pro 100g angegeben
- Einfache Lösung: 
                    Alle Zutaten die in Gramm und Milliliter angegeben sind, bekommen Faktor 0.01
                    Alle Zutaten die in Stück angegeben sind, bekommen Faktor 1. Die Nährwerte müssten hier für Stück statt 100g vorliegen


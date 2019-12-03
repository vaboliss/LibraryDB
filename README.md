# LibraryDB


Bibliotekos duomenų bazė. 
Duomenų bazę sudaro lentelės:

Knyga - Tai lentelėje, kurioje patalpinta Knygos 

Kopija- Tai lentelėje, kurioje patalpinta visos knygų kopijos

Skaitytojas - Tai lentelė, kurioje patalpinta visi skaitytojai

Darbuotojas- Tai lentelė, kurioje patalpinta visi darbuotojai

Baudos - Tai lentelė, kurioje patalpintos skaitytojų nesumokėtos baudos 

BauduIstorija - Tai lentelė, kurioje patalpinta visos kada nors egzistavusios baudos

Istorija - Tai lentelė, kurioje patalpinta visa informacija apie knygų išdavimą/gražinimą 

Statusas - Tau lentelė, kurioje patalpinta visos paskolintos knygos

Taip pat Statusas turi du trigerius :
1. Vienas kai atliekame įdėjimą į lentelę, tai yra paskolinam skaitytojui knygą,
kai įvyksta šis įvykis mes į istoriją įdedame naują įrašą, su tokia pačia informacija
2. Antrasis kai atliekame eilutės ištrinimą, tai  yra kai skaitytojas gražina knygą, 
kai įvyksta šis įvykis mes Istorijos lentelėje susirandame įrašą ir modifikuojame 
jame stulpelį grazinta ir jam priskiriame dabartinę datą.

Taip pat turime kelis virtuales lenteles, kad palengvintumėme duomenų ieškojimą,

1. Baudos - Visos baudos, nurodytas bauda, velavimo laikas ir kita naudinga informacija
2. Laiku_negrazintos - visos knygos, kurios nebuvo grazintos laiku
3. knygu_isdavimo_grazinimo_istorija - knygų išdavimo/gražinimo istorija
4. paiimtos_knygos - visos paiimtos knygos
5. nepaiimtos_knygos - visos nepaiimtos knygos
6. visos_knygos - visos knygos

Norint pasinaudoti šiom virtualiomis lentelėmis reikia 
pateikti užklausą SELECT * FROM Virtualios lentelės pavadinimas

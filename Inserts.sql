



INSERT INTO bachallenge.skaitytojas(id,ak,vardas,pavarde)
    values ('1','123456789','Jonas','Jonaitis');
INSERT INTO bachallenge.skaitytojas(id,ak,vardas,pavarde)
    values ('2','987654321','Petras','Petraitis');
INSERT INTO bachallenge.skaitytojas(id,ak,vardas,pavarde)
    values ('3','789456123','Antanas','Antanaitis');
INSERT INTO bachallenge.skaitytojas(id,ak,vardas,pavarde)
    values ('4','123456788','Karolis','Korinaitis');
INSERT INTO bachallenge.skaitytojas(id,ak,vardas,pavarde)
    values ('5','156523561','Povilas','Povilaitis');

INSERT INTO bachallenge.darbuotojas(id,vardas,pavarde)
    values('1','Dovydas','Dovydaitis');
INSERT INTO bachallenge.darbuotojas(id,vardas,pavarde)
    values('2','Paulius','Pauliukaitis');
INSERT INTO bachallenge.darbuotojas(id,vardas,pavarde)
    values('3','Irena','Irenaite');

INSERT INTO bachallenge.knyga(isbn, pavadinimas, metai, autorius)
    values ('123456789','Duomenu bazes','2000-08-23','Petras Karalis');
INSERT INTO bachallenge.knyga(isbn, pavadinimas, metai, autorius)
    values ('987654321','Algoritmai','2010-10-23','Paulina Stakenaite');
INSERT INTO bachallenge.knyga(isbn, pavadinimas, metai, autorius)
    values ('789456123','Design patterns','2019-08-23','Karlas Lava');

INSERT INTO bachallenge.kopija(nr, isbn)
    values('1','123456789');
INSERT INTO bachallenge.kopija(nr, isbn)
    values('2','123456789');
INSERT INTO bachallenge.kopija(nr, isbn)
    values('3','123456789');
INSERT INTO bachallenge.kopija(nr, isbn)
    values('4','987654321');
INSERT INTO bachallenge.kopija(nr, isbn)
    values('5','987654321');
INSERT INTO bachallenge.kopija(nr, isbn)
    values('6','987654321');
INSERT INTO bachallenge.kopija(nr, isbn)
    values('7','789456123');
INSERT INTO bachallenge.kopija(nr, isbn)
    values('8','789456123');
INSERT INTO bachallenge.kopija(nr, isbn)
    values('9','789456123');


INSERT INTO bachallenge.statusas(nr, paiimta, grazinti, skaitytojas, darbuotojas)
    values(1, '2019-11-03', '2019-12-03', '1','1');

INSERT INTO bachallenge.statusas(nr, paiimta, grazinti, skaitytojas, darbuotojas)
    values(2, '2019-11-20', '2019-12-01', '2','3');

INSERT INTO bachallenge.statusas(nr, paiimta, grazinti, skaitytojas, darbuotojas)
    values(4, '2019-11-01', '2019-12-02', '3','2');

INSERT INTO bachallenge.baudos(id, nr, bauda, data, darbuotojas, priezastis)
    values(1,2,100,'2019-12-03','3','Velavimas');






create table bachallenge.skaitytojas(
    Id integer not null primary key,
    Ak char(11) not null,
    Vardas varchar(32) not null,
    Pavarde varchar(32) not null
);
create table bachallenge.darbuotojas(
    Id integer not null primary key,
    Vardas varchar(32) not null,
    Pavarde varchar(32) not null
);
create table bachallenge.knyga(
    Isbn char(13) not null primary key,
    Pavadinimas varchar(32) not null,
    Metai date not null,
    Autorius varchar(64) not null
);
create table bachallenge.kopija
(
    Nr integer not null PRIMARY KEY ,
    ISBN char(13) not null,

    foreign key(ISBN) references bachallenge.knyga(Isbn)

);
create table bachallenge.statusas
(
    Nr integer not null primary key,
    Paiimta date not null,
    Grazinti date not null,
    Skaitytojas integer not null,
    Darbuotojas integer not null,

    foreign key (Skaitytojas) references bachallenge.skaitytojas(Id),
    foreign key (Darbuotojas) references bachallenge.darbuotojas(Id),
    foreign key(Nr) references bachallenge.kopija
);
create table bachallenge.istorija
(
    Nr integer not null,
    Paiimta date not null,
    Grazinta date,
    Grazinti date not null,
    Skaitytojas integer not null,
    Darbuotojas integer not null,

    foreign key (Skaitytojas) references bachallenge.skaitytojas(Id),
    foreign key (Darbuotojas) references bachallenge.darbuotojas(Id),
    foreign key(Nr) references bachallenge.kopija

);
create table bachallenge.baudos
(
  Id integer not null primary key,
  Nr integer not null,
  Bauda double precision not null,
  Data date not null,
  darbuotojas integer not null,
  Priezastis varchar(256),

  foreign key (darbuotojas) references bachallenge.darbuotojas(Id),
  foreign key(Nr) references bachallenge.statusas
);

create table  bachallenge.bauduIstorija
(
  Id integer not null primary key,
  Nr integer not null,
  Bauda double precision not null,
  darbuotojas integer not null,
  Data date not null,
  Priezastis varchar(256),
  Sumoketa date,

  foreign key(Nr) references bachallenge.kopija,
  foreign key (darbuotojas) references bachallenge.darbuotojas(Id)
);



/*TRIGGERS*/
create or replace function prideta_bauda()
RETURNS trigger as $$
BEGIN
    INSERT INTO bachallenge.bauduIstorija(id, nr, Bauda,darbuotojas, Data, Sumoketa,Priezastis)
        VALUES(new.id, new.nr, new.Bauda, new.darbuotojas, new.Data, null, new.Priezastis);
    RETURN new;
END;
$$LANGUAGE plpgsql;


create or replace function sumoketa_bauda()
RETURNS TRIGGER as $$
    begin
    Update bachallenge.bauduIstorija SET Sumoketa= now() WHERE id = old.id;
    RETURN NUll;
    end
$$LANGUAGE plpgsql;

create or replace function knyga_paiimta()
RETURNS trigger as $$
BEGIN
    INSERT INTO bachallenge.istorija(nr, paiimta, grazinta , grazinti, skaitytojas, darbuotojas)
        VALUES(new.nr,new.paiimta,null ,new.Grazinti,new.skaitytojas,new.darbuotojas);
    RETURN new;
END;
$$LANGUAGE plpgsql;

create or replace function knyga_grazinta()
RETURNS TRIGGER as $$
    begin
    Update bachallenge.istorija SET grazinta= now() WHERE nr = old.nr;
    RETURN NUll;
    end
$$LANGUAGE plpgsql;

CREATE TRIGGER istorijaGrazinta
    AFTER DELETE on bachallenge.statusas
        for each row execute procedure knyga_grazinta();

CREATE TRIGGER istorijaPaiimta
AFTER INSERT ON bachallenge.statusas
    FOR EACH ROW EXECUTE PROCEDURE knyga_paiimta();

CREATE TRIGGER bauduistorijaprideta
AFTER INSERT ON bachallenge.baudos
    FOR EACH ROW EXECUTE PROCEDURE prideta_bauda();

CREATE TRIGGER istorijabaudasumoketa
    AFTER DELETE on bachallenge.baudos
        for each row execute procedure sumoketa_bauda();


SELECT * from bachallenge.istorija;


CREATE view paiimtos_knygos AS
SELECT skaitytojas.ak as " Skaitytojo Asmens kodas", skaitytojas.vardas as "Skaitytojo vardas",skaitytojas.pavarde as "Skaitytojo pavardė", statusas.nr as "Knygos numeris",knyga.pavadinimas as "Knygos pavadinimas" ,knyga.isbn,knyga.metai,darbuotojas.id as "Darbuotojo identifikatorius",darbuotojas.vardas as "Darbuotojo vardas" , darbuotojas.pavarde as "Darbuotojo Pavardė" from bachallenge.statusas
INNER JOIN bachallenge.kopija as kopija ON statusas.nr = kopija.nr
INNER JOIN bachallenge.knyga as knyga ON knyga.isbn = kopija.ISBN
INNER JOIN bachallenge.skaitytojas as skaitytojas ON skaitytojas.id = statusas.skaitytojas
INNER JOIN bachallenge.darbuotojas as darbuotojas ON darbuotojas.id = statusas.darbuotojas;

Create view nepaiimtos_knygos AS
SELECT kopija.nr,knyga.isbn,knyga.pavadinimas,knyga.metai,knyga.autorius from bachallenge.statusas
RIGHT JOIN bachallenge.kopija on statusas.nr = kopija.nr
INNER JOIN bachallenge.knyga on knyga.isbn = kopija.isbn
where statusas.nr is null;


Create view visos_knygos AS
Select kopija.nr, knyga.isbn, knyga.pavadinimas,knyga.metai,knyga.autorius  from bachallenge.kopija
INNER JOIN bachallenge.knyga on kopija.isbn = knyga.isbn;

Create view knygu_isdavimo_grazinimo_istorija AS
SELECT skaitytojas.vardas as "Skaitytojo vardas",skaitytojas.pavarde as "Skaitytojo pavarde", skaitytojas.ak as "Skaitytojo asmens kodas", istorija.paiimta,istorija.grazinta,
       kopija.nr,knyga.isbn, pavadinimas,metai, autorius,
       darbuotojas.id as "Darbuotojo identifikatorius",
       darbuotojas.vardas as "Darbuotojo vardas", darbuotojas.pavarde as "Darbuotojo pavarde" from bachallenge.istorija
JOIN bachallenge.kopija on istorija.nr = kopija.nr
JOIN bachallenge.knyga on knyga.isbn = kopija.isbn
INNER JOIN bachallenge.skaitytojas as skaitytojas ON skaitytojas.id = istorija.skaitytojas
INNER JOIN bachallenge.darbuotojas as darbuotojas ON darbuotojas.id = istorija.darbuotojas;

Create view Laiku_negrazintos AS
SELECT nr,paiimta,grazinti,grazinta,skaitytojas,darbuotojas as laikas from bachallenge.istorija
where grazinta is null AND
      now() >= grazinti::date OR
      grazinta >= grazinti::date;

Create view Baudos AS
SELECT bachallenge.bauduistorija.id, skaitytojas.vardas,skaitytojas.pavarde, bauda, bachallenge.bauduistorija.nr, pavadinimas, bachallenge.knyga.isbn, Ln.paiimta,
       Ln.grazinti,Ln.grazinta, TO_CHAR(now()-grazinti, 'DD') as "Velavimas dienomis",priezastis,sumoketa,
       bachallenge.darbuotojas.vardas as "Uzregistravusio darbuotojo vardas", bachallenge.darbuotojas.pavarde as "Darbuotojo pavarde" , bachallenge.darbuotojas.id as "Darbuotojo identifikatorius"  from bachallenge.bauduistorija
JOIN Laiku_negrazintos Ln on bauduistorija.nr = Ln.nr
INNER JOIN bachallenge.skaitytojas on skaitytojas=skaitytojas.id
INNER JOIN bachallenge.darbuotojas on bauduistorija.darbuotojas=darbuotojas.id
INNER JOIN bachallenge.kopija on bauduistorija.nr = kopija.nr
INNER JOIN bachallenge.knyga on kopija.isbn = knyga.isbn;



SELECT * from Baudos;
SELECT * from Laiku_negrazintos;
Select * from knygu_isdavimo_grazinimo_istorija;
SELECT * from paiimtos_knygos;
SELECT * from nepaiimtos_knygos;
SELECT * from visos_knygos;



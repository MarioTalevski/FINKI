/* ZADACA 1 */
CREATE TABLE hotel(
    "ime" varchar(50) not null,
    "adresa" varchar(100) not null,
    "brZvezdi" number not null,
    "drzava" varchar(50) not null,
    "grad" varchar(50) not null,
    constraint hotel_pk primary key ("ime"),
    check ("brZvezdi" > 0 and "brZvezdi" < 6)
);
CREATE TABLE klient(
    "id" number not null,
    "ime" varchar(50) not null,
    "prezime" varchar (50) not null,
    "adresa" varchar(50) not null,
    "drzava" varchar(50) not null,
    constraint klient_pk primary key ("id")
);
CREATE TABLE tip_soba(
    "ime_tip" varchar(50) not null,
    "brKreveti" number not null,
    "brLica" number not null, 
    "rang" number not null,
    constraint tip_soba_pk primary key ("ime_tip")
);
CREATE TABLE soba(
    "id" number not null,
    "sprat" number not null,
    "ime" varchar(50) not null,
    "ime_tip" varchar(50) not null,
    constraint hotel_fk foreign key ("ime") references hotel("ime"),
    constraint tip_soba_fk foreign key ("ime_tip") references tip_soba("ime_tip"),
    constraint soba_pk primary key ("id")
);
CREATE TABLE rezervacija(
    "id" number not null,
    "od" date not null,
    "do" date not null,
    "data_rez" date not null,
    "ime" varchar(50) not null,
    "ime_tip" varchar(50) not null,
    "idKlient" number not null,
    constraint rezervacija_pk primary key ("id"),
    constraint hotel_rezervacija_fk foreign key ("ime") references hotel("ime"),
    constraint tip_soba_rezervacija_fk foreign key ("ime_tip") references tip_soba("ime_tip"),
    constraint rezervacija_klient_fk foreign key ("id") references klient("id") on delete set null
);
CREATE TABLE komentar(
    "id" number not null,
    "data" date not null,
    "sodrzina" varchar(100) not null,
    "ime" varchar(50) not null,
    "idKlient" number not null,
    constraint komentar_pk primary key ("id"),
    constraint komentar_hotel_fk foreign key ("ime") references hotel("ime"),
    constraint komentar_klient_fk foreign key ("id") references klient("id")
);
CREATE TABLE grad(
    "ime" varchar(50) not null,
    "drzava" varchar(50) not null,
    "imeHotel" varchar(50) not null,
    constraint grad_pk primary key ("ime"),
    constraint grad_hotel_fk foreign key ("ime") references hotel("ime")
);
CREATE TABLE znamenitost(
    "ime" varchar(50) not null,
    "opis" varchar(100) not null,
    "stepen" number not null,
    "imeHotel" varchar(50) not null,
    constraint znamenitost_pk primary key("ime"),
    constraint znamenitost_hotel_fk foreign key("ime") references hotel("ime")
);
CREATE TABLE poseteni_znamenitosti(
    "id" number not null,
    "idKlient" number not null,
    "ime" varchar(50) not null,
    "imeZnamenitost" varchar(50) not null,
    constraint poseteni_klient_fk foreign key ("id") references klient("id"),
    constraint poseteni_znamenisost_fk foreign  key("ime") references znamenitost("ime")
);

/* ZADACA 2 */ 
CREATE TABLE korisnik(
    "MBR" number not null,
    "grad" varchar(50) not null,
    "ulica" varchar(50) not null,
    "broj" number not null,
    "tip" varchar(50) not null,
    constraint korisnik_pk primary key ("MBR")
);
CREATE TABLE tel_broj(
    "broj" number not null,
    "MBR" number not null,
    constraint tel_broj_pk primary key ("broj"),
    constraint tel_korisnik_fk foreign key ("MBR") references korisnik("MBR"),
    check "broj" LIKE '07_______'
    
);
CREATE TABLE mobilen_operator(
    "naziv" varchar(50) not null,
    "opis" varchar(50) not null,
    constraint mobilen_operator_pk primary key ("naziv"),
   check ("naziv" in ('T-MOBILE','VIP'))
);
CREATE TABLE dogovor(
    "datum" date not null,
    "broj" number not null,
    "naziv" varchar(50) not null,
    "MBR" number not null,
    constraint dog_tel_broj_fk foreign key ("broj") references tel_broj("broj"),
    constraint dog_mobilen_operator_fk foreign key ("naziv") references mobilen_operator("naziv") on delete cascade,
    constraint dog_korisnik_fk foreign key ("MBR") references korisnik("MBR")
);
CREATE TABLE paket(
    "naziv" varchar(50) not null,
    "opis" varchar(100) not null,
    constraint paket_pk primary key ("naziv")
    
);
CREATE TABLE paket_dop_uslugi(
    "usluga" varchar(50) not null,
    "naziv" varchar(50) not null,
    constraint paket_dop_uslugi_pk primary key("usluga"),
    constraint paket_fk foreign key ("naziv") references paket("naziv")    
);
CREATE TABLE izbor(
    "datum" date not null,
    "id" number not null,
    "broj" number not null,
    "naziv" varchar(50) not null,
    constraint izbor_pk primary key ("id"),
    constraint izbor_tel_broj_fk foreign key ("broj") references tel_broj("broj") on delete cascade,
    constraint izbor_paket_fk foreign key ("naziv") references paket("naziv")
);
CREATE TABLE tip_korisnik(
    "id" number not null,
    "MBR" number not null,
    "tip" varchar(30) not null,
    constraint tip_korisnik_pk primary key ("id"),
    constraint tip_korisnik_fk foreign key ("MBR") references korisnik("MBR"),
    check ("tip" in ('PRIPEJD','POSTPEJD'))
);

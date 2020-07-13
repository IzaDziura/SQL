-- OPCJA CREATE

-- stworzenie tabeli movies
create table movies (
	movie_id varchar(36),
	movie_name varchar(40),
	movie_type varchar(30),
	movie_rating tinyint);

-- stworzenie tabeli movies tylko, jeżeli nie istnieje
create table if not exists movies (
	movie_id varchar(36),
	movie_name varchar(40),
	movie_type varchar(30),
	movie_rating tinyint);

-- stworzenie tabeli movies tylko, jeżeli nie istniej; 
-- movie_id to unikalny klusz, który automatycznie się inkrementuje
-- żadne z pól nie może być puste
create table if not exists movies (
	movie_id varchar(36) not null unique auto_increment primary key,
	movie_name varchar(40) not null,
	movie_type varchar(30) not null,
	movie_rating tinyint not null);

-- stworzenie tabeli movies tylko, jeżeli nie istniej; 
-- złączenie kolumn movie_id, movie_name powinny być jednoznacznym identyfikatorem tabeli
create table if not exists movies(
	movie_id varchar(36) not null unique,
    movie_name varchar(40) not null,
    movie_type varchar(30) not null,
    movie_rating tinyint not null,
    primary key (movie_id, movie_name));
	
-- stworzenie tabeli movies_v2 na podstawie tabeli movies
create table movies_v2 like movies;

--stworzenie tabeli movies_v2 na podstawie tabeli movies wraz z danymi z tej tabeli
create table if not exists movies_v2 as select * from movies;

-- stworzenie tabeli company
-- company_id powinno być jednoznacznym identyfikatorem
-- trade not null
-- number_of_employees powinno być domyślnie ustawione na zero
create table if not exists company(
	company_id varchar(28) not null unique primary key,
    trade varchar(40) not null,
    number_of_employees int default 0);
	
-- stworzenie tabeli job_offer
-- domyślna wartość dla offer_title to pusty łańcuch znaków
-- domyślna wartość dla offer_min_salary to 5000
-- domyślna wartość dla offer_max_salary to null
-- offer_id powinna być jednoznacznym identyfikatorem
-- company_id to klucz obcy
create table if not exists job_offer(
	offer_id varchar(36) not null unique,
    offer_title varchar(40) not null default ' ',
    offer_min_salary decimal(6,0) default 5000,
    offer_max_salary  decimal(6, 0) default null,
    company_id varchar(28) not null,
    foreign key (company_id) references company(company_id));
	
-- stworzenie tabeli candidate
-- COŚ Z KLUCZEM OBCYM
create table if not exists candidate(
	candidate_id varchar(36) not null unique,
    first_name varchar(40) not null default ' ',
    last_name varchar(40) not null default ' ',
    email varchar(30) not null,
    phone_number varchar(12) not null default 'unknow',
    company_id varchar(28) not null,
    offer_id varchar(36) not null,
    foreign key (company_id, offer_id) references company(company_id, offer_id));

	
-- OPCJA ALTER
	
-- zmiana nazwy tablicy movies
alter table movies rename movies_renamed;	

-- doadnie kolumny do istniejącej tabeli
alter table movies_renamed add movie_director varchar(40); 
	
-- dodanie kolumny na pierwsze miejsce
alter table movies_renamed add id int first;

-- dodanie kolumny movie_description za kolumną movie_name
alter table movies_renamed add movie_description varchar(255) after movie_name;

-- zmodyfikowanie typu danych jednej kolumny
alter table movies_renamed modify movie_rating int;

-- usunięcie kolumy z tabeli
alter table movies_renamed drop movie_director;

-- usunięcie klucza głównego
alter table movies_renamed drop primary key;

-- dodanie klucza głównego do istniejącej kolumny
alter table movies_renamed add primary key(movie_id);

-- dodanie klucza obcego fk_candidate_id w kolumnie company_id odnoszącego się do klucza podstaowego company_id z tabeli company
alter table job_offer add constraint fk_candidate_id foreign key (company_id) references company(company_id);
	
-- usunięcie klucza obcego

-- dodanie indeksu do nazwy kolumny
alter table movies_renamed add index idx_movie_id(movie_id); 

-- usunięcie indeksu
alter table movies_renamed drop index idx_movie_id;


-- OPCJA DROP
 -- usunięcie tabeli
 drop table movies;
 
 -- usinięcie tabel
 drop table job_offer, company;


-- OPCJA INSERT

-- wprowadzenie danych do tabeli movies
insert into movies values ('CXX132D', 'Lord Of The Rings', 'Fantasy', 100);

-- wprowadzenie danych do tabeli movies do dwóch kolumn
insert into movies(movie_id, movie_name) values ('CXX133D', 'Star Wars');

-- wprowadzenie danych do tabeli movies z wartością null
insert into movies values ('CXX134D', 'God Father', NULL, 90);

-- wprowadzenie 3 rekordów na raz
insert into movies values ('CXX135D', 'Good Witch', 'Special', 99),
						  ('CXX136D', 'Avengers', 'Action', 90),
						  ('CXX137D', 'Harry Potter', 'Fantasy', 90);
						  
-- skopiwanie rekordów do innej tabeli
insert into movies_new select * from movies;

-- utworzenie tabeli movies 
-- movie_id nie będzia miała zduplikowanych danych
-- movie_id automatycznie będzie zwiekszac swoją wartość
-- jezeli nie będzie wartości w movie_name, automatycznie uzupełni się N/ABS
create table if not exists movies(
	movie_id integer not null auto_increment primary key,
    movie_name varchar(40) not null default 'N/A',
    movie_rating integer not null);
	
insert into movies values (501, 'Lord Of The Rings', 100);
insert into movies(movie_rating) values (15);
insert into movies(movie_name, movie_rating) values ('Harry Potter', 90);

-- wprowadzenie pojedyńczego wiersza do tabeli company
-- company_id nie będzie zawierać zduplikowanych wartości
create table if not exists company(
	company_id varchar(28) not null unique primary key,
    trade varchar(40) not null,
    number_of_employees int default 0);
	
insert into company values (1001, 'Nokia', 800);
-- sprawdzenie warunku o unikalnym numerze
insert into company values (1001, 'Samsung', 900);

-- kolumna company_id powinna zawierać artości istniejące w kolumnie company_id w tabeli company
CREATE TABLE IF NOT EXISTS job_offer(
	offer_id varchar(36) NOT NULL UNIQUE, 
    offer_title varchar(40) NOT NULL DEFAULT ' ',
    offer_min_salary decimal(6,0) DEFAULT 5000,
    offer_max_salary decimal(6,0) DEFAULT NULL,
    company_id varchar(28) NOT NULL,
    FOREIGN KEY (company_id) REFERENCES company(company_id));
    
INSERT INTO job_offer VALUES(321,'Java developer',6000,10000,1001);
INSERT INTO job_offer VALUES(322,'QA Engineer',3000,6000,1001);


-- OPCJA UPDATE

-- movie_name ma zawierać opcję domyślną tekst "To be done"
update movies set movie_name = 'To be done';

-- zmień wartość w kolumnie movie_rating na 8, jeżeli w kolumnie movie_type jest wartość Action
update movies_new set movie_rating=8 where movie_type='Action';

-- zmień wartość w kolumne movie_name na Only for adults, jeżeli movie_type = Horror I movie_rating = 18
update movies movie_name='Only for adults' where movie_type='Horror' and movie_rating>=18;

-- offer_title z tabeli job_offer ma wyswietlać outdated jeżeli w tabeli company kolumna number_of_employees jest większa niż 10000
update job_offer set offer_title='outdated' where company_id in (select company_id from company where number_of_employees >10000);


-- OPCJA DELETE

-- usuń rekordy z tabeli movies
delete from movies;

-- usuń rekordy z tabeli movies, gdzie movie_type = Action
delete from movies where movie_type='Action';

-- usuń rekordy z tabeli movies, gdzie movie_rating jest mniejszy niż 15
delete from movies where movie_rating<15;

-- usuń rekordy z tabeli job_offer, która jest powiązana z firmą zatrudniającą powyżej 200 osób
delete from job_offer where company_id in (select company_id from company where number_of_employees>200);


-- OPCJA SELECT

-- wyświetl wszystko z tabeli movies
select * from movies;

-- wyświetl kolumny movie_rating i movie_name z tabeli movies
select movie_rating, movie_name from movies;

-- wyświetl wszytsko dla movie_rating mniejsze niż 14
select * from movies where movie_rating < 14;

-- wyświetl dane z tabeli job_offer powiązane z firmą, gdzie movie_name rozpoczyna się od IT
select * from job_offer where company_id in (select company_if from company where trade like 'IT%');








	
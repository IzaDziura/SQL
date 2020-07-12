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
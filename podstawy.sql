-- stworzenie tabeli movies
create table movies (
movie_id varchar(36),
movie_name varchar(40),
movie_type varchar(30),
movie_rating tinyint);

-- stworzenie tabeli movies tylko, jeżeli nie istnieje
create tables if not exists movies (
movie_id varchar(36),
movie_name varchar(40),
movie_type varchar(30),
movie_rating tinyint);

-- stworzenie tabeli movies tylko, jeżeli nie istniej; 
-- movie_id to unikalny klusz, który automatycznie się inkrementuje
-- żadne z pól nie może być puste
create tables if not exists movies (
movie_id varchar(36) not null unique auto_increment primary key,
movie_name varchar(40) not null,
movie_type varchar(30) not null,
movie_rating tinyint not null);
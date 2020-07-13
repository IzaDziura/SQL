-- wyświetl Id, Name, Population z tabeli city, tylko pierwsze 10 wyników
select Id, Name, Population from city limit 50, 10;

-- wyświetl Id, Name, Population z tabeli city, wyniki 31-40
select Id, Name, Population from city limit 30, 10;

-- wyświetl Name z tabeli city, których populacja jest większa niż 2000000
select Name from city where Population > 2000000;

-- wyświetl nazwy miast zaczynające się na Be
select Name from city where Name like 'Be%';

-- wyświetl nazwy miast, których populacja mieści się pomiędzy 500000 a 1000000
select Name from city where Population between 500000 and 1000000;

-- wyświetl nazwy miast według kolumny Name rosnąco
select Name from city order by Name ASC;

-- wyświetl miasto o najnizszej populacji
select Name, min(Population) from city;

-- wyświetl kraj o największej populacji
select Name, max(Population) from country;

-- wyświetl wszystkie języki uzywane w rejonie Caribbean
select CountryCode, Language, Region from countrylanguage cl join country c on cl.CountryCode=c.Code where c.Region = 'Caribbean';

-- wyświetl stolicę Hiszpani
select * from country c join city ci on ci.id = c.Capital where c.Name= 'Spain'; 

-- wyświetl państwo z najdłuższą wyczekiwaną długością życia
select * , max(LifeExpectancy) from country;

-- wyświetl wszystkie miasta z Europy
select * from country co join city c on co.Code=c.CountryCode where co.Continent = 'Europe';

-- Zaaktualizuj głowę państwa Stanów Zjednoczonych
update country set HeadOfState = 'Donald Tramp' where Name = 'United States';

-- wyświetl miasto najbardziej zaludnione
select Name, max(Population) from country;

-- wyświetl miasto najmniej zaludnione
select *, min(Population) from country;

-- wyświetl liczbę rekordów w tabeli city
select count(*) from city;

-- wyświetl liczbę miast w Chinach
select count(*) from city c join country co on c.CountryCode=co.Code where co.Name = 'China';
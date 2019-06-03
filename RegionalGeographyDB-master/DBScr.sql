 CREATE DATABASE Regional_geography_db;
 GO
 USE Regional_geography_db;
------------------------------------------------------
--Создание таблиц и PK, FK
------------------------------------------------------
CREATE TABLE Continent (
	Continent_ID INT IDENTITY NOT NULL,
	Name VARCHAR(50) UNIQUE NOT NULL,
	CONSTRAINT Continent_PK PRIMARY KEY(Continent_ID) 
)
CREATE TABLE Country (
	Country_ID INT IDENTITY NOT NULL,
	Continent_ID INT NOT NULL,
	Name  VARCHAR(100) UNIQUE NOT NULL,
	Total_Area INT NOT NULL,
	Population_Size INT NOT NULL,
	CONSTRAINT Country_PK PRIMARY KEY (Country_ID),
	FOREIGN KEY (Continent_ID)  REFERENCES Continent (Continent_ID) ON DELETE CASCADE ON UPDATE CASCADE 
)
CREATE TABLE Language(
	Language_ID  INT IDENTITY NOT NULL,
	Name VARCHAR(50) NOT NULL,
	CONSTRAINT Language_FK PRIMARY KEY (Language_ID)
)
CREATE TABLE CountryLanguage(
	ID INT IDENTITY NOT NULL,
	Country_ID INT NOT NULL,
	Language_ID INT NOT NULL,
	CONSTRAINT CountryLanguage_PK PRIMARY KEY (ID),
	FOREIGN KEY (Country_ID) REFERENCES Country (Country_ID) ON DELETE CASCADE,
	FOREIGN KEY (Language_ID) REFERENCES Language (Language_ID) ON DELETE CASCADE
)
CREATE TABLE City (
	Country_ID INT NOT NULL,
	City_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	Population_Size INT NOT NULL,
	CONSTRAINT City_PK PRIMARY KEY (City_ID),
	FOREIGN KEY (Country_ID)  REFERENCES Country (Country_ID) ON DELETE CASCADE ON UPDATE CASCADE 
)
CREATE TABLE Sight_Type (
	SightType_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	CONSTRAINT SightType_PK PRIMARY KEY (SightType_ID)
)
CREATE TABLE Sight (
	Sight_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	City_ID INT NOT NULL,
	OpeningHours VARCHAR(100) NOT NULL,
	SightType_ID INT,
	Address VARCHAR(200) NOT NULL,
	IsUNESCO BIT,
	Description VARCHAR(1000),
	CONSTRAINT Sight_PK PRIMARY KEY (Sight_ID),
	FOREIGN KEY (City_ID)  REFERENCES City (City_ID) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY (SightType_ID)  REFERENCES Sight_Type (SightType_ID) ON UPDATE CASCADE
)
--------------------------------------------------------------------------
-- Заполнение таблиц 
--------------------------------------------------------------------------
INSERT INTO Continent(Name) VALUES ('Europe')
INSERT INTO Continent(Name) VALUES ('Asia')
INSERT INTO Continent(Name) VALUES ('Eurasia')
INSERT INTO Continent(Name) VALUES ('Antarctica')
INSERT INTO Continent(Name) VALUES ('Australia')
INSERT INTO Continent(Name) VALUES ('South America')
INSERT INTO Continent(Name) VALUES ('North America')
INSERT INTO Continent(Name) VALUES ('Africa')
----------------------------------------------------------
-- Добавление данных с помощью процедур
----------------------------------------------------------
-- Страны
EXEC AddCountry 'Eurasia', 'Russia', 17100000, 146781095
EXEC AddCountry 'Europe', 'France', 674685, 66991000
EXEC AddCountry 'South America', 'Chile', 756950, 17789267
-- Языки
EXEC AddLanguage 'Russian'
EXEC AddLanguage 'French' 
EXEC AddLanguage 'Chilean'
EXEC AddLanguage 'Spanish'
-- Привязка языков к странам
EXEC JoinCountryLanguage 'Russia','Russian'
EXEC JoinCountryLanguage 'France','French'
EXEC JoinCountryLanguage 'Chile','Spanish'
EXEC JoinCountryLanguage 'Chile','Chilean' 
-- Города
EXEC AddCity 'France', 'Paris', 2190327
EXEC AddCity 'France', 'Versailles', 85771
EXEC AddCity 'France', 'Marne-la-Vallee', 291132
EXEC AddCity 'Russia', 'Moscow', 11920000
EXEC AddCity 'Russia', 'St. Petersburg', 5383968
EXEC AddCity 'Russia', 'Irkutsk', 623869
EXEC AddCity 'Russia', 'Novosibirsk', 1612833
EXEC AddCity 'Chile', 'Isla de Pascua', 7750
EXEC AddCity 'Chile', 'Antofagasta', 388545
EXEC AddCity 'Chile', 'Puerto Chacabuco', 1243
-- Типы достопримечательностей
EXEC AddSightType 'Theater'
EXEC AddSightType 'Museum'
EXEC AddSightType 'Fountain'
EXEC AddSightType 'Mountain'
EXEC AddSightType 'Lake'
EXEC AddSightType 'Cathedral'
EXEC AddSightType 'Amusement Park'
EXEC AddSightType 'National Park'
EXEC AddSightType 'Monument'
-- Достопримечательности
EXEC AddSight 'Mariinsky Theater', 'St. Petersburg', '11: 00–19: 00 ','Theater',' Theater Square, 1, St. Petersburg, 190000 ', 0,' Opera and Ballet Theater in St. Petersburg, one of the leading musical theaters in Russia and the world. '
EXEC AddSight 'Baikal', 'Irkutsk', '24/7','Lake','Irkutsk region, 665921', 1,'Lake of tectonic origin, the deepest lake on the planet, the largest natural reservoir of fresh water.'
EXEC AddSight 'Moscow Kremlin and Red Square', 'Moscow', '09: 30–18: 00', 'Museum', 'Red Square, Moscow, 109012', 1, 'The main historical symbol of the country and its most famous landmark, witnesses a number of major historical events.'
EXEC AddSight 'Notre Dame de Paris', 'Paris', '08: 00–19: 00 ','Cathedral',' 6 Parvis Notre-Dame - Pl. Jean-Paul II, 75004 Paris, France ', 1,' Notre-Dame de Paris is a Catholic church, one of the symbols of the French capital. '
EXEC AddSight 'Versailles','Versailles', '09: 00–17: 30', 'Museum', 'Place d Armes, 78000 Versailles, France', 0, 'Palace and park ensemble, the former residence of the French kings, now being a suburb of Paris; center of world-class tourism. '
EXEC AddSight 'Disneyland', 'Marne-la-Vallee', '10: 00–20: 00 ','Amusement Park',' Boulevard de Parc, 77700 Coupvray, France ', 0,' The complex of amusement parks of the Walt Disney company ", The park area is about 1943 hectares, an average of 12.5 million people visit Disneyland Paris per year.'
EXEC AddSight 'National Park Rapanui', 'Isla de Pascua', '24/7 ','National Park',' Easter Island, Valparaiso, Chile ', 1,' The island owes its glory to numerous stone sculptures of moai, the creation of which attributed to the ancient Rapanuyans (X — XVI centuries). '
EXEC AddSight 'Pukara de Quitar', 'Antofagasta', '08: 00–19: 00 ','Monument',' San Pedro de Atacama, Antofagasta, Chile ', 0,' Pre-Columbian village and archaeological monument, the village is known its stone fortress, which dates from the XII century. '
EXEC AddSight 'Laguna San Rafael', 'Puerto Chacabuco', '24/7 ','Lake',' Puerto Chacabuco, Puerto Aisen, Chile ', 0,' Arc-shaped coastal lake, glacier. '
--------------------------------------------------------------------------
-- Запросы для клиентской части 
--------------------------------------------------------------------------
-- Входят в юнеско...
SELECT * FROM  Sight WHERE Sight.IsUNESCO = 1
-- города по населению от ста тысяч до миллиона
SELECT Name, Population_Size FROM City WHERE Population_Size BETWEEN 100000 AND 1000000
-- Топ 10 стран по площади
SELECT TOP 10 Name, Total_Area FROM Country ORDER BY Total_Area DESC
-- Города миллионники и города с тремя или более достопр.
SELECT City.Name FROM City WHERE Population_Size > 999999
UNION 
SELECT City.Name FROM City WHERE (SELECT Count(*) FROM Sight WHERE City.City_ID = Sight.City_ID)>=3
-- Страны с достопр. из ЮНЕСКО за исключением стран из Африки
SELECT Country.Name FROM Country 
	WHERE (SELECT Count(*) FROM Sight WHERE Sight.IsUNESCO = 1 AND Sight.City_ID IN (SELECT City_ID FROM City WHERE City.Country_ID = Country.Country_ID)) > 0
EXCEPT
SELECT Country.Name FROM Country WHERE (SELECT Continent.Name FROM Continent WHERE Continent.Continent_ID = Country.Continent_ID) = 'Africa'
-- Страны с французским языком и театрами
SELECT Country.Name FROM Country 
	JOIN CountryLanguage ON Country.Country_ID = CountryLanguage.Country_ID 
	WHERE (SELECT Language.Name FROM Language
	WHERE CountryLanguage.Language_ID = Language.Language_ID) = 'French'
INTERSECT
SELECT Country.Name FROM Country
	JOIN City ON City.Country_ID = Country.Country_ID
	WHERE (SELECT Count(*) FROM Sight
	WHERE Sight.City_ID = City.City_ID AND Sight.SightType_ID = (SELECT SightType_ID FROM Sight_Type WHERE Sight_Type.Name = 'Theater'))>0
-- Города, в которых больше двух 
SELECT City.Name AS Город, Sight.Name AS Достопримечаательность FROM City
	JOIN Sight ON City.City_ID = Sight.City_ID
	GROUP BY City.Name, Sight.Name HAVING Count(*) > 2
-- Города, в названии которых есть дефис
SELECT * FROM City WHERE City.Name LIKE '%[-]%'
-- Таблица городов с их размером населения и общей суммой населения во всех городах,
-- которые есть в базе, сгруппированных по странам
SELECT Country.Name, City.Name, Sum(City.Population_Size) AS Размер_населения FROM Country
JOIN City ON City.Country_ID = Country.Country_ID
GROUP BY Country.Name, City.Name WITH ROLLUP
-- Таблица достопр. одного из типов: озеро, водопад, река, океан
SELECT * FROM Sight WHERE
(SELECT Sight_Type.Name FROM Sight_Type WHERE Sight.SightType_ID = Sight_Type.SightType_ID) IN ('Lake', 'Waterfall', 'River', 'Ocean')
-- Список стран с населением большим, чем население любого города в России
SELECT * FROM Country
WHERE Country.Population_Size > ANY(SELECT Population_Size FROM City WHERE City.Country_ID = (SELECT Country.Country_ID FROM Country WHERE Country.Name = 'Russia'))
-- Список городов в которых нет достопр.
SELECT * FROM City
	WHERE NOT EXISTS(SELECT * FROM Sight WHERE Sight.City_ID = City.City_ID)
--------------------------------------------------------------------------
-- Процедуры 
--------------------------------------------------------------------------
-- Добавление страны
GO
CREATE PROCEDURE AddCountry 
					@ContinentName VARCHAR(50),
					@Name VARCHAR(100),
					@Total_Area INT,
					@Population_Size INT
					AS
BEGIN

	IF (SELECT Count(Continent_ID) FROM Continent WHERE Name = @ContinentName) = 1
		IF (SELECT Count(Country_ID) FROM Country WHERE Name = @Name) = 0
			INSERT INTO Country(Continent_ID, Name, Total_Area, Population_Size)
			VALUES ((SELECT Continent_ID FROM Continent WHERE Name = @ContinentName), @Name, @Total_Area, @Population_Size)
		ELSE 
		PRINT 'Country' + @Name + 'already exists'
	ELSE
		PRINT 'There is no such continent:'+@ContinentName
END;
-- Добавление города
GO
CREATE PROCEDURE AddCity
	@CountryName VARCHAR(50),
	@Name VARCHAR(100),
	@Population_Size INT
AS
BEGIN
	IF (SELECT COUNT(Country_ID) FROM Country WHERE Name = @CountryName) = 1
		IF (SELECT COUNT(City_ID) FROM City WHERE Name = @Name) = 0
			INSERT INTO City(Country_ID, Name, Population_Size)
			VALUES ((SELECT Country_ID FROM Country WHERE Name = @CountryName), @Name, @Population_Size)
		ELSE
			PRINT 'City ' + @Name + ' already exists'
	ELSE 
		PRINT 'There is no such country:' + @CountryName
END;
-- Добавление языка
GO
CREATE PROCEDURE AddLanguage
	@Name VARCHAR(100)
AS IF (SELECT COUNT(Language_ID) FROM Language WHERE Name = @Name) = 0
		INSERT INTO Language (Name) VALUES (@Name);
	ELSE 
		PRINT 'Already contained:' + @Name;
-- Процедура для привязки языка к стране
GO
CREATE PROCEDURE JoinCountryLanguage
	@Country VARCHAR(100),
	@Language VARCHAR(100)
AS
BEGIN
	IF (SELECT Count(Country_ID) FROM Country WHERE Name = @Country) = 1
		IF (SELECT COUNT(Language_ID) FROM Language WHERE Name = @Language) = 1
			INSERT INTO CountryLanguage(Country_ID,Language_ID) 
			VAlUES ((SELECT Country_ID FROM Country WHERE Name = @Country),(SELECT Language_ID FROM Language WHERE Name = @Language));
		ELSE
			PRINT 'There is no language in the database:' + @Language;
	ELSE 
		PRINT 'Countries are not in the database:' + @Country;
END;
-- Добавление типа достопримечательности
GO
CREATE PROCEDURE AddSightType
	@Name VARCHAR(100)
AS
BEGIN 
IF (SELECT COUNT(SightType_ID) FROM Sight_Type WHERE Name = @Name) = 0
		INSERT INTO Sight_Type (Name) VALUES (@Name);
	ELSE 
		PRINT 'Already contained:' + @Name;
END;
-- Добавление достопримечательности
GO
CREATE PROCEDURE AddSight 
	@Name VARCHAR(100),
	@CityName VARCHAR(100),
	@OpeningHours VARCHAR(100),
	@SightType VARCHAR(100),
	@Address VARCHAR(100),
	@IsUNESCO BIT,
	@Discription VARCHAR(1000)
AS
BEGIN
	IF (SELECT COUNT(City_ID) FROM City WHERE Name = @CityName) = 0
	BEGIN
		PRINT 'There is no such city:' + @CityName;
		RETURN;
	END;
	IF (SELECT COUNT(SightType_ID) FROM Sight_Type WHERE Name = @SightType) = 0
	BEGIN
		PRINT 'There is no such type of attraction:' + @SightType;
		RETURN;
	END;
	IF (SELECT COUNT(SightType_ID) FROM Sight WHERE Name = @Name) > 0
	BEGIN
		PRINT 'Already exists: ' + @Name;
		RETURN;
	END;
	INSERT INTO Sight (Name, City_ID, OpeningHours, SightType_ID, Address, IsUNESCO, Description)
	VALUES (@Name,
			(SELECT City_ID FROM City WHERE Name = @CityName),
			@OpeningHours,
			(SELECT SightType_ID FROM Sight_Type WHERE Name = @SightType),
			@Address,
			@IsUNESCO,
			@Discription);
END;
-- Вывод достопр. данного города
GO
CREATE PROCEDURE ShowSightsOf @CityName VARCHAR(100)
AS 
BEGIN
	IF (SELECT COUNT(City_ID) FROM City WHERE Name = @CityName) = 0
	BEGIN
		PRINT 'There is no such city:' + @CityName;
		RETURN;
	END;
	SELECT Sight.Name FROM Sight WHERE Sight.City_ID = (SELECT City_ID FROM City Where City.Name = @CityName)
END;
-- Проверка того, содержится ли в данном городе достопр. данного типа
GO
CREATE FUNCTION SightTypeContainedIn (@SyghtType VARCHAR(100), @CityName VARCHAR(100)) 
RETURNS BIT 
AS 
BEGIN
	IF ((SELECT Count(SightType_ID) FROM Sight WHERE Sight.City_ID = (SELECT City_ID FROM City Where City.Name = 'Irkutsk') AND SightType_ID = (SELECT SightType_ID FROM Sight_Type Where Sight_Type.Name = 'Lae')) = 0)
		RETURN 0;
	RETURN 1
END;
----------------------------------------------------------
-- Представления
----------------------------------------------------------
-- Вывод достопр. сгруппированных по стране и городу
GO
CREATE VIEW CountryCitySight(Страна, Город, Достопримечательность)
AS SELECT Country.Name, City.Name, Sight.Name FROM Country 
JOIN City ON Country.Country_ID=City.Country_ID
JOIN Sight ON City.City_ID = Sight.City_ID;
-- Вывод всех допстопр. сгруппированных по типу
GO
CREATE VIEW SightTypeSights (Тип, Название)
AS SELECT Sight_Type.Name, Sight.Name FROM Sight_Type
JOIN Sight ON Sight.SightType_ID = Sight_Type.SightType_ID
GROUP BY Sight_Type.Name, Sight.Name;
-- Вывод стран и языков в них используемых
GO
CREATE VIEW CountryLanguageVIEW (Страна, Язык)
AS SELECT Country.Name AS Country, Language.Name AS Language FROM Country
JOIN CountryLanguage ON Country.Country_ID = CountryLanguage.Country_ID
JOIN Language ON CountryLanguage.Language_ID = Language.Language_ID 
GROUP BY Country.Name, Language.Name;
-- Вывод представлений
--SELECT * FROM SightTypeSights
--SELECT * FROM CountrySight
--SELECT * FROM CountryLanguageVIEW
-- Удаление
--DROP VIEW CountryCitySight;
--DROP VIEW SightTypeSights;
--DROP VIEW CountryLanguageVIEW;
----------------------------------------------------------
-- Тригеры 
----------------------------------------------------------
GO
CREATE TRIGGER Continent_INSERT
ON Continent
INSTEAD OF INSERT
AS
 PRINT 'Sorry, continents are immovable';

GO
CREATE TRIGGER Continent_DELETE 
ON Continent
INSTEAD OF DELETE 
AS
 PRINT 'Sorry, continents are immovable';

GO
CREATE TRIGGER Continent_UPDATE
ON Continent
INSTEAD OF UPDATE
AS
 PRINT 'Sorry, continents are immovable';
----------------------------------------------------------
-- Индексы
----------------------------------------------------------
CREATE INDEX index_coutry ON Country (Name)
CREATE INDEX index_language ON Language (Name)
CREATE INDEX index_city ON City (Name)
----------------------------------------------------------
-- Удаление процедур
----------------------------------------------------------
--DROP PROCEDURE AddCountry;
--DROP PROCEDURE AddCity;
--DROP PROCEDURE AddLanguage;
--DROP PROCEDURE JoinCountryLanguage;
--DROP PROCEDURE AddSightType;
--DROP PROCEDURE AddSight;
--DROP PROCEDURE SowSightsOf;
----------------------------------------------------------
-- Удаление таблиц
----------------------------------------------------------
--DROP TABLE Sight;
--DROP TABLE Sight_Type;
--DROP TABLE City;
--DROP TABLE CountryLanguage;
--DROP TABLE Language;
--DROP TABLE Country;
--DROP TABLE Continent;
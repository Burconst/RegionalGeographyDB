-- CREATE DATABASE Regional_geography_db;
-- GO
-- USE Regional_geography_db;

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

--

INSERT INTO Continent(Name) VALUES ('Европа')
INSERT INTO Continent(Name) VALUES ('Азия')
INSERT INTO Continent(Name) VALUES ('Евразия')
INSERT INTO Continent(Name) VALUES ('Антарктида')
INSERT INTO Continent(Name) VALUES ('Австралия')
INSERT INTO Continent(Name) VALUES ('Южная Америка')
INSERT INTO Continent(Name) VALUES ('Северная Америка')
INSERT INTO Continent(Name) VALUES ('Африка')

--------------------------------------------------------------------------
-- Процедуры 
--------------------------------------------------------------------------



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
			PRINT 'Страна '+@Name+' уже существует'
	ELSE
		PRINT 'Нет такого континент: '+@ContinentName
END;


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
			PRINT 'Город '+@Name+' уже существует'
	ELSE 
		PRINT 'Нет такой страны: '+@CountryName
END;


GO
CREATE PROCEDURE AddLanguage
	@Name VARCHAR(100)
AS IF (SELECT COUNT(Language_ID) FROM Language WHERE Name = @Name) = 0
		INSERT INTO Language (Name) VALUES (@Name);
	ELSE 
		PRINT 'Уже содержится: '+@Name;


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
			PRINT 'Языка нет в базе: '+@Language;
	ELSE 
		PRINT 'Страны нет в базе: '+@Country;
END;


GO
CREATE PROCEDURE AddSightType
	@Name VARCHAR(100)
AS
BEGIN 
IF (SELECT COUNT(SightType_ID) FROM Sight_Type WHERE Name = @Name) = 0
		INSERT INTO Sight_Type (Name) VALUES (@Name);
	ELSE 
		PRINT 'Уже содержится: '+@Name;
END;

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
		PRINT 'Нет такого города: '+@CityName;
		RETURN;
	END;
	IF (SELECT COUNT(SightType_ID) FROM Sight_Type WHERE Name = @SightType) = 0
	BEGIN
		PRINT 'Нет такого типа достопримечательности: '+@SightType;
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



----------------------------------------------------------
-- Добавление данных с помощью процедур
----------------------------------------------------------
GO
EXEC AddCountry 'Евразия', 'Россия', 17100000, 146781095

EXEC AddLanguage 'Русский язык'

EXEC JoinCountryLanguage 'Россия','Русский язык'

EXEC AddCity 'Россия', 'Москва', 11920000
EXEC AddCity 'Россия','Санкт-Петербург', 5383968

EXEC AddSightType 'Театр'
EXEC AddSightType 'Музей'
EXEC AddSightType 'Фонтан'
EXEC AddSightType 'Гора'
EXEC AddSightType 'Озеро'

EXEC AddSight 'Мариинский театр', 'Санкт-Петербург', '11:00–19:00', 'Театр', 'Театральная пл., 1, Санкт-Петербург, 190000', 0, 'Театр оперы и балета в Санкт-Петербурге, один из ведущих музыкальных театров России и мира.'



----------------------------------------------------------
-- Представления
----------------------------------------------------------


--



----------------------------------------------------------
-- Удаление таблиц
----------------------------------------------------------
--DROP TABLE Continent;
--DROP TABLE Language;
--DROP TABLE CountryLanguage;
--DROP TABLE Country;
--DROP TABLE City;
--DROP TABLE Sight_Type;
--DROP TABLE Sight;

--

-- CREATE DATABASE Regional_geography_db;
-- GO
-- USE Regional_geography_db;

------------------------------------------------------
--Создание таблиц и PK, FK
------------------------------------------------------
CREATE TABLE Continent (
	Continent_ID INT IDENTITY NOT NULL,
	Name VARCHAR(50) NOT NULL,
	CONSTRAINT Continent_PK PRIMARY KEY(Continent_ID) 
)

CREATE TABLE Country (
	Continent_ID INT NOT NULL,
	Country_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	Total_Area INT NOT NULL,
	Population_Size INT NOT NULL,
	CONSTRAINT Country_PK PRIMARY KEY (Country_ID),
	FOREIGN KEY (Continent_ID)  REFERENCES Continent (Continent_ID)
)

CREATE TABLE CountryLanguage(
	ID INT NOT NULL,
	Country_ID INT NOT NULL,
	Language_ID INT NOT NULL,
	CONSTRAINT CountryLanguage_PK PRIMARY KEY (ID),
	FOREIGN KEY (Country_ID) REFERENCES Country (Country_ID),
	FOREIGN KEY (Language_ID) REFERENCES Language (Language_ID)
)

CREATE TABLE Language(
	Language_ID INT NOT NULL,
	Name VARCHAR(50) NOT NULL,
	CONSTRAINT Language_FK PRIMARY KEY (Language_ID)
)

CREATE TABLE City (
	Country_ID INT NOT NULL,
	City_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	Population_Size INT NOT NULL,
	CONSTRAINT City_PK PRIMARY KEY (City_ID),
	FOREIGN KEY (Country_ID)  REFERENCES Country (Country_ID)
)

CREATE TABLE Sight (
	Sight_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	City_ID INT NOT NULL,
	OpeningHours VARCHAR(100) NOT NULL,
	SightType_ID INT NOT NULL,
	Address VARCHAR(200) NOT NULL,
	Description VARCHAR(200),
	CONSTRAINT City_Sight_PK PRIMARY KEY (City_Sight_ID),
	FOREIGN KEY (City_ID)  REFERENCES City (City_ID),
	FOREIGN KEY (SightType_ID)  REFERENCES Sight_Type (SightType_ID)
)

CREATE TABLE Sight_Type (
	SightType_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	CONSTRAINT SightType_PK PRIMARY KEY (SightType_ID)
)

--





----------------------------------------------------------
-- Удаление таблиц
----------------------------------------------------------
DROP TABLE Continent;
DROP TABLE Country;
DROP TABLE City;
DROP TABLE Sight;
DROP TABLE Sight_Type;
DROP TABLE CountryLanguage;
DROP TABLE Language;
--

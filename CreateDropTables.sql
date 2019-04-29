-- CREATE DATABASE Regional_geography_db;
-- GO
-- USE Regional_geography_db;

------------------------------------------------------
--Создание таблиц и PK
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
	State_Languages VARCHAR(50) NOT NULL,
	Total_Area INT NOT NULL,
	Population_Size INT NOT NULL,
	CONSTRAINT Country_PK PRIMARY KEY (Country_ID)
)

CREATE TABLE City (
	Country_ID INT NOT NULL,
	City_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	Population_Size INT NOT NULL,
	CONSTRAINT City_PK PRIMARY KEY (City_ID)
)

CREATE TABLE City_sight (
	City_Sight_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	City_ID INT NOT NULL,
	OpeningHours VARCHAR(100) NOT NULL,
	CitySightType_ID INT NOT NULL,
	Address VARCHAR(200)
	CONSTRAINT City_Sight_PK PRIMARY KEY (City_Sight_ID)
)

CREATE TABLE Natural_Sight (
	Nearest_City_ID INT NOT NULL,
	Name VARCHAR(100) NOT NULL,
	SightType_ID INT NOT NULL,
	IsUNESCO BIT NOT NULL,
	Main_Characteristic_ID INT,
)

CREATE TABLE Natural_Sight_Type (
	SightType_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	CONSTRAINT SightType_PK PRIMARY KEY (SightType_ID)
)

CREATE TABLE City_Sight_Type (
	CitySightType_ID INT IDENTITY NOT NULL,
	Name VARCHAR(100) NOT NULL,
	CONSTRAINT CitySightType_PK PRIMARY KEY (CitySightType_ID)
)

CREATE TABLE UniqueCharacteristic (
	Characteristic_ID INT IDENTITY NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Value INT NOT NULL,
	CONSTRAINT Characteristic_PK PRIMARY KEY (Characteristic_ID)
)
--

----------------------------------------------------------
-- Создание FK
----------------------------------------------------------





----------------------------------------------------------
-- Удаление таблиц
----------------------------------------------------------
DROP TABLE Continent;
DROP TABLE Country;
DROP TABLE City;
DROP TABLE City_sight;
DROP TABLE Natural_Sight;
DROP TABLE Sight_Type;
DROP TABLE City_Sight_Type;
DROP TABLE UniqueCharacteristic;
--
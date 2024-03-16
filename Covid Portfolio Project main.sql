select*
From [Covid portfolio project ].[dbo].[Covid Deaths]
Order by 3,4 

--select*
--From [Covid portfolio project ].[dbo].[Covid Vaccinations]
--order by 3,4

-- Select the data that we are going to be using 
select location, date,total_cases,new_cases,total_deaths,population_density
From [Covid portfolio project ].[dbo].[Covid Deaths]
Order by 1,2

--Looking at the total cases vs total deaths 
--- Shows the likelihood of dying if you contact covid in your country 
SELECT location, 
       date, 
       CAST(total_cases AS FLOAT) AS total_cases, 
       CAST(total_deaths AS FLOAT) AS total_deaths, 
       (CAST(total_deaths AS FLOAT) * 100.0 / CAST(total_cases AS FLOAT)) AS DeathPercentage
FROM [Covid portfolio project].[dbo].[Covid Deaths]
WHERE location LIKE '%United Kingdom%'
ORDER BY 1,2;

-- Looking at the total cases vs the population
-\
--- shows the percentage of the population that got covid 
SELECT location, 
       date, 
       CAST(total_cases AS FLOAT) AS total_cases, 
       CAST(population_density AS FLOAT) AS population_density, 
       (CAST(total_cases AS FLOAT) * 100.0 / CAST(Population_density AS FLOAT)) AS DeathPercentage
FROM [Covid portfolio project].[dbo].[Covid Deaths]
WHERE location LIKE '%United Kingdom%'
ORDER BY 1,2 

--Looking at countries with highest infection rate compared to population 

SELECT location, 
       MAX(total_cases) AS max_total_cases, 
       MAX(population_density) AS max_population_density,
       (MAX(total_cases) / MAX(population_density)) * 100 AS HighestInfection
FROM [Covid portfolio project].[dbo].[Covid Deaths]
GROUP BY location
ORDER BY HighestInfection deSC;

--Showing the countries with the highest death counts per population   

SELECT location, 
       MAX(CAST(total_deaths AS FLOAT)) AS max_Highest_deaths
FROM [Covid portfolio project].[dbo].[Covid Deaths]
Where continent is not null 
GROUP BY location
ORDER BY max_Highest_deaths DESC;

--Breaking it by continent 
SELECT location, 
       MAX(CAST(total_deaths AS FLOAT)) AS max_Highest_deaths
FROM [Covid portfolio project].[dbo].[Covid Deaths]
WHERE continent IS NULL 
GROUP BY location
ORDER BY max_Highest_deaths DESC;

--Showing the continents with the highest death counts 

select*
From [Covid portfolio project ].[dbo].[Covid Deaths]
Order by 3,4 

--select*
--From [Covid portfolio project ].[dbo].[Covid Vaccinations]
--order by 3,4

-- Select the data that we are going to be using 
select location, date,total_cases,new_cases,total_deaths,population_density
From [Covid portfolio project ].[dbo].[Covid Deaths]
Order by 1,2

--Looking at the total cases vs total deaths 
--- Shows the likelihood of dying if you contact covid in your country 
SELECT location, 
       date, 
       CAST(total_cases AS FLOAT) AS total_cases, 
       CAST(total_deaths AS FLOAT) AS total_deaths, 
       (CAST(total_deaths AS FLOAT) * 100.0 / CAST(total_cases AS FLOAT)) AS DeathPercentage
FROM [Covid portfolio project].[dbo].[Covid Deaths]
WHERE location LIKE '%United Kingdom%'
ORDER BY 1,2;

-- Looking at the total cases vs the population
-\
--- shows the percentage of the population that got covid 
SELECT location, 
       date, 
       CAST(total_cases AS FLOAT) AS total_cases, 
       CAST(population_density AS FLOAT) AS population_density, 
       (CAST(total_cases AS FLOAT) * 100.0 / CAST(Population_density AS FLOAT)) AS DeathPercentage
FROM [Covid portfolio project].[dbo].[Covid Deaths]
WHERE location LIKE '%United Kingdom%'
ORDER BY 1,2 

--Looking at countries with highest infection rate compared to population 

SELECT location, 
       MAX(total_cases) AS max_total_cases, 
       MAX(population_density) AS max_population_density,
       (MAX(total_cases) / MAX(population_density)) * 100 AS HighestInfection
FROM [Covid portfolio project].[dbo].[Covid Deaths]
GROUP BY location
ORDER BY HighestInfection deSC;

--Showing the countries with the highest death counts per population   

SELECT location, 
       MAX(CAST(total_deaths AS FLOAT)) AS max_Highest_deaths
FROM [Covid portfolio project].[dbo].[Covid Deaths]
Where continent is not null 
GROUP BY location
ORDER BY max_Highest_deaths DESC;

--Breaking it by continent (Showing the continents with the highest death counts)
SELECT continent, 
       MAX(CAST(total_deaths AS FLOAT)) AS max_Highest_deaths
FROM [Covid portfolio project].[dbo].[Covid Deaths]
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY max_Highest_deaths DESC;

--Global Numbers 
SELECT
       date,
       SUM(new_cases) AS total_cases,
       SUM(CAST(new_deaths AS int)) AS total_deaths,
       CASE WHEN SUM(new_cases) = 0 THEN 0 ELSE SUM(CAST(new_deaths AS int)) / SUM(new_cases) * 100 END AS DeathPercentage 
FROM [Covid portfolio project].[dbo].[Covid Deaths]
WHERE continent is NULL
GROUP BY date
ORDER BY DATE desc;


--Covid Vaccinations Data set 

Select*
From [Covid portfolio project ].dbo.[Covid Vaccinations]

--Joining both tables 
SELECT *
FROM [Covid portfolio project].dbo.[Covid Deaths] dea
JOIN [Covid portfolio project].dbo.[Covid Vaccinations] vac
on dea.location = vac.location
and dea.date = vac.date 

--Looking at Total population vs Vaccination
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population_density, 
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS BIGINT)) OVER (PARTITION BY dea.location order by dea.location, dea.date) AS total_new_vaccinations
FROM [Covid portfolio project].dbo.[Covid Deaths] dea
JOIN [Covid portfolio project].dbo.[Covid Vaccinations] vac
ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 1, 2;

















 



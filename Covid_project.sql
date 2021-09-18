--Using DEATHS table--
SELECT * FROM Covid..Covid_deaths;

SELECT location,date,total_cases, new_cases, total_deaths, population 
FROM Covid..Covid_deaths
ORDER BY 1,2;

--Finding death rate in % = (deaths/cases)*100--
SELECT location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 AS death_rate
FROM Covid..Covid_deaths
WHERE location like '%india%'
Order by 1,2 DESC;

--Cases per population in % = (total cases/population)*100
SELECT location,date,total_cases,total_deaths, (total_cases/population)*100 AS infection_rate,(total_deaths/total_cases)*100 AS death_rate
FROM Covid..Covid_deaths
WHERE location like '%india%'
Order by 1,2;

--Highest infection rate
SELECT location,population,MAX(total_cases)as HighestCase,MAX((total_cases/population)*100) AS infection_rate
FROM Covid..Covid_deaths WHERE continent is not null
GROUP BY location,population
ORDER BY population DESC;

--Highest death per population
SELECT location,population,MAX(cast(total_deaths as int)) as TotalDeath, MAX((total_deaths/population)*100) as death_per_population 
FROM Covid..Covid_deaths WHERE continent is not null 
GROUP BY location,population 
ORDER BY TotalDeath DESC;

--Continentwise data death data
SELECT location,population,MAX(cast(total_deaths as int)) as TotalDeath
FROM Covid..Covid_deaths WHERE continent is null 
GROUP BY location,population 
ORDER BY TotalDeath DESC;

--GLobal data--
--Overall cases and deaths
SELECT SUM(new_cases) as totalcases, SUM(cast(total_deaths as int)) as totaldeaths, SUM(cast(total_deaths as int))/SUM(new_cases) as deathpercent
FROM Covid..Covid_deaths WHERE continent is not null
ORDER BY 1;

--date wise case and deaths
SELECT date,SUM(new_cases) as totalcases, SUM(cast(total_deaths as int)) as totaldeaths, SUM(cast(total_deaths as int))/SUM(new_cases) as deathpercent
FROM Covid..Covid_deaths WHERE continent is not null
GROUP BY date
ORDER BY 1;

--Using VACCINATION table--

Select * FROM Covid..Covid_vaccination 
WHERE continent is not null;

--Percentage vaccinated
SELECT dea.location, SUM(dea.population) as Population, SUM(cast(vac.new_vaccinations as int)) as vaccinated, 
MAX(cast(vac.people_fully_vaccinated as int))/MAX(dea.population)*100 as Vaccine_percent
From Covid..Covid_deaths as dea
Join Covid..Covid_vaccination as vac
ON dea.location=vac.location AND dea.date=vac.date
WHERE dea.continent is not null AND dea.continent like '%asia%'
Group by dea.location
Order by Vaccine_percent DESC;
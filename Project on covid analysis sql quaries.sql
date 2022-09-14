Select Location date, total_cases, total_deaths,population
From Deaths

ORDER BY 1,2

--Looking for total cases vs total deaths
--Shows liklelyhood of dying if you contract covid in particular country

Select Location date, total_cases, total_deaths, (total_deaths/total_cases)*100 as PercentagePopulationInfected
From Deaths
Where location like '%india%'
ORDER BY 4 desc

--total cases vs percentage

Select Location date, total_cases, population, (total_deaths/population)*100 as DeathPercentage
From Deaths
Where location like '%india%'
ORDER BY 4 desc

-- countries with highest infection rate compared to population
Select Location date, population, MAX(total_cases) as HighestInfectionCount,  MAX((total_cases/population))*100 as PercentagePopulationInfected
From Deaths
--Where location like '%india%'
Group by Location, Population
Order BY PercentagePopulationInfected desc

--Showing countries with highest deathcount per population
Select Location, MAX(cast (Total_deaths as int )) as TotalDeathCount
From Deaths
--Where location like '%india%'
Where continent is not null
Group by Location
Order bY TotalDeathCount desc

--Showing countinents with highest deathcount per population
Select location, MAX(cast (Total_deaths as int )) as TotalDeathCount
From Deaths
--Where location like '%india%'
Where continent is  null
Group by location
Order bY TotalDeathCount desc

-- Global Numbers

Select   SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths , Sum(cast(new_deaths as int))/Sum (new_cases) *100 as DeathPercntage
From Deaths
where continent is not null
ORDER BY 1,2

-- Looking at total population vs Vaccinations
Select dea.continent,dea.location, dea.date,dea. population, vac.new_vaccinations, SUM(Convert(bigint,vac.new_vaccinations))
OVER( Partition by dea.Location order by dea.location,dea.date) as total

from Deaths  dea
Join vaccinations   vac
On dea.location = vac.location
and dea.date = vac.date

and dea.continent is not null
Where dea.location like '%albania%'



select *
from Deaths  dea
Join vaccinations   vac
On dea.location = vac.location
and dea.date = vac.date

--creating view to store data

create view PopulationVaccinated as
Select dea.continent,dea.location, dea.date,dea. population, vac.new_vaccinations, SUM(Convert(bigint,vac.new_vaccinations))
OVER( Partition by dea.Location order by dea.location,dea.date) as total

from Deaths  dea
Join vaccinations   vac
On dea.location = vac.location
and dea.date = vac.date

and dea.continent is not null

select * from PopulationVaccinated


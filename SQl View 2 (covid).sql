

-- Select the data we are looking at and which we going to use for analysis
-- Most Important in where clause i use argument which says continnent is not null that is because in data set they have beeb already been in group so the data is showing separately for continent

Select location, date, total_cases, new_cases,total_deaths, population
From [Portfolio project (Covid)]..CovidDeaths$
Order by 1, 2;

-- Looking at total cases vs total deaths for India

Select location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 As Death_Percentage
From [Portfolio project (Covid)]..CovidDeaths$
Where location like '%india%'
and continent is not null
Order by 1, 2

--Looking at total cases vs total deaths for whole world

Select location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 As Death_Percentage
From [Portfolio project (Covid)]..CovidDeaths$
--Where location like '%india%'
where continent is not null
Order by 1, 2


--Looking at total cases vs population
--Shows what percentage of population got covid

Select location, date, total_cases,population, (total_cases/population)*100 As case_Percentage
From [Portfolio project (Covid)]..CovidDeaths$
--Where location like '%india%'
where continent is not null
Order by 1, 2

--looking at ountry with highest infection rate compared to population

Select location, population, Max(total_cases) as highest_infection_count , MAx((total_cases/population))*100 As Percentage_population_effect
From [Portfolio project (Covid)]..CovidDeaths$
--Where location like '%india%'
where continent is not null
group by location, population
Order by Percentage_population_effect desc;

--Death rate for India for COvid innfection people
select location,  population, Max((total_deaths/total_cases))*100 as Death_rate
from [Portfolio project (Covid)]..CovidDeaths$
where location = 'India'
and continent is not null
Group by location, population

-- Showing countries with highest death count

Select location, MAX(Cast(total_deaths as int)) As Death_count
From [Portfolio project (Covid)]..CovidDeaths$
--Where location like '%india%'
where continent is not null
group by location
Order by Death_count desc;

--LET'S BREAK THIS DATA OR THINGS DOWN TO CONTINENT INSTEAD OF LOCATION



select location, MAX(Cast(total_deaths as int)) As Death_count
From [Portfolio project (Covid)]..CovidDeaths$
--Where location like '%india%'
where continent is  null
group by location
Order by Death_count desc;

select continent, MAX(Cast(total_deaths as int)) As Death_count
From [Portfolio project (Covid)]..CovidDeaths$
--Where location like '%india%'
where continent is not  null
group by continent
Order by Death_count desc;


--GLobal Numbers 

Select  SUM(new_cases)as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as death_percent
From [Portfolio project (Covid)]..CovidDeaths$
--Where location like '%india%'
where continent is not null
--group by date
Order by 1, 2

Select dea.location,dea.continent,dea.date,dea.population, vac.new_vaccinations
,SUM(Cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location Order by dea.location, dea.date) as RollingPeopleVAccinated 
From [Portfolio project (Covid)]..CovidDeaths$ as dea
join [Portfolio project (Covid)]..CovidVaccinations$ as vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
order by  2,3

-- USe Cte we have to define column as well without data type

With popvsvac (Continent, Location, date, population, new_vaccination, RollingPeopleVAccinated)
As (Select dea.continent,dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(Cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location Order by dea.location, dea.date) as RollingPeopleVAccinated 
From [Portfolio project (Covid)]..CovidDeaths$ as dea
join [Portfolio project (Covid)]..CovidVaccinations$ as vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
--order by  2,3
)

Select * ,(RollingPeopleVAccinated/population)*100
From popvsvac

--USe Temp Table we have to define the column same as our original query table with data type also

Drop Table if exists #percentagepopulationvaccinated
Create Table #percentagepopulationvaccinated
(
continent nvarchar(255), 
location nvarchar(255) ,
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVAccinated numeric
)
Insert Into #percentagepopulationvaccinated
Select dea.continent,dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(Cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location Order by dea.location, dea.date) as RollingPeopleVAccinated
From [Portfolio project (Covid)]..CovidDeaths$ as dea
join [Portfolio project (Covid)]..CovidVaccinations$ as vac
on dea.location = vac.location and dea.date = vac.date
--where dea.continent is not null
--order by  2,3;

Select * ,(RollingPeopleVAccinated/population)*100
from #percentagepopulationvaccinated


--creating view to store data vefore visuialization

Create view percentagepopulationvaccinated as
Select dea.continent,dea.location, dea.date,dea.population, vac.new_vaccinations
,SUM(Cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location Order by dea.location, dea.date) as RollingPeopleVAccinated
From [Portfolio project (Covid)]..CovidDeaths$ as dea
join [Portfolio project (Covid)]..CovidVaccinations$ as vac
on dea.location = vac.location and dea.date = vac.date
where dea.continent is not null
--order by  2,3;

Select *
From percentagepopulationvaccinated


---Queries used for Tableau Project

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [Portfolio project (Covid)]..CovidDeaths$
where continent is not null 
order by 1,2

---- numbers are extremely close so we will keep them - The Second includes "International"  Location
--nO 1 ) 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [Portfolio project (Covid)]..CovidDeaths$
where location = 'World'
order by 1,2

-- NO 2) 
-- We take these out as they are not inCluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From [Portfolio project (Covid)]..CovidDeaths$
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc

--No 3) 

Select Location, Population, date ,MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio project (Covid)]..CovidDeaths$
--Where location like '%states%'
Group by Location, Population,date
order by PercentPopulationInfected desc


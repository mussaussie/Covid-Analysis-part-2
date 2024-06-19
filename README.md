# Part 2: Analyzing COVID-19 Data with SQL

## Overview
This part of the project involves analyzing the COVID-19 data stored in the `CovidDeaths` and `CovidVaccinations` tables within the `Portfolio project (Covid)` database. The analysis includes examining total cases, deaths, and vaccination rates across different locations, and comparing infection and death rates globally and for specific regions.

## Steps

### 1. Initial Data Selection
- Selected the data from the `CovidDeaths` table to understand its structure and contents.

### 2. Total Cases vs. Total Deaths for India
- Calculated the death percentage for India to understand the severity of the pandemic in the country.

### 3. Total Cases vs. Total Deaths Globally
- Analyzed the death percentage globally to compare it with India's data.

### 4. Total Cases vs. Population
- Evaluated the percentage of the population that got COVID-19 to assess the spread of the virus.

### 5. Highest Infection Rate Compared to Population
- Identified the country with the highest infection rate to understand which region was most affected.

### 6. Death Rate for India
- Calculated the death rate for COVID-19 in India to get a more specific understanding of its impact.

### 7. Countries with Highest Death Count
- Listed countries with the highest death count to identify the most affected regions.

### 8. Breaking Data Down to Continent Level
- Compared data at the continent level for a broader analysis:
  - Highest death count by location with continent as NULL.
  - Highest death count by continent.

### 9. Global Numbers
- Calculated total cases and deaths globally to understand the overall impact of the pandemic.

### 10. Vaccination Data Analysis
- Analyzed vaccination data by joining the `CovidDeaths` and `CovidVaccinations` tables:
  - Examined rolling vaccination data to track progress over time.

### 11. Using CTE for Rolling Vaccination Data
- Defined a Common Table Expression (CTE) to simplify queries and manage rolling vaccination data.

### 12. Using Temporary Tables
- Created and utilized temporary tables to store intermediate results for complex queries.

### 13. Creating Views
- Created views to store cleaned and processed data, making it easier for visualization and further analysis.

## Conclusion
This project provided a comprehensive analysis of the COVID-19 pandemic, focusing on case counts, death rates, and vaccination progress. By using SQL for data cleaning and analysis, we were able to derive meaningful insights and prepare the data for visualization in tools like Tableau.

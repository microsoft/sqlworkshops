/* Get some general information about the data in the WWI OLTP system */
USE WideWorldImporters;
GO

/* Show the Populations. 
Where do we have the most people?
 */
SELECT TOP 10 CityName as 'City Name'
, StateProvinceName as 'State or Province'
, sp.LatestRecordedPopulation as 'Population'
, CountryName
FROM Application.Cities AS city
JOIN Application.StateProvinces AS sp ON
    city.StateProvinceID = sp.StateProvinceID
JOIN Application.Countries AS ctry ON 
    sp.CountryID=ctry.CountryID
ORDER BY Population, CityName;
GO
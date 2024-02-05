select * from Shark

-- TOTAL NO. OF EPISODES IN SHARK TANK

select count(distinct(Episode)) as Episodes from Shark

-- total no. of brands

select count(Distinct(Brand)) as Total_Brand from Shark

-- brands that got funding out of total
-- here we are taking from two different query from same table

select a.Pitch, b.Funding from
(select count([Amount Invested lakhs]) Pitch from Shark) a,
(select count([Amount Invested lakhs]) Funding from Shark where [Amount Invested lakhs] NOT IN (0)) b

select ROUND(CAST(b.Funding AS FLOAT)/CAST(a.Pitch AS FLOAT),2) AS funding_percent from
(select count([Amount Invested lakhs]) Pitch from Shark) a,
(select count([Amount Invested lakhs]) Funding from Shark where [Amount Invested lakhs] NOT IN (0)) b

-- SELECT TOTAL NO. OF MALE FROM DATA
SELECT sum(Male) as Total_Male from Shark

-- SELECT TOTAL NO. OF FEMALE FROM DATA
SELECT sum(Female) as Total_Female from Shark

--gender ratio

SELECT sum(Female)/sum(Male) as Percent_of_M_F from Shark

--total invested amount by location

select Location, sum([Amount Invested lakhs]) Total_funding from Shark
where Location is not NULL 
group by Location

-- average of equity taken(avg of equity without zero)


select ROUND(avg(a.[Equity Taken %]),2) as AVG_equity from
(select * from Shark where [Equity Taken %] not in (0))a

--HIGHEST DEAL TAKEN

select max([Amount Invested lakhs]) max_amount_invested from Shark

-- startups having female

select Brand, Female from Shark where Female > 0

-- pitches who got funding and having atleast one female

select sum(Female)
from (select * from Shark where Female > 0 and [Amount Invested lakhs]>0) a

--select location with most brands and order them in desc 

select * from shark

select Location, Count(Brand) Brands from shark 
group by Location
order by Brands Desc

--select Sectors of startup with most count and order them in desc 

select Sector, Count(Sector) Sectors from shark 
group by Sector
order by Sectors Desc

--partners

select partners, Count(Partners) sharks_Invested from Shark
where Partners not in ('-')
group by partners order by sharks_Invested Desc

-- ashneer invested

-- Rank the startup as per they got funding and also display sector

select Location, Brand, Sector, [Amount Invested lakhs],   
row_number() over (partition by sector order by [Amount Invested lakhs] desc) rnk from shark

select Location, Brand, Sector, [Amount Invested lakhs],   
rank() over (partition by sector order by [Amount Invested lakhs] desc) rnk from shark

select Location, Brand, Sector, [Amount Invested lakhs],   
dense_rank() over (partition by sector order by [Amount Invested lakhs] desc) rnk from shark

-- partion by practice query

select Sector, Count(Location) over (partition by Sector) Location_count from Shark

Select sector, sum([Amount Invested lakhs]) over (partition by Sector) Location_count from Shark

Select sector, sum([Amount Invested lakhs]) from Shark
group by Sector

-- in case we have to use the aggregate function then only group by in usefull
--else for rank and dense rank and row num the partition by is useful



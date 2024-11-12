---Sales Data Analysis 

--PROFIT ANALYSIS
	
select sum(profit)
as total_profit 
from brew_data;

select 
    sum(case 
            when countries in ('nigeria', 'ghana') then profit 
            else 0 
        end) as anglophone_territories,
    sum(case 
            when countries in ('senegal', 'togo', 'benin') then profit 
            else 0 
        end) as francophone_territories
from brew_data;

select years, 
sum(profit) as total_profit
from brew_data
group by years
order by total_profit desc;

select months, sum(profit) as total_profit_by_months, 
avg(profit) as avg_profit_by_months
from brew_data
group by months
order by total_profit_by_months desc;


select countries, sum(profit)as total_profit_by_countries
from brew_data
group by countries
order by total_profit_by_countries desc;

select top 1
        countries,
        sum(profit) as total_profit_2019
    from brew_data
    where years = 2019
	group by countries
    order by total_profit_2019 desc;

 select top 1
        years,
        sum(profit) as year_with_highest_total_profit
    from brew_data
	group by years
order by year_with_highest_total_profit desc;

	select top 1
	months,
	sum(profit) as month_with_least_profit
	from brew_data
	group by months
	order by month_with_least_profit asc;

	select months, years,
	min(profit) as min_profit_dec_2018
	from brew_data
	where months = 'december'
	and years = 2018
	group by months, years;
	
	select months,
 sum(profit) * 100.0 / sum(sales) as '2019_monthly_profit_percentage'
from brew_data
where years = 2019
group by months
order by '2019_monthly_profit_percentage';
	
	select top 1
	brands,
	sum(profit) as brand_with_highest_profit_senegal
	from brew_data
	where countries ='senegal'
	group by brands
	order by brand_with_highest_profit_senegal desc;

---SALES TEAM ANALYSIS

select sales_rep,
sum(quantity) as total_quantity,
sum(sales) as total_sales 
from brew_data
group by sales_rep
order by total_sales desc;

select sales_rep,
sum(sales) as total_sales,
count(sales_id) as total_deals,
avg(sales) as avg_sales
from brew_data
group by sales_rep
order by total_sales desc;

select sales_rep, brands, 
sum(sales) as total_sales,
count(sales_id) as total_deals
from brew_data
group by sales_rep, brands
order by total_sales desc;

select sales_rep, countries, 
count(sales_id) as total_deals,
sum(sales) as country_sales
from brew_data
group by sales_rep, countries
order by country_sales desc;

select sales_rep, countries, 
count(sales_id) as total_deals,
sum(sales) as total_sales
from brew_data
group by sales_rep, countries
order by total_sales desc;

select sales_rep, countries, count(sales_id) as total_deals,
sum(sales) as country_sales from brew_data
group by sales_rep, countries
order by country_sales desc;

---BRAND AND TERRITORY ANALYSIS

alter table brew_data
add territories varchar (50) default null;

update brew_data
set territories = case 
    when countries = 'nigeria' then 'anglophone_territories'
    when countries = 'ghana' then 'anglophone_territories'
    else 'francophone_territories'
end; 
 
 select top 3
    brands,
    sum(quantity) as total_quantity
from brew_data
where territories = 'francophone_territories' 
    and years in ('2018', '2019') 
group by brands 
order by total_quantity desc; 

select brands, sum(profit) as total_profit_brands
from brew_data
group by brands
order by total_profit_brands desc; 

select brands, countries, sum(quantity) as total_quantities_sold
from brew_data
group by brands, countries
order by total_quantities_sold desc;

select brands, countries, total_quantities_sold, total_profit 
from (
select countries, brands, sum(quantity) as total_quantities_sold, sum(profit) as total_profit,
row_number() over (partition by countries order by sum(quantity) desc) as number
from brew_data
group by countries, brands)
as top_ranked_brands
where number = 1;

select top 2
brands,
sum(quantity) as total_quantity
from brew_data
where countries = 'ghana'
group by brands
order by total_quantity desc;
 
select brands, 
  sum(quantity) as total_units_purchased
  from brew_data
  where countries = 'nigeria'
  group by brands
  order by total_units_purchased desc;
  

select top 1 brands,
	sum(quantity) as top_malt_anglophone
	from brew_data
	where brands in ('beta malt', 'grand malt')
	and years in ('2018', '2019')
	and territories = 'anglophone_territories'
	group by brands
	order by top_malt_anglophone desc;

select top 1
brands,
sum(quantity) as '2019_top_brand'
from brew_data
where countries = 'nigeria'
and years= 2019
group by brands
order by '2019_top_brand' desc;

select top 1
brands,
sum(quantity) as favourite_brands_southsouth_nigeria
from brew_data
where region = 'southsouth'
and countries = 'nigeria'
group by brands
order by favourite_brands_southsouth_nigeria desc;

select sum(quantity) as beer_consumption_nigeria
from
    brew_data
where
    brands not like '%malt'
    and countries = 'nigeria';

select brands,
sum(quantity) as budweiser_consumption_nigeria
from brew_data
where brands = 'budweiser'
and countries = 'nigeria'
group by brands;

select region,
sum(quantity) as '2019_budweiser_consumption_nigeria'
from brew_data
where brands = 'budweiser'
and years = '2019'
and countries = 'nigeria'
group by region
order by '2019_budweiser_consumption_nigeria' desc;

---COUNTRY ANALYSIS

select countries, COUNT(SALES_ID) as Order_by_Countries
from BREW_DATA
group by COUNTRIES
order by Order_by_Countries desc;

select countries, sum(quantity) as total_quantities_by_countries
from brew_data
group by countries
order by total_quantities_by_countries desc;

select countries, brands, count(sales_id) as total_orders, 
sum(quantity) as total_quantity, avg(quantity) as avg_quantity_per_order
from brew_data
group by countries, brands
order by total_quantity desc;

select
top 1 countries,
sum(quantity) as country_with_beer_highest_consumption
from brew_data
where brands not like '%malt'
group by countries
order by country_with_beer_highest_consumption desc;

select top 1 sales_rep,
sum(quantity) as sales_rep_with_highest_sales
from brew_data
where countries = 'senegal'
and brands = 'budweiser'
group by sales_rep
order by sales_rep_with_highest_sales desc;

select top 1 countries,
sum(profit) as country_with_highest_profit_4th_quarter_2019
from brew_data
where months in('october', 'november', 'december')
and years = '2019'
group by countries
order by country_with_highest_profit_4th_quarter_2019 desc;


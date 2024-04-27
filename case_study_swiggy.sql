use grow_sql;
select * from swiggy;
-- HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?
select distinct restaurant_name as high_rated_resturant
from swiggy where rating>4.5;
-- 13 restaurants have the rating greater than 4.5.

-- WHICH IS THE TOP CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?
select city,count(distinct restaurant_name) as restaurant_count
from swiggy
group by city
order by restaurant_count desc;
-- BANGALORE city has the highest number number of restaurants.

-- HOW MANY RESTAURANTS SELL( HAVE WORD "PIZZA" IN THEIR NAME)?
select distinct restaurant_name from swiggy where restaurant_name like '%Pizza%';
-- Total 4 reatuarnats have the word Pizza with there name such as "Pizza Hut , Oven Story Pizza , Domino's Pizza , Sams Pizza",

-- WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS ?
select cuisine ,count(*) as cuisine_count  from swiggy
group by cuisine
order by cuisine_count desc limit 10;
-- North Indian,Chinese is the common cuisine among the retaurants.

-- WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?
 select city,avg(rating) as avg_rating from swiggy
 group by city;
 -- Average rating in Bangalore is 4.11510 and in Ahemdabad is 4.06864.alter
 
 -- WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU  CATEGORY FOR EACH RESTAURANT?
 select distinct restaurant_name,menu_category,item,max(price) as highest_price from swiggy 
 where menu_category='recommended'
 group by restaurant_name limit 5;
 -- Tandoor Hut is the resturant and the item is Dal Tadka which has the highest price under the recommended menu category.
 
 -- FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER  THAN INDIAN CUISINE.
 select distinct restaurant_name,cost_per_person from swiggy where cuisine<>"Indian"
 order by cost_per_person desc limit 5;
 -- "China Pearl, Anupam's Coast II Coast, Chinita Real Mexican Food, Once Upon a Flame, Parika" are the expensive resturants.
 
 -- FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.
 select distinct restaurant_name,cost_per_person from swiggy where cost_per_person > (select avg(cost_per_person) from swiggy);
 
 -- RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.
 select distinct s1.restaurant_name,s1.city,s2.city from swiggy as s1 join 
 swiggy as s2  on s1.restaurant_name = s2.restaurant_name and s1.city <> s2.city;
 
 -- WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE' CATEGORY?
 select distinct restaurant_name,count(distinct item) as count_item from swiggy
 where menu_category="MAIN COURSE" group by restaurant_name
 order by count_item desc;
 
 -- LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME.
select distinct restaurant_name,
(count(case when veg_or_nonveg="Veg" then 1 end)/count(*)*100) 
as vegeterian_percentage
from swiggy group by restaurant_name
having vegeterian_percentage=100.00
order by restaurant_name;

-- WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?
select distinct restaurant_name,avg(price) as avg_price
from swiggy group by restaurant_name 
order by avg_price;

-- WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?
select distinct restaurant_name,count(distinct menu_category) as category_count
from swiggy
group by restaurant_name
order by category_count desc limit 5;

-- WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?
select distinct restaurant_name,
(count(case when veg_or_nonveg="Non-veg" then 1 end)/count(*)*100) 
as Non_vegeterian_percentage
from swiggy group by restaurant_name
order by Non_vegeterian_percentage desc limit 5;
 
-- DETERMINE MOST AND LEAST EXPENSIVE CITIES FOR DINING. 
select city,sum( distinct cost_per_person) as total_expense from swiggy group by city order by total_expense desc; 
-- OR 
/* with cityExpense as(
select city,max(cost_per_person) as max_cost,min(cost_per_person) as min_cost
from swiggy group by city)
select city,max_cost,min_cost from cityExpense order by max_cost desc;
*/

-- FIND TOP 2 RATED RESTAURANT IN EACH CITY. 
with RatingRankByCity As(
select distinct restaurant_name,city,rating,DENSE_RANK() over(partition by city order by rating desc) as rating_rank
from swiggy)
select restaurant_name,city,rating,rating_rank from RatingRankByCity where rating_rank=1;


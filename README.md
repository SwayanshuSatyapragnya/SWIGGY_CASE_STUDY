# SWIGGY_CASE_STUDY
The SWIGGY CASE STUDY is simple project which focused on the food delivery services provided by different restaurants that are registered in the SWIGGY platform.

## Table of Contents

- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools Used](#tools-used)
- [Analysis Steps](#analysis-steps)
- [Some measure Analysis with SQL](#some-measure-analysis-with-sql)


### Project Overview

This simple project is used to analyze the important/required KPIs such as "Top City with highest number of restaurants","Common Cuisine among the restaurants ", "Average rating of restaurants in each city " etc.


### Data Sources

The primary data used for this project is "Swiggydata_casestudy.sql" which is completely a script file that contains all the information about all the restaurants, orders, types of food, and customers over which we have performed our analysis.

### Tools Used

- MySQL Workbench: The platform used for running the sql queries and commands to find the key insights.


### Analysis Steps

- Primarily we have loaded the script file that conatins all the information in SSMS platform and executed that file succefully.
- We have started our analysis by excuting quries to find  every possible insights.


### Some measure Analysis with SQL



#### Included some intresting code/features worked with


- WHICH IS THE TOP CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?


 ```sql
  select city,count(distinct restaurant_name) as restaurant_count
        from swiggy
        group by city
        order by restaurant_count desc;
  ```

- HOW MANY RESTAURANTS SELL( HAVE WORD "PIZZA" IN THEIR NAME)?


```sql
select distinct restaurant_name from swiggy where restaurant_name like '%Pizza%';
```

- WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS ?


```sql
select cuisine ,count(*) as cuisine_count  from swiggy
group by cuisine
order by cuisine_count desc limit 10;
```


-  WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?


```sql
select city,avg(rating) as avg_rating from swiggy
 group by city;
```


- WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU  CATEGORY FOR EACH RESTAURANT?


```sql
select distinct restaurant_name,menu_category,item,max(price) as highest_price from swiggy 
 where menu_category='recommended'
 group by restaurant_name limit 5;
```

- WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE' CATEGORY?


```sql
 select distinct restaurant_name,count(distinct item) as count_item from swiggy
 where menu_category="MAIN COURSE" group by restaurant_name
 order by count_item desc;
```


### Conclusion


In this project we have gone throug several different use cases to make better business decision , we have also analyzed the customer trends which will be helpfull for the company to make new and better products and to provide better services to the customers.
 
 - As for our analysis we found that "Bangalore" is the city that has more numbers restaurants than the other cities.
 
 - 13 restaurants are unique as these restaurants have the rating of 4.5
   
 - The 'Hocco Kitchen' is one of the restaurants that offers only and only Vegeterian foods and 'Donne Biriyani House' is the restaurant that offers more numbers of nonveg dishes.

 - 'Urban Kitli' is the restaurant that has lowest price of dishes among all the restaurants.

 - Among all the cuisine North Indian, Chinese cuisine is the most commonly used cuisine. 

use sakila;
#Instructions
#In this lab we will find the customers who were active in consecutive months of May and June. Follow the steps to complete the analysis.

#Create a table rentals_may to store the data from rental table with information for the month of May.
#Insert values in the table rentals_may using the table rental, filtering values only for the month of May.
select * from sakila.rental;
drop table if exists rentals_may; 
create table rentals_may as select *,date_format(rental_date,'%m') as mes from rental
where date_format(rental_date,'%m') = 5; 
select * from sakila.rentals_may;

#Create a table rentals_june to store the data from rental table with information for the month of June.
#Insert values in the table rentals_june using the table rental, filtering values only for the month of June.
select * from sakila.rental;
drop table if exists rentals_june; 
create table rentals_june as select *,date_format(rental_date,'%m') as mes from rental 
where date_format(rental_date,'%m') = 6 ;
select * from sakila.rentals_june;

#Check the number of rentals for each customer for May
select * from  sakila.rentals_may;
select * from sakila.customer;

select count(*) as 'films_rented',rm.customer_id from rentals_may rm 
join customer c on rm.customer_id = c.customer_id
group by rm.customer_id
order by films_rented desc;

#Check the number of rentals for each customer for June
select * from  sakila.rentals_june;
select * from sakila.customer;

select count(*) as 'films_rented',rj.customer_id from rentals_june rj
join customer c on rj.customer_id = c.customer_id
group by rj.customer_id
order by films_rented desc ;








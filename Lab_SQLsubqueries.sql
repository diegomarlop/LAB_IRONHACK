use sakila;
#1. How many copies of the film Hunchback Impossible exist in the inventory system?
select count(*),f.title from sakila.inventory i 
join sakila.film f on i.film_id = f.film_id
where title = 'hunchback impossible' ;

#2.List all films whose length is longer than the average of all the films.
select * from sakila.film;
select title from sakila.film 
where length > (select avg(length) from sakila.film);

#3.Use subqueries to display all actors who appear in the film Alone Trip.
select * from sakila.film_actor;
select * from sakila.film;

select fa.actor_id,f.title from sakila.film_actor fa 
join sakila.film f on fa.film_id = f.film_id
where actor_id in (select actor_id from film_actor
where title ='Alone trip'); 

#4.Sales have been lagging among young families, and you wish to target all family movies for a promotion.
#Identify all movies categorized as family films.
select * from sakila.film;

select title,rating from sakila.film
where rating in (select rating from sakila.film
where rating='g');

#5.Get name and email from customers from Canada using subqueries. Do the same with joins. 
#Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
#that will help you get the relevant information.
select * from sakila.customer;
select * from sakila.country;
select * from sakila.address;
select * from sakila.city;

select email,first_name from sakila.customer 
where address_id in (select address_id from sakila.address
where city_id in (select city_id from sakila.city
where country_id in (select country_id from sakila.country
where country = 'canada')) );

select * from sakila.customer c 
join sakila.address a on c.address_id = a.address_id
join sakila.city ci on a.city_id = ci.city_id
join sakila.country co on ci.country_id = co.country_id
where country = 'canada';

#6. Which are films starred by the most prolific actor? 
#Most prolific actor is defined as the actor that has acted in the most number of films. 
#First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select * from sakila.film_actor;
select * from sakila.film;


select fa.actor_id,f.film_id,rank() over ( order by f.film_id) as ranking from film_actor fa
join film f on fa.film_id = f.film_id;


select actor_id,count(*) as number_of_movies,rank() over(order by count(*)) from film_actor
group by actor_id
order by count(*) desc;

#7. Films rented by most profitable customer. 
#You can use the customer table and payment table to find the most profitable customer 
#ie the customer that has made the largest sum of payments
select * from customer;
select * from payment;
select * from rental;



#8.Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount_spent by each client
select * from payment;

select distinct customer_id,sum(amount) from payment
where amount>(
 select avg(amount) from payment
 )
 group by customer_id;
 

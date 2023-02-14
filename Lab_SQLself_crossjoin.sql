use sakila;
#Lab | SQL Self and cross join

#1.Get all pairs of actors that worked together.
select * from sakila.actor;
select * from sakila.film_actor;

select distinct film.film_id,actor.actor_id from sakila.film_actor actor 
join sakila.film_actor film on actor.actor_id <> film.actor_id
and actor.film_id = film.film_id;


#2.Get all pairs of customers that have rented the same film more than 3 times.
select * from inventory;
select * from rental;
select * from film;

create temporary table tabla_1
select inventory.film_id, rental.customer_id, count(rental.rental_id) as Rentals
from rental
left join inventory on rental.inventory_id = inventory.inventory_id
group by customer_id, film_id
having Rentals >=3;

select * from tabla_1;

select film.title, tabla_1.customer_id, Rentals
from tabla_1
left join film on tabla_1.film_id = film.film_id;

#3.Get all possible pairs of actors and films.
select * from actor;
select * from film_actor;

select * from (select distinct actor_id from actor) sub1
cross join (select distinct film_id from film_actor) sub2
order by actor_id,film_id;

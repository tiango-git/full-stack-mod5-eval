------------------------------------------------------------
/*
 * Customer insertar, modificar y eliminar
 */

INSERT INTO public.customer
(store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active)
VALUES(0, '', '', '', 0, true, 'now'::text::date, now(), 0);

INSERT INTO public.customer
(store_id, first_name, last_name, email, address_id, active)
VALUES(1, 'Pedro', 'Perez', 'pperez@email.com', 1, 1);

-- Obtener último id insertado
SELECT LASTVAL();

UPDATE public.customer
SET store_id=1, first_name='Pedro', last_name='Perez', email='pperez@email.com', address_id=1, active=0
WHERE customer_id=600;

DELETE FROM public.customer
WHERE customer_id=600;

------------------------------------------------------------
/*
 * Staff insertar, modificar y eliminar
 */

INSERT INTO public.staff
(first_name, last_name, address_id, email, store_id, username, "password")
VALUES('Pedro', 'Perez', 1, 'pperez@email.com', 1, 'pperez', '123456');

-- Obtener último id insertado
SELECT LASTVAL();

UPDATE public.staff
SET first_name='Pedro', last_name='Perez', address_id=2, email='pperez@email.com', store_id=2
WHERE staff_id=3;

UPDATE public.staff
SET "password"='qwerty'
WHERE staff_id=3;

DELETE FROM public.staff
WHERE staff_id=3;

------------------------------------------------------------
/*
 * Actor insertar, modificar y eliminar
 */

INSERT INTO public.actor
(first_name, last_name)
VALUES('Pablo', 'Pereira');

-- Obtener último id insertado
SELECT LASTVAL();

UPDATE public.actor
SET first_name='Pablito', last_name='Pereira'
WHERE actor_id=203;

DELETE FROM public.actor
WHERE actor_id=203;


------------------------------------------------------------
/*
 * Listar todas las “rental” con los datos del “customer” dado un año y mes.
 */
select
	to_char(r.rental_date,'YYYY-MM-DD') as rental_date,
	c.first_name,
	c.last_name,
	(r.return_date - r.rental_date) as rental_duration
from
	dvdrental.public.rental r
left outer join dvdrental.public.customer c
	on (c.customer_id = r.customer_id)
where
	to_char(r.rental_date,'YYYYMM') = '200505';
	
------------------------------------------------------------
/*
 * Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
 */
select
	payment_id as número,
	to_char(payment_date,'YYYY-MM-DD') as fecha,
	amount as total
from
	dvdrental.public.payment;

/*
 * Uso de GROUP BY
 * Total de ventas por día y la cantidad de ventas
 */
select
	to_char(payment_date,'YYYY-MM-DD') as fecha,
	SUM(amount) as total,
	COUNT(payment_id) as cantidad
from
	dvdrental.public.payment
group by
	1
order by
	1;

------------------------------------------------------------
/*
 * Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.
*/
select
	title,
	release_year,
	rental_rate
from
	dvdrental.public.film
where
	release_year = 2006
	and rental_rate > 4;

------------------------------------------------------------
/*
 * Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si
 * éstas pueden ser nulas, y su tipo de dato correspondiente.
 */
select
	t1.TABLE_NAME as tabla_nombre,
	t1.COLUMN_NAME as columna_nombre,
	t1.IS_NULLABLE as columna_nulo,
	t1.DATA_TYPE as columna_tipo_dato,
	t1.COLUMN_DEFAULT as columna_defecto
from
	INFORMATION_SCHEMA.COLUMNS t1
inner join PG_CLASS t2 on
	(t2.RELNAME = t1.TABLE_NAME)
where
	t1.TABLE_SCHEMA = 'public'
order by
	t1.TABLE_NAME;
	
------------------------------------------------------------
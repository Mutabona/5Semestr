--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE agencydb;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:l/O4H6bU5yjErCOeb6c5yw==$skrsDLclDQIajWiDedHxSW9Y24hYtSreTOur2rthsKI=:R9+1CNdtlFiL8H0TFJwvZt2fRMR9quOZz2kwdI4ljuA=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "agencydb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: agencydb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE agencydb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE agencydb OWNER TO postgres;

\connect agencydb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    direction_id uuid,
    hotel_id uuid,
    flight_id uuid,
    name character varying(30),
    surname character varying(30),
    booking_date date,
    status character varying(15)
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: directions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(30) NOT NULL,
    country character varying(30) NOT NULL,
    description text,
    popularity double precision
);


ALTER TABLE public.directions OWNER TO postgres;

--
-- Name: flights; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flights (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    number integer NOT NULL,
    departure_date date NOT NULL,
    arrival_date date NOT NULL,
    cost numeric NOT NULL,
    company character varying(30) NOT NULL,
    CONSTRAINT cost_above_zerp CHECK ((cost > (0)::numeric))
);


ALTER TABLE public.flights OWNER TO postgres;

--
-- Name: hotels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hotels (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(30),
    address character varying(50),
    stars integer,
    rating double precision,
    services text
);


ALTER TABLE public.hotels OWNER TO postgres;

--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    booking_id uuid NOT NULL,
    review_text text,
    grade double precision,
    review_date date,
    CONSTRAINT grade_constraint CHECK (((grade >= (0)::double precision) AND (grade <= (10)::double precision)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, direction_id, hotel_id, flight_id, name, surname, booking_date, status) FROM stdin;
248c2eb7-f0ac-4939-9016-e9f09bc9984c	75fb288b-368b-461b-afe5-6318c5576834	40170125-0dbe-4ae8-9dcd-edadcff25d8d	10fa75f0-8dfe-4e8e-bcb4-8f6af92dac75	John	Doe	2024-09-01	Confirmed
61a69990-e77e-40fa-bbdb-aabeb7c29706	faff8b6d-5b9f-48e7-b823-501d7fb16e8d	6c3be25e-685e-4ec5-86ff-cb7caed16e96	a35b451e-8c80-44fc-84c7-016943e46cf2	Jane	Smith	2024-09-02	Pending
5c18f76e-a3fa-431d-adeb-a3a177ce1489	92306ed5-eee0-4a03-a83c-470039c53f8d	87acec1e-56fc-40a0-824e-50e314e71829	9b8b7cd9-af03-44b3-8aca-883775a6fc3a	Alice	Johnson	2024-09-03	Cancelled
c445b8ed-e40d-4858-899e-75bd0a2e8c52	b26ce04a-5c75-4232-9ad9-d83abc175bf7	7f23a9c2-fd42-41df-b753-1232ab102a98	353a3ca6-ea4b-48f4-88e8-9edca9cb5499	Bob	Brown	2024-09-04	Confirmed
63367bb9-4dc5-40ca-af0f-13113673644c	bfcdb054-6606-4b7f-b3fc-4a0e05ecae71	6c8803b5-8e61-4305-8dc3-102384ef35e3	b47cf8ff-3423-4d91-8ebd-022690937d36	Charlie	Davis	2024-09-05	Pending
06035ad5-c6fa-4f87-a41b-e0e7f43578b0	7f015771-d8b6-4cb3-bbe5-f3a820e9db3b	5c6e4eae-d0c1-41f6-8007-64d8dec28f3d	de24664b-b4ca-421d-8f68-d8e576aad1e5	David	Wilson	2024-09-06	Cancelled
0aa170c9-dc7b-4c34-978c-06be67cf4c05	8d59b6df-18a5-40a6-a58b-fe20c512ed9b	2be82b5a-8adf-45f6-b516-363a41dad44e	8e58af11-1701-40ac-93bf-e9127a9b3efa	Eve	Taylor	2024-09-07	Confirmed
54da4a12-b518-4f32-b72d-6cf28be10541	042b23fd-4469-421c-9fd1-2bf55cc156f9	c90dfeaf-bb12-4f98-9dfd-d98a2f2d95d2	cbd4bbce-9005-4758-b64b-ab7e27548aa8	Frank	Anderson	2024-09-08	Pending
a3595444-6ecb-478c-8d92-753b665bc21a	a19f2f32-b3b3-4e52-aa2e-5e8c57beb707	2b016ab0-8ec1-4e3b-bcde-40f6fe886a39	49896826-7247-4a87-9b14-3ef8eec344bb	Grace	Thomas	2024-09-09	Cancelled
12f28bfe-10f5-42fa-9055-04a985301553	da7371d7-fe7f-4cfd-ab9d-379fe06cabc0	650b5539-bfd9-44bf-9327-240e976d1c5e	9853b9ee-589b-4aed-8c8f-467aedbd9439	Hank	Jackson	2024-09-10	Confirmed
8662fc50-7a8b-479a-9afb-ec9015ff8208	6110ac8e-0b6b-4871-b8bd-f23aa845023b	6f48ae8e-9336-4e11-9703-f686195efea3	f3b7613c-59e2-411a-be34-8ec0a253f976	Ivy	White	2024-09-11	Pending
039a80a7-3059-463e-b5b6-403b2a675e2e	70bf92d7-4dee-4bae-821e-6ad2ca6a3f1d	c2dfe10f-c3f3-4fa4-be97-fd767f66f04c	e66131aa-a20b-4c14-9724-52082cf1865c	Jack	Harris	2024-09-12	Cancelled
13552489-7e05-4adb-b4d4-243f3d4da5a0	bd5ebd25-1afd-4594-bc8a-f4a1a0414a85	18294973-9df5-4a88-8415-6e4b3c866a5e	e453bf10-e304-45b9-a3a6-3640d5d68aa7	Karen	Martin	2024-09-13	Confirmed
608af4b4-ea52-4d98-95d6-2b4a71de2dbe	402778c9-38cf-4be0-8a4c-544f078fb341	0c0357e9-dd9f-4c72-9742-d7a92e82c5d5	6c3ba82a-5982-4ad6-b675-f313e47ed0be	Leo	Garcia	2024-09-14	Pending
74c66112-67e1-44f7-8ed0-19d30009baa3	1f8892a1-9243-4867-bce9-faca7f096d5e	595aa6e3-3b09-416f-9843-fe1ca93ca926	720004bf-cbe9-4cc2-a5a6-7b1954d1c660	Mia	Martinez	2024-09-15	Cancelled
\.


--
-- Data for Name: directions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directions (id, name, country, description, popularity) FROM stdin;
75fb288b-368b-461b-afe5-6318c5576834	Paris	France	City of Light	9.8
faff8b6d-5b9f-48e7-b823-501d7fb16e8d	Tokyo	Japan	Land of the Rising Sun	9.5
92306ed5-eee0-4a03-a83c-470039c53f8d	New York	USA	The Big Apple	9.7
b26ce04a-5c75-4232-9ad9-d83abc175bf7	London	UK	Capital of England	9.6
bfcdb054-6606-4b7f-b3fc-4a0e05ecae71	Sydney	Australia	Harbour City	9.4
7f015771-d8b6-4cb3-bbe5-f3a820e9db3b	Rome	Italy	The Eternal City	9.3
8d59b6df-18a5-40a6-a58b-fe20c512ed9b	Berlin	Germany	Capital of Germany	9.2
042b23fd-4469-421c-9fd1-2bf55cc156f9	Bangkok	Thailand	City of Angels	9.1
a19f2f32-b3b3-4e52-aa2e-5e8c57beb707	Dubai	UAE	City of Gold	9
da7371d7-fe7f-4cfd-ab9d-379fe06cabc0	Barcelona	Spain	City of Gaudi	8.9
6110ac8e-0b6b-4871-b8bd-f23aa845023b	Moscow	Russia	Capital of Russia	8.8
70bf92d7-4dee-4bae-821e-6ad2ca6a3f1d	Istanbul	Turkey	City of Two Continents	8.7
bd5ebd25-1afd-4594-bc8a-f4a1a0414a85	Rio de Janeiro	Brazil	Marvelous City	8.6
402778c9-38cf-4be0-8a4c-544f078fb341	Cape Town	South Africa	Mother City	8.5
1f8892a1-9243-4867-bce9-faca7f096d5e	Hong Kong	China	Asia’s World City	8.4
\.


--
-- Data for Name: flights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flights (id, number, departure_date, arrival_date, cost, company) FROM stdin;
10fa75f0-8dfe-4e8e-bcb4-8f6af92dac75	101	2024-10-01	2024-10-02	500.00	Airline A
a35b451e-8c80-44fc-84c7-016943e46cf2	102	2024-10-03	2024-10-04	450.00	Airline B
9b8b7cd9-af03-44b3-8aca-883775a6fc3a	103	2024-10-05	2024-10-06	600.00	Airline C
353a3ca6-ea4b-48f4-88e8-9edca9cb5499	104	2024-10-07	2024-10-08	550.00	Airline D
b47cf8ff-3423-4d91-8ebd-022690937d36	105	2024-10-09	2024-10-10	700.00	Airline E
de24664b-b4ca-421d-8f68-d8e576aad1e5	106	2024-10-11	2024-10-12	650.00	Airline F
8e58af11-1701-40ac-93bf-e9127a9b3efa	107	2024-10-13	2024-10-14	400.00	Airline G
cbd4bbce-9005-4758-b64b-ab7e27548aa8	108	2024-10-15	2024-10-16	750.00	Airline H
49896826-7247-4a87-9b14-3ef8eec344bb	109	2024-10-17	2024-10-18	800.00	Airline I
9853b9ee-589b-4aed-8c8f-467aedbd9439	110	2024-10-19	2024-10-20	850.00	Airline J
f3b7613c-59e2-411a-be34-8ec0a253f976	111	2024-10-21	2024-10-22	900.00	Airline K
e66131aa-a20b-4c14-9724-52082cf1865c	112	2024-10-23	2024-10-24	950.00	Airline L
e453bf10-e304-45b9-a3a6-3640d5d68aa7	113	2024-10-25	2024-10-26	1000.00	Airline M
6c3ba82a-5982-4ad6-b675-f313e47ed0be	114	2024-10-27	2024-10-28	1050.00	Airline N
720004bf-cbe9-4cc2-a5a6-7b1954d1c660	115	2024-10-29	2024-10-30	1100.00	Airline O
\.


--
-- Data for Name: hotels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hotels (id, name, address, stars, rating, services) FROM stdin;
40170125-0dbe-4ae8-9dcd-edadcff25d8d	Hotel Sunshine	123 Beach Ave	5	9.1	WiFi, Pool, Spa
6c3be25e-685e-4ec5-86ff-cb7caed16e96	Mountain Retreat	456 Hill St	4	8.5	WiFi, Breakfast, Parking
87acec1e-56fc-40a0-824e-50e314e71829	City Central	789 Main Rd	3	7.8	WiFi, Gym
7f23a9c2-fd42-41df-b753-1232ab102a98	Ocean View	321 Ocean Dr	5	9.3	WiFi, Pool, Gym, Spa
6c8803b5-8e61-4305-8dc3-102384ef35e3	Budget Inn	654 Budget Ln	2	6.4	WiFi, Parking
5c6e4eae-d0c1-41f6-8007-64d8dec28f3d	Luxury Suites	987 Luxury Blvd	5	9.7	WiFi, Pool, Spa, Gym, Breakfast
2be82b5a-8adf-45f6-b516-363a41dad44e	Country Lodge	111 Country Rd	4	8.2	WiFi, Breakfast, Parking
c90dfeaf-bb12-4f98-9dfd-d98a2f2d95d2	Urban Stay	222 City St	3	7.5	WiFi, Gym, Parking
2b016ab0-8ec1-4e3b-bcde-40f6fe886a39	Seaside Hotel	333 Seaside Ave	4	8.9	WiFi, Pool, Breakfast
650b5539-bfd9-44bf-9327-240e976d1c5e	Downtown Hotel	444 Downtown St	3	7.2	WiFi, Parking
6f48ae8e-9336-4e11-9703-f686195efea3	Airport Hotel	555 Airport Rd	4	8	WiFi, Breakfast, Parking
c2dfe10f-c3f3-4fa4-be97-fd767f66f04c	Historic Hotel	666 Historic Ln	5	9	WiFi, Spa, Breakfast
18294973-9df5-4a88-8415-6e4b3c866a5e	Business Hotel	777 Business Blvd	4	8.3	WiFi, Gym, Parking
0c0357e9-dd9f-4c72-9742-d7a92e82c5d5	Family Hotel	888 Family St	3	7.6	WiFi, Pool, Breakfast
595aa6e3-3b09-416f-9843-fe1ca93ca926	Boutique Hotel	999 Boutique Ave	5	9.5	WiFi, Spa, Gym, Breakfast
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (id, booking_id, review_text, grade, review_date) FROM stdin;
b27eb327-ffa4-4b70-8cbe-703a0b96a0c3	248c2eb7-f0ac-4939-9016-e9f09bc9984c	Great experience!	9	2024-09-16
29f2d405-f0f0-4aaf-a8c1-d95b9e24a84e	61a69990-e77e-40fa-bbdb-aabeb7c29706	Good service.	8	2024-09-17
3956b902-b701-4194-a443-6c558ed7a3ee	5c18f76e-a3fa-431d-adeb-a3a177ce1489	Average stay.	6	2024-09-18
1cd93b2c-9a69-48e7-a731-6589fa63feeb	c445b8ed-e40d-4858-899e-75bd0a2e8c52	Not satisfied.	4	2024-09-19
f1fe145e-e580-4927-9377-f19a76aa1081	63367bb9-4dc5-40ca-af0f-13113673644c	Excellent!	10	2024-09-20
69379bea-3743-4e03-8db8-51eee5a69113	06035ad5-c6fa-4f87-a41b-e0e7f43578b0	Could be better.	5	2024-09-21
82df1d53-099f-411d-9a70-8764bde4736d	0aa170c9-dc7b-4c34-978c-06be67cf4c05	Loved it!	9.5	2024-09-22
7c71dae1-ca23-4372-a7a4-9474ab7a91a9	54da4a12-b518-4f32-b72d-6cf28be10541	Just okay.	7	2024-09-23
50cb687c-4f5b-4200-b5ac-e84d68fa0837	a3595444-6ecb-478c-8d92-753b665bc21a	Terrible experience.	2	2024-09-24
9a067780-a099-4cea-8469-07b3e3dbb51d	12f28bfe-10f5-42fa-9055-04a985301553	Fantastic!	9.8	2024-09-25
05303cbe-37fc-4d6d-94fd-91ea404d364b	8662fc50-7a8b-479a-9afb-ec9015ff8208	Good value.	8.5	2024-09-26
cac9f193-5e35-4975-8d92-c957f5cd2537	039a80a7-3059-463e-b5b6-403b2a675e2e	Not worth it.	3	2024-09-27
e61dc40e-e806-494e-b273-2d3e1fb0a746	13552489-7e05-4adb-b4d4-243f3d4da5a0	Very nice.	8.8	2024-09-28
5906c8ad-0b40-43bb-80f3-29aa9d990601	608af4b4-ea52-4d98-95d6-2b4a71de2dbe	Disappointing.	4.5	2024-09-29
65cac4a3-7031-4443-be24-d36e241ffc0e	74c66112-67e1-44f7-8ed0-19d30009baa3	Highly recommend!	9	2024-09-30
\.


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: directions directions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directions
    ADD CONSTRAINT directions_pkey PRIMARY KEY (id);


--
-- Name: flights flights_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flights
    ADD CONSTRAINT flights_pkey PRIMARY KEY (id);


--
-- Name: hotels hotels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id, booking_id);


--
-- Name: bookings bookings_direction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_direction_id_fkey FOREIGN KEY (direction_id) REFERENCES public.directions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: bookings bookings_flight_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES public.flights(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: bookings bookings_hotel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotels(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: reviews reviews_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--


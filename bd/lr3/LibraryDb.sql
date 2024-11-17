--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE librarydb;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:d01px38w6dbv8H/1Agg9Ow==$3E2Ls4zQQXFydAk0XmOpgJVwTKHyNcDBdtkZOVpTDhU=:SIjBYpr6eOL/ireSPVoEcRsiyxhm3H9QXOU5jESVtLA=';

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

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (Debian 17.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
SET transaction_timeout = 0;
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
SET transaction_timeout = 0;
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
-- Database "librarydb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (Debian 17.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: librarydb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE librarydb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE librarydb OWNER TO postgres;

\connect librarydb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: check_book_insert(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_book_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    begin
        if new.publish_year is null then
            new.publish_year := date_part('year', current_date);
        elseif new.publish_year < 1950 or new.publish_year > date_part('year', current_date) then
            raise exception 'Год публикации должен быть между 1950 и настоящим годом';
        end if;
        if new.pages < 10 or new.pages > 2000 then
            raise exception 'Количество страниц должно быть меньше 2000 и больше 10';
        end if;
        return new;
    end;
    $$;


ALTER FUNCTION public.check_book_insert() OWNER TO postgres;

--
-- Name: is_old(integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_old(publish_date integer, note character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
    begin
        if note = 'учебник' then
            if date_part('year', current_date) - publish_date >= 20 then
                return 'старое издание';
            else return '';
            end if;
        elseif note = 'справочник' then
            if date_part('year', current_date) - publish_date >= 10 then
                return 'старое издание';
            else return '';
            end if;
        else
            if date_part('year', current_date) - publish_date >= 30 then
                return 'старое издание';
            else return '';
            end if;
        end if;
    end;
    $$;


ALTER FUNCTION public.is_old(publish_date integer, note character varying) OWNER TO postgres;

--
-- Name: make_report(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.make_report(rubric_name character varying, mode integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
    declare rec record;
    begin
        if mode = 0 then
            delete from report;
        end if;
        for rec in ( select rubricators.name as rubric_name, author, books.name as book_name, publish_year, publisher, note
                           from rubricators join books on rubricators.code = books.rubricator where rubricators.name = rubric_name)
        loop
            insert into report
            values (rec.rubric_name, rec.author, rec.book_name, rec.publish_year, rec.publisher, is_old(rec.publish_year, rec.note));
            end loop;
    end;
    $$;


ALTER FUNCTION public.make_report(rubric_name character varying, mode integer) OWNER TO postgres;

--
-- Name: store_old_rubricators(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.store_old_rubricators() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    begin
        insert into rubricators_old values (old.code, old.name, current_user, current_date);
        return new;
    end;
    $$;


ALTER FUNCTION public.store_old_rubricators() OWNER TO postgres;

--
-- Name: bookscode_gen; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookscode_gen
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookscode_gen OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    code integer DEFAULT nextval('public.bookscode_gen'::regclass) NOT NULL,
    rubricator integer NOT NULL,
    name character varying(40) NOT NULL,
    author character varying(100) NOT NULL,
    publisher character varying(30) NOT NULL,
    publish_year integer NOT NULL,
    pages integer NOT NULL,
    cost double precision NOT NULL,
    note character varying(100)
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: readerid_gen; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.readerid_gen
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.readerid_gen OWNER TO postgres;

--
-- Name: readers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.readers (
    id integer DEFAULT nextval('public.readerid_gen'::regclass) NOT NULL,
    fio character varying(30) NOT NULL,
    address character varying(40) NOT NULL,
    birthdate date NOT NULL,
    gender character(1) NOT NULL,
    phone character(12) NOT NULL,
    passport character(12) NOT NULL
);


ALTER TABLE public.readers OWNER TO postgres;

--
-- Name: report; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.report (
    rubric_name character varying(30),
    author character varying(100),
    book_name character varying(40),
    publish_year integer,
    publisher character varying(30),
    note character varying
);


ALTER TABLE public.report OWNER TO postgres;

--
-- Name: rubricatorcode_gen; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rubricatorcode_gen
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rubricatorcode_gen OWNER TO postgres;

--
-- Name: rubricators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rubricators (
    code integer DEFAULT nextval('public.rubricatorcode_gen'::regclass) NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.rubricators OWNER TO postgres;

--
-- Name: rubricators_old; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rubricators_old (
    code integer,
    name character varying(30),
    username character varying,
    date date
);


ALTER TABLE public.rubricators_old OWNER TO postgres;

--
-- Name: season_tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.season_tickets (
    reader integer NOT NULL,
    book integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL
);


ALTER TABLE public.season_tickets OWNER TO postgres;

--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (code, rubricator, name, author, publisher, publish_year, pages, cost, note) FROM stdin;
1	1	Учебник математики	Иванов И.И.	Просвещение	2020	300	500	учебник
2	2	Справочник по физике	Петров П.П.	Наука	2019	450	700	справочник
3	3	Литературный роман	Сидоров С.С.	Пальмира	2021	350	400	\N
4	4	История искусств	Кузнецова А.А.	АСТ	2018	600	900	\N
5	5	Биология	Лебедев В.В.	Эксмо	2017	320	450	учебник
6	6	Справочник по химии	Миронова Т.Т.	Мир	2016	500	800	справочник
7	7	Программирование на Python	Крылов К.К.	БХВ	2022	480	650	\N
8	8	Кулинарная книга	Боброва Н.Н.	Рипол Классик	2020	250	300	\N
9	9	Путеводитель по городам	Быков А.А.	Вече	2019	275	350	\N
10	10	Философия	Котова Е.Е.	КноРус	2021	400	600	\N
11	11	Основы геометрии	Новиков В.В.	Феникс	2018	300	500	учебник
12	12	Руководство по медицине	Соколов П.П.	ГЭОТАР-Медиа	2017	540	750	\N
13	13	Учебник по программированию	Лукина С.С.	ДМК Пресс	2022	410	600	учебник
15	15	Руководство по фотографии	Тихонов А.А.	Эксмо	1952	360	550	\N
14	14	Справочник по математике	Орлова И.И.	Высшая школа	1952	475	700	справочник
16	15	Руководство по танцам	Тихонов А.А.	Эксмо	2024	360	550	\N
\.


--
-- Data for Name: readers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.readers (id, fio, address, birthdate, gender, phone, passport) FROM stdin;
1	Иван Иванов	ул. Пушкина, д. 10	1990-05-21	M	79991234567 	4509 123456 
2	Мария Петрова	ул. Ленина, д. 25	1985-11-15	F	79997654321 	4509 654321 
3	Алексей Смирнов	пр. Гагарина, д. 3	1992-02-10	M	79993456789 	4510 987654 
4	Ольга Сидорова	ул. Чехова, д. 12	1994-07-22	F	79992345678 	4510 876543 
5	Павел Орлов	ул. Маяковского, д. 7	1988-03-30	M	79994561234 	4511 765432 
6	Наталья Кузнецова	ул. Свердлова, д. 14	1991-08-19	F	79995612345 	4511 654321 
7	Дмитрий Соколов	ул. Герцена, д. 9	1987-04-12	M	79993456780 	4512 543210 
8	Елена Ковалева	ул. Гоголя, д. 2	1995-12-05	F	79997865432 	4512 432109 
9	Максим Лебедев	ул. Тургенева, д. 8	1993-06-11	M	79991233456 	4513 321098 
10	Анна Миронова	ул. Шевченко, д. 15	1996-09-23	F	79994567890 	4513 210987 
11	Владимир Крылов	ул. Кутузова, д. 19	1990-01-17	M	79992345679 	4514 109876 
12	Ирина Котова	ул. Жукова, д. 4	1989-05-25	F	79996789012 	4514 098765 
13	Сергей Новиков	ул. Толстого, д. 6	1986-11-02	M	79997865431 	4515 987654 
14	Татьяна Боброва	ул. Ясная, д. 13	1992-03-21	F	79993456788 	4515 876543 
15	Андрей Быков	ул. Лесная, д. 5	1994-07-14	M	79991234568 	4516 765432 
\.


--
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.report (rubric_name, author, book_name, publish_year, publisher, note) FROM stdin;
Pet Supplies	Орлова И.И.	Справочник по математике	1952	Высшая школа	старое издание
\.


--
-- Data for Name: rubricators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rubricators (code, name) FROM stdin;
2	Books
3	Home Appliances
4	Software
5	Music Instruments
6	Sports Equipment
7	Clothing
8	Toys
9	Movies
10	Games
11	Furniture
12	Jewelry
13	Beauty Products
14	Pet Supplies
15	Office Supplies
1	Electronic Devices
\.


--
-- Data for Name: rubricators_old; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rubricators_old (code, name, username, date) FROM stdin;
1	Tech Gadgets	postgres	2024-11-17
\.


--
-- Data for Name: season_tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.season_tickets (reader, book, start_date, end_date) FROM stdin;
1	2	2024-01-10	2024-02-10
2	3	2024-02-15	2024-03-15
3	4	2024-03-20	2024-04-20
4	5	2024-04-25	2024-05-25
5	6	2024-05-30	2024-06-30
6	7	2024-07-05	2024-08-05
7	8	2024-08-10	2024-09-10
8	9	2024-09-15	2024-10-15
9	10	2024-10-20	2024-11-20
10	11	2024-11-25	2024-12-25
11	12	2024-12-30	2025-01-30
12	13	2025-02-05	2025-03-05
13	14	2025-03-10	2025-04-10
14	15	2025-04-15	2025-05-15
15	1	2025-05-20	2025-06-20
\.


--
-- Name: bookscode_gen; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookscode_gen', 18, true);


--
-- Name: readerid_gen; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.readerid_gen', 15, true);


--
-- Name: rubricatorcode_gen; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rubricatorcode_gen', 15, true);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (code);


--
-- Name: readers readers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.readers
    ADD CONSTRAINT readers_pkey PRIMARY KEY (id);


--
-- Name: rubricators rubricators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rubricators
    ADD CONSTRAINT rubricators_pkey PRIMARY KEY (code);


--
-- Name: books check_new_book; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_new_book BEFORE INSERT OR UPDATE ON public.books FOR EACH ROW EXECUTE FUNCTION public.check_book_insert();


--
-- Name: rubricators store_rubricators_data; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER store_rubricators_data BEFORE UPDATE ON public.rubricators FOR EACH ROW EXECUTE FUNCTION public.store_old_rubricators();


--
-- Name: books books_rubricator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_rubricator_fkey FOREIGN KEY (rubricator) REFERENCES public.rubricators(code);


--
-- Name: season_tickets season_tickets_book_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.season_tickets
    ADD CONSTRAINT season_tickets_book_fkey FOREIGN KEY (book) REFERENCES public.books(code);


--
-- Name: season_tickets season_tickets_reader_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.season_tickets
    ADD CONSTRAINT season_tickets_reader_fkey FOREIGN KEY (reader) REFERENCES public.readers(id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (Debian 17.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
SET transaction_timeout = 0;
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


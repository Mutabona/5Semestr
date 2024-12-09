--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE "HospitalDb";




--
-- Drop roles
--

DROP ROLE admins;
DROP ROLE doctors;
DROP ROLE postgres;
DROP ROLE sisters;


--
-- Roles
--

CREATE ROLE admins;
ALTER ROLE admins WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE doctors;
ALTER ROLE doctors WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:LOGWxai7fjilWkbdSSsDGw==$fiWVPQW3fX4PphjKGe64lKR0/i/uWKGG88tm/Wyo8R4=:VBrJIP2kuKaZ87G7dq0N9UfxyehMAS/nDiSrbb1wUGw=';
CREATE ROLE sisters;
ALTER ROLE sisters WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;

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

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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
-- Database "HospitalDb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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
-- Name: HospitalDb; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "HospitalDb" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE "HospitalDb" OWNER TO postgres;

\connect "HospitalDb"

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


--
-- Name: check_user_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_user_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (SELECT "Role" FROM "Users" WHERE "Id" = NEW."UserId") <> 2 THEN
        RAISE EXCEPTION 'Пользователь не является врачом';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_user_role() OWNER TO postgres;

--
-- Name: check_user_role_for_mark(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_user_role_for_mark() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (SELECT "Role" FROM "Users" WHERE "Id" = NEW."UserId") <> 3 THEN
        RAISE EXCEPTION 'Пользователь не является медсестрой';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_user_role_for_mark() OWNER TO postgres;

--
-- Name: generate_uuid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_uuid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."Id" IS NULL THEN
        NEW."Id" := uuid_generate_v4();
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_uuid() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Analyzes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Analyzes" (
    "Id" uuid NOT NULL,
    "Type" text NOT NULL,
    "Date" date NOT NULL,
    "Result" text NOT NULL,
    "HistoryId" uuid NOT NULL,
    "AppointmentId" uuid
);


ALTER TABLE public."Analyzes" OWNER TO postgres;

--
-- Name: Appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Appointments" (
    "Id" uuid NOT NULL,
    "Content" text NOT NULL,
    "ExaminationId" uuid NOT NULL,
    "Date" date DEFAULT '-infinity'::date NOT NULL
);


ALTER TABLE public."Appointments" OWNER TO postgres;

--
-- Name: Examinations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Examinations" (
    "Id" uuid NOT NULL,
    "Date" date NOT NULL,
    "Conclusion" text,
    "HistoryId" uuid NOT NULL,
    "UserId" uuid
);


ALTER TABLE public."Examinations" OWNER TO postgres;

--
-- Name: Histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Histories" (
    "Id" uuid NOT NULL,
    "Diagnosis" text,
    "ArriveDate" date NOT NULL,
    "PatientId" uuid NOT NULL,
    "UserId" uuid,
    "DepartureDate" date,
    "LifeAnamnesis" text NOT NULL,
    "DiseaseAnamnesis" text NOT NULL,
    "Epicrisis" text,
    "Complaints" text NOT NULL
);


ALTER TABLE public."Histories" OWNER TO postgres;

--
-- Name: Marks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Marks" (
    "Id" uuid NOT NULL,
    "IsDone" boolean NOT NULL,
    "Date" date NOT NULL,
    "UserId" uuid,
    "AppointmentId" uuid NOT NULL
);


ALTER TABLE public."Marks" OWNER TO postgres;

--
-- Name: Patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Patients" (
    "Id" uuid NOT NULL,
    "FIO" text NOT NULL,
    "Telephone" text NOT NULL,
    "Passport" text NOT NULL,
    "BirthDate" date NOT NULL,
    "Address" text NOT NULL
);


ALTER TABLE public."Patients" OWNER TO postgres;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    "Id" uuid NOT NULL,
    "FIO" text NOT NULL,
    "Telephone" text NOT NULL,
    "Login" text NOT NULL,
    "Password" text NOT NULL,
    "Role" integer NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- Data for Name: Analyzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Analyzes" ("Id", "Type", "Date", "Result", "HistoryId", "AppointmentId") FROM stdin;
69313ea2-e984-46e1-9859-4d6dd41f656d	Общий анализ крови	2024-12-07	Гемоглобин (Hb): 140 г/л. Норма: 130-170 г/л. Эритроциты (RBC): 4.8 млн/мкл. Норма: 4.5-5.5 млн/мкл. Лейкоциты (WBC): 6.0 тыс/мкл. Норма: 4.0-9.0 тыс/мкл. Тромбоциты (PLT): 250 тыс/мкл. Норма: 150-400 тыс/мкл. Гематокрит (Hct): 45%. Норма: 40-50%. Средний объем эритроцитов (MCV): 90 фл. Норма: 80-100 фл. Среднее содержание Hb в эритроците (MCH): 30 пг. Норма: 27-33 пг. Средняя концентрация Hb в эритроците (MCHC): 340 г/л. Норма: 320-360 г/л. Скорость оседания эритроцитов (СОЭ): 10 мм/час. Норма: 0-15 мм/час.	35d30e1f-ce1e-40fc-a8db-8cd1c7c97892	99edb726-4909-4bc5-964b-531a746fca5b
0ea16250-6607-468e-861d-7b2fd3bdb0db	КТ грудной клетки	2024-12-07	Легкие: без очаговых и инфильтративных изменений, объем легочной ткани сохранен, патологические образования не выявлены.\n\nБронхи: проходимы, стенки не утолщены.\n\nМедиастинум: нормальных размеров, без признаков лимфаденопатии.\n\nПлевральные полости: свободные, без признаков выпота.\n\nСердце и крупные сосуды: нормальных размеров, стенки и клапаны сердца без видимых изменений, аорта и другие крупные сосуды без патологических изменений.\n\nГрудная клетка и ребра: без признаков переломов и патологических изменений.	7145da82-229e-43cc-83a2-e1f09e7a6378	4d5a3041-d10e-43a0-bb21-96098c9ac146
08dcc42d-2acb-4b86-bcba-8c092d8e1cc0	ЭЭГ мозга	2024-12-07	Фоновая активность: альфа-ритм с частотой 8-12 Гц, амплитуда до 50 мкВ, доминирует в затылочных областях.\n\nБета-ритм: частота 14-30 Гц, амплитуда до 20 мкВ, доминирует в лобных и центральных областях.\n\nТета-ритм: частота 4-7 Гц, амплитуда до 30 мкВ, проявляется в состоянии покоя.\n\nДельта-ритм: частота 0.5-3 Гц, амплитуда до 100 мкВ, проявляется во время сна или глубокого расслабления.\n\nРеакция на фотостимуляцию: нормальная, без признаков патологической активности.\n\nРеакция на гипервентиляцию: усиление тета- и дельта-ритмов в пределах нормы.	3b01af55-8da3-43cf-9b8a-b0c64d4d1647	39ed946d-089f-4cf2-998a-4f9bbe8dff74
1d7d7cc1-ad06-4be4-bd5d-52d01324f01b	Анализ мочи	2024-12-07	Цвет: Светло-желтый, соответствует норме.\n\nПрозрачность: Полная, без мутных включений.\n\nПлотность: 1.020 г/мл. Норма: 1.010-1.025 г/мл.\n\npH: 6.0. Норма: 4.5-8.0.\n\nБелок: Отрицательный. Норма: Отсутствует.\n\nГлюкоза: Отрицательная. Норма: Отсутствует.\n\nКетоновые тела: Отрицательные. Норма: Отсутствуют.\n\nБилирубин: Отрицательный. Норма: Отсутствует.\n\nЭритроциты: 0-1 в поле зрения. Норма: 0-2 в поле зрения.\n\nЛейкоциты: 0-2 в поле зрения. Норма: 0-5 в поле зрения.\n\nЭпителиальные клетки: Единичные. Норма: Единичные.\n\nЦилиндры: Не обнаружены. Норма: Отсутствуют.\n\nБактерии: Не обнаружены. Норма: Отсутствуют.	9d19ee33-7f80-4a23-96bd-9dad5c128ab2	d38831aa-e165-4306-8c46-c0ac7b19a390
385684d5-8bd6-416d-87ff-4eb837869259	Лабораторное исследование крови на гормоны	2024-12-07	Тиреотропный гормон (ТТГ): 2.5 мЕд/л. Норма: 0.4-4.0 мЕд/л.\n\nТрийодтиронин (Т3): 1.8 нг/мл. Норма: 1.2-2.8 нг/мл.\n\nТироксин (Т4): 8.0 мкг/дл. Норма: 5.0-12.0 мкг/дл.\n\nКортизол: 15 мкг/дл. Норма: 6-23 мкг/дл.\n\nИнсулин: 12 мкЕд/мл. Норма: 3-25 мкЕд/мл.\n\nПролактин: 15 нг/мл. Норма: 5-25 нг/мл.\n\nЭстрадиол: 45 пг/мл. Норма для женщин (фолликулярная фаза): 20-200 пг/мл.\n\nТестостерон: 5.5 нг/мл. Норма для мужчин: 2.5-10.0 нг/мл.	9c5d7c9f-647b-45ee-9414-e7b50b2079e4	18d0f151-385f-449f-ac87-a6dff3422877
df6017ae-c23f-4060-a303-a12ab0d3e835	Анализ на уровень витамина D	2024-12-07	25(OH) витамин D (кальциферол): 45 нг/мл. Норма: 30-50 нг/мл.	ac79d8d9-00c7-4536-ba71-93071856590e	f8a117fe-617d-43ee-aa27-9b329e65074b
ffd90f4d-49ba-47b3-894e-c8baeb93e013	Электроэнцефалография	2024-12-07	Фоновая активность: Альфа-ритм с частотой 8-12 Гц, амплитуда до 50 мкВ, доминирует в затылочных областях.\n\nБета-ритм: Частота 14-30 Гц, амплитуда до 20 мкВ, доминирует в лобных и центральных областях.\n\nТета-ритм: Частота 4-7 Гц, амплитуда до 30 мкВ, проявляется в состоянии покоя.\n\nДельта-ритм: Частота 0.5-3 Гц, амплитуда до 100 мкВ, проявляется во время сна или глубокого расслабления.\n\nРеакция на фотостимуляцию: Нормальная, без признаков патологической активности.\n\nРеакция на гипервентиляцию:	c57838d0-e9e9-404c-8b5e-d625c388b129	786a4972-907b-4263-accb-e834c743e0c5
630329a9-c5cd-4b93-a9bb-8f9a361b4422	Лабораторное исследование крови	2024-12-07	Находки:\n\nГемоглобин (Hb): 145 г/л. Норма: 130-170 г/л.\n\nЭритроциты (RBC): 5.1 млн/мкл. Норма: 4.5-5.5 млн/мкл.\n\nЛейкоциты (WBC): 6.5 тыс/мкл. Норма: 4.0-9.0 тыс/мкл.\n\nТромбоциты (PLT): 280 тыс/мкл. Норма: 150-400 тыс/мкл.\n\nГематокрит (Hct): 46%. Норма: 40-50%.\n\nСредний объем эритроцитов (MCV): 88 фл. Норма: 80-100 фл.\n\nСреднее содержание Hb в эритроците (MCH): 29 пг. Норма: 27-33 пг.\n\nСредняя концентрация Hb в эритроците (MCHC): 335 г/л. Норма: 320-360 г/л.\n\nСкорость оседания эритроцитов (СОЭ): 12 мм/час. Норма: 0-15 мм/час.\n\nБиохимические показатели:\n\nГлюкоза: 5.2 ммоль/л. Норма: 3.3-5.5 ммоль/л.\n\nХолестерин: 4.8 ммоль/л. Норма: 3.0-5.2 ммоль/л.\n\nАланинаминотрансфераза (АЛТ): 25 Ед/л. Норма: 10-40 Ед/л.\n\nАспартатаминотрансфераза (АСТ): 20 Ед/л. Норма: 10-40 Ед/л.\n\nБилирубин общий: 12 мкмоль/л. Норма: 5-20 мкмоль/л.\n\nКреатинин: 85 мкмоль/л. Норма: 60-110 мкмоль/л.\n\nМочевина: 5.0 ммоль/л. Норма: 2.5-8.3 ммоль/л.	f8a8b0f3-b315-4365-919a-b04d85b773f6	3cec94bc-c3d6-49c0-aaab-00b23bffc8c5
3c817514-d81c-4938-abe5-135d9c20cff0	МРТ головного мозга	2024-12-07	Субарахноидальные пространства и желудочковая система: не расширены, без признаков гидроцефалии.\n\nСерое и белое вещество головного мозга: дифференциация сохранена, патологические изменения не выявлены.\n\nМиндалины мозжечка: расположены на уровне большого затылочного отверстия.\n\nГипофиз: обычных размеров, без признаков опухоли.\n\nОрбиты глаз: без патологических изменений.\n\nГоловной мозг и шейный отдел спинного мозга: без признаков патологических изменений.	5af227f3-57ef-443c-a7cd-60ddc8782e77	\N
\.


--
-- Data for Name: Appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Appointments" ("Id", "Content", "ExaminationId", "Date") FROM stdin;
05c3a260-da68-4276-8ec6-626e748a4d91	Подкожная инъекция инсулина	37bc5654-7077-4d19-8075-2827ad2c2220	2024-11-15
786a4972-907b-4263-accb-e834c743e0c5	Электроэнцефалография (ЭЭГ)	3d32c8c0-b417-42ed-85c3-ebda4c878488	2024-05-15
99edb726-4909-4bc5-964b-531a746fca5b	Общий анализ крови	5dec7242-5b32-4712-aeee-baacfffff904	2024-02-01
9c03db70-1713-49ef-bae0-1320cae1c440	Физиотерапия (электрофорез)	91e129fd-cc80-43d0-9fa8-7add99778f19	2024-05-20
4d5a3041-d10e-43a0-bb21-96098c9ac146	КТ грудной клетки	06f8e00b-4666-400b-8a7d-d4c820a7dbfd	2024-06-15
39ed946d-089f-4cf2-998a-4f9bbe8dff74	ЭЭГ мозга	608d663b-c529-4ca4-9b3e-a9bf9a82bd4d	2024-07-01
d38831aa-e165-4306-8c46-c0ac7b19a390	Анализ мочи	6358951f-d748-47a1-84c5-98c1d5e67bfc	2024-08-10
5b1259c3-9b35-4463-b4d5-382129800d94	Внутривенная инъекция метилпреднизолона	2d38e21a-1d08-4362-bb7c-2b1276367ced	2024-09-15
18d0f151-385f-449f-ac87-a6dff3422877	Лабораторное исследование крови на гормоны	b033903a-2cf3-4c00-acbb-bc5591e4a98d	2024-10-25
082b2d3e-13bd-4bca-b250-68903afb5c9f	Физиотерапия	42777940-61f5-4293-aec0-bdfa7585c9e5	2024-11-30
f8a117fe-617d-43ee-aa27-9b329e65074b	Анализ на уровень витамина D	dc42b8d8-01cd-4f75-beec-9a82904ad692	2024-02-20
e20cf601-937e-4a36-8b90-9888c88b2c34	Групповая психотерапия	f6292f5c-7280-4274-a8a6-e21c20eb2055	2024-03-30
3cec94bc-c3d6-49c0-aaab-00b23bffc8c5	Лабораторное исследование крови	84c2c078-b83d-4fde-a70c-d1ea5192a89a	2024-08-05
5936c885-c19f-4158-9de0-951856de0c9a	Препарат: Цефтриаксон Дозировка: 1 г Способ введения: Внутримышечно (в/м)	dc42b8d8-01cd-4f75-beec-9a82904ad692	2024-12-09
\.


--
-- Data for Name: Examinations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Examinations" ("Id", "Date", "Conclusion", "HistoryId", "UserId") FROM stdin;
37bc5654-7077-4d19-8075-2827ad2c2220	2024-11-15	Пациент показал улучшение, рекомендовано снижение дозировки препаратов.	b80f7016-99f5-4786-869e-41a202bd1957	87673641-9182-437c-bfba-3e2804565778
91e129fd-cc80-43d0-9fa8-7add99778f19	2024-05-20	Обострение симптомов, рекомендована корректировка терапии.	cd9eb8f3-985c-4643-9bd6-7bbcdc1d1a62	87673641-9182-437c-bfba-3e2804565778
06f8e00b-4666-400b-8a7d-d4c820a7dbfd	2024-06-15	Пациент продемонстрировал значительное улучшение, рекомендовано продолжение терапии.	7145da82-229e-43cc-83a2-e1f09e7a6378	21454d8b-1076-4b17-bcec-4b4ef026049c
608d663b-c529-4ca4-9b3e-a9bf9a82bd4d	2024-07-01	Состояние пациента улучшилось, рекомендуется продолжение текущего плана лечения.	3b01af55-8da3-43cf-9b8a-b0c64d4d1647	4db834a2-c3cf-497c-87bf-c253c055c36d
6358951f-d748-47a1-84c5-98c1d5e67bfc	2024-08-10	Значительное улучшение, рекомендуется постепенная отмена препаратов.	9d19ee33-7f80-4a23-96bd-9dad5c128ab2	ae7280e7-33e8-47bb-a11a-7866d977c568
b033903a-2cf3-4c00-acbb-bc5591e4a98d	2024-10-25	Пациент стабилен, рекомендуется продолжение лечения.	9c5d7c9f-647b-45ee-9414-e7b50b2079e4	9926bf28-71c0-4d18-96a4-9eecc24ec29f
42777940-61f5-4293-aec0-bdfa7585c9e5	2024-11-30	Состояние пациента улучшилось, рекомендована выписка.	66b1dbfe-1b3c-45e6-ad16-8513bb0e8583	f7377f3b-068d-4163-ad89-3190126647cb
dc42b8d8-01cd-4f75-beec-9a82904ad692	2024-02-20	Состояние пациента стабильно, рекомендуется продолжение наблюдения.	ac79d8d9-00c7-4536-ba71-93071856590e	21454d8b-1076-4b17-bcec-4b4ef026049c
84c2c078-b83d-4fde-a70c-d1ea5192a89a	2024-08-05	Состояние пациента значительно улучшилось, рекомендуется постепенная отмена препаратов.	f8a8b0f3-b315-4365-919a-b04d85b773f6	ae7280e7-33e8-47bb-a11a-7866d977c568
f6292f5c-7280-4274-a8a6-e21c20eb2055	2024-03-30	Пациент стабилен, планируется выписка.	9fbdf340-2d53-4e8a-b80d-d9b897c17e0f	4db834a2-c3cf-497c-87bf-c253c055c36d
5dec7242-5b32-4712-aeee-baacfffff904	2024-02-01	Состояние пациента стабилизировано, рекомендуется продолжение терапии.	35d30e1f-ce1e-40fc-a8db-8cd1c7c97892	\N
2d38e21a-1d08-4362-bb7c-2b1276367ced	2024-09-15	Состояние пациента стабильно, наблюдение продолжается.	1cd41799-38fa-446a-9970-0a358b497ab2	\N
3d32c8c0-b417-42ed-85c3-ebda4c878488	2024-05-15	Обострение симптомов, рекомендована корректировка терапии.	c57838d0-e9e9-404c-8b5e-d625c388b129	\N
\.


--
-- Data for Name: Histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Histories" ("Id", "Diagnosis", "ArriveDate", "PatientId", "UserId", "DepartureDate", "LifeAnamnesis", "DiseaseAnamnesis", "Epicrisis", "Complaints") FROM stdin;
9d19ee33-7f80-4a23-96bd-9dad5c128ab2	F32.2 - Тяжелый депрессивный эпизод без психотических симптомов	2024-04-20	a1ff4447-5787-48d6-97b6-08d5f9d043cd	ae7280e7-33e8-47bb-a11a-7866d977c568	\N	Тяжелый стресс на работе	Снижение настроения и энергии	Состояние улучшилось после медикаментозной терапии	Жалобы на упадок сил и настроение
7145da82-229e-43cc-83a2-e1f09e7a6378	F42.0 - Обсессивно-компульсивное расстройство с преобладанием навязчивых мыслей	2023-09-15	507ae1f5-6876-46ab-b4bc-1799ac992123	21454d8b-1076-4b17-bcec-4b4ef026049c	\N	Постоянные ритуалы и проверки	Навязчивые мысли и действия	Значительное улучшение после когнитивно-поведенческой терапии	Жалобы на навязчивые мысли и действия
5af227f3-57ef-443c-a7cd-60ddc8782e77	F31.1 - Биполярное аффективное расстройство, текущий эпизод мании без психотических симптомов	2023-03-20	d18637dd-5c0f-4713-8dfb-95ca55796286	9926bf28-71c0-4d18-96a4-9eecc24ec29f	\N	Пациентка выросла в неполной семье	Симптомы проявляются в виде резких смен настроения	Состояние улучшилось после медикаментозного лечения	Жалобы на частые перепады настроения
3b01af55-8da3-43cf-9b8a-b0c64d4d1647	F41.0 - Паническое расстройство	2024-02-10	e29ca8e4-163e-4752-a311-3583ebfdb745	4db834a2-c3cf-497c-87bf-c253c055c36d	\N	Частые переезды и стрессовые ситуации	Панические атаки	Состояние стабилизировано медикаментами	Жалобы на внезапные приступы паники
8ea9103d-4cb3-4cb4-8eba-9edff2cc3a0d	F33.2 - Рекуррентное депрессивное расстройство, текущий эпизод тяжелой депрессии без психотических симптомов	2023-05-10	56253396-3449-4cd0-af32-71eb1f0df7e6	f7377f3b-068d-4163-ad89-3190126647cb	\N	Пациент жил в стрессовых условиях работы	Чувство безнадежности и усталости	Ремиссия достигнута после психотерапии	Жалобы на постоянное чувство усталости и тревоги
cd9eb8f3-985c-4643-9bd6-7bbcdc1d1a62	F43.1 - Посттравматическое стрессовое расстройство	2023-07-01	2baa21ab-96ad-444f-8965-26b5c3e12a25	87673641-9182-437c-bfba-3e2804565778	2024-12-07	Пережитое жестокое обращение в детстве	Повышенная тревожность и ночные кошмары	Состояние улучшилось после долгосрочной терапии	Жалобы на повторяющиеся кошмары и тревожность
35d30e1f-ce1e-40fc-a8db-8cd1c7c97892	F20.0 - Параноидная шизофрения	2023-01-15	3f9eaec2-a813-4491-b857-587a9bec7516	\N	\N	Пациент вырос в благополучной семье	Страдающий депрессией на протяжении последних пяти лет	Пациент стабилен после курса лечения	Жалобы на бессонницу и тревогу
1cd41799-38fa-446a-9970-0a358b497ab2	F50.0 - Анорексия нервная	2024-06-30	b3d6343f-a550-444b-80ff-e4affe54a5e7	\N	\N	Семейные конфликты по поводу веса	Навязчивые мысли о еде и весе	Стабилизация состояния после терапии	Жалобы на навязчивые мысли о еде и страх набора веса
9fbdf340-2d53-4e8a-b80d-d9b897c17e0f	F50.1 - Атипичная анорексия нервная	2024-03-10	87523946-1a35-4543-b0c5-100ea79df3f9	4db834a2-c3cf-497c-87bf-c253c055c36d	\N	Проблемы с весом и самооценкой с детства	Ограничение в еде и страх набора веса	Стабилизация состояния после терапии	Жалобы на навязчивые мысли о еде и весе
b80f7016-99f5-4786-869e-41a202bd1957	F32.0 - Легкий депрессивный эпизод	2024-10-20	3edaa859-439c-426a-be71-709059ffb806	87673641-9182-437c-bfba-3e2804565778	\N	Частый стресс на работе	Снижение настроения и мотивации	Состояние улучшилось после психотерапии	Жалобы на усталость и снижение настроения
ac79d8d9-00c7-4536-ba71-93071856590e	F41.1 - Генерализованное тревожное расстройство	2024-01-15	3004dfb7-f944-4d66-9afb-c5183558cf35	21454d8b-1076-4b17-bcec-4b4ef026049c	\N	Постоянное чувство тревоги с детства	Тревожность и беспокойство	Состояние улучшилось после терапии	Жалобы на постоянное чувство тревоги
c57838d0-e9e9-404c-8b5e-d625c388b129	F41.2 - Смешанное тревожное и депрессивное расстройство	2024-05-05	6e4dbe46-5e13-4932-b6ec-f72bd9e0a5dd	ae7280e7-33e8-47bb-a11a-7866d977c568	\N	Постоянные стрессовые ситуации на работе и дома	Тревожность и депрессивные эпизоды	Состояние улучшилось после когнитивно-поведенческой терапии	Жалобы на беспокойство и снижение настроения
66b1dbfe-1b3c-45e6-ad16-8513bb0e8583	F43.1 - Посттравматическое стрессовое расстройство	2024-10-05	2dc3ec60-5d4e-43db-aa33-02d476282144	f7377f3b-068d-4163-ad89-3190126647cb	\N	Пережитое жестокое обращение в детстве	Повышенная тревожность и ночные кошмары	Состояние улучшилось после долгосрочной терапии	Жалобы на повторяющиеся кошмары и тревожность
9c5d7c9f-647b-45ee-9414-e7b50b2079e4	F40.1 - Социальные фобии	2024-08-15	194e803c-7757-4095-8e91-a75d3fc22052	9926bf28-71c0-4d18-96a4-9eecc24ec29f	\N	Переживания социальной изоляции в школе	Страх перед публичными выступлениями	Улучшение после терапии и тренингов	Жалобы на страх общения с людьми
f8a8b0f3-b315-4365-919a-b04d85b773f6	F42.2 - Смешанное обсессивно-компульсивное расстройство	2024-07-20	797ee969-18ba-4f93-b0a2-77b5bea00bf4	\N	\N	Навязчивые мысли и ритуалы с детства	ОКР с преобладанием компульсий	Значительное улучшение после когнитивно-поведенческой терапии	Жалобы на навязчивые мысли и действия
\.


--
-- Data for Name: Marks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Marks" ("Id", "IsDone", "Date", "UserId", "AppointmentId") FROM stdin;
0193a003-52cc-78bf-9c89-342b21807956	t	2024-12-07	aecd0e0c-5a7b-41d6-ba0f-3b70043996f9	99edb726-4909-4bc5-964b-531a746fca5b
0193a023-06bf-7b80-9c8d-51324705110e	t	2024-12-07	aecd0e0c-5a7b-41d6-ba0f-3b70043996f9	9c03db70-1713-49ef-bae0-1320cae1c440
0193a024-cf7a-719d-84c3-78ea63afea87	t	2024-12-07	3a3cffc6-9e7a-472d-ada2-53ddaac68a76	4d5a3041-d10e-43a0-bb21-96098c9ac146
0193a026-5404-7ff8-9b88-407f05756110	t	2024-12-07	3a3cffc6-9e7a-472d-ada2-53ddaac68a76	39ed946d-089f-4cf2-998a-4f9bbe8dff74
0193a02d-3468-7bb0-af57-6db8808055e5	t	2024-12-07	3a3cffc6-9e7a-472d-ada2-53ddaac68a76	d38831aa-e165-4306-8c46-c0ac7b19a390
0193a02d-aa13-72f7-9e0f-65f952ade43a	t	2024-12-07	3a3cffc6-9e7a-472d-ada2-53ddaac68a76	5b1259c3-9b35-4463-b4d5-382129800d94
0193a02e-997a-798b-ad03-212b6f4a7213	t	2024-12-07	3a3cffc6-9e7a-472d-ada2-53ddaac68a76	18d0f151-385f-449f-ac87-a6dff3422877
0193a02e-d73e-7474-ad18-c363c491b7d9	t	2024-12-07	3a3cffc6-9e7a-472d-ada2-53ddaac68a76	082b2d3e-13bd-4bca-b250-68903afb5c9f
0193a030-9cc7-7c1a-9153-9ace217251c3	t	2024-12-07	ab72f753-1e0c-41ff-a14a-4dff10048f52	05c3a260-da68-4276-8ec6-626e748a4d91
0193a032-3871-7285-8835-0cd136c4f453	t	2024-12-07	ab72f753-1e0c-41ff-a14a-4dff10048f52	f8a117fe-617d-43ee-aa27-9b329e65074b
0193a032-da3b-7074-a926-5fd69b8db884	t	2024-12-07	ab72f753-1e0c-41ff-a14a-4dff10048f52	e20cf601-937e-4a36-8b90-9888c88b2c34
0193a033-bf78-705b-8480-259aae419372	t	2024-12-07	ab72f753-1e0c-41ff-a14a-4dff10048f52	786a4972-907b-4263-accb-e834c743e0c5
0193a035-67dd-739b-afca-3ba69b871048	t	2024-12-07	ab72f753-1e0c-41ff-a14a-4dff10048f52	3cec94bc-c3d6-49c0-aaab-00b23bffc8c5
\.


--
-- Data for Name: Patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Patients" ("Id", "FIO", "Telephone", "Passport", "BirthDate", "Address") FROM stdin;
3f9eaec2-a813-4491-b857-587a9bec7516	Сергеев Сергей Сергеевич	111-222-3333	1111 222233	1975-08-12	г. Москва, ул. Арбат, д. 5
d18637dd-5c0f-4713-8dfb-95ca55796286	Ковалёва Анна Дмитриевна	222-333-4444	2222 333344	1988-11-23	г. Санкт-Петербург, ул. Невский, д. 15
56253396-3449-4cd0-af32-71eb1f0df7e6	Лебедев Павел Иванович	333-444-5555	3333 444455	1993-03-14	г. Казань, ул. Баумана, д. 25
2baa21ab-96ad-444f-8965-26b5c3e12a25	Иванова Екатерина Алексеевна	444-555-6666	4444 555566	1981-06-30	г. Новосибирск, ул. Красный Проспект, д. 35
507ae1f5-6876-46ab-b4bc-1799ac992123	Васильев Артём Петрович	555-666-7777	5555 666677	1997-12-21	г. Екатеринбург, ул. Ленина, д. 45
e29ca8e4-163e-4752-a311-3583ebfdb745	Мартынова Оксана Викторовна	666-777-8888	6666 777788	1990-10-10	г. Челябинск, ул. Кирова, д. 55
a1ff4447-5787-48d6-97b6-08d5f9d043cd	Дмитриев Никита Сергеевич	777-888-9999	7777 888899	1984-01-08	г. Омск, ул. Советская, д. 65
b3d6343f-a550-444b-80ff-e4affe54a5e7	Николаева Светлана Андреевна	888-999-0000	8888 999900	1992-07-19	г. Самара, ул. Победы, д. 75
194e803c-7757-4095-8e91-a75d3fc22052	Морозов Андрей Владимирович	999-000-1111	9999 000011	1987-02-04	г. Тюмень, ул. Ленина, д. 85
2dc3ec60-5d4e-43db-aa33-02d476282144	Зайцева Лариса Михайловна	000-111-2222	0000 111122	1995-09-13	г. Волгоград, ул. Мира, д. 95
3edaa859-439c-426a-be71-709059ffb806	Кузнецов Дмитрий Иванович	111-222-3334	1111 222234	1982-04-15	г. Красноярск, ул. Ленина, д. 105
3004dfb7-f944-4d66-9afb-c5183558cf35	Фёдорова Анна Павловна	222-333-4445	2222 333345	1985-11-28	г. Владивосток, ул. Светланская, д. 115
87523946-1a35-4543-b0c5-100ea79df3f9	Григорьев Алексей Николаевич	333-444-5556	3333 444456	1990-05-17	г. Хабаровск, ул. Ленинградская, д. 125
6e4dbe46-5e13-4932-b6ec-f72bd9e0a5dd	Крылова Надежда Александровна	444-555-6667	4444 555567	1989-03-29	г. Барнаул, ул. Ленина, д. 135
797ee969-18ba-4f93-b0a2-77b5bea00bf4	Попов Евгений Петрович	555-666-7778	5555 666678	1978-08-05	г. Иркутск, ул. Лермонтова, д. 145
b9730830-e84d-4f7b-9fb1-287f68a33e8a	Donets Nikaly Olegovich	111-222-3333	1111 222233	1975-08-12	г. Москва, ул. Арбат, д. 5
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" ("Id", "FIO", "Telephone", "Login", "Password", "Role") FROM stdin;
049cffae-52f7-44f1-8912-41cb7b09b7c2	Иванов Иван Иванович	123-456-7890	ivanov	password123	1
3a3cffc6-9e7a-472d-ada2-53ddaac68a76	Петрова Мария Ивановна	234-567-8901	petrova	password456	3
ab72f753-1e0c-41ff-a14a-4dff10048f52	Сидорова Анна Петровна	345-678-9012	sidorova	password789	3
ab9477ed-7f7f-450c-bc15-89d367900e3e	Кузнецова Ольга Игоревна	456-789-0123	kuznetsova	password012	3
1987098c-8371-403e-8315-7650328fab0a	Фёдорова Елена Сергеевна	567-890-1234	fedorova	password345	3
a9bfde41-7c0b-4334-a2ed-2557aae8e279	Смирнова Наталья Андреевна	678-901-2345	smirnova	password678	3
dd248797-aa22-40ac-9316-a5892e5a1033	Морозова Дарья Дмитриевна	789-012-3456	morozova	password901	3
aecd0e0c-5a7b-41d6-ba0f-3b70043996f9	Новикова Юлия Алексеевна	890-123-4567	novikova	password234	3
9926bf28-71c0-4d18-96a4-9eecc24ec29f	Егоров Виктор Петрович	901-234-5678	egorov	password567	2
f7377f3b-068d-4163-ad89-3190126647cb	Сидоров Сергей Викторович	012-345-6789	sidorov	password890	2
87673641-9182-437c-bfba-3e2804565778	Павлов Александр Сергеевич	123-456-7891	pavlov	password1234	2
21454d8b-1076-4b17-bcec-4b4ef026049c	Романов Андрей Владимирович	234-567-8902	romanov	password4567	2
4db834a2-c3cf-497c-87bf-c253c055c36d	Михайлов Олег Дмитриевич	345-678-9013	mikhailov	password7890	2
ae7280e7-33e8-47bb-a11a-7866d977c568	Тимофеев Борис Артемович	456-789-0124	timofeev	password0123	2
\.


--
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20241127102925_Initial	9.0.0
20241129101213_UserUniqueConstraint	9.0.0
20241130120555_Add_date_to_appointment	9.0.0
20241201132810_Change relation analysis-appointment to 1-1	9.0.0
20241207013449_Add_delete_constraints	9.0.0
20241207021306_Change_some_properties_to_nullable	9.0.0
20241207021701_Examination_userid_nullable	9.0.0
20241207021926_Mark_userId_nullable	9.0.0
20241207022548_Add_uuid-ossp	9.0.0
20241208182609_change_appointmentId_to_not_required	9.0.0
\.


--
-- Name: Analyzes PK_Analyzes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Analyzes"
    ADD CONSTRAINT "PK_Analyzes" PRIMARY KEY ("Id");


--
-- Name: Appointments PK_Appointments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Appointments"
    ADD CONSTRAINT "PK_Appointments" PRIMARY KEY ("Id");


--
-- Name: Examinations PK_Examinations; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Examinations"
    ADD CONSTRAINT "PK_Examinations" PRIMARY KEY ("Id");


--
-- Name: Histories PK_Histories; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Histories"
    ADD CONSTRAINT "PK_Histories" PRIMARY KEY ("Id");


--
-- Name: Marks PK_Marks; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT "PK_Marks" PRIMARY KEY ("Id");


--
-- Name: Patients PK_Patients; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Patients"
    ADD CONSTRAINT "PK_Patients" PRIMARY KEY ("Id");


--
-- Name: Users PK_Users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");


--
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- Name: IX_Analyzes_AppointmentId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Analyzes_AppointmentId" ON public."Analyzes" USING btree ("AppointmentId");


--
-- Name: IX_Analyzes_HistoryId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Analyzes_HistoryId" ON public."Analyzes" USING btree ("HistoryId");


--
-- Name: IX_Appointments_ExaminationId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Appointments_ExaminationId" ON public."Appointments" USING btree ("ExaminationId");


--
-- Name: IX_Examinations_HistoryId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Examinations_HistoryId" ON public."Examinations" USING btree ("HistoryId");


--
-- Name: IX_Examinations_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Examinations_UserId" ON public."Examinations" USING btree ("UserId");


--
-- Name: IX_Histories_PatientId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Histories_PatientId" ON public."Histories" USING btree ("PatientId");


--
-- Name: IX_Histories_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Histories_UserId" ON public."Histories" USING btree ("UserId");


--
-- Name: IX_Marks_AppointmentId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Marks_AppointmentId" ON public."Marks" USING btree ("AppointmentId");


--
-- Name: IX_Marks_UserId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Marks_UserId" ON public."Marks" USING btree ("UserId");


--
-- Name: IX_Users_Login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Users_Login" ON public."Users" USING btree ("Login");


--
-- Name: Histories trigger_check_user_role; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_check_user_role BEFORE INSERT ON public."Histories" FOR EACH ROW EXECUTE FUNCTION public.check_user_role();


--
-- Name: Marks trigger_check_user_role_for_mark; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_check_user_role_for_mark BEFORE INSERT ON public."Marks" FOR EACH ROW EXECUTE FUNCTION public.check_user_role_for_mark();


--
-- Name: Analyzes trigger_generate_uuid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_generate_uuid BEFORE INSERT ON public."Analyzes" FOR EACH ROW EXECUTE FUNCTION public.generate_uuid();


--
-- Name: Appointments trigger_generate_uuid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_generate_uuid BEFORE INSERT ON public."Appointments" FOR EACH ROW EXECUTE FUNCTION public.generate_uuid();


--
-- Name: Examinations trigger_generate_uuid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_generate_uuid BEFORE INSERT ON public."Examinations" FOR EACH ROW EXECUTE FUNCTION public.generate_uuid();


--
-- Name: Histories trigger_generate_uuid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_generate_uuid BEFORE INSERT ON public."Histories" FOR EACH ROW EXECUTE FUNCTION public.generate_uuid();


--
-- Name: Marks trigger_generate_uuid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_generate_uuid BEFORE INSERT ON public."Marks" FOR EACH ROW EXECUTE FUNCTION public.generate_uuid();


--
-- Name: Patients trigger_generate_uuid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_generate_uuid BEFORE INSERT ON public."Patients" FOR EACH ROW EXECUTE FUNCTION public.generate_uuid();


--
-- Name: Users trigger_generate_uuid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_generate_uuid BEFORE INSERT ON public."Users" FOR EACH ROW EXECUTE FUNCTION public.generate_uuid();


--
-- Name: Analyzes FK_Analyzes_Appointments_AppointmentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Analyzes"
    ADD CONSTRAINT "FK_Analyzes_Appointments_AppointmentId" FOREIGN KEY ("AppointmentId") REFERENCES public."Appointments"("Id") ON DELETE SET NULL;


--
-- Name: Analyzes FK_Analyzes_Histories_HistoryId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Analyzes"
    ADD CONSTRAINT "FK_Analyzes_Histories_HistoryId" FOREIGN KEY ("HistoryId") REFERENCES public."Histories"("Id") ON DELETE CASCADE;


--
-- Name: Appointments FK_Appointments_Examinations_ExaminationId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Appointments"
    ADD CONSTRAINT "FK_Appointments_Examinations_ExaminationId" FOREIGN KEY ("ExaminationId") REFERENCES public."Examinations"("Id") ON DELETE CASCADE;


--
-- Name: Examinations FK_Examinations_Histories_HistoryId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Examinations"
    ADD CONSTRAINT "FK_Examinations_Histories_HistoryId" FOREIGN KEY ("HistoryId") REFERENCES public."Histories"("Id") ON DELETE CASCADE;


--
-- Name: Examinations FK_Examinations_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Examinations"
    ADD CONSTRAINT "FK_Examinations_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE SET NULL;


--
-- Name: Histories FK_Histories_Patients_PatientId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Histories"
    ADD CONSTRAINT "FK_Histories_Patients_PatientId" FOREIGN KEY ("PatientId") REFERENCES public."Patients"("Id") ON DELETE CASCADE;


--
-- Name: Histories FK_Histories_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Histories"
    ADD CONSTRAINT "FK_Histories_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE SET NULL;


--
-- Name: Marks FK_Marks_Appointments_AppointmentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT "FK_Marks_Appointments_AppointmentId" FOREIGN KEY ("AppointmentId") REFERENCES public."Appointments"("Id") ON DELETE CASCADE;


--
-- Name: Marks FK_Marks_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Marks"
    ADD CONSTRAINT "FK_Marks_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE SET NULL;


--
-- Name: TABLE "Analyzes"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public."Analyzes" TO doctors;
GRANT SELECT,INSERT ON TABLE public."Analyzes" TO sisters;


--
-- Name: TABLE "Appointments"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public."Appointments" TO doctors;
GRANT SELECT ON TABLE public."Appointments" TO sisters;


--
-- Name: TABLE "Examinations"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Examinations" TO doctors;
GRANT SELECT ON TABLE public."Examinations" TO sisters;


--
-- Name: TABLE "Histories"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public."Histories" TO doctors;
GRANT SELECT ON TABLE public."Histories" TO sisters;


--
-- Name: TABLE "Marks"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public."Marks" TO doctors;
GRANT SELECT,INSERT ON TABLE public."Marks" TO sisters;


--
-- Name: TABLE "Patients"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT ON TABLE public."Patients" TO doctors;
GRANT SELECT ON TABLE public."Patients" TO sisters;


--
-- Name: TABLE "Users"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public."Users" TO admins;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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


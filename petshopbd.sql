--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-05-28 00:54:34

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16453)
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    "Name" text,
    "Password" text
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16460)
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Users" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 219 (class 1259 OID 16427)
-- Name: cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart (
    id integer NOT NULL,
    catalog_id integer,
    "user" text,
    count integer
);


ALTER TABLE public.cart OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16437)
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cart ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 16399)
-- Name: catalog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalog (
    id integer NOT NULL,
    name text,
    description text,
    category_id integer,
    image_url text,
    price integer
);


ALTER TABLE public.catalog OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16402)
-- Name: catalog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.catalog ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.catalog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 16408)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name text
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16411)
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.category ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 16440)
-- Name: favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites (
    id integer NOT NULL,
    catalog_id integer,
    "user" text
);


ALTER TABLE public.favorites OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16447)
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.favorites ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4873 (class 0 OID 16453)
-- Dependencies: 223
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" (id, "Name", "Password") FROM stdin;
1	Nikita	nikita
\.


--
-- TOC entry 4869 (class 0 OID 16427)
-- Dependencies: 219
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart (id, catalog_id, "user", count) FROM stdin;
59	2	Nikita	2
61	3	Nikita	3
62	4	Nikita	2
63	15	Nikita	1
\.


--
-- TOC entry 4865 (class 0 OID 16399)
-- Dependencies: 215
-- Data for Name: catalog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalog (id, name, description, category_id, image_url, price) FROM stdin;
12	Корм для грызунов	рпорпопропр	1	https://4lapy.ru/resize/800x800/upload/iblock/38e/38e141651f8bc2bb9dfa20167edda067.jpg	823
3	Собачий корм	рпорпопропр	1	https://m.mirkorma.ru/upload/iblock/32a/32ac2125a2f23daeb2ebaef3dcea41bc.png	345
4	Корм для грызунов	43543543	1	https://4lapy.ru/resize/480x480/upload/iblock/2f6/2f69ac7c9eb91f3c1025e31a08882d2e.jpg	654
5	gfdgfd	gfhfghfghgfhfghfghgfhgf	2	\N	456
6	hgfhfghfg	hgbm nbmnb	3	\N	345
7	hfgdhfgdhfgh	ghfdghgfhfh	2	\N	233
8	Корм для рыбок	hgjhgjhgjhgjgh	1	https://www.dinozavrik.ru/upload/iblock/431/4316e46f0cb503256f05e80ff71c0500.png	236
9	Мяч	Обычный мяч	2	\N	653
13	Корм для грызунов	рпорпопропр	1	https://ir.ozone.ru/s3/multimedia-r/c1000/6078941619.jpg	532
14	Собачий корм	рпорпопропр	1	https://glavnoehvost.ru/upload/thumbs/source/productimage/image/7a99606-5e10-11ea-9710-d0509947687b9c76e1fe-5e94-11ea-9711-d0509947687b_6242c1aad4b2d.jpeg	235
15	Собачий корм	рпорпопропр	1	https://storage.yandexcloud.net/valta-storage-pictures/Goods/92aed165-a471-11ed-8183-005056bf23ce_1x1_1.jpg	164
16	Собачий корм	рпорпопропр	1	https://www.perfectfit.ru/upload/iblock/567/ad_M_L_chick_view_front.png	235
10	Корм для грызунов	рпорпопропр	1	https://img.bethowen.ru/upload/iblock/51f/51f229599600c60d878832bf5e20ff30.jpg	325
11	Собачий корм	рпорпопропр	1	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIkzE_mwL_5wSngDNeJu7VNCo9zKQfqQA1Bs6fC7_-0Q&s	368
17	Корм для змей	рпорпопропр	1	https://www.magazindoberman.ru/spree/products/000/020/997/original/Korobka-Myshm-novorozhdennye_%281%29.jpg?1586705291	525
18	Кошачий корм	рпорпопропр	1	https://catalog.detmir.st/media/GE0_95D7tgxpl7i_Mi37BPyOrO_LeAVGfhcB3THGkds=?preset=site_product_gallery_r1500	235
19	Корм для рыбок	рпорпопропр	1	https://zoosfera-nn.ru/images/detailed/678/3528ffcb599611dfa835002618badd88_2739764feb9e11eb80fa00155d331805.jpg	358
20	Корм для грызунов	рпорпопропр	1	https://kormzdes.ru/wa-data/public/shop/products/82/27/2782/images/3781/3781.970.jpg	820
21	Корм для рыбок	рпорпопропр	1	https://siniyej.ru/image/cache/catalog/food/dry/tetra_766402_korm-dlya-ryb---tetra-min-hlopya-12-g-1080x720.jpg	345
22	Корм для енотов	рпорпопропр	1	https://zveryatam.ru/images/products/b6/fe/product_img_5711.jpg	654
2	Корм для рыбок	акой корм станет любимым лакомством ваших аквариумных рыб, рептилий, птиц и других животных, ведь он содержит витамины и аминокислоты, которые улучшают состояние питомца и благотворно влияют на его здоровье. Сушеные крупные тушки гамаруса изготовлены исключительно натуральным путем - они высушены на солнце, без применения облучения или других технологий. При кормлении рачка можно растирать в хлопья (для насекомых, золотых рыбок, улиток ахатин, муравьев) или же давать в полноразмерной виде (водных красноухих или сухопутных черепах, ящериц, канареек). Сухой корм - источник протеина и каротиноидов, он очень легко усваивается в организме животного и способствует его полноценному развитию. Также рачки станут отличной прикормкой и приманкой для рыбалки на крупные виды (сом, щука, таймень) и охоты. Товары для аквариума расфасованы в удобную пластиковую тару объемом по 1 литру. Срок годности корма - 2 года.	1	https://i0.wp.com/lively-planet.ru/wp-content/uploads/2019/06/tetramin-flakes-1.png?fit=1000%2C1000&ssl=1	435
\.


--
-- TOC entry 4867 (class 0 OID 16408)
-- Dependencies: 217
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name) FROM stdin;
2	Шампуни и кондиционеры
3	Игрушки для животных
4	Ошейники и поводки
5	Клетки и вольеры
1	Корма и лакомства
\.


--
-- TOC entry 4871 (class 0 OID 16440)
-- Dependencies: 221
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorites (id, catalog_id, "user") FROM stdin;
49	9	Nikita
51	6	Nikita
54	2	Nikita
\.


--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 224
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_seq"', 1, true);


--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 220
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_id_seq', 63, true);


--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 216
-- Name: catalog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.catalog_id_seq', 22, true);


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 218
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 5, true);


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 222
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favorites_id_seq', 54, true);


--
-- TOC entry 4718 (class 2606 OID 16459)
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- TOC entry 4714 (class 2606 OID 16431)
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- TOC entry 4710 (class 2606 OID 16418)
-- Name: catalog catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT catalog_pkey PRIMARY KEY (id);


--
-- TOC entry 4712 (class 2606 OID 16420)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 4716 (class 2606 OID 16446)
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- TOC entry 4720 (class 2606 OID 16432)
-- Name: cart catalog_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT catalog_id FOREIGN KEY (catalog_id) REFERENCES public.catalog(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4721 (class 2606 OID 16448)
-- Name: favorites catalog_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT catalog_id FOREIGN KEY (catalog_id) REFERENCES public.catalog(id) NOT VALID;


--
-- TOC entry 4719 (class 2606 OID 16421)
-- Name: catalog category_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog
    ADD CONSTRAINT category_fk FOREIGN KEY (category_id) REFERENCES public.category(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


-- Completed on 2024-05-28 00:54:34

--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9

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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: carrier_configs; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.carrier_configs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid NOT NULL,
    carrier_id uuid NOT NULL,
    account_id uuid DEFAULT gen_random_uuid() NOT NULL,
    api_username text NOT NULL,
    api_password text NOT NULL,
    api_key1 text NOT NULL,
    api_key2 text NOT NULL,
    account_number text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.carrier_configs OWNER TO fleetar_app;

--
-- Name: carriers; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.carriers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    website text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.carriers OWNER TO fleetar_app;

--
-- Name: companies; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.companies (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.companies OWNER TO fleetar_app;

--
-- Name: company_contacts; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.company_contacts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_id uuid NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    phone text,
    email text,
    role text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.company_contacts OWNER TO fleetar_app;

--
-- Name: company_profiles; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.company_profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_id uuid NOT NULL,
    address text,
    phone text,
    email text,
    website text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.company_profiles OWNER TO fleetar_app;

--
-- Name: products; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid NOT NULL,
    company_id uuid,
    name text NOT NULL,
    description text NOT NULL,
    hscode text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.products OWNER TO fleetar_app;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    first_name text,
    last_name text,
    phone text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.profiles OWNER TO fleetar_app;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.sessions (
    id character varying(128) NOT NULL,
    expires bigint,
    session text NOT NULL
);


ALTER TABLE public.sessions OWNER TO fleetar_app;

--
-- Name: shipment_products; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.shipment_products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    shipment_id uuid NOT NULL,
    product_id uuid NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    unit_price numeric(10,4),
    total_value numeric(12,2) GENERATED ALWAYS AS (((quantity)::numeric * unit_price)) STORED,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT shipment_products_quantity_check CHECK ((quantity >= 1)),
    CONSTRAINT shipment_products_unit_price_check CHECK ((unit_price >= 0.1))
);


ALTER TABLE public.shipment_products OWNER TO fleetar_app;

--
-- Name: shipments; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.shipments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid NOT NULL,
    company_id uuid,
    origin text,
    destination text,
    status text DEFAULT 'Created'::text,
    com_description text,
    com_quantity integer,
    com_weight integer,
    com_height integer,
    com_width integer,
    com_chargeable_weight integer,
    po_number text,
    so_number text,
    tracking_number text,
    carrier_number text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.shipments OWNER TO fleetar_app;

--
-- Name: tenants; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.tenants (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    logo text,
    created_at timestamp without time zone DEFAULT now(),
    greetings text
);


ALTER TABLE public.tenants OWNER TO fleetar_app;

--
-- Name: users; Type: TABLE; Schema: public; Owner: fleetar_app
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tenant_id uuid NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    role text DEFAULT 'user'::text,
    full_name text
);


ALTER TABLE public.users OWNER TO fleetar_app;

--
-- Data for Name: carrier_configs; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.carrier_configs (id, tenant_id, carrier_id, account_id, api_username, api_password, api_key1, api_key2, account_number, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: carriers; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.carriers (id, name, website, created_at) FROM stdin;
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.companies (id, tenant_id, name, created_at) FROM stdin;
\.


--
-- Data for Name: company_contacts; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.company_contacts (id, company_id, first_name, last_name, phone, email, role, created_at) FROM stdin;
\.


--
-- Data for Name: company_profiles; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.company_profiles (id, company_id, address, phone, email, website, created_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.products (id, tenant_id, company_id, name, description, hscode, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.profiles (id, user_id, first_name, last_name, phone, created_at) FROM stdin;
a34f2533-2cce-44d3-b657-57f3b9a1f193	dd07697b-02a0-4d83-94b5-59edaaf35aec	df	sdlf	09	2025-10-20 13:21:28.910446
b1d39b5a-57d0-45a4-89ec-d3048baeeb79	90d907b1-3343-4b3e-ba6b-75d90e582089	max	junior	666	2025-10-20 11:08:38.538678
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.sessions (id, expires, session) FROM stdin;
013de91d-d02d-453e-8320-cdce01707ae3	1760976523	{"data":{},"longterm":false}
8859ba64-1113-4491-9306-f5f459c52c92	1760715482	{"data":{},"longterm":false}
c43477d2-119f-4cf7-b50c-cf98aae9b7f6	1760715482	{"data":{},"longterm":false}
b892e0ea-3f01-4dc5-9a2f-05813044a7e0	1760976523	{"data":{},"longterm":false}
6efe78d3-df23-4a09-b850-08d3fcf90cc5	1760970314	{"data":{},"longterm":false}
31a43d9c-0a22-4bf0-bd92-4ee06a65ec49	1760970314	{"data":{},"longterm":false}
0f8954aa-b1bb-41cc-853c-777005f659b4	1760722160	{"data":{},"longterm":false}
5719e555-7e78-4973-a26e-df7bd82a0c5c	1760969097	{"data":{},"longterm":false}
9fb1685d-0af1-47b4-8cef-4a0cffa8ac4f	1760969097	{"data":{},"longterm":false}
dfbcfe08-52cb-475a-9c11-6a8bae4bd4f4	1760722876	{"data":{"id":"\\"dc4b3ac2-f845-4ba6-87b8-2199e437d42c\\""},"longterm":false}
8bfd75df-6685-4aed-b277-82f6d16e912f	1760717792	{"data":{},"longterm":false}
046cc206-264a-45dd-8bea-100ac3bf743c	1760717792	{"data":{},"longterm":false}
ff468f50-d9e1-4b49-a22b-969d6840d363	1760717897	{"data":{},"longterm":false}
e2fd9625-fb23-4980-88ca-e0635e55ffcd	1760717897	{"data":{},"longterm":false}
8012b2af-f2af-4175-afc1-76aedb02f5c8	1760714734	{"data":{},"longterm":false}
d5fcd6db-d1cb-4b6f-a30b-0322c1eb9320	1760714734	{"data":{},"longterm":false}
9ee53d34-4816-42e7-a2ac-8a7546450564	1760972003	{"data":{},"longterm":false}
31f671fd-31e2-4feb-83d7-1a9858ca1f01	1760972003	{"data":{},"longterm":false}
8173cd9d-d0c7-49f5-b419-ded23f6f3b8e	1760988588	{"data":{"id":"\\"90d907b1-3343-4b3e-ba6b-75d90e582089\\""},"longterm":false}
49f66d4c-6762-4bf9-aed7-edafa5cd4fdb	1760756801	{"data":{"id":"\\"dc4b3ac2-f845-4ba6-87b8-2199e437d42c\\""},"longterm":false}
4694763d-c0ec-4a48-8b50-0ff5aba9a94a	1760711712	{"data":{},"longterm":false}
\.


--
-- Data for Name: shipment_products; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.shipment_products (id, shipment_id, product_id, quantity, unit_price, created_at) FROM stdin;
\.


--
-- Data for Name: shipments; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.shipments (id, tenant_id, company_id, origin, destination, status, com_description, com_quantity, com_weight, com_height, com_width, com_chargeable_weight, po_number, so_number, tracking_number, carrier_number, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.tenants (id, name, logo, created_at, greetings) FROM stdin;
5c36191d-bd28-4985-ab4a-75ce6ae43fab	HICHB	https://img.freepik.com/premium-vector/colorful-bird-wing-feather-logo-icon_23758-199.jpg?semt=ais_hybrid&w=740&q=80	2025-10-16 11:17:18.093133	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: fleetar_app
--

COPY public.users (id, tenant_id, email, password_hash, created_at, role, full_name) FROM stdin;
90d907b1-3343-4b3e-ba6b-75d90e582089	5c36191d-bd28-4985-ab4a-75ce6ae43fab	test@test.com	$argon2id$v=19$m=19456,t=2,p=1$NMFm5ZAL8xRR8mVSeabS2A$XnFmSxj2HSoGb8mfFRQBHF9XMjTZZG9ZBUA5vR8yq1w	2025-10-20 11:05:08.029552	Admin	max junior
dd07697b-02a0-4d83-94b5-59edaaf35aec	5c36191d-bd28-4985-ab4a-75ce6ae43fab	ghgf@sd.com	$argon2id$v=19$m=19456,t=2,p=1$fRT/D1QpWfh8zmDSAqOcnQ$sjg5QD2AkARm6CRKEQqrw7ghfb0kPhqEAzM9EhZiIdo	2025-10-20 13:21:28.899573	user	df sdlf
\.


--
-- Name: carrier_configs carrier_configs_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.carrier_configs
    ADD CONSTRAINT carrier_configs_pkey PRIMARY KEY (id);


--
-- Name: carrier_configs carrier_configs_tenant_id_carrier_id_account_id_key; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.carrier_configs
    ADD CONSTRAINT carrier_configs_tenant_id_carrier_id_account_id_key UNIQUE (tenant_id, carrier_id, account_id);


--
-- Name: carriers carriers_name_key; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.carriers
    ADD CONSTRAINT carriers_name_key UNIQUE (name);


--
-- Name: carriers carriers_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.carriers
    ADD CONSTRAINT carriers_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_contacts company_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.company_contacts
    ADD CONSTRAINT company_contacts_pkey PRIMARY KEY (id);


--
-- Name: company_profiles company_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.company_profiles
    ADD CONSTRAINT company_profiles_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: shipment_products shipment_products_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.shipment_products
    ADD CONSTRAINT shipment_products_pkey PRIMARY KEY (id);


--
-- Name: shipments shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_pkey PRIMARY KEY (id);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_companies_tenant; Type: INDEX; Schema: public; Owner: fleetar_app
--

CREATE INDEX idx_companies_tenant ON public.companies USING btree (tenant_id);


--
-- Name: idx_contacts_company; Type: INDEX; Schema: public; Owner: fleetar_app
--

CREATE INDEX idx_contacts_company ON public.company_contacts USING btree (company_id);


--
-- Name: idx_products_tenant; Type: INDEX; Schema: public; Owner: fleetar_app
--

CREATE INDEX idx_products_tenant ON public.products USING btree (tenant_id);


--
-- Name: idx_shipment_products_product; Type: INDEX; Schema: public; Owner: fleetar_app
--

CREATE INDEX idx_shipment_products_product ON public.shipment_products USING btree (product_id);


--
-- Name: idx_shipment_products_shipment; Type: INDEX; Schema: public; Owner: fleetar_app
--

CREATE INDEX idx_shipment_products_shipment ON public.shipment_products USING btree (shipment_id);


--
-- Name: idx_shipments_company; Type: INDEX; Schema: public; Owner: fleetar_app
--

CREATE INDEX idx_shipments_company ON public.shipments USING btree (company_id);


--
-- Name: idx_shipments_tenant; Type: INDEX; Schema: public; Owner: fleetar_app
--

CREATE INDEX idx_shipments_tenant ON public.shipments USING btree (tenant_id);


--
-- Name: idx_shipments_tracking; Type: INDEX; Schema: public; Owner: fleetar_app
--

CREATE INDEX idx_shipments_tracking ON public.shipments USING btree (tracking_number);


--
-- Name: idx_users_tenant; Type: INDEX; Schema: public; Owner: fleetar_app
--

CREATE INDEX idx_users_tenant ON public.users USING btree (tenant_id);


--
-- Name: carrier_configs carrier_configs_carrier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.carrier_configs
    ADD CONSTRAINT carrier_configs_carrier_id_fkey FOREIGN KEY (carrier_id) REFERENCES public.carriers(id) ON DELETE CASCADE;


--
-- Name: carrier_configs carrier_configs_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.carrier_configs
    ADD CONSTRAINT carrier_configs_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: companies companies_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: company_contacts company_contacts_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.company_contacts
    ADD CONSTRAINT company_contacts_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: company_profiles company_profiles_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.company_profiles
    ADD CONSTRAINT company_profiles_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: products products_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE SET NULL;


--
-- Name: products products_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: shipment_products shipment_products_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.shipment_products
    ADD CONSTRAINT shipment_products_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: shipment_products shipment_products_shipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.shipment_products
    ADD CONSTRAINT shipment_products_shipment_id_fkey FOREIGN KEY (shipment_id) REFERENCES public.shipments(id) ON DELETE CASCADE;


--
-- Name: shipments shipments_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE SET NULL;


--
-- Name: shipments shipments_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT shipments_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: users users_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fleetar_app
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO fleetar_app;


--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: checks; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE checks (
    id integer NOT NULL,
    name character varying(255),
    example character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    puppet_type character varying(255),
    environment_id integer
);


ALTER TABLE public.checks OWNER TO monitoring;

--
-- Name: checks_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.checks_id_seq OWNER TO monitoring;

--
-- Name: checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE checks_id_seq OWNED BY checks.id;


--
-- Name: checks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('checks_id_seq', 24, true);


--
-- Name: commands; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE commands (
    id integer NOT NULL,
    name character varying(255),
    command_line text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    environment_id integer
);


ALTER TABLE public.commands OWNER TO monitoring;

--
-- Name: commands_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE commands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.commands_id_seq OWNER TO monitoring;

--
-- Name: commands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE commands_id_seq OWNED BY commands.id;


--
-- Name: commands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('commands_id_seq', 20, true);


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE contacts (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    alias character varying(255),
    service_notification_options character varying(255),
    host_notification_options character varying(255),
    project_id integer,
    environment_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    password character varying(255),
    encrypted_password character varying(255)
);


ALTER TABLE public.contacts OWNER TO monitoring;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.contacts_id_seq OWNER TO monitoring;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE contacts_id_seq OWNED BY contacts.id;


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('contacts_id_seq', 1, false);


--
-- Name: environments; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE environments (
    id integer NOT NULL,
    name character varying(255),
    descriptiton character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.environments OWNER TO monitoring;

--
-- Name: environments_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE environments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.environments_id_seq OWNER TO monitoring;

--
-- Name: environments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE environments_id_seq OWNED BY environments.id;


--
-- Name: environments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('environments_id_seq', 2, true);


--
-- Name: host_groups; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE host_groups (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    project_id integer,
    environment_id integer
);


ALTER TABLE public.host_groups OWNER TO monitoring;

--
-- Name: host_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE host_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.host_groups_id_seq OWNER TO monitoring;

--
-- Name: host_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE host_groups_id_seq OWNED BY host_groups.id;


--
-- Name: host_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('host_groups_id_seq', 10, true);


--
-- Name: hosts; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE hosts (
    id integer NOT NULL,
    project_id integer,
    hostname character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    environment_id integer
);


ALTER TABLE public.hosts OWNER TO monitoring;

--
-- Name: hosts_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE hosts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.hosts_id_seq OWNER TO monitoring;

--
-- Name: hosts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE hosts_id_seq OWNED BY hosts.id;


--
-- Name: hosts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('hosts_id_seq', 1, true);


--
-- Name: projects; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.projects OWNER TO monitoring;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO monitoring;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('projects_id_seq', 3, true);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO monitoring;

--
-- Name: services; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE services (
    id integer NOT NULL,
    project_id integer,
    host_group_id integer,
    check_id integer,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    params character varying(255),
    host_id integer,
    environment_id integer,
    vip_id integer
);


ALTER TABLE public.services OWNER TO monitoring;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO monitoring;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE services_id_seq OWNED BY services.id;


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('services_id_seq', 55, true);


--
-- Name: users; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    admin boolean DEFAULT false NOT NULL,
    approved boolean DEFAULT false NOT NULL,
    project_id integer
);


ALTER TABLE public.users OWNER TO monitoring;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO monitoring;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('users_id_seq', 2, true);


--
-- Name: versions; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone
);


ALTER TABLE public.versions OWNER TO monitoring;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.versions_id_seq OWNER TO monitoring;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('versions_id_seq', 164, true);


--
-- Name: vips; Type: TABLE; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE TABLE vips (
    id integer NOT NULL,
    name character varying(255),
    ip character varying(255),
    project_id integer,
    environment_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.vips OWNER TO monitoring;

--
-- Name: vips_id_seq; Type: SEQUENCE; Schema: public; Owner: monitoring
--

CREATE SEQUENCE vips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.vips_id_seq OWNER TO monitoring;

--
-- Name: vips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: monitoring
--

ALTER SEQUENCE vips_id_seq OWNED BY vips.id;


--
-- Name: vips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: monitoring
--

SELECT pg_catalog.setval('vips_id_seq', 2, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY checks ALTER COLUMN id SET DEFAULT nextval('checks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY commands ALTER COLUMN id SET DEFAULT nextval('commands_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY contacts ALTER COLUMN id SET DEFAULT nextval('contacts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY environments ALTER COLUMN id SET DEFAULT nextval('environments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY host_groups ALTER COLUMN id SET DEFAULT nextval('host_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY hosts ALTER COLUMN id SET DEFAULT nextval('hosts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY services ALTER COLUMN id SET DEFAULT nextval('services_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: monitoring
--

ALTER TABLE ONLY vips ALTER COLUMN id SET DEFAULT nextval('vips_id_seq'::regclass);


--
-- Data for Name: checks; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY checks (id, name, example, created_at, updated_at, puppet_type, environment_id) FROM stdin;
1	load	-w 20,15,15 -c 35,30,30\t	2014-01-12 17:50:40.179486	2014-02-25 09:56:20.89057	monitorizacion::checks::load	2
2	disk	{"disk":"/dev/sda","args":"-w 20% -c 10%"}	2014-01-12 17:51:06.375071	2014-02-25 09:56:20.990889	monitorizacion::checks::disk	2
3	tcp	{"host":"google.com","port":"452","args":"-4"}	2014-01-12 17:51:32.925422	2014-02-25 09:56:21.008831	monitorizacion::checks::tcp	2
5	http	{"host":"google.com","port":"452","args":"-4"}	2014-01-13 09:01:48.088821	2014-02-25 09:56:21.040894	monitorizacion::checks::http	2
6	users	-w 5 -c 10	2014-01-13 09:02:33.428342	2014-02-25 09:56:21.053783	monitorizacion::checks::users	2
7	load	-w 20,15,15 -c 35,30,30\t	2014-02-25 10:22:56.045972	2014-02-25 10:22:56.045972	monitorizacion::checks::load	1
8	disk	{"disk":"/dev/sda","args":"-w 20% -c 10%"}	2014-02-25 10:22:56.291587	2014-02-25 10:22:56.291587	monitorizacion::checks::disk	1
9	tcp	{"host":"google.com","port":"452","args":"-4"}	2014-02-25 10:22:56.42712	2014-02-25 10:22:56.42712	monitorizacion::checks::tcp	1
10	procs	-w 150 -c 200	2014-02-25 10:22:56.455529	2014-02-25 10:22:56.455529	monitorizacion::checks::procs	1
11	http	{"host":"google.com","port":"452","args":"-4"}	2014-02-25 10:22:56.472905	2014-02-25 10:22:56.472905	monitorizacion::checks::http	1
12	users	-w 5 -c 10	2014-02-25 10:22:56.493616	2014-02-25 10:22:56.493616	monitorizacion::checks::users	1
13	swap	-w 10% -c 1%	2014-03-03 12:35:53.596471	2014-03-03 12:35:53.596471	monitorizacion::checks::swap	2
14	net_interfaces	no params	2014-03-03 12:39:33.853055	2014-03-03 12:39:47.086823	monitorizacion::checks::netinterfaces	2
15	mem_free	-w 15 -c 5	2014-03-03 12:42:18.051196	2014-03-03 12:42:18.051196	monitorizacion::checks::memfree	2
16	mem_used	-w 85 -c 95	2014-03-03 12:43:13.960433	2014-03-03 12:43:13.960433	monitorizacion::checks::memused	2
17	cpu	no params	2014-03-03 13:14:42.189243	2014-03-03 13:14:42.189243	monitorizacion::checks::cpu	2
18	calltrace	no params	2014-03-04 11:47:23.287302	2014-03-04 11:47:23.287302	monitorizacion::checks::calltrace	2
19	fs_writable	/usr	2014-03-04 12:26:13.204448	2014-03-04 12:26:13.204448	monitorizacion::checks::fswritable	2
20	logfiles	{"tag":"TXerror","logfile":"/var/log/file.log","args":"--criticalpattern='.*TX-error.*' --warningpattern='.*TX-warn'"}	2014-03-05 11:06:51.235679	2014-03-05 11:06:51.235679	monitorizacion::checks::logfiles	2
21	ssh	-t 10 localhost	2014-03-11 12:18:10.236656	2014-03-11 12:18:10.236656	monitorizacion::checks::ssh	2
22	apache	{"host":"localhost","measurement":"active_threads","args":"-w 4 -c 8"}	2014-03-14 10:46:46.987072	2014-03-14 10:46:46.987072	monitorizacion::checks::apache	2
23	apache_accesslog	{"access_log":"/var/log/httpd/access_log","analyze_time":"10","args":"-w 10 -c 20"}	2014-03-14 12:22:50.378942	2014-03-14 12:22:50.378942	monitorizacion::checks::apache_accesslog	2
24	http_header	{"host":"localhost","url":"/","port":"80","regex":"SAMEORIGIN","timeout":"5"}	2014-03-17 10:54:14.639308	2014-03-17 10:54:14.639308	monitorizacion::checks::http_header	2
4	procs	{"process":"ssh","args":"-w 10 -c 20 --metric=CPU"}	2014-01-13 09:01:31.150933	2014-03-20 13:48:29.18321	monitorizacion::checks::procs	2
\.


--
-- Data for Name: commands; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY commands (id, name, command_line, created_at, updated_at, environment_id) FROM stdin;
1	check-host-alive	$USER1$/check_ping -H $HOSTADDRESS$ -w 3000.0,80% -c 5000.0,100% -p 5\t	2014-01-13 08:41:49.740472	2014-02-25 09:56:38.961388	2
2	check_ping	$USER1$/check_ping -H $HOSTADDRESS$ -w $ARG1$ -c $ARG2$ -p 5\t	2014-01-13 08:42:03.311964	2014-02-25 09:56:38.986425	2
3	check_nrpe	$USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$\t	2014-01-13 08:42:14.806859	2014-02-25 09:56:39.004194	2
4	notify-host-by-email	/usr/bin/printf no definido	2014-01-13 09:07:46.622086	2014-02-25 09:56:39.029815	2
5	notify-service-by-email	/usr/bin/printf no definido	2014-01-13 09:07:57.869408	2014-02-25 09:56:39.048201	2
6	check_dummy	$USER1$/check_dummy $ARG1$	2014-01-13 09:08:15.482573	2014-02-25 09:56:39.062135	2
7	check_icinga_startup_delay	$USER1$/check_dummy 0 \\"Icinga started with $$(($EVENTSTARTTIME$-$PROCESSSTARTTIME$)) seconds delay | delay=$$(($EVENTSTARTTIME$-$PROCESSSTARTTIME$))\\"	2014-01-13 09:08:25.586283	2014-02-25 09:56:39.078446	2
8	process-host-perfdata	/usr/bin/printf not used	2014-01-13 09:08:40.103888	2014-02-25 09:56:39.092879	2
9	process-service-perfdata	/usr/bin/printf not used	2014-01-13 09:08:50.951338	2014-02-25 09:56:39.10647	2
10	check-host-alive	$USER1$/check_ping -H $HOSTADDRESS$ -w 3000.0,80% -c 5000.0,100% -p 5\t	2014-02-25 10:23:16.858841	2014-02-25 10:23:16.858841	1
11	check_ping	$USER1$/check_ping -H $HOSTADDRESS$ -w $ARG1$ -c $ARG2$ -p 5\t	2014-02-25 10:23:16.914786	2014-02-25 10:23:16.914786	1
12	check_nrpe	$USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$\t	2014-02-25 10:23:16.933608	2014-02-25 10:23:16.933608	1
13	notify-host-by-email	/usr/bin/printf no definido	2014-02-25 10:23:16.951119	2014-02-25 10:23:16.951119	1
14	notify-service-by-email	/usr/bin/printf no definido	2014-02-25 10:23:16.969709	2014-02-25 10:23:16.969709	1
15	check_dummy	$USER1$/check_dummy $ARG1$	2014-02-25 10:23:16.988501	2014-02-25 10:23:16.988501	1
16	check_icinga_startup_delay	$USER1$/check_dummy 0 \\"Icinga started with $$(($EVENTSTARTTIME$-$PROCESSSTARTTIME$)) seconds delay | delay=$$(($EVENTSTARTTIME$-$PROCESSSTARTTIME$))\\"	2014-02-25 10:23:17.0055	2014-02-25 10:23:17.0055	1
17	process-host-perfdata	/usr/bin/printf not used	2014-02-25 10:23:17.02423	2014-02-25 10:23:17.02423	1
18	process-service-perfdata	/usr/bin/printf not used	2014-02-25 10:23:17.041487	2014-02-25 10:23:17.041487	1
19	notify-service-by-email	/bin/echo	2014-03-03 11:46:35.946814	2014-03-03 11:46:35.946814	2
20	notify-host-by-email	/bin/echo	2014-03-03 11:46:55.847123	2014-03-03 11:46:55.847123	2
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY contacts (id, name, email, alias, service_notification_options, host_notification_options, project_id, environment_id, created_at, updated_at, password, encrypted_password) FROM stdin;
\.


--
-- Data for Name: environments; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY environments (id, name, descriptiton, created_at, updated_at) FROM stdin;
1	pro	Production environment	2014-02-25 09:55:15.144068	2014-02-25 09:55:15.144068
2	pre	Preproduction environment	2014-02-25 09:55:29.296816	2014-03-10 12:11:10.36745
\.


--
-- Data for Name: host_groups; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY host_groups (id, name, created_at, updated_at, project_id, environment_id) FROM stdin;
4	common	2014-01-12 17:53:47.329774	2014-02-25 09:58:08.438571	1	2
5	common	2014-01-12 17:54:18.576936	2014-02-25 09:58:08.45173	3	2
1	webserver	2014-01-12 17:52:41.612048	2014-02-25 09:58:08.464631	1	2
2	ftpserver	2014-01-12 17:52:41.627349	2014-02-25 09:58:08.478747	1	2
6	common	2014-02-25 10:23:37.876698	2014-02-25 10:23:37.876698	2	1
7	common	2014-02-25 10:23:37.934117	2014-02-25 10:23:37.934117	1	1
8	common	2014-02-25 10:23:37.954657	2014-02-25 10:23:37.954657	3	1
9	webserver	2014-02-25 10:23:37.971635	2014-02-25 10:23:37.971635	1	1
10	ftpserver	2014-02-25 10:23:37.991591	2014-02-25 10:23:37.991591	1	1
3	common	2014-01-12 17:53:11.846096	2014-03-19 10:18:01.02545	2	2
\.


--
-- Data for Name: hosts; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY hosts (id, project_id, hostname, created_at, updated_at, environment_id) FROM stdin;
1	1	client	2014-01-13 11:59:10.944061	2014-02-25 09:57:55.115674	2
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY projects (id, name, created_at, updated_at) FROM stdin;
1	m2m	2014-01-12 17:52:41.606597	2014-01-12 17:52:41.606597
2	common	2014-01-12 17:52:50.018081	2014-01-12 17:52:50.018081
3	bluevia	2014-01-12 17:54:18.571162	2014-01-12 17:54:18.571162
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY schema_migrations (version) FROM stdin;
20140112111130
20140108090354
20140106224530
20140106224725
20140108125341
20140107131537
20140106224522
20140107125625
20140107125723
20140106224538
20140106224717
20140106224508
20140113110918
20140113141545
20140113202730
20140114082426
20140211095100
20140212105813
20140212131249
20140212132241
20140212132252
20140212132259
20140212132316
20140220103254
20140220143723
20140220145800
20140221090526
20140221091545
20140306123928
20140306124917
20140318100229
20140318112130
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY services (id, project_id, host_group_id, check_id, name, created_at, updated_at, params, host_id, environment_id, vip_id) FROM stdin;
6	\N	5	3	google-pay	2014-01-12 17:54:18.580429	2014-02-25 09:58:24.225192	{"host":"pay.google.com","port":"443"}	\N	2	\N
12	\N	3	6	users	2014-01-13 09:04:41.596707	2014-02-25 09:58:24.275607		\N	2	\N
14	\N	\N	3	Check.tcp.cliente	2014-01-13 11:59:11.020162	2014-02-25 09:58:24.353044	{"host":"especifico.cliente.net","port":"21"}	1	2	\N
16	\N	\N	2	ftp	2014-01-13 12:39:35.125092	2014-02-25 09:58:24.38413	{"disk":"/srv/ftp","args":"-w 3000 -c 10"}	1	2	\N
30	\N	1	3	prueba	2014-03-03 11:59:56.785537	2014-03-03 11:59:56.785537	{"host":"prueba.cliente.net","port":"80"}	\N	2	\N
31	\N	2	3	cualquiercosa	2014-03-03 11:59:56.804323	2014-03-03 11:59:56.804323	{"host":"prueba.ftp.net","port":"21"}	\N	2	\N
4	\N	3	1	load	2014-01-12 17:53:11.847886	2014-03-03 13:18:02.631663		\N	2	\N
36	\N	3	17	cpu	2014-03-03 13:18:02.70871	2014-03-03 13:18:02.70871		\N	2	\N
37	\N	3	2	disk	2014-03-03 13:18:03.116038	2014-03-03 13:18:03.116038		\N	2	\N
38	\N	3	13	swap	2014-03-03 13:18:03.145348	2014-03-03 13:18:03.145348		\N	2	\N
39	\N	3	14	net_interfaces	2014-03-03 13:18:03.156642	2014-03-03 13:18:03.156642		\N	2	\N
40	\N	3	15	free_memory	2014-03-03 13:18:03.166462	2014-03-03 13:18:03.166462		\N	2	\N
41	\N	3	16	used_memory	2014-03-03 13:18:03.173528	2014-03-03 13:18:03.173528		\N	2	\N
29	\N	4	1	load	2014-03-03 11:59:56.646405	2014-03-03 13:21:53.938514	-w 20,15,10 -c 30,40,50	\N	2	\N
42	\N	3	18	calltrace	2014-03-04 11:48:22.189364	2014-03-04 11:48:22.189364		\N	2	\N
44	\N	\N	19	fs_writable	2014-03-04 12:33:33.120701	2014-03-04 12:33:33.120701	/usr	1	2	\N
45	\N	4	20	Fail-pass-ssh	2014-03-05 11:43:41.48048	2014-03-05 11:43:41.48048	{"tag":"SSH-fail","logfile":"/var/log/secure","args":"--criticalpattern='.*Failed password.*'"}	\N	2	\N
46	\N	3	21	ssh	2014-03-11 12:18:28.302864	2014-03-11 12:18:28.302864		\N	2	\N
47	\N	1	22	active_threads	2014-03-14 10:47:37.784638	2014-03-14 11:32:03.291777	{"measurement":"active_threads","args":"-w 4 -c 8"}	\N	2	\N
48	\N	1	22	apache_server_uptime	2014-03-14 11:32:04.540381	2014-03-14 11:32:04.540381	{"measurement":"server_uptime"}	\N	2	\N
49	\N	1	23	apache_general_access_log	2014-03-14 12:23:51.221072	2014-03-14 12:23:51.221072		\N	2	\N
50	\N	1	23	apache_ssl_access_log	2014-03-14 12:23:51.259781	2014-03-14 12:23:51.259781	{"access_log":"/var/log/httpd/ssl_access_log","args":"-w 5 -c 10"}	\N	2	\N
51	\N	1	24	http_whois	2014-03-17 10:55:31.9485	2014-03-17 10:55:31.9485	{"regex":"libssh2/1.4.2"}	\N	2	\N
52	\N	\N	3	google-VIP	2014-03-18 11:32:27.833685	2014-03-18 12:25:40.440516	{"host":"VIP.google.com","port":"443"}	\N	2	1
53	\N	\N	3	Apache	2014-03-18 12:49:09.983207	2014-03-18 12:49:09.983207	{"host":"VIP.APACHE.com","port":"1111"}	\N	2	2
11	\N	5	2	disco Raiz	2014-01-12 21:36:02.140757	2014-03-19 10:17:41.669723	{"disk":"/"}	\N	2	\N
54	\N	\N	5	interfaaces	2014-03-19 09:54:52.032637	2014-03-19 10:19:56.211509	{"host":"ada234.com"}	\N	2	1
55	\N	\N	3	caaaarga	2014-03-19 09:54:52.081639	2014-03-19 10:26:00.163591	{"host":"VIP.OTRA.com","port":"1111"}	\N	2	2
7	\N	3	4	processes	2014-01-12 20:55:13.695457	2014-03-20 13:49:06.885765	{"process":"sshd"}	\N	2	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, admin, approved, project_id) FROM stdin;
2	admin@admin.com	$2a$10$NxPZO0.q9Tisx1lZkcluKu2OJZJXF2XXn.FLFeQYZO9bk/43wMxUS	\N	\N	\N	1	2014-03-04 14:26:04.701461	2014-03-04 14:26:04.701461	192.168.51.1	192.168.51.1	2014-03-04 14:25:40.150875	2014-03-04 14:26:04.704621	t	t	2
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY versions (id, item_type, item_id, event, whodunnit, object, created_at) FROM stdin;
1	Check	1	update	\N	---\nid: 1\nname: load\nexample: ! "-w 20,15,15 -c 35,30,30\\t"\ncreated_at: 2014-01-12 17:50:40.179486000 Z\nupdated_at: 2014-01-13 09:00:15.169309000 Z\npuppet_type: monitorizacion::checks::load\nenvironment_id: \n	2014-02-25 09:56:20.968473
2	Check	2	update	\N	---\nid: 2\nname: disk\nexample: ! '{"disk":"/dev/sda","args":"-w 20% -c 10%"}'\ncreated_at: 2014-01-12 17:51:06.375071000 Z\nupdated_at: 2014-01-13 09:00:31.728670000 Z\npuppet_type: monitorizacion::checks::disk\nenvironment_id: \n	2014-02-25 09:56:21.000252
3	Check	3	update	\N	---\nid: 3\nname: tcp\nexample: ! '{"host":"google.com","port":"452","args":"-4"}'\ncreated_at: 2014-01-12 17:51:32.925422000 Z\nupdated_at: 2014-01-13 09:01:03.704240000 Z\npuppet_type: monitorizacion::checks::tcp\nenvironment_id: \n	2014-02-25 09:56:21.020986
4	Check	4	update	\N	---\nid: 4\nname: procs\nexample: -w 150 -c 200\ncreated_at: 2014-01-13 09:01:31.150933000 Z\nupdated_at: 2014-01-13 09:01:31.150933000 Z\npuppet_type: monitorizacion::checks::procs\nenvironment_id: \n	2014-02-25 09:56:21.034565
5	Check	5	update	\N	---\nid: 5\nname: http\nexample: ! '{"host":"google.com","port":"452","args":"-4"}'\ncreated_at: 2014-01-13 09:01:48.088821000 Z\nupdated_at: 2014-01-13 09:01:48.088821000 Z\npuppet_type: monitorizacion::checks::http\nenvironment_id: \n	2014-02-25 09:56:21.048049
6	Check	6	update	\N	---\nid: 6\nname: users\nexample: -w 5 -c 10\ncreated_at: 2014-01-13 09:02:33.428342000 Z\nupdated_at: 2014-01-13 09:02:33.428342000 Z\npuppet_type: monitorizacion::checks::users\nenvironment_id: \n	2014-02-25 09:56:21.059927
7	Command	1	update	\N	---\nid: 1\nname: check-host-alive\ncommand_line: ! "$USER1$/check_ping -H $HOSTADDRESS$ -w 3000.0,80% -c 5000.0,100%\n  -p 5\\t"\ncreated_at: 2014-01-13 08:41:49.740472000 Z\nupdated_at: 2014-01-13 08:41:49.740472000 Z\nenvironment_id: \n	2014-02-25 09:56:38.978075
8	Command	2	update	\N	---\nid: 2\nname: check_ping\ncommand_line: ! "$USER1$/check_ping -H $HOSTADDRESS$ -w $ARG1$ -c $ARG2$ -p 5\\t"\ncreated_at: 2014-01-13 08:42:03.311964000 Z\nupdated_at: 2014-01-13 08:42:03.311964000 Z\nenvironment_id: \n	2014-02-25 09:56:38.99618
9	Command	3	update	\N	---\nid: 3\nname: check_nrpe\ncommand_line: ! "$USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$\\t"\ncreated_at: 2014-01-13 08:42:14.806859000 Z\nupdated_at: 2014-01-13 08:42:14.806859000 Z\nenvironment_id: \n	2014-02-25 09:56:39.018082
10	Command	4	update	\N	---\nid: 4\nname: notify-host-by-email\ncommand_line: /usr/bin/printf no definido\ncreated_at: 2014-01-13 09:07:46.622086000 Z\nupdated_at: 2014-01-13 09:07:46.622086000 Z\nenvironment_id: \n	2014-02-25 09:56:39.040078
11	Command	5	update	\N	---\nid: 5\nname: notify-service-by-email\ncommand_line: /usr/bin/printf no definido\ncreated_at: 2014-01-13 09:07:57.869408000 Z\nupdated_at: 2014-01-13 09:07:57.869408000 Z\nenvironment_id: \n	2014-02-25 09:56:39.055311
12	Command	6	update	\N	---\nid: 6\nname: check_dummy\ncommand_line: $USER1$/check_dummy $ARG1$\ncreated_at: 2014-01-13 09:08:15.482573000 Z\nupdated_at: 2014-01-13 09:08:15.482573000 Z\nenvironment_id: \n	2014-02-25 09:56:39.071897
13	Command	7	update	\N	---\nid: 7\nname: check_icinga_startup_delay\ncommand_line: $USER1$/check_dummy 0 \\"Icinga started with $$(($EVENTSTARTTIME$-$PROCESSSTARTTIME$))\n  seconds delay | delay=$$(($EVENTSTARTTIME$-$PROCESSSTARTTIME$))\\"\ncreated_at: 2014-01-13 09:08:25.586283000 Z\nupdated_at: 2014-01-13 09:08:25.586283000 Z\nenvironment_id: \n	2014-02-25 09:56:39.085568
14	Command	8	update	\N	---\nid: 8\nname: process-host-perfdata\ncommand_line: /usr/bin/printf not used\ncreated_at: 2014-01-13 09:08:40.103888000 Z\nupdated_at: 2014-01-13 09:08:40.103888000 Z\nenvironment_id: \n	2014-02-25 09:56:39.100198
15	Command	9	update	\N	---\nid: 9\nname: process-service-perfdata\ncommand_line: /usr/bin/printf not used\ncreated_at: 2014-01-13 09:08:50.951338000 Z\nupdated_at: 2014-01-13 09:08:50.951338000 Z\nenvironment_id: \n	2014-02-25 09:56:39.115026
16	Host	1	update	\N	---\nid: 1\nproject_id: 1\nhostname: client\ncreated_at: 2014-01-13 11:59:10.944061000 Z\nupdated_at: 2014-01-13 11:59:10.944061000 Z\nenvironment_id: \n	2014-02-25 09:57:55.132663
17	HostGroup	3	update	\N	---\nid: 3\nname: common\ncreated_at: 2014-01-12 17:53:11.846096000 Z\nupdated_at: 2014-01-12 17:53:11.846096000 Z\nproject_id: 2\nenvironment_id: \n	2014-02-25 09:58:08.43033
18	HostGroup	4	update	\N	---\nid: 4\nname: common\ncreated_at: 2014-01-12 17:53:47.329774000 Z\nupdated_at: 2014-01-12 17:53:47.329774000 Z\nproject_id: 1\nenvironment_id: \n	2014-02-25 09:58:08.445779
19	HostGroup	5	update	\N	---\nid: 5\nname: common\ncreated_at: 2014-01-12 17:54:18.576936000 Z\nupdated_at: 2014-01-12 17:54:18.576936000 Z\nproject_id: 3\nenvironment_id: \n	2014-02-25 09:58:08.458678
20	HostGroup	1	update	\N	---\nid: 1\nname: webserver\ncreated_at: 2014-01-12 17:52:41.612048000 Z\nupdated_at: 2014-01-12 20:57:46.884834000 Z\nproject_id: 1\nenvironment_id: \n	2014-02-25 09:58:08.470309
21	HostGroup	2	update	\N	---\nid: 2\nname: ftpserver\ncreated_at: 2014-01-12 17:52:41.627349000 Z\nupdated_at: 2014-01-12 20:57:46.888363000 Z\nproject_id: 1\nenvironment_id: \n	2014-02-25 09:58:08.48628
22	Service	1	update	\N	---\nid: 1\nproject_id: \nhost_group_id: 1\ncheck_id: 3\nname: conexion-google\ncreated_at: 2014-01-12 17:52:41.616310000 Z\nupdated_at: 2014-01-12 17:52:41.616310000 Z\nparams: ! '{"host":"google.com","port":"80"}'\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.216388
23	Service	6	update	\N	---\nid: 6\nproject_id: \nhost_group_id: 5\ncheck_id: 3\nname: google-pay\ncreated_at: 2014-01-12 17:54:18.580429000 Z\nupdated_at: 2014-01-12 17:54:18.580429000 Z\nparams: ! '{"host":"pay.google.com","port":"443"}'\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.234262
24	Service	4	update	\N	---\nid: 4\nproject_id: \nhost_group_id: 3\ncheck_id: 1\nname: carga\ncreated_at: 2014-01-12 17:53:11.847886000 Z\nupdated_at: 2014-01-13 09:04:41.562747000 Z\nparams: ''\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.245651
25	Service	7	update	\N	---\nid: 7\nproject_id: \nhost_group_id: 3\ncheck_id: 4\nname: procesos\ncreated_at: 2014-01-12 20:55:13.695457000 Z\nupdated_at: 2014-01-13 09:04:41.591736000 Z\nparams: ''\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.262119
26	Service	12	update	\N	---\nid: 12\nproject_id: \nhost_group_id: 3\ncheck_id: 6\nname: users\ncreated_at: 2014-01-13 09:04:41.596707000 Z\nupdated_at: 2014-01-13 09:04:41.596707000 Z\nparams: ''\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.288012
27	Service	9	update	\N	---\nid: 9\nproject_id: \nhost_group_id: 4\ncheck_id: 1\nname: carga\ncreated_at: 2014-01-12 21:33:38.660945000 Z\nupdated_at: 2014-01-13 09:06:04.854684000 Z\nparams: -w 10,10,10 -c 20,20,20\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.306011
28	Service	10	update	\N	---\nid: 10\nproject_id: \nhost_group_id: 1\ncheck_id: 1\nname: carga\ncreated_at: 2014-01-12 21:34:23.165119000 Z\nupdated_at: 2014-01-13 09:06:04.858723000 Z\nparams: -w 10,15,20 -c 25,30,35\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.318259
29	Service	11	update	\N	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 2\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-01-13 09:06:42.884734000 Z\nparams: ! '{"disk":"/"}'\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.332178
30	Service	13	update	\N	---\nid: 13\nproject_id: \nhost_group_id: 2\ncheck_id: 3\nname: conex con yahoo\ncreated_at: 2014-01-13 10:19:24.578361000 Z\nupdated_at: 2014-01-13 10:19:24.578361000 Z\nparams: ! '{"host":"yahoo.com","port":"443"}'\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.346489
135	Service	49	create	2	\N	2014-03-14 12:23:51.227801
136	Service	50	create	2	\N	2014-03-14 12:23:51.263951
139	Service	52	create	2	\N	2014-03-18 11:32:27.896289
31	Service	14	update	\N	---\nid: 14\nproject_id: \nhost_group_id: \ncheck_id: 3\nname: Check.tcp.cliente\ncreated_at: 2014-01-13 11:59:11.020162000 Z\nupdated_at: 2014-01-13 12:16:32.668550000 Z\nparams: ! '{"host":"especifico.cliente.net","port":"21"}'\nhost_id: 1\nenvironment_id: \n	2014-02-25 09:58:24.360016
32	Service	3	update	\N	---\nid: 3\nproject_id: \nhost_group_id: 2\ncheck_id: 2\nname: ftp\ncreated_at: 2014-01-12 17:52:41.677698000 Z\nupdated_at: 2014-01-13 12:34:36.885301000 Z\nparams: ! '{"disk":"/srv/ftp","args":"-w 222 -c 222"}'\nhost_id: \nenvironment_id: \n	2014-02-25 09:58:24.374917
33	Service	16	update	\N	---\nid: 16\nproject_id: \nhost_group_id: \ncheck_id: 2\nname: ftp\ncreated_at: 2014-01-13 12:39:35.125092000 Z\nupdated_at: 2014-01-13 12:39:35.125092000 Z\nparams: ! '{"disk":"/srv/ftp","args":"-w 3000 -c 10"}'\nhost_id: 1\nenvironment_id: \n	2014-02-25 09:58:24.394885
34	Check	7	create	\N	\N	2014-02-25 10:22:56.246335
35	Check	8	create	\N	\N	2014-02-25 10:22:56.305346
36	Check	9	create	\N	\N	2014-02-25 10:22:56.441593
37	Check	10	create	\N	\N	2014-02-25 10:22:56.459314
38	Check	11	create	\N	\N	2014-02-25 10:22:56.479312
39	Check	12	create	\N	\N	2014-02-25 10:22:56.503014
40	Command	10	create	\N	\N	2014-02-25 10:23:16.90076
41	Command	11	create	\N	\N	2014-02-25 10:23:16.921772
42	Command	12	create	\N	\N	2014-02-25 10:23:16.941668
43	Command	13	create	\N	\N	2014-02-25 10:23:16.959803
44	Command	14	create	\N	\N	2014-02-25 10:23:16.976289
45	Command	15	create	\N	\N	2014-02-25 10:23:16.992424
46	Command	16	create	\N	\N	2014-02-25 10:23:17.011297
47	Command	17	create	\N	\N	2014-02-25 10:23:17.030361
48	Command	18	create	\N	\N	2014-02-25 10:23:17.048398
49	HostGroup	6	create	\N	\N	2014-02-25 10:23:37.919498
50	HostGroup	7	create	\N	\N	2014-02-25 10:23:37.945128
51	HostGroup	8	create	\N	\N	2014-02-25 10:23:37.958565
52	HostGroup	9	create	\N	\N	2014-02-25 10:23:37.979372
53	HostGroup	10	create	\N	\N	2014-02-25 10:23:38.001323
54	Service	17	create	\N	\N	2014-02-25 10:23:53.380785
55	Service	18	create	\N	\N	2014-02-25 10:23:53.409959
56	Service	19	create	\N	\N	2014-02-25 10:23:53.434003
57	Service	20	create	\N	\N	2014-02-25 10:23:53.457502
58	Service	21	create	\N	\N	2014-02-25 10:23:53.485325
59	Service	22	create	\N	\N	2014-02-25 10:23:53.50483
60	Service	23	create	\N	\N	2014-02-25 10:23:53.528698
61	Service	24	create	\N	\N	2014-02-25 10:23:53.550465
62	Service	25	create	\N	\N	2014-02-25 10:23:53.575815
63	Service	26	create	\N	\N	2014-02-25 10:23:53.600763
64	Service	27	create	\N	\N	2014-02-25 10:23:53.628978
65	Service	28	create	\N	\N	2014-02-25 10:23:53.657309
66	User	1	create	\N	\N	2014-03-03 11:43:12.898303
67	User	1	update	\N	---\nid: 1\nemail: alvaro@alvaro.es\nencrypted_password: $2a$10$fPKpiSF6Ik51lwbHj0Rnle52DgMMbtQJ0mOLHZD.4dg2TwBTfdB4W\nreset_password_token: \nreset_password_sent_at: \nremember_created_at: \nsign_in_count: 0\ncurrent_sign_in_at: \nlast_sign_in_at: \ncurrent_sign_in_ip: \nlast_sign_in_ip: \ncreated_at: 2014-03-03 11:43:12.544430000 Z\nupdated_at: 2014-03-03 11:43:12.544430000 Z\nadmin: false\napproved: false\nproject_id: 2\n	2014-03-03 11:44:49.936436
68	User	1	update	\N	---\nid: 1\nemail: alvaro@alvaro.es\nencrypted_password: $2a$10$fPKpiSF6Ik51lwbHj0Rnle52DgMMbtQJ0mOLHZD.4dg2TwBTfdB4W\nreset_password_token: \nreset_password_sent_at: \nremember_created_at: \nsign_in_count: 0\ncurrent_sign_in_at: \nlast_sign_in_at: \ncurrent_sign_in_ip: \nlast_sign_in_ip: \ncreated_at: 2014-03-03 11:43:12.544430000 Z\nupdated_at: 2014-03-03 11:44:48.620059000 Z\nadmin: true\napproved: true\nproject_id: 2\n	2014-03-03 11:44:56.786749
69	Command	19	create	1	\N	2014-03-03 11:46:36.05361
70	Command	20	create	1	\N	2014-03-03 11:46:56.123556
71	Service	9	destroy	1	---\nid: 9\nproject_id: \nhost_group_id: 4\ncheck_id: 1\nname: carga\ncreated_at: 2014-01-12 21:33:38.660945000 Z\nupdated_at: 2014-02-25 09:58:24.296691000 Z\nparams: -w 10,10,10 -c 20,20,20\nhost_id: \nenvironment_id: 2\n	2014-03-03 11:50:38.673535
72	Service	22	destroy	1	---\nid: 22\nproject_id: \nhost_group_id: 4\ncheck_id: 1\nname: carga\ncreated_at: 2014-02-25 10:23:53.497578000 Z\nupdated_at: 2014-02-25 10:23:53.497578000 Z\nparams: -w 10,10,10 -c 20,20,20\nhost_id: \nenvironment_id: 1\n	2014-03-03 11:50:38.723599
73	Service	1	destroy	1	---\nid: 1\nproject_id: \nhost_group_id: 1\ncheck_id: 3\nname: conexion-google\ncreated_at: 2014-01-12 17:52:41.616310000 Z\nupdated_at: 2014-02-25 09:58:24.198733000 Z\nparams: ! '{"host":"google.com","port":"80"}'\nhost_id: \nenvironment_id: 2\n	2014-03-03 11:50:38.752304
74	Service	10	destroy	1	---\nid: 10\nproject_id: \nhost_group_id: 1\ncheck_id: 1\nname: carga\ncreated_at: 2014-01-12 21:34:23.165119000 Z\nupdated_at: 2014-02-25 09:58:24.311638000 Z\nparams: -w 10,15,20 -c 25,30,35\nhost_id: \nenvironment_id: 2\n	2014-03-03 11:50:38.766545
75	Service	17	destroy	1	---\nid: 17\nproject_id: \nhost_group_id: 1\ncheck_id: 3\nname: conexion-google\ncreated_at: 2014-02-25 10:23:53.315334000 Z\nupdated_at: 2014-02-25 10:23:53.315334000 Z\nparams: ! '{"host":"google.com","port":"80"}'\nhost_id: \nenvironment_id: 1\n	2014-03-03 11:50:38.77564
76	Service	23	destroy	1	---\nid: 23\nproject_id: \nhost_group_id: 1\ncheck_id: 1\nname: carga\ncreated_at: 2014-02-25 10:23:53.521108000 Z\nupdated_at: 2014-02-25 10:23:53.521108000 Z\nparams: -w 10,15,20 -c 25,30,35\nhost_id: \nenvironment_id: 1\n	2014-03-03 11:50:38.785385
77	Service	13	destroy	1	---\nid: 13\nproject_id: \nhost_group_id: 2\ncheck_id: 3\nname: conex con yahoo\ncreated_at: 2014-01-13 10:19:24.578361000 Z\nupdated_at: 2014-02-25 09:58:24.338661000 Z\nparams: ! '{"host":"yahoo.com","port":"443"}'\nhost_id: \nenvironment_id: 2\n	2014-03-03 11:50:38.808851
78	Service	3	destroy	1	---\nid: 3\nproject_id: \nhost_group_id: 2\ncheck_id: 2\nname: ftp\ncreated_at: 2014-01-12 17:52:41.677698000 Z\nupdated_at: 2014-02-25 09:58:24.366832000 Z\nparams: ! '{"disk":"/srv/ftp","args":"-w 222 -c 222"}'\nhost_id: \nenvironment_id: 2\n	2014-03-03 11:50:38.819551
79	Service	25	destroy	1	---\nid: 25\nproject_id: \nhost_group_id: 2\ncheck_id: 3\nname: conex con yahoo\ncreated_at: 2014-02-25 10:23:53.569014000 Z\nupdated_at: 2014-02-25 10:23:53.569014000 Z\nparams: ! '{"host":"yahoo.com","port":"443"}'\nhost_id: \nenvironment_id: 1\n	2014-03-03 11:50:38.829713
80	Service	27	destroy	1	---\nid: 27\nproject_id: \nhost_group_id: 2\ncheck_id: 2\nname: ftp\ncreated_at: 2014-02-25 10:23:53.619980000 Z\nupdated_at: 2014-02-25 10:23:53.619980000 Z\nparams: ! '{"disk":"/srv/ftp","args":"-w 222 -c 222"}'\nhost_id: \nenvironment_id: 1\n	2014-03-03 11:50:38.842586
81	Service	29	create	1	\N	2014-03-03 11:59:56.777322
82	Service	30	create	1	\N	2014-03-03 11:59:56.790988
83	Service	31	create	1	\N	2014-03-03 11:59:56.810969
84	Service	26	update	1	---\nid: 26\nproject_id: \nhost_group_id: \ncheck_id: 3\nname: Check.tcp.cliente\ncreated_at: 2014-02-25 10:23:53.591818000 Z\nupdated_at: 2014-02-25 10:23:53.591818000 Z\nparams: ! '{"host":"especifico.cliente.net","port":"21"}'\nhost_id: 1\nenvironment_id: 1\n	2014-03-03 11:59:57.027033
85	Service	28	update	1	---\nid: 28\nproject_id: \nhost_group_id: \ncheck_id: 2\nname: ftp\ncreated_at: 2014-02-25 10:23:53.645203000 Z\nupdated_at: 2014-02-25 10:23:53.645203000 Z\nparams: ! '{"disk":"/srv/ftp","args":"-w 3000 -c 10"}'\nhost_id: 1\nenvironment_id: 1\n	2014-03-03 11:59:57.05311
86	Check	13	create	1	\N	2014-03-03 12:35:53.719538
87	Check	14	create	1	\N	2014-03-03 12:39:34.085787
137	Check	24	create	2	\N	2014-03-17 10:54:14.82034
138	Service	51	create	2	\N	2014-03-17 10:55:31.965091
88	Check	14	update	1	---\nid: 14\nname: net_interfaces\nexample: without params\ncreated_at: 2014-03-03 12:39:33.853055000 Z\nupdated_at: 2014-03-03 12:39:33.853055000 Z\npuppet_type: monitorizacion::checks::netinterfaces\nenvironment_id: 2\n	2014-03-03 12:39:47.539566
89	Check	15	create	1	\N	2014-03-03 12:42:18.061893
90	Check	16	create	1	\N	2014-03-03 12:43:13.986817
91	Service	32	create	1	\N	2014-03-03 12:45:23.636488
92	Service	33	create	1	\N	2014-03-03 12:45:23.653559
93	Service	34	create	1	\N	2014-03-03 12:45:23.661859
94	Service	35	create	1	\N	2014-03-03 12:45:23.671517
95	Check	17	create	1	\N	2014-03-03 13:14:42.613804
96	Service	19	destroy	1	---\nid: 19\nproject_id: \nhost_group_id: 3\ncheck_id: 1\nname: carga\ncreated_at: 2014-02-25 10:23:53.423553000 Z\nupdated_at: 2014-02-25 10:23:53.423553000 Z\nparams: ''\nhost_id: \nenvironment_id: 1\n	2014-03-03 13:18:02.526444
97	Service	20	destroy	1	---\nid: 20\nproject_id: \nhost_group_id: 3\ncheck_id: 4\nname: procesos\ncreated_at: 2014-02-25 10:23:53.449392000 Z\nupdated_at: 2014-02-25 10:23:53.449392000 Z\nparams: ''\nhost_id: \nenvironment_id: 1\n	2014-03-03 13:18:02.610765
98	Service	21	destroy	1	---\nid: 21\nproject_id: \nhost_group_id: 3\ncheck_id: 6\nname: users\ncreated_at: 2014-02-25 10:23:53.474512000 Z\nupdated_at: 2014-02-25 10:23:53.474512000 Z\nparams: ''\nhost_id: \nenvironment_id: 1\n	2014-03-03 13:18:02.624311
99	Service	4	update	1	---\nid: 4\nproject_id: \nhost_group_id: 3\ncheck_id: 1\nname: carga\ncreated_at: 2014-01-12 17:53:11.847886000 Z\nupdated_at: 2014-02-25 09:58:24.239716000 Z\nparams: ''\nhost_id: \nenvironment_id: 2\n	2014-03-03 13:18:02.673739
100	Service	7	update	1	---\nid: 7\nproject_id: \nhost_group_id: 3\ncheck_id: 4\nname: procesos\ncreated_at: 2014-01-12 20:55:13.695457000 Z\nupdated_at: 2014-02-25 09:58:24.252355000 Z\nparams: ''\nhost_id: \nenvironment_id: 2\n	2014-03-03 13:18:02.70454
101	Service	36	create	1	\N	2014-03-03 13:18:02.713574
102	Service	37	create	1	\N	2014-03-03 13:18:03.136775
103	Service	38	create	1	\N	2014-03-03 13:18:03.150867
104	Service	39	create	1	\N	2014-03-03 13:18:03.163336
105	Service	40	create	1	\N	2014-03-03 13:18:03.170743
106	Service	41	create	1	\N	2014-03-03 13:18:03.187508
107	Service	32	destroy	1	---\nid: 32\nproject_id: \nhost_group_id: 4\ncheck_id: 14\nname: interfaces\ncreated_at: 2014-03-03 12:45:23.576373000 Z\nupdated_at: 2014-03-03 12:45:23.576373000 Z\nparams: ''\nhost_id: \nenvironment_id: 2\n	2014-03-03 13:18:25.82298
108	Service	33	destroy	1	---\nid: 33\nproject_id: \nhost_group_id: 4\ncheck_id: 15\nname: mem_free\ncreated_at: 2014-03-03 12:45:23.646751000 Z\nupdated_at: 2014-03-03 12:45:23.646751000 Z\nparams: ''\nhost_id: \nenvironment_id: 2\n	2014-03-03 13:18:25.83049
109	Service	34	destroy	1	---\nid: 34\nproject_id: \nhost_group_id: 4\ncheck_id: 16\nname: mem_used\ncreated_at: 2014-03-03 12:45:23.656205000 Z\nupdated_at: 2014-03-03 12:45:23.656205000 Z\nparams: -w 15 -c 20\nhost_id: \nenvironment_id: 2\n	2014-03-03 13:18:25.860104
110	Service	35	destroy	1	---\nid: 35\nproject_id: \nhost_group_id: 4\ncheck_id: 13\nname: swap\ncreated_at: 2014-03-03 12:45:23.666467000 Z\nupdated_at: 2014-03-03 12:45:23.666467000 Z\nparams: ''\nhost_id: \nenvironment_id: 2\n	2014-03-03 13:18:25.883034
111	Service	26	destroy	1	---\nid: 26\nproject_id: \nhost_group_id: \ncheck_id: 3\nname: Check.tcp.cliente\ncreated_at: 2014-02-25 10:23:53.591818000 Z\nupdated_at: 2014-03-03 11:59:56.817728000 Z\nparams: ! '{"host":"especifico.cliente.net","port":"21"}'\nhost_id: 1\nenvironment_id: 2\n	2014-03-03 13:18:25.907885
112	Service	28	destroy	1	---\nid: 28\nproject_id: \nhost_group_id: \ncheck_id: 2\nname: ftp\ncreated_at: 2014-02-25 10:23:53.645203000 Z\nupdated_at: 2014-03-03 11:59:57.037635000 Z\nparams: ! '{"disk":"/srv/ftp","args":"-w 3000 -c 10"}'\nhost_id: 1\nenvironment_id: 2\n	2014-03-03 13:18:25.931258
113	Service	18	destroy	1	---\nid: 18\nproject_id: \nhost_group_id: 5\ncheck_id: 3\nname: google-pay\ncreated_at: 2014-02-25 10:23:53.397573000 Z\nupdated_at: 2014-02-25 10:23:53.397573000 Z\nparams: ! '{"host":"pay.google.com","port":"443"}'\nhost_id: \nenvironment_id: 1\n	2014-03-03 13:18:37.0967
114	Service	24	destroy	1	---\nid: 24\nproject_id: \nhost_group_id: 5\ncheck_id: 2\nname: disco Raiz\ncreated_at: 2014-02-25 10:23:53.542775000 Z\nupdated_at: 2014-02-25 10:23:53.542775000 Z\nparams: ! '{"disk":"/"}'\nhost_id: \nenvironment_id: 1\n	2014-03-03 13:18:37.115747
115	Service	29	update	1	---\nid: 29\nproject_id: \nhost_group_id: 4\ncheck_id: 1\nname: carga\ncreated_at: 2014-03-03 11:59:56.646405000 Z\nupdated_at: 2014-03-03 11:59:56.646405000 Z\nparams: -w 20,15,10 -c 30,40,50\nhost_id: \nenvironment_id: 2\n	2014-03-03 13:21:56.330519
116	Check	18	create	1	\N	2014-03-04 11:47:23.67574
117	Service	42	create	1	\N	2014-03-04 11:48:22.212681
118	Check	19	create	1	\N	2014-03-04 12:26:13.30744
119	Service	43	create	1	\N	2014-03-04 12:26:35.371918
120	Service	43	destroy	1	---\nid: 43\nproject_id: \nhost_group_id: 3\ncheck_id: 19\nname: fs_writable\ncreated_at: 2014-03-04 12:26:35.357559000 Z\nupdated_at: 2014-03-04 12:26:35.357559000 Z\nparams: ''\nhost_id: \nenvironment_id: 2\n	2014-03-04 12:32:50.065404
121	Service	44	create	1	\N	2014-03-04 12:33:33.146248
122	User	2	create	\N	\N	2014-03-04 14:25:40.369959
123	User	2	update	\N	---\nid: 2\nemail: admin@admin.com\nencrypted_password: $2a$10$NxPZO0.q9Tisx1lZkcluKu2OJZJXF2XXn.FLFeQYZO9bk/43wMxUS\nreset_password_token: \nreset_password_sent_at: \nremember_created_at: \nsign_in_count: 0\ncurrent_sign_in_at: \nlast_sign_in_at: \ncurrent_sign_in_ip: \nlast_sign_in_ip: \ncreated_at: 2014-03-04 14:25:40.150875000 Z\nupdated_at: 2014-03-04 14:25:40.150875000 Z\nadmin: false\napproved: false\nproject_id: 2\n	2014-03-04 14:26:00.808555
124	User	2	update	\N	---\nid: 2\nemail: admin@admin.com\nencrypted_password: $2a$10$NxPZO0.q9Tisx1lZkcluKu2OJZJXF2XXn.FLFeQYZO9bk/43wMxUS\nreset_password_token: \nreset_password_sent_at: \nremember_created_at: \nsign_in_count: 0\ncurrent_sign_in_at: \nlast_sign_in_at: \ncurrent_sign_in_ip: \nlast_sign_in_ip: \ncreated_at: 2014-03-04 14:25:40.150875000 Z\nupdated_at: 2014-03-04 14:26:00.672220000 Z\nadmin: true\napproved: true\nproject_id: 2\n	2014-03-04 14:26:04.727826
125	User	1	destroy	2	---\nid: 1\nemail: alvaro@alvaro.es\nencrypted_password: $2a$10$fPKpiSF6Ik51lwbHj0Rnle52DgMMbtQJ0mOLHZD.4dg2TwBTfdB4W\nreset_password_token: \nreset_password_sent_at: \nremember_created_at: \nsign_in_count: 1\ncurrent_sign_in_at: 2014-03-03 11:44:56.454522000 Z\nlast_sign_in_at: 2014-03-03 11:44:56.454522000 Z\ncurrent_sign_in_ip: 192.168.51.1\nlast_sign_in_ip: 192.168.51.1\ncreated_at: 2014-03-03 11:43:12.544430000 Z\nupdated_at: 2014-03-03 11:44:56.506793000 Z\nadmin: true\napproved: true\nproject_id: 2\n	2014-03-04 14:26:34.64602
126	Check	20	create	2	\N	2014-03-05 11:06:51.259008
127	Service	45	create	2	\N	2014-03-05 11:43:41.569929
128	Check	21	create	2	\N	2014-03-11 12:18:10.491608
129	Service	46	create	2	\N	2014-03-11 12:18:28.710942
130	Check	22	create	2	\N	2014-03-14 10:46:47.149928
131	Service	47	create	2	\N	2014-03-14 10:47:37.82885
132	Service	47	update	2	---\nid: 47\nproject_id: \nhost_group_id: 1\ncheck_id: 22\nname: apache_active_threads\ncreated_at: 2014-03-14 10:47:37.784638000 Z\nupdated_at: 2014-03-14 10:47:37.784638000 Z\nparams: ! '{"measurement":"active_threads","args":"-w 4 -c 8"}'\nhost_id: \nenvironment_id: 2\n	2014-03-14 11:32:04.531861
133	Service	48	create	2	\N	2014-03-14 11:32:04.549661
134	Check	23	create	2	\N	2014-03-14 12:22:50.389057
140	Vip	1	create	2	\N	2014-03-18 11:32:27.94009
141	Service	52	update	2	---\nid: 52\nproject_id: \nhost_group_id: \ncheck_id: \nname: google-VIP\ncreated_at: 2014-03-18 11:32:27.833685000 Z\nupdated_at: 2014-03-18 11:32:27.833685000 Z\nparams: ! '{"host":"VIP.google.com","port":"443"}'\nhost_id: \nenvironment_id: 2\nvip_id: 1\n	2014-03-18 11:49:26.940583
142	Service	52	update	2	---\nid: 52\nproject_id: \nhost_group_id: \ncheck_id: 1\nname: google-VIP\ncreated_at: 2014-03-18 11:32:27.833685000 Z\nupdated_at: 2014-03-18 11:49:26.667514000 Z\nparams: ! '{"host":"VIP.google.com","port":"443"}'\nhost_id: \nenvironment_id: 2\nvip_id: 1\n	2014-03-18 12:25:40.552127
143	Service	53	create	2	\N	2014-03-18 12:49:09.992076
144	Vip	2	create	2	\N	2014-03-18 12:49:10.006549
145	Service	54	create	2	\N	2014-03-19 09:54:52.066715
146	Service	55	create	2	\N	2014-03-19 09:54:52.08865
147	HostGroup	3	update	2	---\nid: 3\nname: common\ncreated_at: 2014-01-12 17:53:11.846096000 Z\nupdated_at: 2014-02-25 09:58:08.415176000 Z\nproject_id: 2\nenvironment_id: 2\n	2014-03-19 10:04:02.147526
148	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 2\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-02-25 09:58:24.323797000 Z\nparams: ! '{"disk":"/"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:05:09.822421
149	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 1\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-03-19 10:05:09.813758000 Z\nparams: ! '{"disk":"/"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:06:04.681626
150	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 3\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-03-19 10:06:04.539460000 Z\nparams: ! '{"disk":"/"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:06:36.340221
151	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 3\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-03-19 10:06:36.330260000 Z\nparams: ! '{"host":"pay.google.com","port":"443"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:06:43.944093
152	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 3\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-03-19 10:06:43.938744000 Z\nparams: ! '{"host":"pa222y.google.com","port":"443"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:07:10.389209
153	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 1\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-03-19 10:07:10.263115000 Z\nparams: ! '{"host":"pa222y.google.com","port":"443"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:11:50.334075
154	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 2\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-03-19 10:11:50.155734000 Z\nparams: ! '{"disk":"/"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:12:22.4214
155	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 1\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-03-19 10:12:22.273874000 Z\nparams: ! '{"disk":"/"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:12:46.138552
156	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 2\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-03-19 10:12:46.126272000 Z\nparams: ! '{"disk":"/"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:13:29.5858
157	Service	11	update	2	---\nid: 11\nproject_id: \nhost_group_id: 5\ncheck_id: 1\nname: disco Raiz\ncreated_at: 2014-01-12 21:36:02.140757000 Z\nupdated_at: 2014-03-19 10:13:29.563085000 Z\nparams: ! '{"disk":"/"}'\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-19 10:17:41.694095
158	HostGroup	3	update	2	---\nid: 3\nname: common1\ncreated_at: 2014-01-12 17:53:11.846096000 Z\nupdated_at: 2014-03-19 10:04:01.864692000 Z\nproject_id: 2\nenvironment_id: 2\n	2014-03-19 10:18:01.044204
159	Service	54	update	2	---\nid: 54\nproject_id: \nhost_group_id: \ncheck_id: 14\nname: interfaaces\ncreated_at: 2014-03-19 09:54:52.032637000 Z\nupdated_at: 2014-03-19 09:54:52.032637000 Z\nparams: ''\nhost_id: \nenvironment_id: 2\nvip_id: 1\n	2014-03-19 10:19:56.269384
160	Service	55	update	2	---\nid: 55\nproject_id: \nhost_group_id: \ncheck_id: 1\nname: caaaarga\ncreated_at: 2014-03-19 09:54:52.081639000 Z\nupdated_at: 2014-03-19 09:54:52.081639000 Z\nparams: ! '-w 2 2 3 4 '\nhost_id: \nenvironment_id: 2\nvip_id: 2\n	2014-03-19 10:26:00.17351
161	Vip	2	update	2	---\nid: 2\nname: otravip\nip: 99.99.99.88\nproject_id: 3\nenvironment_id: 2\ncreated_at: 2014-03-18 12:49:09.978386000 Z\nupdated_at: 2014-03-18 12:49:09.978386000 Z\n	2014-03-19 10:36:11.799653
162	Vip	2	update	2	---\nid: 2\nname: otravip\nip: 192.168.51.5/24\nproject_id: 3\nenvironment_id: 2\ncreated_at: 2014-03-18 12:49:09.978386000 Z\nupdated_at: 2014-03-19 10:36:11.460775000 Z\n	2014-03-19 10:36:19.365909
163	Check	4	update	2	---\nid: 4\nname: procs\nexample: -w 150 -c 200\ncreated_at: 2014-01-13 09:01:31.150933000 Z\nupdated_at: 2014-02-25 09:56:21.027808000 Z\npuppet_type: monitorizacion::checks::procs\nenvironment_id: 2\n	2014-03-20 13:48:29.400545
164	Service	7	update	2	---\nid: 7\nproject_id: \nhost_group_id: 3\ncheck_id: 4\nname: processes\ncreated_at: 2014-01-12 20:55:13.695457000 Z\nupdated_at: 2014-03-03 13:18:02.683303000 Z\nparams: ''\nhost_id: \nenvironment_id: 2\nvip_id: \n	2014-03-20 13:49:06.971638
\.


--
-- Data for Name: vips; Type: TABLE DATA; Schema: public; Owner: monitoring
--

COPY vips (id, name, ip, project_id, environment_id, created_at, updated_at) FROM stdin;
1	vip-host.com	1.2.3.4	3	2	2014-03-18 11:32:27.74279	2014-03-18 11:32:27.74279
2	otravip	192.168.51.5	3	2	2014-03-18 12:49:09.978386	2014-03-19 10:36:19.360007
\.


--
-- Name: checks_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY checks
    ADD CONSTRAINT checks_pkey PRIMARY KEY (id);


--
-- Name: commands_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY commands
    ADD CONSTRAINT commands_pkey PRIMARY KEY (id);


--
-- Name: contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: environments_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY environments
    ADD CONSTRAINT environments_pkey PRIMARY KEY (id);


--
-- Name: host_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY host_groups
    ADD CONSTRAINT host_groups_pkey PRIMARY KEY (id);


--
-- Name: hosts_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY hosts
    ADD CONSTRAINT hosts_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: services_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: vips_pkey; Type: CONSTRAINT; Schema: public; Owner: monitoring; Tablespace: 
--

ALTER TABLE ONLY vips
    ADD CONSTRAINT vips_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: monitoring; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


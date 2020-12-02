CREATE USER opensips WITH PASSWORD 'admin1234';
CREATE DATABASE opensips_cdr OWNER opensips;
\c opensips_secondary
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO opensips;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO opensips;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO opensips;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TYPES TO opensips;

CREATE TABLE version (
    table_name VARCHAR(32) NOT NULL,
    table_version INTEGER DEFAULT 0 NOT NULL,
    CONSTRAINT version_t_name_idx UNIQUE (table_name)
);

INSERT INTO version (table_name, table_version) values ('acc','7');
CREATE TABLE acc (
    id SERIAL PRIMARY KEY NOT NULL,
    method VARCHAR(16) DEFAULT '' NOT NULL,
    from_tag VARCHAR(64) DEFAULT '' NOT NULL,
    to_tag VARCHAR(64) DEFAULT '' NOT NULL,
    callid VARCHAR(64) DEFAULT '' NOT NULL,
    sip_code VARCHAR(3) DEFAULT '' NOT NULL,
    sip_reason VARCHAR(32) DEFAULT '' NOT NULL,
    accountcode text DEFAULT '' NOT NULL,
    caller_id_name text NOT NULL,
    caller_id_number text NOT NULL,
    destination TEXT DEFAULT '' NOT NULL,
    src_ip TEXT DEFAULT '' NOT NULL,
    dst_ip TEXT NOT NULL,
    leg TEXT DEFAULT '' NOT NULL,
    direction text default '' NOT null,
    time TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    duration INTEGER DEFAULT 0 NOT NULL,
    ms_duration INTEGER DEFAULT 0 NOT NULL,
    setuptime INTEGER DEFAULT 0 NOT NULL,
    created TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL
);

INSERT INTO version (table_name, table_version) values ('dialog','11');
CREATE TABLE dialog (
    dlg_id BIGINT PRIMARY KEY NOT NULL,
    callid VARCHAR(255) NOT NULL,
    from_uri VARCHAR(255) NOT NULL,
    from_tag VARCHAR(64) NOT NULL,
    to_uri VARCHAR(255) NOT NULL,
    to_tag VARCHAR(64) NOT NULL,
    mangled_from_uri VARCHAR(64) DEFAULT NULL,
    mangled_to_uri VARCHAR(64) DEFAULT NULL,
    caller_cseq VARCHAR(11) NOT NULL,
    callee_cseq VARCHAR(11) NOT NULL,
    caller_ping_cseq INTEGER NOT NULL,
    callee_ping_cseq INTEGER NOT NULL,
    caller_route_set TEXT,
    callee_route_set TEXT,
    caller_contact VARCHAR(255),
    callee_contact VARCHAR(255),
    caller_sock VARCHAR(64) NOT NULL,
    callee_sock VARCHAR(64) NOT NULL,
    state INTEGER NOT NULL,
    start_time INTEGER NOT NULL,
    timeout INTEGER NOT NULL,
    vars BYTEA DEFAULT NULL,
    profiles TEXT DEFAULT NULL,
    script_flags INTEGER DEFAULT 0 NOT NULL,
    module_flags INTEGER DEFAULT 0 NOT NULL,
    flags INTEGER DEFAULT 0 NOT NULL,
    rt_on_answer VARCHAR(64) DEFAULT NULL,
    rt_on_timeout VARCHAR(64) DEFAULT NULL,
    rt_on_hangup VARCHAR(64) DEFAULT NULL
);

INSERT INTO version (table_name, table_version) values ('clusterer','4');
CREATE TABLE clusterer (
    id SERIAL PRIMARY KEY NOT NULL,
    cluster_id INTEGER NOT NULL,
    node_id INTEGER NOT NULL,
    url VARCHAR(64) NOT NULL,
    state INTEGER DEFAULT 1 NOT NULL,
    no_ping_retries INTEGER DEFAULT 3 NOT NULL,
    priority INTEGER DEFAULT 50 NOT NULL,
    sip_addr VARCHAR(64),
    flags VARCHAR(64),
    description VARCHAR(64),
    CONSTRAINT clusterer_clusterer_idx UNIQUE (cluster_id, node_id)
);

ALTER SEQUENCE clusterer_id_seq MAXVALUE 2147483647 CYCLE;

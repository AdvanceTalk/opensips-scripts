DROP TABLE acc;
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


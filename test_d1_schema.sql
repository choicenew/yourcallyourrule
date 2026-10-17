-- Cloudflare D1 Initial Schema
CREATE TABLE IF NOT EXISTS remote_numbers (
    phone_number TEXT PRIMARY KEY,
    id TEXT,
    name TEXT,
    label TEXT,
    priority INTEGER,
    action TEXT,
    count INTEGER,
    labels_json TEXT
);

CREATE TABLE IF NOT EXISTS number_countries (
    phone_number TEXT,
    country_iso_code TEXT,
    PRIMARY KEY (phone_number, country_iso_code)
);

CREATE TABLE IF NOT EXISTS op_log (
    log_id TEXT PRIMARY KEY,
    phone_number TEXT,
    operation TEXT,
    payload TEXT,
    timestamp TEXT,
    source_device_id TEXT
);

CREATE TABLE IF NOT EXISTS verification_reports (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    phone_number TEXT,
    report_data TEXT,
    uploaded_at TEXT,
    device_id TEXT
);

CREATE TABLE IF NOT EXISTS deletion_proposals (
    phone_number TEXT PRIMARY KEY,
    proposal_start_time TEXT,
    highest_risk_level TEXT,
    verified_owner_count INTEGER DEFAULT 0,
    proposal_count INTEGER DEFAULT 1,
    status TEXT DEFAULT 'pending',
    last_updated TEXT
);

CREATE TABLE IF NOT EXISTS proposal_submissions (
    id TEXT PRIMARY KEY,
    proposer_id TEXT,
    phone_number TEXT,
    submission_time TEXT
);

CREATE TABLE IF NOT EXISTS proposal_votes (
    id TEXT PRIMARY KEY,
    voter_id TEXT,
    proposal_id TEXT,
    vote_time TEXT,
    is_consumed INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS app_config (
    key TEXT PRIMARY KEY,
    value TEXT
);

INSERT OR REPLACE INTO app_config (key, value) VALUES ('proposal_limit_standard_user_limit', '5');
INSERT OR REPLACE INTO app_config (key, value) VALUES ('proposal_limit_vip_user_limit', '20');
INSERT OR REPLACE INTO app_config (key, value) VALUES ('proposal_limit_days', '7');
INSERT OR REPLACE INTO app_config (key, value) VALUES ('proposal_limit_votes_per_proposal', '3');

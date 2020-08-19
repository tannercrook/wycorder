-- Wrote for use on PostgreSQL


-- Drop the tables
DROP TABLE reading;
DROP TABLE system_user;

-- system_user table holds the identities for people. *Note that it is built so that you can operate completely anonymously.
CREATE TABLE system_user 
( system_user_id 	INTEGER		PRIMARY KEY 	GENERATED ALWAYS AS IDENTITY
, email 			VARCHAR(80)
, sis_id 			INTEGER
, token 			VARCHAR(250)
, password			VARCHAR(250)
, active 			INTEGER			NOT NULL DEFAULT 1
, created_at		TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP);


CREATE UNIQUE INDEX system_user_uq_1 ON system_user (email);
CREATE UNIQUE INDEX system_user_uq_2 ON system_user (sis_id);

-- reading table holds user readings. The status holds the final determination of the reading.
CREATE TABLE reading 
( reading_id 		INTEGER 		PRIMARY KEY 	GENERATED ALWAYS AS IDENTITY 
, system_user_id	INTEGER			NOT NULL 
, time_taken 		TIMESTAMP WITH TIME ZONE 		NOT NULL    DEFAULT CURRENT_TIMESTAMP
, status 			VARCHAR(10) 
, fever_chills		SMALLINT 
, cough				SMALLINT
, sore_throat		SMALLINT 
, short_breath		SMALLINT 
, fatigue			SMALLINT 
, aches 			SMALLINT 
, taste_loss		SMALLINT 
, congestion 		SMALLINT 
, nausea_vomit_diarrhea	SMALLINT
, infectious_contact	SMALLINT 
, temperature			SMALLINT 
, CONSTRAINT fk_reading_1 FOREIGN KEY (system_user_id) REFERENCES system_user(system_user_id) 
, CONSTRAINT ck_reading_1 CHECK (status IN ('Pass','Fail','Warn')));
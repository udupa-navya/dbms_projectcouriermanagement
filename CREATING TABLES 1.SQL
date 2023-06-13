CREATE TABLE HUB
(
	hub_id	      INT		PRIMARY KEY,
	hub_name     VARCHAR(50)  NOT NULL,
	hub_add	   VARCHAR(100)	NOT NULL,
	hub_type    VARCHAR(10)	DEFAULT 'warehouse'
);



CREATE TABLE MESSENGER
(
	messenger_id	    INT		  PRIMARY KEY,
	messenger_name	VARCHAR(50)	  NOT NULL,
	mess_hub	INT		  NOT NULL,
	mess_mob  CHAR(10)	  NOT NULL CHECK  (mess_mob SIMILAR TO '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),//CHECKING IF THE PHONE NUMBER IS VALID ONE AGAINST POSTGRES Regex//
	FOREIGN KEY (mess_hub) REFERENCES HUB(hub_id)
);


CREATE TABLE CONSIGNMENT
(
	con_id		   INT			 PRIMARY KEY,
	con_origin	VARCHAR(100)	 NOT NULL,
	con_dest	VARCHAR(100)	 NOT NULL,
	shipped_date	   DATE          NOT NULL,
	received_date      DATE          NOT NULL CHECK (received_date >= shipped_date AND shipped_date >= '1970-01-01') );//constraint fro checking whether received date is greater than shipped date//



CREATE TABLE CLIENT
(
	client_id		   INT		   PRIMARY KEY,
	client_name   VARCHAR(50)	   NOT NULL,
	client_add	VARCHAR(100)   NOT NULL,
	client_mobile   CHAR(10)	   NOT NULL CHECK (client_mobile SIMILAR TO '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),//constraint checking for valid phone no//
	client_email	VARCHAR(50)	   NOT NULL CHECK (client_email SIMILAR TO '%_@_%._%'),//Constraint for checking valid email id//
	client_hub INT NOT NULL,
	FOREIGN KEY (client_hub) REFERENCES HUB(hub_id) );


CREATE TABLE PARCEL
(
	parcel_id		      INT	    PRIMARY KEY,
	parcel_sender_id      INT	    NOT NULL,
	parcel_type VARCHAR(50)    DEFAULT 'regular',
	parcel_weight	     DECIMAL   NOT NULL,
	paid  varchar(5) DEFAULT 'YES',
	delivered varchar(5) DEFAULT 'NO',
	src_city     VARCHAR(100) NOT NULL,
	dst_city		 VARCHAR(100)   NOT NULL,
	parcel_consign_id  INT		NOT NULL,
	par_mess_id			 INT		NOT NULL,
	FOREIGN KEY (parcel_sender_id) REFERENCES CLIENT(client_id),
	FOREIGN KEY (parcel_consign_id) REFERENCES CONSIGNMENT(con_id),
	FOREIGN KEY (par_mess_id) REFERENCES MESSENGER(messenger_id) );

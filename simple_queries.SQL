
/* SIMPLE QUERIES */

/* 1) Print all the cities where the service delivers */
SELECT HUB_add FROM HUB WHERE HUB_type='warehouse';


/* 2) Print the city in which each delivery messenger delivers */

SELECT DISTINCT MESSENGER.messenger_name, HUB.HUB_add
FROM MESSENGER,HUB
WHERE MESSENGER.mess_hub=HUB.hub_id;

/* 3) Print details of all consignments arriving into Pune */

SELECT CONSIGNMENT.con_origin,CONSIGNMENT.con_dest,CONSIGNMENT.shipped_date,CONSIGNMENT.received_date
FROM CONSIGNMENT
WHERE CONSIGNMENT.con_dest='Pune';


/* 4) Print the client name and delivery messenger for each parcel */
 
SELECT PARCEL.parcel_id, CLIENT.client_name, MESSENGER.messenger_name
FROM PARCEL,CLIENT,MESSENGER
WHERE CLIENT.client_id=PARCEL.parcel_sender_id
	AND MESSENGER.messenger_id=PARCEL.par_mess_id;
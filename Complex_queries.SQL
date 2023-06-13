/* 1) Find the number of deliveries undertaken by each messenger 
   (Aggregate function) */

SELECT MESSENGER.messenger_name, COUNT(*)
FROM MESSENGER,PARCEL
WHERE MESSENGER.messenger_id=PARCEL.par_mess_id
GROUP BY MESSENGER.messenger_name;


/* 2) Check the usage of delivery services by clients by ranking them according to number 
of parcels sent. This information can be used to identify clients for gold memberships.
(aggregate function) */

SELECT CLIENT.client_name, COUNT(*)
FROM CLIENT,PARCEL
WHERE CLIENT.client_id=PARCEL.parcel_sender_id
GROUP BY CLIENT.client_name; 


/* 3) Identify the number of outgoing parcels from each city
  (Nested Query) */

SELECT PARCEL.src_city,COUNT(*) 
FROM PARCEL 
WHERE (PARCEL.src_city IN 
(SELECT CONSIGNMENT.con_origin 
FROM CONSIGNMENT,PARCEL 
WHERE PARCEL.parcel_consign_id=CONSIGNMENT.con_id)) 
GROUP BY PARCEL.src_city ;

/* 4) Print the parcelr_id, mobile number of associated client and source address for each parcel 
(Full Outer Join) */
SELECT parcel_id, client_name, client_add 
FROM PARCEL 
FULL OUTER JOIN CLIENT 
ON PARCEL.parcel_sender_id=CLIENT.client_id;

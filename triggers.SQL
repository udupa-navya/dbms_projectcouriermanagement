

/* TRIGGERS */

/* 1) Ensure that the delivery is not done if payment is pending */
/* If payment_status='pending', but delivery_status='done', this is an INVALID STATE */
/* Hence, the delivery_status is changed to 'pending' */
CREATE TRIGGER non_paid
AFTER INSERT OR UPDATE ON PARCEL
FOR EACH ROW EXECUTE PROCEDURE parcel_fun();

AS
BEGIN
SET NOCOUNT ON
UPDATE PARCEL
SET delivered='NO'
FROM PARCEL
WHERE paid like 'NO'
END;


/* Demonstrating the trigger */
INSERT INTO PARCEL
VALUES (11,1,'regular',9,'NO','YES','Delhi','Chennai',4,4);

SELECT * FROM PARCEL;

/* 2) Classify the inserted parcel as heavy_weight if it crosses the weight limit */
CREATE TRIGGER large_parcel
   ON  PARCEL 
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	UPDATE PARCEL
	SET Parcel_type ='heavy_weight'
	FROM PARCEL
	WHERE Parcel_weight > 1000


END
GO

/* Demonstrating the trigger */
INSERT INTO PARCEL
VALUES (12,1,'regular',1566,'YES','NO','Pune','Delhi',9,2)

SELECT* FROM PARCEL


SELECT * FROM PARCEL 

/* 3) If the source address of a consignment matches its destination address 
then set it as invalid and do not allow insertion into the relation */
CREATE TRIGGER unavbl_consignment
ON CONSIGNMENT
AFTER INSERT, UPDATE
AS
BEGIN
SET NOCOUNT ON
	UPDATE CONSIGNMENT
	SET con_origin = 'invalid'
	FROM CONSIGNMENT
	WHERE con_origin = con_dest
	print('invalid consignment')
	
END
rollback;


INSERT INTO CONSIGNMENT
VALUES (19,'Pune','Pune','2020-05-02','2020-05-10')
SELECT * FROM CONSIGNMENT

/* 4) If a HUB is neither of the type sales or warehouse set it as connecting */
CREATE TRIGGER unique_HUB
ON HUB
AFTER INSERT, UPDATE
AS
BEGIN
SET NOCOUNT ON
	UPDATE HUB
	SET HUB_type = 'connecting'
	FROM HUB
	WHERE HUB_type NOT LIKE 'warehouse' AND HUB_type NOT LIKE 'sales'
	
END
 /* Demonstrating the trigger */
INSERT INTO HUB
VALUES (14,'PUN1','Pune','any')
SELECT* FROM HUB

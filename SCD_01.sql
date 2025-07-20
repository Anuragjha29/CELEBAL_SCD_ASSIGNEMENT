CREATE PROCEDURE sp_scd_type_1
    @CustomerID INT,
    @CustomerName VARCHAR(100)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM dim_customer WHERE CustomerID = @CustomerID)
    BEGIN
        UPDATE dim_customer
        SET CustomerName = @CustomerName
        WHERE CustomerID = @CustomerID
    END
    ELSE
    BEGIN
        INSERT INTO dim_customer (CustomerID, CustomerName)
        VALUES (@CustomerID, @CustomerName)
    END
END

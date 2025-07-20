CREATE PROCEDURE sp_scd_type_0
    @CustomerID INT,
    @CustomerName VARCHAR(100)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM dim_customer WHERE CustomerID = @CustomerID)
    BEGIN
        INSERT INTO dim_customer (CustomerID, CustomerName)
        VALUES (@CustomerID, @CustomerName)
    END
  
END

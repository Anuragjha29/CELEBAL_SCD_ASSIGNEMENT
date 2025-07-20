CREATE PROCEDURE sp_scd_type_4
    @CustomerID INT,
    @CustomerName VARCHAR(100)
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM dim_customer WHERE CustomerID = @CustomerID AND CustomerName <> @CustomerName
    )
    BEGIN
        -- Insert old data to history table
        INSERT INTO dim_customer_history (CustomerID, CustomerName, ModifiedDate)
        SELECT CustomerID, CustomerName, GETDATE()
        FROM dim_customer
        WHERE CustomerID = @CustomerID

    
        UPDATE dim_customer
        SET CustomerName = @CustomerName
        WHERE CustomerID = @CustomerID
    END
    ELSE IF NOT EXISTS (
        SELECT 1 FROM dim_customer WHERE CustomerID = @CustomerID
    )
    BEGIN
        INSERT INTO dim_customer (CustomerID, CustomerName)
        VALUES (@CustomerID, @CustomerName)
    END
END

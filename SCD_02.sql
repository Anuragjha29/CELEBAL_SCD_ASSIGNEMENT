CREATE PROCEDURE sp_scd_type_2
    @CustomerID INT,
    @CustomerName VARCHAR(100)
AS
BEGIN
    DECLARE @CurrentDate DATE = GETDATE()

  
    IF EXISTS (
        SELECT 1 FROM dim_customer
        WHERE CustomerID = @CustomerID AND IsCurrent = 1 AND CustomerName <> @CustomerName
    )
    BEGIN
        -- Expire old record
        UPDATE dim_customer
        SET EndDate = @CurrentDate, IsCurrent = 0
        WHERE CustomerID = @CustomerID AND IsCurrent = 1

      
        INSERT INTO dim_customer (CustomerID, CustomerName, StartDate, EndDate, IsCurrent)
        VALUES (@CustomerID, @CustomerName, @CurrentDate, NULL, 1)
    END
    ELSE IF NOT EXISTS (
        SELECT 1 FROM dim_customer WHERE CustomerID = @CustomerID
    )
    BEGIN
        -- Insert first-time record
        INSERT INTO dim_customer (CustomerID, CustomerName, StartDate, EndDate, IsCurrent)
        VALUES (@CustomerID, @CustomerName, @CurrentDate, NULL, 1)
    END
END

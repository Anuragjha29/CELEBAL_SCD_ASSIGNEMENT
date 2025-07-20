CREATE PROCEDURE sp_scd_type_6
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
      
        UPDATE dim_customer
        SET EndDate = @CurrentDate, IsCurrent = 0
        WHERE CustomerID = @CustomerID AND IsCurrent = 1

        
        INSERT INTO dim_customer (CustomerID, CustomerName, PreviousCustomerName, StartDate, EndDate, IsCurrent)
        VALUES (@CustomerID, @CustomerName,
               (SELECT CustomerName FROM dim_customer WHERE CustomerID = @CustomerID AND IsCurrent = 0 AND EndDate = @CurrentDate),
               @CurrentDate, NULL, 1)
    END
    ELSE IF NOT EXISTS (
        SELECT 1 FROM dim_customer WHERE CustomerID = @CustomerID
    )
    BEGIN
        
        INSERT INTO dim_customer (CustomerID, CustomerName, PreviousCustomerName, StartDate, EndDate, IsCurrent)
        VALUES (@CustomerID, @CustomerName, NULL, @CurrentDate, NULL, 1)
    END
END

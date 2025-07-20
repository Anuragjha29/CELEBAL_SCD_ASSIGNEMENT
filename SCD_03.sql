CREATE PROCEDURE sp_scd_type_3
    @CustomerID INT,
    @CustomerName VARCHAR(100)
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM dim_customer WHERE CustomerID = @CustomerID AND CustomerName <> @CustomerName
    )
    BEGIN
        UPDATE dim_customer
        SET PreviousCustomerName = CustomerName,
            CustomerName = @CustomerName
        WHERE CustomerID = @CustomerID
    END
    ELSE IF NOT EXISTS (
        SELECT 1 FROM dim_customer WHERE CustomerID = @CustomerID
    )
    BEGIN
        INSERT INTO dim_customer (CustomerID, CustomerName, PreviousCustomerName)
        VALUES (@CustomerID, @CustomerName, NULL)
    END
END

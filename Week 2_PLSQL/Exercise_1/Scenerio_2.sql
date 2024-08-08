DECLARE
    v_balance NUMBER;
    v_customer_id NUMBER;
BEGIN
    FOR rec IN (SELECT CustomerID, Balance 
                FROM Customers) 
    LOOP
        v_customer_id := rec.CustomerID;
        v_balance := rec.Balance;
        
        IF v_balance > 10000 THEN
            -- Update the customer's VIP status
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = v_customer_id;
        END IF;
    END LOOP;
    
    -- Commit the changes
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('VIP status updated for customers with balance over $10,000.');
END;
/

DECLARE
    v_age NUMBER;
    v_customer_id NUMBER;
    v_interest_rate NUMBER;
BEGIN
    FOR rec IN (SELECT c.CustomerID, l.InterestRate, TRUNC((SYSDATE - c.DOB)/365.25) AS Age 
                FROM Customers c 
                JOIN Loans l ON c.CustomerID = l.CustomerID) 
    LOOP
        v_customer_id := rec.CustomerID;
        v_interest_rate := rec.InterestRate;
        v_age := rec.Age;
        
        IF v_age > 60 THEN
            -- Apply a 1% discount
            UPDATE Loans
            SET InterestRate = v_interest_rate - 1
            WHERE CustomerID = v_customer_id;
        END IF;
    END LOOP;
    
    -- Commit the changes
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Interest rates updated for customers above 60 years old.');
END;
/

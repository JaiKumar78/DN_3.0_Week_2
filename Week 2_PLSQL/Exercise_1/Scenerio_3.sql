DECLARE
    v_due_date DATE;
    v_customer_id NUMBER;
BEGIN
    FOR rec IN (SELECT l.LoanID, l.CustomerID, l.EndDate, c.Name 
                FROM Loans l 
                JOIN Customers c ON l.CustomerID = c.CustomerID
                WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30) 
    LOOP
        v_customer_id := rec.CustomerID;
        v_due_date := rec.EndDate;
        
        -- Print the reminder message
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan for Customer ' || rec.Name || 
                             ' (ID: ' || v_customer_id || ') is due on ' || v_due_date);
    END LOOP;
END;
/

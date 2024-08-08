CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account_id IN NUMBER,
    p_to_account_id IN NUMBER,
    p_amount IN NUMBER
) IS
    v_balance_from NUMBER;
    insufficient_funds EXCEPTION;
BEGIN
    -- Check the balance of the 'from' account
    SELECT Balance INTO v_balance_from
    FROM Accounts
    WHERE AccountID = p_from_account_id
    FOR UPDATE;

    -- Check if the balance is sufficient for the transfer
    IF v_balance_from < p_amount THEN
        RAISE insufficient_funds;
    ELSE
        -- Deduct from the 'from' account
        UPDATE Accounts
        SET Balance = Balance - p_amount,
            LastModified = SYSDATE
        WHERE AccountID = p_from_account_id;

        -- Add to the 'to' account
        UPDATE Accounts
        SET Balance = Balance + p_amount,
            LastModified = SYSDATE
        WHERE AccountID = p_to_account_id;
        
        -- Commit the transaction
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Transfer of ' || p_amount || ' from Account ' || p_from_account_id || ' to Account ' || p_to_account_id || ' completed successfully.');
    END IF;
EXCEPTION
    WHEN insufficient_funds THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transfer failed: Insufficient funds in Account ' || p_from_account_id || '.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
END;
/

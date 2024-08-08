DECLARE
    CURSOR cur_accounts IS
        SELECT AccountID, Balance FROM Accounts;

    v_accountID Accounts.AccountID%TYPE;
    v_balance Accounts.Balance%TYPE;
    v_annualFee NUMBER := 50; -- Example annual fee
BEGIN
    OPEN cur_accounts;
    
    LOOP
        FETCH cur_accounts INTO v_accountID, v_balance;
        EXIT WHEN cur_accounts%NOTFOUND;

        -- Deduct the annual fee from the balance
        UPDATE Accounts
        SET Balance = Balance - v_annualFee,
            LastModified = SYSDATE
        WHERE AccountID = v_accountID;

        DBMS_OUTPUT.PUT_LINE('Annual fee applied to Account ID: ' || v_accountID || ', New Balance: ' || (v_balance - v_annualFee));
    END LOOP;

    CLOSE cur_accounts;
END;
/

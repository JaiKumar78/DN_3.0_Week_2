CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
    v_interest_rate CONSTANT NUMBER := 0.01;
BEGIN
    -- Update the balance of all savings accounts by applying the interest rate
    UPDATE Accounts
    SET Balance = Balance * (1 + v_interest_rate),
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Monthly interest processed for all savings accounts.');
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any unexpected errors
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error processing monthly interest: ' || SQLERRM);
END;
/

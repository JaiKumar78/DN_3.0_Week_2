DECLARE
    CURSOR cur_loans IS
        SELECT LoanID, InterestRate FROM Loans;

    v_loanID Loans.LoanID%TYPE;
    v_interestRate Loans.InterestRate%TYPE;
    v_newInterestRate NUMBER;
BEGIN
    OPEN cur_loans;
    
    LOOP
        FETCH cur_loans INTO v_loanID, v_interestRate;
        EXIT WHEN cur_loans%NOTFOUND;

        -- Define new interest rate based on the policy (for example, reduce by 0.5%)
        v_newInterestRate := v_interestRate - 0.5;

        -- Update the loan with the new interest rate
        UPDATE Loans
        SET InterestRate = v_newInterestRate,
            LastModified = SYSDATE
        WHERE LoanID = v_loanID;

        DBMS_OUTPUT.PUT_LINE('Loan ID: ' || v_loanID || ' Interest Rate updated to: ' || v_newInterestRate);
    END LOOP;

    CLOSE cur_loans;
END;
/

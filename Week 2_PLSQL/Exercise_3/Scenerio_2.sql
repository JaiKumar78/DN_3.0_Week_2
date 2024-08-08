CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) IS
BEGIN
    -- Update the salary of all employees in the specified department
    UPDATE Employees
    SET Salary = Salary * (1 + p_bonus_percentage / 100),
        HireDate = SYSDATE
    WHERE Department = p_department;

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Bonuses updated for department: ' || p_department);
EXCEPTION
    WHEN OTHERS THEN
        -- Handle any unexpected errors
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating bonuses for department: ' || p_department || ' - ' || SQLERRM);
END;
/

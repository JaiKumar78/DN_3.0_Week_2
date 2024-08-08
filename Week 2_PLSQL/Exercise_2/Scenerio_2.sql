CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_employee_id IN NUMBER,
    p_percentage IN NUMBER
) IS
    v_current_salary NUMBER;
    employee_not_found EXCEPTION;
BEGIN
    -- Get the current salary of the employee
    SELECT Salary INTO v_current_salary FROM Employees WHERE EmployeeID = p_employee_id;

    -- Update the salary
    UPDATE Employees
    SET Salary = v_current_salary + (v_current_salary * p_percentage / 100),
        LastModified = SYSDATE
    WHERE EmployeeID = p_employee_id;

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_employee_id || ' not found.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END UpdateSalary;
/

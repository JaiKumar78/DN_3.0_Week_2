CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
    p_loan_amount NUMBER,
    p_interest_rate NUMBER,
    p_duration_years NUMBER
) RETURN NUMBER IS
    v_monthly_installment NUMBER;
    v_monthly_rate NUMBER;
    v_total_months NUMBER;
BEGIN
    -- Convert annual interest rate to a monthly rate
    v_monthly_rate := p_interest_rate / 12 / 100;
    
    -- Total number of months for the loan duration
    v_total_months := p_duration_years * 12;
    
    -- Calculate monthly installment using the formula:
    -- EMI = P * r * (1+r)^n / [(1+r)^n-1]
    IF v_monthly_rate = 0 THEN
        -- If the interest rate is 0, it's a simple division of loan amount by total months
        v_monthly_installment := p_loan_amount / v_total_months;
    ELSE
        v_monthly_installment := p_loan_amount * v_monthly_rate * POWER(1 + v_monthly_rate, v_total_months) /
                                 (POWER(1 + v_monthly_rate, v_total_months) - 1);
    END IF;

    RETURN v_monthly_installment;
END;
/

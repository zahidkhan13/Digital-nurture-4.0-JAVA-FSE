CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
) AS
    v_balance NUMBER;
BEGIN
    EXECUTE IMMEDIATE 'SELECT Balance FROM BankAccounts WHERE AccountID = :1'
        INTO v_balance USING p_from_account;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account.');
    END IF;

    EXECUTE IMMEDIATE 'UPDATE BankAccounts SET Balance = Balance - :1 WHERE AccountID = :2'
        USING p_amount, p_from_account;

    EXECUTE IMMEDIATE 'UPDATE BankAccounts SET Balance = Balance + :1 WHERE AccountID = :2'
        USING p_amount, p_to_account;

    COMMIT;
END;
/
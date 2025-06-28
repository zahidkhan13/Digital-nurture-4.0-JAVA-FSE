-- ✅ Enable DBMS_OUTPUT
SET SERVEROUTPUT ON;

-- ✅ Drop old tables if they exist
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Loans';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Customers';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- ✅ Create Customers table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Age NUMBER,
    Balance NUMBER(10,2),
    InterestRate NUMBER(5,2),
    IsVIP CHAR(1)
);
/

-- ✅ Insert Customers
INSERT INTO Customers VALUES (1, 'Alice', 65, 15000, 8.5, 'N');
INSERT INTO Customers VALUES (2, 'Bob', 45, 9500, 9.2, 'N');
INSERT INTO Customers VALUES (3, 'Charlie', 70, 3000, 7.8, 'N');
COMMIT;
/

-- ✅ Create Loans table
CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    DueDate DATE
);
/

-- ✅ Insert Loans
INSERT INTO Loans VALUES (101, 1, SYSDATE + 10);
INSERT INTO Loans VALUES (102, 2, SYSDATE + 40);
INSERT INTO Loans VALUES (103, 3, SYSDATE + 20);
COMMIT;
/

-- ✅ Scenario 1: Discount interest rate if Age > 60
BEGIN
    FOR rec IN (SELECT CustomerID FROM Customers WHERE Age > 60) LOOP
        UPDATE Customers
        SET InterestRate = InterestRate - 1
        WHERE CustomerID = rec.CustomerID;
    END LOOP;
    COMMIT;
END;
/

-- ✅ Scenario 2: Promote to VIP if Balance > 10000
BEGIN
    FOR rec IN (SELECT CustomerID FROM Customers WHERE Balance > 10000) LOOP
        UPDATE Customers
        SET IsVIP = 'Y'
        WHERE CustomerID = rec.CustomerID;
    END LOOP;
    COMMIT;
END;
/

-- ✅ Scenario 3: Loan reminders for due dates in next 30 days
DECLARE
    v_customer_name VARCHAR2(100);
BEGIN
    FOR rec IN (
        SELECT LoanID, CustomerID, DueDate
        FROM Loans
        WHERE DueDate <= SYSDATE + 30
    ) LOOP
        SELECT Name INTO v_customer_name
        FROM Customers
        WHERE CustomerID = rec.CustomerID;

        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || rec.LoanID ||
                             ' for ' || v_customer_name ||
                             ' is due on ' || TO_CHAR(rec.DueDate, 'DD-MON-YYYY'));
    END LOOP;
END;
/
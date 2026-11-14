USE banking_analytics;

SELECT 'accounts' AS table_name, COUNT(*) AS total_rows FROM accounts
UNION ALL
SELECT 'branches', COUNT(*) FROM branches
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'loans', COUNT(*) FROM loans
UNION ALL
SELECT 'repayments', COUNT(*) FROM repayments
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions;

SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY transaction_type
ORDER BY total_amount DESC;

SELECT
    channel,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM transactions
GROUP BY channel
ORDER BY total_amount DESC;

SELECT
    status,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY status
ORDER BY total_transactions DESC;

SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.amount) AS total_amount
FROM branches b
JOIN transactions t
    ON b.branch_id = t.branch_id
GROUP BY b.branch_id, b.branch_name, b.city
ORDER BY total_amount DESC;

SELECT
    c.customer_id,
    COUNT(a.account_id) AS total_accounts,
    SUM(a.opening_balance) AS total_balance
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
GROUP BY c.customer_id
ORDER BY total_balance DESC
LIMIT 10;

SELECT
    loan_status,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    ROUND(AVG(interest_rate_pct), 2) AS average_interest_rate
FROM loans
GROUP BY loan_status
ORDER BY total_loans DESC;

SELECT
    payment_status,
    COUNT(*) AS total_repayments,
    SUM(amount_due) AS total_amount_due,
    SUM(amount_paid) AS total_amount_paid
FROM repayments
GROUP BY payment_status
ORDER BY total_repayments DESC;

SELECT
    c.customer_id,
    COUNT(l.loan_id) AS total_loans,
    SUM(l.loan_amount) AS total_loan_amount
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY c.customer_id
ORDER BY total_loan_amount DESC
LIMIT 10;

SELECT
    a.customer_id,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.amount) AS total_transaction_amount
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY a.customer_id
ORDER BY total_transaction_amount DESC
LIMIT 10;

SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY transaction_month;

SELECT
    account_type,
    COUNT(*) AS total_accounts,
    SUM(opening_balance) AS total_opening_balance,
    ROUND(AVG(opening_balance), 2) AS average_opening_balance
FROM accounts
GROUP BY account_type
ORDER BY total_opening_balance DESC;

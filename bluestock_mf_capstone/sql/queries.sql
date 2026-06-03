-- 1) Top 5 funds by latest AUM
SELECT amfi_code, SUM(aum_crore) as total_aum
FROM fact_aum
GROUP BY amfi_code
ORDER BY total_aum DESC
LIMIT 5;

-- 2) Average NAV per month (for each fund)
SELECT f.amfi_code, d.year, d.month, AVG(fn.nav) as avg_nav
FROM fact_nav fn
JOIN dim_date d ON fn.date_id = d.date_id
JOIN dim_fund f ON fn.amfi_code = f.amfi_code
GROUP BY f.amfi_code, d.year, d.month
ORDER BY f.amfi_code, d.year, d.month;

-- 3) SIP YoY growth: total SIP amount this year vs last year (percent)
WITH sip AS (
  SELECT date(substr(transaction_date,1,4)) AS tx_date, strftime('%Y', transaction_date) as year, amfi_code, SUM(amount_inr) as amount
  FROM fact_transactions
  WHERE transaction_type = 'SIP'
  GROUP BY year, amfi_code
)
SELECT s1.amfi_code, s1.amount as amount_current_year, s2.amount as amount_prev_year,
       (CAST(s1.amount AS REAL)-CAST(s2.amount AS REAL))/NULLIF(s2.amount,0) * 100 as pct_growth
FROM sip s1
LEFT JOIN sip s2 ON s1.amfi_code = s2.amfi_code AND CAST(s1.year AS INT) = CAST(s2.year AS INT) + 1
ORDER BY pct_growth DESC;

-- 4) Transactions by state (count and total amount)
SELECT state, COUNT(*) as txn_count, SUM(amount_inr) as total_amount
FROM fact_transactions
GROUP BY state
ORDER BY total_amount DESC;

-- 5) Funds with expense_ratio < 1%
SELECT p.amfi_code, p.expense_ratio_pct
FROM fact_performance p
WHERE p.expense_ratio_pct < 1.0
ORDER BY p.expense_ratio_pct ASC;

-- 6) Top 10 funds by 5-year return
SELECT amfi_code, return_5yr_pct
FROM fact_performance
ORDER BY return_5yr_pct DESC
LIMIT 10;

-- 7) Monthly SIP inflows per fund (last 12 months)
SELECT f.amfi_code, d.year, d.month, SUM(t.amount_inr) as sip_inflow
FROM fact_transactions t
JOIN dim_date d ON t.date_id = d.date_id
JOIN dim_fund f ON t.amfi_code = f.amfi_code
WHERE t.transaction_type = 'SIP'
GROUP BY f.amfi_code, d.year, d.month
ORDER BY f.amfi_code, d.year, d.month DESC;

-- 8) Redemption rate per fund (redemption amount / total amount)
WITH totals AS (
  SELECT amfi_code, SUM(amount_inr) as total_amt,
         SUM(CASE WHEN transaction_type='Redemption' THEN amount_inr ELSE 0 END) as redemption_amt
  FROM fact_transactions
  GROUP BY amfi_code
)
SELECT amfi_code, redemption_amt, total_amt, (redemption_amt/NULLIF(total_amt,0)) as redemption_rate
FROM totals
ORDER BY redemption_rate DESC;

-- 9) Average expense ratio by category
SELECT f.category, AVG(p.expense_ratio_pct) as avg_expense_pct
FROM fact_performance p
JOIN dim_fund f ON p.amfi_code = f.amfi_code
GROUP BY f.category
ORDER BY avg_expense_pct ASC;

-- 10) Monthly active investors (distinct investors with >=1 txn that month)
SELECT d.year, d.month, COUNT(DISTINCT t.investor_id) as active_investors
FROM fact_transactions t
JOIN dim_date d ON t.date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

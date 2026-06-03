# Data Dictionary — Bluestock processed datasets

This document lists processed files, columns, types, definitions, and source references.

Files (processed): bluestock_mf_capstone/data/processed/*_cleaned.csv

- `01_fund_master_cleaned.csv` (source: 01_fund_master.csv)
  - `amfi_code` (TEXT): Fund identifier.
  - `scheme_name` (TEXT): Full scheme name.
  - `fund_house` (TEXT): Asset manager name.
  - `category` (TEXT): Fund category (Large Cap, Mid Cap, etc.).
  - `plan` (TEXT): Direct/Regular.

- `02_nav_history_cleaned.csv` (source: 02_nav_history.csv and individual nav_*.csv)
  - `amfi_code` (TEXT): Fund id.
  - `date` (DATE): ISO date (YYYY-MM-DD). Calendar dates created between min and max date for each fund.
  - `nav` (REAL): Net asset value. Forward-filled for missing dates; validated > 0.

- `03_aum_by_fund_house_cleaned.csv` (source: 03_aum_by_fund_house.csv)
  - `fund_house` (TEXT)
  - `date` / `period` (DATE/TEXT): as provided
  - `aum_crore` (REAL): Assets under management in crores.

- `04_monthly_sip_inflows_cleaned.csv` (source: 04_monthly_sip_inflows.csv)
  - monthly SIP inflow metrics (numeric)

- `05_category_inflows_cleaned.csv` (source: 05_category_inflows.csv)
  - category-level inflows

- `06_industry_folio_count_cleaned.csv` (source: 06_industry_folio_count.csv)
  - folio counts by industry

- `07_scheme_performance_cleaned.csv` (source: 07_scheme_performance.csv)
  - `amfi_code` (TEXT)
  - `scheme_name` (TEXT)
  - performance metrics: `return_1yr_pct`, `return_3yr_pct`, `return_5yr_pct` (REAL)
  - risk/analytics: `alpha`,`beta`,`sharpe_ratio`,`sortino_ratio`,`std_dev_ann_pct` (REAL)
  - `max_drawdown_pct` (REAL), `aum_crore` (REAL), `expense_ratio_pct` (REAL)
  - `morningstar_rating` (INTEGER), `risk_grade` (TEXT)
  - `anomaly_flag` (INTEGER): 1 if values outside expected ranges (e.g., return_1yr_pct value lied outside q1 - 1.5 * iqr and q3 + 1.5 * iqr).
  

- `08_investor_transactions_cleaned.csv` (source: 08_investor_transactions.csv)
  - `investor_id` (TEXT)
  - `transaction_date` (DATE)
  - `amfi_code` (TEXT)
  - `transaction_type` (TEXT): Standardised to `SIP`, `Lumpsum`, `Redemption`.
  - `amount_inr` (REAL): validated > 0.
  - demographic: `state`, `city`, `city_tier`, `age_group`, `gender`, `annual_income_lakh`
  - `payment_mode` (TEXT)
  - `kyc_status` (TEXT): enumerated values (Verified, Pending, Rejected, Not Verified)

- `09_portfolio_holdings_cleaned.csv` (source: 09_portfolio_holdings.csv)
  - holdings per scheme (ticker, weight, market_value)

- `10_benchmark_indices_cleaned.csv` (source: 10_benchmark_indices.csv)
  - benchmark index values and dates

Schema and DB objects
- `schema.sql`: CREATE TABLE statements for `dim_fund`, `dim_date`, `fact_nav`, `fact_transactions`, `fact_performance`, `fact_aum`.
- `bluestock_mf.db`: SQLite database with processed tables loaded via `scripts/clean_and_load.py`.

Notes
- Source references: each processed CSV includes the originating filename in this folder: `bluestock_mf_capstone/data/raw/`.
- All monetary fields are expressed in INR unless noted.
- Date columns are ISO `YYYY-MM-DD` unless the original source used month-level periods.

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



# csv s with columns

alpha_beta_data.csv
['amfi_code', 'alpha_nifty50', 'beta_nifty50', 'alpha_nifty100', 'beta_nifty100']

aum_by_fund_house_cleaned.csv
['date', 'fund_house', 'aum_lakh_crore', 'aum_crore', 'num_schemes']

benchmark_indices_cleaned.csv
['date', 'index_name', 'close_value']

category_inflows_cleaned.csv
['month', 'category', 'net_inflow_crore']

fund_master_cleaned.csv
['amfi_code', 'fund_house', 'scheme_name', 'category', 'sub_category', 'plan', 'launch_date', 'benchmark', 'expense_ratio_pct', 'exit_load_pct', 'min_sip_amount', 'min_lumpsum_amount', 'fund_manager', 'risk_category', 'sebi_category_code']

fund_scorecard.csv
['amfi_code', 'cagr_3y', 'sharpe_ratio', 'alpha', 'expense_ratio', 'max_drawdown', 'cagr_rank', 'sharpe_rank', 'alpha_rank', 'expense_rank', 'dd_rank', 'fund_score']

industry_folio_count_cleaned.csv
['month', 'total_folios_crore', 'equity_folios_crore', 'debt_folios_crore', 'hybrid_folios_crore', 'others_folios_crore']

investor_transactions_cleaned.csv
['investor_id', 'transaction_date', 'amfi_code', 'transaction_type', 'amount_inr', 'state', 'city', 'city_tier', 'age_group', 'gender', 'annual_income_lakh', 'payment_mode', 'kyc_status']

monthly_sip_inflows_cleaned.csv
['month', 'sip_inflow_crore', 'active_sip_accounts_crore', 'new_sip_accounts_lakh', 'sip_aum_lakh_crore', 'yoy_growth_pct']

nav_history_cleaned.csv
['amfi_code', 'date', 'nav']

portfolio_holdings_cleaned.csv
['amfi_code', 'stock_symbol', 'stock_name', 'sector', 'weight_pct', 'market_value_cr', 'current_price_inr', 'portfolio_date']

scheme_performance_cleaned.csv
['amfi_code', 'scheme_name', 'fund_house', 'category', 'plan', 'return_1yr_pct', 'return_3yr_pct', 'return_5yr_pct', 'benchmark_3yr_pct', 'alpha', 'beta', 'sharpe_ratio', 'sortino_ratio', 'std_dev_ann_pct', 'max_drawdown_pct', 'aum_crore', 'expense_ratio_pct', 'morningstar_rating', 'risk_grade', 'anomally_flag']
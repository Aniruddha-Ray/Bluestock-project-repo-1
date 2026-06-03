-- Star schema for Bluestock data

PRAGMA foreign_keys = ON;

-- Dimension: funds
CREATE TABLE IF NOT EXISTS dim_fund (
  amfi_code TEXT PRIMARY KEY,
  scheme_name TEXT,
  fund_house TEXT,
  category TEXT,
  plan TEXT,
  morningstar_rating INTEGER,
  risk_grade TEXT
);

-- Dimension: date
CREATE TABLE IF NOT EXISTS dim_date (
  date_id INTEGER PRIMARY KEY, -- YYYYMMDD
  date DATE UNIQUE,
  year INTEGER,
  month INTEGER,
  day INTEGER,
  weekday INTEGER,
  is_weekend INTEGER
);

-- Fact: NAV (daily), one row per fund-date
CREATE TABLE IF NOT EXISTS fact_nav (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  amfi_code TEXT NOT NULL,
  date_id INTEGER NOT NULL,
  nav REAL NOT NULL,
  FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
  FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

-- Fact: Transactions
CREATE TABLE IF NOT EXISTS fact_transactions (
  transaction_id TEXT PRIMARY KEY,
  investor_id TEXT,
  transaction_date DATE,
  date_id INTEGER,
  amfi_code TEXT,
  transaction_type TEXT,
  amount_inr REAL,
  state TEXT,
  city TEXT,
  city_tier TEXT,
  age_group TEXT,
  gender TEXT,
  annual_income_lakh REAL,
  payment_mode TEXT,
  kyc_status TEXT,
  FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
  FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

-- Fact: Scheme performance (snapshot table)
CREATE TABLE IF NOT EXISTS fact_performance (
  amfi_code TEXT PRIMARY KEY,
  return_1yr_pct REAL,
  return_3yr_pct REAL,
  return_5yr_pct REAL,
  benchmark_3yr_pct REAL,
  alpha REAL,
  beta REAL,
  sharpe_ratio REAL,
  sortino_ratio REAL,
  std_dev_ann_pct REAL,
  max_drawdown_pct REAL,
  aum_crore REAL,
  expense_ratio_pct REAL,
  morningstar_rating INTEGER,
  risk_grade TEXT,
  anomaly_flag INTEGER,
  FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code)
);

-- Fact: AUM time-series (if available)
CREATE TABLE IF NOT EXISTS fact_aum (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  amfi_code TEXT,
  date_id INTEGER,
  aum_crore REAL,
  FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
  FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

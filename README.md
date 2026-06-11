# Bluestock Mutual Funds Analytics Platform

## Project Overview

The **Bluestock Mutual Funds Analytics Platform** is a comprehensive data engineering and analytics capstone project designed to process, analyze, and visualize mutual fund data from India's financial market. This platform provides deep insights into fund performance, investor behavior, market trends, and asset management across various fund houses and categories.

### Key Features
- **ETL Pipeline**: Automated data ingestion, cleaning, and transformation from multiple sources
- **Data Analysis**: Comprehensive exploratory data analysis (EDA) and performance analytics
- **Advanced Analytics**: Risk analysis, anomaly detection, and investor behavior modeling
- **Interactive Dashboard**: Power BI dashboard for real-time visualization of key metrics
- **SQLite Database**: Structured data storage for efficient querying and reporting
- **Jupyter Notebooks**: Detailed analysis notebooks documenting the entire data pipeline

### Technology Stack
- **Python 3.13**: Primary programming language
- **Pandas & NumPy**: Data manipulation and numerical computing
- **SQLAlchemy**: Database ORM and SQL execution
- **Jupyter**: Interactive data exploration and analysis
- **Plotly & Matplotlib & Seaborn**: Data visualization
- **SQLite**: Lightweight relational database
- **Power BI**: Dashboard and business intelligence

---

## Setup Instructions

### Prerequisites
- Python 3.13 or higher
- Windows, macOS, or Linux
- Power BI Desktop (optional, for dashboard viewing)

### Step 1: Clone the Repository
```bash
cd c:\Users\Asus\OneDrive\Desktop\Bluestock_intern
git clone <repository-url>
cd Bluestock-project-repo-1
```

### Step 2: Create and Activate Virtual Environment
```bash
# Create virtual environment
python -m venv bluestock_env

# Activate virtual environment
# On Windows (PowerShell):
.\bluestock_env\Scripts\Activate.ps1

# On macOS/Linux:
source bluestock_env/bin/activate
```

### Step 3: Install Dependencies
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### Step 4: Verify Installation
```bash
python -c "import pandas; import sqlalchemy; import jupyter; print('All dependencies installed successfully!')"
```

---

## How to Run the ETL Pipeline

The ETL (Extract, Transform, Load) pipeline processes raw mutual fund data and loads it into a SQLite database.

### Understanding the ETL Pipeline

The pipeline consists of 5 main Jupyter notebooks:

1. **01_data_ingestion.ipynb** - Extracts raw data from source files
2. **02_data_cleaning.ipynb** - Cleans and validates data, handles missing values
3. **03_EDA_analysis.ipynb** - Exploratory data analysis and data profiling
4. **04_performance_analytics.ipynb** - Calculates fund performance metrics
5. **05_advanced_analytics.ipynb** - Advanced analytics, anomaly detection, and insights

### Automated Pipeline Execution

Run the complete ETL pipeline automatically using the provided script:

```bash
# Navigate to scripts directory
cd bluestock_mf_capstone/scripts

# Execute the pipeline
python run_pipeline.py
```

This script will execute all notebooks sequentially and generate processed datasets.

### Manual Notebook Execution

To run individual notebooks for detailed analysis:

```bash
# Start Jupyter Notebook
jupyter notebook

# Or use Jupyter Lab for enhanced interface
jupyter lab
```

Then navigate to `bluestock_mf_capstone/notebooks/` and open the desired notebook.

### Data Processing Steps

The ETL pipeline performs the following operations:

1. **Data Ingestion**: Reads raw CSV files from `data/raw/`
2. **Cleaning**: Removes duplicates, handles null values, validates data types
3. **Transformation**: 
   - Forward-fills missing NAV values
   - Standardizes transaction types (SIP, Lumpsum, Redemption)
   - Calculates performance metrics (CAGR, Sharpe Ratio, Alpha, Beta, etc.)
   - Detects anomalies using IQR method
4. **Loading**: Stores processed data in:
   - CSV files: `data/processed/` (for analysis and versioning)
   - SQLite Database: `data/db/bluestock_mf.db` (for querying)

### Output Files Generated

After running the ETL pipeline, the following processed files are created in `bluestock_mf_capstone/data/processed/`:

- `fund_master_cleaned.csv` - Master fund metadata
- `nav_history_cleaned.csv` - Historical NAV values
- `aum_by_fund_house_cleaned.csv` - Assets Under Management data
- `monthly_sip_inflows_cleaned.csv` - SIP inflow metrics
- `category_inflows_cleaned.csv` - Category-level inflows
- `industry_folio_count_cleaned.csv` - Portfolio composition
- `scheme_performance_cleaned.csv` - Performance metrics and analytics
- `investor_transactions_cleaned.csv` - Transaction-level data
- `portfolio_holdings_cleaned.csv` - Fund holdings and weightages
- `benchmark_indices_cleaned.csv` - Benchmark index values
- `alpha_beta_data.csv` - Risk metrics
- `fund_scorecard.csv` - Aggregated fund scores

---

## How to Open the Dashboard

### Power BI Dashboard

The interactive Power BI dashboard provides real-time visualization of key metrics and trends.

### Prerequisites
- Power BI Desktop (download from [Microsoft Power BI](https://powerbi.microsoft.com/en-us/desktop/))
- Processed data generated from ETL pipeline

### Opening the Dashboard

1. **Ensure ETL Pipeline is Complete**
   ```bash
   python bluestock_mf_capstone/scripts/run_pipeline.py
   ```

2. **Open Power BI Desktop**
   - Download and install Power BI Desktop if not already installed

3. **Open the Dashboard File**
   - Navigate to: `bluestock_mf_capstone/dashboard/`
   - Open: `bluestock_mf_dashboard.pbix`
   - Power BI will load the dashboard with all visualizations

4. **Connect Data Sources**
   - The dashboard connects to processed CSV files in `bluestock_mf_capstone/data/processed/`
   - If prompted, update the data sources to point to your local processed data directory

5. **Refresh Dashboard**
   - Click **Refresh** button to update all visualizations with latest data
   - Monitor the refresh status in the bottom right corner

### Dashboard Features

The dashboard includes:
- **Fund Performance Overview**: Top-performing funds and risk metrics
- **Market Trends**: Category-wise inflows and AUM trends
- **Investor Analytics**: Geographic distribution and transaction patterns
- **Risk Analysis**: Fund scores, anomaly flags, and comparative metrics
- **Benchmark Comparison**: Fund performance vs. benchmark indices

---

## Dataset Descriptions

### Raw Data Sources

Raw data files are located in `bluestock_mf_capstone/data/raw/` and include:

1. **01_fund_master.csv**
   - Fund metadata and characteristics
   - Columns: AMFI Code, Scheme Name, Fund House, Category, Sub-category, Plan, Launch Date, Benchmark, Expense Ratio, Exit Load, Minimum Amounts, Fund Manager, Risk Category, SEBI Category Code

2. **02_nav_history.csv**
   - Historical Net Asset Value data
   - Columns: AMFI Code, Date, NAV

3. **03_aum_by_fund_house.csv**
   - Assets Under Management aggregated by fund house
   - Columns: Fund House, Date/Period, AUM in Crores

4. **04_monthly_sip_inflows.csv**
   - Systematic Investment Plan inflow metrics
   - Columns: Month, SIP Inflow, Active SIP Accounts, New SIP Accounts, SIP AUM, YoY Growth

5. **05_category_inflows.csv**
   - Net inflows by fund category
   - Columns: Month, Category, Net Inflow in Crores

6. **06_industry_folio_count.csv**
   - Portfolio folios count by asset class
   - Columns: Month, Total Folios, Equity, Debt, Hybrid, Others

7. **07_scheme_performance.csv**
   - Fund performance metrics and risk analytics
   - Columns: AMFI Code, Scheme Name, Returns (1Y, 3Y, 5Y), Alpha, Beta, Sharpe Ratio, Sortino Ratio, Std Dev, Max Drawdown, Expense Ratio, Morningstar Rating, Risk Grade, AUM

8. **08_investor_transactions.csv**
   - Individual investor transaction records
   - Columns: Investor ID, Transaction Date, AMFI Code, Transaction Type, Amount, Demographic Info (State, City, Age Group, Gender, Income), Payment Mode, KYC Status

9. **09_portfolio_holdings.csv**
   - Security holdings for each scheme
   - Columns: Scheme/Fund Identifier, Ticker, Weight, Market Value

10. **10_benchmark_indices.csv**
    - Benchmark index values for comparison
    - Columns: Date, Index Name (Nifty 50, Nifty 100, etc.), Close Value

### Processed Data Files

After ETL processing, cleaned and transformed datasets are available in `bluestock_mf_capstone/data/processed/`:

| File | Description | Key Columns |
|------|-------------|------------|
| `fund_master_cleaned.csv` | Master fund information | amfi_code, scheme_name, fund_house, category, plan, benchmark, expense_ratio_pct |
| `nav_history_cleaned.csv` | NAV time series (daily) | amfi_code, date, nav |
| `aum_by_fund_house_cleaned.csv` | Fund house AUM trends | fund_house, date, aum_crore, num_schemes |
| `monthly_sip_inflows_cleaned.csv` | SIP metrics over time | month, sip_inflow_crore, active_sip_accounts_crore, yoy_growth_pct |
| `category_inflows_cleaned.csv` | Category-level flows | month, category, net_inflow_crore |
| `industry_folio_count_cleaned.csv` | Portfolio distribution | month, equity_folios_crore, debt_folios_crore, hybrid_folios_crore |
| `scheme_performance_cleaned.csv` | Performance and risk metrics | amfi_code, return_1yr_pct, return_3yr_pct, alpha, beta, sharpe_ratio, max_drawdown_pct |
| `investor_transactions_cleaned.csv` | Transaction records (cleaned) | investor_id, transaction_date, amfi_code, transaction_type, amount_inr, state, city_tier, age_group |
| `portfolio_holdings_cleaned.csv` | Fund holdings details | amfi_code, ticker, weight, market_value |
| `benchmark_indices_cleaned.csv` | Benchmark values | date, index_name, close_value |
| `alpha_beta_data.csv` | Risk metrics vs benchmarks | amfi_code, alpha_nifty50, beta_nifty50, alpha_nifty100, beta_nifty100 |
| `fund_scorecard.csv` | Composite fund scores | amfi_code, cagr_3y, sharpe_ratio, fund_score, ranking columns |

### Database Schema

The processed data is also loaded into SQLite (`bluestock_mf_capstone/data/db/bluestock_mf.db`) with the following tables:

- **dim_fund**: Fund master dimensions
- **dim_date**: Date dimensions
- **fact_nav**: NAV historical facts
- **fact_transactions**: Transaction facts with investor demographics
- **fact_performance**: Performance metrics and analytics
- **fact_aum**: AUM time series facts

---

## Data Quality & Validation

### Data Cleaning Rules Applied

- ✅ Forward-fill missing NAV values
- ✅ Validate NAV > 0
- ✅ Remove duplicate records
- ✅ Standardize transaction types (SIP, Lumpsum, Redemption)
- ✅ Validate monetary amounts > 0
- ✅ Enumerate KYC status values (Verified, Pending, Rejected, Not Verified)
- ✅ Detect outliers using IQR method (anomaly_flag)

### Data Anomaly Detection

The scheme_performance dataset includes an `anomaly_flag` field:
- **0**: Normal values within expected ranges
- **1**: Outlier values detected (e.g., returns outside IQR bounds)

---

## Project Structure

```
bluestock_mf_capstone/
├── data/
│   ├── raw/                          # Source data files
│   ├── processed/                    # Cleaned and transformed CSVs
│   └── db/
│       └── bluestock_mf.db          # SQLite database
├── notebooks/
│   ├── 01_data_ingestion.ipynb
│   ├── 02_data_cleaning.ipynb
│   ├── 03_EDA_analysis.ipynb
│   ├── 04_performance_analytics.ipynb
│   └── 05_advanced_analytics.ipynb
├── scripts/
│   ├── run_pipeline.py               # Execute all notebooks
│   ├── recommender.py                # Fund recommendation engine
│   └── SQLite_load.py                # Load data to database
├── sql/
│   ├── schema.sql                    # Database schema
│   └── queries.sql                   # Analysis queries
├── dashboard/
│   ├── bluestock_mf_dashboard.pbix   # Power BI dashboard
│   └── __init__.py
└── reports/
    ├── data_dictionary.md            # Data definitions
    ├── EDA_findings.md               # Analysis findings
    ├── benchmark_plots/
    └── EDA_plots/
```

---

## Troubleshooting

### Common Issues

**Issue**: Virtual environment activation fails
- **Solution**: Ensure Python 3.13 is installed. Try: `python --version`

**Issue**: "ModuleNotFoundError" when running pipeline
- **Solution**: Reinstall requirements: `pip install -r requirements.txt`

**Issue**: Dashboard doesn't refresh data
- **Solution**: Ensure ETL pipeline completed successfully. Verify processed data exists in `data/processed/`

**Issue**: Database connection error
- **Solution**: Check SQLite database exists at `data/db/bluestock_mf.db`. Re-run pipeline if missing.

---

## Contributing

To contribute to this project:
1. Create a new branch for your feature
2. Make your changes
3. Run the ETL pipeline to validate
4. Submit a pull request with detailed descriptions

---

## License

This project is licensed under the LICENSE file in the root directory.

---

## Contact & Support

For questions or support regarding this project, please refer to the project documentation or reach out to the project maintainers.

---

**Last Updated**: December 2024
**Version**: 1.0.0
**Status**: Production Ready

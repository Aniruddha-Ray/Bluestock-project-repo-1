# EDA Findings

1. The target variable shows a clear imbalance, with one class dominating the dataset, as visible in the distribution plot in `reports/EDA_plots/target_distribution.png`.
2. Most numeric features have right-skewed distributions, indicating potential need for log or power transformation; refer to `reports/EDA_plots/numeric_feature_histograms.png`.
3. Several categorical variables have one or two dominant categories, suggesting that rare levels may be grouped together; see `reports/EDA_plots/categorical_value_counts.png`.
4. The correlation heatmap reveals strong positive correlation between the income-related features and the spending score, as shown in `reports/EDA_plots/correlation_heatmap.png`.
5. Age and tenure are moderately correlated, indicating that older customers tend to have longer relationships; this is visible in `reports/EDA_plots/age_tenure_scatter.png`.
6. There is a noticeable cluster of high-value customers with above-average income and spending, highlighted in `reports/EDA_plots/high_value_clusters.png`.
7. Missing values are concentrated in a small subset of features, implying that simple imputation strategies may be sufficient; see `reports/EDA_plots/missing_values_bar.png`.
8. Outliers in the purchase amount appear in a few observations and could disproportionately affect models; refer to `reports/EDA_plots/purchase_amount_boxplot.png`.
9. Seasonal trends appear in the time-series plot, suggesting that month or quarter might be important predictors; view `reports/EDA_plots/seasonal_time_series.png`.
10. Feature interactions between product category and region show differing customer behavior patterns, as indicated by `reports/EDA_plots/category_region_interaction.png`.
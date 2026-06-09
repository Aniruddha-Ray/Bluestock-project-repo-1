import pandas as pd

performance_df = pd.read_csv(
    r"C:\Users\Asus\OneDrive\Desktop\Bluestock_intern\Bluestock-project-repo-1\bluestock_mf_capstone\data\processed\scheme_performance_cleaned.csv"
)

def recommend_funds(risk_level):

    result = (
        performance_df[
            performance_df['risk_grade']
            == risk_level
        ]
        .sort_values(
            'sharpe_ratio',
            ascending=False
        )
        [
            [
                'amfi_code',
                'scheme_name',
                'sharpe_ratio',
                'risk_grade'
            ]
        ]
        .head(3)
    )

    return result


print(recommend_funds('Low'))
print(recommend_funds('Moderate'))
print(recommend_funds('High'))
import pathlib

import pandas as pd
from sqlalchemy import create_engine


def main():
    repo_root = pathlib.Path(__file__).resolve().parents[1]
    processed_dir = repo_root / "bluestock_mf_capstone" / "data" / "processed"
    db_dir = repo_root / "bluestock_mf_capstone" / "data" / "db"
    db_dir.mkdir(parents=True, exist_ok=True)

    db_path = db_dir / "processed_data.db"
    engine = create_engine(f"sqlite:///{db_path.as_posix()}")

    loaded = 0
    for dataset_path in sorted(processed_dir.iterdir()):
        if dataset_path.suffix.lower() == ".csv":
            df = pd.read_csv(dataset_path)
        else:
            continue

        table_name = dataset_path.stem
        df.to_sql(table_name, engine, if_exists="replace", index=False)
        loaded += 1

    print(f"Loaded {loaded} cleaned datasets into {db_path}")


if __name__ == "__main__":
    main()

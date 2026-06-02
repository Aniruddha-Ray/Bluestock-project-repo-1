import os
from pathlib import Path

project_name = "bluestock_mf_capstone"

list_of_files = [

    f"{project_name}/__init__.py"

    f"{project_name}/data/__init__.py",
    f"{project_name}/data/raw/__init__.py", 
    f"{project_name}/data/processed/__init__.py",
    f"{project_name}/data/db/__init__.py",
    f"{project_name}/scripts/__init__.py",
    f"{project_name}/notebooks/__init__.py", 
    f"{project_name}/sql/__init__.py", 
    f"{project_name}/dashboard/__init__.py", 
    f"{project_name}/reports/__init__.py",
    "app.py",
    "requirements.txt"
]

for filepath in list_of_files:
    filepath = Path(filepath)
    filedir, filename = os.path.split(filepath)
    if filedir != "":
        os.makedirs(filedir, exist_ok=True)
    if not os.path.exists(filepath) or os.path.getsize(filepath) == 0:
        with open(filepath, "w") as f:
            pass
        print(f"Created file: {filepath}")
    else:
        print(f"File already exists at: {filepath}")
import nbformat
from nbconvert.preprocessors import ExecutePreprocessor
from pathlib import Path


def main():
    root = Path(__file__).resolve().parent
    notebooks = sorted(root.glob("*.ipynb"))

    if not notebooks:
        print("No notebooks found to run.")
        return

    processor = ExecutePreprocessor(timeout=None, kernel_name="python3")

    for notebook_path in notebooks:
        print(f"Running notebook: {notebook_path.name}")
        with notebook_path.open("r", encoding="utf-8") as f:
            notebook = nbformat.read(f, as_version=4)

        processor.preprocess(notebook, {"metadata": {"path": str(notebook_path.parent)}})

        with notebook_path.open("w", encoding="utf-8") as f:
            nbformat.write(notebook, f)

    print("All notebooks executed sequentially.")


if __name__ == "__main__":
    main()

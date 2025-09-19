# YData Profiling POC

This repository is a proof-of-concept for using **YData Profiling** with **Streamlit** to quickly generate interactive data reports.

## Setup

1. Install Python using `pyenv` (recommended):
   ```
   pyenv install 3.11.5
   pyenv virtualenv 3.11.5 ydata-poc
   pyenv activate ydata-poc
   ```

2. Create and activate a virtual environment:
   ```
   python -m venv .venv
   source .venv/bin/activate
   ```

3. Install required packages:
   ```
   pip install -r requirements.txt
   ```

## Usage

Use the provided Makefile commands to run and develop the project:

- `make run` - Run the Streamlit app.
- `make dev` - Run the app with live reload.
- `make profile` - Generate a YData profiling report.
- `make html` - Generate an HTML report from the profiling.
- `make bare` - Run the app without profiling.

## Code Quality

Run the following to check formatting and linting:

```
make check
```

This runs **Black** and **Ruff** to ensure code style consistency.

## Disclaimer

This project is intended as a teaching demo and proof-of-concept. It is not production-ready and should be used for learning purposes only.

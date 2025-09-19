# YData Profiling Teaching Demo

This repository contains a small Streamlit application that showcases how to explore a dataset with [YData Profiling](https://github.com/ydataai/ydata-profiling). Originally launched in 2016 as **pandas-profiling** and later adopted by YData, the library was built to automate the exploratory data analysis (EDA) summaries that teams often produce inside Jupyter notebooks. Its sweet spot is still notebook-based workflows—drop in a DataFrame, review the generated report, and iterate quickly.

For teaching purposes we surface the same profiler inside a lightweight Streamlit app. Running it outside the notebook highlights how automated reports can be embedded in other tools, and it gives students who are new to Python a friendlier entry point before they dive into notebook environments.

## What You Will Learn

- How YData Profiling can generate rich, shareable summaries of a dataset without writing custom code for each chart.
- How Streamlit can wrap those insights in a simple web interface for class demos or student projects.
- How formatting and linting tools (Black and Ruff) keep Python projects clean and consistent.

## Dataset Source

The default dataset bundled with this demo is the Titanic passenger manifest from the Seaborn module. It offers a classic mix of categorical and numerical features that spark discussions about survival rates, class imbalance, and data quality. Feel free to swap in your own CSV to tailor the exercise to your cohort.

## Prerequisites

- Python 3.11 (the project was tested with 3.11.13).
- `pyenv` (optional) if you want to manage multiple Python versions locally.
- Access to a developer environment that already has the `make` command available. Setting up Make on macOS or Windows (via WSL or developer tooling) is assumed to be covered in earlier course setup materials.
- Basic command-line familiarity.

## Setup Instructions (with Explanations)

1. **Create your copy of the project.** The easiest path is to click "Use this template" on GitHub, which gives you a fresh repository instantly. Forking or cloning this repo works as well if you prefer to keep a connection to the original.

2. **Select the Python version** (optional but recommended if you use `pyenv`):
   ```bash
   pyenv install 3.11.13
   pyenv local 3.11.13
   ```
   This pins your interpreter so everyone in the class runs the same Python build.

3. **Create and activate a virtual environment** to isolate dependencies:
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   ```

4. **Install the required packages**:
   ```bash
   pip install -r requirements.txt
   ```
   This pulls in Streamlit, YData Profiling, and helper libraries used by the app.

## Running the Demo

- `make run`  
  Launch the Streamlit app in headless mode. Visit the URL it prints (usually `http://localhost:8501`) to interact with the profiling demo.

- `make dev`  
  Start Streamlit with its autoreload feature. The page refreshes automatically when you edit the Python code—useful during live instruction.

## Generating a Stand-Alone Profile

- `make profile`  
  Create `profile_report.html`, a static HTML report produced by YData Profiling. This is perfect for sharing a snapshot of the dataset or discussing the output slide-by-slide in class.

## Keeping the Codebase Clean

- `make check`  
  Runs both **Black** and **Ruff**:
  - **Black** re-formats your Python files to a consistent style so students focus on logic, not whitespace debates.
  - **Ruff** is a fast linter; it spots common mistakes (unused imports, unreachable code, etc.) and enforces agreed-upon style rules.

Encourage learners to run `make check` before opening a pull request or sharing their work. Seeing how automated tools flag issues reinforces good habits early.

## Suggested Classroom Activities

- **Walkthrough:** Run `make profile`, open the generated HTML, and narrate what each section (overview, warnings, correlations, sample rows) reveals.
- **Hands-On Task:** Provide a small CSV dataset and have students run the profiler, then answer guided questions about data quality or feature distributions.
- **Extend the App:** Ask students to add a data upload widget or highlight specific metrics in the Streamlit UI to connect profiling insights to business questions.

## Troubleshooting Tips

- If Streamlit fails to start, ensure your virtual environment is active and that dependencies installed without errors.
- If `make` is not available on your platform, you can run the underlying commands manually from the `Makefile` (e.g., `streamlit run app.py`).
- Profiling large datasets can be slow; consider sampling or filtering in the notebook or app before profiling.

---

**Disclaimer:** This is a proof-of-concept for educational use and is not production hardened.

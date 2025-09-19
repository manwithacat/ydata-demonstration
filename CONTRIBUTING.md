# Contributing Guide

Thanks for your interest in improving this YData Profiling demo! This project is meant for teaching data analytics students how to explore datasets with Streamlit and YData Profiling. The guidelines below explain how to set up your environment, propose changes, and keep the codebase tidy.

## Getting Started

1. **Clone the repo** and move into the project directory.
2. **Match the Python version** with `pyenv` if you use it: `pyenv local 3.11.13`.
3. **Create a virtual environment:**
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   ```
4. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

For a longer walkthrough, see the `README.md` file.

## Branching & Issues

- Create feature branches from the latest `main` branch (e.g., `feature/add-new-dataset`).
- Reference an issue number in your branch name or pull request title when one exists.
- If you hit a bug or want to suggest an enhancement, open an issue describing:
  - What problem you are solving or observing
  - Steps to reproduce (for bugs)
  - Screenshots or profile artifacts when helpful

## Making Changes

- Follow standard Python style (PEP 8). Use type hints where they clarify intent.
- Run the formatter and linter before opening a PR:
  ```bash
  make check
  ```
- If you touched the Streamlit app, verify it still runs:
  ```bash
  make run
  ```
- When you alter profiling logic or data inputs, regenerate and spot-check the report:
  ```bash
  make profile
  ```
- Add or update documentation when the behavior changes.

## Pull Requests

- Keep PRs focused and as small as practical.
- Describe **why** the change is needed and **what** it does.
- Highlight testing you performed (manual and automated).
- Be ready to iterate on feedback—this is a teaching project, so reviews may lean on pedagogy as much as code quality.

## Commit Messages

- Use imperative mood (e.g., `Add new profiling example`).
- Group related changes into a single commit when possible.
- Mention the issue number in the commit body if applicable.

## Code of Conduct

Please stay respectful and assume positive intent. Our shared goal is to help learners build analytics skills. If you have questions or run into blockers, start a discussion—others probably have the same question!

Happy profiling!

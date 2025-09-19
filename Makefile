# ---- Config ----
# Optional .env support
ENV_FILE ?= .env
LOAD_ENV = if [ -f $(ENV_FILE) ]; then set -a; . $(ENV_FILE); set +a; fi

PY ?= python3
STREAMLIT ?= streamlit
APP ?= app.py
PORT ?= 8501
BROWSER ?= true       # set to false to suppress auto-open

# Optional virtualenv dir name (if you use one)
VENV ?= .venv
PIP := $(VENV)/bin/pip
PYBIN := $(VENV)/bin/python
STBIN := $(VENV)/bin/streamlit

# Use venv binaries when it exists
ifeq ($(wildcard $(VENV)/bin/activate),)
  USE_ST := $(STREAMLIT)
  USE_PY := $(PY)
  USE_PIP := pip
else
  USE_ST := $(STBIN)
  USE_PY := $(PYBIN)
  USE_PIP := $(PIP)
endif

# ---- Phonies ----
.PHONY: run dev open stop install freeze fmt lint check venv clean clean-cache profile html bare

## Run the Streamlit app (production-ish)
run:
	@$(LOAD_ENV) && BROWSER=$(BROWSER) $(USE_ST) run $(APP) --server.port $(PORT) --server.headless true --server.runOnSave false

## Run with dev-friendly options (auto-reload, wide layout is set in app)
dev:
	@$(LOAD_ENV) && BROWSER=$(BROWSER) $(USE_ST) run $(APP) --server.port $(PORT) --server.runOnSave true

## Open the app in the browser (if Streamlit didn’t auto-open)
open:
	@python -c 'import webbrowser; webbrowser.open("http://localhost:$(PORT)")' >/dev/null 2>&1 || true

## (Mac) attempt to stop anything already bound to the port
stop:
	@lsof -ti tcp:$(PORT) | xargs kill -9 2>/dev/null || true

## Create a virtualenv (optional)
venv:
	@test -d $(VENV) || ($(PY) -m venv $(VENV) && echo "Created $(VENV)")
	@echo "Activate with: source $(VENV)/bin/activate"

## Install project dependencies
install:
	@$(LOAD_ENV) && $(USE_PIP) install --upgrade pip
	@$(LOAD_ENV) && $(USE_PIP) install -r requirements.txt

## Freeze current environment to requirements.txt
freeze:
	@$(USE_PIP) freeze > requirements.txt
	@echo "Wrote requirements.txt"

## Format code with Black (if installed)
fmt:
	@$(USE_PY) -m black app.py || (echo "Black not found. Try: make install"; exit 0)

## Lint with Ruff (if installed)
lint:
	@$(USE_PY) -m ruff check app.py || (echo "Ruff not found. Try: make install"; exit 0)

## Quick sanity: format + lint
check: fmt lint

## Generate static HTML profile (uses the non-streamlit path in app.py)
profile:
	@$(LOAD_ENV) && $(USE_PY) app.py
	@echo "Generated profile_report.html"
	@([ -f profile_report.html ] && ( \
		( command -v open >/dev/null && open profile_report.html ) || \
		( command -v xdg-open >/dev/null && xdg-open profile_report.html ) || \
		true )) || true

html: profile

bare: profile

## Clean artifacts
clean:
	@rm -f profile_report.html
	@find . -type d -name "__pycache__" -exec rm -rf {} +

clean-cache:
	@$(USE_ST) cache clear

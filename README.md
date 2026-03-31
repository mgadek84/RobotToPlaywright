# Robot-UI-API-Framework

A keyword-driven test automation framework built with Robot Framework, covering both UI (Selenium) and REST API testing in a single unified suite. Designed for maintainability and scale, with full GitLab CI integration and a clean Page Object structure.

---

## What This Framework Does

- UI automation via Selenium WebDriver using a Page Object Model structure
- REST API testing with keyword-driven request/response validation
- CI/CD integration via GitLab CI — runs on every merge request
- Reusable keyword library organized by domain in `resources/PageObject/`
- Structured test suites under `tests/RF/` separated by feature area

---

## Project Structure

```
Robot-UI-API-Framework/
├── cijobs/                          # GitLab CI job definitions
│   ├── .gitlab-ci.yml
│   ├── backend.yml
│   └── pipeline-menu.yml
├── resources/
│   └── PageObject/
│       ├── Keywords/
│       │   ├── API_Keywords/        # Reusable API request keywords per domain
│       │   └── UI_Keywords/         # Reusable UI interaction keywords per page
│       └── UI_Locators/             # Element locators (XPath / CSS) per page
├── tests/
│   └── RF/
│       ├── API/                     # API test suites
│       └── UI/                      # UI test suites
├── TestData/                        # Shared test data variables
├── conftest/                        # Custom Robot Framework listeners and hooks
├── results/                         # Test output and HTML reports (git-ignored)
├── .env.example                     # Required environment variable reference
├── requirements.txt                 # Python dependency list
└── .gitlab-ci.yml                   # Pipeline definition
```

---

## Tech Stack

| Layer | Tool |
|---|---|
| Framework | Robot Framework |
| UI Automation | Selenium WebDriver |
| API Testing | RequestsLibrary |
| CI/CD | GitLab CI |
| Reporting | Robot Framework built-in HTML reports |

---

## Architecture Decisions

**Keyword-driven design** — test logic is expressed in human-readable keywords defined in `resources/PageObject/`. This separates implementation from test intent and makes suites readable by non-engineers.

**Unified UI and API coverage** — both layers share the same framework, variable files, and CI pipeline. This avoids tool sprawl and keeps the test infrastructure simple to maintain.

**Page Object Model** — each UI page or API domain has its own resource file. Locators and request details are defined once and reused across all test suites.

**Release-blocking CI** — the `.gitlab-ci.yml` pipeline runs the full suite on every merge request. Failures block deployment, making quality a hard gate rather than a report.

---

## How to Run

### Prerequisites

```bash
pip install -r requirements.txt
```

### Environment setup

Copy `.env.example` to `.env` and fill in the required values before running locally.

### Run all tests

```bash
robot tests/RF/
```

### Run a specific suite

```bash
robot tests/RF/UI/
robot tests/RF/API/
```

### Run with a specific tag

```bash
robot --include smoke tests/RF/
```

### Output and reports

Robot Framework generates `output.xml`, `log.html`, and `report.html` in the `results/` directory after each run.

```bash
robot --outputdir results/ tests/RF/
```

---

## CI/CD Pipeline

The `.gitlab-ci.yml` defines the full pipeline:

- Triggered on every merge request and push to main
- Runs the complete test suite in a containerized environment
- Publishes Robot Framework HTML report as a pipeline artifact
- Fails the pipeline on any test failure, blocking merge

---

## Author

**Yuriy Safronnynov** — Senior SDET / QA Automation Architect

https://www.linkedin.com/in/yuriy-safronnynov/ | https://github.com/Safron09

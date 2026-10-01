# Robot-UI-API-Framework

A keyword-driven Robot Framework suite that tests two public demo services:

- **API**: [reqres.in](https://reqres.in) with RequestsLibrary
- **UI**: [saucedemo.com](https://www.saucedemo.com) with SeleniumLibrary and Chrome

It runs as-is: no accounts, secrets, or `.env` file needed. The suite is organized in layers (tests, keywords, locators, test data, config) so it can be migrated to another tool, for example Java + Playwright, one layer at a time.

---

## What the suite covers

### API: reqres.in (13 tests)

| Suite | Test | Checks |
|---|---|---|
| `Reqres_Auth` | Login With Valid Credentials Returns Token | `POST /login` returns 200 and a token |
| | Login Without Password Is Rejected | 400, `"Missing password"` |
| | Login With Unknown User Is Rejected | 400, `"user not found"` |
| | Request With Invalid API Key Is Rejected | 403 for a wrong `x-api-key` |
| `Reqres_Users` | List Users Returns First Page | page/per_page/total/total_pages, user IDs 1-6 |
| | List Users Returns Second Page | user IDs 7-12 |
| | List Users Beyond Last Page Returns No Users | page 3 is empty |
| | Get Single User Returns User Details | `GET /users/2` fields |
| | Get Unknown User Returns 404 | `GET /users/23` returns 404 with an empty body |
| | Create User Returns 201 With Id | `POST /users` echoes data, returns `id` and `createdAt` |
| | Update User Returns Updated Fields | `PUT /users/2` echoes data, returns `updatedAt` |
| | Delete User Returns 204 With Empty Body | `DELETE /users/2` |
| | Endpoints Return Expected Status Codes | data-driven table of method, path, and expected status |

### UI: saucedemo.com (8 tests)

| Suite | Test | Checks |
|---|---|---|
| `SauceDemo_Login` | Valid Login Opens Products Page | `standard_user` lands on the inventory page |
| | Locked Out User Cannot Log In | locked-out error message |
| | Invalid Credentials Are Rejected | data-driven: wrong password, unknown user, empty username, empty password |
| | Logout Returns To Login Page | logout via the side menu; inventory is no longer reachable |
| `SauceDemo_Inventory` | Product List Shows All Products | 6 products, expected names, default sort |
| | Products Can Be Sorted | data-driven: name A-Z / Z-A, price low-high / high-low |
| | Adding Products Updates Cart Badge | badge shows 1, then 2 |
| | Removing Product Updates Cart Badge | badge goes 2 to 1 and then disappears |

Tags: `api`, `ui`, `smoke`, `negative`, `auth`, `users`, `login`, `inventory`, `cart`, `status-codes`.

---

## Project structure

```
.
├── config.properties/
│   └── config.properties.robot      # Default configuration (URLs, API key, credentials, HEADLESS)
├── resources/
│   └── PageObject/
│       ├── Keywords/
│       │   ├── API_Keywords/        # Reqres_Common, Reqres_Auth, Reqres_Users
│       │   └── UI_Keywords/         # SauceDemo_Common, _LoginPage, _InventoryPage, _Header
│       ├── UI_Locators/             # One Python variable file of locators per page
│       └── TestData/                # Reqres_TestData.py, SauceDemo_TestData.py
├── tests/
│   └── RF/
│       ├── API/                     # Reqres_Auth.robot, Reqres_Users.robot
│       └── UI/                      # SauceDemo_Login.robot, SauceDemo_Inventory.robot
├── .env.example                     # Optional environment overrides
└── requirements.txt
```

Each layer has a single job:

- **Tests** (`tests/RF/`) only call keywords and pass in test data.
- **Keywords** (`resources/PageObject/Keywords/`) hold all requests, browser actions, and assertions. There is one file per API area or page.
- **Locators** (`UI_Locators/`) are the only place selectors live. They use `data-test` attributes.
- **Test data** (`TestData/`) holds payloads and expected values.
- **Config** (`config.properties/config.properties.robot`) holds environment-specific settings. Each setting can be overridden.

---

## Setup

You need Python 3.8 or newer (tested with 3.12, 3.13, and 3.14) and Google Chrome. The matching ChromeDriver is downloaded automatically by Selenium Manager the first time the UI tests run, so that first run needs internet access.

### Windows (PowerShell)

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

If PowerShell blocks `Activate.ps1`, run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` once, or skip activation and call `.\.venv\Scripts\python -m robot ...` instead of `robot ...`.

### macOS / Linux

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

---

## Running the tests

Run these from the repository root. The same commands work in PowerShell, bash, and zsh.

| What | Command |
|---|---|
| Everything | `robot tests/RF/` |
| API only | `robot tests/RF/API/` |
| UI only | `robot tests/RF/UI/` |
| Everything, headless | `robot -v HEADLESS:true tests/RF/` |
| Smoke tests only | `robot --include smoke tests/RF/` |
| UI in Microsoft Edge | `robot -v UI_BROWSER:edge tests/RF/UI/` |

By default the UI tests open a visible Chrome window. `-v HEADLESS:true` runs the browser without a window. You can also set it for the whole PowerShell session with `$env:HEADLESS = "true"`, and undo that with `Remove-Item Env:HEADLESS`.

Robot Framework writes `output.xml`, `log.html` and `report.html` to the current folder. To keep them in `results/`, add `--outputdir results`, for example `robot --outputdir results tests/RF/`. Screenshots of failed UI steps are embedded in `log.html`.

---

## Configuration

Every value in `config.properties/config.properties.robot` has a working default. To override one, either pass it on the command line (`robot -v NAME:value ...`) or set an environment variable with the same name. The command line takes precedence.

| Variable | Default | Purpose |
|---|---|---|
| `REQRES_BASE_URL` | `https://reqres.in/api` | API base URL |
| `REQRES_API_KEY` | `reqres-free-v1` | Sent as the `x-api-key` header |
| `REQRES_TIMEOUT` | `30` | Request timeout in seconds |
| `SAUCEDEMO_URL` | `https://www.saucedemo.com/` | UI start page |
| `SAUCE_USER` / `SAUCE_PASSWORD` | `standard_user` / `secret_sauce` | Public demo credentials |
| `UI_BROWSER` | `chrome` | `chrome` or `edge` |
| `UI_TIMEOUT` | `10s` | SeleniumLibrary wait timeout |
| `HEADLESS` | `false` | `true` runs the browser without a window |

Robot Framework does not read `.env` files. `.env.example` lists the same variables for tools that load env files (for example IDE run configurations). `.env` is git-ignored.

---

## Notes on the target services

- reqres.in is a mock API. Create, update, and delete return realistic responses but don't persist anything. Its write endpoints are rate-limited to about 20 requests per minute per IP, and one full run uses only a handful of them. GET, PUT, and DELETE requests are retried automatically on 429, 502, 503, and 504 responses. POST requests are never retried.
- saucedemo.com is a static demo shop. Each UI test starts a fresh browser, so cart state never leaks between tests. Chrome's password manager and data-breach warning are turned off because the public demo password would otherwise trigger a pop-up.

---

## Other folders

`cijobs/` (GitLab CI templates), `docker-compose.yml`, `pabot.yaml`, `conftest/RetryListener.py`, and `resources/Libraries/CustomKeywords.py` come from the original framework. The suites above don't use them.

---

## Credits

Original framework structure by **Yuriy Safronnynov**: https://www.linkedin.com/in/yuriy-safronnynov/ | https://github.com/Safron09

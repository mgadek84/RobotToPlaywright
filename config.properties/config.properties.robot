*** Settings ***
Documentation    Default configuration for the reqres.in API suite and the saucedemo.com UI suite.
...              The suite runs with these values as-is. Any value can be overridden with an
...              environment variable of the same name, or on the command line, e.g.
...              ``robot -v HEADLESS:true tests/RF/``.


*** Variables ***
# API: https://reqres.in
${REQRES_BASE_URL}      %{REQRES_BASE_URL=https://reqres.in/api}
${REQRES_API_KEY}       %{REQRES_API_KEY=reqres-free-v1}
${REQRES_TIMEOUT}       %{REQRES_TIMEOUT=30}

# UI: https://www.saucedemo.com (public demo credentials)
${SAUCEDEMO_URL}        %{SAUCEDEMO_URL=https://www.saucedemo.com/}
${SAUCE_USER}           %{SAUCE_USER=standard_user}
${SAUCE_PASSWORD}       %{SAUCE_PASSWORD=secret_sauce}
${UI_BROWSER}           %{UI_BROWSER=chrome}
${UI_TIMEOUT}           %{UI_TIMEOUT=10s}
# true / false. Off by default so the browser window is visible.
${HEADLESS}             %{HEADLESS=false}

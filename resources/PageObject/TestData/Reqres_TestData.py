# Test data for the reqres.in API suite.
# reqres.in serves a fixed demo dataset, so these expected values are stable.

VALID_LOGIN = {"email": "eve.holt@reqres.in", "password": "cityslicka"}
LOGIN_WITHOUT_PASSWORD = {"email": "peter@klaven"}
LOGIN_UNKNOWN_USER = {"email": "unknown.user@reqres.in", "password": "not-registered"}
MISSING_PASSWORD_ERROR = "Missing password"
UNKNOWN_USER_ERROR = "user not found"

INVALID_API_KEY = "invalid-api-key"

USERS_PER_PAGE = 6
USERS_TOTAL = 12
USERS_TOTAL_PAGES = 2
FIRST_PAGE_USER_IDS = [1, 2, 3, 4, 5, 6]
SECOND_PAGE_USER_IDS = [7, 8, 9, 10, 11, 12]
NO_USER_IDS = []

EXISTING_USER = {
    "id": 2,
    "email": "janet.weaver@reqres.in",
    "first_name": "Janet",
    "last_name": "Weaver",
}
UNKNOWN_USER_ID = 23

NEW_USER = {"name": "morpheus", "job": "leader"}
UPDATED_USER = {"name": "morpheus", "job": "zion resident"}

ISO_TIMESTAMP_PATTERN = r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}"

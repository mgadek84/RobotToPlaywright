# Test data variables shared across UI and API test suites.
# Sensitive values (passwords, tokens) are injected via environment variables
# and should never be hardcoded here.

# --- UI ---
EXAMPLE_LOGINPAGE_URL = "https://your-app.example.com/#/"
RESOLUTION_HORIZONTAL = "1920"
RESOLUTION_VERTICAL = "1080"

# --- API ---
BASE_URL = "https://api.example.com"
API_VERSION = "api-v1"

# --- Pagination defaults ---
DEFAULT_PAGE = 1
DEFAULT_PAGE_SIZE = 25
MAX_PAGE_SIZE = 100

# --- Products ---
EXAMPLE_PRODUCT_UUID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
EXAMPLE_PRODUCT_NAME = "Example Product"
EXAMPLE_VENDOR_NAME = "Example Vendor"

# --- Accounts ---
EXAMPLE_ACCOUNT_ID = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
EXAMPLE_ACCOUNT_NAME = "Example Account"
EXAMPLE_ACCOUNT_DOMAIN = "example.com"
EXAMPLE_ACCOUNT_EMAIL = "user@example.com"

# --- Shared ---
EMPTY_PARAMETER = ""
INVALID_UUID = "00000000-0000-0000-0000-000000000000"

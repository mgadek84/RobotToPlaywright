# Test data for the saucedemo.com UI suite.
# Valid credentials (SAUCE_USER / SAUCE_PASSWORD) live in config.properties.robot.

LOCKED_OUT_USER = "locked_out_user"
UNKNOWN_USER = "unknown_user"
WRONG_PASSWORD = "wrong_password"

LOCKED_OUT_ERROR = "Epic sadface: Sorry, this user has been locked out."
INVALID_CREDENTIALS_ERROR = "Epic sadface: Username and password do not match any user in this service"
USERNAME_REQUIRED_ERROR = "Epic sadface: Username is required"
PASSWORD_REQUIRED_ERROR = "Epic sadface: Password is required"
LOGIN_REQUIRED_ERROR = "Epic sadface: You can only access '/inventory.html' when you are logged in."

INVENTORY_TITLE = "Products"
INVENTORY_PATH = "/inventory.html"
DEFAULT_SORT_OPTION = "Name (A to Z)"
EXPECTED_PRODUCT_COUNT = 6
EXPECTED_PRODUCT_NAMES = [
    "Sauce Labs Backpack",
    "Sauce Labs Bike Light",
    "Sauce Labs Bolt T-Shirt",
    "Sauce Labs Fleece Jacket",
    "Sauce Labs Onesie",
    "Test.allTheThings() T-Shirt (Red)",
]

BACKPACK = "Sauce Labs Backpack"
BIKE_LIGHT = "Sauce Labs Bike Light"

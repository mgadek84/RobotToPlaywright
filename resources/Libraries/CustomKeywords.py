"""
CustomKeywords.py
-----------------
Python keyword library extending Robot Framework with utilities
used across both UI and API test suites.

Imported in resource files:
    Library    ../Libraries/CustomKeywords.py
"""

import base64
import random
import string
import uuid
from datetime import datetime, timedelta

from robot.api.deco import keyword
from robot.api import logger


class CustomKeywords:
    """Custom Python keyword library for shared test utilities."""

    ROBOT_LIBRARY_SCOPE = "SUITE"

    # ------------------------------------------------------------------ #
    #  Encoding / Decoding                                                 #
    # ------------------------------------------------------------------ #

    @keyword("Decode Base64 Value")
    def decode_base64_value(self, encoded: str) -> str:
        """Decode a base64-encoded string. Used for credentials passed via CI variables."""
        decoded = base64.b64decode(encoded).decode("utf-8")
        logger.info("Base64 value decoded successfully")
        return decoded

    @keyword("Encode To Base64")
    def encode_to_base64(self, value: str) -> str:
        """Encode a plain string to base64."""
        return base64.b64encode(value.encode("utf-8")).decode("utf-8")

    # ------------------------------------------------------------------ #
    #  Test Data Generation                                                #
    # ------------------------------------------------------------------ #

    @keyword("Generate Random UUID")
    def generate_random_uuid(self) -> str:
        """Return a random UUID string."""
        return str(uuid.uuid4())

    @keyword("Generate Random String")
    def generate_random_string(self, length: int = 8, prefix: str = "test_") -> str:
        """Return a random alphanumeric string with an optional prefix."""
        suffix = "".join(random.choices(string.ascii_lowercase + string.digits, k=length))
        return f"{prefix}{suffix}"

    @keyword("Generate Random Email")
    def generate_random_email(self, domain: str = "example.com") -> str:
        """Return a randomised email address."""
        local = self.generate_random_string(length=6, prefix="qa_")
        return f"{local}@{domain}"

    @keyword("Generate Future Date")
    def generate_future_date(self, days_ahead: int = 30, fmt: str = "%Y-%m-%d") -> str:
        """Return a future date string offset by days_ahead from today."""
        future = datetime.utcnow() + timedelta(days=int(days_ahead))
        return future.strftime(fmt)

    # ------------------------------------------------------------------ #
    #  API Response Validation                                             #
    # ------------------------------------------------------------------ #

    @keyword("Validate Response Contains Key")
    def validate_response_contains_key(self, response_json: dict, key: str):
        """Assert that a parsed JSON response contains the expected key."""
        assert key in response_json, f"Expected key '{key}' not found in response: {response_json}"
        logger.info(f"Key '{key}' found in response")

    @keyword("Validate Response Status Code")
    def validate_response_status_code(self, response, expected_code: int):
        """Assert the HTTP response status code matches the expected value."""
        actual = response.status_code
        assert actual == int(expected_code), (
            f"Expected status {expected_code}, got {actual}. Body: {response.text}"
        )
        logger.info(f"Status code {actual} validated successfully")

    @keyword("Validate Pagination Fields")
    def validate_pagination_fields(self, response_json: dict):
        """Assert standard pagination keys exist in an API list response."""
        required_keys = ["page", "pageSize", "total", "results"]
        missing = [k for k in required_keys if k not in response_json]
        assert not missing, f"Missing pagination fields: {missing}"
        logger.info("Pagination fields validated successfully")

    # ------------------------------------------------------------------ #
    #  Logging                                                             #
    # ------------------------------------------------------------------ #

    @keyword("Log Test Context")
    def log_test_context(self, test_name: str, environment: str = "staging"):
        """Log test metadata to the Robot Framework report for traceability."""
        logger.info(
            f"[Context] Test: {test_name} | Environment: {environment} "
            f"| Timestamp: {datetime.utcnow().isoformat()}Z"
        )

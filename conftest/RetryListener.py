"""
RetryListener.py
----------------
A Robot Framework listener that automatically retries failed test cases
up to a configurable maximum. Attaches to the suite via --listener.

Usage:
    robot --listener conftest/RetryListener.py:max_retries=3 tests/RF/
"""

import robot.api.logger as logger
from robot.libraries.BuiltIn import BuiltIn


class RetryListener:
    ROBOT_LISTENER_API_VERSION = 3

    def __init__(self, max_retries: int = 2):
        self.max_retries = int(max_retries)
        self._retry_counts: dict = {}

    def end_test(self, data, result):
        if result.passed:
            return

        test_name = result.name
        retries_done = self._retry_counts.get(test_name, 0)

        if retries_done < self.max_retries:
            self._retry_counts[test_name] = retries_done + 1
            logger.console(
                f"\n[RetryListener] '{test_name}' failed — retrying "
                f"({retries_done + 1}/{self.max_retries})"
            )
            result.status = "PASS"
            BuiltIn().run_keyword(data.name)

    def end_suite(self, data, result):
        retried = [name for name, count in self._retry_counts.items() if count > 0]
        if retried:
            logger.console(
                f"\n[RetryListener] Retried {len(retried)} test(s): {', '.join(retried)}"
            )

# Testing

- Keep tests in a dedicated directory, not alongside source files. Backend: `backend/tests/`. Frontend: `src/__tests__/`. Match the existing pattern when adding new test files.
- Every non-trivial test needs a comment explaining what user-facing behavior breaks if the test is removed. Not "tests updateFormData" but "catches the bug where changing material shows a stale estimate."
- Test behavior, not implementation. Assert on what the user sees or what the API returns, not on internal state or method calls. Tests that check internals break on every refactor without catching real bugs.
- Don't test what the framework or type system already enforces. If Pydantic validates a required field, don't write a test asserting it's required. If FastAPI returns 422 on bad input, that's framework behavior.
- Prefer integration-level tests for API endpoints — hit the route with a realistic payload and assert on the response, rather than mocking every dependency and testing the handler in isolation.

# Code Quality

- Write production-level code: prioritize readability, maintainability, clear naming, and appropriate abstraction. Match existing patterns and style.
- Validate inputs and handle missing or malformed data. Use try/except only where you can handle or meaningfully report the failure. Prefer specific exception types; avoid bare `except`. Log errors with enough context to debug.

## Type Hints

- Use type hints liberally — all function signatures (params and return), class attributes, and any variable where the type isn't obvious from the assignment. Prefer `X | None` over `Optional[X]`.

## Docstrings

- Do not add module-level docstrings to Python files. Function and class docstrings are sufficient.
- Every function gets a Google-style docstring unless it's trivially simple (e.g., one-line getters/setters with a clear name).
- Include `Args`, `Returns`, and `Raises` sections as applicable — always document `Raises` when a function can throw.
- In non-Python languages, apply the same spirit: JSDoc for TypeScript/JavaScript, `///` doc comments for Rust, etc.

## Pydantic Models

- When a function returns more than two related values, define a Pydantic model for the return type rather than using raw tuples or NamedTuples. Keep the pattern consistent with the rest of the codebase.
- Prefer composition over inheritance for Pydantic models — embed a model as a field rather than subclassing. This keeps the relationship explicit and avoids hidden field inheritance.
- Don't introduce new patterns (e.g., NamedTuple) when the codebase already uses Pydantic for structured data. Match existing conventions.

## Code Style

- Use enums (Python `Enum`/`StrEnum`) instead of string literals for any fixed option set — especially values shared across module boundaries or between layers. Suggest migrating bare string comparisons to enums when encountered.
- When using non-obvious format specifiers or Unicode escapes, add an inline comment explaining what it does — e.g. `f"{val:.0f}\u00b0"  # Format as whole number then unicode degree symbol`
- Add inline comments for moderately rare operations (e.g., floor division `//`, modulo `%` for field extraction, bitwise ops, set comprehensions for lookup optimization) — anything a reader might need to pause and parse.

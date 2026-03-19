# Overlay: api

Purpose:
- Keep API contracts explicit, stable, and easy for clients to consume.
- Reduce ambiguity in validation, payload shape, and compatibility expectations.

When to apply:
- Endpoint design, serializers, request validation, and response-shape changes.
- Public, internal, or service-to-service API work.

Output focus:
- Clear contract boundaries and compatibility expectations.
- Explicit validation and error behavior.
- Predictable payload design for producers and consumers.

Decision prompts:
- What contract are clients depending on today?
- How are inputs validated and failures represented?
- Will this change break existing consumers or assumptions?

Quality checks:
- Contract changes are explicit and justified.
- Validation and error semantics are easy to understand.
- Compatibility concerns are addressed before implementation.

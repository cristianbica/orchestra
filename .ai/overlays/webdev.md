# Overlay: webdev

Purpose:
- Keep server-rendered and MVC-style web app work aligned with the request lifecycle.
- Reduce drift across routes, controllers, forms, sessions, and jobs.

When to apply:
- Controller, route, form, and session-driven web application changes.
- Server-rendered feature work in frameworks such as Rails- or Symfony-style apps.

Output focus:
- Clear request/response flow and responsibility boundaries.
- Predictable form handling, validation, and user flow behavior.
- Reuse of established web-app patterns before adding new abstractions.

Decision prompts:
- Which part of the request lifecycle owns this behavior?
- Does this belong in routing, controller logic, form handling, or background work?
- Is the flow still predictable for a server-rendered application?

Quality checks:
- Request flow is easy to trace end to end.
- Validation and session impacts are explicit.
- Background work is separated cleanly from request handling.

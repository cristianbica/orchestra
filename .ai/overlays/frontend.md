# Overlay: frontend

Purpose:
- Keep the web app view layer clear, predictable, and maintainable.
- Reduce friction in templates, styling, rendering, and browser-side interaction code.

When to apply:
- HTML/template, CSS, browser-side JavaScript, and interaction-layer changes.
- UI behavior work inside server-rendered or hybrid web applications.

Output focus:
- Clear rendering structure and interaction behavior.
- Consistent separation between presentation and non-view concerns.
- Maintainable browser-side logic with minimal UI complexity.

Decision prompts:
- Is this concern truly part of the view layer?
- Does the rendering structure stay easy to understand?
- Is browser-side behavior doing only what the UI needs?

Quality checks:
- Templates and browser-side code stay readable.
- Styling and interaction logic do not obscure intent.
- View-layer changes do not quietly pull in unrelated business logic.

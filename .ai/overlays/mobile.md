# Overlay: mobile

Purpose:
- Keep native and mobile-shell work aligned with platform behavior and device constraints.
- Reduce friction at the boundary between app lifecycle, navigation, device capabilities, and embedded web content.

When to apply:
- Native mobile features, shell-wrapper apps, and web-to-native mobile flows.
- Changes that depend on app lifecycle, navigation, device behavior, or platform conventions.

Output focus:
- Clear mobile-specific lifecycle and navigation behavior.
- Explicit handling of device and platform constraints.
- Stable boundaries between native and web layers where both are involved.

Decision prompts:
- What mobile lifecycle or navigation behavior matters here?
- Does this rely on device or platform-specific constraints?
- Where does responsibility sit between native and embedded web behavior?

Quality checks:
- Platform-specific assumptions are explicit.
- Mobile navigation and lifecycle behavior are coherent.
- Native/web boundary behavior is predictable and maintainable.

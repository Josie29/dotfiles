# Frontend

- Use `rem` for font sizes, spacing, padding, and margins — not `px`. Reserve `px` for borders, shadows, and sub-4px details. Use `em` for component-relative sizing.
- Use a consistent spacing scale (multiples of 0.25rem / 4px). Avoid arbitrary magic numbers.
- Define colors, fonts, and breakpoints as CSS custom properties or design tokens — no hardcoded values scattered in components.
- Write mobile-first CSS: base styles for small screens, `min-width` breakpoints to scale up.
- Prefer semantic HTML (`<button>`, `<nav>`, `<section>`) over ARIA roles on generic elements.
- Prefer flexbox/grid over `position: absolute/fixed` for layout. Use positioning only to break out of document flow intentionally.
- For mobile web, prefer `dvh` over `vh` to account for dynamic browser chrome.
- These conventions apply to web. React Native / Flutter use density-independent units natively — px-equivalent values are standard there.
- Prefer TypeScript over JavaScript for any new file. Use `.tsx` for React components and `.ts` for everything else. In existing JS-only codebases, write new files as TS rather than triggering a full migration — Next.js and Vite both support mixing `.jsx`/`.tsx` in the same project.

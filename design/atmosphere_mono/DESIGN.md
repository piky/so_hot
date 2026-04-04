# Design System Document: The Atmospheric Canvas

## 1. Overview & Creative North Star
**Creative North Star: "The Ethereal Observer"**

This design system rejects the cluttered, widget-heavy aesthetic of traditional weather apps in favor of an editorial, calm, and data-focused experience. We treat weather not as a set of disconnected numbers, but as an environmental mood. 

To move beyond the "template" look, the system relies on **intentional asymmetry**—placing large-scale typographic elements (like current temperature) off-center to create a sense of movement—and **tonal depth**. We break the rigid grid by allowing glassmorphic cards to overlap and "float" over soft, generative gradients that shift based on the time of day and meteorological conditions. The result is a UI that feels less like software and more like a high-end digital broadsheet.

---

## 2. Colors
Our palette is rooted in Material Design logic but applied with a high-end, editorial lens. The colors are designed to be "adaptive," where the `primary` and `secondary` tokens should be swapped dynamically to reflect the local sky (e.g., Cool Blues for rain, Muted Ambers for golden hour).

### The "No-Line" Rule
**Explicit Instruction:** 1px solid borders are strictly prohibited for sectioning. Structural boundaries must be defined solely through background color shifts or tonal transitions. Use `surface_container_low` against `surface` to create a boundary without a hard line.

### Surface Hierarchy & Nesting
Instead of a flat grid, treat the UI as stacked sheets of frosted glass.
- **Level 0 (Base):** `surface` (#f7f9fc)
- **Level 1 (Sub-sections):** `surface_container_low` (#f0f4f8)
- **Level 2 (Active Cards):** `surface_container_lowest` (#ffffff) for maximum "pop" against the background.

### The "Glass & Gradient" Rule
To achieve "The Ethereal Observer" look, main weather cards must use Glassmorphism.
- **Recipe:** Fill with `primary_fixed` at 15% opacity + `backdrop-blur` of 20px. 
- **Signature Textures:** Use a linear gradient transition from `primary` to `primary_container` (at 45 degrees) for hero weather backgrounds to provide a professional, deep polish.

---

## 3. Typography
We utilize a dual-typeface system to balance editorial elegance with functional data density.

*   **Manrope (The Voice):** Used for Display, Headlines, and Titles. Its geometric but warm curves feel modern and inviting.
*   **Inter (The Precision):** Used for Labels and technical data. Its high x-height ensures legibility at small scales (e.g., wind speed, humidity).

### Scale Highlights
- **Display LG (Manrope / 3.5rem):** Reserved for the current temperature. Use -0.04em letter spacing to create a high-fashion, "tight" look.
- **Headline SM (Manrope / 1.5rem):** For city names and daily summaries.
- **Label MD (Inter / 0.75rem):** For all technical metadata. These should always be in `on_surface_variant` or `secondary` to maintain a calm hierarchy.

---

## 4. Elevation & Depth
Depth is achieved through **Tonal Layering** rather than drop shadows.

### The Layering Principle
- Place a `surface_container_lowest` card on a `surface_container_low` section. This creates a soft, natural lift that feels sophisticated and light.

### Ambient Shadows
Shadows are a last resort. If a floating element (like a FAB or modal) requires a shadow, it must be:
- **Blur:** 40px - 60px
- **Opacity:** 4%-6%
- **Color:** Use a tinted version of `on_surface` (e.g., a deep navy tint) rather than a neutral grey to maintain the "atmospheric" feel.

### The "Ghost Border" Fallback
If accessibility requires a container edge, use a **Ghost Border**: 1px width, `outline_variant` token, at **15% opacity**. Never use 100% opaque lines.

---

## 5. Components

### Cards (The Core)
*   **Rule:** Forbid the use of divider lines within cards.
*   **Separation:** Use `spacing scale 4` (1.4rem) to separate data points. 
*   **Style:** `surface_container_lowest` with a `lg` (1rem) corner radius. Use glassmorphism for cards sitting directly over weather animations.

### Buttons
*   **Primary:** Fill with `primary` (#0060ad), text in `on_primary`. Shape: `full` (pill-shaped).
*   **Tertiary:** Transparent background, `primary` text. Use for less critical actions like "More Details."

### Chips (Conditions & Filters)
*   Used for "Rain Expected" or "High UV" alerts.
*   **Style:** `secondary_container` background with `on_secondary_container` text. `sm` (0.25rem) corner radius for a more technical, "tag" appearance.

### Input Fields (Location Search)
*   **Style:** Minimalist. No bottom line or box. Use `surface_container_high` as a subtle pill shape.
*   **Typography:** `body-md` in `on_surface`.

### Weather Timeline (Custom Component)
*   A horizontal scrolling list.
*   **Interaction:** The "Current Hour" should be highlighted using `primary_fixed` and a slight scale increase (1.1x), rather than a thick border.

---

## 6. Do's and Don'ts

### Do:
- **Do** use whitespace as a structural element. If in doubt, increase spacing by one step on the scale.
- **Do** use the `primary_dim` and `secondary_dim` tokens for active states to create a "pressed" look without changing the hue.
- **Do** overlap elements. Let a weather icon peek out of the top-right corner of a card to break the "boxed-in" feel.

### Don't:
- **Don't** use pure black (#000000) for text. Always use `on_surface` (#2c3338) to keep the contrast "calm."
- **Don't** use standard 1px dividers. They create "visual noise" that contradicts the minimal North Star.
- **Don't** use high-saturation shadows. They make the UI look like a 2014-era app rather than a premium modern experience.
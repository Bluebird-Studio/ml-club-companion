# Design system — editorial learning, tactile experimentation

## Creative direction

**Reference:** modern science museum meets carefully typeset educational textbook. Crisp, light, calm, with satisfying live graphs. Student-friendly without cartoonish decoration. Visually aligned with the restrained style of the Machine Learning Club website.

## Design tokens (provisional)

| Token | Light | Dark |
|---|---|---|
| Canvas | `#F7F8FC` | `#101827` |
| Primary ink | `#14213D` | `#F3F6FD` |
| Secondary ink | `#58677E` | `#AFBED2` |
| Primary accent | `#2856D9` | `#88A8FF` |
| Success | `#087B65` | `#71D8B7` |
| Caution | `#A65A13` | `#FFC57B` |
| Surface | `#FFFFFF` | `#1C283B` |
| Outline | `#DFE5EF` | `#33445C` |

Use semantic tokens from Flutter `ColorScheme` and verify contrast in implementation; hex values are design targets, not a claim of contrast certification.

## Typography / layout

- System sans (first pass) with clearly distinct display / title / body / caption roles, tabular figures for numeric values.
- Spacing on a 4dp grid: 8, 12, 16, 24, 32; 16dp mobile margins, 24–32dp tablet.
- Rounded cards around 16–20dp; restrained shadows, visible outlines, generous whitespace.
- NavigationBar on phone, NavigationRail on tablets/wide layouts; no horizontal overflow at 320–360dp widths.
- Visuals take priority: charts are large, legible, with axes, labels and context; not merely decorative illustrations.

## Signature screens

1. **Home:** week indicator and learning goal; "Continue Week N" hero; compact two-column actions (Explore / Practice), recent activity.
2. **Learning path:** readable list of 15 weeks; topic, date, progress and effort; clear current/locked/unavailable states without falsely implying content exists.
3. **Lesson:** objective, concise stepwise explanation, one visual example, a *Try it* action, references and four web resource links.
4. **Playground:** chart/diagram above controls on phone, side-by-side on wide screens. Sliders + displayed values; accessible stepper or text alternatives; reset; "What changed?" explanation.
5. **Quiz:** question, progress, full-width options with unambiguous selection, submit state, then explanation. Gentle and specific feedback, not random celebration.
6. **Progress:** goals completed, recent practice and best attempts with no public comparison.

## Interaction and motion

- Subtle 140–240ms transitions for selections and card state; respect OS reduced-motion setting.
- Parameters update live; chart labels must not jump around and must remain readable under large fonts.
- Loading/empty/offline/error success states are designed screens, not raw error strings.
- Accessibility: semantic labels on sliders and plot summaries, screen-reader reading order, keyboard focus, not color alone for correct/incorrect, text scaling, 48dp touch targets.

## App icon / Play listing

Clean abstract ML visual (small network nodes / a graph or simple line-and-point mark) related to the club's identity. Export adaptive foreground and monochrome icons, high-resolution 512px listing icon, feature graphic and accurate phone/tablet screenshots. Do not create fake screenshots or show features that are not built.

## Design review gate

Capture screenshots of the four primary tabs on a compact Android phone and a tablet, check dark/light, large text, and landscape. Obtain a teacher usability pass with a 90-second first-time-use task.

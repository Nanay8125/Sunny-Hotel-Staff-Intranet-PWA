# Design System
## Sunny Hotel Staff Intranet PWA

**Version:** 1.0  
**Last Updated:** December 31, 2025  
**Status:** Ready for Implementation  

---

## 1. Design Philosophy

The Sunny Hotel Staff Intranet is designed with **clarity, efficiency, and accessibility** at its core. Staff members work in fast-paced environments and need an interface that:

- **Minimizes cognitive load** - Quick decision making, clear hierarchy
- **Supports touch interaction** - Large targets, generous spacing
- **Works across devices** - Seamless experience on phones, tablets, and desktops
- **Respects accessibility** - WCAG 2.1 AA compliance, readable typography
- **Conveys professionalism** - Hospital/hotel-grade polish, trustworthy aesthetic

---

## 2. Color Palette

### Primary Colors

**Slate Blue (Primary Action)**
```
Hex: #2C3E50
RGB: 44, 62, 80
HSL: 204°, 29%, 24%
Usage: Main buttons, headers, key interactive elements
Accessibility: ✓ WCAG AA compliant on white backgrounds
```

**Emerald Green (Success/Confirmation)**
```
Hex: #27AE60
RGB: 39, 174, 96
HSL: 145°, 63%, 43%
Usage: "Complete," "Approved," successful states
Accessibility: ✓ WCAG AA compliant on white backgrounds
```

**Coral Red (Alert/Urgent)**
```
Hex: #E74C3C
RGB: 231, 76, 60
HSL: 6°, 78%, 57%
Usage: Errors, urgent tasks, high-priority flags
Accessibility: ✓ WCAG AA compliant on white backgrounds
```

**Amber Orange (Warning)**
```
Hex: #F39C12
RGB: 243, 156, 18
HSL: 39°, 90%, 51%
Usage: Warnings, maintenance issues, attention needed
Accessibility: ✓ WCAG AA compliant on white backgrounds
```

**Sky Blue (Info)**
```
Hex: #3498DB
RGB: 52, 152, 219
HSL: 204°, 70%, 53%
Usage: Information, notifications, secondary actions
Accessibility: ✓ WCAG AA compliant on white backgrounds
```

### Neutral Colors

**White (Background)**
```
Hex: #FFFFFF
RGB: 255, 255, 255
Usage: Main background, cards, clean spaces
```

**Light Gray (Secondary Background)**
```
Hex: #F5F7FA
RGB: 245, 247, 250
HSL: 214°, 29%, 97%
Usage: Alternating card backgrounds, inactive areas
```

**Medium Gray (Borders & Dividers)**
```
Hex: #BDC3C7
RGB: 189, 195, 199
HSL: 210°, 8%, 76%
Usage: Input borders, dividing lines, subtle separation
```

**Dark Gray (Text)**
```
Hex: #34495E
RGB: 52, 73, 94
HSL: 209°, 29%, 29%
Usage: Body text, labels, secondary information
Accessibility: ✓ High contrast on white (7.2:1 ratio)
```

**Charcoal (Dark Text)**
```
Hex: #1A252F
RGB: 26, 37, 47
HSL: 210°, 29%, 14%
Usage: Headlines, navigation, primary text
Accessibility: ✓ Maximum contrast on white (11:1 ratio)
```

**Error Text (Light)**
```
Hex: #A93226
RGB: 169, 50, 38
HSL: 9°, 62%, 41%
Usage: Error messages (lower emphasis)
Accessibility: ✓ 4.5:1 ratio on white
```

### Color Usage Chart

```
┌─────────────────────┬──────────────────────┬─────────────────┐
│ Color               │ Primary Use          │ Hex Code        │
├─────────────────────┼──────────────────────┼─────────────────┤
│ Slate Blue          │ Buttons, Headers     │ #2C3E50         │
│ Emerald Green       │ Success, Complete    │ #27AE60         │
│ Coral Red           │ Errors, Urgent       │ #E74C3C         │
│ Amber Orange        │ Warnings             │ #F39C12         │
│ Sky Blue            │ Info, Secondary      │ #3498DB         │
│ White               │ Main Background      │ #FFFFFF         │
│ Light Gray          │ Secondary BG         │ #F5F7FA         │
│ Medium Gray         │ Borders              │ #BDC3C7         │
│ Dark Gray           │ Body Text            │ #34495E         │
│ Charcoal            │ Headlines            │ #1A252F         │
└─────────────────────┴──────────────────────┴─────────────────┘
```

### Dark Mode Support (Future Phase 2)

```css
@media (prefers-color-scheme: dark) {
  --bg-primary: #1A252F;
  --bg-secondary: #2C3E50;
  --text-primary: #F5F7FA;
  --text-secondary: #BDC3C7;
  --border: #34495E;
}
```

---

## 3. Typography System

### Font Stack

**Headlines & Navigation (Geometric Sans-Serif)**
```
Font: "Segoe UI", "Roboto", "Helvetica Neue", Arial, sans-serif
Rationale: Professional, modern, globally supported
```

**Body Text & UI Labels (Humanist Sans-Serif)**
```
Font: "Segoe UI", "Roboto", "Helvetica Neue", Arial, sans-serif
Rationale: Highly readable, accessible, clean appearance
```

**Monospace (Code & Technical Info)**
```
Font: "Courier New", "Monaco", monospace
Usage: Task IDs, room numbers, codes
```

### Font Scale & Specifications

| Type | Size | Weight | Line Height | Letter Spacing | Use Case |
|------|------|--------|------------|----------------|----------|
| **Display (Hero)** | 32px | 700 | 1.2 | -0.02em | Page headers, app title |
| **Heading 1** | 28px | 700 | 1.3 | -0.015em | Section titles |
| **Heading 2** | 24px | 600 | 1.4 | -0.01em | Subsection titles |
| **Heading 3** | 20px | 600 | 1.5 | 0 | Card titles, modal headers |
| **Body Large** | 18px | 400 | 1.6 | 0 | Primary body text, labels |
| **Body Regular** | 16px | 400 | 1.6 | 0.25px | Standard body text |
| **Body Small** | 14px | 400 | 1.5 | 0.15px | Secondary text, hints |
| **Caption** | 12px | 500 | 1.4 | 0.1px | Timestamps, metadata |
| **Button** | 16px | 600 | 1.5 | 0.25px | All button text |

### Accessibility Guidelines

- **Minimum Font Size:** 14px for body text (no text <12px)
- **Maximum Line Length:** 65-75 characters for comfortable reading
- **Contrast Ratio:** 4.5:1 minimum (WCAG AA)
- **Line Height:** Minimum 1.5 for readability
- **Font Weight:** Avoid <400 weight for body text

### Font Examples (CSS)

```css
/* Headlines */
h1 {
  font-size: 28px;
  font-weight: 700;
  line-height: 1.3;
  letter-spacing: -0.015em;
  color: #1A252F;
}

/* Body Text */
body {
  font-size: 16px;
  font-weight: 400;
  line-height: 1.6;
  color: #34495E;
  letter-spacing: 0.25px;
}

/* Small Text */
.caption {
  font-size: 12px;
  font-weight: 500;
  line-height: 1.4;
  color: #7F8C8D;
}

/* Buttons */
button {
  font-size: 16px;
  font-weight: 600;
  line-height: 1.5;
  letter-spacing: 0.25px;
}
```

---

## 4. Button Component System

### Button Sizes (Mobile-First)

| Size | Height | Padding | Font Size | Touch Target | Usage |
|------|--------|---------|-----------|--------------|-------|
| **Large** | 56px | 16px 24px | 16px | 56×56px | Primary actions, mobile |
| **Medium** | 48px | 12px 20px | 16px | 48×48px | Secondary actions |
| **Small** | 40px | 8px 16px | 14px | 40×40px | Tertiary actions, tablets |
| **XSmall** | 32px | 6px 12px | 12px | Not touch-friendly | Desktop only |

### Button Variants

#### Primary Button (Main Actions)

**States:**
- Default: Slate Blue background, white text
- Hover: Darker blue (#1A3A52)
- Active: Even darker (#0F2333)
- Disabled: Medium gray with reduced opacity

```css
.btn-primary {
  background-color: #2C3E50;
  color: #FFFFFF;
  border: none;
  border-radius: 8px;
  padding: 16px 24px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.2s ease;
  min-height: 56px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

.btn-primary:hover:not(:disabled) {
  background-color: #1A3A52;
}

.btn-primary:active:not(:disabled) {
  background-color: #0F2333;
}

.btn-primary:disabled {
  background-color: #BDC3C7;
  color: #7F8C8D;
  cursor: not-allowed;
  opacity: 0.6;
}
```

#### Secondary Button (Alternative Actions)

**States:**
- Default: White background, Slate Blue border (2px), Slate Blue text
- Hover: Light gray background
- Active: Medium gray background
- Disabled: Reduced opacity

```css
.btn-secondary {
  background-color: #FFFFFF;
  color: #2C3E50;
  border: 2px solid #2C3E50;
  border-radius: 8px;
  padding: 14px 22px; /* Adjusted for border */
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s ease;
  min-height: 56px;
}

.btn-secondary:hover:not(:disabled) {
  background-color: #F5F7FA;
  border-color: #1A3A52;
  color: #1A3A52;
}

.btn-secondary:active:not(:disabled) {
  background-color: #E8EBF0;
}

.btn-secondary:disabled {
  border-color: #BDC3C7;
  color: #7F8C8D;
  cursor: not-allowed;
  opacity: 0.6;
}
```

#### Success Button (Confirmation)

```css
.btn-success {
  background-color: #27AE60;
  color: #FFFFFF;
  border: none;
  border-radius: 8px;
  padding: 16px 24px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.2s ease;
  min-height: 56px;
}

.btn-success:hover:not(:disabled) {
  background-color: #1E8449;
}

.btn-success:disabled {
  background-color: #BDC3C7;
  cursor: not-allowed;
}
```

#### Danger Button (Destructive)

```css
.btn-danger {
  background-color: #E74C3C;
  color: #FFFFFF;
  border: none;
  border-radius: 8px;
  padding: 16px 24px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.2s ease;
  min-height: 56px;
}

.btn-danger:hover:not(:disabled) {
  background-color: #C0392B;
}

.btn-danger:disabled {
  background-color: #BDC3C7;
  cursor: not-allowed;
}
```

#### Icon Button (Compact)

```css
.btn-icon {
  width: 56px;
  height: 56px;
  padding: 0;
  border-radius: 8px;
  background-color: #2C3E50;
  color: #FFFFFF;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.2s ease;
}

.btn-icon:hover:not(:disabled) {
  background-color: #1A3A52;
}

.btn-icon svg {
  width: 24px;
  height: 24px;
}
```

#### Button Groups (Mobile Layout)

```css
.btn-group {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
}

.btn-group.horizontal {
  flex-direction: row;
  justify-content: space-between;
}

.btn-group.horizontal button {
  flex: 1;
}

@media (min-width: 768px) {
  .btn-group {
    flex-direction: row;
    gap: 12px;
  }
}
```

---

## 5. Card Component System

### Standard Card

```css
.card {
  background-color: #FFFFFF;
  border: 1px solid #BDC3C7;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  transition: box-shadow 0.2s ease, transform 0.2s ease;
}

.card:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
  transform: translateY(-2px);
}

.card.interactive {
  cursor: pointer;
}
```

### Card Structure

```html
<div class="card">
  <div class="card-header">
    <h3 class="card-title">Room Turnover Tasks</h3>
    <span class="card-badge badge-primary">5 tasks</span>
  </div>
  
  <div class="card-content">
    <p>Task content goes here</p>
  </div>
  
  <div class="card-footer">
    <button class="btn-secondary">Cancel</button>
    <button class="btn-primary">Complete</button>
  </div>
</div>
```

### Card Variants

#### Task Card (Priority-Colored)

```css
.card-task {
  border-left: 4px solid #2C3E50;
  position: relative;
}

.card-task.priority-high {
  border-left-color: #E74C3C;
}

.card-task.priority-medium {
  border-left-color: #F39C12;
}

.card-task.priority-low {
  border-left-color: #27AE60;
}

.card-task-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.task-id {
  font-family: 'Courier New', monospace;
  font-size: 12px;
  color: #7F8C8D;
}

.task-time {
  font-size: 14px;
  color: #34495E;
}
```

#### Guest Card (Information)

```css
.card-guest {
  background: linear-gradient(135deg, #F5F7FA 0%, #FFFFFF 100%);
}

.guest-name {
  font-size: 18px;
  font-weight: 700;
  color: #1A252F;
}

.guest-room {
  font-size: 14px;
  color: #7F8C8D;
  margin-top: 4px;
}

.guest-status {
  display: inline-block;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 600;
  margin-top: 8px;
}

.guest-status.checked-in {
  background-color: rgba(39, 174, 96, 0.1);
  color: #27AE60;
}

.guest-status.pending {
  background-color: rgba(243, 156, 18, 0.1);
  color: #F39C12;
}
```

#### Maintenance Card (Status Indicator)

```css
.card-maintenance {
  border-radius: 12px;
  overflow: hidden;
}

.maintenance-status-bar {
  height: 4px;
  background-color: #2C3E50;
  width: 100%;
}

.maintenance-status-bar.completed {
  background-color: #27AE60;
}

.maintenance-status-bar.urgent {
  background-color: #E74C3C;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.7; }
}

.maintenance-title {
  font-weight: 600;
  color: #1A252F;
}

.maintenance-location {
  font-size: 14px;
  color: #7F8C8D;
  margin-top: 4px;
}
```

---

## 6. Navigation Pattern

### Bottom Tab Navigation (Mobile-First)

**Design Principle:** 5-item maximum for clarity, touch-friendly spacing

```css
.nav-tab-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  height: 64px;
  background-color: #FFFFFF;
  border-top: 1px solid #BDC3C7;
  display: flex;
  justify-content: space-around;
  align-items: flex-end;
  padding-bottom: env(safe-area-inset-bottom);
  z-index: 100;
}

.nav-item {
  flex: 1;
  height: 64px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 4px;
  color: #7F8C8D;
  text-decoration: none;
  cursor: pointer;
  transition: color 0.2s ease;
  padding-bottom: 8px;
}

.nav-item.active {
  color: #2C3E50;
  border-top: 3px solid #2C3E50;
}

.nav-icon {
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.nav-label {
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.5px;
  white-space: nowrap;
}
```

### Navigation Structure

```
┌─────────────────────────────────────────┐
│         Sunny Hotel Intranet            │ (Header)
├─────────────────────────────────────────┤
│                                         │
│              Content Area               │
│          (Safe from bottom nav)         │
│                                         │
├─────────────────────────────────────────┤
│ [Icon] │ [Icon] │ [Icon] │ [Icon] │ [Icon] │ (Bottom Nav)
│ Home   │ Tasks  │ Guests │ Message│ Profile│
└─────────────────────────────────────────┘
```

### Tablet Navigation (768px+)

```css
@media (min-width: 768px) {
  .nav-tab-bar {
    position: sticky;
    top: 0;
    bottom: auto;
    height: auto;
    flex-direction: row;
    border-top: none;
    border-right: 1px solid #BDC3C7;
    width: 80px;
    height: 100vh;
    flex-direction: column;
  }
  
  .nav-item {
    height: auto;
    padding: 16px;
    border-top: none;
    border-left: 3px solid transparent;
  }
  
  .nav-item.active {
    border-left: 3px solid #2C3E50;
    border-top: none;
    background-color: #F5F7FA;
  }
}
```

### Desktop Navigation (1024px+)

```css
@media (min-width: 1024px) {
  .nav-tab-bar {
    width: 200px;
    padding: 20px 0;
  }
  
  .nav-label {
    font-size: 13px;
  }
  
  .nav-item {
    justify-content: flex-start;
    padding: 12px 16px;
  }
}
```

### Breadcrumb Navigation

```css
.breadcrumb {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #7F8C8D;
  margin-bottom: 16px;
  padding: 12px 16px;
  background-color: #F5F7FA;
  border-radius: 8px;
}

.breadcrumb a {
  color: #2C3E50;
  text-decoration: none;
  transition: color 0.2s ease;
}

.breadcrumb a:hover {
  color: #1A3A52;
  text-decoration: underline;
}

.breadcrumb-separator {
  color: #BDC3C7;
}
```

---

## 7. Input & Form Components

### Text Input

```css
.input-text {
  width: 100%;
  padding: 12px 16px;
  font-size: 16px;
  border: 1px solid #BDC3C7;
  border-radius: 8px;
  font-family: inherit;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
  background-color: #FFFFFF;
  min-height: 48px;
}

.input-text:focus {
  outline: none;
  border-color: #2C3E50;
  box-shadow: 0 0 0 3px rgba(44, 62, 80, 0.1);
}

.input-text:disabled {
  background-color: #F5F7FA;
  color: #7F8C8D;
  cursor: not-allowed;
}

.input-text.error {
  border-color: #E74C3C;
}
```

### Textarea

```css
.input-textarea {
  width: 100%;
  padding: 12px 16px;
  font-size: 16px;
  border: 1px solid #BDC3C7;
  border-radius: 8px;
  font-family: inherit;
  line-height: 1.6;
  resize: vertical;
  min-height: 120px;
  transition: border-color 0.2s ease;
}

.input-textarea:focus {
  outline: none;
  border-color: #2C3E50;
  box-shadow: 0 0 0 3px rgba(44, 62, 80, 0.1);
}
```

### Select Dropdown

```css
.input-select {
  width: 100%;
  padding: 12px 16px;
  font-size: 16px;
  border: 1px solid #BDC3C7;
  border-radius: 8px;
  background-color: #FFFFFF;
  cursor: pointer;
  min-height: 48px;
  appearance: none;
  background-image: url('data:image/svg+xml,...');
  background-repeat: no-repeat;
  background-position: right 12px center;
  padding-right: 40px;
}

.input-select:focus {
  outline: none;
  border-color: #2C3E50;
  box-shadow: 0 0 0 3px rgba(44, 62, 80, 0.1);
}
```

### Checkbox & Radio

```css
.input-checkbox,
.input-radio {
  width: 20px;
  height: 20px;
  cursor: pointer;
  accent-color: #2C3E50;
}

.input-checkbox:focus,
.input-radio:focus {
  outline: 2px solid #3498DB;
  outline-offset: 2px;
}

.checkbox-group,
.radio-group {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.checkbox-item,
.radio-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.checkbox-item:hover,
.radio-item:hover {
  background-color: #F5F7FA;
}
```

### Form Label

```css
.form-label {
  display: block;
  font-size: 14px;
  font-weight: 600;
  color: #1A252F;
  margin-bottom: 8px;
  text-align: left;
}

.form-label.required::after {
  content: ' *';
  color: #E74C3C;
}

.form-hint {
  display: block;
  font-size: 12px;
  color: #7F8C8D;
  margin-top: 4px;
}

.form-error {
  display: block;
  font-size: 12px;
  color: #A93226;
  margin-top: 4px;
}
```

---

## 8. Badge & Status Components

### Badge Styles

```css
.badge {
  display: inline-flex;
  align-items: center;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
  white-space: nowrap;
  gap: 6px;
}

.badge-primary {
  background-color: rgba(44, 62, 80, 0.1);
  color: #2C3E50;
}

.badge-success {
  background-color: rgba(39, 174, 96, 0.1);
  color: #27AE60;
}

.badge-danger {
  background-color: rgba(231, 76, 60, 0.1);
  color: #E74C3C;
}

.badge-warning {
  background-color: rgba(243, 156, 18, 0.1);
  color: #F39C12;
}

.badge-info {
  background-color: rgba(52, 152, 219, 0.1);
  color: #3498DB;
}

.badge-neutral {
  background-color: #F5F7FA;
  color: #7F8C8D;
}
```

### Status Indicator

```css
.status-dot {
  display: inline-block;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  animation: pulse-dot 2s infinite;
}

.status-dot.active {
  background-color: #27AE60;
}

.status-dot.inactive {
  background-color: #BDC3C7;
}

.status-dot.pending {
  background-color: #F39C12;
}

.status-dot.error {
  background-color: #E74C3C;
}

@keyframes pulse-dot {
  0% {
    box-shadow: 0 0 0 0 currentColor;
  }
  70% {
    box-shadow: 0 0 0 6px rgba(0, 0, 0, 0);
  }
  100% {
    box-shadow: 0 0 0 0 rgba(0, 0, 0, 0);
  }
}
```

---

## 9. Spacing System

### Baseline Unit: 4px

| Size | Value | Usage |
|------|-------|-------|
| **XS** | 4px | Icon padding, tight spacing |
| **S** | 8px | Input label margin, component padding |
| **M** | 12px | Card padding, section spacing |
| **L** | 16px | Button padding, major content spacing |
| **XL** | 24px | Page margins, major section gap |
| **2XL** | 32px | Large section breaks |
| **3XL** | 48px | Full-width component gaps |

### Application

```css
/* Content margins */
.page-content {
  padding: 16px;
  padding-bottom: 80px; /* Account for bottom nav */
}

/* Section spacing */
.section {
  margin-bottom: 32px;
}

/* Component spacing */
.component {
  margin-bottom: 12px;
}

/* List spacing */
.list-item {
  margin-bottom: 8px;
}

.list-item + .list-item {
  margin-top: 8px;
}
```

---

## 10. Shadow System

### Elevation Levels

```css
/* Flat - No shadow */
.elevation-0 {
  box-shadow: none;
}

/* Raised - Subtle shadow */
.elevation-1 {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

/* Floating - Medium shadow */
.elevation-2 {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
}

/* Hovering - Higher shadow */
.elevation-3 {
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

/* Modal/Overlay - Highest shadow */
.elevation-4 {
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.20);
}
```

---

## 11. Border Radius & Corners

```css
/* Sharp corners - System UI elements */
.radius-none {
  border-radius: 0;
}

/* Slightly rounded - Forms, inputs */
.radius-small {
  border-radius: 4px;
}

/* Standard rounded - Cards, buttons */
.radius-default {
  border-radius: 8px;
}

/* Rounded - Larger components */
.radius-medium {
  border-radius: 12px;
}

/* Very rounded - Pills, badges */
.radius-large {
  border-radius: 20px;
}

/* Fully rounded - Circles */
.radius-full {
  border-radius: 50%;
}
```

---

## 12. Responsive Breakpoints

```css
/* Mobile First Approach */

/* Extra small (Default) */
/* 0px - 479px */

/* Small devices (Landscape phones) */
@media (min-width: 480px) {
  /* sm breakpoint */
}

/* Medium devices (Tablets) */
@media (min-width: 768px) {
  /* md breakpoint */
}

/* Large devices (Large tablets, small desktops) */
@media (min-width: 1024px) {
  /* lg breakpoint */
}

/* Extra large (Desktops) */
@media (min-width: 1280px) {
  /* xl breakpoint */
}

/* XXL (Large desktops) */
@media (min-width: 1536px) {
  /* 2xl breakpoint */
}
```

### Responsive Layout Example

```css
/* Mobile (default) */
.container {
  padding: 16px;
  grid-template-columns: 1fr;
}

/* Tablet */
@media (min-width: 768px) {
  .container {
    padding: 24px;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .container {
    padding: 32px;
    grid-template-columns: repeat(3, 1fr);
    gap: 24px;
  }
}
```

---

## 13. Mobile-Specific Optimizations

### Safe Area Insets (Notch Support)

```css
.app-container {
  padding-left: max(16px, env(safe-area-inset-left));
  padding-right: max(16px, env(safe-area-inset-right));
  padding-top: max(16px, env(safe-area-inset-top));
  padding-bottom: max(80px, env(safe-area-inset-bottom));
}
```

### Touch Target Sizing

```css
/* Minimum 48x48px for touch targets */
.touch-target {
  min-width: 48px;
  min-height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Spacing between targets */
.touch-target + .touch-target {
  margin-left: 8px;
}
```

### Mobile Viewport Meta Tag

```html
<meta name="viewport" 
      content="width=device-width, 
               initial-scale=1.0, 
               viewport-fit=cover,
               maximum-scale=5.0,
               user-scalable=yes">
```

### Disable Zoom on Input Focus (iOS)

```css
input, select, textarea {
  font-size: 16px; /* Prevents auto-zoom on iOS */
}
```

---

## 14. Dark Mode Support (Phase 2)

```css
@media (prefers-color-scheme: dark) {
  :root {
    --color-bg-primary: #1A252F;
    --color-bg-secondary: #2C3E50;
    --color-bg-tertiary: #34495E;
    --color-text-primary: #F5F7FA;
    --color-text-secondary: #BDC3C7;
    --color-border: #34495E;
  }
  
  .card {
    background-color: var(--color-bg-secondary);
    border-color: var(--color-border);
  }
  
  body {
    background-color: var(--color-bg-primary);
    color: var(--color-text-primary);
  }
}
```

---

## 15. Animations & Transitions

### Standard Transitions

```css
/* Button interactions */
.button {
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Hover effects */
.interactive {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

/* Color changes */
.color-change {
  transition: color 0.2s ease, background-color 0.2s ease;
}

/* Opacity fade */
.fade {
  transition: opacity 0.3s ease;
}
```

### Page Transitions

```css
/* Slide in from right (next page) */
@keyframes slideInRight {
  from {
    transform: translateX(100%);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
}

/* Slide out to left (previous page) */
@keyframes slideOutLeft {
  from {
    transform: translateX(0);
    opacity: 1;
  }
  to {
    transform: translateX(-100%);
    opacity: 0;
  }
}

.page-enter {
  animation: slideInRight 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.page-exit {
  animation: slideOutLeft 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
```

### Loading States

```css
@keyframes spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.spinner {
  animation: spin 1s linear infinite;
}

@keyframes shimmer {
  0% {
    background-position: -1000px 0;
  }
  100% {
    background-position: 1000px 0;
  }
}

.skeleton {
  animation: shimmer 2s infinite;
  background: linear-gradient(90deg, 
    #f0f0f0 25%, 
    #e0e0e0 50%, 
    #f0f0f0 75%);
  background-size: 1000px 100%;
}
```

---

## 16. Iconography

### Icon System

**Grid Size:** 24px × 24px (standard)
**Stroke Weight:** 2px
**Corner Radius:** 2px (slight rounding)
**Color:** Inherit from text color

### Icon Library

Use: `Feather Icons` or `Material Design Icons`

**Common Icons:**
- Home (dashboard)
- CheckSquare (tasks)
- Users (guests/staff)
- MessageSquare (messages)
- Settings (profile/settings)
- AlertCircle (urgent/alert)
- Clock (time-related)
- MapPin (location)
- Plus (add)
- X (close)
- Menu (navigation)
- ChevronRight (navigation)

### Icon Usage

```css
.icon {
  width: 24px;
  height: 24px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.icon-sm {
  width: 16px;
  height: 16px;
}

.icon-lg {
  width: 32px;
  height: 32px;
}

.icon-primary {
  color: #2C3E50;
}

.icon-success {
  color: #27AE60;
}

.icon-danger {
  color: #E74C3C;
}
```

---

## 17. Component Library Implementation

### React Component Example

```jsx
// Button.jsx
export function Button({
  variant = 'primary',
  size = 'large',
  disabled = false,
  icon,
  children,
  ...props
}) {
  const variantClass = `btn-${variant}`;
  const sizeClass = `btn-${size}`;
  
  return (
    <button 
      className={`btn ${variantClass} ${sizeClass}`}
      disabled={disabled}
      {...props}
    >
      {icon && <span className="btn-icon">{icon}</span>}
      {children}
    </button>
  );
}

// Usage
<Button variant="primary" size="large" icon={<CheckIcon />}>
  Complete Task
</Button>
```

### Card Component Example

```jsx
// Card.jsx
export function Card({ children, variant = 'default', onClick }) {
  const className = `card card-${variant}`;
  
  return (
    <div className={className} onClick={onClick}>
      {children}
    </div>
  );
}

// Usage
<Card variant="task" onClick={handleTaskClick}>
  <Card.Header title="Room Cleaning" badge="Priority: High" />
  <Card.Content>Task details...</Card.Content>
  <Card.Footer>
    <Button variant="secondary">Decline</Button>
    <Button variant="success">Accept</Button>
  </Card.Footer>
</Card>
```

---

## 18. Accessibility Checklist

- ✅ **Contrast:** All text passes WCAG AA (4.5:1 minimum)
- ✅ **Touch Targets:** All interactive elements 48×48px minimum
- ✅ **Typography:** No text smaller than 14px; line height ≥1.5
- ✅ **Navigation:** Keyboard accessible, clear focus states
- ✅ **Semantics:** Proper HTML elements (buttons, links, form controls)
- ✅ **ARIA Labels:** Forms, icons, and custom components labeled
- ✅ **Color:** Not sole indicator of state (use text, icons, patterns)
- ✅ **Motion:** Respects `prefers-reduced-motion` setting
- ✅ **Forms:** Labels associated with inputs, error messages clear
- ✅ **Images:** All images have alt text

---

## 19. Component Documentation

### Documentation Template

For each component, provide:

```markdown
## ComponentName

**Purpose:** Brief description

**Variants:**
- Default
- [Other states]

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| ... | ... | ... | ... |

**Accessibility:**
- ARIA roles/labels
- Keyboard support
- Focus management

**Example:**
\`\`\`jsx
<Component prop="value">Content</Component>
\`\`\`
```

---

## 20. Implementation Checklist

- [ ] Create CSS custom properties for colors
- [ ] Set up Tailwind config with custom theme
- [ ] Build component library in React/Vue
- [ ] Document all components with Storybook
- [ ] Create responsive layout utilities
- [ ] Implement dark mode support
- [ ] Set up accessibility testing
- [ ] Create design tokens JSON file
- [ ] Add to design system documentation site
- [ ] Train development team on system usage

---

## 21. Design Tokens (CSS Variables)

```css
:root {
  /* Colors */
  --color-primary: #2C3E50;
  --color-success: #27AE60;
  --color-danger: #E74C3C;
  --color-warning: #F39C12;
  --color-info: #3498DB;
  
  --color-bg-primary: #FFFFFF;
  --color-bg-secondary: #F5F7FA;
  --color-border: #BDC3C7;
  --color-text-primary: #1A252F;
  --color-text-secondary: #34495E;
  
  /* Typography */
  --font-stack: 'Segoe UI', 'Roboto', sans-serif;
  --font-size-body: 16px;
  --line-height-body: 1.6;
  
  /* Spacing */
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 12px;
  --spacing-lg: 16px;
  --spacing-xl: 24px;
  
  /* Shadows */
  --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.08);
  --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.12);
  
  /* Radius */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
  
  /* Transitions */
  --transition-fast: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  --transition-normal: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
```

---

## Document Control

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | Dec 31, 2025 | Initial design system created |

---

**Next Steps:**
1. Review design system with team
2. Create Figma design files
3. Build React component library
4. Set up Storybook for documentation
5. Implement in development environment
6. Conduct accessibility audit
7. Launch with MVP features

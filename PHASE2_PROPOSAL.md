# Phase 2 Proposal & Scaling Strategy: Sunny Hotel Intranet PWA

Following the successful implementation of the core PWA and Push Notifications, this document outlines the roadmap for scaling the system into a multi-property enterprise solution with advanced automation.

## 1. Enterprise Infrastructure: Multi-Hotel Support
To support growth from a single 25-room hotel to a hotel group, the data model and security layer must be multi-tenant.

### Architectural Changes:
*   **Tenant Partitioning**: Introduce a `hotels` table. Add `hotel_id` (UUID) to all core entities (`users`, `rooms`, `announcements`, `documents`).
*   **Global vs. Local Roles**:
    *   `super_admin`: Full access to all hotels.
    *   `hotel_manager`: Access restricted to their specific hotel.
*   **RLS Evolution**: Update all Supabase RLS policies to include `AND hotel_id = (SELECT hotel_id FROM users WHERE id = auth.uid())`.

## 2. Workforce Management: Attendance Tracking
A mobile-first attendance system leverages the PWA's accessibility to replace legacy clock-in hardware.

### Key Features:
*   **Geolocation Clock-In**: Use the browser Geolocation API to verify the staff member is physically at the hotel during clock-in.
*   **QR-Checkpoints**: Managers can place unique QR codes in departments. Staff scan a code to "log" their presence (e.g., verifying a security round or starting a shift).
*   **Shift Scheduling**: A visual calendar view for managers to assign shifts, with push notifications sent to staff 1 hour before their shift starts.

## 3. Operations Intelligence: Analytics Dashboard
Turn raw task data into actionable insights for management.

### Key Metrics:
*   **Housekeeping Efficiency**: Average time taken to clean different room types (`suite` vs. `standard`).
*   **Maintenance Health**: Mean time to resolution (MTTR) for urgent vs. low-priority repairs.
*   **Staff Engagement**: Tracking announcement "read rates" to ensure critical safety policies are being seen.
*   **Bottleneck Detection**: Visual heatmaps showing floors or departments with the highest volume of pending tasks.

## 4. Ecosystem Integration: PMS Sync
Integration with Property Management Systems (PMS) like Opera, Mews, or Cloudbeds removes manual room status updates.

### Integration Points:
*   **Auto-Dirty Trigger**: When the PMS registers a guest "Check-out," send a webhook to the Intranet to automatically set the room status to `dirty` and create a housekeeping task.
*   **Occupancy Sync**: Real-time room status (`occupied`, `reserved`) updates based on the current guest ledger.
*   **Guest Requests**: Pipe guest requests (e.g., "extra towels") directly into the staff's task queue as high-priority tasks.

## 5. Intelligent Automation: AI Features
Leverage AI to reduce the cognitive load on managers and improve staff productivity.

### Specific Applications:
*   **Smart Categorization**: maintenance requests filed by staff can be processed via an LLM to automatically assign a category (`plumbing`, `electrical`) and a priority level based on the description.
*   **Visual QC (Quality Control)**: Housekeeping staff take a photo of the finished room; AI analyzes it to ensure standard amenities (towels, toiletries) are present and the room looks "Clean."
*   **Predictive Maintenance**: Analyze historical data to predict when an AC unit or elevator is likely to fail, scheduling maintenance *before* a guest complains.
*   **Multilingual Support**: Real-time translation of announcements for a diverse workforce, ensuring all staff understand urgent alerts regardless of their primary language.

---

## Scaling Strategy & Technology Stack
*   **Frontend**: Migrate to **Next.js Parallel Routes** for complex dashboards.
*   **Database**: Utilize **Supabase Edge Functions** for background processing and AI integrations.
*   **Real-time**: Expand usage of **Supabase Realtime** for a "Live Operations" map showing staff locations and room statuses in real-time.
*   **Data Warehouse**: Export logs periodically to a tool like **BigQuery** for long-term historical trend analysis.

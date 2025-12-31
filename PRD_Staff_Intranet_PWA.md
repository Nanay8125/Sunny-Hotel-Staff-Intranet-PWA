# Product Requirements Document
## Sunny Hotel Staff Intranet PWA

**Document Version:** 1.0  
**Last Updated:** December 31, 2025  
**Status:** Ready for Development  

---

## 1. Executive Summary

The **Sunny Hotel Staff Intranet PWA** is a Progressive Web Application designed exclusively for internal staff operations across a 25-room hotel with 30 employees across four departments. This application centralizes critical operational information, task management, and team communication to improve efficiency, reduce response times, and enhance staff coordination.

**Target Users:** Front Desk (8), Housekeeping (10), Maintenance (6), Management (6)

---

## 2. Product Goals

### Primary Goals
1. **Operational Efficiency** - Reduce task turnaround time by 40% and minimize miscommunication
2. **Real-time Information Access** - Enable staff to access critical hotel/guest data instantaneously
3. **Asynchronous Communication** - Provide messaging system accessible offline for non-urgent updates
4. **Task Management** - Centralize task assignment, tracking, and completion workflows
5. **Accessibility** - Available on any device (mobile/tablet/desktop) without installation friction

### Secondary Goals
1. **Cost Reduction** - Replace multiple legacy systems with single unified platform
2. **Staff Satisfaction** - Streamline workflows and reduce administrative burden
3. **Compliance & Audit** - Maintain audit trails for sensitive operations
4. **Data Security** - Ensure guest data and operational information remain confidential

---

## 3. User Roles & Permissions Matrix

| Role | Count | Key Responsibilities | Access Level |
|------|-------|----------------------|---------------|
| **Front Desk Staff** | 8 | Check-ins/outs, guest communication, service requests | Standard |
| **Housekeeping Staff** | 10 | Room turnover, cleanliness reports, supply management | Standard |
| **Maintenance Staff** | 6 | Maintenance requests, repairs, equipment logs | Standard |
| **Department Managers** | 3 | Task assignment, staff performance, reporting | Elevated |
| **General Manager** | 1 | System admin, all features, financial data access | Admin |
| **Night Manager** | 2 | All Standard + on-call decision authority | Elevated |

### Permission Framework

```
PERMISSION LEVELS:
├── Admin (General Manager)
│   ├── All features
│   ├── User management
│   ├── System settings
│   ├── Financial reporting
│   └── Audit logs (full)
│
├── Elevated (Dept Managers + Night Manager)
│   ├── Task assignment
│   ├── Staff scheduling
│   ├── Department reporting
│   ├── Audit logs (department-filtered)
│   └── All Standard features
│
└── Standard (All Staff)
    ├── View assigned tasks
    ├── View team roster
    ├── Access guest info (limited)
    ├── Internal messaging
    ├── Submit maintenance requests
    └── View shift schedule
```

---

## 4. Core Features by Role

### 4.1 Front Desk Staff

#### Primary Features
- **Guest Dashboard**
  - Current guests (room, check-out time, special requests)
  - Search guest profiles (name, room number)
  - View room status (occupied, reserved, maintenance)
  - Log guest requests/messages

- **Task Management**
  - View assigned tasks (wake-up calls, late checkout approvals, amenity requests)
  - Mark tasks complete with timestamp
  - Escalate service requests to housekeeping/maintenance

- **Shift Information**
  - View current & upcoming shift details
  - Clock in/out functionality
  - Handover notes from previous shift

- **Messaging**
  - Send messages to other departments
  - Department broadcast announcements
  - Offline message queue (send when online)

### 4.2 Housekeeping Staff

#### Primary Features
- **Room Status Board**
  - Real-time room status (clean, dirty, occupied, maintenance)
  - Floor-by-floor overview
  - Filter by room type/status

- **Task Queue**
  - Assigned rooms for turnover (priority ordered)
  - Task details (room type, special requests, VIP status)
  - Mark complete with timestamp & notes
  - Issue reports (damage, missing items)

- **Supply Management**
  - Current inventory (linens, toiletries, cleaning supplies)
  - Request resupply for shortage
  - Stock level alerts

- **Maintenance Requests**
  - View maintenance issues in assigned rooms
  - Request urgent maintenance
  - Mark resolved collaboratively with maintenance

- **Team Collaboration**
  - Message other housekeeping staff
  - View team assignments
  - Share room status updates

### 4.3 Maintenance Staff

#### Primary Features
- **Work Orders**
  - View assigned maintenance requests
  - Filter by priority/location/status
  - Accept/reject/reassign tasks
  - Complete with photos & notes

- **Asset Management**
  - View equipment status & location
  - Log maintenance history
  - Schedule preventive maintenance
  - Track spare parts inventory

- **Room Coordination**
  - View room-by-room maintenance status
  - Coordinate with housekeeping on shared tasks
  - Log emergency calls

- **Service Requests**
  - Respond to urgent calls
  - Update requestor on progress
  - Close completed work with notes

### 4.4 Department Managers

#### All Standard Features PLUS:

- **Task Management Console**
  - Create & assign tasks to team members
  - View task completion status & timelines
  - Reassign/prioritize tasks
  - Performance analytics (tasks completed, avg time)

- **Staff Dashboard**
  - View team roster with contact info
  - Current shift assignments
  - Performance metrics (attendance, task completion)
  - Leave requests & approvals

- **Reporting**
  - Department-specific reports (tasks, efficiency, issues)
  - Guest complaint logs
  - Maintenance request trends
  - Export reports (PDF/CSV)

- **Notifications & Alerts**
  - Alert staff to urgent issues
  - Broadcast department announcements
  - Escalation workflows

### 4.5 Night Manager

#### All Standard Features PLUS:

- **Full Coverage Visibility**
  - All guest information
  - All open tasks across departments
  - Real-time alerts
  - Staff on-call status

- **Decision Authority**
  - Approve urgent guest requests
  - Authorize emergency maintenance
  - Approve overtime
  - Escalate critical issues to GM

- **Night Shift Specific**
  - Emergency contact list
  - Night audit checklist
  - Late arrival/departure management
  - Security incident logs

### 4.6 General Manager

#### All Features PLUS:

- **System Administration**
  - User account management
  - Role assignment & permissions
  - System configuration

- **Financial Dashboard**
  - Revenue reports
  - Labor cost analysis
  - Guest spend tracking
  - Operational expenses

- **Audit & Compliance**
  - Full audit logs
  - Data access history
  - System health monitoring
  - Backup status

- **Strategic Reports**
  - Occupancy trends
  - Staff performance analytics
  - Guest satisfaction metrics
  - Operational KPIs

---

## 5. User Journeys

### Journey 1: Morning Shift Check-in & Task Assignment
**Actors:** Front Desk Staff → Department Manager

1. **Staff Arrival**
   - Open PWA on mobile device (no download required)
   - Authenticate with PIN/employee ID
   - View shift summary: guests arriving today, tasks pending

2. **Shift Handover Review**
   - Read notes from night shift manager
   - Acknowledge critical messages
   - Check no. of occupied rooms & checkout times

3. **Manager Reviews Department Tasks**
   - Opens task dashboard
   - Assigns check-out assistance tasks
   - Assigns room keys preparation tasks
   - Estimates task priority based on checkout times

4. **Front Desk Staff Execute Tasks**
   - Receives real-time notification of assigned tasks
   - Views task details (room, guest name, special requests)
   - Completes tasks, marks as done
   - Provides notes if issues occur

**Success Metric:** Tasks created and assigned within 5 minutes of shift start

---

### Journey 2: Emergency Maintenance Request
**Actors:** Any Staff → Maintenance Staff → Maintenance Manager

1. **Request Initiation**
   - Any staff member encounters issue (room A/C broken)
   - Opens PWA, taps "Maintenance Request"
   - Selects room, describes issue, marks priority (urgent/normal)
   - Optionally attaches photo
   - Submits (works offline, queues if needed)

2. **Maintenance Notification**
   - Maintenance staff receive push notification
   - View new request with photos & description
   - Accept task, update status to "In Progress"
   - Navigate to room location

3. **Repair & Resolution**
   - Complete maintenance work
   - Add notes & timestamp
   - Optionally attach photo of completed work
   - Mark task as "Complete"

4. **Notification & Closure**
   - Requesting staff notified: "Maintenance complete in your room"
   - Requester can verify completion or request follow-up
   - Task closes after 2 hours if not disputed

**Success Metric:** Urgent request acknowledged within 2 minutes; completed within 30 minutes

---

### Journey 3: Room Turnover Workflow
**Actors:** Housekeeping Staff → Front Desk → Manager

1. **Task Reception**
   - Housekeeping staff sees room turnover task on dashboard
   - View room details: guest checkout time, room type, special notes (VIP, allergy info)
   - Navigate to room with task details displayed on mobile

2. **During Cleaning**
   - Mark room status "In Progress"
   - Photo checklist: verify all items clean/in place
   - Log any issues (damage, missing items)
   - Confirm completion once satisfied

3. **Housekeeping Manager Reviews**
   - Manager notified of new issues/damage
   - Can reassign room to higher-priority task queue
   - Track productivity: 4 rooms per hour average

4. **Front Desk Verification**
   - Receives notification when room cleaned
   - Updates room status to "Ready"
   - Informs guests when upgraded room is available

**Success Metric:** Room turnover completed in 35-45 min; 92% first-time pass rate (no re-cleans)

---

### Journey 4: Guest Service Request to Resolution
**Actors:** Guest → Front Desk → Any Department → Manager

1. **Request Logging**
   - Front Desk receives guest request (extra towels, reservation change, late checkout)
   - Logs request in system with guest room number
   - Assigns to appropriate department
   - Guest given timeframe estimate

2. **Department Task Assignment**
   - Department manager notified of new request
   - Assigns to available staff member
   - Staff receives task with guest room & details

3. **Task Completion**
   - Staff completes request, logs time
   - Optionally confirms completion with guest (phone/in-person)
   - Marks task complete

4. **Follow-up**
   - Front Desk notified automatically
   - Can reach back to guest: "Your request is complete"
   - Manager tracks: response time, completion time, guest satisfaction

**Success Metric:** Standard requests resolved <2 hours; urgencies <30 min

---

### Journey 5: End-of-Shift Reporting (Manager)
**Actors:** Department Manager → General Manager

1. **Shift Summary Compilation**
   - Manager views team's completed tasks
   - Reviews any incomplete/escalated items
   - Compiles incident log (complaints, issues, damages)

2. **Report Generation**
   - Generates shift report: tasks completed, time spent, incidents
   - Adds manager notes & recommendations
   - Submits for GM review

3. **GM Review & Archival**
   - GM receives notification of pending reports
   - Reviews for patterns/issues
   - Approves or requests clarification
   - Report archived for compliance

**Success Metric:** All shift reports submitted within 30 min of shift end

---

## 6. Non-Functional Requirements

### 6.1 Offline Functionality

**Critical (Must Work Offline):**
- View assigned tasks
- View shift information
- View guest check-in/out times
- Read previous messages
- Access guest emergency contact info

**High Priority (Queue & Sync):**
- Submit maintenance requests
- Mark tasks complete
- Send messages (queued, sent when online)
- Add notes to tasks

**Low Priority (Require Online):**
- Create new guest profiles
- Update financial data
- Run reports
- Access detailed guest history

**Sync Strategy:**
- Automatic sync when connection returns
- Visual indicator of pending actions
- Conflict resolution: last-write-wins with audit trail
- Max 50MB local storage

---

### 6.2 Security Requirements

**Authentication & Authorization:**
- Single sign-on (employee ID + PIN or biometric)
- Session timeout: 15 minutes inactivity
- Account lockout: 5 failed attempts = 30 min lockout
- Role-based access control (RBAC) enforced client & server-side

**Data Protection:**
- All data in transit: TLS 1.3 minimum
- All sensitive data at rest: AES-256 encryption
- Guest PII encrypted separately (GDPR/CCPA compliance)
- NO guest credit card data stored locally

**Audit & Compliance:**
- All user actions logged with timestamp & user ID
- Data access logs retained for 1 year
- Regular security audits (quarterly)
- GDPR-compliant data deletion (24-month retention)

**Privacy:**
- Staff cannot access other staff personal info
- Managers can view team contact info only
- Guest data access logged & monitored
- Clear data classification labels

---

### 6.3 Performance Requirements

| Metric | Target |
|--------|--------|
| **App Load Time** | <2 sec (3G network) |
| **First Contentful Paint** | <1.5 sec |
| **Time to Interactive** | <3 sec |
| **Task Navigation** | <500ms |
| **Message Sync** | <2 sec |
| **API Response Time** | <1 sec (p95) |
| **Lighthouse Score** | 90+ (Performance) |
| **Uptime SLA** | 99.5% |

**Optimization Strategies:**
- Service Worker caching (Cache-first for static assets)
- Lazy loading for lists (infinite scroll, 50-item chunks)
- Image optimization (WebP, max 100KB per image)
- Minified bundle <500KB gzipped
- Database query optimization (indexes on frequently filtered fields)

---

### 6.4 Compatibility & Accessibility

**Browsers & Devices:**
- Desktop: Chrome, Firefox, Safari (latest 2 versions)
- Mobile: iOS Safari 14+, Chrome Android 90+
- Tablets: All modern devices (7"+ screens)
- Offline-first: Works on 2G+ networks

**Accessibility (WCAG 2.1 AA):**
- Keyboard navigation fully supported
- Screen reader compatible (ARIA labels)
- Color contrast: 4.5:1 minimum
- Font size: Min 14px, scalable up to 200%
- Touch targets: Min 48x48px
- Estimated 95%+ accessible to staff with disabilities

---

### 6.5 Reliability & Failure Handling

**Downtime Tolerance:**
- Critical tasks (guest check-in) can work offline
- Non-critical failures: Graceful degradation with toast notifications
- Network error retry: exponential backoff (1s, 2s, 4s, 8s)
- Max 3 retry attempts before error

**Backup & Recovery:**
- Nightly automated backups
- Recovery point objective (RPO): <1 hour
- Recovery time objective (RTO): <2 hours
- Quarterly disaster recovery drills

---

## 7. Technical Specifications

### 7.1 Technology Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | React.js, React Router, Vite (build) |
| **State Management** | Redux Toolkit |
| **Offline/Sync** | Service Worker, IndexedDB |
| **Styling** | Tailwind CSS + CSS Modules |
| **Authentication** | JWT + refresh tokens |
| **API** | RESTful (possibility for WebSocket for real-time) |
| **Backend** | Node.js + Express.js |
| **Database** | PostgreSQL |
| **Hosting** | AWS (EC2 + RDS) or Azure App Service |
| **Monitoring** | Sentry, New Relic, CloudFlare Analytics |

### 7.2 API Architecture

**Core Endpoints:**

```
AUTH
├── POST /auth/login
├── POST /auth/logout
└── POST /auth/refresh

USERS & STAFF
├── GET /api/staff
├── GET /api/staff/{id}
└── GET /api/staff/me

TASKS
├── GET /api/tasks (filtered by assigned user/status)
├── POST /api/tasks
├── PATCH /api/tasks/{id}
└── GET /api/tasks/{id}/history

GUESTS
├── GET /api/guests (current)
├── GET /api/guests/{id}
└── PATCH /api/guests/{id}

MAINTENANCE
├── GET /api/maintenance-requests
├── POST /api/maintenance-requests
└── PATCH /api/maintenance-requests/{id}

MESSAGES
├── GET /api/messages
├── POST /api/messages
└── GET /api/messages/{conversationId}

REPORTS
├── GET /api/reports/shift-summary
├── GET /api/reports/maintenance-trends
└── GET /api/reports/staff-performance

ROOMS
├── GET /api/rooms (with status)
├── PATCH /api/rooms/{id}/status
└── GET /api/rooms/{id}/history
```

---

## 8. MVP (Minimum Viable Product) - Phase 1

**Target Launch:** Q1 2026  
**Development Timeline:** 12-14 weeks

### MVP Features

**Must-Have (Core Loop):**
1. ✅ Authentication (PIN-based for simplicity)
2. ✅ Guest dashboard (current guests, room status)
3. ✅ Task management (view, assign, complete)
4. ✅ Maintenance request submission & tracking
5. ✅ Basic messaging (between departments)
6. ✅ Shift information & handover notes
7. ✅ Room status board (housekeeping)
8. ✅ Offline mode (task view, offline messaging queue)
9. ✅ Mobile-first responsive design
10. ✅ Role-based access (3 levels: Staff, Manager, Admin)

**Out of Scope (Phase 2):**
- Advanced reporting & analytics
- Biometric authentication
- Scheduling & shift swaps
- Supply inventory management
- Time-tracking & labor costing
- Guest satisfaction surveys
- Integration with PMS (Property Management System)
- Advanced audit logs
- Multi-language support

### MVP Success Metrics
- **Adoption:** >85% staff using app daily within 1 month
- **Task Efficiency:** 30% reduction in task completion time
- **Communication:** 90% of shift handovers via app (vs. paper/verbal)
- **System Uptime:** 99%+ during test period
- **User Satisfaction:** NPS >60

---

## 9. Phase 2 Features (Post-Launch)

**Target Launch:** Q3 2026  
**Development Timeline:** 8-10 weeks

### Phase 2 Enhancements

1. **Advanced Scheduling**
   - Shift swaps & time-off requests
   - Automatic schedule publishing
   - Calendar integration (Google Calendar export)
   - Overtime tracking & approval

2. **Inventory Management**
   - Real-time supply tracking
   - Automatic reorder alerts
   - Supplier integration
   - Cost tracking

3. **Enhanced Reporting & Analytics**
   - Custom report builder
   - Dashboard with KPI widgets
   - Trend analysis (guest complaints, maintenance issues)
   - Staff performance scorecards
   - Excel export with charts

4. **Biometric & Advanced Security**
   - Fingerprint/Face ID authentication
   - Two-factor authentication (2FA)
   - Advanced audit logs with change tracking
   - Data export compliance reports

5. **Guest Integration**
   - Guest-facing messaging (chat with staff)
   - Guest-submitted service requests
   - Guest satisfaction surveys
   - Guest loyalty program integration

6. **Predictive Analytics**
   - Maintenance issue predictions
   - Demand forecasting for housekeeping
   - Staff availability optimization
   - Guest churn prediction

7. **AI-Powered Features**
   - Chatbot for common questions (staff & guests)
   - Smart task assignment (based on availability/skills)
   - Automated report generation
   - Incident pattern detection

8. **Third-Party Integrations**
   - PMS (Cloudbeds, Opera) sync
   - Accounting software (QuickBooks)
   - Slack integration for notifications
   - Google Workspace integration

9. **Mobile App Packaging**
   - iOS App Store distribution
   - Android Play Store distribution
   - App-exclusive features (push notifications, offline maps)

10. **Accessibility Enhancements**
    - Full multi-language support (Spanish, French, Portuguese)
    - Enhanced voice controls
    - Dyslexia-friendly font option
    - Dark mode optimization

---

## 10. Business Metrics & Success Criteria

### Key Performance Indicators (KPIs)

| Metric | Current (Baseline) | Target (3 months) | Target (12 months) |
|--------|------------------|-------------------|------------------|
| **Task Completion Time** | 60 min avg | 35 min | 25 min |
| **Guest Request Response Time** | 30 min | 15 min | <10 min |
| **Staff App Daily Active Users** | N/A | 85% | 95% |
| **Maintenance Request Turnaround** | 4 hours | 90 min | 45 min |
| **Shift Handover Completion Rate** | 70% (manual) | 95% (digital) | 98% |
| **Guest Satisfaction (service speed)** | 7.2/10 | 8.5/10 | 9.0/10 |
| **Staff Satisfaction (tool usefulness)** | N/A | NPS 50+ | NPS 70+ |
| **System Uptime** | 98% (multiple systems) | 99.5% | 99.9% |
| **Time Spent on Admin Tasks** | 10 hrs/day | 5 hrs/day | 3 hrs/day |

### Financial Impact
- **Savings:** 15 hours/week staff admin time × 30 staff × $18/hr = $8,100/month operational savings
- **Revenue Uplift:** Faster service response → improved guest satisfaction → 5% repeat booking increase
- **Operational Efficiency:** Reduced maintenance response time → fewer emergency calls → equipment longevity
- **Return on Investment:** Estimated breakeven in 9-12 months

---

## 11. Risk Analysis & Mitigation

| Risk | Impact | Probability | Mitigation |
|------|--------|------------|-----------|
| **Low staff tech adoption** | High | Medium | Training program, champions, in-app tutorials |
| **Data privacy breach** | Critical | Low | Annual security audits, encryption, GDPR compliance |
| **Network downtime in areas** | Medium | Low | Robust offline mode, multi-network connectivity |
| **Scope creep / missed launch** | High | Medium | Strict MVP definition, agile sprints, weekly reviews |
| **Integration with legacy systems** | Medium | High | Plan Phase 2 integration, avoid Phase 1 dependency |
| **Staff resistance to change** | Medium | Medium | Leadership buy-in, feedback loops, visible benefits |
| **Mobile device theft/loss** | Medium | Medium | Session timeout, remote wipe, encryption |
| **Database performance at scale** | Medium | Low | Query optimization, caching, DB indexing from start |

---

## 12. Launch Plan

### Pre-Launch (Week 1-2)
1. Staff training sessions (2 hours each, department-specific)
2. Pilot testing with selected super-users (1 shift)
3. Fix critical bugs identified
4. Prepare launch day communication & support

### Launch Day (Week 3)
1. Roll out to day shift (8am)
2. On-site support staff available
3. Collect feedback & log issues
4. Minor hotfix deployment if needed

### Post-Launch (Week 4-8)
1. Weekly feedback reviews
2. Daily monitoring & hotfixes
3. Staff engagement tracking
4. Phase 1 feature optimization based on usage data

---

## 13. Success Criteria & Definition of Done

**MVP Launch Complete When:**
- ✅ All critical features functional & tested
- ✅ 90%+ staff trained and onboarded
- ✅ Zero data loss in offline scenarios
- ✅ <2 second load times on 4G/WiFi
- ✅ 99%+ uptime during 24-hour pilot
- ✅ All high-priority security requirements met
- ✅ Complete audit trail functional
- ✅ Disaster recovery procedure tested

---

## 14. Appendix: Glossary

| Term | Definition |
|------|-----------|
| **PWA** | Progressive Web App - app-like experience in web browser |
| **Offline Mode** | App functionality without internet connection |
| **Task** | Discrete work item assigned to staff |
| **Service Request** | Guest or staff request for service |
| **Turnover** | Room cleaning between guests |
| **RBAC** | Role-Based Access Control |
| **PMS** | Property Management System (hotel booking system) |
| **NPS** | Net Promoter Score |
| **Push Notification** | Alert sent to user device |
| **Sync** | Updating local & server data to match |

---

## 15. Document Control

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 0.1 | Dec 30, 2025 | Product Team | Initial draft |
| 1.0 | Dec 31, 2025 | Product Team | Ready for development |

---

**Document Approval:**
- [ ] General Manager
- [ ] IT Director
- [ ] Department Manager Representative
- [ ] Product Owner

---

**Next Steps:**
1. Stakeholder review & approval (1 week)
2. Design phase kickoff (wireframes & prototypes)
3. Development team onboarding (architecture review)
4. Sprint planning for Phase 1 (1 week)
5. Development begins (12-14 weeks to MVP)

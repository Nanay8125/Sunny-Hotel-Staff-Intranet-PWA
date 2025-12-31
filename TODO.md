# Push Notifications Implementation Plan

## Tasks
- [ ] Install web-push library dependency
- [ ] Create lib/webPush.ts for VAPID key configuration and utilities
- [ ] Fix app/api/push/route.ts (add Supabase client, implement web-push sending)
- [ ] Create lib/usePushNotifications.ts hook for client-side permission handling
- [ ] Update lib/notifications.ts to use web-push API calls
- [ ] Create app/dashboard/components/PushNotificationSettings.tsx UI component
- [ ] Integrate push notification settings into dashboard
- [ ] Test notifications for urgent maintenance, announcements, and manager alerts

## Environment Variables Needed
- NEXT_PUBLIC_VAPID_PUBLIC_KEY
- VAPID_PRIVATE_KEY
- VAPID_EMAIL (for VAPID contact)

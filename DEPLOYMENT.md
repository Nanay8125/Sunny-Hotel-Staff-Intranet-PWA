# Production Deployment Guide: Sunny Hotel Intranet PWA

Follow these steps to deploy the Sunny Hotel Intranet system to a production environment.

## 1. Supabase Backend Setup

1.  **Create Project**: Go to [Supabase](https://supabase.com/) and create a new project.
2.  **Database Schema**:
    *   Open the **SQL Editor** in the Supabase dashboard.
    *   Copy the contents of `hotel_intranet_schema.sql` from the project root.
    *   Run the script to create tables, enums, indexes, and RLS policies.
3.  **Authentication**:
    *   Go to **Authentication > Providers** and ensure "Email" is enabled.
    *   (Optional) Disable "Confirm Email" if you want to manually onboard staff without waiting for email verification, though keeping it enabled is more secure.
4.  **Storage**:
    *   Create a bucket named `documents` for uploaded files.
    *   Ensure the RLS policies in the schema match your storage bucket permissions.

## 2. Environment Variables

You will need to configure these variables in your hosting provider (e.g., Vercel):

| Variable | Description | Source |
| :--- | :--- | :--- |
| `NEXT_PUBLIC_SUPABASE_URL` | Your Supabase Project URL | Supabase API Settings |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Your Supabase Anon/Public Key | Supabase API Settings |
| `SUPABASE_SERVICE_ROLE_KEY` | (Optional) For admin scripts | Supabase API Settings |
| `NEXT_PUBLIC_VAPID_PUBLIC_KEY` | Public key for Push Notifications | Generated (see `lib/webPush.ts`) |
| `VAPID_PRIVATE_KEY` | Private key for Push Notifications | Generated |
| `VAPID_EMAIL` | Contact email for Web Push | Use `mailto:admin@yourdomain.com` |

## 3. Vercel Deployment

1.  **Connect Git**: Push your code to GitHub, GitLab, or Bitbucket.
2.  **Import Project**: In [Vercel](https://vercel.com/), click "New Project" and import your repository.
3.  **Configure Framework**: Vercel should auto-detect **Next.js**.
4.  **Add Envs**: Paste the Environment Variables listed in Section 2.
5.  **Deploy**: Click "Deploy". Vercel will build the PWA and host it on an HTTPS-secured URL.

## 4. Domain & PWA Configuration

1.  **Custom Domain**: go to **Settings > Domains** in Vercel to add your hotel's domain (e.g., `intranet.sunnyhotel.com`).
2.  **Manifest & Service Worker**:
    *   Ensure `public/manifest.json` reflects the correct `start_url` and theme colors.
    *   The system is pre-configured to handle HTTPS redirection and HSTS as long as it is deployed on a modern host like Vercel.

## 5. Staff Onboarding Steps

Once the system is live, follow these steps to onboard the hotel team:

1.  **First Admin**: Create the first "General Manager" account directly in the Supabase `auth.users` and `public.users` tables.
2.  **Staff Registration**:
    *   Provide staff with the deployment URL.
    *   Ask them to sign up with their work email.
3.  **Role Assignment**:
    *   A Manager must log in and navigate to the **Staff Management** section (or update the `role` column in the Supabase dashboard) to assign roles: `front_desk`, `housekeeping`, `maintenance`, etc.
    *   **Crucial**: Users will have limited access until a role is assigned via RLS.
4.  **Install PWA**:
    *   Instruct staff to open the site on their mobile devices (Chrome on Android, Safari on iOS).
    *   Click the **"Install App"** prompt or use the "Add to Home Screen" option in the browser menu.
5.  **Enable Notifications**:
    *   Ask staff to go to their **Dashboard** and click **"Enable Push Notifications"** to receive urgent maintenance and management alerts.

---

**Security Note**: Always rotate your VAPID keys and Supabase keys if you suspect a leak. Ensure `NODE_ENV` is set to `production` to enable the built-in HTTPS enforcement.

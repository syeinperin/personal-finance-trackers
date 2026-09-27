# Cloud tracker setup

1. Create one project at https://supabase.com/.
2. Open the `SUPABASE_SETUP.sql` at the root of the downloadable package and run it in Supabase SQL Editor.
3. In Supabase > Project Settings > API, copy the project URL and *publishable* (or legacy anon) key to `config.js` in EACH theme folder. NEVER put a secret or service_role key in browser code.
4. In Supabase > Authentication > Providers, enable Email/Password and keep Confirm Email on. In URL Configuration, add both production Vercel URLs to allowed redirect URLs; set the primary Site URL to one of them.
5. Upload/deploy each theme folder as its own Vercel project (root directory is folder containing index.html). Both projects use the SAME Supabase URL and publishable key. Each login sees private theme-specific records.
6. The first login displays sample starter figures until you edit them. Backup previous trackers: open your OLD working pink or dark website in the same browser where you used it, Settings > Export JSON; then in the new hosted website sign in and choose Import old backup. Verify the restored figures; import REPLACES current theme's data. Export backups periodically.
7. For password reset emails in production, configure reliable SMTP and test the email confirmation + recovery links.
8. Test with two separate accounts to ensure user B cannot view or change user A's records.

Security: Supabase authentication + Row Level Security enforce per-user permissions in the database. Browser code contains public configuration only. HTTPS is supplied by Vercel. No actual backend has been provisioned by this download, so login will not work until you configure Supabase. Don't deploy it with placeholder config and expect login to work.

Reliability: online connection required to load/save. Wait until status reads Saved securely to cloud before closing. Export JSON backup periodically. The two versions have separate data for a given account, even though the login can be shared. Browser sessions may remain signed in via Supabase until sign-out.

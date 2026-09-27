-- Run once in Supabase SQL Editor. Each theme's data is independent for each account.
create table if not exists public.finance_tracker_data (
  user_id uuid not null references auth.users(id) on delete cascade,
  theme text not null check (theme in ('berry', 'northstar')),
  payload jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, theme)
);
alter table public.finance_tracker_data enable row level security;
revoke all on public.finance_tracker_data from anon, authenticated;
grant select, insert, update on public.finance_tracker_data to authenticated;
create policy "read own tracker" on public.finance_tracker_data for select to authenticated using ((select auth.uid()) = user_id);
create policy "create own tracker" on public.finance_tracker_data for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "update own tracker" on public.finance_tracker_data for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
-- Intentionally no browser-facing delete policy.

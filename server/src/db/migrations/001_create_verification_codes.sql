-- Create table for storing email verification codes
create table if not exists public.verification_codes (
  email text primary key,
  code text not null,
  expires_at timestamp with time zone not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Init RLS (optional but good practice)
alter table public.verification_codes enable row level security;

-- Policy: Allow server (service role) full access
create policy "Allow service role full access"
on public.verification_codes
for all
to service_role
using (true)
with check (true);

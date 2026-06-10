#!/bin/bash
echo "Monitoring Supabase project status..."
while true; do
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://xzpjlnkirboevkjzitcx.supabase.co/rest/v1/" -H "apikey: $(grep VITE_SUPABASE_ANON_KEY .env.local | cut -d= -f2 | tr -d '\"')" 2>/dev/null)
  if [ "$HTTP_CODE" = "401" ] || [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "404" ]; then
    echo "Supabase project is back online! HTTP Code: $HTTP_CODE"
    break
  fi
  sleep 5
done

#!/bin/bash
# Source env file to get SUPABASE_URL and SUPABASE_ANON_KEY (or SERVICE_ROLE_KEY)
ENV_FILE="/Users/zhuchen/Downloads/newmaos---ap-calculus-mastery/.env.local"

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: $ENV_FILE does not exist."
    exit 1
fi

URL=$(grep "VITE_SUPABASE_URL" "$ENV_FILE" | cut -d '=' -f2 | tr -d '"' | tr -d "'")
KEY=$(grep "VITE_SUPABASE_ANON_KEY" "$ENV_FILE" | cut -d '=' -f2 | tr -d '"' | tr -d "'")

if [ -z "$URL" ]; then
    URL=$(grep "SUPABASE_URL" "$ENV_FILE" | cut -d '=' -f2 | tr -d '"' | tr -d "'")
fi

if [ -z "$KEY" ]; then
     KEY=$(grep "SUPABASE_ANON_KEY" "$ENV_FILE" | cut -d '=' -f2 | tr -d '"' | tr -d "'")
fi

if [ -z "$KEY" ]; then
    KEY=$(grep "SUPABASE_SERVICE_ROLE_KEY" "$ENV_FILE" | cut -d '=' -f2 | tr -d '"' | tr -d "'")
fi

if [ -z "$URL" ] || [ -z "$KEY" ]; then
    echo "Error: Could not find URL or KEY in .env.local"
    exit 1
fi

echo "Fetching all Both_Limits questions..."
# Fetch existing questions to find matches manually
RESPONSE=$(curl -s -H "apikey: $KEY" -H "Authorization: Bearer $KEY" "$URL/rest/v1/questions?topic=eq.Both_Limits&select=id,title,prompt,updated_at")
echo "$RESPONSE" > database/existing_questions.json
echo "Saved to database/existing_questions.json"

#!/bin/bash

# Load credentials from OpenCode's auth.json using python
AUTH_FILE="$HOME/.local/share/opencode/auth.json"

get_key() {
    python3 -c "import json; print(json.load(open('$AUTH_FILE')).get('$1',{}).get('key',''))" 2>/dev/null
}

OPENROUTER_API_KEY=$(get_key "openrouter")

# Function to draw 5 small circles
draw_circles() {
    local percent=$1
    local filled=$(( (percent + 19) / 20 ))
    [ "$filled" -gt 5 ] && filled=5
    
    result=""
    for i in 1 2 3 4 5; do
        if [ "$i" -le "$filled" ]; then
            result="${result}●"
        else
            result="${result}○"
        fi
    done
    echo "$result"
}

# OpenRouter
if [ -n "$OPENROUTER_API_KEY" ]; then
    OR_RESPONSE=$(curl -s "https://openrouter.ai/api/v1/credits" -H "Authorization: Bearer $OPENROUTER_API_KEY" 2>/dev/null)
    if echo "$OR_RESPONSE" | grep -q "total_credits"; then
        TOTAL=$(echo "$OR_RESPONSE" | grep -o '"total_credits":[0-9.]*' | cut -d':' -f2)
        USAGE=$(echo "$OR_RESPONSE" | grep -o '"total_usage":[0-9.]*' | cut -d':' -f2)
        REMAINING=$(printf "%.2f" "$(echo "scale=2; $TOTAL - $USAGE" | bc)")
        PERCENT=$(echo "scale=0; $REMAINING * 100 / $TOTAL" | bc | cut -d'.' -f1)
        
        CIRCLES=$(draw_circles $PERCENT)
        printf "OpenRouter %s \$%s\n" "$CIRCLES" "$REMAINING"
    fi
fi

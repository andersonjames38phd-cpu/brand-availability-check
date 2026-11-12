#!/usr/bin/env bash
# Brand Availability Check - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~brand-availability-check"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Full check on a few candidates
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "brandNames": [
        "Lumenforge",
        "Northwind",
        "Kestrel"
      ]
    }'

# 2. Domains and socials only (fastest)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
      "brandNames": [
        "Lumenforge"
      ],
      "checkTrademarks": false
    }'

# 3. Synchronous run - get items in the same response (small jobs only)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}&format=json" \
  -H "Content-Type: application/json" \
  -d '{
      "brandNames": [
        "Lumenforge"
      ]
    }'

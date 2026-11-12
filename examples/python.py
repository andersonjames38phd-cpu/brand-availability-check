"""Brand Availability Check - Python example.

Install:
    pip install apify-client

Run:
    APIFY_TOKEN=your_token python python.py
"""

import os
from apify_client import ApifyClient

TOKEN = os.environ.get("APIFY_TOKEN", "YOUR_TOKEN")
ACTOR = "Turboextract/brand-availability-check"

client = ApifyClient(TOKEN)

# 1. Start the actor and wait for it to finish
run_input = {
    "brandNames": ["Lumenforge", "Northwind", "Kestrel"],
}

run = client.actor(ACTOR).call(run_input=run_input)

# 2. Stream results
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    free = [d["host"] for d in item["domains"] if d["available"]]
    print(item["brandName"], "- free domains:", ", ".join(free) or "none")

# 3. Or pull all at once into a list
items = list(client.dataset(run["defaultDatasetId"]).iterate_items())
print(f"\n{len(items)} names returned.")

// Brand Availability Check - Node.js example.
//
// Install:
//   npm install apify-client
//
// Run:
//   APIFY_TOKEN=your_token node node.mjs

import { ApifyClient } from 'apify-client';

const TOKEN = process.env.APIFY_TOKEN ?? 'YOUR_TOKEN';
const ACTOR = 'Turboextract/brand-availability-check';

const client = new ApifyClient({ token: TOKEN });

// 1. Start the actor and wait for it to finish
const runInput = {
    brandNames: ['Lumenforge', 'Northwind', 'Kestrel'],
};

const run = await client.actor(ACTOR).call(runInput);

// 2. Pull dataset items
const { items } = await client.dataset(run.defaultDatasetId).listItems();

for (const item of items) {
    const free = item.domains.filter((d) => d.available).map((d) => d.host);
    console.log(item.brandName, '- free domains:', free.join(', ') || 'none');
}

console.log(`\n${items.length} names returned.`);

// 3. Or stream item-by-item (useful for large jobs)
// for await (const item of client.dataset(run.defaultDatasetId).iterate()) {
//     console.log(item);
// }

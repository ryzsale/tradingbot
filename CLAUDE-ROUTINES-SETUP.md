# Claude Desktop / Claude Code Routine Setup

The routine prompts are already written in the repo under [routines](routines). Use the steps below to create the five scheduled routines in Claude Desktop or Claude Code cloud.

## 1) Create the five routines
Create one routine for each prompt file:

- Pre-market: [routines/pre-market.md](routines/pre-market.md)
- Market-open: [routines/market-open.md](routines/market-open.md)
- Midday: [routines/midday.md](routines/midday.md)
- Daily-summary: [routines/daily-summary.md](routines/daily-summary.md)
- Weekly-review: [routines/weekly-review.md](routines/weekly-review.md)

## 2) Use these schedule values
- Pre-market: 0 6 * * 1-5
- Market-open: 30 8 * * 1-5
- Midday: 0 12 * * 1-5
- Daily-summary: 0 15 * * 1-5
- Weekly-review: 0 16 * * 5

Set the timezone to America/Chicago.

## 3) Add these environment variables to each routine
- ALPACA_API_KEY
- ALPACA_SECRET_KEY
- ALPACA_ENDPOINT
- ALPACA_DATA_ENDPOINT
- PERPLEXITY_API_KEY
- PERPLEXITY_MODEL
- CLICKUP_API_KEY
- CLICKUP_WORKSPACE_ID
- CLICKUP_CHANNEL_ID

Do not put secrets in a repo .env file for the cloud runs. Put them in the routine environment settings.

## 3a) Brokerage preference
The workspace already has a working Robinhood MCP server configured. Prefer that for account state, positions, orders, and trade execution. Keep the Alpaca wrapper scripts only as fallback or testing paths.

## 4) Enable the required GitHub setting
In the routine environment settings, turn on:
- Allow unrestricted branch pushes

This avoids the common push failure on first setup.

## 5) Connect the GitHub repo
Install the Claude GitHub App on this repository and allow it access to the repo.

## 6) Paste the prompt content
Open each routine in the Claude UI and paste the content from the matching file in [routines](routines) exactly as written.

## 7) Test one routine first
Run the pre-market routine once manually. Confirm that:
- it reads the memory files
- it writes a research entry
- it commits and pushes

If that succeeds, add the remaining routines.

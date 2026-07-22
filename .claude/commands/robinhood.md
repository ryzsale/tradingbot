---
description: Robinhood-first account and portfolio snapshot using the configured MCP tools
---

Use the configured Robinhood MCP tools first.

1. Read the account state from Robinhood MCP.
2. Read positions and open orders from Robinhood MCP.
3. Summarize the portfolio in a concise format.
4. If the Robinhood MCP tools are unavailable, fall back to the Alpaca wrapper scripts and clearly state that fallback.

Output format:
Portfolio — <today's date>
Equity: $X | Cash: $X | Buying power: $X
Positions:
  SYM | Shares | Entry -> Now | Unrealized P&L | Stop
Open orders:
  TYPE | SYM | qty | status

---
description: Robinhood-first trade helper with strategy-rule validation
---

Use the configured Robinhood MCP tools first for any brokerage action.

Args: SYMBOL SHARES SIDE (buy or sell). If missing, ask.

1. Read account state and positions from Robinhood MCP.
2. For BUY, validate:
   - Total positions after fill <= 6
   - Trades this week + 1 <= 3
   - SHARES * price <= 20% of equity
   - SHARES * price <= available cash
   - daytrade_count leaves room
   - Catalyst documented in today's RESEARCH-LOG
   If any fail, STOP and print the failed checks.
3. For SELL, confirm the position exists with the requested quantity.
4. Print the proposed order details and ask for confirmation.
5. On confirmation, place the order using Robinhood MCP.
6. If Robinhood MCP is unavailable, fall back to the Alpaca wrapper script and clearly note the fallback.
7. Log the trade to memory/TRADE-LOG.md with thesis, entry, stop, target, and R:R.
8. Send a brief ClickUp update.

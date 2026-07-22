---
description: Run the market-open execution workflow
---

Run the workflow defined in routines/market-open.md.

Follow the steps exactly:
1. Read today's research and trade context.
2. Re-validate account, positions, and quotes.
3. Apply the buy-side rule checks before placing any order.
4. Execute buys and place trailing stops.
5. Append the trades to memory/TRADE-LOG.md.
6. Commit and push if trades were executed.

---
description: Run the daily summary workflow
---

Run the workflow defined in routines/daily-summary.md.

Follow the steps exactly:
1. Read the latest trade log and prior EOD snapshot.
2. Pull final account and position state.
3. Compute day and phase P&L.
4. Append an EOD snapshot to memory/TRADE-LOG.md.
5. Send a ClickUp summary and push the update.

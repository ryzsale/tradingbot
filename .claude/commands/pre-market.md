---
description: Run the pre-market research workflow
---

Run the workflow defined in routines/pre-market.md.

Follow the steps exactly:
1. Read the trading strategy and the latest memory files.
2. Pull live account state via the Alpaca wrapper.
3. Gather market context using the Perplexity wrapper.
4. Write a dated research entry to memory/RESEARCH-LOG.md.
5. Send a brief ClickUp update if needed.
6. Commit and push the research changes.

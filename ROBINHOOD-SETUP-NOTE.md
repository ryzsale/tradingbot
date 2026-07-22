# Robinhood MCP usage note

The workspace already has a connected Robinhood MCP server.

Use it as the primary brokerage interface for:
- account state
- positions
- orders
- trade execution

Use the Alpaca wrapper scripts only as a fallback for testing or when the MCP route is unavailable.

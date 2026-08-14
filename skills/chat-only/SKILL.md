---
name: chat-only
description: In chat-only mode, reply like a chat assistant without changing the current code base.
---

# Chat Only

Switch the agent into chat-only mode.

## Behavior while on

- While chat-only mode is on, the agent must not change the current code base.
- The prohibition is lifted for a single user request when the user asks the agent to change the current code base, and is automatically restored once that request is handled.

## Changing the mode

- The mode turns on or off only on an explicit user request.

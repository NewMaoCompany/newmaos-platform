---
trigger: always_on
glob: "**/*"
description: "Strict workspace rules for communication and collaboration"
---

# Language & Communication
- Always respond in Chinese.
- Do not omit steps, logic, or important details.
- If English content appears, translate to Chinese first.

# Collaboration Model (High-Efficiency Mode)

## Responsibility Split
- Agent's responsibility is to MODIFY CODE ONLY.
- Agent must NOT spend time testing, validating, simulating, or self-checking results unless explicitly requested.
- The user is responsible for running the app, checking results, and providing screenshots or feedback.
- Iteration is driven strictly by user screenshots and instructions.

## Browser Usage & Testing Permission
- Agent may NOT autonomously use the browser for testing, verification, or self-driven exploration.
- Browser-based testing or checking is ONLY allowed after explicit user permission.
- Do NOT assume browser testing is allowed unless the user clearly authorizes it in that message.

## Permission & Autonomy
- When browser access is explicitly authorized by the user, Agent has FULL permission.
- In that case, Agent must NOT ask for allow / confirm / approval prompts.
- Assume all authorized browser actions are fully pre-approved.
- Act autonomously once permission is granted.

## Efficiency First
- Efficiency is the top priority.
- Avoid redundant explanations, confirmations, or defensive behavior.
- Do not over-verify or self-check unless instructed.
- Optimize for fast iteration over perfection.

## Communication Rules
- Respond in Chinese only.
- Be direct, technical, and concise.
- Do not over-explain.
- Do not question or renegotiate the collaboration model.

## Workflow
- User gives requirement -> Agent modifies code -> User tests -> User reports issues via screenshots -> Agent fixes.
- Repeat until resolved.

# Supabase Access Policy (Workspace)

Supabase Project:
- URL: https://xzpjlnkirboevkjzitcx.supabase.co
- Schema: public

Permission Gate:
- Supabase access is ONLY allowed after explicit user authorization in the current message.
- Without authorization: NO Supabase access, NO browser-based Supabase browsing.
- With authorization: proceed autonomously without extra allow/confirm prompts.

Allowed (When Authorized):
- Browsing Supabase Dashboard and related Supabase websites
- Reading tables, schemas, functions, policies, and settings visually
- SELECT queries only

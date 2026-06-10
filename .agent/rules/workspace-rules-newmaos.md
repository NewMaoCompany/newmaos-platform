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

# Restricted Operations

## Large Downloads
- You MUST ask for explicit USER confirmation before performing any operation that involves downloading more than 10GB of data.
- This rule is absolute and applies to all models and agents in this workspace.

# Global Refactor Requirements (Onboarding, Subscription, Notifications)
Please deeply rethink and refactor the onboarding, Pro subscription, access control, and top navigation badge system. One important global requirement: all user-facing language on the website must be English. This includes all popups, buttons, tooltips, badge messages, reward messages, locked-feature warnings, subscription prompts, onboarding text, error messages, success messages, and any text shown in Dashboard, Practice, Analysis, Forum, Settings, Subscription, wallet, and check-in pages. Do not use Chinese or mixed Chinese-English in the actual website UI.

Please completely remove the current bell notification system. Remove the bell icon, the bell notification page, and all old notification logic connected to it. From now on, all reminders should be shown only through red dots or numeric badges on the five top navigation tabs: Dashboard, Practice, Analysis, Forum, and Settings. Each tab should have its own badge logic, and the badge state must be stored persistently in the backend, not only in frontend state. Refreshing the page must not randomly remove badges.

For a brand-new user, after registration succeeds, wait about 1–2 seconds and automatically show a non-dismissible popup saying: “Claim your free 200 coins.” This popup cannot be closed, skipped, or dismissed. The user must click the claim button. After claiming, the system must actually add 200 coins to the user’s wallet in the backend, update the wallet balance immediately on the frontend, and show a coin animation flying into the wallet in the top-right area. After the 200 coins are successfully claimed, wait about 2–3 seconds and then show a second popup prompting the user to upgrade from Basic to Pro using 199 coins. The popup should clearly explain that the user can upgrade now with 199 coins, and that they can also upgrade later from Settings → Subscription. This Pro upgrade popup can be closed, but closing it does not mean the user has subscribed.

If the user is still on the Basic plan, Pro-only features must remain locked. This includes Analysis, Forum, and any advanced editing or premium features inside Settings. When a Basic user clicks a locked feature, the system should show an English popup such as: “This feature requires Pro. Please upgrade in Settings → Subscription.” The popup should include a clear button that navigates to Settings → Subscription. Do not silently block the user; always explain why the feature is locked and where to upgrade.

Dashboard badge logic should be tied to daily check-in. Every day at 12:00 AM, the backend should generate or refresh a check-in reminder for that user if the user has not checked in for the new day. The Dashboard tab should show a red dot, and the Check-in button or Check-in card inside Dashboard should also show a red dot. These two badges must stay synchronized. When the user completes check-in, both badges should disappear.

Practice badge logic should be tied to daily practice recommendations. Every day at 12:00 AM, the backend should refresh the Practice reminder. If the user has a new Algorithm Choice, Random Choice, or Review recommendation for the day, the Practice tab should show a red dot, and the corresponding recommendation card inside Practice should also show a red dot. When the user clicks and handles that card, both the internal card badge and the Practice tab badge should disappear.

Analysis badge logic should refresh daily at 12:00 AM. If the user’s practice data, accuracy, coins, question performance, or other analysis-related metrics changed during the past 24 hours, the Analysis tab should show a red dot to indicate that new analysis is available. When the user opens and views the latest analysis, the badge should disappear.

Forum badge logic should be based on unread community activity. If the user has new replies, comments, likes, mentions, system interactions, or other unread forum-related activity, the Forum tab should show a badge. If there are multiple unread items, the badge should show the unread count, not just a dot. When the user views or handles each unread item, the count should decrease. When all unread forum activity has been handled, the Forum badge should disappear.

Settings badge logic should be tied only to subscription status. If the user is not Pro, the backend should refresh one Settings reminder every day, and both the Settings top tab and Settings → Subscription subpage should show a red dot. This badge must not disappear simply because the user refreshes the page, opens Settings, clicks the tab, or closes the Pro popup. It should disappear only after the user successfully subscribes to Pro.

All badge states must be backend-persistent and synchronized with the frontend. Top navigation badges and internal page/card badges must be linked in both directions. If the user enters from the top navigation tab and completes the related action, the internal badge should disappear. If the user enters from the internal card or button and completes the related action, the top navigation badge should disappear. Please clean up the old bell-based notification logic and replace it with a unified top-navigation badge system that does not duplicate reminders, does not lose state after refresh, and does not remove badges before the user completes the required action.

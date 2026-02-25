# Automated Payment Verification

To automatically verify that a roommate has paid for a specific month, we can implement one of the following strategies:

## 1. Bank Sync via Plaid (Recommended)
This is the most robust and professional method. 
- **How it works**: The user connects their bank account via Plaid. The app then scans transactions for keywords like "Zelle", "Venmo", "Rent", or specific recipient names (e.g., "Nico Covone").
- **Verification Logic**: 
  - IF a transaction matches recipient "Nico" AND amount matches expected split.
  - THEN mark as "Verified" in the app.
- **Pros**: Fully hands-off for the user once connected.
- **Cons**: Requires a Plaid developer account and a small monthly cost per user.

## 2. Zelle/Venmo Email Parsing
Zelle and Venmo send confirmation emails for every transaction.
- **How it works**: We set up a dedicated inbox or use an "Inbound Parse" service (like SendGrid or Mailgun). The user forwards their Zelle emails to `verify@rentcalc.app`.
- **Verification Logic**: A Cloud Function parses the email body to extract the date, amount, and note.
- **Pros**: Easy to implement; no bank connection required.
- **Cons**: Users have to remember to forward emails (can be automated with gmail filters).

## 3. OCR (Gemini API) Screenshot Audit
This is what we are partially doing now with the image you provided.
- **How it works**: The user uploads a screenshot of their Zelle/Venmo activity directly into the app.
- **Verification Logic**: We send the image to Gemini (Vertex AI / Firebase GenAI SDK) with a prompt to "Extract Zelle transactions to Nico Covone".
- **Pros**: High "Wow" factor; very easy for users to just take a snap.
- **Cons**: Manual step for the user; costs a small amount per LLM call.

---

### Current Implementation Status:
- Created a **Payment Discrepancy** page that uses your actual Zelle data.
- Added a **Verify Automatically** button to the Rent Tracking screen.
- Updated the logic to show your current "Balance" against Nico.

# Contract: Deep Link (Invitation)

Scheme: `fujii://invite/{CODE}`

## Flow
- OS opens app with the URI
- App extracts `code` query param
- App submits code via InviteViewModel
- On success: navigate to MonthCalendar view (read-only if viewer)
- On failure: show invalid/expired message and guidance

## Test Cases
- Valid code → success state, calendar visible
- Invalid code → error message shown
- Expired/revoked code → error message shown

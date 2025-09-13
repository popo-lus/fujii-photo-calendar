# Contract: Security Rules (Conceptual)

- Viewers (anonymous sessions via invite) have read-only access to owner-visible scope.
- Enforce invite validity: not disabled, not expired.
- Prevent writes/deletes by viewers; only owners can upload/edit.
- Rate-limit invite submissions to mitigate brute force.
- Log access events for 90 days.

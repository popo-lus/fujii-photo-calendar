# Contract: Invites

## Get Invite by Code
- Endpoint: GET /invites/{code}
- Behavior: Firestore get invites/{code}（list 禁止）
- Response:
  - 200 OK: { code, ownerUid, disabled: boolean, expiresAt?: Timestamp }
  - 404 Not Found

## Invalidate Invite
- Endpoint: POST /invites/{code}:invalidate
- Behavior: Firestore update invites/{code}.disabled = true
- Response: 204 No Content

備考: 本仕様は Functions なしの最小構成。厳密な使用回数制限は扱わない。

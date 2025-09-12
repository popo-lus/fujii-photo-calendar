# Contract: Albums (Read Only for Anonymous)

## Get Calendar (Owner)
- Endpoint: GET /albums/{ownerUid}/calendar/{MM}
- Behavior: Firestore get users/{ownerUid}/calendar/{MM}
- Response: 200 OK: { userPhotos: [...], fujiiPhotos: [...], month }

## Permissions
- Registered user (owner): 読み/書き
- Anonymous (with invite): 読みのみ

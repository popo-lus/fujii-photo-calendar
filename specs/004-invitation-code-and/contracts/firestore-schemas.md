# Contract: Firestore Schemas

## invites/{code}
- ownerUid: string (required)
- disabled: boolean (default false)
- expiresAt: timestamp | null
- createdAt: timestamp

Notes:
- Document ID is the invite code itself (aligned with seed-invites.js).
- No status/usageCount/lastUsedAt fields at persistence layer; derive in client if needed.

## users/{uid}/calendar/{MM}
- userPhotos: Photo[]
- fujiiPhotos: Photo[]
- month: number
- updatedAt: timestamp

## types
Photo:
- id: string
- url: string
- capturedAt: timestamp
- month: number
- type: 'user-photos' | 'fujii-photos'
- updatedAt: timestamp
- memo: string

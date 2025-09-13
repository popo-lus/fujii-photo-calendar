# Data Model: Invitation & User Photo Upload

この文書はデータモデルを「Firestore側（永続スキーマ）」と「クライアント側（アプリ内モデル）」で明確に分けて記述します。既存実装互換性を最優先とします。

## Firestore Entities（永続データ）

### invites/{code}
- ownerUid: string（必須）
- disabled: boolean（既定: false）
- expiresAt: timestamp | null（任意）
- createdAt: timestamp（サーバー時刻）

備考:
- ドキュメントIDが招待コードそのもの（seed-invites.js 準拠）。
- status/usageCount/lastUsedAt 等は持たない（必要に応じてアプリ側で導出）。

### users/{uid}/calendar/{MM}
- userPhotos: Photo[]
- fujiiPhotos: Photo[]
- month: number
- updatedAt: timestamp

types: Photo（配列要素の形）
- id: string
- url: string
- capturedAt: timestamp
- month: number
- type: 'user-photos' | 'fujii-photos'
- updatedAt: timestamp
- memo: string（任意）

備考:
- 既存実装（および seed-storage.js）の形を踏襲。フィールド名/構造を変更しない。

## Client Entities（アプリ内モデル）

### Invitation（アプリ内）
- code: string（invites/{code} のドキュメントID）
- ownerUid: string
- disabled: boolean
- expiresAt: timestamp | null
- createdAt: timestamp
- shareableUrl: string（導出）: `fujii://invite?code={code}`
- status: 'active' | 'revoked' | 'expired'（導出）

導出ルール（例）:
- status = expired if expiresAt < now; revoked if disabled == true; else active

注記（セッション管理）:
- ViewerSession（アプリ内モデル）は作成しない。Firebase Auth（匿名認証）にセッション管理を委譲する。
- 端末側のセッション永続化は Firebase Auth の既定挙動に従う。

### Photo（アプリ内）
- 既存の Firestore 配列要素（id, url, capturedAt, month, type, updatedAt, memo）に準拠。
- 互換性を維持するため、owner/source/visibility などの追加属性は導出/オプショナルとして扱い、永続層のスキーマは変更しない。

互換性ポリシー:
- Firestore の既存配列スキーマを不変とし、クライアント側で必要に応じて派生情報を補完する。

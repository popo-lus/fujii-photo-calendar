# Data Model: Registration & Anonymous Viewing

対象: specs/003-features-registration/spec.md

本ドキュメントでは、各エンティティについて「Source of Truth（正）」と保存先レイヤ（Firebase Auth / Firestore / クライアントのみ）を明示します。

## Entities

### User
- uid: string
- email: string
- displayName: string
- status: 'active' | 'disabled' | 'pending'

Layer / Source of Truth
- Firebase Auth（正）: uid, email, displayName
- Firestore: users/{uid} ドキュメントにアプリ固有の値を保持（例: { displayName, email, status, createdAt, updatedAt }）
	- 備考: status は Auth には存在しないため Firestore 側が正。
- クライアント（Entity として保持）: UserRepository / UserService を通じて取得・購読可能。ローカルの正ではなく、Auth/Firestore の同期結果を表現する。

### Album
- ownerUid: string
- photos: Array<{ id: string, url: string, capturedAt: Timestamp, month: number, type: 'user-photos'|'fujii-photos', updatedAt: Timestamp, memo: string }>

Layer / Source of Truth
- Firestore（正）: users/{ownerUid}/calendar/{MM}
	- 既存コントラクトでは userPhotos[], fujiiPhotos[] の2配列で保存する想定。
	- 本エンティティの photos[] は UI で結合して扱うための論理モデル（ストレージ上の正ではない）。
- クライアント: 表示都合での整形・結合のみ（正ではない）

### InviteCode
- code: string
- ownerUid: string
- disabled: boolean (default false)
- expiresAt: Timestamp | null
- createdAt: Timestamp

Layer / Source of Truth
- Firestore（正）: invites/{code}
- クライアント: 送信（認証/閲覧開始）後は保持しない（任意の一時入力のみ）。

### ViewerSession
- viewerUid: string
- code: string
- albumOwnerUid: string
- createdAt: Timestamp
- expiresAt?: Timestamp

Layer / Source of Truth
- Firebase Auth: 匿名ユーザーのセッション（サインイン状態）
- Firestore: guestSessions/{viewerUid} = { code, albumOwnerUid, ... }（監査・簡易トラッキング用途。正は「現在の Auth セッション」）
- クライアント: 保持は Firebase パッケージ（Auth セッション管理）に一任。独自の永続保存は行わない。

## Validation Rules (from spec)
- Registration requires: displayName (non-empty), email (RFC5322 basic), password (min length: 8 assumed)
- Email uniqueness enforced（重複は上書き不可）
- Anonymous viewer: code exists, not disabled, not expired
- Anonymous viewer: read-only (no edit operations)

適用レイヤ（どこで強制するか）
- displayName/email/password 形式: クライアントで事前検証 + Firebase Auth が最終バリデーション（password 強度/メール重複）
- Email uniqueness: Firebase Auth が正（同一メールでの重複作成を拒否）
- Invite code の存在/失効: Firestore（invites/{code} の read で判定）
- Anonymous の読み取りのみ: Firestore セキュリティルールで強制（匿名ユーザーは書き込み不可）

## App Layer Integration（Service/Repository）
- User はクライアントでも Entity として保持し、以下の経路で利用する:
	- UserRepository: 現在のユーザーを取得/購読（Auth 状態 + Firestore users/{uid} をマージ）
	- UserService: 画面/ユースケースから利用する薄いファサード（例: 表示名更新時に Auth と Firestore を一貫更新）
- InviteCode は入力時のみ使用し、送信後は保持しない。
- ViewerSession は Firebase Auth によるセッション管理に一任し、アプリ独自のローカル永続化は行わない。

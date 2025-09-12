# Contract: Auth

本契約はクライアント（Flutter）での操作と Firebase の対応を擬似APIとして表現します。

## Register (Email/Password)
- Endpoint: POST /auth/register
- Request: { displayName: string, email: string, password: string }
- Behavior:
  - firebase_auth.createUserWithEmailAndPassword(email, password)
  - updateProfile(displayName)
  - Firestore: users/{uid} に { displayName, email, createdAt, updatedAt }
- Response: 201 Created（uid, displayName, email）
- Errors:
  - 400: validation error（名前空、メール形式、パスワード弱い）
  - 409: duplicate email（既存アカウント）

## Login (Email/Password)
- Endpoint: POST /auth/login
- Request: { email: string, password: string }
- Behavior: firebase_auth.signInWithEmailAndPassword
- Response: 200 OK（uid）
- Errors: 401 invalid credentials

## Anonymous View (Invite Code)
- Endpoint: POST /auth/anonymous
- Request: { code: string }
- Behavior:
  - firebase_auth.signInAnonymously
  - Firestore: guestSessions/{uid} = { code }
  - invites/{code} を get して存在確認（任意）
- Response: 200 OK（viewerUid）
- Errors: 400 invalid code（存在しない/失効など）

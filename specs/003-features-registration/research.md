# Research: 登録（Email/Password）＋匿名閲覧（招待コード）

日付: 2025-09-12
対象: specs/003-features-registration/spec.md（Flutter＋Firebase Auth、invites.md準拠）

## 決定事項（Decision）
- 認証方式
  - 登録ユーザー: Firebase Authentication の Email/Password を使用
  - 閲覧者（匿名）: Firebase Authentication の Anonymous を使用
- 招待コードの検証
  - Firestore の invites/{code} と guestSessions/{viewerUid} を利用
  - `specs/003-features-registration/contracts/invites.md` の最小構成（Cloud Functions なし、list 禁止、get のみ）
- データ参照
  - 既存構造（users/{uid}/calendar/{MM} に userPhotos/fujiiPhotos 配列）を踏襲
  - 匿名閲覧は invites ルールに合致する場合のみカレンダーを読み取り可
- プロフィール
  - 名前（表示名）のみ（画像なし）
- 言語
  - 日本語のみ

## 根拠（Rationale）
- シンプルさ: Functions 不使用により運用・学習コストを抑制
- 既存資産の活用: calendar 構造とストレージURL表示を継続
- ユースケース適合: 閲覧者は匿名で十分。編集は登録ユーザーのみ

## 代替案と比較（Alternatives）
- 代替: OAuth/SSO
  - 理由: 運用コスト増。要件外
- 代替: Functions による招待消費・使用回数カウント
  - 理由: 本フェーズでは不要。invites.md でも非推奨（最小構成）

## 未決定/不明点（Resolved / None）
- 本仕様では「同意保存」「通知初期設定」「プロフィール画像」は対象外
- パスワード最小文字数は後続実装で 8 文字（目安）をデフォルトとする想定


## リスクと緩和
- コード漏洩: list 禁止・手動失効（disabled）・有効期限（expiresAt）
- 匿名セッション横展開: 端末バインド（ローカル保持）と失効反映

## 現状のアプリ構成（確認済み）
- 依存関係: firebase_auth, cloud_firestore, riverpod（riverpod_annotation）, auto_route
- ディレクトリ構成（app/lib）:
  - core/, data/（services, repositories）, domain/（entities, repositories, usecases）, presentation/（screens, router, viewmodels）, providers/
- 既存パターン: Photos 系に Repository/Service を採用（UseCase 層あり）。本機能も UserRepository/UserService 方針で整合。
- Firestore パス: users/{uid}/calendar/{MM} に userPhotos[] / fujiiPhotos[]
- 認証ガード: presentation/router/auth_guard.dart で FirebaseAuth.currentUser を参照

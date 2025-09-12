# Implementation Steps: 003-features-registration

この手順書は、既存の app 構成（Riverpod/auto_route/Repository パターン）と本機能の設計文書を踏まえ、漏れなく着実に実装するための順序を示します。テストは本フェーズの範囲外です。

## 前提
- 依存: firebase_auth, cloud_firestore, riverpod, riverpod_annotation, auto_route
- Firestore 構造: users/{uid}/calendar/{MM} に userPhotos[], fujiiPhotos[]
- 招待仕様: specs/003-features-registration/contracts/invites.md

## 1. Auth 拡張（登録・匿名導線）
1-1. 画面導線
- LoginPage に以下の導線を追加
  - 「新規登録」ボタン（登録ダイアログ/ページへ）
  - 「招待コードで閲覧」ボタン（コード入力ダイアログ/ページへ）

1-2. バリデーション（クライアント）
- AuthValidators に以下を定義/確認
  - displayName: 非空
  - email: 形式
  - password: 最小8文字（仮）

1-3. サービス/API 呼び出し
- AuthService に API を追加
  - register(displayName, email, password):
    - FirebaseAuth.createUserWithEmailAndPassword
    - currentUser.updateDisplayName(displayName)
    - Firestore users/{uid} に { displayName, email, status: 'active', createdAt, updatedAt } を作成
  - signInAnonymousWithCode(code):
    - FirebaseAuth.signInAnonymously
    - invites/{code} を get（disabled でない/期限切れでないこと）
    - 必要なら guestSessions/{uid} を作成（監査用途）

1-4. ViewModel
- LoginViewModel に以下のイベント/状態を追加
  - onTapRegister → AuthService.register → Router でホームへ
  - onTapInviteView → AuthService.signInAnonymousWithCode → 共有アルバムへ

## 2. User Repository/Service
2-1. Repository
- contracts/user_repository.md に準拠して UserRepository 実装
  - watchCurrent(): authStateChanges + Firestore users/{uid} を combineLatest
  - getCurrentOnce(): 一回取得
  - updateDisplayName(): Auth + Firestore を一貫更新

2-2. Service（薄いファサード）
- UserService: watchCurrent / updateDisplayName を委譲
- Riverpod Provider を追加（keepAlive 適用検討）

## 3. 招待コード閲覧のルーティング
- 共有アルバムへの遷移に必要な ownerUid と month を Router にパラメータとして渡す
- invites/{code} の ownerUid を参照し、LoadMonthPhotosUseCase(uid: ownerUid, month: X) を呼び出す

## 4. Firestore セキュリティ（設計連携）
- 匿名ユーザーは読み取りのみ許可（users/{ownerUid}/calendar/{MM}）
- 書き込みは登録ユーザー（ownerUid が currentUser.uid のみ）
- invites の list 禁止、get のみ許可

## 5. UI 文言（日本語）
- エラー文言（重複メール/無効コード/通信失敗）の日本語メッセージを整備
- 成功トースト/スナックバー（任意）

## 6. 既存機能との統合確認
- AuthGuard の振る舞い確認（匿名ユーザーでも閲覧ルートは許可）
- 既存の UseCase/Repository で任意の ownerUid を受けられることを確認（本リポジトリは uid を引数で受け取れる実装済み）

## 7. 開発・動作確認手順（手動）
- Emulator 起動 → seed（auth/storage/invites）
- 登録フロー → ホーム遷移
- 招待閲覧フロー → 共有アルバム表示（編集不可）
- 失効コード確認 → エラーメッセージ

## 8. デプロイ/設定
- firebase.json（FlutterFire） は既存設定を利用
- iOS/Android の設定ファイル（GoogleService-Info.plist / google-services.json）は既存

## 9. ログ/モニタリング
- AppLogger に主要イベント（register success/failure, anonymous start/failure）出力

## 10. 今後の拡張余地（任意）
- プロフィール編集（表示名更新）導線
- 招待の発行/無効化 UI

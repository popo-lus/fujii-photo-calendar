# Tasks: 招待コード & ユーザー写真アップロード（URL起動のみ）

Input: /specs/004-invitation-code-and/ の設計資料（plan.md 必須, research.md, data-model.md, contracts/）
Prerequisites: FVM 3.32.0, Firebase Emulator, シード投入、匿名認証の許可

## 実行フロー（要約）
- contracts/* → 実装に必要な項目を洗い出し
- data-model.md → 実装時のデータ整合性の指針
- research.md → セットアップ/ポリシー/運用タスク
- 順序: Setup → 実装 → 仕上げ

パス前提: Flutter モバイルアプリの実装は `app/lib/**` 配下。

---

## Phase 3.1: Setup（環境・依存・構成）
- [ ] T001 FVM セットアップと依存取得（ローカル開発の統一）
  - 実行: app/ で FVM 3.32.0 を use、`fvm flutter pub get`
  - 成功条件: 依存解決成功、`app/.dart_tool/`生成
- [ ] T002 Firebase Emulator 接続の確認と切替手段の明記
  - 対象: `app/lib/main.dart` の `USE_FIREBASE_EMULATORS` 環境定義と useEmulators ブロック
  - 成功条件: エミュレータ起動時に Firestore/Storage/Auth へ接続（ログに出力）
- [ ] T003 Android/iOS のカスタムスキーム設定の検証
  - 対象: AndroidManifest の intent-filter、iOS Info.plist の URL Schemes
  - 成功条件: 端末で `fujii://invite?code=XXXX` がアプリに到達
- [ ] T004 [P] build_runner 設定の検証（codegen）
  - 実行: `fvm dart run build_runner build --delete-conflicting-outputs`
  - 成功条件: `*.g.dart`/`*.freezed.dart` が生成・最新

## Phase 3.2: Core 実装
- [ ] T005 Deep Link エラー時 UX 強化
  - 対象: `app/lib/main.dart`（失敗時の画面誘導）、`app/lib/presentation/screens/auth/invite_code_page.dart`（文言/再取得導線）
  - 成功条件: 無効/期限切れで明示的メッセージと再試行導線
- [ ] T006 InviteViewModel の成功/失敗ハンドリング拡充
  - 対象: `app/lib/presentation/viewmodels/auth/invite_view_model.dart`
  - 成功条件: 成功→遷移、失敗→状態が画面に伝播
- [ ] T007 Photo 追加時のメタデータ保存
  - 対象: 既存アップロードフロー（適切な Service/Repo 層）
  - 成功条件: `capturedAt` と `memo` が `userPhotos[]` に保存、既存スキーマ互換
- [ ] T008 画像アップロード サイズ/形式の制限なし運用
  - 対象: `firebase_storage` への受け入れ（失敗時のエラー表示のみ）
  - 成功条件: 形式不問で受理、OS/Storage 由来エラーのユーザ向け文言

 

## Phase 3.3: 共有メニュー経由アップロード（最小）
- [ ] T010 共有受信パッケージ導入の検討と選定
  - 候補: `receive_sharing_intent` など（iOS は Share Extension 必要・スコープ小）
  - 成功条件: iOS/Android 両方で単一画像を受け取り、アプリ起動→アップロードに繋げる方針確定
- [ ] T011 iOS 共有受信プロトタイプ（最小）
  - 対象: iOS ターゲット/設定追加が必要な場合は別ターゲット作成の是非を判断
  - 成功条件: 実機で共有→アプリへ連携し、アップロードフローに入る
- [ ] T012 Android 共有受信インテント対応（最小）
  - 対象: AndroidManifest の `SEND`/`SEND_MULTIPLE` intent-filter と受信コード
  - 成功条件: 共有→アプリへ連携し、アップロードフローに入る

## Phase 3.4: 仕上げ
- [ ] T013 [P] パフォーマンスとログの確認
  - 対象: `core/logger`, `PerfTimer`、アクセスログ量と頻度の調整
- [ ] T014 [P] ドキュメント整備
  - 対象: `specs/004-invitation-code-and/quickstart.md` 補足（深リンク起動手順/共有メニュー検証手順）
- [ ] T015 [P] 静的解析/整形のパス確認
  - 実行: `scripts/format.sh`（lib/ が必須・test/ は存在時のみ）
- [ ] T016 E2E 手動確認リスト（端末別）
  - iOS 実機/Android 実機での深リンク・ピッカー・共有メニューの最小検証

---

## 依存関係
- T001 → T002/T004
- T002 → T006/T007/T008（Emulator を用いる実装）
- T003 → T005（深リンク関連のUX）
- T004 → 生成物に依存する実装（InviteViewModel 等）
- T010 → T011/T012（選定後に各OS実装）
- 実装（T005-T012）→ 仕上げ（T013-T016）

## 並行実行（例）
- 実装フェーズ: T005（main.dart/画面）と T007（アップロードメタ）を並行可（別ファイル/別層）
- 共有メニュー: T011（iOS）と T012（Android）は別OSのため並行可

## 検証ゲート（実施のたびに）
- Build: `fvm flutter build` は不要（開発は `fvm flutter run`）
- Lint/Format: scripts/format.sh → PASS
- Smoke: 実機で深リンク・アップロード最小確認

## 仕様カバレッジ
- Deep Link（fujii://invite?code=XXXX）: T003, T005, T006
- ビューアー＝オーナーと同一スコープの参照（read-only）: 実装方針に反映（InviteViewModel/画面UX）
- 画像アップロード（アプリ内/共有メニュー）: T008, T010-T012
- メモ/capturedAt 保存: T007
- 通知/分析/モデレーションなし: 非対象（タスク化せず）
  

## 注意/前提（このリポジトリの制約に合わせた判断）
- Firestore Security Rules の厳密テストはエミュレータ前提の統合テスト（Dart）で代替。専用 Node ハーネスは追加しない。
- iOS 共有メニュー（Share Extension）はスコープ大のため「最小機能」から入り、検証後に拡張可。
- 既存スキーマを保持し、追加メタデータは配列要素（Photo）のフィールドのみに限定。

---

## 参考ファイル
- Contracts: `specs/004-invitation-code-and/contracts/deep-link.md`, `firestore-schemas.md`, `security-rules.md`, `storage-structure.md`
- Data Model: `specs/004-invitation-code-and/data-model.md`
- Quickstart: `specs/004-invitation-code-and/quickstart.md`

# Tasks: アカウント新規登録＋匿名閲覧（招待コード）

Feature Dir: `/specs/003-features-registration`  
Inputs: `plan.md`, `research.md`, `data-model.md`, `contracts/`（`auth.md`, `invites.md`, `albums.md`, `user_repository.md`）, `quickstart.md`  
Branch: `003-features-registration`

注: ユーザー要望により自動テスト作成は範囲外。品質確認は Quickstart の手動検証＋ログで実施。各タスクは具体的なファイル・変更内容を示し、[P] は並列可能（同一ファイルに触れない、依存なし）の目印です。

---
## Phase 3.1: Setup / 下準備（軽微）
- [ ] T001 依存関係の確認（変更なし想定）: `firebase_auth`, `cloud_firestore`, `firebase_core`, `flutter_riverpod`, `riverpod_annotation`, `auto_route` が `app/pubspec.yaml` に存在することを確認（不足あれば追記して `flutter pub get`）。ファイル: `app/pubspec.yaml`
- [ ] T002 [P] ログカテゴリの追加: 登録/匿名閲覧用のイベント関数を `AppLogger` に追加（`logRegisterStart/success/failure`, `logAnonymousStart/success/failure`）。ファイル: `app/lib/core/logger/logger.dart`

## Phase 3.2: Validation / ルール整備
- [ ] T003 入力バリデーション拡張: `AuthValidators` に `displayName`（非空）と `password`（最小8文字・簡易強度）を追加。ファイル: `app/lib/core/utils/validators/auth_validators.dart`

## Phase 3.3: Auth Service 拡張（登録 / 匿名）
- [ ] T004 `AuthService.register(displayName, email, password)` を追加。
  - createUserWithEmailAndPassword → currentUser.updateDisplayName(displayName)
  - Firestore: `users/{uid}` に `{ displayName, email, status: 'active', createdAt, updatedAt }` を作成
  - 失敗時: 例外をドメイン向けに正規化（日本語メッセージは VM/UI 層で対応可）
  - ファイル: `app/lib/data/services/auth_service.dart`
- [ ] T005 `AuthService.signInAnonymousWithCode(code)` を追加。
  - FirebaseAuth.signInAnonymously → Firestore で `invites/{code}` を get（存在・disabled=false・期限内を確認）
  - 任意: 監査用に `guestSessions/{viewerUid}` を作成 `{ code, albumOwnerUid, createdAt }`
  - 招待の `ownerUid` を返せる戻り値 or 結果型を整備（VM から遷移先決定に使用）
  - ファイル: `app/lib/data/services/auth_service.dart`

## Phase 3.4: User Service / Repository（Firestore 単一データソース）
- [ ] T006 ドメイン Entity: `UserEntity`（uid, email, displayName, status）を追加（freezed/json は任意、最小で可）。ファイル: `app/lib/domain/entities/user_entity.dart`
- [ ] T007 リポジトリIF: `UserRepository` を追加。
  - `Stream<UserEntity?> watchByUid(String uid);`
  - `Future<UserEntity?> getByUidOnce(String uid);`
  - `Future<void> updateDisplayName({required String uid, required String displayName});`（Firestore のみ更新）
  - ファイル: `app/lib/domain/repositories/user_repository.dart`
- [ ] T008 実装: `UserService` ＋ `UserRepositoryImpl` を追加。
  - UserService（Firestore 単一ソース）
    - `Stream<Map<String, dynamic>?> watchUserJson(String uid);`
    - `Future<Map<String, dynamic>?> getUserJsonOnce(String uid);`
    - ファイル: `app/lib/data/services/user_service.dart`
  - UserRepositoryImpl（Service の JSON を Entity にマッピング）
    - `watchByUid`/`getByUidOnce` を実装し、`UserEntity` を返す
    - `updateDisplayName` は Firestore の users/{uid}.displayName のみ更新
    - ファイル: `app/lib/data/repositories/user_repository_impl.dart`
- [ ] T009 [P] Provider 追加（各実装の直下に定義）:
  - `userServiceProvider` → `app/lib/data/services/user_service.dart` の実装の下に配置
  - `userRepositoryProvider` → `app/lib/data/repositories/user_repository_impl.dart` の実装の下に配置
  - `userByUidStreamProvider(uid)`（family）→ `app/lib/data/repositories/user_repository_impl.dart` の実装の下に配置

## Phase 3.5: ViewModel（登録 / 招待コード）
- [ ] T010 Register 用 VM 作成: 状態（idle/loading/error/success）と `submit()` 実装。`AuthService.register` を呼び、成功でホームへ遷移。ファイル: `app/lib/presentation/viewmodels/auth/register_view_model.dart`
- [ ] T011 Invite 用 VM 作成: 状態と `submit(code)` 実装。`AuthService.signInAnonymousWithCode` を呼び、返却された `ownerUid` と現在月をもとにカレンダーへ遷移。ファイル: `app/lib/presentation/viewmodels/auth/invite_view_model.dart`

## Phase 3.6: Router / 画面
- [ ] T012 ルーター更新: `RegisterRoute`, `InviteCodeRoute` を追加（`auto_route`）。ファイル: `app/lib/presentation/router/app_router.dart`
- [ ] T013 [P] 画面: `RegisterPage` 作成（名前/メール/パスワード入力、バリデーション、日本語エラー表示）。ファイル: `app/lib/presentation/screens/auth/register_page.dart`
- [ ] T014 [P] 画面: `InviteCodePage` 作成（招待コード入力、日本語エラー表示）。ファイル: `app/lib/presentation/screens/auth/invite_code_page.dart`
- [ ] T015 Login 画面更新: 「新規登録」「招待コードで閲覧」ボタンを追加し、それぞれの Route に遷移。ファイル: `app/lib/presentation/screens/auth/login_page.dart`
- [ ] T016 ルート生成: build_runner を実行して `app_router.gr.dart` を更新（コマンド実行）。

## Phase 3.7: フロー統合 / 遷移
- [ ] T017 登録成功時の遷移: `RegisterViewModel` 成功 → `MonthCalendarRoute()`（自分の `uid`、現在月）。ファイル: `app/lib/presentation/viewmodels/auth/register_view_model.dart`
- [ ] T018 招待成功時の遷移: `InviteViewModel` 成功 → `MonthCalendarRoute(ownerUid: invite.ownerUid, month: now)`（読み取り専用前提）。ファイル: `app/lib/presentation/viewmodels/auth/invite_view_model.dart`
- [ ] T019 [P] ログ呼び出し: Register/Anonymous の start/success/failure を各 VM/Service から `AppLogger` へ出力。ファイル: `app/lib/core/logger/logger.dart`, `app/lib/data/services/auth_service.dart`, `app/lib/data/services/user_service.dart`, `app/lib/presentation/viewmodels/auth/*`

## Phase 3.8: 権限制御（設計整合の確認）
- [ ] T020 Firestore 読み取り: 匿名ユーザーでも `users/{ownerUid}/calendar/{MM}` を参照可能な想定で、アプリ側は編集 UI を無効化（既存 UI の編集操作は登録ユーザー限定）。コード変更は UI の表示制御のみで可。ファイル: `app/lib/presentation/screens/calendar/*`（必要箇所のみ）
- [ ] T021 invites の参照: list 禁止 / get のみ利用という前提で、`AuthService.signInAnonymousWithCode` 内の実装方針をコメントで明示。ファイル: `app/lib/data/services/auth_service.dart`

## Phase 3.9: ドキュメント / 手動検証
- [ ] T022 Quickstart 更新: 招待コード閲覧の手順に画面名・遷移先・失敗時メッセージ例を追記。ファイル: `specs/003-features-registration/quickstart.md`
- [ ] T023 [P] contracts/auth.md 追記（任意・軽微）: `users/{uid}` 作成は登録フロー内で行い、以後の同期待ちは UserRepository で吸収する旨の注釈を1行追記。ファイル: `specs/003-features-registration/contracts/auth.md`
- [ ] T024 [P] README 追記（任意）: 新規登録/匿名閲覧の概要と起動手順リンクを追加。ファイル: `README.md`

---
## 依存関係 / 並列性
- T001 →（不足があれば）T004/T005 に影響
- T002（Logger）は他と独立 [P]
- T003 → T010/T011/T013/T014（UI 入力検証）
- T004/T005 → T010/T011（VM から呼び出し）
- T006/T007 → T008 → T009 （Repository → Provider）
- T012 → T016（ルート生成）
- T012/T013/T014/T015 → T016（画面とルートの追加後に生成）
- T017/T018 は VM 実装完了後
- T020/T021 はサービス/画面実装と独立気味（コメント/表示制御）
- ドキュメント系（T022-T024）は実装後に並列 [P]

---
## 並列実行例
```
# 初期並列
T002（Logger） & T003（Validators） & T006（User Entity） & T007（UserRepository IF）

# サービス/VM 側
T004（register 実装） → T010（Register VM） → T013（RegisterPage）
T005（anonymous 実装） → T011（Invite VM） → T014（InviteCodePage）

# ルーター/UI 側
T012（ルート追加） → T015（Login 画面更新） → T016（コード生成）

# 仕上げ
T019（ログ呼び出し） & T020（UI表示制御） & T021（コメント） & T022-T024（ドキュメント）
```

---
## Validation Checklist（テスト省略版）
- [ ] 画面: Login に「新規登録」「招待コードで閲覧」ボタンが表示され、遷移できる（T012〜T016）
- [ ] 登録: 入力バリデーション 日本語表示／重複メールは上書き不可でエラー（T003, T004, T013）
- [ ] 登録成功後に自分のカレンダーへ遷移（T017）
- [ ] 招待: 無効コード/期限切れ/disabled は日本語エラー（T005, T014）
- [ ] 招待成功後に `ownerUid` のカレンダーを閲覧でき、編集不可（T018, T020）
- [ ] ログ: register/anonymous の開始・成功・失敗が出力される（T002, T019）
- [ ] Quickstart/README が更新され、手動手順が再現できる（T022, T024）

---
備考:
- Firestore セキュリティルールは別レポジトリ/環境前提。アプリ側は設計整合（list 禁止・get 参照）と UI 表示制御に留める。
- DisplayName 更新（UserRepository.updateDisplayName）は将来拡張用。今回の UI からは呼ばない。

（Generated by tasks for feature 003-features-registration; tests intentionally omitted per request）

# Feature Plan: 招待コード作成機能（Functions なし）

**Feature Branch**: `007-create-invitation`
**Created**: 2025-09-13
**Status**: Plan
**Inputs**:
- invites 設計: `specs/003-features-registration/contracts/invites.md` / `infra/app/docs/invites.md`
- 既存アプリ構成: `presentation / providers / domain / data / core`
- 既存閲覧フロー: `InviteViewModel`＋`AuthService.signInAnonymousWithCode`

---

## 目的 / スコープ
- 登録ユーザー（オーナー）がアプリ内から「閲覧専用の招待コード」を新規発行し、共有できるようにする。
- 作成されたコードは `invites/{code}` に保存（ownerUid, disabled=false, expiresAt?, createdAt）。
- 最小構成（Cloud Functions 不使用・list 禁止）。コード列挙や使用回数管理は行わない（invites.md 準拠）。

非スコープ:
- 発行済み一覧/検索、使用回数集計、QR生成の画像保存、月単位スコープの制御、HTTPS ディープリンクの配布管理。

---

## 画面/UX（最小）
- 入口: ログイン済み（非匿名）ユーザー向けに「招待を作成」導線を追加。
  - 暫定配置: `MonthPage` の AppBar メニュー「…」→「招待を作成」。
- モーダル（`InviteCreatePage`）
  - ボタン「新しい招待コードを作成」→ 成功時にコードと共有用 URL を表示。
  - 表示: `CODE`, `fujii://invite/{CODE}`、コピー、共有シート（可能なら）。
  - 任意入力: 有効期限（日付ピッカー/プリセット: なし/7日/30日）。
  - エラーは日本語で簡潔表示。

---

## アーキテクチャ（層別）

### domain
- Entity: `InviteEntity`
  - `code: String`
  - `ownerUid: String`
  - `disabled: bool`（default: false）
  - `expiresAt: DateTime?`
  - `createdAt: DateTime?`（server 時刻は Nullable として保持）
- Repository IF: `InviteRepository`
  - `Future<InviteEntity> create({required String ownerUid, DateTime? expiresAt, int length = 8, int maxRetry = 5})`
  - `Future<InviteEntity?> getByCode(String code)`（衝突確認・デバッグ用）
  - `Future<void> disable(String code)`（将来用。今回実装は任意）
- Usecase: `CreateInviteUsecase`
  - 上記 Repository を呼び出し、成功時に `InviteEntity` を返す。

### data
- Service: `InviteService`（Firestore 直接アクセス）
  - `Future<bool> exists(String code)` → `invites/{code}` の存在チェック（get のみ）
  - `Future<void> put({required String code, required String ownerUid, bool disabled=false, DateTime? expiresAt})`
  - `Future<Map<String, dynamic>?> getJson(String code)`
- Repository 実装: `InviteRepositoryImpl`
  - コード生成 → `exists(code)` 衝突チェック → `put(...)`。衝突時は `maxRetry` まで再生成。
  - 生成アルゴリズムは core のユーティリティへ分離。

### core
- Util: `generateInviteCode({int length = 8, String alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'})`
- Logger 拡張（必要最小）
  - `logInviteCreateStart({required String ownerUid})`
  - `logInviteCreateSuccess({required String ownerUid, required String code})`
  - `logInviteCreateFailure({required String ownerUid, required Object error})`

### providers（DI）
- `inviteServiceProvider`（`firestoreProvider` を注入）
- `inviteRepositoryProvider`（Service を注入）
- `createInviteUsecaseProvider`

### presentation
- ViewModel: `InviteCreateViewModel`
  - 状態: `idle / creating / error(message) / success(entity)`（Freezed）
  - `create({DateTime? expiresAt, int length = 8})`
- Page: `InviteCreatePage`
  - `ConsumerWidget`（モーダル）。成功後はコードを強調表示しコピー/共有導線。

---

## Firestore 書き込み仕様
- コレクション: `invites`
- ドキュメントID: `code`（英大字＋数字, I/O/1/0 を除外）
- フィールド
  - `ownerUid: string`
  - `disabled: bool`（省略時 false）
  - `expiresAt: Timestamp?`
  - `createdAt: serverTimestamp()`
- ルール前提（既存）
  - `invites` は get のみ一般許可、write は「管理者」または「オーナー本人（ownerUid==auth.uid）」に許可。

---

## 例外/バリデーション
- 未ログイン/匿名ユーザー → 作成不可（UI 入口を非表示、VM でもガード）
- 衝突: `exists(code)==true` → 再生成（`maxRetry`）。超過時は UI に「再試行してください」。
- 有効期限: クライアント側では `DateTime.now()` と比較して過去日時は不可。

---

## 実装ファイル（案）
- domain
  - `app/lib/domain/entities/invite_entity.dart`
  - `app/lib/domain/repositories/invite_repository.dart`
  - `app/lib/domain/usecases/create_invite_usecase.dart`
- data
  - `app/lib/data/services/invite_service.dart`
  - `app/lib/data/repositories/invite_repository_impl.dart`
- core
  - `app/lib/core/utils/invite_code_generator.dart`
  - `app/lib/core/logger/logger.dart`（メソッド追加）
- presentation
  - `app/lib/presentation/viewmodels/auth/invite_create_view_model.dart`
  - `app/lib/presentation/screens/auth/invite_create_page.dart`
  - 入口導線: `app/lib/presentation/screens/calendar/month_page.dart`（メニュー追加）
- providers
  - `app/lib/providers/firebase_providers.dart`（既存）
  - 新規 Provider は各ファイルで `riverpod_annotation` により生成

---

## 主要インターフェース（シグネチャ）
```dart
// core/utils/invite_code_generator.dart
String generateInviteCode({int length = 8, String alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'});

// domain/entities/invite_entity.dart
class InviteEntity {
  final String code;
  final String ownerUid;
  final bool disabled;
  final DateTime? expiresAt;
  final DateTime? createdAt;
  // const コンストラクタ + fromJson/toJson は任意
}

// domain/repositories/invite_repository.dart
abstract class InviteRepository {
  Future<InviteEntity> create({required String ownerUid, DateTime? expiresAt, int length = 8, int maxRetry = 5});
  Future<InviteEntity?> getByCode(String code);
  Future<void> disable(String code);
}

// data/services/invite_service.dart
class InviteService {
  Future<bool> exists(String code);
  Future<void> put({required String code, required String ownerUid, bool disabled = false, DateTime? expiresAt});
  Future<Map<String, dynamic>?> getJson(String code);
}

// domain/usecases/create_invite_usecase.dart
class CreateInviteUsecase {
  Future<InviteEntity> call({DateTime? expiresAt, int length = 8});
}

// presentation/viewmodels/auth/invite_create_view_model.dart
@freezed class InviteCreateState { /* idle / creating / error / success */ }
class InviteCreateViewModel extends _$InviteCreateViewModel {
  Future<void> create({DateTime? expiresAt, int length = 8});
}
```

---

## 共有 URL / 表示
- 共有用 URI: `fujii://invite/{CODE}`（既存 Deep Link ハンドラに合流）。
- UI ではコード文字列と URI のコピー/共有（OS 共有シート）を提供。

---

## テレメトリ（ログ）
- 追加 API（`AppLogger`）
  - `invite_create_start` / `invite_create_success` / `invite_create_failure`
- VM/Repository/Service の各層で適宜ログを出力し、失敗時は `error` にも送る。

---

## 作業手順（タスク）
1) core: `invite_code_generator.dart` 追加
2) domain: `InviteEntity` / `InviteRepository` 追加
3) data: `InviteService` / `InviteRepositoryImpl` 実装＋Provider 生成
4) domain: `CreateInviteUsecase` 実装＋Provider 生成
5) core: `AppLogger` に招待作成ログ API 追加
6) presentation: `InviteCreateViewModel` 実装（Freezed/riverpod）
7) presentation: `InviteCreatePage` 追加（モーダル）
8) UI 導線: `MonthPage` にメニュー追加（非匿名のみ表示）
9) ビルド/解析/テスト

---

## 実行コマンド
```sh
cd app
fvm install 3.32.0 && fvm use 3.32.0 --force
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter analyze
```

---

## 受け入れ基準（最小）
- ログイン済みユーザーが 1 タップでコードを作成でき、`invites/{code}` に想定スキーマで書き込まれる。
- 生成直後にコードと `fujii://invite/{CODE}` を UI で確認・コピーできる。
- 無効な状態（匿名ユーザー/未ログイン）では入口が表示されない。
- 重複衝突時に自動再試行し、上限超過ならユーザーへ再試行を促す。

---

## ロールバック
- UI 導線を無効化（メニュー非表示）。
- `InviteRepositoryImpl.disable(code)` を実装済みなら、誤配布コードを `disabled=true` で即時無効化。

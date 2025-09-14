# Feature Plan: 閲覧者→被撮影者 リクエスト機能（最小実装）

**Feature Branch**: `006-requests`
**Created**: 2025-09-14
**Status**: Plan

---

## 目的 / スコープ
- 閲覧者（匿名可）が、被撮影者（オーナー）に「コメント付きリクエスト」を送信できる。
- 被撮影者のアプリはリアルタイムで受信し、画面上に通知（バッジ/スナックバー）を表示する。
- データは Firestore の Users 配下サブコレクションで管理。
- 最小構成（Cloud Functions／Push 通知は範囲外）。

非スコープ:
- Push 通知（FCM）、メール通知
- モデレーション/通報、添付画像
- 複雑なスレッド/返信UI（今回は単方向の「受信一覧＋既読」まで）

---

## ユースケース
- 閲覧者: 招待コードで匿名閲覧 → 画面の「リクエスト」からコメント送信。
- 被撮影者: アプリ起動/前面でリアルタイム受信。バッジ件数や一覧で確認し、既読化する。

---

## データモデル（Firestore）
- コレクション: `users/{ownerUid}/requests/{requestId}`
  - `requesterUid: string`（送信者の `auth.uid`。匿名）
  - `comment: string`（最大 500 文字想定）
  - `createdAt: Timestamp`（serverTimestamp）

表示ポリシー:
- 既読管理（status/readAt）は行わない。
- 「作成から一定日数（例: 14日）」は一覧に表示する。
- アプリ側で `now - createdAt <= retentionDays` の条件で絞り込み表示。
- 任意で `expiresAt` を保存してもよいが、最小構成では `createdAt` のみで十分。

ID 生成: クライアント側で `doc().id`（衝突リスク低）。

---

## Firestore ルール（方針）
- `invites.md` の `canView(ownerUid)` 相当を再利用し、「閲覧権限を持つユーザーのみ create 可能」にする。
- オーナー（`auth.uid == ownerUid`）と管理者は read/update（既読化/整理）可能。閲覧者は create のみ。
- 例（擬似）:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{db}/documents {
    function isAdmin() { return request.auth != null && request.auth.token.role == 'admin'; }
    function canView(ownerUid) {
      return request.auth != null &&
             exists(/databases/$(db)/documents/guestSessions/$(request.auth.uid)) &&
             get(/databases/$(db)/documents/invites/(
               get(/databases/$(db)/documents/guestSessions/$(request.auth.uid)).data.code
             )).data.ownerUid == ownerUid &&
             !(get(/databases/$(db)/documents/invites/(
               get(/databases/$(db)/documents/guestSessions/$(request.auth.uid)).data.code
             )).data.disabled == true);
    }

    match /users/{ownerUid}/requests/{rid} {
      allow create: if canView(ownerUid)
        && request.resource.data.requesterUid == request.auth.uid
        && request.resource.data.keys().hasOnly(['requesterUid','comment','createdAt']);

      allow read: if request.auth != null && (request.auth.uid == ownerUid || isAdmin());

      // 既読管理をしないため update は不要。必要なら削除のみ許可。
      allow delete: if request.auth != null && (request.auth.uid == ownerUid || isAdmin());
    }
  }
}
```

---

## アーキテクチャ（層別）

### Domain
- Entity: `RequestEntity`
  - `id, ownerUid, requesterUid, comment, createdAt`
- Repository IF: `RequestRepository`
  - `Future<void> submit({required String ownerUid, required String comment})`
  - `Stream<List<RequestEntity>> watchRecent({required String ownerUid, int retentionDays = 14})`
  - （任意）`Future<void> delete({required String ownerUid, required String requestId})`

- Service: `RequestsService`
  - `Future<void> addRequest(...)`（`users/{ownerUid}/requests` に `set`）
  - `Stream<List<Map<String,dynamic>>> watchRecent(ownerUid, {retentionDays})`
  - （任意）`Future<void> delete(ownerUid, rid)`
- Mapper: `request_mappers.dart`（JSON ⇄ Entity）
- Repository 実装: `RequestRepositoryImpl`（Service + Mapper）

### UseCase
- `SubmitRequestUsecase`（閲覧者側）
- `WatchRecentRequestsUsecase`（被撮影者側）

### Providers（DI）
- 各 Service/Repository/UseCase 直下に `@Riverpod` で Provider 自動生成。

---

## 画面 / UX（最小）
- 閲覧者（read-only モード表示時）
  - `MonthCalendarPage` AppBar に「リクエスト」ボタン（吹き出しアイコン）を追加。
  - タップで `RequestDialog`（`TextField` + 送信）。成功時にスナックバー。
- 被撮影者（通常ログイン時）
  - AppBar に「リクエスト」アイコン＋未読件数バッジ。
  - `RequestsListPage` で一覧表示、個別に「既読」操作。
  - 受信時にスナックバー（前面時）。

---

## 主要 I/F（シグネチャ例）
```dart
// domain/entities/request_entity.dart
class RequestEntity { /* fields as above */ }

// domain/repositories/request_repository.dart
abstract class RequestRepository {
  Future<void> submit({required String ownerUid, required String comment});
  Stream<List<RequestEntity>> watchRecent({required String ownerUid, int retentionDays = 14});
  Future<void> delete({required String ownerUid, required String requestId});
}

// data/services/requests_service.dart
class RequestsService {
  Future<void> addRequest({required String ownerUid, required Map<String, dynamic> json});
  Stream<List<Map<String, dynamic>>> watchRecent({required String ownerUid, int retentionDays = 14});
  Future<void> delete({required String ownerUid, required String requestId});
}
```

---

## 実装ファイル（案）
- Domain
  - `app/lib/domain/entities/request_entity.dart`
  - `app/lib/domain/repositories/request_repository.dart`
  - `app/lib/domain/usecases/submit_request_usecase.dart`
  - `app/lib/domain/usecases/watch_incoming_requests_usecase.dart`
  - `app/lib/domain/usecases/mark_request_read_usecase.dart`
- Data
  - `app/lib/data/services/requests_service.dart`
  - `app/lib/data/mappers/request_mappers.dart`
  - `app/lib/data/repositories/request_repository_impl.dart`
- Presentation（最小）
  - `app/lib/presentation/screens/requests/requests_list_page.dart`
  - `app/lib/presentation/screens/requests/widgets/request_dialog.dart`
  - 入口: `MonthCalendarPage` の AppBar にアイコン追加（閲覧者/被撮影者で表示切替）

---

## フロー（擬似コード）
- 閲覧者送信:
```
final auth = ref.read(authServiceProvider);
final ownerUid = await auth.resolveOwnerUidForCurrentAnonymous();
await ref.read(submitRequestUsecaseProvider)(ownerUid: ownerUid, comment: text);
```
- 被撮影者受信:
```
ref.watch(watchRecentRequestsUsecaseProvider(ownerUid)).listen((list) {
  // バッジ更新、スナックバー表示など
});
```

---

## 作業手順（チェックリスト）
1) Domain: Entity/Repository IF/UseCases 追加
2) Data: Service/Mapper/Repository 実装 + Provider 生成
3) Presentation: 送信ダイアログ + 受信一覧（最小）
4) MonthCalendarPage の AppBar にアイコン追加（匿名＝送信、被撮影者＝受信）
5) Firestore ルール更新（`users/{ownerUid}/requests` セクション追加）
6) codegen & 解析: `fvm dart run build_runner build --delete-conflicting-outputs` / `fvm flutter analyze`

---

## 受け入れ基準
- 閲覧者がコメントを送信すると `users/{ownerUid}/requests/{id}` に保存される。
- 被撮影者が即時に受信し、一覧・バッジで確認できる。
- リクエストは「作成から一定日数（例: 14日）」表示される（既読操作なし）。
- 閲覧者は他人のリクエストを読めず、被撮影者のみが自分宛てのリクエストを閲覧できる。

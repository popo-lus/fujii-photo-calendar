# 005: Device Calendar 連携（取得専用）仕様

## 目的 / スコープ
- 端末内のカレンダーとイベント情報を「取得のみ」で扱う機能を追加する。
- パッケージは `device_calendar` を採用（最新安定版を利用）。
- 取得結果は Domain の Entity に正規化し、Repository/Service/Provider 経由で Presentation から利用できるようにする。
- 非スコープ（今回含めない）:
  - 予定の作成/更新/削除（書き込み系）
  - 通知/リマインダー設定
  - Web/デスクトップ対応（未対応端末では無効化/ガード）

## 参考: 既存アーキテクチャに合わせたレイヤ構成
- Domain: Entity / Repository IF / Usecase
- Data: Service（外部パッケージ境界）/ Mapper / Repository 実装
- Providers: Riverpod による DI（`@Riverpod` で codegen）
- Presentation: なし（本チケットでは UI/VM は対象外）

## 追加する主な型
- Domain/Entities
  - `DeviceCalendarEntity { id, name, accountName, isReadOnly }`
  - `DeviceEventEntity { id, calendarId, title, description, location, start, end, isAllDay }`
- Domain/Repositories（IF）
  - `DeviceCalendarRepository`
    - `Future<bool> ensurePermission()`
    - `Future<List<DeviceCalendarEntity>> fetchCalendars({ bool onlyWritable = false })`
    - `Future<List<DeviceEventEntity>> fetchEvents({ required String calendarId, required DateTime start, required DateTime end })`
- Domain/Usecases
  - `EnsureCalendarPermissionUsecase`
  - `LoadDeviceCalendarsUsecase`
  - `LoadDeviceEventsInRangeUsecase`
- Data/Service
  - `DeviceCalendarService`（`device_calendar` の `DeviceCalendarPlugin` を内包）
    - `Future<bool> hasPermissions()`
    - `Future<bool> requestPermissions()`
    - `Future<List<Calendar>> retrieveCalendars({ bool onlyWritable = false })`
    - `Future<List<Event>> retrieveEvents(String calendarId, DateTime start, DateTime end)`
- Data/Mappers
  - `device_calendar_mappers.dart`（Plugin の `Calendar`/`Event` → Domain Entity 変換）
- Data/Repositories（Impl）
  - `DeviceCalendarRepositoryImpl`（Service + Mapper を使用）
- Providers（Riverpod）
  - `deviceCalendarServiceProvider`
  - `deviceCalendarRepositoryProvider`
  - 備考: Service/Repository の各クラス定義の直下に Provider を記述（他の Service/Repository と同様の配置）。

## プラットフォーム設定
- 依存追加（`app/pubspec.yaml`）
  - `dependencies:` に `device_calendar: ^x.y.z`（導入時点の安定版。導入時に実際のバージョンを確定）
- iOS（`app/ios/Runner/Info.plist`）
  - `NSCalendarsUsageDescription` を追加（例: `カレンダーの予定を表示するために使用します`）
- Android（`app/android/app/src/main/AndroidManifest.xml`）
  - 読み取り権限のみ付与（書き込みは非スコープ）
    - `<uses-permission android:name="android.permission.READ_CALENDAR"/>`
  - ランタイム権限はアプリ側で要求（Usecase 経由で `requestPermissions()` を実行）
- 非対応プラットフォーム（Web/デスクトップ）
  - Service 内でガードし、`false`/空配列を返すか、明示的に `UnsupportedError` を domain エラーに正規化

## エラーハンドリング方針
- Repository/Usecase は `Result<T>` を返却（成功: `Success<T>` / 失敗: `Failure<T>`）。
- 権限未許可 → `ensurePermission()` が `Success(false)` を返却。Presentation はダイアログ/トーストで誘導。
- 端末にカレンダー無し/対象期間にイベント無し → 空コレクション返却（正常系）。
- 予期せぬ例外（プラグイン例外・プラットフォーム未対応） → `core/result` に合わせて `Result.failure` 相当へ正規化（既存パターンに準拠）。

## 実装詳細（ファイル設計）
- Domain
  - `app/lib/domain/entities/device_calendar_entity.dart`
  - `app/lib/domain/entities/device_event_entity.dart`
  - `app/lib/domain/repositories/device_calendar_repository.dart`
  - `app/lib/domain/usecases/ensure_calendar_permission_usecase.dart`
  - `app/lib/domain/usecases/load_device_calendars_usecase.dart`
  - `app/lib/domain/usecases/load_device_events_in_range_usecase.dart`
- Data
  - `app/lib/data/services/device_calendar_service.dart`
  - `app/lib/data/mappers/device_calendar_mappers.dart`
  - `app/lib/data/repositories/device_calendar_repository_impl.dart`
- Providers（配置方針）
  - Service/Repository は各ファイル内でクラス定義の直下に `@Riverpod(keepAlive: true)` な Provider を定義
  - Usecase も各クラス直下に `@Riverpod()` な Provider を定義（codegen 使用）

<!-- Presentation は今回スコープ外のため定義しない -->

## 呼び出し例

### Usecase Provider 経由（推奨 / Result 型）
```dart
final perm = await ref.read(ensureCalendarPermissionUsecaseProvider).call();
final granted = perm.fold(
  onSuccess: (v) => v,
  onFailure: (e, _) => false,
);
if (!granted) return; // 権限未許可のUI誘導など

final calendarsRes = await ref.read(loadDeviceCalendarsUsecaseProvider).call();
final calendars = calendarsRes.fold(
  onSuccess: (l) => l,
  onFailure: (e, st) => const <DeviceCalendarEntity>[],
);

final eventsRes = await ref.read(loadDeviceEventsInRangeUsecaseProvider).call(
  calendarId: calendars.first.id,
  start: rangeStart,
  end: rangeEnd,
);
final events = eventsRes.fold(
  onSuccess: (l) => l,
  onFailure: (e, st) => const <DeviceEventEntity>[],
);
```

### Repository を直接利用（低レベルAPI / Result 型）
```dart
final repo = ref.read(deviceCalendarRepositoryProvider);
final perm = await repo.ensurePermission();
if (!perm.isSuccess || perm.data != true) return;

final calendarsRes = await repo.fetchCalendars();
final calendars = calendarsRes.data ?? const [];

final eventsRes = await repo.fetchEvents(
  calendarId: calendars.first.id,
  start: rangeStart,
  end: rangeEnd,
);
final events = eventsRes.data ?? const [];
```

## 実装手順（チェックリスト）
1) 依存追加: `device_calendar` を `pubspec.yaml` に追加 → `fvm flutter pub get`
2) iOS/Android の権限設定を追加（Info.plist / AndroidManifest.xml）
3) Domain: Entity/Repository IF/Usecase を追加
4) Data: Service（Plugin ラッパー）/Mapper/Repository Impl を追加
5) Providers: 各 Service/Repository/Usecase ファイル内で Provider 定義 → `fvm dart run build_runner build --delete-conflicting-outputs`
6) 静的解析・整形: `../scripts/format.sh` を `app/` で実行

## テスト
- 本チケットでは追加しない（将来必要になれば別タスクで実施）。

## 依存・注意事項
- CI/ローカルともに FVM `3.32.0` を使用。
- 生成コード（`*.g.dart`）は本 PR で含める（`build_runner` 実行）。
- 非対応プラットフォームでは機能を隠すか、ボタン非活性 + トーストで案内。

## 今後の拡張（非スコープ）
- 書き込み系（イベント追加/更新/削除）と双方向同期
- フィルタ/検索、終日/繰り返し、参加者詳細の拡張
- 予定と写真/スライドショーの連携（期間マッチング等）

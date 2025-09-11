# Tasks: 月カレンダー閲覧（メインページ）

**Feature Dir**: `/specs/001-features-main-page`  
**Inputs**: `plan.md`, `research.md`, `data-model.md`, `contracts/` (`openapi.yaml`, `firestore-schema.md`)  
**Project Type**: Flutter (mobile + Firebase BaaS)  
**Architecture**: core / domain / data / presentation / providers

本バージョンではユーザー要望により「自動テスト関連タスク (契約テスト / インテグレーションテスト / ユニットテスト)」を全て削除。品質確認は手動 Quickstart 手順とログ/計測ユーティリティで行う前提。将来テスト導入を容易にするため構造 (Result, 分離レイヤ, Provider DI) は維持。

---
## Task Ordering Rationale (テスト除外版)
1. Setup: プロジェクト基盤・依存追加・静的解析
2. Core/Model: Result, 例外, Entity, Mapper
3. Data: Service → Repository
4. Domain: UseCase 群
5. Providers: DI 配線
6. ViewModel: UI 状態管理
7. UI: ルーター・画面・ウィジェット
8. Integration: 初期化/キャッシュ/ログ/パフォーマンス計測
9. Polish: ドキュメント、Lint、パフォーマンス記録、リリースノート

`[P]` は依存せず別ファイルを編集できる並列候補。

---
## Phase 3.1: Setup
- [x] T001 Flutter プロジェクト生成 `flutter create . --project-name fujii_photo_calendar`（既存不要ファイルあれば整理）
- [x] T002 pubspec.yaml 依存追加 (auto_route, auto_route_generator, flutter_riverpod, freezed, json_serializable, build_runner, cached_network_image, firebase_core, cloud_firestore, firebase_storage, meta, collection) ※ firebase_* は `flutterfire configure` でも追加され得るが明示列挙
- [x] T003 [P] Flutter SDK バージョン固定 `fvm use <FLUTTER_VERSION> --force` + `.fvm/fvm_config.json` をコミット（後続全コマンドは `fvm flutter ...` 推奨コメント追記）
- [x] T004 [P] Freezed / JsonSerializable / build_runner 設定 (`dev_dependencies` 追記 + `build.yaml` 雛形) および `dart run build_runner build --delete-conflicting-outputs` 初回実行（結果は未コミットでも可）
- [x] T005 [P] FlutterFire 設定 `flutterfire configure` 実行（ターゲット Firebase プロジェクト選択→ `lib/firebase_options.dart` 生成→ `main.dart` に `Firebase.initializeApp` 追記）
- [x] T006 Lint & formatter 設定 (`analysis_options.yaml` recommended + 将来 import_lint 予告コメント) + `make format` / `scripts/format.sh` 雛形（任意）
- [x] T007 CI ワークフロー下書き `.github/workflows/ci.yaml` (fvm セットアップ → flutter pub get → analyze → build_runner build)

## Phase 3.2: Core / Model Implementation
- [x] T007 `core/result/result.dart` Result<T> 実装 (success/error, map, flatMap)
- [x] T008 [P] 例外階層 `core/error/app_exceptions.dart` (NetworkException, DecodeException, EmptyPhotoSetException, AdminExposureViolation)
- [x] T009 PhotoEntity (freezed + json) `lib/domain/entities/photo_entity.dart`
- [x] T010 [P] Photo マッピング関数 `lib/data/mappers/photo_mapper.dart` (Firestore Map→Entity, priority/monthKey 派生)

## Phase 3.3: Data Layer
- [x] T011 Firestore Service `lib/data/services/calendar_service.dart` (uid+month で fujii & user 取得)
- [x] T012 Repository Interface `lib/domain/repositories/calendar_repository.dart` (loadMonthPhotos)
- [x] T013 Repository 実装 `lib/data/repositories/calendar_repository_impl.dart` (Service 呼出 + Mapper + メモリキャッシュ + 単回リトライ)

## Phase 3.4: Domain UseCases
- [ ] T014 UseCase: 月写真ロード `lib/domain/usecases/load_month_photos_usecase.dart`
- [ ] T015 UseCase: スライドショーバッチ計算 `lib/domain/usecases/compute_slideshow_batch_usecase.dart`
- [ ] T016 UseCase: Admin 露出保証 `lib/domain/usecases/ensure_admin_exposure_usecase.dart`

## Phase 3.5: Providers (DI Wiring)
- [ ] T017 Provider 定義 `lib/providers/calendar_providers.dart` (firestore, service, repository, usecases, viewmodel)

## Phase 3.6: ViewModel
- [ ] T018 Month ViewModel `lib/presentation/viewmodels/calendar/month_view_model.dart` (UI State sealed, ロード/スワイプ/スライドショー制御)

## Phase 3.7: UI Layer
- [ ] T019 ルーター設定 `lib/presentation/router/app_router.dart` (auto_route: MonthCalendarRoute)
- [ ] T020 月ページスクリーン `lib/presentation/screens/calendar/month_page.dart`
- [ ] T021 [P] カレンダーグリッド `lib/presentation/screens/calendar/widgets/month_grid.dart`
- [ ] T022 [P] スライドショー `lib/presentation/screens/calendar/widgets/photo_slideshow.dart`
- [ ] T023 [P] 空月プレースホルダー `lib/presentation/screens/calendar/widgets/empty_month_placeholder.dart`

## Phase 3.8: Integration / Infrastructure
- [ ] T024 Firestore 初期化 & 起動ログ `lib/main.dart`
- [ ] T025 キャッシュ設定 `lib/core/utils/cache_config.dart` (cached_network_image カスタム CacheManager)
- [ ] T026 ロギング/メトリクス `lib/core/logger/logger.dart` (初回描画/スワイプ/露出イベント記録 API)
- [ ] T027 パフォーマンス計測ラッパー `lib/core/utils/perf_timer.dart`

## Phase 3.9: Polish
- [ ] T028 Import 依存グラフ lint 雛形 `import_lint.yaml`
- [ ] T029 README 更新 (アーキ構成 & 実行手順反映)
- [ ] T030 Quickstart 手動検証セクション追記 `specs/001-features-main-page/quickstart.md` (計測ログ活用方法)
- [ ] T031 初期パフォーマンス記録 `docs/perf/initial-benchmark.md`
- [ ] T032 Dead code / 重複削減最終パス
- [ ] T033 リリースノートドラフト `CHANGELOG.md`

---
## Dependencies
- T001 → (T002,T003,T005)
- T002 → (T004,T011)  # 依存追加後にコード生成/Service 実装が可能
- T003 → (T004,T005,T007)  # fvm 固定後に他コマンド統一
- T004 → (T007..T010,T011)  # コード生成と Lint 設定後に Core 実装開始
- T005 → (T024)  # firebase_options.dart 生成後に main 初期化強化
- T007 (Result) → T011 以降
- T009 (Entity) → T010, T011, T012, T013, T014
- T010 → T013, T014
- T011 → T013
- T012 → T013 → T014
- T014 → T015, T016, T018
- T015/T016 → T018
- T017 (Providers) → T018 → (T019-T023)
- T024/25/26/27 完了後 Quickstart 手動検証
- Polish (T028-T033) は全実装後

---
## Parallel Execution Examples
Core 早期並列:
```
Task: "T008 例外階層定義"
Task: "T010 Photo マッピング関数"
```
UI ウィジェット並列:
```
Task: "T021 カレンダーグリッド"
Task: "T022 スライドショー"
Task: "T023 空月プレースホルダー"
```
Polish 並列:
```
Task: "T028 import_lint 雛形"
Task: "T029 README 更新"
Task: "T031 初期パフォーマンス記録"
```

---
## Validation Checklist (テスト除外方針)
- [ ] テスト関連タスクが存在しないことを確認
- [ ] 各タスクが一意ファイル/目的を明示
- [ ] 依存チェーンが Core→Data→Domain→Providers→ViewModel→UI→Integration→Polish 順を維持
- [ ] `[P]` タスクは同一ファイル競合なし
- [ ] 将来テスト導入用に責務分離構造を保持

---
## Notes
- この構成は将来テストを追加する際、`test/` 配下に UseCase / Mapper / ViewModel / Integration を段階投入しやすい粒度を保持
- Quickstart の数値基準は `perf_timer` + ログで手動検証 (T027 完了後)
- テスト削除判断により品質リスク上昇: 重要ロジック (Admin 露出保証 / スライドショー間隔) は最小限ログ検証を推奨

生成日時: 2025-09-11 (No-Test Variant)

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
- [x] T008 `core/result/result.dart` Result<T> 実装 (success/error, map, flatMap)
- [x] T009 [P] 例外階層 `core/error/app_exceptions.dart` (NetworkException, DecodeException, EmptyPhotoSetException, AdminExposureViolation)
- [x] T010 PhotoEntity (freezed + json) `lib/domain/entities/photo_entity.dart`
- [x] T011 [P] Photo マッピング関数 `lib/data/mappers/photo_mapper.dart` (Firestore Map→Entity, priority/monthKey 派生)

## Phase 3.3: Data Layer（分離）
- [x] T012 FujiiPhotos Service `lib/data/services/fujii_photos_service.dart`（uid+month で `fujiiPhotos[]` 抽出）
- [x] T013 UserPhotos Service `lib/data/services/user_photos_service.dart`（uid+month で `userPhotos[]` 抽出）
- [x] T014 Repository Interfaces `lib/domain/repositories/{fujii_photos_repository.dart,user_photos_repository.dart}`（各 load API）
- [x] T015 Repository 実装 `lib/data/repositories/{fujii_photos_repository_impl.dart,user_photos_repository_impl.dart}`（各 Service 呼出 + Mapper + キャッシュ + 単回リトライ）

## Phase 3.4: Domain UseCases
- [x] T016 UseCase: 月写真ロード（集約）`lib/domain/usecases/load_month_photos_usecase.dart`（両Repoを結合）
- [x] T017 UseCase: スライドショーバッチ計算 `lib/domain/usecases/compute_slideshow_batch_usecase.dart`
- [x] T018 UseCase: Admin 露出保証 `lib/domain/usecases/ensure_admin_exposure_usecase.dart`

## Phase 3.5: Providers (DI Wiring)
- [x] T019 Provider 定義 `lib/providers/calendar_providers.dart`（firestore, services(fujii/user), repositories(fujii/user), usecases, viewmodel）
	- 実装メモ: 要件変更により単一 `calendar_providers.dart` ではなく
		- `lib/providers/firebase_providers.dart` (Firestore のみ集約)
		- Service / Repository / UseCase は各定義ファイル内で `@Riverpod` により生成
		- ViewModel Provider は ViewModel 実装 (Phase 3.6) で追加予定（元タスクの「viewmodel」項目は後段で実現）
		- 機能要件 (DI で Firestore→Service→Repository→UseCases 参照可能) は満たしているため完了扱い

## Phase 3.6: ViewModel
- [x] T020 Month ViewModel `lib/presentation/viewmodels/calendar/month_view_model.dart`（ロード/スワイプ/スライドショー制御: 現在 AsyncValue<MonthData> 実装にて達成）

## Phase 3.7: UI Layer
- [x] T021 ルーター設定 `lib/presentation/router/app_router.dart` (auto_route: MonthCalendarRoute) ※ 単一画面初期構成
- [x] T022 月ページスクリーン `lib/presentation/screens/calendar/month_page.dart` (AsyncValue 状態切替 / reload / slideshow トグル / prev/next)
- [x] T023 [P] カレンダーグリッド `lib/presentation/screens/calendar/widgets/month_grid.dart` 仮実装 (ID表示, star)
- [x] T024 [P] スライドショー `lib/presentation/screens/calendar/widgets/photo_slideshow.dart` タップ進行簡易版
- [x] T025 [P] 空月プレースホルダー `lib/presentation/screens/calendar/widgets/empty_month_placeholder.dart`

## Phase 3.8: Integration / Infrastructure
- [x] T026 Firestore 初期化 & 起動ログ `lib/main.dart` (AppLogger + PerfTimer で firebase init 計測 & ログ)
- [x] T027 キャッシュ設定 `lib/core/utils/cache_config.dart` (custom CacheManager + placeholder)
- [x] T028 ロギング/メトリクス `lib/core/logger/logger.dart` (startup / month_load / swipe / slideshow / perf / error)
- [x] T029 パフォーマンス計測ラッパー `lib/core/utils/perf_timer.dart`

## Phase 3.9: Polish
- [ ] T030 Import 依存グラフ lint 雛形 `import_lint.yaml`
- [ ] T031 README 更新 (アーキ構成 & 実行手順反映)
- [ ] T032 Quickstart 手動検証セクション追記 `specs/001-features-main-page/quickstart.md` (計測ログ活用方法)
- [ ] T033 初期パフォーマンス記録 `docs/perf/initial-benchmark.md`
- [ ] T034 Dead code / 重複削減最終パス
- [ ] T035 リリースノートドラフト `CHANGELOG.md`

## Phase 3.10: 月ページからの写真アップロード（FR-019）
- [ ] T036 月ページに「写真を追加」ボタンを追加
	- 対象: `lib/presentation/screens/calendar/month_page.dart`
	- 表示条件: 被撮影者（編集可=readOnly=false）のみ表示。閲覧者（readOnly=true）では非表示。
	- 成功条件: タップで ViewModel の `onAddPhoto()`（仮）を呼び出す。
- [ ] T037 ViewModel にアップロードアクションを配線
	- 対象: `lib/presentation/viewmodels/calendar/month_view_model.dart`
	- 仕様: 既存の UploadUserPhotoUseCase（EXIF→capturedAt→month 派生）を呼び、成功で当月写真へ即時反映、失敗でエラーバナー＋再試行導線。
	- 成功条件: 成功時に `state` の `photos` が増え UI に反映。失敗時はユーザーに理由を提示。


---
## Dependencies
- T001 → (T002,T003,T005)
- T002 → (T004,T012,T013)  # 依存追加後にコード生成/Service 実装が可能
- T003 → (T004,T005,T007)  # fvm 固定後に他コマンド統一
- T004 → (T008..T011,T012,T013)  # コード生成と Lint 設定後に Core 実装開始
- T005 → (T026)  # firebase_options.dart 生成後に main 初期化強化
- T008 (Result) → T012 以降
- T010 (Entity) → T011, T012, T013, T014, T015
- T011 → T015
- T012/T013 → T015
- T015 → T016
- T016 → T017, T018, T020
- T017/T018 → T020
- T019 (Providers) → T020 → (T021-T025)
- T026/27/28/29 完了後 Quickstart 手動検証
- Polish (T030-T035) は全実装後

---
## Parallel Execution Examples
Core 早期並列:
```
Task: "T009 例外階層定義"
Task: "T011 Photo マッピング関数"
```
UI ウィジェット並列:
```
Task: "T023 カレンダーグリッド"
Task: "T024 スライドショー"
Task: "T025 空月プレースホルダー"
```
Polish 並列:
```
Task: "T030 import_lint 雛形"
Task: "T031 README 更新"
Task: "T033 初期パフォーマンス記録"
```

---
## Validation Checklist (テスト除外方針)
- [x] テスト関連タスクが存在しないことを確認
- [x] 各タスクが一意ファイル/目的を明示
- [x] 依存チェーンが Core→Data→Domain→Providers→ViewModel→UI→Integration→Polish 順を維持
- [x] `[P]` タスクは同一ファイル競合なし
- [x] 将来テスト導入用に責務分離構造を保持

---
## Notes
- この構成は将来テストを追加する際、`test/` 配下に UseCase / Mapper / ViewModel / Integration を段階投入しやすい粒度を保持
- Quickstart の数値基準は `perf_timer` + ログで手動検証 (T029 完了後)
- テスト削除判断により品質リスク上昇: 重要ロジック (Admin 露出保証 / スライドショー間隔) は最小限ログ検証を推奨

生成日時: 2025-09-11 (No-Test Variant)

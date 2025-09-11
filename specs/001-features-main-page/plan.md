# Implementation Plan: 月カレンダー閲覧（メインページ）

**Branch**: `[001-features-main-page]` | **Date**: 2025-09-11 | **Spec**: `/specs/001-features-main-page/spec.md`
**Input**: Feature specification from `/specs/001-features-main-page/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
   → If not found: ERROR "No feature spec at {path}"
2. Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Detect Project Type from context (web=frontend+backend, mobile=app+api)
   → Set Structure Decision based on project type
3. Evaluate Constitution Check section below
   → If violations exist: Document in Complexity Tracking
   → If no justification possible: ERROR "Simplify approach first"
   → Update Progress Tracking: Initial Constitution Check
4. Execute Phase 0 → research.md
   → If NEEDS CLARIFICATION remain: ERROR "Resolve unknowns"
5. Execute Phase 1 → contracts, data-model.md, quickstart.md, agent-specific template file (e.g., `CLAUDE.md` for Claude Code, `.github/copilot-instructions.md` for GitHub Copilot, or `GEMINI.md` for Gemini CLI).
6. Re-evaluate Constitution Check section
   → If new violations: Refactor design, return to Phase 1
   → Update Progress Tracking: Post-Design Constitution Check
7. Plan Phase 2 → Describe task generation approach (DO NOT create tasks.md)
8. STOP - Ready for /tasks command
```

**IMPORTANT**: The /plan command STOPS at step 7. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary
本機能は、アプリ起動時に「日付のみの月カレンダー」を表示し、その背後に「過去の同月に撮影した写真」を正方形グリッドでスライドショー表示するメインページを提供する。Admin 追加写真は一回り大きく表示し、スタジオ撮影実績が無い月は撮影促進プレースホルダーを表示する。左右スワイプで月遷移。表示対象の月判定は「撮影タイムゾーンの暦日」。成功基準は描画/応答/露出/信頼性などを定量化（spec参照）。実装は Flutter（fvm管理）＋ Firebase/Firestore を採用し、auto_route によるルーティング、Riverpod によるDI/状態管理を用いる。Auth/Storage/Firestore の初期データは提供された seed スクリプト（`seed-auth.js`, `seed-storage.js`）で生成される前提とし、それらの実際のコレクション/フィールド構造をデータモデルへ反映する。

## Technical Context
**Language/Version**: Dart 3.x / Flutter 3.x（fvmでバージョン固定）  
**Primary Dependencies**: auto_route, flutter_riverpod, freezed, json_serializable, cached_network_image, firebase_core, cloud_firestore（必要に応じて firebase_storage）  
**Storage**: Firebase Firestore（ユーザーごとの calendar/{month} 階層配下に fujii-photos, user-photos）  
**Seed Data Alignment**: `users/{uid}` に role (admin|user) を保持。`users/{uid}/calendar/{MM}/(fujii-photos|user-photos)/{filename}` ドキュメントに `id,url,capturedAt,month,type,updatedAt,memo` が格納（seed-storage.js）。アプリ側で追加で計算/派生する `monthKey`, `priority(任意)` を付与し、`type` は Firestore 値（'fujii-photos'|'user-photos'）をそのまま enum として利用。
（自動テストは本フェーズ対象外。手動確認と観測ログで品質確保）  
**Target Platform**: タブレット（8〜9インチ、横画面）＋スマホ対応（レスポンシブ）
**Project Type**: mobile（アプリ＋Firebase BaaS）  
**Performance Goals**: 60fps維持、スワイプ応答 p95 ≤ 50ms、月遷移アニメ 250–350ms、初回描画 p95 ≤ 1.0s（詳細は spec の成功基準）  
**Constraints**: オフラインフォールバック（キャッシュ/プレースホルダー）、撮影TZ基準の月判定、Admin写真最低1枚露出  
**Data Normalization Constraints**: Firestore の seed スキーマとアプリ内部エンティティの差異を以下方針で吸収: (1) Firestoreには存在しない派生フィールドは ViewModel で構築 (2) priority は Admin 強調要件に合わせクライアント側ルール（fujii-photos=高優先度, user-photos=0）で算出。
**Scale/Scope**: 当面は単一被写体の月ビュー中心（将来拡張: 日ビュー/通知/認証等は別Issue）

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Simplicity**:
- Projects: 1（mobileアプリ）
- Using framework directly?: Yes（Flutter/Firestore SDKを直接利用）
- Single data model?: Yes（App Entity=Firestoreドキュメント形）
- Avoiding patterns?: 部分的にNo（Repository層採用）

**Architecture**:
- Feature as library?: N/A（モバイルUI中心のため画面単位のモジュール化を実施）
- Libraries listed: UI/Router/Services/Repositories/Models
- CLI per library: N/A
- Library docs: 本plan配下のドキュメントで代替

（自動テスト運用ルールは今回は非適用）

**Observability**:
- 構造化ログ（重要イベント: 初回描画、写真初表示、スワイプ開始/完了、エラー）
- ログ収集: 開発時はコンソール、将来はCrashlytics/Analyticsに集約
- エラー文脈: 例外＋画面/状態ID付与

**Versioning**:
- アプリSemVerをCIで付与想定（BUILD自動採番）
- Firestoreスキーマ変更はマイグレーション手順を research に記載

## Project Structure

### Documentation (this feature)
```
specs/[###-feature]/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### Source Code (repository root)
```
# Option 1: Single project (DEFAULT)
src/
├── models/
├── services/
├── cli/
└── lib/

（tests ディレクトリは未作成: 将来必要時に追加）

# Option 2: Web application (when "frontend" + "backend" detected)
backend/
├── src/
│   ├── models/
│   ├── services/
│   └── api/
└── tests/

frontend/
├── src/
│   ├── components/
│   ├── pages/
│   └── services/
└── tests/

# Option 3: Mobile + API (when "iOS/Android" detected)
api/
└── [same as backend above]

ios/ or android/
└── [platform-specific structure]
```

**Structure Decision**: Option 3（Mobile+BaaS）。Flutter公式アーキテクチャ + Riverpod 記事を参照し、UI / Domain / Data の 3 層＋Cross-cutting(core) を明確化。既存案を再編し以下ディレクトリ構成を採用:

```
lib/
├── main.dart
├── firebase_options.dart
├── core/                       # 共通基盤（例外, Result, logger, utils, constants）
│   ├── result/                 # Result<T> 定義（compass_app 準拠 + 拡張）
│   ├── error/                  # 例外種別（NetworkException 等）
│   ├── logger/                 # ログ/メトリクス出力アダプタ
│   └── utils/
├── presentation/               # UI層 (公式: UI Layer)
│   ├── router/                 # auto_route 設定
│   ├── screens/                # Page Widget（1画面=1ディレクトリ）
│   │   └── calendar/
│   │       ├── month_page.dart
│   │       └── widgets/        # 月セル, グリッド, スライドショー部品
│   ├── viewmodels/             # StateNotifier / AsyncNotifier / Hooks VM
│   │   └── calendar/
│   │       └── month_view_model.dart
│   └── widgets/                # 汎用再利用コンポーネント
├── domain/                     # ドメイン層 (Entities / Repository Interface / UseCase)
│   ├── entities/
│   │   └── photo_entity.dart
│   ├── repositories/           # interface (抽象) e.g. calendar_repository.dart
│   └── usecases/
│       ├── load_month_photos_usecase.dart
│       ├── compute_slideshow_batch_usecase.dart
│       └── ensure_admin_exposure_usecase.dart
├── data/                       # データ層 (実装 + 外部I/O)
│   ├── services/               # Firestore/Storage/Platform/Dio 等純粋I/O
│   │   └── calendar_service.dart
│   ├── repositories/           # impl (Repository interfaces の実装)
│   │   └── calendar_repository_impl.dart
│   ├── mappers/                # Firestore Document → Entity 変換 (純関数)
│   └── models/                 # Service層専用 DTO（必要最小限 / JSON 変換のみ）
├── providers/                  # Riverpod Provider 定義（依存グラフ）
│   └── calendar_providers.dart
└── configuration/              # 環境設定, flavor, feature flags

test/ （将来の自動テスト導入時に利用）
```

### 公式アーキテクチャ適用差分
- Domain 層を `entities / repositories(interface) / usecases` に分離し、Data 層実装の差し替え容易性を確保。
- Repository interface を Domain に置く（UI からは Domain までしか意識させない）→ Data 実装は隠蔽。
- Result<T> を core/result に導入し、Service/Repository/UseCase 境界で例外を握り潰さず型で扱う（UI では AsyncValue<Result<…>> もしくは ViewModel 内で state 正規化）。
- Firestore Document → DTO(model) → Entity の 2 段構成は過剰になり得るためルール化:
   - 変換ロジックが domain 検証/派生計算を含む場合: DTO + Mapper を保持
   - 現状: Photo は派生 `priority` / `monthKey` 計算のみ（軽量）。→ 初期は DTO スキップし Service → Mapper → Entity 直行。拡張余地として `data/models` は空で作成。
- UseCase は複数 Repository/Service 連携または複雑ロジック（ランダム選抜 + Admin 露出保証）が存在するため採用（Flutter公式指針: 不要なら省略可）。
- Riverpod Provider 生成順: serviceProvider → repositoryImplProvider → repositoryProvider(interface expose) → useCaseProviders → viewModelProviders → screen widgets。

### レイヤ依存ルール (Allow List)
```
presentation  → domain, (providers, core)
domain        → core
data          → domain (ONLY interfaces), core
core          → (依存なし / 外部パッケージのみ)
providers     → data, domain, core (DI wiring) ※ UI ロジック禁止
```
逆方向依存（例: domain→data, core→presentation）は禁止。CI 将来タスクで import graph 検査を追加予定。

### Result<T> ポリシー
- Service: 失敗を AppException (core/error) へ正規化し Result.error で返却
- Repository Impl: キャッシュ/再試行/フォールバック適用後も失敗ならそのまま伝播
- UseCase: 可能な限りビジネスルール検証失敗を domain-level Exception に変換（例: EmptyPhotoSetException）
- ViewModel: Result<T> を UI 状態に flatten（`loading / ready(data) / error(message)`）

### Photo 関連適用例
1. Service (Firestore): ドキュメント Snapshots を生 Raw Map List に→ Mapper へ
2. Mapper: priority, monthKey を計算し Entity 生成
3. Repository Impl: メモリキャッシュ + 一括フェッチ + 型安全変換 + 失敗時リトライ (1 回) + Result<T>
4. UseCase: ランダムシャッフル（seed対応）→ Admin 露出保証 → スライドショーバッチ生成
5. ViewModel: `MonthCalendarState` (sealed) { loading, placeholder, ready(photos, slideshowBatch) }

### Provider 役割最小化
providers では「組み立てとスコープ管理」以外のロジック（変換/検証/選抜）は禁止。テスト容易性確保のため Provider 経由で差し替えできるよう interface 型を公開。

### タスク影響 (Phase 2 以降反映予定)
追加予定タスク例:
- core/result/result.dart 追加 + 単体テスト
- core/error/ 例外階層 (Network/Decode/EmptyPhotoSet/AdminExposureViolation)
- data/mappers/photo_mapper.dart 実装
- domain/repositories/calendar_repository.dart (interface)
- data/repositories/calendar_repository_impl.dart
- providers/calendar_providers.dart: layered wiring
- viewmodels/month_view_model.dart: Result flatten + sealed UI state
- 依存グラフ静的検査 (import_lint) 下書き

### 移行方針
現行 plan に記載の `services/ repositories/ usecases/ viewmodels/` 構成は上記へ rename/再配置（初コード投入時）。既存ドキュメントとの乖離を避けるため spec 側へのフィールド/レイヤ説明は追従不要（本 plan のみで差分管理）。

---

（以下 旧アーキテクチャ説明を本節に統合済み）

## Architecture Alignment (Updated: Flutter公式 + Riverpod)
| Layer          | Dir (root)              | Responsibility (要約)                              | State    |
| -------------- | ----------------------- | -------------------------------------------------- | -------- |
| Presentation   | presentation/           | Widget/レイアウト/簡易分岐/アニメ/入力イベント     | No       |
| ViewModel      | presentation/viewmodels | UI状態保持・イベント→UseCase or Repository 呼出    | Yes      |
| Domain         | domain/                 | ビジネスルール/Entity/Repository Interface/UseCase | No       |
| Data Repo Impl | data/repositories       | 取得/集約/キャッシュ/失敗処理                      | Optional |
| Service        | data/services           | 外部I/O (Firestore/Storage/Platform) 状態無し      | No       |
| Core           | core/                   | 共通基盤(Result/Exception/Logger/Utils)            | No       |

### UseCase 継続採用理由
複数 Repository（写真 + 将来メタデータ）協調やランダム/露出保証の純化。公式指針上 optional だがドメイン複雑度 > trivial のため維持。

### 初期ユースケース（不変）
1. load_month_photos_usecase
2. compute_slideshow_batch_usecase
3. ensure_admin_exposure_usecase

（自動テスト順序は削除）

### 設計メモ更新
- Mapper 導入判断基準: ドメイン派生ロジック > 単純コピーか否かで決定
- 乱数は `SeededRandom` (core/utils) 封装で再現性確保
- In-memory cache は Map<(uid, month), List<PhotoEntity>> 単純実装
- 露出保証: スライドショー総フレーム内で admin >=1 を assert。違反で fallback (最初差替) + metrics event

### Provider Wiring サンプル（擬似コード）
```
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
final calendarServiceProvider = Provider((ref) => CalendarService(ref.watch(firestoreProvider)));
final calendarRepositoryImplProvider = Provider((ref) => CalendarRepositoryImpl(ref.watch(calendarServiceProvider)));
final calendarRepositoryProvider = Provider<CalendarRepository>((ref) => ref.watch(calendarRepositoryImplProvider));
final loadMonthPhotosUseCaseProvider = Provider((ref) => LoadMonthPhotosUseCase(ref.watch(calendarRepositoryProvider)));
// ... etc
```

### UI State (Sealed 案)
```
sealed class MonthCalendarState {
   const MonthCalendarState();
}
class Loading extends MonthCalendarState { const Loading(); }
class Placeholder extends MonthCalendarState { const Placeholder(this.reason); final String reason; }
class Ready extends MonthCalendarState { const Ready(this.photos, this.slideshow); final List<PhotoEntity> photos; final List<PhotoEntity> slideshow; }
class ErrorState extends MonthCalendarState { const ErrorState(this.message); final String message; }
```

---

### Seed Integration / Data Normalization
| Concern    | Firestore Raw (seed)                     | App Entity (内部)            | 取扱方針                                           |
| ---------- | ---------------------------------------- | ---------------------------- | -------------------------------------------------- |
| Role       | `users/{uid}.role`                       | `User.role`                  | 認証済みユーザーコンテキストに読み込み Provider 化 |
| Photo Path | `users/{uid}/calendar/{MM}/(fujii-photos | user-photos)/{filename}`     | `PhotoEntity`                                      | 取得後に type 正規化 / monthKey を付与 |
| capturedAt | timestamp (UTC/Z)                        | captureAt (TZ含)             | 端末側で TZ 判定用に DateTime.parse                |
| month      | number (1..12)                           | month (int), monthKey ("MM") | monthKey = zero-pad                                |
| type       | 'fujii-photos'                           | 'user-photos'                | type ('fujii-photos'                               | 'user-photos') + isStudioShot          | Firestore 値を直接使用 |
| priority   | (無し)                                   | priority(int)                | type=='fujii-photos' → >0 固定値 (例:10)           |
| memo       | string                                   | memo                         | そのまま利用（現状UI未使用）                       |
| updatedAt  | timestamp                                | updatedAt                    | キャッシュの比較指標                               |

### Index & Query Strategy
| Use Case     | Query                                                            | Index 要否             | 備考                                 |
| ------------ | ---------------------------------------------------------------- | ---------------------- | ------------------------------------ |
| 月表示       | collectionGroup(`fujii-photos`), where month==X AND uid==current | 単一フィールド (month) | 必要なら複合: month + updatedAt desc |
| ユーザー写真 | 同上 (user-photos)                                               | 同上                   | 同期タイミングで merge               |
| 管理強調     | 上記結果をメモリでソート                                         | 不要                   | priority はクライアント生成          |

### Security Rules (High Level Draft)
1. 認証ユーザーのみ自分の `users/{uid}` 階層を read（共有URL閲覧は別メカニズムで tokenized path 予定）
2. Write: Admin ロールのみ `fujii-photos` 追加可 / 一般ユーザーは `user-photos`
3. month フィールドは 1..12 の整数であることを rule で検証
4. 画像 URL は Storage ダウンロードトークンを含むが今後 CDN 経由へ移行検討
5. 共有リンク閲覧時は read-only かつユーザー固有 UID の限定された subset のみアクセス許可（別Issue）。

## Phase 0: Outline & Research
1. **Extract unknowns from Technical Context** above:
   - For each NEEDS CLARIFICATION → research task
   - For each dependency → best practices task
   - For each integration → patterns task

2. **Generate and dispatch research agents**:
   ```
   For each unknown in Technical Context:
     Task: "Research {unknown} for {feature context}"
   For each technology choice:
     Task: "Find best practices for {tech} in {domain}"
   ```

3. **Consolidate findings** in `research.md` using format:
   - Decision: [what was chosen]
   - Rationale: [why chosen]
   - Alternatives considered: [what else evaluated]

**Output**: research.md with all NEEDS CLARIFICATION resolved（作成済み: `/specs/001-features-main-page/research.md`）

## Phase 1: Design & Contracts
*Prerequisites: research.md complete*

1. **Extract entities from feature spec** → `data-model.md`:
   - Entity name, fields, relationships
   - Validation rules from requirements
   - State transitions if applicable

2. **Generate API contracts** from functional requirements:
   - For each user action → endpoint
   - Use standard REST/GraphQL patterns
   - Output OpenAPI/GraphQL schema to `/contracts/`

3. **Update agent file incrementally** (O(1) operation):
   - Run `/scripts/update-agent-context.sh [claude|gemini|copilot]` for your AI assistant
   - If exists: Add only NEW tech from current plan
   - Preserve manual additions between markers
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency
   - Output to repository root

**Output**: data-model.md, /contracts/*, quickstart.md, agent-specific file（作成済み）

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy (簡略化)**:
- contracts / data-model / quickstart から実装タスクのみ抽出

**Ordering Strategy**:
- Model → Service → Repository Impl → UseCase → ViewModel → UI → Wiring → 手動確認

**Estimated Output**: 15-20 tasks

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation
*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)  
**Phase 4**: Implementation (quickstart.md に基づき手動確認 + パフォーマンス観測)  
**Phase 5**: 保留

## Complexity Tracking
*Fill ONLY if Constitution Check has violations that must be justified*

| Violation                       | Why Needed                             | Simpler Alternative Rejected Because                                      |
| ------------------------------- | -------------------------------------- | ------------------------------------------------------------------------- |
| Repository pattern              | 可読性と関心分離、データ取得とUIの分離 | 直接Firestore参照だとUI/ビジネスロジックが結合し責務肥大                  |
| Client-side priority derivation | Admin強調表示を迅速に実現              | Firestoreフィールド追加は初期段階で過剰、将来必要時にサーバー側計算へ移行 |


## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
- [x] Phase 2: Task planning complete (/plan command - describe approach only)
- [x] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete (manual verification)
- [ ] Phase 5: (reserved)

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
- [x] Complexity deviations documented

---
*Based on Constitution v2.1.1 - See `/memory/constitution.md`*
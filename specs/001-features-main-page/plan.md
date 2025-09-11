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
**Testing**: flutter_test、golden test（UI）、integration_test（起動〜月遷移/スライドショー）  
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

**Testing (NON-NEGOTIABLE)**:
- RED-GREEN-Refactor: 遵守（まずゴールデン/統合テストを作成し失敗を確認）
- Commit順序: テスト→実装
- Order: Contract(インターフェース)→Integration→E2E→Unit
- Real deps: Firestoreエミュレータ優先（本番直結は避ける）
- Integration対象: 画像キャッシュ/Firestoreクエリ/ルーティング
- Forbidden: 実装先行・RED省略

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

tests/
├── contract/
├── integration/
└── unit/

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

**Structure Decision**: Option 3（Mobile+BaaS）。Flutterは以下の構成（ユーザー指定）:

```
lib
├── firebase_options.dart
├── main.dart
├── models/
│  └── calendar/
│      ├── photo_entity.dart
│      ├── photo_entity.freezed.dart
│      └── photo_entity.g.dart
├── providers/
│  └── calendar/
│      ├── calendar_provider.dart
│      └── calendar_provider.g.dart
├── repositories/
│  └── calendar/
│      ├── calendar_repository.dart
│      └── calendar_repository.g.dart
├── router/
│  ├── auto_route_guard.dart
│  ├── auto_route_guard.g.dart
│  ├── router.dart
│  ├── router.g.dart
│  └── router.gr.dart
├── screens/
│  └── calendar/
│      ├── month_page.dart
│      ├── month_view_model.dart
│      ├── month_view_model.freezed.dart
│      └── month_view_model.g.dart
└── services/
   └── calendar/
      ├── calendar_service.dart
      └── calendar_service.g.dart
```

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

3. **Generate contract tests** from contracts:
   - One test file per endpoint
   - Assert request/response schemas
   - Tests must fail (no implementation yet)

4. **Extract test scenarios** from user stories:
   - Each story → integration test scenario
   - Quickstart test = story validation steps

5. **Update agent file incrementally** (O(1) operation):
   - Run `/scripts/update-agent-context.sh [claude|gemini|copilot]` for your AI assistant
   - If exists: Add only NEW tech from current plan
   - Preserve manual additions between markers
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency
   - Output to repository root

**Output**: data-model.md, /contracts/*, quickstart.md, agent-specific file（作成済み）

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:
- Load `/templates/tasks-template.md` as base
- Generate tasks from Phase 1 design docs (contracts, data model, quickstart)
- Each contract → contract test task [P]
- Each entity → model creation task [P] 
- Each user story → integration test task
- Implementation tasks to make tests pass

**Ordering Strategy**:
- TDD order: Tests before implementation 
- Dependency order: Models before services before UI
- Mark [P] for parallel execution (independent files)

**Estimated Output**: 25-30 numbered, ordered tasks in tasks.md

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation
*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)  
**Phase 4**: Implementation (execute tasks.md following constitutional principles)  
**Phase 5**: Validation (run tests, execute quickstart.md, performance validation)

## Complexity Tracking
*Fill ONLY if Constitution Check has violations that must be justified*

| Violation                       | Why Needed                                 | Simpler Alternative Rejected Because                                      |
| ------------------------------- | ------------------------------------------ | ------------------------------------------------------------------------- |
| Repository pattern              | 可読性とテスト容易性、データ取得とUIの分離 | 直接Firestore参照だとUI/ビジネスロジックが結合し、テストが困難            |
| Client-side priority derivation | Admin強調表示を迅速に実現                  | Firestoreフィールド追加は初期段階で過剰、将来必要時にサーバー側計算へ移行 |


## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
- [ ] Phase 2: Task planning complete (/plan command - describe approach only)
- [ ] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
- [x] Complexity deviations documented

---
*Based on Constitution v2.1.1 - See `/memory/constitution.md`*
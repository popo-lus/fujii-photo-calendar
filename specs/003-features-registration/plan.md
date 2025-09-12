# Implementation Plan: [FEATURE]
# Implementation Plan: アカウント新規登録＋匿名閲覧（招待コード）

**Branch**: `003-features-registration` | **Date**: 2025-09-12 | **Spec**: /Users/lupisys/dev_project/fujii-photo-calendar/specs/003-features-registration/spec.md
**Input**: Feature specification from `/specs/003-features-registration/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
2. Fill Technical Context (scan for NEEDS CLARIFICATION) → なし（現状）
3. Evaluate Constitution Check section below → モバイル単一プロジェクトで進行
4. Execute Phase 0 → research.md（Flutter×Firebase Auth、匿名サインイン＋invites設計）
5. Execute Phase 1 → contracts, data-model.md, quickstart.md を作成
6. Re-evaluate Constitution Check → 問題なければ PASS
7. Plan Phase 2 → /tasks の生成方針を記述（作成はしない）
8. STOP - Ready for /tasks command
```

## Summary
登録ユーザーは「名前・メール・パスワード」で登録。閲覧者はアカウント不要で「招待コード」による匿名サインインで閲覧のみを許可。Flutter クライアントから Firebase Authentication（Email/Password + Anonymous）/ Firestore を利用し、招待は `app/docs/invites.md` に準拠した最小構成で実装する。

## Technical Context
**Language/Version**: Dart 3.x（Flutter）  
**Primary Dependencies**: Flutter, firebase_auth, cloud_firestore  
**Storage**: Firestore（写真URLは既存保存を利用）、Storageは既存  
**Testing**: 本フェーズの範囲外（実施しない）  
**Target Platform**: iOS, Android, Web（Flutter）  
**Project Type**: mobile（単一アプリ）  
**Performance Goals**: 起動→ホーム遷移 < 2s（エミュ含む）、入力検証応答 < 150ms  
**Constraints**: オフライン時はキャッシュ表示（既存要件準拠）、日本語のみ  
**Scale/Scope**: 画面追加は最小（登録/招待入力を既存ログインUIに統合）  

## Constitution Check
**Simplicity**:
- Projects: 1（app のみ）
- Using framework directly: Yes（Flutter公式プラグインを直接利用）
- Single data model: Yes（Account/Album/Invite/ViewerSession 最小）
- Avoiding patterns: Yes（Repository等は導入しない）

**Architecture**:
- Features as library: N/A（モバイル単体）
- Libraries listed: N/A（社内ライブラリなし）
- CLI per library: N/A
- Library docs: N/A

**Testing**: 本フェーズの範囲外（実施しない）

**Observability**:
- Structured logging: 重要イベント（登録成功、匿名セッション開始/失効）をINFOログ
- Frontend→backend: N/A（今回はクライアントのみ）
- Error context: 入力値とバリデーション失敗理由をロギング（PIIマスキング）

**Versioning**:
- Version: アプリのビルド番号で管理
- BUILD increments: 各変更で増分
- Breaking changes: なし（新規機能追加）

## Project Structure
Structure Decision: Mobile（Option 3 の「Mobile + API」だが API なし、既存 app 配下に実装）

## Phase 0: Outline & Research
研究観点:
- Flutter × Firebase Auth（email/password + anonymous）のベストプラクティス
- invites.md 準拠の Firestore ルール確認（invites, guestSessions の参照）
- 既存 UI（ログイン画面）への導線統合

Output: `research.md` に決定と根拠を記載

## Phase 1: Design & Contracts
1) data-model.md（エンティティ）
- User: uid, email, displayName, status
- Album: ownerUid, photos[]（既存URL）、編集権限=ownerのみ
- InviteCode: code, ownerUid, disabled, expiresAt, createdAt
- ViewerSession: viewerUid, code, albumOwnerUid, createdAt, expiresAt(optional)

2) contracts/（擬似API/クライアント契約）
- Auth
   - POST /auth/register {displayName, email, password} → 201（クライアント: firebase_auth.createUserWithEmailAndPassword + users/{uid} 作成）
   - POST /auth/login {email, password} → 200（…signInWithEmailAndPassword）
   - POST /auth/anonymous {code} → 200（…signInAnonymously → guestSessions/{uid}=code）
- Invites
   - GET /invites/{code} → 200/404（firestore: invites/{code}）
招待は `specs/003-features-registration/contracts/invites.md` に準拠した最小構成で実装する。
   - GET /albums/{ownerUid} → 200（firestore: users/{ownerUid}/calendar/{MM}…）

3) quickstart.md
**Primary Dependencies**: Flutter, firebase_auth, cloud_firestore, riverpod, riverpod_annotation, auto_route  

4) （テスト関連は本計画では扱わない）
 Single data model: Yes（User/Album/Invite/ViewerSession 最小）
 Patterns: Repository パターンを既存コードで使用（Photos 系）。本機能でも UserRepository を導入予定。
- /templates/tasks-template.md をベースに、契約からタスク出力
- 並列可: 文書生成
 User: uid, email, displayName, status（client でも Entity として保持）

    - GET /albums/{ownerUid}/calendar/{MM} → 200（firestore: users/{ownerUid}/calendar/{MM}）

## Progress Tracking
Structure Decision: Mobile（既存 app 配下に実装）

Current source structure (as of app/lib):
```
app/lib/
   core/
   data/
      repositories/
      services/
   domain/
      entities/
      repositories/
      usecases/
   presentation/
      screens/
      router/
      viewmodels/
   providers/
```
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
**Testing**: 本フェーズの範囲外（実施しない）
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
- [ ] Complexity deviations documented
**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link]
**Input**: Feature specification from `/specs/[###-feature-name]/spec.md`

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
[Extract from feature spec: primary requirement + technical approach from research]

## Technical Context
**Language/Version**: [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION]  
**Primary Dependencies**: [e.g., FastAPI, UIKit, LLVM or NEEDS CLARIFICATION]  
**Storage**: [if applicable, e.g., PostgreSQL, CoreData, files or N/A]  
**Testing**: [e.g., pytest, XCTest, cargo test or NEEDS CLARIFICATION]  
**Target Platform**: [e.g., Linux server, iOS 15+, WASM or NEEDS CLARIFICATION]
**Project Type**: [single/web/mobile - determines source structure]  
**Performance Goals**: [domain-specific, e.g., 1000 req/s, 10k lines/sec, 60 fps or NEEDS CLARIFICATION]  
**Constraints**: [domain-specific, e.g., <200ms p95, <100MB memory, offline-capable or NEEDS CLARIFICATION]  
**Scale/Scope**: [domain-specific, e.g., 10k users, 1M LOC, 50 screens or NEEDS CLARIFICATION]

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Simplicity**:
- Projects: [#] (max 3 - e.g., api, cli, tests)
- Using framework directly? (no wrapper classes)
- Single data model? (no DTOs unless serialization differs)
- Avoiding patterns? (no Repository/UoW without proven need)

**Architecture**:
- EVERY feature as library? (no direct app code)
- Libraries listed: [name + purpose for each]
- CLI per library: [commands with --help/--version/--format]
- Library docs: llms.txt format planned?

**Testing (NON-NEGOTIABLE)**:
- RED-GREEN-Refactor cycle enforced? (test MUST fail first)
- Git commits show tests before implementation?
- Order: Contract→Integration→E2E→Unit strictly followed?
- Real dependencies used? (actual DBs, not mocks)
- Integration tests for: new libraries, contract changes, shared schemas?
- FORBIDDEN: Implementation before test, skipping RED phase

**Observability**:
- Structured logging included?
- Frontend logs → backend? (unified stream)
- Error context sufficient?

**Versioning**:
- Version number assigned? (MAJOR.MINOR.BUILD)
- BUILD increments on every change?
- Breaking changes handled? (parallel tests, migration plan)

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

**Structure Decision**: [DEFAULT to Option 1 unless Technical Context indicates web/mobile app]

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

**Output**: research.md with all NEEDS CLARIFICATION resolved

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

3. （テスト生成はスキップ）
4. （テストシナリオ抽出はスキップ）

5. **Update agent file incrementally** (O(1) operation):
   - Run `/scripts/update-agent-context.sh [claude|gemini|copilot]` for your AI assistant
   - If exists: Add only NEW tech from current plan
   - Preserve manual additions between markers
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency
   - Output to repository root

**Output**: data-model.md, /contracts/*, quickstart.md, agent-specific file

## Phase 2: Task Planning Approach
*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:
- Load `/templates/tasks-template.md` as base
- Generate tasks from Phase 1 design docs (contracts, data model, quickstart)
- Implementation tasksのみ（テスト作成タスクは生成しない）

**Ordering Strategy**:
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

| Violation                  | Why Needed         | Simpler Alternative Rejected Because |
| -------------------------- | ------------------ | ------------------------------------ |
| [e.g., 4th project]        | [current need]     | [why 3 projects insufficient]        |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient]  |


## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
- [x] Phase 2: Task planning complete (/plan command - describe approach only)
- [x] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
- [ ] Complexity deviations documented

---
*Based on Constitution v2.1.1 - See `/memory/constitution.md`*
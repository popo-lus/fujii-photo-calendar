# Implementation Plan: 親ユーザーログイン機能 (メール+パスワード)

**Branch**: `002-features-login` | **Date**: 2025-09-11 | **Spec**: `specs/002-features-login/spec.md`
**Input**: Feature specification from `/specs/002-features-login/spec.md`

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
親ユーザーがメールアドレス+パスワードで既存Flutterアプリ内からFirebase Authenticationを用いてログインし、セッション維持/ログアウトが行える最小機能を追加する。閲覧専用ユーザー/共有閲覧トークンは別仕様。監査ログ（ログインイベント永続保存）は本機能スコープ外。未確定事項: パスワード表示切替方針。

## Technical Context
**Language/Version**: Dart (Flutter stable 現行)  
**Primary Dependencies**: firebase_auth, firebase_core, flutter_riverpod(状態管理), logging/独自logger  
**Storage**: Firebase Authentication (認証)  
**Testing**: flutter_test + integration_test (Authフロー), 可能なら firebase_auth_mocks / Emulator 接続  
**Target Platform**: Flutter マルチプラットフォーム (iOS, Android, Web, Desktop) ※優先はモバイル/タブレット  
**Project Type**: mobile (単一Flutterアプリ)  
**Performance Goals**: ログイン操作→初期画面遷移 < 1.5s (p95) / 入力バリデーション即時 (<50ms)  
**Constraints**: オフライン時ログイン不可 / ネットワーク不安定時リトライUI提供 / パスワード入力はセキュアフィールド  
**Scale/Scope**: 初期ユーザー数少（<1000）想定・高負荷調整不要 / セッション同時数制限なし

未確定 (NEEDS CLARIFICATION 引き継ぎ):
（なし - Spec 合意済み）

## Constitution Check
*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Simplicity**:
- Projects: 1 (既存Flutterアプリのみ) → OK
- Using framework directly: Firebase Auth公式SDKを直接利用 → OK
- Single data model: User最小モデルのみ（追加DTOなし） → OK
- Avoiding over-pattern: Repository層を無理に増やさず ViewModel→Service(薄)→Firebase SDK 直 → OK

**Architecture**:
- Feature分離ライブラリ化: 今回はアプリ内モジュール (library化不要) → OK
- Libraries listed: firebase_auth(認証), riverpod(状態) → 目的明確 (監査ログ除外のため cloud_firestore 不要)
- CLI: 該当なし (モバイル) → N/A
- llms.txt: 必要性低 (小規模) → N/A

**Testing (NON-NEGOTIABLE)**:
- RED→GREEN→Refactor: 遵守 (初回: 失敗するテストでAuth UI/logic未実装状態確認)
- Commits: テスト追加→実装→リファクタ順序方針
- Order: Integration(画面遷移/結果) → Unit(validator) → UI細分 (規模的に簡略化)
- Real dependencies: Emulator接続 (Auth) を優先、mockは補助
- Integration tests: ログイン成功/失敗/セッション維持ケース
- Forbidden事項: 仕様外実装を先行しない

**Observability**:
- Structured logging: 既存 logger を利用し "signIn:start/success/failure", "signOut", "tokenInvalidated" を記録（PII 不出力）
- Backend転送: なし（監査ログスコープ外）
- Error context: エラーコード(firebase_auth) + 正規化メッセージ

**Versioning**:
- Appバージョン管理は既存 pubspec.yaml に従い本機能専用の独自番号は不要
- Breaking変更: 既存未実装領域のため影響軽微

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

**Structure Decision**: Option 3 (mobile) のうち既存単一Flutter構成を維持 (追加フォルダ不要)

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

**Output**: research.md with all (本機能で必要な) NEEDS CLARIFICATION を整理 (未決事項は明示リスト化し後続判断前提)

## Phase 1: Design & Contracts
*Prerequisites: research.md complete*

1. **Extract entities** → `data-model.md`:
   - AuthResult(Parent): email, userUid, identifier, lastLoginAt
   - セッションは独立モデルを作らず挙動のみ定義
   - Validation rules: email形式, password非空/長さ(最小) [研究で決定]

2. **Generate contracts** (Flutter内サービス境界定義):
   - AuthService Interface: signIn(email,password), signOut(), getCurrentUser(), observeAuthState()
   - 監査ログ用リポジトリは作成しない（スコープ外）
   - `/contracts/auth.md` には AuthService のみ記述

3. **Contract tests**:
   - test/contracts/auth_service_contract_test.dart: signIn成功/失敗 (Emulator)

4. **Integration scenarios**:
   - ログイン成功遷移 test/integration/login_success_test.dart
   - 誤資格情報エラー test/integration/login_failure_test.dart
   - セッション維持 test/integration/session_persistence_test.dart (有効期間仮値)

5. **Update agent file**:
   - Run `/scripts/update-agent-context.sh [claude|gemini|copilot]` for your AI assistant
   - If exists: Add only NEW tech from current plan
   - Preserve manual additions between markers
   - Update recent changes (keep last 3)
   - Keep under 150 lines for token efficiency
   - Output to repository root

**Output**: data-model.md, /contracts/*, failing tests, quickstart.md, agent-specific file

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

| Violation                                           | Why Needed (Stakeholder Rationale)                        | Simpler Alternative Rejected Because                         |
| --------------------------------------------------- | --------------------------------------------------------- | ------------------------------------------------------------ |
| Omitted automated tests (contract/integration/unit) | 初期デモ優先 / 時間制約で先にUIを可視化し意思決定を早める | 最小限の失敗テスト維持: 品質向上だが初期投入時間増を許容せず |
| Introduced AuthGuard abstraction                    | AutoRoute Guard 機構活用で責務分離と将来拡張 (role別)     | main.dart に if 分岐: 短期的には簡単だが散在と複雑化の懸念   |


## Progress Tracking
*This checklist is updated during execution flow*

**Phase Status**:
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
- [x] Phase 2: Task planning complete (/plan command - describe approach only)
- [x] Phase 3: Tasks generated (tasks.md created; test tasks intentionally omitted)
   - [ ] Phase 4: Implementation complete
   - [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS (更新: cloud_firestore 依存除去で簡素化)
- [x] All NEEDS CLARIFICATION resolved
- [x] Complexity deviations documented (テスト省略特例)

---
*Based on Constitution v2.1.1 - See `/memory/constitution.md`*
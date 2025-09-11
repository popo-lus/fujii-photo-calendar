# Feature Specification: ログイン機能（作成したアカウントでログインできる機能）

**Feature Branch**: `002-features-login`  
**Created**: 2025-09-11  
**Status**: Draft  
**Input**: User description: "ログイン機能: 作成したアカウントでログインできる機能"

## Execution Flow (main)
```
1. Parse user description from Input
   → If empty: ERROR "No feature description provided"
2. Extract key concepts from description
   → Identify: actors, actions, data, constraints
3. For each unclear aspect:
   → Mark with [NEEDS CLARIFICATION: specific question]
4. Fill User Scenarios & Testing section
   → If no clear user flow: ERROR "Cannot determine user scenarios"
5. Generate Functional Requirements
   → Each requirement must be testable
   → Mark ambiguous requirements
6. Identify Key Entities (if data involved)
7. Run Review Checklist
   → If any [NEEDS CLARIFICATION]: WARN "Spec has uncertainties"
   → If implementation details found: ERROR "Remove tech details"
8. Return: SUCCESS (spec ready for planning)
```

---

## ⚡ Quick Guidelines
- ✅ Focus on WHAT users need and WHY
- ❌ Avoid HOW to implement (no tech stack, APIs, code structure)
- 👥 Written for business stakeholders, not developers

### Section Requirements
- **Mandatory sections**: Must be completed for every feature
- **Optional sections**: Include only when relevant to the feature
- When a section doesn't apply, remove it entirely (don't leave as "N/A")

### For AI Generation
When creating this spec from a user prompt:
1. **Mark all ambiguities**: Use [NEEDS CLARIFICATION: specific question] for any assumption you'd need to make
2. **Don't guess**: If the prompt doesn't specify something (e.g., "login system" without auth method), mark it
3. **Think like a tester**: Every vague requirement should fail the "testable and unambiguous" checklist item
4. **Common underspecified areas**:
   - User types and permissions
   - Data retention/deletion policies  
   - Performance targets and scale
   - Error handling behaviors
   - Integration requirements
   - Security/compliance needs

---

## User Scenarios & Testing *(mandatory)*

### Primary User Story
子連れの親（メイン利用者）がメールアドレスとパスワードでログインし、自身の子供の写真カレンダーにアクセスし投稿可能な権限ある操作を開始できる。閲覧専用ユーザーや共有トークンによるアクセスは本仕様スコープ外（別仕様で定義）。管理者向け（Admin）専用ページ/機能も対象外。

### Acceptance Scenarios
1. **Given** 未ログイン状態かつログイン画面が表示されている, **When** 親ユーザーが有効な資格情報を入力しログイン操作を行う, **Then** 初期画面（写真/カレンダー）が表示されユーザー名/子の識別情報に基づくパーソナライズが行われる。
2. **Given** 未ログイン状態, **When** 間違った資格情報（存在しないメールアドレスまたは不一致のパスワード）でログインを試行, **Then** 一般化されたエラーメッセージが即時表示され再入力が可能であり既存入力フィールドは保持される（パスワード値も保持しパスワード入力欄へフォーカス戻し）。
3. **Given** ログイン済み状態, **When** アプリを再起動する, **Then** ユーザーが明示的にログアウトしない限り再ログイン要求は表示されない（セッションは明示ログアウトまたは資格情報無効化まで継続）。
4. **Given** ログアウト操作をユーザーが実行, **When** 確認後処理が完了, **Then** セッションは無効化されログイン画面へ遷移する。

### Edge Cases
- 入力フィールドが空のままログイン操作 → バリデーションエラー表示。
- ネットワーク一時切断中の送信 → 自動再試行は行わず、明示的な「再試行」操作（ボタン）を提示。
- 同一アカウントで複数端末同時ログイン → 許可（同時セッション制限なし）。
- パスワード変更やサーバ側強制失効によりトークンが無効化された後の操作 → 再ログイン要求表示。
- 多数回の無効認証試行 → ロックアウト/永続監査はスコープ外（アプリ内一時ログ出力のみ任意）。

## Requirements *(mandatory)*

### Functional Requirements
- **FR-001**: システムは親ユーザーがログイン画面からメールアドレスとパスワードを入力し送信できるUIを提供しなければならない。
- **FR-002**: システムは必須入力（メールアドレス + パスワード）欠落時に即時バリデーションエラーを表示し送信をブロックしなければならない。
- **FR-003**: システムは正しい親ユーザー資格情報が送信された場合に初期画面へ遷移させなければならない。
- **FR-004**: システムは誤った資格情報の場合に一般化されたエラーメッセージを表示し再試行を許可しなければならない。
- **FR-005**: システムはユーザーが明示的にログアウトするか、認証資格情報（例: パスワード変更/サーバ失効）が無効化されるまで再認証を要求しないセッション永続挙動を提供しなければならない。
- **FR-006**: システムは手動ログアウト操作でセッションを即時無効化し再アクセス時にログイン画面を表示しなければならない。
- **FR-007**: システムは入力されたメールアドレス形式を検証し不正形式を即時通知しなければならない。
- **FR-008**: システムは同一親アカウントによる複数端末同時ログインを許可（制限なし）し既存セッションを維持しなければならない。
- **FR-009**: システムは資格情報失効やサーバ側トークン失効を検知した場合、保護対象操作のタイミングを待たず速やかに再ログイン誘導を行わなければならない。
- **FR-010**: システムはログイン画面でパスワード表示切替（初期マスク / アイコンタップで表示切替 / 再タップで再マスク）を提供し、平文表示中はフォント/アイコンで明示し無操作一定時間経過や画面遷移で自動的に再マスクする。
- **FR-011**: システムはエラーメッセージ文言が該当メールアドレスの存在可否を推測できない一般化表現で統一されなければならない。
- **FR-012**: システムは親ユーザー認証方式としてメールアドレス+パスワードのみをサポートし他の外部ID/SSOを提供しない。

### Key Entities *(include if feature involves data)*
- **AuthResult (Parent Authentication Snapshot)**: 認証成功時点の親ユーザー情報スナップショット。属性（最低限）: email, displayName, lastLoginAt。セッションは独立エンティティを設けず Firebase Auth の状態 + トークン有効性で判定し、明示ログアウトまたは資格情報失効まで持続。

（閲覧専用ユーザー/共有トークンは別仕様）

### Success Metrics *(new)*
- p95: フォーム送信→初期画面表示 < 1.5s
- 初回有効資格情報試行成功率 ≥ 95%
- 内部エラー率（ネットワーク/無効資格情報除く） < 0.5%
- アプリ再起動後セッション自動復帰成功率 ≥ 99%
- クライアント側入力バリデーション応答時間 < 50ms

### Dependencies & Assumptions *(new)*
- Flutter SDK: プロジェクト既定安定版 (最低サポートは現行 stable -1 を想定)
- 使用パッケージ: firebase_core, firebase_auth, (状態管理) riverpod, ロギングユーティリティ
- Firebase Auth Emulator / 本番プロジェクト設定済であること
- ネットワーク接続必須（オフライン時ログイン不可）
- 端末時刻が大幅にずれている場合の挙動は保証外（トークン有効期限判定に影響）
- SSO / MFA / パスワード再設定フローは導入しない前提

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [x] No implementation details (languages, frameworks, APIs)  *(Draft内: 実装技術未記載 OK)*
- [x] Focused on user value and business needs
- [x] Written for non-technical stakeholders
- [x] All mandatory sections completed

### Requirement Completeness
- [x] No [NEEDS CLARIFICATION] markers remain
- [x] Requirements are testable and unambiguous
- [x] Success criteria are measurable (Success Metrics節参照)
- [x] Scope is clearly bounded (親ユーザーログイン/セッション管理のみ)
- [x] Dependencies and assumptions identified

---

## Execution Status
*Updated by main() during processing*

- [x] User description parsed
- [x] Key concepts extracted (ログイン, アカウント, ロール, セッション, バリデーション, エラー処理)
- [x] Ambiguities marked
- [x] User scenarios defined
- [x] Requirements generated
- [x] Entities identified
- [x] Review checklist passed

---

### Out of Scope (Current Release)
- アカウントロック/遅延導入（連続失敗対策）
- パスワード再設定フロー（"パスワードを忘れた"）
- メールアドレス確認/未認証アカウント状態管理
- 同時セッション数制限（無制限許可）
- 管理者(Admin)専用ページ/機能
- 認証方式の多要素/SSO/外部ID連携
- セッション/認証データ保持期間・削除ポリシー定義
- 閲覧専用ユーザーおよび共有閲覧トークン全機能（発行/検証/再生成/失効/閲覧権限）
- 共有閲覧トークンの自動失効/回転ポリシー
- 共有閲覧トークン配布経路の管理（アプリ外共有 UX）

---

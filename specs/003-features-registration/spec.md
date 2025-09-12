# Feature Specification: アカウント新規登録機能

**Feature Branch**: `003-features-registration`  
**Created**: 2025-09-12  
**Status**: Draft  
**Input**: User description: "signup registration: アカウント新規登録機能の追加（既存アプリ：カレンダー×デジタルフォトフレーム／対象：子連れの親子・祖父母・Admin・常時起動想定）。既にログイン画面あり。被撮影者と閲覧者が初回利用時に新規登録できるようにする。登録後はプロフィール・家族関係に紐付け、基本的な通知設定・プライバシー同意取得を含む。"

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

## User Scenarios (mandatory)

### Primary User Story
被撮影者（登録ユーザー）のみが、名前（表示名）・メールアドレス・パスワードの3項目で新規登録を行う。登録後はすぐに自分のアルバム（閲覧・編集可）へ遷移する。閲覧者はアカウントを作成せず、招待コード入力のみで匿名ログインし、共有されたアルバムを閲覧のみ行える。以後は常時起動でも継続利用できるよう、登録ユーザーはログイン状態が、匿名閲覧者は匿名ビューアセッションが端末に保持される。

### Acceptance Scenarios
1. Given 初回起動でログイン画面が表示されている, When 登録ユーザーが「新規登録」を選択し名前・メール・パスワードを入力する, Then アカウントが作成されホーム（自身のアルバム）に遷移する。
2. Given 登録ユーザーとしてログイン済み, When ホームを開く, Then 自身のアルバムの閲覧・編集（写真の追加・削除等）が可能である。
3. Given 閲覧者が招待コードを受け取っている, When ログイン画面の「招待コードで閲覧」からコードを入力する, Then 匿名ビューアセッションが作成され、共有アルバム（閲覧専用）に遷移する。
4. Given 招待コードが無効/期限切れ/取り消し済み, When 閲覧者がコードを入力する, Then 「無効なコード」である旨が表示され、再入力/発行者に確認する導線が提示される（情報漏えい防止の文言設計）。
5. Given 匿名ビューアセッションで常時起動している, When アプリを再起動する, Then 同一端末ではセッションが継続し、再度コード入力なしで同一アルバムを閲覧できる（有効期限内）。
6. Given 登録ユーザーが招待コード/セッションを無効化した, When 閲覧者が再表示を行う, Then セッションは失効し、再度有効な招待が必要である旨が表示される。

### Edge Cases
- 入力済み連絡先（メール）が既存アカウントと重複する場合は上書き不可。ログイン/リカバリ導線を提示。
- 通信不安定時の再送/再試行手段と進捗保持。
- 途中離脱（登録途中でアプリ終了）後の再開ポイント。
- 共有端末/フォトフレーム端末での誤アカウント作成防止。
- 招待コードの漏洩時に即時失効・再発行が必要なケース。
- 匿名ビューアの複数端末同時利用・再発行ポリシー。
- 匿名ビューアによる簡易リアクションの可否と悪用対策（許可する場合）。

## Requirements (mandatory)

### Functional Requirements
- FR-001: システムは、登録ユーザーのみが新規アカウントを作成できること。閲覧者はアカウントを作成しない。
- FR-002: ログイン画面に「新規登録」と「招待コードで閲覧」の導線があること。
- FR-003: 登録に必要な情報は「名前（表示名）・メールアドレス・パスワード」の3項目のみであること。メール形式検証と重複チェック、パスワードの基本的な強度検証（最低文字数など）を行うこと。
- FR-004: 登録後は直ちにホーム（自身のアルバム）へ遷移し、閲覧・編集が可能であること。
- FR-005: 登録時に家族関係の明示的な選択は不要であること（閲覧範囲はデフォルト設定とする）。
- FR-006: 閲覧者は「招待コードで閲覧」からコードを入力して匿名ビューアセッションを開始できること。
- FR-007: 無効/期限切れ/取り消し済みコード入力時は適切に案内すること（情報漏えい防止の文言）。
- FR-008: 匿名ビューアセッションは端末単位で保持され、再起動後も有効期限内は再入力なしで閲覧できること。
- FR-009: 重複登録は上書き不可とし、既存アカウント検出時はログイン/リカバリ導線を提示すること。
- FR-010: 表示言語は日本語のみ対応とすること。
- FR-011: 匿名閲覧者は閲覧のみ可能で、編集系操作はできないこと。
- FR-012: 招待コードは登録ユーザーが発行/無効化できること（コードの有効期限・取り消しの概念を持つ）。
- FR-013: 管理者（藤井写真館）のアカウント作成は本機能の範囲外とする。
- FR-014: プライバシーポリシー/利用規約への明示的同意の取得や、その同意バージョン・タイムスタンプの保存は本機能では行わない。
- FR-015: プロフィール情報は名前（表示名）のみで、画像は扱わない。

### Key Entities (include if feature involves data)
- User（ユーザー）: uid、email、displayName、status（有効/未確認/停止）。
- Album（アルバム）: 登録ユーザーが閲覧・編集可能な写真コレクション。招待により匿名閲覧者へ閲覧権限を共有。
- InviteCode（招待コード）: 発行者（登録ユーザー）、対象 Album、コード値、発行/有効期限、状態（有効/失効/取り消し）。
- ViewerSession（匿名ビューアセッション）: セッションID、対象 Album、端末バインド情報、有効期限、許可された操作の範囲。

---

## Review & Acceptance Checklist
GATE: Automated checks run during main() execution

### Content Quality
- [x] No implementation details (languages, frameworks, APIs)
- [x] Focused on user value and business needs
- [x] Written for non-technical stakeholders
- [x] All mandatory sections completed

### Requirement Completeness
- [x] No [NEEDS CLARIFICATION] markers remain
- [ ] Requirements are testable and unambiguous  
- [ ] Success criteria are measurable
- [x] Scope is clearly bounded
- [ ] Dependencies and assumptions identified

---

## Execution Status
Updated by main() during processing

- [x] User description parsed
- [x] Key concepts extracted
- [x] Ambiguities marked
- [x] User scenarios defined
- [x] Requirements generated
- [x] Entities identified
- [ ] Review checklist passed

---

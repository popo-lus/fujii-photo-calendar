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

## User Scenarios & Testing (mandatory)

### Primary User Story
被撮影者（保護者）および閲覧者（祖父母など）が、アプリ初回起動時に自身のアカウントを新規登録し、必須のプライバシー同意を行った上でプロフィール作成と家族関係の紐付けを完了する。以後は常時起動（デジタルフォトフレーム的）でも継続利用できるよう、ログイン状態が維持され、必要な通知を受け取れる。

### Acceptance Scenarios
1. Given 初回起動でログイン画面が表示されている, When ユーザーが「新規登録」を選択し必須情報を入力・同意を完了する, Then アカウントが作成され初期プロフィール設定画面に進める。
2. Given 新規登録直後, When ユーザーが自分の家族関係（例：保護者/祖父母）を選択し家族へ参加または家族を作成する, Then タイムライン閲覧対象が家族単位で決まり、ホームに遷移する。
3. Given 新規登録直後, When 通知受信可否の初期設定を行う（受信/最小限/オフなど）, Then 選択内容が保存され、以降の配信に反映される。
4. Given 閲覧者が保護者からの招待を受け取っている, When 招待に従って新規登録を行う, Then 既存の家族に正しく紐付いてホームへ遷移する。
5. Given 同意を拒否した場合, When 同意画面で「同意しない」を選択する, Then アカウント作成は完了せず、同意が必要である旨が明確に案内される。

### Edge Cases
- 入力済み連絡先（メール/電話）が既存アカウントと重複する場合の挙動（上書き不可・ログイン案内）。
- 通信不安定時の再送/再試行手段と進捗保持。
- 未成年の子どもの扱い（アカウントを作るのは保護者のみ、子どもはプロフィールとして管理）。
- 途中離脱（同意・プロフィール途中でアプリ終了）後の再開ポイント。
- 共有端末/フォトフレーム端末での誤アカウント作成防止。

## Requirements (mandatory)

### Functional Requirements
- FR-001: システムは、被撮影者（保護者）および閲覧者が初回利用時に新規アカウントを作成できること。
- FR-002: 既存のログイン画面から、明確な「新規登録」導線が提供されていること。
- FR-003: アカウント作成には必須識別情報の入力が必要であり、形式・重複の検証が行われること。[NEEDS CLARIFICATION: 必須項目（メール/電話/氏名/パスワード等）と検証基準]
- FR-004: アカウント有効化前に、プライバシーポリシーおよび利用規約への明示的同意が取得され、同意バージョンとタイムスタンプが保存されること。
- FR-005: 登録フローで初期通知設定（例：アップロード通知、コメント/リアクション、キャンペーン情報など）を選択でき、保存されること。[NEEDS CLARIFICATION: 初期デフォルト値と通知種別の範囲]
- FR-006: 登録完了時にプロフィール（表示名、アイコン等の最低限）作成/編集が可能であること。[NEEDS CLARIFICATION: 初期プロフィール項目の確定]
- FR-007: 家族関係の紐付けが可能であること（新規に家族を作成する、既存家族へ参加する）。[NEEDS CLARIFICATION: 紐付け手段（招待リンク/コード/管理者承認）]
- FR-008: 役割（保護者/閲覧者）によってアクセス可能機能が適切に制御されること（例：閲覧者はアップロード不可）。[NEEDS CLARIFICATION: 既存権限体系との整合]
- FR-009: 重複登録を防止するため、既存アカウント検出時にはログイン/リカバリ導線を提示すること。
- FR-010: 常時起動想定に対応し、初期設定で「ログイン状態の保持」の選択肢が提供されること。[NEEDS CLARIFICATION: 既定の保持期間/条件]
- FR-011: エラーメッセージはユーザーに理解可能な文言で表示され、主要言語をサポートすること。[NEEDS CLARIFICATION: 対応言語（日本語/英語 など）]
- FR-012: 子ども本人のアカウント作成は想定せず、保護者が子どもプロフィールを管理できること（年少者保護）。[NEEDS CLARIFICATION: 年齢基準/同意要件]
- FR-013: 管理者（藤井写真館）のアカウント作成は本機能の範囲外か、別手段（例：運用で作成）とすること。[NEEDS CLARIFICATION: 管理者の登録フロー含有可否]

### Key Entities (include if feature involves data)
- Account（アカウント）: ID、ロール（保護者/閲覧者/管理者）、状態（有効/未確認/停止）
- Profile（プロフィール）: 表示名、アイコン等の基本属性（技術仕様に依存しない抽象レベル）
- Family（家族）: 家族単位のグループ定義、表示名
- Relationship（関係）: Account と Family の関係（保護者/祖父母/その他閲覧者）
- NotificationPreference（通知設定）: 通知種別ごとの受信可否/頻度
- Consent（同意）: ポリシー/規約のバージョン、同意日時、同意者
- Invitation/JoinToken（参加トークン）: 既存家族に参加するための合意に基づく参照子 [NEEDS CLARIFICATION: 有効期限/承認フロー]

---

## Review & Acceptance Checklist
GATE: Automated checks run during main() execution

### Content Quality
- [ ] No implementation details (languages, frameworks, APIs)
- [ ] Focused on user value and business needs
- [ ] Written for non-technical stakeholders
- [ ] All mandatory sections completed

### Requirement Completeness
- [ ] No [NEEDS CLARIFICATION] markers remain
- [ ] Requirements are testable and unambiguous  
- [ ] Success criteria are measurable
- [ ] Scope is clearly bounded
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

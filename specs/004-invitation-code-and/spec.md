# Feature Specification: Invitation Code & User Photo Upload

**Feature Branch**: `004-invitation-code-and`  
**Created**: 2025-09-13  
**Status**: Draft  
**Input**: User description: "カレンダー×デジタルフォトフレームアプリ。目的: ユーザー(子連れの親子)が藤井写真館で継続的に写真を撮りたいと思わせる。ターゲット: 被撮影者(親子)、閲覧者(祖父母ほか)、Admin(藤井写真館)。追加したい機能: 1) 招待コード作成機能(閲覧のみ・QR/URL共有)、2) 写真アップロード機能(被撮影者がスマホの共有メニューからもアップロード可能)"

---

## ⚡ Quick Guidelines
- ✅ Focus on WHAT users need and WHY
- ❌ Avoid HOW to implement (no tech stack, APIs, code structure)
- 👥 Written for business stakeholders, not developers

### Section Requirements
- Mandatory sections: Must be completed for every feature
- Optional sections: Include only when relevant to the feature
- When a section doesn't apply, remove it entirely (don't leave as "N/A")

---

## User Scenarios & Testing (mandatory)

### Primary User Story
- 被撮影者として、家族スペース/アルバムの写真を祖父母などの「閲覧者」に安全に見せるため、閲覧のみ可能な「招待コード」を作成し、URLやQRコードで共有したい。
- 被撮影者として、写真館の写真だけでなく、自分のスマホで撮影した子どもの写真も同じスペースにアップロードし、家族で一元的に閲覧・鑑賞したい。スマホの共有メニューからも素早く追加できると便利。
- 閲覧者として、受け取ったコード/QR/URLを使って簡単にアクセスし、最新の家族写真を時系列またはカレンダー形式で閲覧したい（編集は不要）。
 

### Acceptance Scenarios
1. Given 被撮影者が家族スペースにログイン済み, When 「閲覧者用の招待コードを作成」操作を行う, Then 「閲覧のみ」の権限を持つ招待コードが生成され、共有可能なURLとQRコードが表示される。
2. Given 招待コードが有効, When 閲覧者がURL（例: fujii://invite/XXXX）を開く, Then 被撮影者アカウントで閲覧可能なすべての写真を閲覧できる（アップロード/編集/削除は不可）。
3. Given 被撮影者がアプリ内から写真を選択, When アップロードを実行する, Then 写真が家族スペースに追加され、任意メモ（キャプション）を付与して保存でき、アップロード完了のフィードバックが表示される。
4. Given スマホ上の任意の写真アプリ, When 共有メニューから本アプリを選択してアップロードを実行する, Then 選択した写真が対象スペース/アルバムへ追加される（中断時はユーザーに分かる形で再試行可能）。
5. Given 被撮影者が発行済み招待コード一覧を開く, When コードの失効/削除を実行する, Then 以後そのコードではアクセスできなくなる。
6. Given 期限切れの招待コード, When 閲覧者がアクセスを試みる, Then 「コードが無効/期限切れ」のメッセージと再取得の案内が表示される。

### Edge Cases
- 招待コードの有効期限切れ、上限回数超過、被撮影者による明示的な失効。
- スコープは被撮影者と閲覧者で同一（アクセス権限のみ異なる）。
- 閲覧者は編集/ダウンロード/再共有は不可（閲覧のみ）。
- 共有メニュー経由のアップロード中にアプリがバックグラウンド化、オフライン、タイムアウト、重複ファイル、非常に大きいファイル、非対応形式。
 
- 複数の招待コードがあってもアクセス範囲は同一（閲覧のみ）で競合しない（優先順位の概念は不要）。

---

## Requirements (mandatory)

### Functional Requirements
- FR-001: 被撮影者は、特定のスコープ（家族スペース/アルバム）に対して閲覧のみ可能な招待コードを作成できること。
	- スコープは被撮影者と閲覧者で同一。閲覧者は同一スコープに対し「閲覧のみ（read-only）」権限を持つ。
- FR-002: システムは、招待コードから共有可能なURLおよびQRコードを生成できること。
	- 共有URLはカスタムスキーム fujii://invite/{CODE} を採用する（本機能ではHTTPS/Universal Linksは対象外）
- FR-003: 閲覧者は、URLから被撮影者アカウントで閲覧可能なすべての写真にアクセスし、閲覧できること（編集・アップロード・削除は不可）。
	- アクセスできる範囲（スコープ）は被撮影者の可視範囲と同一であり、閲覧者は閲覧専用。
- FR-004: 被撮影者は、発行済み招待コードの一覧/状態（有効・失効・期限・使用回数・最終利用日時）を確認し、個別に失効・再発行できること。
- FR-005: システムは、招待コードの有効期限、スコープ、権限を厳格に適用し、期限切れ/失効コードのアクセスを拒否すること。
- FR-006: 閲覧者の認証/識別は匿名可（アカウント作成不要）。招待コード/URL起点で匿名ビューアセッションを生成し端末に保持する。表示名（ニックネーム）は任意、メールは不要。（過去ドキュメント「003-features-registration」に準拠）
- FR-007: 被撮影者は、アプリ内から端末内の写真を選択してアップロードできること（進行状況表示、キャンセル、再試行を含む）。
- FR-008: 被撮影者は、iPhone（iOS）およびAndroidの共有メニュー（シェアシート/共有インテント）から本アプリを選択し、対象スコープを指定して写真をアップロードできること。
- FR-009: システムは、画像であればアップロードを許可する（形式制限なし）。本featureではサイズ上限は設けない。OS/ストレージ等の制約で拒否された場合は、ユーザーに明確な理由を提示する。
- FR-010: アップロードされた写真には撮影日時を記録し、任意のメモ（キャプション）の保存に対応すること。その他メタデータは本featureでは必須としない。
- FR-011: システムは、ネットワークエラー等の一時的失敗に対して再試行/再開を提供し、ユーザーに結果を通知すること。
- ~FR-012: ユーザー写真のモデレーション/通報対応~ → 本featureの範囲外（実装なし）
- ~FR-013: 新規写真追加時、関係者への通知（アプリ内/プッシュ/メール等）~ → 本featureの範囲外（実装なし）
- FR-014: プライバシー: 招待コードは閲覧のみのアクセス権を付与し、個人情報や内部IDをURL/QRに含めないこと。アクセスはいつでも被撮影者が取り消せること。
- FR-015: セキュリティ: コードは推測困難な強度を持ち、試行回数制限やレート制限を適用すること。アクセスログは90日間保持し、自動削除する（発行者の削除要請時は即時削除）。
- ~FR-016: 分析: コードごとの利用回数/最終利用日時/発行者を集計~ → 本機能では不要（最低限の管理のみ）

### Key Entities (include if feature involves data)
- InvitationCode: 表示名/説明（任意）、code、shareableUrl、qrPayload、scope（space/album）、permissions（read-only）、expiresAt、status（active/revoked/expired）、usageCount、lastUsedAt、createdAt、createdBy。
- Viewer: role=viewer、joinedVia（code/url/qr）、displayName（任意）、同意（利用規約/プライバシー）。
- Space/Album: 写真の論理的なまとまり。可視範囲（private/with-code）。
- Photo: id、owner（admin/user）、source（user-upload/admin-added）、createdAt、visibility、caption（任意）、基本メタデータ（撮影日時など）。
- UploadSession: files、totalSize、progress、status（queued/running/succeeded/failed/canceled）、error（任意）。

---

## Review & Acceptance Checklist
- [x] No implementation details (languages, frameworks, APIs)
- [x] Focused on user value and business needs
- [x] Written for non-technical stakeholders
- [x] All mandatory sections completed
- [x] No [NEEDS CLARIFICATION] markers remain
- [x] Requirements are testable and unambiguous  
- [x] Success criteria are measurable
- [x] Scope is clearly bounded
- [x] Dependencies and assumptions identified

---

## Execution Status
- [x] User description parsed
- [x] Key concepts extracted
- [x] Ambiguities marked
- [x] User scenarios defined
- [x] Requirements generated
- [x] Entities identified
- [x] Review checklist passed

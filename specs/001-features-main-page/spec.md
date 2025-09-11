# Feature Specification: カレンダー×デジタルフォトフレームアプリ：月カレンダー閲覧

**Feature Branch**: `[001-features-main-page]`  
**Created**: 2025-09-11  
**Status**: Draft  
**Input**: User description: "カレンダー×デジタルフォトフレームアプリ\n目的: ユーザー(子連れの親子)が藤井写真館で継続的に写真を撮りたいと思わせる\nターゲットユーザー: 被撮影者=子連れの親子（写真アップロード・管理・撮影促進）、閲覧者=祖父祖母等（閲覧・簡単なリアクション）、Admin=藤井写真館（写真追加・キャンペーン配信）。常時起動に近いデジタルフォトフレーム。\n主要機能（本仕様の対象）: 月カレンダー閲覧（メイン）。日付のみ表示。背景に複数写真（正方形グリッド）、Admin 追加写真は一回り大きく。スライドショーで遷移。過去の同月に撮影した写真を表示。写真館で未撮影の月には撮影促進プレースホルダーを表示。"

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
子連れの親（被撮影者）または祖父母などの閲覧者として、アプリを起動すると今月の「日付のみの月カレンダー」が表示され、その背後に「過去の同月に撮影した写真」の正方形グリッドが表示される。写真は自動的にスライドショーで入れ替わり、藤井写真館（Admin）が追加した写真は他の写真より一回り大きく強調される。該当月に藤井写真館での撮影実績がない場合は、「撮影予定を入れましょう」「来店をおすすめします」といったプレースホルダーが表示され、撮影を促される。

### Acceptance Scenarios
1. **Given** 対象月に藤井写真館での撮影実績がある過去写真が存在する、**When** アプリでその月のカレンダーを開く、**Then** 背景グリッドに当該月に撮影された写真のみが表示され、Admin 追加写真は他より一回り大きく表示される。
2. **Given** 対象月に藤井写真館での撮影実績が一切ない、**When** アプリでその月のカレンダーを開く、**Then** 背景写真の代わりに「撮影予定を入れましょう」「来店をおすすめします」などのプレースホルダーが表示される。
3. **Given** 背景グリッドに複数の写真がある、**When** ユーザーが操作をしなくても時間経過する、**Then** 写真は自動でスライドショーとして切り替わる（デフォルト切替間隔=5秒±0.5秒、クロスフェード=300ms、黒フラッシュなし）。
4. **Given** Admin が特定の写真を追加済み、**When** カレンダーを表示する、**Then** その写真はグリッド内で他より大きく表示され目に留まりやすい。
5. **Given** 対象月に「藤井写真館での撮影実績」はないがユーザー個人の当該月写真は存在する、**When** その月のカレンダーを開く、**Then** 背景にユーザー個人の当該月写真を表示しつつ、撮影促進プレースホルダーも同時に表示する（両立表示）。
6. **Given** 撮影日時メタデータが欠落/誤っている写真がアップロードされる、**When** データベース登録時のバリデーションが実行される、**Then** 当該写真は登録不可（もしくは無効として除外）となり、月カレンダー表示には一切影響しない（表示時の特別なフォールバック不要）。
7. **Given** 写真を撮影したタイムゾーンと閲覧端末のタイムゾーンが異なる、**When** カレンダーを表示する、**Then** 月の判定は「写真を撮影したタイムゾーン」における暦日で行われ、閲覧端末のタイムゾーンには影響されない。
8. **Given** 月カレンダーが表示されている、**When** ユーザーが左右にスワイプする、**Then** 右スワイプで前月、左スワイプで翌月に遷移できる。
9. **Given** 閲覧者が共有URL/QRコードから本ページにアクセスする（アカウント無し）、**When** ページを開く、**Then** 閲覧者向けの表示バリアントが表示される（被撮影者向けの管理・促進要素は非表示）。
10. **Given** 被撮影者（親）がアカウントでアクセスする、**When** ページを開く、**Then** 被撮影者向けの表示バリアントが表示される（例: 撮影促進プレースホルダー、ナビゲーション等）。

### Edge Cases
- 対象月にユーザー個人の写真はあるが「藤井写真館での撮影実績」がない場合の扱い → ユーザー個人の当該月写真を背景に表示しつつ、撮影促進プレースホルダーも併記する（両立表示）。
- 写真が非常に多い/少ない（0枚、1枚、極端に多い）の場合の表示ルール → グリッドの最大枚数は端末のサイズに合わせ、写真が多い時はランダムで表示する。
- 写真の撮影日時メタデータが欠落/誤っている場合（同月判定不可） → データベース登録時にバリデーションで弾く（登録不可/無効化）。表示時は考慮不要（対象外として扱う）。
- タイムゾーンの違いにより月境界がずれる場合 → 写真を撮影したタイムゾーンにおける日付で判定を行う。
- オフライン/低帯域時に写真取得ができない場合 → カレンダーは表示し、写真はキャッシュ/プレースホルダーにフォールバックする。

## Requirements *(mandatory)*

### Functional Requirements
- **FR-001**: System MUST 月カレンダーを表示する（「日付のみ」、予定やイベントは表示しない）。
- **FR-002**: System MUST デフォルトで現在の月を表示する（表示月の決定は端末設定に準拠する）。
- **FR-003**: System MUST 左右スワイプ操作で前後の月（前月/翌月）に移動できるようにする。
- **FR-004**: System MUST カレンダー背後に正方形の写真グリッドを表示する（写真は複数枚）。
- **FR-005**: System MUST グリッド内の写真が自動でスライドショーのように切り替わる。
- **FR-006**: System MUST Admin が追加した写真を他の写真より一回り大きく表示する（ユーザーが追加した写真を表示するグリッドの４個分のサイズ）。
- **FR-007**: System MUST 背景写真の選定を「対象月と同じ月に撮影された写真（年は問わない）」に限定する。
- **FR-008**: System MUST 「藤井写真館での撮影実績」がその月に存在しない場合、撮影促進プレースホルダー（例: 「撮影予定を入れましょう」「来店をおすすめします」）を表示する。なお当該月のユーザー個人写真が存在する場合は、それらを背景に表示しつつプレースホルダーも表示する（両立表示）。
- **FR-009**: System MUST 背景写真にユーザー個人の写真を含める。スタジオ撮影有無の判定とは区別して扱う。
- **FR-010**: System MUST Admin 追加写真が存在する場合、最低1枚は必ず表示する。
- **FR-011**: System MUST このページの表示内容をロール別（被撮影者/閲覧者）に分ける。被撮影者向け表示と閲覧者向け表示でコンテンツ構成やCTAを適切に切り替える（具体的な差分は別途定義）。
- **FR-012**: System MUST 失敗時フォールバック：写真の取得に失敗してもカレンダー本体は表示を継続し、背景はキャッシュまたはプレースホルダーへフォールバックする。
- **FR-013**: System SHOULD コピー文言は日本語のみで表示する（多言語対応は行わない）。
- **FR-014**: System MUST 「同月」判定はデータベース登録時にバリデーション済みの「撮影日時（その写真の撮影タイムゾーン基準の暦日）」に基づくとする。撮影日時が欠落/不正な写真は登録不可または無効化し表示対象外とする（表示時のフォールバック処理は不要）。
- **FR-015**: System SHOULD プライバシー/安全性：子どもの写真は許可された閲覧者にのみ表示されるべき。
 - **FR-016**: System MUST グリッドの最大表示枚数は端末のサイズ（表示領域）に基づいて決定し、写真が最大枚数を超える場合はランダムに選択して表示する。
 - **FR-017**: System MUST 閲覧者はアカウント不要で共有URL/QRコードから本ページを閲覧できるようにする（共有方法の安全性・有効期限・アクセス範囲・失効手段は別途定義）。
 - **FR-018**: System MUST アプリ起動時に本ページ（月カレンダー）を表示する。

*Example of marking unclear requirements:*
- （曖昧な要件の例・本ページでは対象外）
- **FR-X01**: 本ページでは認証には触れない。認証は「メール/パスワード」と「SSO」を利用予定で、詳細は別の認証仕様で定義する。

### Key Entities *(include if feature involves data)*
- **Photo（写真）**: 撮影日時（月判定に使用）、出所（ユーザー/藤井写真館/Admin 追加）、表示優先度（Admin 強調）、表示可否（権限/共有範囲）。
- **Calendar Month View（月ビュー）**: 対象の年・月、日付グリッド、背景写真グリッド、スライドショー状態、CTA（プレースホルダー）。
- **User Roles（ユーザー種別）**: 被撮影者/閲覧者/Admin。閲覧可否・写真追加の権限に違い。
- **CTA（プレースホルダー）**: 表示条件（スタジオ撮影実績の有無）、文言候補、遷移先（予約/案内などは別機能）。
- **Share Link（共有URL/QR）**: アクセス主体=閲覧者、対象スコープ（どの被写体/アルバム/月に紐付くか）、有効期限/失効方法、再共有可否（詳細は別途定義）。

---
## Non-Functional Constraints（本ページ関連）

- 対応環境: タブレット（8〜9インチ）を主対象、横画面を基本。スマホでも閲覧可能（レスポンシブ）。
- UX基本挙動: アプリ起動時は常に本ページ（月カレンダー）を表示するフォトフレーム的挙動。
- データ処理: 写真はクラウド同期。オフライン時はキャッシュで表示（FR-012に準拠）。

## Measurable Success Criteria（定量的な成功基準）

測定条件（特記なき限り）:
- ターゲット端末: 8〜9インチクラスの現行タブレット（2022年以降、A14/M1/同等SoC）。
- ネットワーク: 良好時=下り20Mbps/遅延<50ms、オフライン時=機内モード（事前に月データ/写真をキャッシュ済み）。
- 指標の統計: 50パーセンタイル(p50)および95パーセンタイル(p95)で評価。

1) 初回表示/描画
- カレンダー本体の初回描画完了（数字グリッドが視認可能）: p95 ≤ 1.0s（p50 ≤ 0.6s）。
- 最初の背景写真が表示されるまで: オンライン p95 ≤ 2.0s（p50 ≤ 1.2s）/ オフライン（キャッシュ） p95 ≤ 1.0s（p50 ≤ 0.6s）。

2) 操作応答性/アニメーション
- スワイプ操作の入力から月遷移アニメーション開始まで: p95 ≤ 50ms。
- 月遷移アニメーションの所要時間: 250〜350ms（黒フラッシュ/白点滅なし）。
- スライドショー切替間隔: 5.0s ± 0.5s（連続で同一写真が表示されないこと=100%）。
- 切替中のフレームドロップ率: p95 ≤ 5%。

3) 露出/表示要件の達成度
- 当該月に Admin 追加写真が1枚以上ある場合、ページ表示から最初の Admin 写真の露出まで: p95 ≤ 10s。
- 当該月にスタジオ撮影実績が無い場合、撮影促進プレースホルダーが視認可能になるまで: p95 ≤ 2.0s。

4) 信頼性/安定性
- 本ページ閲覧セッションのクラッシュフリー率: ≥ 99.9%。
- 画像取得エラー時のユーザー可視の欠落（壊れた画像アイコン/未処理の空白）: p95 = 0 件（適切にプレースホルダーへフォールバック）。

5) 文言/ローカライズ
- 表示文言の日本語適用率: 100%（英語等の混在がない）。

注: 上記は本ページに限定した基準。将来の端末レンジ拡大や極端な低速回線向けの基準は別途見直す。

## Assumptions & Out of Scope（前提・本イシュー対象外）

- Admin側の管理UIはWebで提供予定（今回のプロジェクト対象外）。
- 本イシューは「アプリ基本構造」と「月カレンダー閲覧（メインページ）」に限定。以下は将来イシュー:
   - 日カレンダー（当該日の写真一覧・タイトル/メモ表示）
   - ユーザー登録/ログイン（認証はメール/パスワード＋SSOを予定、詳細は別仕様）
   - チュートリアル、通知、招待、写真アップロード/ダウンロード、リクエスト機能、ライフアルバムモード

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [x] No implementation details (languages, frameworks, APIs)
- [x] Focused on user value and business needs
- [x] Written for non-technical stakeholders
- [x] All mandatory sections completed

### Requirement Completeness
- [x] No [NEEDS CLARIFICATION] markers remain
- [x] Requirements are testable and unambiguous  
- [x] Success criteria are measurable
- [x] Scope is clearly bounded
- [x] Dependencies and assumptions identified

---

## Execution Status
*Updated by main() during processing*

- [x] User description parsed
- [x] Key concepts extracted
- [x] Ambiguities marked
- [x] User scenarios defined
- [x] Requirements generated
- [x] Entities identified
- [x] Review checklist passed

---

ios/ or android/
# 実装計画: 招待コード & ユーザー写真アップロード

ブランチ: 004-invitation-code-and | 日付: 2025-09-14 | 仕様: /Users/lupisys/dev_project/fujii-photo-calendar/specs/004-invitation-code-and/spec.md
入力: 上記パスの機能仕様

## 実行フロー（/plan コマンドの範囲）
1. 入力パスから機能仕様を読み込み → OK
2. テクニカルコンテキストを充足（NEEDS CLARIFICATION の確認）→ 仕様更新で解消済み
3. 憲法チェックを実施 → PASS（下記参照）
4. Phase 0 実行 → research.md 生成
5. Phase 1 実行 → data-model.md, contracts/*, quickstart.md 生成
6. 設計後の憲法チェック → PASS
7. Phase 2 の計画（tasks.md は作成しない）→ 下記に記述

重要: 本 /plan は手順7で停止します。Phase 2 の tasks.md は /tasks コマンドで作成します。

## 概要
本機能は、カスタムスキームのディープリンク経由での閲覧専用アクセスと、オーナーと同一スコープへのユーザー写真アップロードを提供します。主なポイント:
- 招待アクセス: カスタムスキーム fujii://invite/{CODE}。閲覧者はオーナー可視のすべての写真を閲覧専用で閲覧可能。
- アップロード: アプリ内ピッカーから。撮影日時（capturedAt）と任意メモを保存。画像形式は制限なし、サイズ上限は本機能では設けない。
- 範囲外: 通知、モデレーション/通報、コード別分析、Universal Links。
- セキュリティ/運用: 強度の高いコード、レート制限、アクセスログは90日保持し自動削除（発行者の削除要請は即時対応）。

## テクニカルコンテキスト
- 言語/ランタイム: Flutter（Dart, stable）
- 主要依存: Firebase（Auth/Firestore/Storage）、Riverpod、AutoRoute、uni_links
- ストレージ: Firebase Firestore（メタデータ/招待）、Firebase Storage（画像）
- テスト: Flutter test + integration_test；深リンクは実機E2E
- 対応プラットフォーム: iOS / Android（モバイル）
- プロジェクト種別: モバイル
- 性能目標: スムーズなUI、月カレンダー読み込みの実用的レイテンシ、アップロードのリトライ耐性
- 制約: 深リンクはカスタムスキームのみ、画像はサイズ上限なし（OS/Storageの実際の制約には従う）
- 規模/スコープ: シングルファミリー想定、同時実行は中程度、エミュレータ+シードでローカル検証

## 憲法チェック
シンプリシティ:
- プロジェクト数: 1（モバイルアプリ）。新規マイクロライブラリなし。
- フレームワーク利用: Flutter/Firebase SDK を直接利用。不必要な抽象化は避ける。
- データモデル: 追加は最小（招待、写真メタデータ）。余計なDTOなし。

アーキテクチャ:
- 新規ライブラリなし。契約は specs/contracts に文書化。
- 別CLIなし。エミュレータ用シードはインフラリポジトリが提供。

テスト（必須）:
- 契約レベルのTDDを意図（/tasks で tasks.md 生成）。
- 深リンクフローの統合テストを計画。

可観測性:



## 監査結果（抜け漏れチェック）
- 深リンクのプラットフォーム設定の明示性: Android（intent-filter）、iOS（URL Schemes）がタスクとして明記されているか → 追記推奨。
- アプリ内ディープリンク処理の網羅: 初期URI（コールドスタート）と実行時URI（フォアグラウンド）の両方のテストケース → 明記済みだが、テスト項目を具体列挙推奨。
- 招待コード検証UX: 無効/期限切れ/失効時のUI文言・再取得導線 → 明示タスク化を推奨。
- セキュリティ/レート制限: ルールのみでは実現困難なレート制限の扱い（クライアント側スロットリング/バックオフ等）→ 方針タスク化を推奨。
- アクセスログ保持90日: FirestoreのTTLポリシー（expiresAt 相当フィールド）設定とログコレクションのスキーマ定義 → 具体タスクの追加を推奨。
- Firestore Security Rules: 閲覧者のread-only保証、招待有効性チェックのルール改修とルールテスト → 具体タスクの追加を推奨。
- エミュレータ接続: アプリ側からEmulatorへ接続する設定（切替手段含む）の確認 → タスク化推奨。
  
- 進行状況/再試行/キャンセル（FR-011）: UI/リトライポリシー/再開可否の最小要件をタスクとして具体化推奨。
- ダウンロード/再共有の抑止: 閲覧者側UIからの抑止確認とE2Eテスト → タスク化推奨。
 - ドキュメント更新: README/quickstart に深リンク起動方法（実機/シミュレータ）の補足 → タスク化推奨。

## 推奨タスク順序（概要・参照用。tasks.md は別途 /tasks で生成）
1. 環境準備
   - エミュレータ起動/シード投入（infra）と、アプリのEmulator接続切替の確認
   - ログカテゴリ（invite/open/upload/access）方針の整理
2. ディープリンク基盤
   - Android: intent-filter 追記（custom schemeのみ）
   - iOS: URL Schemes 追加（Universal Linksは対象外）
   - アプリ: 初期URI/実行時URIのハンドリング、Inviteコード抽出→送信→ナビゲーション
   - テスト: 正常系/無効/期限切れ/失効/ネットワークエラー
3. 招待コードUX仕上げ
   - エラーメッセージと再取得導線の文言/画面挙動
   - ログ出力の確認
4. セキュリティ/監査
   - Firestore Security Rules 改修（閲覧者 read-only、招待の有効性）
   - ルールテスト作成
   - アクセスログ用スキーマ定義＋TTL設定（90日）
   - レート制限のクライアント側スロットリング/バックオフ
5. アップロード機能（アプリ内ピッカー）
   - 画像形式制限なし・サイズ上限なしの受け入れ
   - capturedAt と memo の保存（既存配列スキーマ互換）
   - 進行状況/キャンセル/再試行（最小）
6. 互換性/回帰
   - 既存のカレンダー表示・既存写真の破壊的変更がないことを確認
7. QA/ドキュメント
   - 手動テスト表（デバイス/OS別）
   - quickstart/README の補足（深リンク起動）
8. リリース準備
   - フラグ有無の最終確認、ビルド/署名、ストア提出前チェック（必要に応じて）

## リスク/前提
- レート制限はクライアントのみでは限定的。将来的にFunctions等の導入で強化の余地あり。
- アクセスログの90日TTLはFirebaseコンソール設定が必要（本リポジトリ外作業）。
 
ドキュメント（本Feature）
- contracts/（Phase 1）

ソースコード（リポジトリルート）
- /app にモバイルアプリ（Flutter）
- バックエンドは新設せず、Firebase（Auth/Firestore/Storage）を利用

## Phase 0: アウトライン & リサーチ
research.md で解消・確定した事項:
- 閲覧者のダウンロード/再共有 → 本機能では禁止。
- 複数招待コードの重複 → 競合なし（いずれも同一の閲覧専用スコープ）。
- 深リンクのスコープ → オーナー可視の全写真に固定。
- ログ保持 → 90日保持、 自動削除、発行者の削除要請は即時対応。

出力: /specs/004-invitation-code-and/research.md

## Phase 1: 設計 & 契約
1) データモデルを data-model.md に抽出（Invitation、Photo ほか）
2) contracts/ を生成:
   - deep-link.md（カスタムスキーム仕様とフロー）
   - firestore-schemas.md（invites, calendar ドキュメント）
   - security-rules.md（閲覧専用アクセス、招待検証の方針）
   - storage-structure.md（user-uploads / studio-uploads のパス）
3) Quickstart を生成（エミュレータ＋シード＋起動）

出力:
- /specs/004-invitation-code-and/data-model.md
- /specs/004-invitation-code-and/contracts/*
- /specs/004-invitation-code-and/quickstart.md

## Phase 2: タスク化アプローチ（ここでは tasks.md を作らない）
タスク生成の方針:
- contracts / data-model を基にタスク化。各契約 → コントラクトテスト [P]。
- アップロード + 深リンクの統合テストを優先。その後にUI配線・プラットフォーム設定検証。

順序付け:
- 契約 → コントラクトテスト → 統合テスト → 実装（招待URLオープン）→ 実装（アップロード）→ 仕上げ

見込み出力: 約25タスク（/tasks が作成）。

## 複雑性トラッキング
憲法からの逸脱なし。

## 進捗トラッキング
フェーズ状況:
- [x] Phase 0: Research 完了（/plan）
- [x] Phase 1: Design 完了（/plan）
- [x] Phase 2: Task 計画を記述（/plan）
- [x] Phase 3: Tasks 生成（/tasks）
- [ ] Phase 4: 実装完了
- [ ] Phase 5: 検証完了

ゲート状況:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
- [ ] Complexity deviations documented

---
Constitution v2.1.1 に基づく - /memory/constitution.md を参照
# リポジトリガイドライン

## プロジェクト構成 / モジュール
- `app/`: Flutter アプリ本体。`lib/` 配下はレイヤ別:
  - `core/`（エラー・ユーティリティ・ログ）
  - `data/`（サービス・マッパー・実装リポジトリ）
  - `domain/`（エンティティ・リポジトリIF・ユースケース）
  - `presentation/`（ルーター・画面・VM）
  - `providers/`（DI/Provider）
- `specs/`（仕様・計画・クイックスタート）、`scripts/`（補助スクリプト）、`.github/`（CI）、`templates/`・`memory/`（執筆補助）。

## ビルド / テスト / 開発コマンド
- FVM セットアップ: `cd app && fvm install 3.32.0 && fvm use 3.32.0 --force`
- 依存取得: `fvm flutter pub get`
- コード生成: `fvm dart run build_runner build --delete-conflicting-outputs`
- 静的解析: `fvm flutter analyze`（または `app/` で `../scripts/format.sh`）
- 実行: `fvm flutter run`（例: `-d chrome`）
- リリースビルド: `fvm flutter build ios|android|web`
- テスト: `fvm flutter test`（テストは `app/test/` に `*_test.dart`）

## コーディング規約 / 命名
- `flutter_lints` 準拠（`app/analysis_options.yaml`）。2スペース、`print` 非推奨。
- ファイル: `snake_case.dart`、型: `PascalCase`、変数/関数: `lowerCamelCase`。
- レイヤ依存: `presentation → providers → domain → core`。`data` は `domain` の実装。逆方向の import を禁止。
- 命名パターン: `*Entity` / `*Repository` / `*Usecase` / `*Service` / `*Mapper` / `*Provider`。
- 整形/Lint 一括: `app/` で `../scripts/format.sh`（`dart format lib test` と `flutter analyze` を実行）。

## テスト方針
- フレームワーク: `flutter_test`。場所: `app/test/`、命名: `*_test.dart`。
- 重点: `core`/`domain` を優先して単体テスト。`data` は Firebase をモック/フェイク。
- 実行例: `fvm flutter test`（カバレッジは `--coverage`）。

## コミット / PR ガイドライン
- コミットは種別 + 要約（履歴参考）: `[feat]`/`[fix]`/`[docs]`/`[refactor]`/`[chore]`/`[test]`。
- PR 要件:
  - 変更概要と関連 Issue（例: `Closes #123`）
  - UI 変更はスクリーンショット/GIF
  - 事前確認: 解析・コード生成・テストを実行済み

## セキュリティ / 設定
- シークレットやキーはコミットしない。`firebase_options.dart` は自動生成。設定は Firebase Console で管理。
- CI と同一の FVM `3.32.0` を使用。
- モデル/ルート/Provider 変更後は必ず codegen と解析を再実行してからコミット。

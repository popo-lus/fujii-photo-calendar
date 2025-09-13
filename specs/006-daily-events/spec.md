# 006: 記念日 × 生成AI（販促短文生成）仕様

## 目的 / スコープ
- 指定日（mmdd）に紐づく「記念日」を外部APIから取得し、Gemini で面白い販促向け短文（1行）を生成する。
- 本仕様はドメイン層〜データ層まで（Service / Repository / UseCase / Provider）。UI/VM/テストの実装は別タスク。
- 非スコープ:
  - UI 組み込み、画面/状態管理
  - 永続キャッシュ（今回はインメモリの短期キャッシュのみ任意）

## 利用API / 留意事項
- 記念日API: whatistoday
  - ベース: `https://api.whatistoday.cyou/`
  - 本仕様の既定: `v3/anniv/{mmdd}` を使用（例とレスポンス仕様に一致）
    - 例: `/v3/anniv/0909` → `{ anniv1, anniv2, ..., anniv5 }`
  - 依頼文に `v2` 記載もあるため、将来差異があれば Service でバージョン切替を吸収（デフォルト v3、オプションで v2）。
- 生成AI: Gemini（Google Generative AI）
  - パッケージ: `google_generative_ai`
  - API Key は flutter_dotenv で秘匿（`app/.env`）。

## レイヤ構成（既存アーキテクチャ準拠）
- Domain: Entity / Repository IF / UseCase
- Data: Service（外部API/Geminiラッパー）/ Mapper / Repository 実装
- Providers: Riverpod（`@Riverpod` で codegen）。各クラス定義直下に Provider を定義。
- Presentation: なし（本チケットでは対象外）

## 追加する主な型
- Domain/Entities
  - `DailyAnniversariesEntity { mmdd: String, items: List<String> }`
  - `PromoCopyEntity { text: String, source: String /* 'gemini'|'fallback' */ }`
- Domain/Repositories（IF）
  - `AnnivRepository`
    - `Future<Result<DailyAnniversariesEntity>> fetchAnniv({ required String mmdd })`
  - `PromoCopyRepository`
    - `Future<Result<PromoCopyEntity>> generatePromo({ required String mmdd, required List<String> anniversaries })`
- Domain/Usecases
  - `GenerateAnnivPromoUsecase`
    - 入力: `DateTime date`（内部で `mmdd` へ）
    - 手順: AnnivRepository で記念日取得 → PromoCopyRepository（Gemini）で短文生成 → `Result<PromoCopyEntity>` 返却

- Data/Services
  - `AnnivApiService`（HTTP クライアント）
    - `Future<DailyAnniversariesEntity> getAnnivV3(String mmdd)`
    - オプション: `getAnnivV2(String mmdd)`（必要時）
  - `GeminiService`（Gemini モデル呼び出し）
    - `Future<String> generatePromo({ required String mmdd, required List<String> anniversaries })`

- Data/Mappers
  - `anniv_mappers.dart`（JSON → `DailyAnniversariesEntity`）

- Data/Repositories（Impl）
  - `AnnivRepositoryImpl`（AnnivApiService + Mapper）
  - `PromoCopyRepositoryImpl`（GeminiService）

- Providers（Riverpod）
  - 各 Service/Repository/UseCase の直下に `@Riverpod(keepAlive: true)` または `@Riverpod()` を定義
  - `geminiApiKeyProvider` は `@Riverpod(keepAlive: true)` とし、`dotenv.env['GEMINI_API_KEY'] ?? ''` を返却

## 依存・設定（pubspec / プラットフォーム）
- 依存追加（`app/pubspec.yaml`）
  - `http`（または `dio`。本仕様では `http` を想定）
  - `google_generative_ai`
  - `flutter_dotenv`
- シークレット管理（flutter_dotenv 採用）
  - `app/.env` に `GEMINI_API_KEY=...` を記載（`app/.gitignore` へ `.env` を追加）
  - `main()` の先頭で `await dotenv.load(fileName: '.env');` を実行
  - CI では Secrets から `.env` を生成して配置（ビルド前に echo 等で書き出し）

## エラーハンドリング方針
- Repository/UseCase は `Result<T>` を返却（成功: `Success<T>` / 失敗: `Failure<T>`）
- 記念日APIエラー時
  - `Failure` を返す。必要に応じて UseCase 側でシンプルなフォールバック文（API 失敗を明示しない一般文）を生成可
- Geminiエラー時
  - 記念日取得が成功していれば、UseCase でフォールバック短文を組み立て `Success(PromoCopyEntity(source:'fallback'))` を返す

## 生成プロンプト（下書き）
- 目的: 日本語で、記念日を活用した「販促向けの面白い短文」を1行で。
- 制約: 40〜60文字程度、句読点最小、露骨な勧誘・誇大表現を避ける、必要なら絵文字1つまで。
- テンプレート（Gemini 入力）:
```
あなたは日本の小売向けコピーライターです。以下の記念日から1つ以上を活用して、
短い販促コピーを1つだけ日本語で作ってください。40〜60文字、絵文字は最多1つ、
誇大・不正確な断定は避け、誰でも楽しめる表現にしてください。

日付: {{mmdd}}
候補: {{anniversaries_csv}}
出力は1行のみ。説明・接頭辞・記号は不要。
```

## 実装詳細（ファイル設計）
- Domain
  - `app/lib/domain/entities/daily_anniversaries_entity.dart`
  - `app/lib/domain/entities/promo_copy_entity.dart`
  - `app/lib/domain/repositories/anniv_repository.dart`
  - `app/lib/domain/repositories/promo_copy_repository.dart`
  - `app/lib/domain/usecases/generate_anniv_promo_usecase.dart`
- Data
  - `app/lib/data/services/anniv_api_service.dart`
  - `app/lib/data/services/gemini_service.dart`
  - `app/lib/data/mappers/anniv_mappers.dart`
  - `app/lib/data/repositories/anniv_repository_impl.dart`
  - `app/lib/data/repositories/promo_copy_repository_impl.dart`
- Providers
  - 各 Service/Repository/UseCase ファイルのクラス直下に `@Riverpod` Provider を定義
  - 追加: `app/lib/providers/ai_providers.dart`（`geminiApiKeyProvider` のみ定義）

## API I/F 仕様（Anniv）
- リクエスト
  - GET `/v3/anniv/{mmdd}`（例: `/v3/anniv/0909`）
- レスポンス（例）
```
{
  "id": 980,
  "mmdd": "0909",
  "anniv1": "救急の日",
  "anniv2": "温泉の日",
  "anniv3": "チョロQの日",
  "anniv4": "九九の日",
  "anniv5": "ポップコーンの日"
}
```
- Mapper で `anniv1..anniv5` を `items: List<String>` に詰め替え、空/欠損は除外。
- v2 との差異がある場合は Service 内で分岐実装（`baseVersion: 'v3'|'v2'`）。

## 呼び出し例（擬似コード / UseCase推奨）
```dart
final usecase = ref.read(generateAnnivPromoUsecaseProvider);
final res = await usecase.call(date: DateTime(2025, 9, 9));
final text = res.fold(
  onSuccess: (p) => p.text,
  onFailure: (e, st) => '今日はちょっと特別。小さなご褒美をどうぞ。',
);
```

## 実装手順（チェックリスト）
1) 依存追加: `http`, `google_generative_ai`, `flutter_dotenv` → `fvm flutter pub get`
2) `app/.env` を作成し `GEMINI_API_KEY=` を設定、`app/.gitignore` に `.env` を追記
3) `main()` で `dotenv.load()` を呼ぶ
4) Providers: `geminiApiKeyProvider` を追加（dotenv 経由でキー取得）
5) Domain: Entities / Repository IF / UseCase を追加（Result型準拠、UseCaseは`@Riverpod`）
6) Data: Services / Mapper / Repository Impl を追加（Service/Repository は各クラス直下で `@Riverpod` 定義）
7) フォールバック文ロジックを UseCase に実装
8) codegen: `fvm dart run build_runner build --delete-conflicting-outputs`
9) 解析・整形: `../scripts/format.sh`

## 注意事項
- レート制限やエラー時は指数バックオフ（最小実装: 1回リトライ or フォールバック）
- Gemini の温度・最大トークン等は `GeminiService` 側でデフォルト設定を保持（例: `temperature: 0.9`）。
- セキュリティ: API Key はログ/例外に出力しない。CI でも `--dart-define` で注入。
- 文字数上限は要件に応じて調整可能。初期は 40〜60 文字。

### コード例（dotenv 初期化 / Provider）
```dart
// main.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const App());
}

// app/lib/providers/ai_providers.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'ai_providers.g.dart';
@Riverpod(keepAlive: true)
String geminiApiKey(Ref ref) => dotenv.env['GEMINI_API_KEY'] ?? '';
```

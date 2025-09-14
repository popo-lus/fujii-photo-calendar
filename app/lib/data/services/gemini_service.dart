import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fujii_photo_calendar/providers/ai_providers.dart';

part 'gemini_service.g.dart';

class GeminiService {
  GeminiService({required String apiKey, String model = 'gemini-1.5-flash'})
    : _model = GenerativeModel(
        model: model,
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.9,
          maxOutputTokens: 100,
        ),
      );

  final GenerativeModel _model;

  Future<String> generatePromo({
    required String mmdd,
    required List<String> anniversaries,
  }) async {
    final csv = anniversaries.join(', ');
    final prompt =
        'あなたは写真コンシェルジュです。以下の記念日から1つ以上を活用して、\n'
        '今日撮ると楽しい「写真テーマ」を1つだけ、日本語で1行の短い誘い文として作成してください。\n'
        '40〜60文字、絵文字は最多1つ、誇大・不正確な断定は避け、誰でも実践しやすい内容にしてください。\n\n'
        '日付: $mmdd\n候補: $csv\n出力は1行のみ。説明や接頭辞は不要。可能なら冒頭に記念日名を含めてください。';
    final res = await _model.generateContent([Content.text(prompt)]);
    final text = res.text?.trim();
    if (text == null || text.isEmpty) {
      throw Exception('Empty response from Gemini');
    }
    return _sanitizeOneLine(text);
  }

  String _sanitizeOneLine(String input) =>
      input.replaceAll(RegExp(r'\s+'), ' ').trim();
}

@Riverpod(keepAlive: true)
GeminiService geminiService(Ref ref) {
  final key = ref.watch(geminiApiKeyProvider);
  return GeminiService(apiKey: key);
}

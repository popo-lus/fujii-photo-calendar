import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_providers.g.dart';

@Riverpod(keepAlive: true)
String geminiApiKey(Ref ref) => dotenv.env['GEMINI_API_KEY'] ?? '';


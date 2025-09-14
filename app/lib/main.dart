import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fujii_photo_calendar/presentation/router/app_router.dart';
import 'package:fujii_photo_calendar/core/logger/logger.dart';
import 'package:fujii_photo_calendar/core/utils/perf_timer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load local secrets (e.g., GEMINI_API_KEY)
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // optional: ignore if missing in dev
  }
  final initTimer = PerfTimer('firebase_init');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final initMs = initTimer.stop();

  // Debugモードでは Firebase Emulators を使用、Release では本番接続
  const useEmulators = kDebugMode;
  if (useEmulators) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
      // (T002) Auth emulator 接続
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      // (T002) 接続ログの明示出力
      AppLogger.instance.log(
        'emulator_setup',
        data: {
          'host': 'localhost',
          'firestorePort': 8080,
          'storagePort': 9199,
          'authPort': 9099,
        },
      );
    } catch (e) {
      debugPrint('Emulator setup skipped/already connected: $e');
    }
  }

  AppLogger.instance.logStartup(
    useEmulators: useEmulators,
    firebaseInitMs: initMs,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final _router = AppRouter();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  StreamSubscription<Uri?>? _sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _handleInitialLink();
    _sub = uriLinkStream.listen(
      (Uri? uri) {
        if (uri == null) return;
        _handleInviteUri(uri);
      },
      onError: (Object e) {
        debugPrint('deeplink error: $e');
      },
    );
  }

  Future<void> _handleInitialLink() async {
    try {
      final initial = await getInitialUri();
      if (initial != null) {
        _handleInviteUri(initial);
      }
    } catch (e) {
      debugPrint('initial link error: $e');
    }
  }

  void _handleInviteUri(Uri uri) {
    // 期待する形式: fujii://invite/{CODE} または https://fujii.photo/invite/{CODE}
    String? code;

    // カスタムスキーム: fujii://invite/{CODE}
    if (uri.scheme == 'fujii' && uri.host == 'invite') {
      if (uri.pathSegments.isNotEmpty && uri.pathSegments.first.isNotEmpty) {
        code = uri.pathSegments.first;
      }
    }

    // HTTPS: https://fujii.photo/invite/{CODE}
    if (code == null && (uri.scheme == 'https' || uri.scheme == 'http')) {
      if (uri.host == 'fujii.photo') {
        final segs = uri.pathSegments;
        if (segs.length >= 2 && segs[0] == 'invite' && segs[1].isNotEmpty) {
          code = segs[1];
        }
      }
    }

    if (code == null || code.isEmpty) return;
    // 既存の招待コード入力機能を使う

    // 失敗時は InviteCodePage に遷移し、コードを引き継いで再試行導線を提示
    MyApp._router.push(InviteCodeRoute(initialCode: code, autoSubmit: true));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Fujii Photo Calendar',
    theme: _buildTheme(Brightness.light),
    darkTheme: _buildTheme(Brightness.dark),
    themeMode: ThemeMode.system,
    routerConfig: MyApp._router.config(),
  );

  ThemeData _buildTheme(Brightness brightness) {
    // 画像の藍色をベースにしたカラーパレット
    const primary = Color(0xFF0C1756); // 濃い藍
    const secondary = Color(0xFF6E7EB7); // 補助の青
    const accent = Color(0xFF2F3E9E); // 強調

    final base = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      textTheme: GoogleFonts.notoSansJpTextTheme(),
      fontFamily: GoogleFonts.notoSansJp().fontFamily,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: primary,
            brightness: brightness,
          ).copyWith(
            primary: primary,
            secondary: secondary,
            surfaceTint: Colors.transparent,
          ),
    );

    return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: Colors.transparent,
        foregroundColor: brightness == Brightness.dark ? Colors.white : primary,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accent, width: 1.6),
        ),
        filled: true,
        fillColor: brightness == Brightness.dark
            ? Colors.white.withOpacity(0.06)
            : Colors.white,
        labelStyle: TextStyle(
          color: brightness == Brightness.dark
              ? Colors.white.withOpacity(0.9)
              : const Color(0xFF1C1C1C),
        ),
      ),
      cardTheme: base.cardTheme.copyWith(
        color: brightness == Brightness.dark
            ? const Color(0xFF111318)
            : Colors.white,
      ),
      snackBarTheme: base.snackBarTheme.copyWith(
        behavior: SnackBarBehavior.floating,
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF0C1756)
            : const Color(0xFF0C1756),
        contentTextStyle: base.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
      ),
    );
  }
}
